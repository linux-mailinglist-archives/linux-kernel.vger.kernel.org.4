Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6F686F60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjBATzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBATze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE825399E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675281283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4O+OE90XnoUkDMuD0O0m1OCqKGNb1pVnn32lSIj0pE=;
        b=ZROZ1QXKFmTcBb8Fq9oneHlBUAute/et4bcYrV6Na/2Ds8XIapUdEULNSxyE0kpw+GCPnz
        pR9EAFxhnUO8ItoHMailrkew+ReEWc00FwtYrG5hI634p+cTEvcxPb1XY/Q4JA+pvACwbQ
        Zi5qwzw89RYgXibWlb2HCgoGn68kJmU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-MGZmIaXNP2KcGwYPV7MHlQ-1; Wed, 01 Feb 2023 14:54:41 -0500
X-MC-Unique: MGZmIaXNP2KcGwYPV7MHlQ-1
Received: by mail-qt1-f199.google.com with SMTP id cr22-20020a05622a429600b003b694a9f291so8827978qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4O+OE90XnoUkDMuD0O0m1OCqKGNb1pVnn32lSIj0pE=;
        b=zu+YuKKj3qZ577S5y+UowUUtEUG0YSdCwd60jd1ul9FeawHQztYxInQLmphiVAEy/3
         Dowo6z76YjhnJevRmFTT3rOU+mJwEHRO8l1Gx+RyAxJNvECEE+osxs3ANs+HEpZ5Vhb7
         eSskxbLUPmhsIGSrpkNorLUrxQLd8iThBy4lTWv0pCoY5nCnhXz6UZuBLLTJrjOwrPtv
         EM9XRLHkHuh+wflVu+7+5RID+91fj2vstggE0KmyA55knx3Z3KRUG2NMvETUJnocDfe8
         LTmjOdf2iMCHNGdM9ks0sLJjLIDsLnRCbuvTA6COQrdCISu/XInxVoZGsv30dbqCLHQ8
         VvtA==
X-Gm-Message-State: AO0yUKXWSjnaGlqpW9XR0/NeSjSpQBD/xeT8Y5un3bOuiaTtqed3r3rz
        zs/LSDtpCh14ElXUGwXrm/M9KYKM61FZU63Ubw5axQxvlfu6TJVniom3BwRwF7K5onOj1BrfwXu
        msy+ekoJjg+XJbFOZjdNhbxWq
X-Received: by 2002:a05:622a:54c:b0:3b8:3629:7cb7 with SMTP id m12-20020a05622a054c00b003b836297cb7mr5720677qtx.64.1675281281513;
        Wed, 01 Feb 2023 11:54:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9Q+M5qIrbxp3xH54KEIWotWIlba2l/wzI+xUL6SESK0mYeTEsH+N4VPERX8EXbE9R4srp8Hg==
X-Received: by 2002:a05:622a:54c:b0:3b8:3629:7cb7 with SMTP id m12-20020a05622a054c00b003b836297cb7mr5720643qtx.64.1675281281222;
        Wed, 01 Feb 2023 11:54:41 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 77-20020a370650000000b0071c2a68d6f2sm8746441qkg.20.2023.02.01.11.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 11:54:40 -0800 (PST)
Subject: Re: [PATCH] Documentation/llvm: add Chimera Linux, Google and Meta
 datacenters
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Kolesa <q66@chimera-linux.org>,
        Chris Mason <clm@meta.com>
References: <20230201192509.4124319-1-ndesaulniers@google.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <28a46c56-e971-bee0-37d6-e442d15aa431@redhat.com>
Date:   Wed, 1 Feb 2023 11:54:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230201192509.4124319-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/23 11:25 AM, Nick Desaulniers wrote:
> Chimera Linux is a Linux distribution from 2021 that builds its kernels
> with Clang.
>
> Google transitioned its data center fleet to run Clang built kernels in
> 2021, and Meta did so as well in 2022.  Meta talked about this at LPC
> 2022 at a talk titled Kernel Live Patching at Scale.
>
> These were important milestones for building the kernel with Clang.
> Making note of them helps improve confidence in the project.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Cc: Daniel Kolesa <q66@chimera-linux.org>
> Cc: Chris Mason <clm@meta.com>
> ---
>   Documentation/kbuild/llvm.rst | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index 6b2bac8e9ce0..6a37ab903e45 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -15,12 +15,15 @@ such as GCC and binutils. Ongoing work has allowed for `Clang
>   <https://clang.llvm.org/>`_ and `LLVM <https://llvm.org/>`_ utilities to be
>   used as viable substitutes. Distributions such as `Android
>   <https://www.android.com/>`_, `ChromeOS
> -<https://www.chromium.org/chromium-os>`_, and `OpenMandriva
> -<https://www.openmandriva.org/>`_ use Clang built kernels.  `LLVM is a
> -collection of toolchain components implemented in terms of C++ objects
> -<https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM that
> -supports C and the GNU C extensions required by the kernel, and is pronounced
> -"klang," not "see-lang."
> +https://www.chromium.org/chromium-os>`_, `OpenMandriva
> +<https://www.openmandriva.org/>`_, and `Chimera Linux
> +<https://chimera-linux.org/>`_ use Clang built kernels. Google's and Meta's
> +datacenter fleets also run kernels built with Clang.
> +
> +`LLVM is a collection of toolchain components implemented in terms of C++
> +objects <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM
> +that supports C and the GNU C extensions required by the kernel, and is
> +pronounced "klang," not "see-lang."

:) yes it is klang.

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>   
>   Clang
>   -----

