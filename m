Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519A750165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGLI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:25:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316E1BFA;
        Wed, 12 Jul 2023 01:20:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so10626243e87.3;
        Wed, 12 Jul 2023 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689150050; x=1691742050;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Stm2+briN7xTHjyU1YYMiw0ahBy2NrW0BYxEeVzHaDk=;
        b=feG9mMNPxVH2E1hZYUaeSzFYUPfTzCgAfJQTdrm/iWAC/FRfKwwsii5R3IGUhDbwgx
         bc3cgKrNPPquwMrXL5Ixcbanxjo6hnnneTcSurxDT+rVWwhbaO6QXMkTu2Nrckm5BCa7
         yR0A6kDOv89asIAau6ARtVReRSfO9ZRJjdvYlcL5gSyR7HSyDCuUO4XY6QLGCrHLUdlj
         jSpYdIZZSx/3cD8xlHZ0h6eZ8lp2ZTkK1/lwmwTibHeuS8kQYABYp8jU28YcWgZ1NBSz
         jMMdjB3kSSMfdqWz5P1IF5vjoZjawglCahR2YSyQ4X7MNnhhWgygXMogP8PFDf15F4n3
         eHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150050; x=1691742050;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Stm2+briN7xTHjyU1YYMiw0ahBy2NrW0BYxEeVzHaDk=;
        b=SernVOh4abjz3kN6XFbeoZqhF2PYZxtKZDQ3FaaVYmFSb0tWhyFGBuEvVnnwAPzaW8
         mt9XiBEjuPFZP4KoIzrTiKrPB0mi3zhXZOChvI4OJ5tTr9Le+Y4xYLXciTkJzM7TH1UX
         4o9q3fwII5fwFrYc+B7Z9xfArQwqN4EkiW+DNH0IbfVqfsEeQDuZzZoLKoP5PllTpTfH
         cQG4ehfs3VaOsqqQuKuBH4f6sV9C8xnHNUg1i1ZffnmAgwMrXQu1GghiHGxjg9PCLt4w
         Ai9VvaacZvBaA33fCSraLNNIOzQahsGvsaVwBc362IOTzVYnIvRZSEOVVuJtJIL3rtUy
         njsA==
X-Gm-Message-State: ABy/qLaEZKORDFxY2TyqKhTWYB8nzCyEPoird/YmPKE6CZn/bcYvEHaH
        Yd426dyHBWZsdOryWKWLU5wrfnNvj9s=
X-Google-Smtp-Source: APBJJlHz4hYlxCwgr1mnFSAkZqZCx64MZvnbcWfrr2bR7jLPqI0yB4T6F1AhFbmI6sIrFbRLZQFG1Q==
X-Received: by 2002:ac2:4e07:0:b0:4f8:5e49:c613 with SMTP id e7-20020ac24e07000000b004f85e49c613mr17263551lfr.43.1689150049426;
        Wed, 12 Jul 2023 01:20:49 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.82.245])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004fbdf1c85b5sm614017lfi.116.2023.07.12.01.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:20:48 -0700 (PDT)
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
To:     David Laight <David.Laight@ACULAB.COM>,
        'John Paul Adrian Glaubitz' <glaubitz@physik.fu-berlin.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
 <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
 <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
 <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c9483d7f-7f5f-dd29-2bba-5659a1dae7e0@gmail.com>
Date:   Wed, 12 Jul 2023 11:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 11:12 AM, David Laight wrote:

>> Sent: 09 July 2023 00:13
> ....
>> Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
>> on and maybe that's the part where we need to correct the offset by 16?
> 
> Would it be less problematic to use (say) 16 for IRQ_0
> leaving IRQ_1+ as 1+ ?

   I don't think so.

> At least that would only cause issues for code that needed
> to use IRQ_0.
> 
> (It has to be said that making IRQ 0 invalid seemed wrong
> to me. x86 (IBM PC) gets away with it because IRQ 0 is
> always assigned to platform specific hardware.)

   Not only x86, IIRC.
   Have you seen the commit below?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289

   IOW, try arguing with Linus. :-)

> 	David

MBR, Sergey
