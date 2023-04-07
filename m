Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5816DB007
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjDGQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbjDGQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:00:42 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5626BC;
        Fri,  7 Apr 2023 09:00:25 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-177b78067ffso46079387fac.7;
        Fri, 07 Apr 2023 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883224; x=1683475224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2S6Pmye+PocCkGNNTJR6fJAUTji3mNvriRoTwPJxn0=;
        b=W9vvvExnjEQKQ/UVsX9DvpcsxK86nU+FRAJLRPHWAOponMX/Rtb5LflGefUNvbKP30
         ea1j64m8Jg6urP5MrwSaeqjiSh1qNkQJ7RHbYmneTe6EoSzOmSmxfJ2PGpySdLKVtwhG
         eOyyyeJt2g2aDFeNSZlztkDpCYucBkn20QpRo19evG8/Y09Giu1TUNMRg/65SST1+Mj7
         WCZ+l2UOelCPKymtphiTAs1JA8Ve44e+0MFwDtF8grMdSr+hu8EQ5KfV6vhGSWbfxGUr
         wfnJwmx3kU3075SQ+KhQHuS6b0Csus4XLwat5Nvu3dzD2QCLSnZU7H5VMCHxOmlkx4Mj
         bXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883224; x=1683475224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2S6Pmye+PocCkGNNTJR6fJAUTji3mNvriRoTwPJxn0=;
        b=VKM0cDGTIS0//ijiqSCSqm3qCzxzkUxYd3ZHkxiQM0lRU8uw937CO7CKO2j7Q70Gxi
         HtL6tU79NdyRNUaqIPKi5FwuX6AOdEiJKQmDEi1E06Os6FW6wiGFZECwesHweQXk2+o9
         lXMoHqFP0rGbpqNDJSTn7U30WlG08S9TkWUoB26jMoKHj82vEPhZKrpCI7Ck0E7m6v6E
         i549vc6AJy7lkFHh1o/AG4rWv9eAgkj0tnSpfi6D9+hCBMW8UN41dWS+l2fua1oftQwt
         XlB7xM2TO2MMsmVtIeT7aVzIj1qhWsZPO/lDVMwSDUOjq8INlar10f/P6c/wjWhpJdim
         ib6Q==
X-Gm-Message-State: AAQBX9dAS94A5WgtEpisgOmqjcjnfqCs7SJiqEtswhatYmatzbJasSrY
        6dqboBztsciozduO9Z4dekTibUeQZkE=
X-Google-Smtp-Source: AKy350b3N2uaGwPX4D1M65fwviXMWpAEeCL4E6lFdDXgJy5tB8VUuvtjgVFyFd5ssXR1zWn7XYBxcQ==
X-Received: by 2002:a05:6870:f20f:b0:17a:b6b6:6f2e with SMTP id t15-20020a056870f20f00b0017ab6b66f2emr2043715oao.56.1680883224640;
        Fri, 07 Apr 2023 09:00:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v21-20020a9d5a15000000b00684152e9ff2sm1844174oth.0.2023.04.07.09.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 09:00:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        peter.ganzhorn@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (coretemp) Delete tjmax debug message
Message-ID: <d792cf15-4263-44f2-ba93-a2479662fbe9@roeck-us.net>
References: <20230330103346.6044-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330103346.6044-1-rui.zhang@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:33:45PM +0800, Zhang Rui wrote:
> After commit c0c67f8761ce ("hwmon: (coretemp) Add support for dynamic
> tjmax"), tjmax value is retrieved from MSR every time the temperature is
> read.
> This means that, with debug message enabled, the tjmax debug message is
> printed out for every single temperature read for any CPU. This spams
> the syslog.
> 
> Ideally, as tjmax is package scope unique, the debug message should show
> once when tjmax is changed for one package. But this requires inventing
> some new per-package data in the coretemp driver, and this is overkill.
> 
> To keep the code simple, delete the tjmax debug message.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 30d77f451937..fe3d4d0dcbed 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -286,10 +286,8 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
>  		 * If the TjMax is not plausible, an assumption
>  		 * will be used
>  		 */
> -		if (val) {
> -			dev_dbg(dev, "TjMax is %d degrees C\n", val);
> +		if (val)
>  			return val * 1000;
> -		}
>  	}
>  
>  	if (force_tjmax) {
