Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADABA717B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjEaJIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjEaJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:08:09 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C28E4C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:08:02 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-514b05895f7so1409521a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685524080; x=1688116080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4XB69pI7oS1KTwJ1Q82+CkziVn4Zul+krCxNc20lxY=;
        b=hF5rhGXPOOd8eZdQQ3DNkBzapxJtKf68EiAo1a9IPWpXaz7OSTkyCGpwOoBmhtq444
         Edz0OVUOK2gCHE/qi5uSIDR+CfACSpofs3x7IPacH+5ka1Re4i5bYKMFCatM9wFkNQCR
         Kynv+nF73kgFpbzeZIT0fCY5WE7tXNEeMjTCQ2/oMNfLncKxNwr3tD+Rozz0gncc5H81
         L5MJaSrp0rJcoKjbIO4eQ5ZASfjN/sj5umJekwonfsGtrcZ+B7OpWx53w20tpFUp2C9L
         aWsG1eCu1roXKzUnkjDzPDLMcmI4nnBA7iBxTXLQ/oHhQvaExejAwggwLNG5S0tLKbJT
         o0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524080; x=1688116080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4XB69pI7oS1KTwJ1Q82+CkziVn4Zul+krCxNc20lxY=;
        b=DbDeQCuC7I0rLLCwdwiW0t31O997nswLrhSAguNcLepipiuAHHcJzQDTfFGEPo3zsf
         P6a229WWpNiyz7l8uvdSPCS9Q3C93X7uX6QYR9p/aFHFlUq+Al9gBHAQG5xTk3o1nUs4
         MkNI5KMptazaqBe+bnF18uGEGZ5r/ChNxC9EOnxBcl2Aa6LOSvXiiOLuRQsfTW2DgDcJ
         /WlPtOzjjLKuu+LSDQYKQSs6eT0NI6tT988uuK7rJQGADByJUiAyUO2eqG8DqcWsl2dg
         zStJLRO6752YyLTYbXvOjVt4dQJYTldSYanRXF/CTYnXR0iCPMoTiFWOULhRRv8dgpnu
         gXxg==
X-Gm-Message-State: AC+VfDyzT/9itfc13scoQ5+KehdYE4QRZxzNPFfNIU+GCOzqxsXMae23
        FUnAioqHpgxauruixqfARDHquE2tEX5ue74=
X-Google-Smtp-Source: ACHHUZ4jHWsOMdaL8fTbPxhKkMfcS5HXhNuYYha/28gUrN+9T6dw86HDPz24GnWXSS15B+jt4XcRCMsHnSQQxsk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:75c6:b0:96f:4226:56d with SMTP
 id jl6-20020a17090775c600b0096f4226056dmr1253514ejc.6.1685524080625; Wed, 31
 May 2023 02:08:00 -0700 (PDT)
Date:   Wed, 31 May 2023 09:07:58 +0000
In-Reply-To: <ZWC2OS5uiRNgHMBBzQqt4FZXnOBeHw5IK5D7CAqfNC-z6nfYVLS9jXgvP2cMFvIMtVG22OGlmRGR9RkUJ53lip-SPiEkTHEiBoxMoL-K_38=@proton.me>
Mime-Version: 1.0
References: <ZWC2OS5uiRNgHMBBzQqt4FZXnOBeHw5IK5D7CAqfNC-z6nfYVLS9jXgvP2cMFvIMtVG22OGlmRGR9RkUJ53lip-SPiEkTHEiBoxMoL-K_38=@proton.me>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531090758.3668499-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
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

Benno Lossin <benno.lossin@proton.me> writes:
> On Wednesday, May 17th, 2023 at 22:31, Alice Ryhl <aliceryhl@google.com> wrote:
>> +macro_rules! define_work_adapter_newtype {
>> +    (
>> +        $(#[$outer:meta])*
>> +        $pub:vis struct $name:ident(
>> +            $(#[$innermeta:meta])*
>> +            $fpub:vis Arc<$inner:ty> $(,)?
>> +        );
>> +        $($rest:tt)*
>> +    ) => {
>> +        $(#[$outer])*
>> +        $pub struct $name($(#[$innermeta])* $fpub $crate::sync::Arc<$inner>);
> 
> I am a bit confused as to why these types *contain* a pointer. Shouldn't
> these be exactly the same `Work<$inner>`, except they allow multiple `run`
> functions? So IMO they should embed a `Work<$inner>` and the
> manually defined `run` function would take a `$inner`.

No, that's not how this particular patch was designed. With the design I
used, the way you tell `enqueue` which `work_struct` field you want to
use is by using a different pointer type for each `work_struct` field.
This macro defines those pointer types.

So, for example, if you have only one `work_struct` field, then you just
use `Arc<MyStruct>` as your pointer type, and the field has type
`Work<Arc<MyStruct>>`.

On the other hand, if you have two `work_struct` fields, then you
instead use the macro to define `MyPointerType1` and `MyPoinerType2`
that both wrap an `Arc<MyStruct>`, and the fields then have types
`Work<MyPointerType1>` and `Work<MyPointerType2>`.

Alice
