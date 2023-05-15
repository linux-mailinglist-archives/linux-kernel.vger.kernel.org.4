Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB04703C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbjEOSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbjEOSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:12:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699041F329
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:10:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2427356866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684174162; x=1686766162;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmonrEr4WjNysQoQ1LLwqU/RtcUbfFNLN3JcLmX+2Vw=;
        b=N5uK4Rw1dAlrxwugTedYBk3M57qUMUBdF+8n4U7MPPM0L4RynTMTFQLRGN93J9kYPd
         kiU8MzbSz+iS8H645FC4vKFetClKBouuHaufmIQ+PsMLQBsuLwBJkxxBhmMGc77LWoyV
         LHeGzdo6gRIH/EhTzLBo1RhjLxgVvGqEaBq5cXdsjHQt7Woe8pXXrXb/1VVSXz4v0soI
         Z8C2YOMMHMtiBaaVeyMH4Dx5ovMv9IJ0ZPhTMn7frPUocv2N43aD0Hp3qkkpy0kvQS9P
         VOckrsW/QVMasDiMmZoEk3CU8u8DuOAEE4g5su43zHfWrg2KlSwkZNwvaCQ4Jj8yhDD8
         Rydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684174162; x=1686766162;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xmonrEr4WjNysQoQ1LLwqU/RtcUbfFNLN3JcLmX+2Vw=;
        b=GFIRpcDXlca9lzqXKLkX2UPm9qKP9SDv52FmQve7NQdJgzmHt1lxuptf0qVYiDZaGw
         r98EqP/8/Eoyf5QNbzPCMscI2BEM3xZf9AzMepu3HRqb4n2S7DDJjYFY3Fh1vnv3Rqta
         YQECTPIVSHhSejlV2Hm/m1qenFh1njfSfTWyFiu27wrLwaH8imaEtrApiPHokbikL3HN
         61QLxDWaSFmmmYMBRXjk/3xq/Q5JGaL+XX8V2t1Rni4o4WZyPZZ4u6xGV7duutTPXgSf
         /CTKo7jzlBk1v+S1ULlYuInWgHwhnaPOxzr7oAjXvTdLVchlj7fQc/cvzH8C9Z5T4QDT
         F3QQ==
X-Gm-Message-State: AC+VfDyuvq6CF5At5jdN0q1rJxCqPeSE1qbmrk062718LYszXp77csgl
        9o8X5Pmfkg+6ZX+o/EhCQFq/0Q==
X-Google-Smtp-Source: ACHHUZ76HaIUpf67gxgtS7EJZc1ON+7z1VLJeepcLysf2WuddzZ35bUQJSDvp61O08LMhuH4BsiomQ==
X-Received: by 2002:a17:907:7b9c:b0:966:7a0a:28c0 with SMTP id ne28-20020a1709077b9c00b009667a0a28c0mr26586892ejc.58.1684174162347;
        Mon, 15 May 2023 11:09:22 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7cd8d000000b0050488d1d376sm7204332edv.0.2023.05.15.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:09:22 -0700 (PDT)
References: <20230508124701.443ba331.gary@garyguo.net>
 <20230509080700.1608146-1-aliceryhl@google.com>
 <2023050937-scouring-truck-d7c0@gregkh>
 <CANiq72=g=CnEQTkc50qozUdOBZECr7Jr2NCRfGFaKh751i6Sww@mail.gmail.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alice Ryhl <aliceryhl@google.com>, gary@garyguo.net,
        alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: error: add missing error codes
Date:   Mon, 15 May 2023 20:07:12 +0200
In-reply-to: <CANiq72=g=CnEQTkc50qozUdOBZECr7Jr2NCRfGFaKh751i6Sww@mail.gmail.com>
Message-ID: <875y8teab3.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, May 9, 2023 at 10:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
>>
>> It depends on which arch you are building for.  That's why we have
>> per-platform errno.h files, the values are different for different ones.
>> So you need to handle them all properly somehow.  How is rust going to
>> handle per-arch stuff like this?
>
> We can do conditional compilation in the same file, possibly with a
> Rust macro which takes a nice table that shows all arches at once.
>
> We can also split into files like C and move it to each `arch/`, there
> are a couple of approaches for this. This is best for `MAINTAINERS`,
> although these headers almost never change, so it is not a big
> advantage.
>
> We could also automatically do everything based on the C headers, too.
> Back then it felt to me like too much complexity for little gain,
> given those C headers almost never change, but now it may be worth it.
> Or, instead, having a test that verifies they are the same instead,
> and that way we don't introduce complexity for the build itself.
>
> Alice only needs `ERESTARTSYS` so far, as far as I understand, so
> perhaps it is simplest to only add the rest of the non-generic ones
> for the moment; and gather opinions on the approaches above meanwhile.

Let's add the ones we need for now. When we need target specific error
codes we can have a `mod` for each arch, gate behind the target
feature and conditionally reexport them.

BR Andreas

