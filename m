Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0F5E94C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIYRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiIYRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:17:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951BD2A958;
        Sun, 25 Sep 2022 10:17:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c7so4625951pgt.11;
        Sun, 25 Sep 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=IVJfwU6yPU7cNazzlbsgGk5tc0qT7f7Ej9MIrbUEG1Q=;
        b=mGoffBUSwfrrAL/9xyeH1BkqCfQogdgEsLkAIsxWTEdhMosjpnFQbJD8KDp5atkSDb
         kGTe7z68m9Fv/Otq7AgPoh/RYgC5xdNwbtAMm6/ch16BzCU0tyaxTDniqhTvupNie+DX
         0P3gmZIYBbk0UW87gvGapenAWSRidksSyyc10QHKRFAA6oaiXanXK33HcrovsFCKRbm+
         BTn+NtFEv6aHl271GhION5Y60tjpCohQD9xJLA+/MANDA7csNryYzMFjd4VFpYwKRbZ/
         w+sxRHVY+NhIKmoA4jej8OxrScDi3fNT+ksdJOI11V0BTtkvchSzakJ/XuOiU3OXU2kS
         bEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IVJfwU6yPU7cNazzlbsgGk5tc0qT7f7Ej9MIrbUEG1Q=;
        b=okY1ccKTbutmO9+4bHWOQD9/tFWdU2LgylvJJc8ALk33lPNL45mt4FkSQhjhPtqvvp
         vzciUbPhzrTnIBBsEJB8UIWiC23IXYFhu8K7KN9Hu02CLMVjPDmPov+ipFREWs5aoqSG
         NpwBYsogp1towttlIlmgNc08cG4HoXSXMlo8mGKLFQzpW490T3qr94XH9xh7sXtHZ8yn
         7azODfu+8ZIAwrqk4yFG6+o6jM2oGw5fQoMuu6DToImXaO0Pew0hEnMAhT4diK16M3B9
         Tw3YHpQdrPwhv5JP5a4MvOsAdCXPHlrNkoWi6wLCRertlSTTUffq/CZ9wOdy3yT846Gb
         IKdg==
X-Gm-Message-State: ACrzQf37a1GPqDiIVAyTQi+2DWwHO2kPL6zHPGGyXKbfkcV8SII03D6F
        iHy7+CirgSzv+s3iZ+gYq5EbTUgwOW4vgw==
X-Google-Smtp-Source: AMsMyM4eDPOAPnOYnnvOFCgDuIeWwE2oAVUH9KswHpHUQ/nDVjGsVS9mj0DM1qXELHdzCLdwY+eQVA==
X-Received: by 2002:a63:ea43:0:b0:438:c056:3dc4 with SMTP id l3-20020a63ea43000000b00438c0563dc4mr16205595pgk.480.1664126278170;
        Sun, 25 Sep 2022 10:17:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a631e52000000b004393f60db36sm9229784pgm.32.2022.09.25.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:17:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:17:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] watchdog: rti-wdt:using the
 pm_runtime_resume_and_get  to simplify the code
Message-ID: <20220925171756.GA1762786@roeck-us.net>
References: <20220802074643.1648660-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802074643.1648660-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:46:43AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rti_wdt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 053ef3bde12d..6e9253761fc1 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -225,9 +225,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		wdt->freq = wdt->freq * 9 / 10;
>  
>  	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
>  		pm_runtime_disable(&pdev->dev);
>  		return dev_err_probe(dev, ret, "runtime pm failed\n");
>  	}
