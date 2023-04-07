Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628B6DB00A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjDGQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjDGQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:01:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE937ED0;
        Fri,  7 Apr 2023 09:01:05 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17786581fe1so46049426fac.10;
        Fri, 07 Apr 2023 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883264; x=1683475264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASAeBSNnC1XcMqJAI1nUTNDXuUf0iWiJJfczB0jpDRA=;
        b=jpGPJ79fabE0r2BTRbZ/VPG0XWRygNaQo+K6uyoyjDD3iY61BXNWRRTvpSs7kHV4bc
         3grH4Q0KybYQa+stKQs6VeJO8R4e3uJld0rEp5w8in4BeGFLkONMKLOMFBreXtvdgbY3
         iaizZVSKU5InYoKEFW+oTiYD8N1Sw3x0e+MfCB/iXmh4FVUO0fHWiMBHhPMbthz7rpTD
         /0znfU9Om6fZjHjYyn0KMkZjrq0/tVPRsNBcxF2hUq0pbH/ETKm6pDMoB8/KOAJc8cUO
         FsoLS9MDFZmqWAm75Ijb0Xi7feK3OiDTIDbw6k58/q7rUnvRBnAAVImf8Jt6PIF1xtAY
         57NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883264; x=1683475264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASAeBSNnC1XcMqJAI1nUTNDXuUf0iWiJJfczB0jpDRA=;
        b=gfTsfiv/9wpCwZmET2iFEjUVe8DmaFcsWCEu0VlJv8Fh7E6hPzNEDuzxHdc7/m73rM
         q0DZFlAjkGgKlKZJSt3xMMnRcCWFiFkVDIobrQRK7az77P+CZv01XENyPu91iWaBY5aR
         7nEARzYrBExOVr+C7RaiDVkqtQBJ1gft9Gp55HGRSdvxSe/GePqCKGr7/ciEnJWaoDzE
         4GeUM5zGii/GF5u33GVHZBflWw6JP3pM82k+FUil1AqlZDAqiO31jMMcjl3FwdWkW6T3
         JfG74Bnbtx+h0xTvkrPI7uWNSnS8s+AwojyT0o/+KdMVsr5fnxKTI4gvUh07+ed6pBBM
         H3bg==
X-Gm-Message-State: AAQBX9fNAKQDWCiesL6XIikj6JrNdI+aaly18S9y12Vgp0op/H7fzKXM
        2Lv8Gr/R6Wkd3iUrY1kQjSs=
X-Google-Smtp-Source: AKy350bY/E21EphtCUqVzMzqQrXuyd3FE9CdvfaSWCm/wLBecOOLMYGPTAhoPHSC7I9fkts8dTDu8Q==
X-Received: by 2002:a05:6870:6589:b0:184:c8c:d05d with SMTP id fp9-20020a056870658900b001840c8cd05dmr1439812oab.56.1680883264571;
        Fri, 07 Apr 2023 09:01:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id tw11-20020a056871490b00b0017eb6cc4609sm1708190oab.39.2023.04.07.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:01:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 09:01:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        peter.ganzhorn@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (coretemp) Delete an obsolete comment
Message-ID: <02cbffad-7f61-491e-a67b-8cc22a65881a@roeck-us.net>
References: <20230330103346.6044-1-rui.zhang@intel.com>
 <20230330103346.6044-2-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330103346.6044-2-rui.zhang@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:33:46PM +0800, Zhang Rui wrote:
> The refinement of tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET
> has been changed for several times.
> 
> Now, the raw value from MSR is used without refinement. Thus remove the
> obsolete comment.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index fe3d4d0dcbed..eba94f68585a 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -282,10 +282,6 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
>  			dev_warn(dev, "Unable to read TjMax from CPU %u\n", tdata->cpu);
>  	} else {
>  		val = (eax >> 16) & 0xff;
> -		/*
> -		 * If the TjMax is not plausible, an assumption
> -		 * will be used
> -		 */
>  		if (val)
>  			return val * 1000;
>  	}
