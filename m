Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9C6CD986
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjC2MrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjC2MrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:47:07 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17644201;
        Wed, 29 Mar 2023 05:47:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p15so19080930ybl.9;
        Wed, 29 Mar 2023 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680094024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4LKIkv2jjaqEZGV9hdNc6tEqjwN//q2Vxizmj38FUA=;
        b=C/FTOzsvLpqVoXeHw2ea3zPblLBmegOph8K5ugkJuMIeVAh+UCRABDUafaz1f7aIY6
         6uf6Eisxla9gTI1kVxoaNMRvLuZ+886001EChYlz+7QAHyUKtffhSZ+X9AgaV5Dhtt4i
         cUdoYx3/xC5++3RLFEW4Rn3nqjJISH/yMNBoXQmw5JVhqdMNSGq2uHeW/tSjnSOHMLQa
         YPEPwgq/aw07Xa5Eb8W/ULtEWEPMWzjvndelcYOIxi6SzYfEpuo/wUlWirjvVu84PMP1
         vVbBQxeLG0dRy38s+Tx6/biOIJEOPkegxuH0BASHN12MurYJAEfE3M4DGsdnhYNOaZrl
         ka+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4LKIkv2jjaqEZGV9hdNc6tEqjwN//q2Vxizmj38FUA=;
        b=OHjyD6SoPlBWaxlf8DY5WWFgtOkShN1AhYYFPL7e4eFE5z5rjYjfgyrH+GWiuM8Ite
         Z12Dl5yvE3pnIBmiU+MwHVK9WYcS6tE4fNKkQ5Lu2pUWYpE67kzp/EysuNGv3HxUuzME
         kquZo18bLaOZWjZT2EkMnzq2TKo7DTaNE9VpFfk099sAAEP/10ZBAdLlaJvMwKxLcaUy
         LCb/CktQembxOvqGhc4NxpmEc5yMqrLcfIYPn1yadw/E1UMIuJxA0GaBleIqi+GsGXZI
         OWPUNmSJcsPrITSWBXj2ZqEgjNVNTWk7tpor2X27IBOaLJ3c1T1VDok027ENc2pQjxV5
         J4jg==
X-Gm-Message-State: AAQBX9c+f2Kx5gfXsyiJdmIfmt5GkjrDAR6asE/t87Wq4xJIoffCe4om
        SE0j8lCTd6M2br1tu8vGHfw=
X-Google-Smtp-Source: AKy350YEM1SqgxyCn8Vd3o3g7PhTtI779t7HLSnooS41hqjb0hoQKh7r4DomNpI4mAxy9ATSPaD6CQ==
X-Received: by 2002:a25:1141:0:b0:b73:f2ab:8c8b with SMTP id 62-20020a251141000000b00b73f2ab8c8bmr2005620ybr.2.1680094023840;
        Wed, 29 Mar 2023 05:47:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x94-20020a25a067000000b00b7767ca74a0sm3424611ybh.61.2023.03.29.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:47:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Mar 2023 05:47:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "peter.ganzhorn@gmail.com" <peter.ganzhorn@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Message-ID: <aeed703c-5dbb-4a6f-a4d7-3c6a55d99e9e@roeck-us.net>
References: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
 <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:43:58AM +0000, Zhang, Rui wrote:
> Hi, Peter,
> 
> CC the list.
> 
> On Tue, 2023-03-28 at 22:37 +0200, Peter Ganzhorn wrote:
> > Dear Mr. Rui,
> > Dear Mr. Roeck,
> > 
> > please consider accepting the attached patches or
> > modifying the coretemp code to stop spamming my syslog.
> > I would appreciate it very much if you can accept the patches.
> > 
> > coretemp: Improve dynamic changes of TjMax
> > After introduction of dynamic TjMax changes in commit
> > c0c67f8761cec1fe36c21d85b1a5400ea7ac30cd
> > my syslog gets spammed with "TjMax is ... degrees C"
> > messages.
> > If TjMax is subject to change at any time, it won't be
> > set in tdata anymore and re-read every time from MSR.
> > This causes quite a lot of dev_dbg() messages to be issued.
> > 
> > The following patches change the code to read TjMax
> > from the MSRs into tdata->tjmax (again) but allow for a
> > dynamic update at any time as well. (Patches 1 and 2)
> > This way a message will only be issued after actual changes.
> > Also I replaced the dev_dbg() with dev_notice (Patch 3) and
> > added a additional dev_notice for the case where TjMax is
> > set based on assumptions. (Patch 4)
> > 
> > 
> > If you do not want to accept my patches, removing the
> > dev_dbg() in get_tjmax() would be the most simple
> > solution I guess.
> > 
> Please check if below patch solves your problem or not.
> 
> From 9370ee5163a85f65230b5222f1f4dece59ce078a Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 29 Mar 2023 11:35:18 +0800
> Subject: [PATCH] hwmon: (coretemp) Avoid duplicate debug messages
> 
> Avoid duplicate dev_dbg messages when tjmax value retrieved from MSR
> does not change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/hwmon/coretemp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 30d77f451937..809456967b50 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -267,6 +267,7 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
>  	int err;
>  	u32 eax, edx;
>  	u32 val;
> +	static u32 tjmax;

That would apply to every instance of this driver, meaning to every
CPU core. Is that really appropriate ?

Guenter

>  
>  	/* use static tjmax once it is set */
>  	if (tdata->tjmax)
> @@ -287,7 +288,10 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
>  		 * will be used
>  		 */
>  		if (val) {
> -			dev_dbg(dev, "TjMax is %d degrees C\n", val);
> +			if (tjmax != val) {
> +				dev_dbg(dev, "TjMax is %d degrees C\n", val);
> +				tjmax = val;
> +			}
>  			return val * 1000;
>  		}
>  	}
> -- 
> 2.25.1
> 
