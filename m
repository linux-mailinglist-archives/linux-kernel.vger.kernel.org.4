Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6487449F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGAOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:40:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCC35B3;
        Sat,  1 Jul 2023 07:40:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7ef3e74edso14541555ad.0;
        Sat, 01 Jul 2023 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688222430; x=1690814430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyUkD0mJUU/Zf9ldB9gHD2S/2d4V8ANSTIaihttQl0A=;
        b=IcDsm+rZ3hWCxWysGUBDBD5VD+zraq6+jUeIaKn/hFtcy9Dgr5iufxyQz/ygOH39mE
         dKiGEbAwOz8eJHxxFR55WRU7m202fAw12RiTvxzs5RHo6nbhnTtdSl9vjLQDwuPpFr/z
         TvqWtGPj6ulYtEAoYGwMzX2zyPasm2e1wbpEnozvkdR6lQUJ35w0J1Jy+siGUmFf5UjH
         cyNBZHheeVh8SCGH/hLqLeKWYGlmlyi9zqpcgdb7nIIezPoxwuP697JcW0aUKS6/EOTW
         Q8u1XdaYb+ICRxwdlNWbA5XSaRkEE1dnWAZEsbucaG8pYUT7P2RSzJAMx5thpCWC2gsn
         w6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688222430; x=1690814430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyUkD0mJUU/Zf9ldB9gHD2S/2d4V8ANSTIaihttQl0A=;
        b=Dwfa4vS5bwhszpWcehLGWzNrDOU2SuuwhftLNa6b+ZgMGTvEgXTmZK9KYUShYPYkBT
         2Ycv77pRsuTGK/eNaDKGro+BypCutH9mLjsqtUawmH1w7oKzEYOH7lEzsh9DeOSRs8Ho
         nyMkxMsF672nQAM/85oL97rwlL2n6rVlxPMx19bzkVRm2au21fKscrfmDZzQ6IXvS+6v
         fDViTm1tIQkjuUI8ky/Dzt2wV+ulqRF8/WnUegRNPWUmgmwH7/TM84pZrZvqHORWfmjB
         ne3vZ+J49/u2jLRiHqo6T+Hr2Cyeczgq/hssgBjulq39XPvFvlAawEeSApWDpJu1YSzM
         RFpA==
X-Gm-Message-State: ABy/qLbxblR9j4A7Hop/HIHaoyQjQflz9Wx3msXxNszK/WLCACMvFJRw
        x6lrtGY65HV05XAMRmTF6Pc=
X-Google-Smtp-Source: APBJJlEqX62QMvHa1JAPHGFp7Jlctzos+OPSmcIe4d+nG9szuHOt9QyZ+r1VUb70YbR27S9Oc5PE2w==
X-Received: by 2002:a17:90a:e60f:b0:262:e742:f40a with SMTP id j15-20020a17090ae60f00b00262e742f40amr3306132pjy.44.1688222430467;
        Sat, 01 Jul 2023 07:40:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b001a69c1c78e7sm12361682plh.71.2023.07.01.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:40:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 1 Jul 2023 07:40:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define
 HARDLOCKUP_DETECTOR_ARCH
Message-ID: <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
References: <20230616150618.6073-1-pmladek@suse.com>
 <20230616150618.6073-7-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616150618.6073-7-pmladek@suse.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 05:06:18PM +0200, Petr Mladek wrote:
> The HAVE_ prefix means that the code could be enabled. Add another
> variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> It will be set when it should be built. It will make it compatible
> with the other hardlockup detectors.
> 
> The change allows to clean up dependencies of PPC_WATCHDOG
> and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> 
> As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> on arm, x86, powerpc architectures.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
...
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -9,7 +9,7 @@
>  #include <asm/irq.h>
>  
>  /* Arch specific watchdogs might need to share extra watchdog-related APIs. */
> -#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)

This results in:

arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_partition':
arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declaration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watchdog_hardlockup_stop'? [-Werror=implicit-function-declaration]
  753 |                 watchdog_hardlockup_set_timeout_pct(factor);

with ppc64_defconfig -CONFIG_HARDLOCKUP_DETECTOR, because the dummy 
for watchdog_hardlockup_set_timeout_pct() is still defined in
arch/powerpc/include/asm/nmi.h which is no longer included.

Guenter

>  #include <asm/nmi.h>
>  #endif
>  
