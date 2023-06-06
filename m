Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32AB7250D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjFFXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjFFXh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:37:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2621711;
        Tue,  6 Jun 2023 16:37:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75ec7e8e826so175384985a.0;
        Tue, 06 Jun 2023 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686094677; x=1688686677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFhBhTIzREHG9mACtwO9tRyPWU+4u6gN6/PkdzEJpag=;
        b=d77x79NsgBLTq06/VgrnLBA18mMJknfbUXrr8BhhI2XbWKK0dzqJBz6jeI7vB0upeP
         sKwQNSh6Ps6CqjjxsGRgsfbkakooZs+V8GFZeNf+gQZoXksuHxbOAMllHpf3iHEl2IO/
         v8CqEY99D46jjyyS/1VWxIVoy6EW71uRClKKED/q7v/oQW6RYgbvP5hSfO+QbCqKArzU
         z0T7B4ArSaaqShjjCTPYTH/MNa07lYUkmSqhytjrsm1nCkwcuyH/u5Wd09149+JvnF94
         iRrkB4GTqzmhX4P1k8KifMiD2Cg8sGLoaL3sUdX97vzG/IgtSCwGB0ZNa/MklTZaLICg
         EbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686094677; x=1688686677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFhBhTIzREHG9mACtwO9tRyPWU+4u6gN6/PkdzEJpag=;
        b=EMe1Ugxs6QW16M6h26wUYQDRDR1JeHNUV7zodTo3TMcm3kjXJ3AOhH+4M7JS2vV4wL
         Ank3qqZJo8IQ9uthBQyGJ+3gqtfo/LHv6iWRvWYuhxssPiFr5gvHZxP+SS3uZ1dWas+J
         W09aKDCdAi6W5S+u0kigRRC4Y9TVfMHkE3HO9jb8Rw3tZJwDDcYCFEa5eEpT0q+gFnS2
         UUFmE/AbsTG8N990AZMS9yxBjOMs7qdnXbeylTFApGa7N5q2ZG05JYbU0RlJqY75ZWvT
         Xk62M++B+0MX9XbZcfrL0JEDBF8CUhiH9YyBNwdGgEW8UJIHdmFQs+RjQQv88RzZc2TN
         YDlw==
X-Gm-Message-State: AC+VfDzdfK4foN5H+lq+VeSejWM4/ySxB+hzKKid1c/jurp8f27vTfq8
        qouGbR9k4CdStBxyd1mY8pI=
X-Google-Smtp-Source: ACHHUZ4+Dpgv5vgO099EF2l/tWaCHrZtfxBMs8Ph0KvZ2JA0RvuUAModS84I6+1h0Uk6bj4bZOxRHA==
X-Received: by 2002:a05:620a:2221:b0:75b:23a1:367f with SMTP id n1-20020a05620a222100b0075b23a1367fmr137834qkh.64.1686094677149;
        Tue, 06 Jun 2023 16:37:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9f20a000000b0075772c756e0sm5237129qkg.101.2023.06.06.16.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 16:37:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1970A27C0054;
        Tue,  6 Jun 2023 19:37:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 19:37:56 -0400
X-ME-Sender: <xms:UsN_ZOcGJeHlqVPcJvE7x1Nfow7WPPDeV70cAPzLSJVggrWyCqNiQw>
    <xme:UsN_ZIOW4RetvFzgJmrpv6MUBSuQb81jbuQDRftBmsSZ-Ixv8xmJwOheHizp_aCOY
    Df6PaxGdTDpCox5MA>
X-ME-Received: <xmr:UsN_ZPgfayrHRKXbEeFo3F_nHGlmrc1sg6w-Cq0CnoVfePCX48CM2h18i-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:U8N_ZL_Y2Bu1QhknI37Sc89lkMnsHJDg6FOT76JiExlmhVXbwLK6Lg>
    <xmx:U8N_ZKunZ1wEKQWhC3mFMoj0og0QMPI8OPKMXQAtDEmcZ1BtTFunLA>
    <xmx:U8N_ZCGiUNXTHW5t_sLxfosfgwnO4sarjcrSrQj_AP-_Dr6v1tGP6Q>
    <xmx:U8N_ZCF_R-BE9s0l0uTdkE3kMErg8abKaM9wpC6fB4X27XiBFvPbMA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 19:37:54 -0400 (EDT)
Date:   Tue, 6 Jun 2023 16:36:30 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] rust: workqueue: add low-level workqueue bindings
Message-ID: <ZH/C/lKeYxM7tbYA@boqun-archlinux>
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-2-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601134946.3887870-2-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:49:39PM +0000, Alice Ryhl wrote:
[...]
> +/// A raw work item.
> +///
> +/// This is the low-level trait that is designed for being as general as possible.
> +///
> +/// The `ID` parameter to this trait exists so that a single type can provide multiple
> +/// implementations of this trait. For example, if a struct has multiple `work_struct` fields, then
> +/// you will implement this trait once for each field, using a different id for each field. The
> +/// actual value of the id is not important as long as you use different ids for different fields
> +/// of the same struct. (Fields of different structs need not use different ids.)
> +///
> +/// Note that the id is used only to select the right method to call during compilation. It wont be
> +/// part of the final executable.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by `__enqueue`
> +/// remain valid for the duration specified in the documentation for `__enqueue`.

^ better to say "the #Guarantees section in the documentation for
`__enqueue`"?

Regards,
Boqun

> +pub unsafe trait RawWorkItem<const ID: u64> {
> +    /// The return type of [`Queue::enqueue`].
> +    type EnqueueOutput;
> +
> +    /// Enqueues this work item on a queue using the provided `queue_work_on` method.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// If this method calls the provided closure, then the raw pointer is guaranteed to point at a
> +    /// valid `work_struct` for the duration of the call to the closure. If the closure returns
> +    /// true, then it is further guaranteed that the pointer remains valid until someone calls the
> +    /// function pointer stored in the `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided closure may only return `false` if the `work_struct` is already in a workqueue.
> +    ///
> +    /// If the work item type is annotated with any lifetimes, then you must not call the function
> +    /// pointer after any such lifetime expires. (Never calling the function pointer is okay.)
> +    ///
> +    /// If the work item type is not [`Send`], then the function pointer must be called on the same
> +    /// thread as the call to `__enqueue`.
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool;
> +}
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 
