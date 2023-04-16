Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49B6E3977
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjDPOnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjDPOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:43:06 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D8B26BA;
        Sun, 16 Apr 2023 07:43:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760f4dcfdf4so9114639f.2;
        Sun, 16 Apr 2023 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681656181; x=1684248181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGpLBVsxwER8/EaEoKHaVtqV2psSyJ0wu7dYzjJmzf8=;
        b=ouPeFzfuNPxikun9ZeVqPAUq6CFiJ19wacRCX8UZJxRWgGfio30SC+a7BO219p07cl
         XVgKDLX/TOu4vLduXjYdkBtnDipb3ZjiFQp6Pe2ZXQYpJ17yl65S+Z/TBKD4SRMDFwKG
         KQ9aofOVxsrzUkcmp8IOYpnhs8QuFmBrUUo0qw0nXq/J9zlHYOTIbAQQZoIgdJ1iPmPM
         2RIQYgtQpQD980zCg+fI0qecxfkAtVRhnLlc9vjrF/gha3GrhFmgt9IngFWkcTGha9ik
         A/kRuTp+2i7tqtu6TJPmWyvTh6c89xOmG+Ni9APeunZE1jU4haUQ7iJUEDvu8V4+Nscx
         JOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681656181; x=1684248181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGpLBVsxwER8/EaEoKHaVtqV2psSyJ0wu7dYzjJmzf8=;
        b=S9DaslT+zSMFhzoJz4EzzIkeGnyR9JP0Og4VYjz/j+wpPknc+/sFLVUOVx4dnbjOWp
         UCeNIqcZxZNL7r7a5sZeHMiAuIlvlXI+uh9tukQu0e5kKeqd7oUnYZSJt/Gj86sR+k2T
         YpByFxpeZqdzfvqxgo/XwnaqOwjWOB7P7bUHRPubD4X4q//QzOITW45emGxxqeV/4u2u
         7cJcoCnRMQ/K3ngA38liHadQMj2JP2AXJkH4et2kUmGMRZgTPq69PFcc4NOl/ykzQM7L
         Dp6TfpPWXhlpAYTYFmtb53OnJ5Q5c21/EmYF8gEBH0leBU4LgWXB4kTF92WXjDMfGJox
         9svA==
X-Gm-Message-State: AAQBX9cnR3ukxC8nnhfJFHCE9GyUmU1Ccsx7KbZJcaQ2xx8OF9pQ9BeC
        ZOwaUis3LekavFRxRi4dfRQ=
X-Google-Smtp-Source: AKy350ajVI1dcl+qJWnB5TwZgR5tXJgpuczGoJNcRfKU8OJAidqFloEWErsqAQYlomUnSlM8SAPWWw==
X-Received: by 2002:a92:2809:0:b0:328:9739:440b with SMTP id l9-20020a922809000000b003289739440bmr8404145ilf.0.1681656181616;
        Sun, 16 Apr 2023 07:43:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020a02cbcf000000b0040f783066a5sm1924899jaq.31.2023.04.16.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:43:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:43:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
Message-ID: <5c043eeb-97c4-4666-9112-c13fefde81cc@roeck-us.net>
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com>
 <20230413132627.3444119-6-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132627.3444119-6-lakshmiy@us.ibm.com>
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

On Thu, Apr 13, 2023 at 08:26:27AM -0500, Lakshmi Yadlapati wrote:
> Bonnell system supports new ACBEL FSG032 power supply on
> I2C addresses 5A and 5B. Update the device tree with new
> power supply information and device addresses.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

This patch will have to be applied through an ARM tree.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> index a5be0ee048ec..4f959a4f8b58 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> @@ -552,14 +552,14 @@ ucd90160@64 {
>  &i2c3 {
>  	status = "okay";
>  
> -	power-supply@58 {
> -		compatible = "ibm,cffps";
> -		reg = <0x58>;
> +	power-supply@5a {
> +		compatible = "acbel,fsg032";
> +		reg = <0x5a>;
>  	};
>  
> -	power-supply@59 {
> -		compatible = "ibm,cffps";
> -		reg = <0x59>;
> +	power-supply@5b {
> +		compatible = "acbel,fsg032";
> +		reg = <0x5b>;
>  	};
>  };
>  
