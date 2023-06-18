Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44277346E1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFRPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:54:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964EB1;
        Sun, 18 Jun 2023 08:54:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b291d55f52so1912103a34.2;
        Sun, 18 Jun 2023 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687103697; x=1689695697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9vWNjtJCgOYE0tvi5Fu/c1AUdXqlTISD3uczbjGvzs=;
        b=CoIysCD1HM2TssfWHrOwMlh90AgP2v+1atKljpwamrXbuvPa+pR2xCvSf82eHXB4lu
         wNg2AzC8McRLVHZB70BE1H8D0QzpMLy0NwC12eNhu5TZpHakRl1eNmbdD9syqu6idRIh
         vee72Ovqkmh6BJdW0Ag5x4vlDbiyW0anYS/Imc7ORJJJq+/vyRvPei/wMSDF5vtu71Ul
         sQh9i4qSzNCDCgZ0thmlbEhyniZxTSdgN8gh5pl5OVu+ADGCYKNJ8T/ST2WzV3N/phld
         2iCJIhyvKdoelcsFJBy4D9Ordkyhg6YPOef7l05zdcM5RXYOmF6Xk0uR1STkdmuRCJ6z
         B8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687103697; x=1689695697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9vWNjtJCgOYE0tvi5Fu/c1AUdXqlTISD3uczbjGvzs=;
        b=fSFMXGlwxMiPonglUtM1ez9x5j5oHw37pQWorL0SviS0s2Fs1agE+i6zjt0gA3PoZn
         3sm7TYyIeEOv76/HyFb10k060zzNZrdi11EZ/Tiv/puYZ+OCA0HC15tj3jD6mq6dNtsb
         qef77cg4OecaTirx8U1EjH4rVg1HcCerJIacw2WBMo4/uMU1myJFJJ60l5SnBxniromw
         MP+39SehXdET+GIFkOz2ii3QUkEYHrcen9FmTP50yC5i4cnctLzKhLvOKs0xB2vvJ9Oo
         dPdwUPNAyM8UEyhAJ2/zOKkkt6y1AZO4NiZqew1O22SefbzVMMl3dcjYN2+7bMrJP+pX
         TOLg==
X-Gm-Message-State: AC+VfDzxmwzS9KzF4D2rR39C9NyoKB11fDc63WKbAaRpY6MAIXnAagEE
        Gp1mHKpa85J+yCaj6bwFnvEK6MnOcBs=
X-Google-Smtp-Source: ACHHUZ471e4AtCyrzgxu6sCf49OreiuhV2fCgC1fcfHHWCih4U0WCoQZdQUDsT+rSzQdH9biNI3b2g==
X-Received: by 2002:a05:6830:148d:b0:6b1:5e8f:e50c with SMTP id s13-20020a056830148d00b006b15e8fe50cmr5599616otq.30.1687103697637;
        Sun, 18 Jun 2023 08:54:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78c03000000b0062e0c39977csm2454022pfd.139.2023.06.18.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 08:54:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 18 Jun 2023 08:54:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (oxp-sensors) Simplify logic of error return
Message-ID: <1c7961f5-a7d0-4c9d-a25d-6929ec4ea2da@roeck-us.net>
References: <20230617181159.32844-1-samsagax@gmail.com>
 <20230617181159.32844-3-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617181159.32844-3-samsagax@gmail.com>
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

On Sat, Jun 17, 2023 at 03:11:43PM -0300, Joaquín Ignacio Aramendía wrote:
> Take return logic on error out of if-else, eliminating
> duplicated code in tt_togle_store() function.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/oxp-sensors.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 584e48d8106e..1e59d97219c4 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -226,13 +226,12 @@ static ssize_t tt_toggle_store(struct device *dev,
>  
>  	if (value) {
>  		rval = tt_toggle_enable();
> -		if (rval)
> -			return rval;
>  	} else {
>  		rval = tt_toggle_disable();
> -		if (rval)
> -			return rval;
>  	}
> +	if (rval)
> +		return rval;
> +
>  	return count;
>  }
>  
