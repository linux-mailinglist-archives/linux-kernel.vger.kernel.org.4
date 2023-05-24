Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCE70F4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjEXLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEXLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:11:33 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0FAC5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:11:31 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-50de84a3861so865903a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684926690; x=1687518690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mh/uplWXEJG8R+eeG89iIATTJ5tXDpqPwH0/Cpz+94=;
        b=Ealvqf6m5eTtrTJw51t/UJcXmkP4y9/lCnZH/rfLC2p1LCmw5L2podZOi9x4uyfp42
         8BpGUAGcvSr0zooJbm/yd+HMtz9kh6YAJBttV5LW1foF3EEDwcfuUH3MDfcTqjtTWwrL
         cwEdXAixIuP1wKTZnHMAobXmu+IjqV1ZJyo+JgCgctPEtbFTvfDWnxKN2tqKhvw8tDrn
         o1RYy1vGzVcxOpH8pwVnpRjAo5boR7L7fvzosXftH8G+3aRDeftjnvZ7h4vW0xNCfRMd
         M+VSr+3qH7pw3z17P0nY/78Vbb3ODNQ8MsOH6O3UnwVtRV83T4Wl4/+urGCkxQzRwGrs
         sWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684926690; x=1687518690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mh/uplWXEJG8R+eeG89iIATTJ5tXDpqPwH0/Cpz+94=;
        b=efLm9wm4G6XBj7cxgwwiCeSJyoOwJIGd3Ql9Vqw1zaO3kU4CLox1nC2hRcUt0FuVZ4
         PV8dNFMGyxCsN94U8E2Fg/VQJoY9Xfjh5XXv1/42Yyymug4s9lXGQ2Ijp8cEL5WTVUYk
         dLKuGy8APSOY2b6CbqrtqTa3FjzeXBGN8SXfT0ccnrvVQNgRblWfxR5UUqdT04iGU2ZC
         23Vsa6ugQL9f9gLDGit3JtKo6NgXrf/FEKHUeC+3qC4/79XaBt0TuAKxR9QeoBPBKmi5
         lwLmRM4aAn0lk/zGXVdAlAQtVRok7RodxR/Ckv5DEc72lSE91XODqQIis7bBJ0jWi4si
         eBnw==
X-Gm-Message-State: AC+VfDzY6scPlnmhsTIeE7ffiRq0sPm576MNQPpmyh+qQzSpTeVjjeZd
        7Br508IwBtdJlzRlGd2I/8SpTGX67Tbi5no=
X-Google-Smtp-Source: ACHHUZ5+4OdHMonxT5AAGoSedUaFjM79+wW2g2Tg0tZikEMfewz+SKNu6+lWkRHbxOW7yIJB/AFDxLBZhC6BAz0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:c34a:0:b0:504:89cf:8170 with SMTP id
 q10-20020a50c34a000000b0050489cf8170mr758066edb.4.1684926689900; Wed, 24 May
 2023 04:11:29 -0700 (PDT)
Date:   Wed, 24 May 2023 11:11:27 +0000
In-Reply-To: <87edn6do1b.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87edn6do1b.fsf@metaspace.dk>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524111127.2491643-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
> Alice Ryhl <aliceryhl@google.com> writes:
>> +        // This preserves the metadata in the pointer, if any.
>> +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);
> 
> I can't follow this. How does this work? `ptr` was for field
> `inner.data: T`, but we are casting to `ArcInner<T>`.
> 
>> +        let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
>> +        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
> 
> Metadata was obtained from a pointer pointing to `inner.data`, we then
> move it back to beginning of `ArcInner<T>` and then reconstruct the
> potentially fat pointer with metadata from the pointer to `T`? How can
> this be right?

The metadata of a struct is always the metadata of its last field, so
both `*mut T` and `*mut ArcInner<T>` have the same metadata. Because of
that, moving the metadata over from one type to the other is ok.

The reason that I cast to an `ArcInner<T>` pointer before calling
`metadata` is because I get a type mismatch otherwise for the metadata,
since the compiler doesn't unify the metadata types when the type is
generic.

Alice
