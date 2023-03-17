Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937056BE624
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCQKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:01:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017A4E5CB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:01:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s8so5510985lfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112; t=1679047301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IULcPf2+7dUXnSWr6iZnijROMDOSV5jq63jdWgbmy2U=;
        b=f1HmXyXbOUwUP6bnI42e+hugNWSsvj/DDYL9h0o3VvirKuv5uLPBjdGmr0KXf+KoDO
         wki3tTzJV1eAsLV6n9DzdTBsLijTyondI0GueVoVy/4ku76epFHGq+SUgWiTWDmZi/bf
         iw5r6MPDABmM9f9vEBjFEHFl51tlJrsS46d5V+HiV5358Dvg2U2Qw6WpxvrBXCinpPLJ
         axOw4SdpF3eMJI0VzBYnCBk713rga3rRvnXsGy2AeklqTH2KMo4jEnp+kOGz/cKAHOpk
         JnSth4LaDyvD0+t7PXZl1ZDILBL4GP/NH97RFuo6N9RjjaPn7CCDsFKJMWm+r7YIVEHV
         /QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679047301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IULcPf2+7dUXnSWr6iZnijROMDOSV5jq63jdWgbmy2U=;
        b=dVGrhYqSd5ebXCZ+6YAKt6znPZATm7hQ5JFfQrUfrsuHTriN+3wkLNCQF7vLqi6H/s
         S5MIC7v7xm3cwyVnGBYPzixeZI0UJ6QRczp4fS8qAwOHqKExMkC6UB7PuyUvPau4JSrb
         MsMJ+7gz1KUMH4HaqG/weljxaq9m8ibr/Cq6nh4CVZepFVlhn9RXRmV/1hPpRZjaXR6A
         RFeukq4IR99Zx2h1fHTOg0kvObvx///vlnssZziHx7RGLv9PKR2BrCVJHwZ9vPJpa0JW
         cQh/02Ru2jSKLTPa7u7ihaxLlkOtNGbee2zsRgsnXb9x1PWI4oXhFi3RcwcRTmwEBTjq
         0tZA==
X-Gm-Message-State: AO0yUKWip/lTFEa80JO1RBJonavuW5Lr1PrOSaO6QUE1dNDQ+OOV9fIr
        6D1cruIGEiRU0R0npQkfXhdb5A==
X-Google-Smtp-Source: AK7set9a07Ek6cej+3Iq/soaUrRsFDaiYmA1FuVeu1wEL4haHCOYOPfeE2FA4Ia14DI6qKIv93iPLQ==
X-Received: by 2002:ac2:5618:0:b0:4df:9ce8:300 with SMTP id v24-20020ac25618000000b004df9ce80300mr4052919lfd.52.1679047301199;
        Fri, 17 Mar 2023 03:01:41 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id l28-20020ac24a9c000000b004e80038e2aasm293788lfp.191.2023.03.17.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:01:40 -0700 (PDT)
Date:   Fri, 17 Mar 2023 11:01:39 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: renesas: Add "renesas," file content pattern
Message-ID: <ZBQ6g1gxBD8vOpc1@oden.dyn.berto.se>
References: <c1be1e97c5457eade25b0eb5118196677cecfc08.1679039809.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1be1e97c5457eade25b0eb5118196677cecfc08.1679039809.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Neat!

On 2023-03-17 08:59:00 +0100, Geert Uytterhoeven wrote:
> Add a keyword match pattern for the word "renesas," in files to the
> ARM/RISC-V/RENESAS ARCHITECTURE section.  This make sure patches
> changing drivers that match against "renesas,<foo>" (as used mostly for
> Renesas on-SoC components) are CCed to the linux-renesas-soc mailing
> list.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> To be queued in renesas-devel for v6.4.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc343041495b7015..281c6da85a4bdf5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2655,6 +2655,7 @@ F:	arch/arm64/configs/renesas_defconfig
>  F:	arch/riscv/boot/dts/renesas/
>  F:	drivers/soc/renesas/
>  F:	include/linux/soc/renesas/
> +K:	\brenesas,
>  
>  ARM/RISCPC ARCHITECTURE
>  M:	Russell King <linux@armlinux.org.uk>
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
