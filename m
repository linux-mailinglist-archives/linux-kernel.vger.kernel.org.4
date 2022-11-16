Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503762C7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiKPSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiKPSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EE60EAC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668624152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBZ39WNjycPf4R6M83kSnl6Dtr1v471N2pU+M0ytGIU=;
        b=NW1L31MMiFfjWa2P104LRm6AGNoIN9nqEjJivM4x+7L3yQbXlFodE8pcMITOK9TI83BHqL
        MpTOkxSDkRPs4wshlFl0LIte84/64QBGw1LaWVLuwwGJDgtEoDCqsNDA/1D//II940fdpe
        y7GCiOaBpmNez/qj2C1Cfhr13iiGkbg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-1BP7D7YNMiKqtqcVopQjhQ-1; Wed, 16 Nov 2022 13:42:31 -0500
X-MC-Unique: 1BP7D7YNMiKqtqcVopQjhQ-1
Received: by mail-qk1-f200.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso18291901qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBZ39WNjycPf4R6M83kSnl6Dtr1v471N2pU+M0ytGIU=;
        b=4Q/RfKdIqeWj3y/ru51I5B9vifeyz2gJS0vgD9JD+TqJvtOK5cxgrjKTIomA7Rz8xC
         g/OSftZ6/wGv3pE6CqcTiPkmQku7wNX5AjIJnMy5SNYxTpfQ52nAnaN+V9N18GbLG3j9
         RYTcMGpl9VAbFAMCi2K+qgkAyWWrFJwsFDi1WMrDuCHAe2o/KQtbaWBwAjTfSjR9gQDZ
         H6pk+D9WV/B79zaj4FSg25PeqcEuazFJDGFUI6j87GWev3Vxo3NZP2ffAWEtKtqzUmex
         fCk7KkMUNXmX1ZPF0YZWWCbmbUlAugEUGSY/DXFz4eXg7PKWP6k7bUpdu/LiR/tZbhdZ
         Z+yw==
X-Gm-Message-State: ANoB5pmZxQGPAdd6IlfrWbmTUoSvC3GayXgRQaZcCDsKwROjIKQDulHd
        MxpczkJc1z4PVqJF6l1Ddi4GFML/g+qCTUt9pj7L0LJ51ouW8FAoGWaByyf1w7OlUJ31fPADAUl
        ILY29xD7B9DE8RAEm5pHbkM5L
X-Received: by 2002:a05:620a:1091:b0:6fa:faac:926d with SMTP id g17-20020a05620a109100b006fafaac926dmr20644246qkk.33.1668624150761;
        Wed, 16 Nov 2022 10:42:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf74h3OlNFfa4y4vca5+glxCb7Xmv3G53GcklHC7K/2QU+PPM7VPRcXlMA2kXHR3p+zgzGIZKA==
X-Received: by 2002:a05:620a:1091:b0:6fa:faac:926d with SMTP id g17-20020a05620a109100b006fafaac926dmr20644228qkk.33.1668624150555;
        Wed, 16 Nov 2022 10:42:30 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id k21-20020ac84795000000b003a569a0afcasm8981146qtq.66.2022.11.16.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:42:30 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3] cpumask: limit visibility of FORCE_NR_CPUS
In-Reply-To: <20221116172451.274938-1-yury.norov@gmail.com>
References: <20221116172451.274938-1-yury.norov@gmail.com>
Date:   Wed, 16 Nov 2022 18:42:25 +0000
Message-ID: <xhsmhr0y2yc4u.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/22 09:24, Yury Norov wrote:
> In current form, FORCE_NR_CPUS is visible to all users building their
> kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> which is not a correct behavior.
>
> This patch fixes it. It also changes the parameter short description:
> removes implementation details and highlights the effect of the change.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
> v3: instead of 'choice', use !COMPILE_TEST to disable FORCE_NR_CPUS
>     in all{yes,mod}config, as suggested by Linus.
>  lib/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 9bbf8a4b2108..404647cd3fac 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -529,8 +529,8 @@ config CPUMASK_OFFSTACK
>         stack overflow.
>
>  config FORCE_NR_CPUS
> -       bool "NR_CPUS is set to an actual number of CPUs"
> -       depends on SMP
> +       bool "Set number of CPUs at compile time"
> +       depends on SMP && EXPERT && !COMPILE_TEST
>         help
>           Say Yes if you have NR_CPUS set to an actual number of possible
>           CPUs in your system, not to a default value. This forces the core
> --
> 2.34.1

