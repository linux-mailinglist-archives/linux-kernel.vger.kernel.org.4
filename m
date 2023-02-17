Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7A69A736
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBQInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:43:08 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A4298EC;
        Fri, 17 Feb 2023 00:43:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi36so591704lfb.6;
        Fri, 17 Feb 2023 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvlfKQyT4/yiRm0UBTgKuh4h9yI1+vauMqU7ek9YADE=;
        b=HvgtBGAcZZ+w5leSYQJ6ynfoCZIc2vrHNcyODIKLu3hBruVHyeF3zFt2P+vrk8G9dU
         sP8IW9reAOAtnuhwSy+UY6bgW3SwX9rb2a7aCz+Ef2ZzXkgNiz3Q5nE5aWpcZ1zl55+e
         E2fOVJtTr7zaXBhUm3IUJd24/6tGf/Xz926FT7XV1TaQJZbmMC4WaQ8dpgChfzR0T0w4
         xHlXBq19AeUEDGrGagmuYB5BjLZe8BmyNHoMydb11cmdywvqU47VviC82lqKF2r8qVjC
         SUL8XyQ1d8w0kLk1OQRqJ4OaIiMmdQIwPWdreGYhAfwdIQ7qy7fFXc1l2CucHXVAFImS
         iQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvlfKQyT4/yiRm0UBTgKuh4h9yI1+vauMqU7ek9YADE=;
        b=QzXEfXbGKpcytsDzdPaZ0vBThuTpfDzxmuQMoCkztC3ANFCUSrmPhZQld2JKVcQZCH
         KR+dfyj3aRw+2c7rqEhHoIClIzi8cppXHVfput8+mrTrRvJ21SaPAODpGIYmfJIRlEda
         T/LFXL4AOKWdbcBJWWaByDXyEPkNQw82K9AIcXVTjc47lCdCFYNVKDlkPCtJkkgmCmDz
         yEfZ0BynvXFZcAt+Ych4CBhTar/YNrzwlk9dkUbUpoPlxxG5lPbUCrYP3fEO0+rZ4tQx
         iY9EoKP8bfEUIIb90ft/eNyDG+yK9Cop5O/ByNsNdo11RZz72dsJQypBXsr1pjgjfC/P
         S5LQ==
X-Gm-Message-State: AO0yUKVl8F6jMcKHrDul6dFrXLeDT1Hu2XR4Jwwqtr7Nt6iKk4/o9O/3
        ApTwXhgKAhOSxiUsTzgOsOpaloX8F7Q=
X-Google-Smtp-Source: AK7set9eWO+FkyX4qsaCLqgPX67GJlmo64d7yQmXKdTsuncTXfsYoDvGTNhRuWR5z9ln/N/UUkUmNg==
X-Received: by 2002:ac2:4c1b:0:b0:4d8:6540:a72c with SMTP id t27-20020ac24c1b000000b004d86540a72cmr3609950lfq.46.1676623385503;
        Fri, 17 Feb 2023 00:43:05 -0800 (PST)
Received: from [192.168.1.103] ([31.173.86.21])
        by smtp.gmail.com with ESMTPSA id y4-20020ac24464000000b004cb14fa604csm609731lfl.262.2023.02.17.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:43:05 -0800 (PST)
Subject: Re: [RFC PATCH] MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not
 set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20230217063858.28311-1-rdunlap@infradead.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5e36b62c-9326-dc8b-3d7e-dfa79b75472b@gmail.com>
Date:   Fri, 17 Feb 2023 11:43:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230217063858.28311-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 9:38 AM, Randy Dunlap wrote:

> When MIPS_CPS=y, MIPS_CPS_PM is not set, HOTPLUG_CPU is not set, and
> KEXEC=y, cps_shutdown_this_cpu() attempts to call cps_pm_enter_state(),
> which is not built when MIPS_CPS_PM is not set.
> Conditionally execute the else branch based on CONFIG_HOTPLUG_CPU
> to remove the build error.
> This build failure is from a randconfig file.
> 
> mips-linux-ld: arch/mips/kernel/smp-cps.o: in function `$L162':
> smp-cps.c:(.text.cps_kexec_nonboot_cpu+0x31c): undefined reference to `cps_pm_enter_state'
> 
> Fixes: 1447864bee4c ("MIPS: kexec: CPS systems to halt nonboot CPUs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/kernel/smp-cps.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -- a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -424,9 +424,11 @@ static void cps_shutdown_this_cpu(enum c
>  			wmb();
>  		}
>  	} else {
> +#ifdef CONFIG_HOTPLUG_CPU

   Perhaps, instead of #ifdef'ery, ude the following:

	} else if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {

>  		pr_debug("Gating power to core %d\n", core);
>  		/* Power down the core */
>  		cps_pm_enter_state(CPS_PM_POWER_GATED);
> +#endif /* CONFIG_HOTPLUG_CPU */
>  	}
>  }
>  

MBR, Sergey
