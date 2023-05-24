Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2470F4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEXLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:19:18 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221CA3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:19:17 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-94a34e35f57so74517266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684927155; x=1687519155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqeOEBaEovgqBOkQYpmiRbcLkCrvNP3WDOQXeuFBws=;
        b=YoTFNVu3BuXhD7O32uXMB2r5DmhBVaFcVMJtr/toOkSxoubHnULS6xAfeW2LnVMAlA
         AYEz2fGtxM3pIYSUnBK97NJj/BDHWhtjg5xXo1E0oD7tUbhsEX3CXPVlILQkcaRPv0ZD
         yjgEMiuiRLnKN6CsU3p9hbhjzB/iYU4uM2KkitkPUbglYVCC8SJ0awVM+Jd6nWLQuc/G
         ndgHixe0rgEmKz+2d++PnHjmKN8G+3JZbxp5NfqtrsOioY71sLNZHgs1D1AtBEUVenMn
         e3E2RvzhRBeZ9qYmqs3ZsfOY5VINcozwl6tDQaiEl1bE2crSn7TsrUNBfRLuLVdhuSpT
         1BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684927155; x=1687519155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqeOEBaEovgqBOkQYpmiRbcLkCrvNP3WDOQXeuFBws=;
        b=Nk9Au4FSbpll4fs6hcG0jMbBd58nR/EoT7Gr7/xK6tqhZciK0EqQSfUpevyM1F+F2Y
         pSrfIZQSN8TdLzUVzNzUluwWaAKsc2Txyu4iKVPi7jqNnzSzrNE5hf082GgXgWcC2EBO
         RrhgMTO/rb7RDnxUAYm4bTvwiEGkzI1Z9cHPumEBw1HXXJRvWVxarzfyDFfldNgQQve9
         f5yKnmA01MP7Oig6cjUU6BMb85S4c+izyBPmbF0K92I57m7/ziw6CBt9KhnmNzdwbTMv
         XLIb3IdaH05ZfY7yG6lSrMe07vEqp+vBBQiXYgq7Y3HujMrbIbtdqQ5wVNf44yWOnPd8
         zJjQ==
X-Gm-Message-State: AC+VfDxbdsEdD6keiZ4zEkp4O2rNVh5nM/stel/llvREo80OVs1PaB23
        E+H2Gv39FhbSAZzScWoLpSSX6bANpkswxFo=
X-Google-Smtp-Source: ACHHUZ6hBDSsE8W54k3/04J7zLascPTlRf9I3nXEziDRNwk18BCOFdKa7mvtqXoJNKmy27weSOFwZUV7ytfiAEg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:5a67:b0:96f:5864:eb6c with SMTP
 id my39-20020a1709065a6700b0096f5864eb6cmr6435514ejc.6.1684927155703; Wed, 24
 May 2023 04:19:15 -0700 (PDT)
Date:   Wed, 24 May 2023 11:19:13 +0000
In-Reply-To: <20230523164333.2c4b0d85.gary@garyguo.net>
Mime-Version: 1.0
References: <20230523164333.2c4b0d85.gary@garyguo.net>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524111913.2492665-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     gary@garyguo.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Guo <gary@garyguo.net> writes:
> On Wed, 17 May 2023 20:31:15 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>> +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
>> +    ///
>> +    /// This code relies on the `repr(C)` layout of structs as described in
>> +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
>> +    /// can only be called once for each previous call to [`Arc::into_raw`].
>> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
>> +        // SAFETY: The safety requirement ensures that the pointer is valid.
>> +        let val_align = core::mem::align_of_val(unsafe { &*ptr });
>> +        let refcount_size = core::mem::size_of::<Opaque<bindings::refcount_t>>();
>> +
>> +        // Use the `repr(C)` algorithm to compute the offset of `data` in `ArcInner`.
>> +        //
>> +        // Pseudo-code for the `#[repr(C)]` algorithm can be found here:
>> +        // <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>
>> +        let mut val_offset = refcount_size;
>> +        let val_misalign = val_offset % val_align;
>> +        if val_misalign > 0 {
>> +            val_offset += val_align - val_misalign;
>> +        }
> 
> Given the layout of the whole ArcInner can be calculated as
> 
> 	Layout::new::<bindings::refcount_t>().extend(Layout::for_value(&*ptr)).unwrap_unchecked().0.pad_to_align()
> 
> The offset of `data` could be more intuitively calculated by
> 
> 	Layout::new::<bindings::refcount_t>().extend(Layout::for_value(&*ptr)).unwrap_unchecked().1
> 
> or
> 
> 	Layout::new::<bindings::refcount_t>().align_to(val_align).unwrap_unchecked().pad_to_align().size()

I'm not a big fan of the `pad_to_align` version (which is also what
the rust branch uses), but I like the version you posted with
`extend`, and I agree that it is clear and intuitive. I will use that
in the next version of the patchset. Thanks for the suggestion.

Alice
