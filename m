Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7D6DC98A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDJQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDJQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:53:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449661B7;
        Mon, 10 Apr 2023 09:53:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-635df3bd6e9so1764567b3a.1;
        Mon, 10 Apr 2023 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681145589; x=1683737589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWeus/1TG729DUywxoS6X/N3MWh2B8xrD5CBn+py+cA=;
        b=kA+YsmkN4/wlHXaLo0dnuOP3fq95QoEsxH+AqJUzZwtYB6MhhJvcTnbYeAGS6hGdy3
         caUQ+yR28ufK3e3GC8qI8Pav7RnfUj9LylgHnx/s67zKNIGLWP42s3zZhm8DDRAxt2pf
         pW7ZdAAfIV5rA1sqCPfKys3+I9s6DdbS2bGKhEA7vNOaipy9hFVIITLYJx0P0zm56B/w
         Lm7norVIPdRNRkljdccqWjGlHT77RxJWdRT183Fitcp02YGul+BsGan1OdaYAfn7E43X
         qlfD0r6J+FB9259bURQK4WiQOYeRGgckoz8fZpnVASx4pheHUxzAIDud1SjefIlxMCoQ
         Bkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145589; x=1683737589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWeus/1TG729DUywxoS6X/N3MWh2B8xrD5CBn+py+cA=;
        b=ChEwLocn9qpW/Qbz6MEZG2y+s7wlv5cQuYLnrPL9rYJZJIh/gN1d+HuxcAacHFtoTk
         fRrESjtskjLO6IvxKOKH5VaIl94ydJ1GYRpUEjPdFAOVN4lmev+OJ8o1rNMt524TeV/a
         EZnEDnZGKcsQgPGuqK8vU/+qc5kuoebGCaYBb85DSLzRzcQUbb1+OfdsXb/g+rPLRx5i
         h2TF05lBhP1CoGaYdAl1i2WFV5Za2yFGODEg7xqzE48t9oGIcBdLnogZCn+foTpROwUq
         WHK2fSThy4S77F2KRnFSxr4NFdyVfYGe3XPFqam/vQmSM2PQUKtI3f941oNSnCY9RAIH
         EfTg==
X-Gm-Message-State: AAQBX9d8f9V4d0Xw459cSVQqnzmqiHPgI6CCM1KPV2wlzLK5hAPNmp1O
        3bkVpGsOncBFo5OCmZOOxanAuQnGF58=
X-Google-Smtp-Source: AKy350brRTVCI4OHWFtiClDz3kbZmTue9ILVke+W4K7PH8x65Pbl+t5jgAc4nfDgs+sSh8Px6CmAWw==
X-Received: by 2002:a05:6a00:a12:b0:627:de16:889c with SMTP id p18-20020a056a000a1200b00627de16889cmr14586491pfh.4.1681145589585;
        Mon, 10 Apr 2023 09:53:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u5-20020a62ed05000000b0062a56e51fd7sm8030553pfh.188.2023.04.10.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:53:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Apr 2023 09:53:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix alignment of function
 call params
Message-ID: <c24a071e-b191-4626-8edc-1658a01d80ef@roeck-us.net>
References: <20230409183549.12683-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409183549.12683-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 08:35:49PM +0200, Aleksa Savic wrote:
> checkpatch warns that alignment of parameters of function call around
> line 869 is off. Indent them properly.
> 
> Fixes: 6f5cdf9b9a86 ("hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 3bd35d833e69..7db7769fe044 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -867,8 +867,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		switch (priv->kind) {
>  		case aquaero:
>  			ret = aqc_get_ctrl_val(priv,
> -				AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
> -				val, AQC_BE16);
> +					       AQUAERO_CTRL_PRESET_START +
> +					       channel * AQUAERO_CTRL_PRESET_SIZE, val, AQC_BE16);

I am not sure I understand how this would improve readability.
It seems to accomplish the opposite. Sure, I know, checkpatch --strict
complains, but that is still better than unreadable code just to make
checkpatch happy.

Guenter
