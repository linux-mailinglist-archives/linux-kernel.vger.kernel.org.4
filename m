Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F1726A01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFGTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjFGTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:42:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F71FE0;
        Wed,  7 Jun 2023 12:42:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d5469c856so407238085a.2;
        Wed, 07 Jun 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686166933; x=1688758933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oF4AC5xHgg8LwfnEbJTH2/uVZSgF0m82b8cRGQMkBc=;
        b=oWRkd82izCC3ALVh//TuRqme/kv6uihxU5NoL8EwK/jJsDDZvkqgKfzcQ4v9vgvdvu
         2+J7jPIoUfmsNDkCgD9SOtXFAwiXxlCtwxuj3ocMcYHoIsDa7rm0B06MNcPY1zdp22VH
         oXh3/fnqD18Yei+gJ6zokAJUkiiVYLl90hrs43Fir8vLSDW8pTFusQOWmMQHWM9gLXAe
         lLnlhLsjKCWHDMGUVV7dRtD+kcm8j6cZP9LrLcMa7ttTgEYW+MPUs5/g08a+eYZp7lAF
         AehFUKFdI+YrZ6sZdq+YRJVf7QxTvuck5ie0YXSGUU08jdzureZH3uETF0R4ppRmJioL
         82yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166933; x=1688758933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oF4AC5xHgg8LwfnEbJTH2/uVZSgF0m82b8cRGQMkBc=;
        b=RtbhgsrB0sEsjvDv8WnTMkozfgJFUfkNheEhTDIp3Bqb2tl94qKKiH1g7LbuGLElwC
         DF5zC98BosmFYeV/4+Yt3GTl05NcOO4MUWXr1Yry3pVv9UkcJpDvS6iJQIhJwvGh+1HS
         HhME1WQYdmLgsUwuRLgCfWQ2JAz8hKMvz2WKSjVD7a7D/2gImQtwOBLsUpQBtxzmRf3a
         9vqz0M0c8vYjLScVlxgUAs255DbyICk/Qi8CP1yDhxJEry0hz34A2tlAPF+nhBWLhxRL
         SIPMobxesdQPiplGGE9dkTP1S1khQ7IuVoSUcPte5OSY8f4YuXBawgIqb0snG047hBY2
         qBvw==
X-Gm-Message-State: AC+VfDw4ijQdw6QeI7X29Lo1OOq7odGoUTzVFY408kyR/Ad4wZjFlbxJ
        qEw/UgkwdJ9U8QAAcUuAy74=
X-Google-Smtp-Source: ACHHUZ7g3ol6PzklOObpWHT/OFybWPGQBPGjbDvawlPrtKF37dXBJl30jomnYhGwHR754us4Nh4BdA==
X-Received: by 2002:a05:620a:8a01:b0:75b:23a1:3670 with SMTP id qt1-20020a05620a8a0100b0075b23a13670mr2692621qkn.49.1686166933309;
        Wed, 07 Jun 2023 12:42:13 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a158700b0075cc804ee88sm144730qkk.30.2023.06.07.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:42:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 27F2427C0054;
        Wed,  7 Jun 2023 15:42:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Jun 2023 15:42:12 -0400
X-ME-Sender: <xms:k92AZDMoZk6mL2FjP4hhUBscoS6Yktqc7W0zw5XIsvDxo4aSA2fOQA>
    <xme:k92AZN8Ll7oDmjZnSJsX0m3__byYQwuu70FurmuC265qlxHUNu2ZtOXViCDp351Q4
    UXcONUHDpb2YajQzw>
X-ME-Received: <xmr:k92AZCTA7nFuOwUhkVlESkbtMHgYlHjbIal2WqIeFCjMeMP9bw9jhL2C2gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdt
    keeihedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:k92AZHuTW6Gqm73R-yfMjhTWCBHLNj2a-SOTWMgJ2_OMoTV_W8ZsEg>
    <xmx:k92AZLcRJtZvxla5iZ44WhdUwtUIIIN7AdfvY6UcsizGWe4-z8fy2A>
    <xmx:k92AZD2RuukR6LlyaEJ8T4ek7dVh36LxHsZXvhZcg96POImGHNfSUw>
    <xmx:k92AZJ3U-NVFXgOFSLhyNDJAuRyFH919Y9zvlET2WVkDPv0a8JO2zQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 15:42:10 -0400 (EDT)
Date:   Wed, 7 Jun 2023 12:40:43 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
Message-ID: <ZIDdO7SPvZh8fD7z@boqun-archlinux>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
 <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
 <20230607194210.380d195f.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607194210.380d195f.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:42:10PM +0100, Gary Guo wrote:
> On Mon, 5 Jun 2023 08:26:04 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Fri, Jun 02, 2023 at 06:18:17PM +0800, Qingsong Chen wrote:
> > [...]
> > > +impl<'a> ScatterList<'a> {
> > > +    /// Construct a new initializer.
> > > +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
> > > +        // SAFETY: `slot` is valid while the closure is called, the memory
> > > +        // buffer is pinned and valid.
> > > +        unsafe {
> > > +            init::pin_init_from_closure(move |slot: *mut Self| {
> > > +                (*slot).set_buf(buf);
> > > +                (*slot).mark_end();  
> > 
> > Benno can provide more information, but you cannot dereference or create
> > a reference to `*slot`, since `slot` points to an uninitialized object
> > (see `try_pin_init` implementations), and referencing uninitialized
> > objects is UB (or may cause UB).
> 
> This is fine for `Self`, because the only non-ZST field in there is
> `Opaque`, which can be uninitialised.
> 

OK, but if you do a

	// this is OK
	let slot_ref = unsafe { &(*slot) };

	// reads uninitialised data.
	let o = slot_ref.offset();

here (before any `set_buf()` or `mark_end()`), isn't it an UB?

Regards,
Boqun

> > 
> > Note that you could do the following for `set_buf`:
> > 
> > 	// `addr_of!`[1] is special since it won't create references
> > 	// (even temporary onces).
> > 	let opaque = addr_of!((*slot).opaque); // <- *const Opaque<bindings::scatterlist>
> > 
> > 	let ptr = Opaque::raw_get(opaque); // <- *mut bindings::scatterlist
> > 
> > 	// Maybe this can be wrapped as a Rust function with a
> > 	// parameter: *mut bindings::scatterlist.
> > 	unsafe {
> > 		bindings::sg_set_buf(ptr, buf.as_ptr(), buf.len());
> > 	}
> > 
> > [1]: https://doc.rust-lang.org/core/ptr/macro.addr_of.html
> > 
> > Regards,
> > Boqun
> > 
> > > +                Ok(())
> > > +            })
> > > +        }
> > > +    }
> > > +  
> > [...]
> 
