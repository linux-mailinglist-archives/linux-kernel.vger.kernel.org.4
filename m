Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321047106B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbjEYHtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbjEYHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:49:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111111BF
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:49:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b9755961so2040003e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685000970; x=1687592970;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=V1XvSVODDEA3TsNr4/6rD8fONkRZXOKHxfaQzrvBuWE=;
        b=Rb//MjVriA87cNvKfaQfy3k9aTXfLTkqIAAMtLnZJCSLwvy103u/pNn02HRykZaUUX
         1vsVPWhDqU+OqtlMaTmprHYMgDKPpfCWb49z0qLWfQH45DLgWjAORZw3oExhyKG1IHSI
         J4fXuhJ8dMvB8XOb1vj/I6nA1/TKUznn+jJgljKwgqIUQLmIgBOCFrrgRiCVQwJ4digD
         b7vxocdF8bhn3v9RlkTFXzfH0YUs2UwotoGSt/gWnNoblBQfExdUtRP6J2BqCTLKf9+Z
         B5zPjKK+Mpt7ur40CI3YTFTWHXU9rIDR9C+hGWSfoUJKIjtUIV9NT7yndiav3lObKCV5
         xEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685000970; x=1687592970;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1XvSVODDEA3TsNr4/6rD8fONkRZXOKHxfaQzrvBuWE=;
        b=SrFnDh0d+ruduZmLpDxCuTv1GXAUNtRw39dktaeky/X+cQ1pWmI0WalOJZVmEGZzd4
         xUef++MpJodqZXeUf1fxnuaJSdOJjAk1ZnKohAE6hRSLil++y9S5Tysy1hYNC0VEPgFT
         E9T+tPf+LMrPyQDBfiar40TzBFUtjFPxm6C3Hpibg1WFa22XVIMbqQhHFstcmlpVlU4N
         sXp8SAuuUvWLvlYffTjLNEiQVWvnUjUe0T4vM4DRrGRa0Wd3d4XafMD+F1opV5TOxLoC
         CaYM/IpYyXl94KesOGHz2dbFJqKhYDnUpFvIQiN+eiHZmnYZCBwzY6EQTOjcnHp5yuws
         JHAw==
X-Gm-Message-State: AC+VfDxvpwyiWGGm97uKhS+pL35IhLvHlczaAr8LaLIYZBKW2BxbNeng
        UgXsEuhKn/fC5jgNNESMYOm1/A==
X-Google-Smtp-Source: ACHHUZ4kdZAHbddsr82/JU+BYvNmlUQoxgJp+jPn0fQ2cDA6MucbPgKmHAJbM5tZHMio1jw9kM0xoQ==
X-Received: by 2002:a05:6512:21a6:b0:4ef:f3bf:93a6 with SMTP id c6-20020a05651221a600b004eff3bf93a6mr6505557lft.51.1685000970268;
        Thu, 25 May 2023 00:49:30 -0700 (PDT)
Received: from localhost (77.241.128.147.mobile.3.dk. [77.241.128.147])
        by smtp.gmail.com with ESMTPSA id t17-20020ac25491000000b004f3b6e71eb1sm108281lfk.291.2023.05.25.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:49:29 -0700 (PDT)
References: <87edn6do1b.fsf@metaspace.dk>
 <20230524111127.2491643-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
Date:   Thu, 25 May 2023 09:45:29 +0200
In-reply-to: <20230524111127.2491643-1-aliceryhl@google.com>
Message-ID: <87a5xsetq5.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>> Alice Ryhl <aliceryhl@google.com> writes:
>>> +        // This preserves the metadata in the pointer, if any.
>>> +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);
>> 
>> I can't follow this. How does this work? `ptr` was for field
>> `inner.data: T`, but we are casting to `ArcInner<T>`.
>> 
>>> +        let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
>>> +        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
>> 
>> Metadata was obtained from a pointer pointing to `inner.data`, we then
>> move it back to beginning of `ArcInner<T>` and then reconstruct the
>> potentially fat pointer with metadata from the pointer to `T`? How can
>> this be right?
>
> The metadata of a struct is always the metadata of its last field, so
> both `*mut T` and `*mut ArcInner<T>` have the same metadata. Because of
> that, moving the metadata over from one type to the other is ok.
>
> The reason that I cast to an `ArcInner<T>` pointer before calling
> `metadata` is because I get a type mismatch otherwise for the metadata,
> since the compiler doesn't unify the metadata types when the type is
> generic.

OK, cool. In that case, since this is common knowledge (is it?),
could you maybe include a link to the relevant documentation, or a
comment indicating why this is OK?

BR Andreas
