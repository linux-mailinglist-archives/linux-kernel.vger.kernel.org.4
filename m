Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F6619F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKDRpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiKDRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE514AF28
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667583838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQmR1/jR3UTmYTEzmSRhCPtSx0fylOy6bnRZe0N+9wM=;
        b=gTKDyMdlZl3TV0c4sXekeI6rLGpy9Tu/+IWUOK3ExtGtxsRP/f1m5ciWliT5scF2U2Qn/E
        hiRAfJSh3ak/eLtnhMqyVMgmlUTn0LtosWb52hTkF7ps7jGVAck2z29JiQX78UWcTHh0th
        yCXin4ClFkDBx88GbmC8IttIGnHH0+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-3D_7pPKmN0ita4_O56cLXQ-1; Fri, 04 Nov 2022 13:43:57 -0400
X-MC-Unique: 3D_7pPKmN0ita4_O56cLXQ-1
Received: by mail-wm1-f72.google.com with SMTP id z15-20020a1c4c0f000000b003cf6f80007cso1995107wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQmR1/jR3UTmYTEzmSRhCPtSx0fylOy6bnRZe0N+9wM=;
        b=KnN4LUvTq3Pt2LBcHbokcjeYvAT1SI7nDuKRdiUwYtFke3O865+WFK7enrUSaxZAiO
         cKdmfiGVVWPydTqL9JecMlzi1mo2KsKNhOKBMMtpNotcr0bpA1s7oAyNgVN77WzwbfCo
         K6r0yTbo3D88rlLqvW6k4UnUBZZxlUFOWDeWa+MuwYQqiO7UjCu6tatlFb8PdspXju7j
         w+rUEX7tH32eauCez4eCzSyKKbJk0/tn762sBPSo8LuNJdqDrqVXZKV6fvItCBuHsRfi
         Jp8iYl7pfaEhwk4JvWwid5XfFT9Ov1hyzrm6zjdOH7xIdEut4bB5URPh+yG8mLQp6nZo
         HpDA==
X-Gm-Message-State: ACrzQf1L2sY7T5hw01Uz5SmA8o1i3Cyc5kVW/q9bCNR9rdLxuO9Vz4qN
        ozidHQrLeR2O5XQ9enpNZVYq9TPbO/KP3VO1xEb4lhz9qB8Bp5yntrx93WNL+26GLbuuEPGmqoF
        LgR9ClocgMqENEnJomWFdhjlj
X-Received: by 2002:adf:cd05:0:b0:236:7a11:b061 with SMTP id w5-20020adfcd05000000b002367a11b061mr284946wrm.292.1667583835886;
        Fri, 04 Nov 2022 10:43:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4IpWBNLDaPnqdZ4Rj31ZB9VRNlAJ0E6Uf1KYyBWy0J6qrsoesGyWNrhiyCPZ9nsYpOVm0TWw==
X-Received: by 2002:adf:cd05:0:b0:236:7a11:b061 with SMTP id w5-20020adfcd05000000b002367a11b061mr284935wrm.292.1667583835634;
        Fri, 04 Nov 2022 10:43:55 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id t6-20020adfe106000000b00231ed902a4esm3977777wrz.5.2022.11.04.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:43:54 -0700 (PDT)
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
Subject: Re: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
In-Reply-To: <20221019225939.1646349-1-yury.norov@gmail.com>
References: <20221019225939.1646349-1-yury.norov@gmail.com>
Date:   Fri, 04 Nov 2022 17:43:53 +0000
Message-ID: <xhsmhtu3evcme.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 15:59, Yury Norov wrote:
> In current form, FORCE_NR_CPUS is visible to all users building their
> kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> which is not a correct behavior.
>
> The 'choice' and unused config UNFORCE_NR_CPUS are used to ensure that
> auto-generated configs that try to enable as much options as possible,
> like allmodconfig, don't enable FORCE_NR_CPUS.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
> v2: extend commit message with an explanation for what we need 'choice'.
>
>  lib/Kconfig | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 9bbf8a4b2108..1ada12f5dda6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -528,14 +528,31 @@ config CPUMASK_OFFSTACK
>         them on the stack.  This is a bit more expensive, but avoids
>         stack overflow.
>
> +choice
> +	prompt "Number of CPUs detection method"
> +	default UNFORCE_NR_CPUS
> +	depends on SMP && EXPERT

What about moving the 'depends on EXPERT' onto FORCE_NR_CPUS? I find it
makes it easier to figure out the requirements for that option, and is
similar to how e.g. CONFIG_PREEMPT_RT is handled.

> +	help
> +	  Select between boot-time and compile-time detection of number
> +	  of CPUs. If it's possible to provide exact number of CPUs at
> +	  compile-time, kernel code may be optimized better.
> +	  For general-purpose kernel, choose "boot time" option.
> +
> +config UNFORCE_NR_CPUS
> +	bool "Set number of CPUs at boot time"
> +	help
> +	  Choose it if you build general-purpose kernel and want to rely
> +	  on kernel to detect actual number of CPUs.
> +
>  config FORCE_NR_CPUS
> -       bool "NR_CPUS is set to an actual number of CPUs"
> -       depends on SMP
> -       help
> -         Say Yes if you have NR_CPUS set to an actual number of possible
> -         CPUs in your system, not to a default value. This forces the core
> -         code to rely on compile-time value and optimize kernel routines
> -         better.
> +	bool "Set number of CPUs at compile time"
> +	help
> +	  Choose it if NR_CPUS corresponds to an actual number of
> +	  possible CPUs in your system. This forces the core code
> +	  to rely on compile-time value and optimize kernel routines
> +	  better.
> +
> +endchoice
>
>  config CPU_RMAP
>       bool
> --
> 2.34.1

