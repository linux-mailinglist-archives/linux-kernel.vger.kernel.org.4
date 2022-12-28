Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D20658395
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiL1Qs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiL1QsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:48:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD391EAEB;
        Wed, 28 Dec 2022 08:43:47 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso10115667ott.10;
        Wed, 28 Dec 2022 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQnCrhO6AKq+gpRyWcdcxzO02zH/wV4Yr26kZOjwumU=;
        b=qTR3nxDn4gUfYaSPGy2lmOXO9F1qBxWnK/JCCDwUDuTq/cjYtsW6mRdw3L4NDVutXR
         MnODtHcixA6knwVhh5ssVQnnRWBLxNLWXQgELgz5n2Z5mSXTby6J71AyFLnFNOCVw6C6
         Yxr8eCaAipNK3BCxDtgq4dDVxQsxTJ+6GsViEZmfmE1eJuquZfsAIDMzPIcJNvLDanz4
         1xLgvEDoImCtvAApIGDVgu45NQ1S2MDwy7SgjcPvWof0uaGvWlGvAkdrgOQIpIOtGQQo
         9nsWChHH1dzZbNFe3z2tvlzn1XFLBqCksNzRb6oeQNrS6jWgGr93qkNVEx032SSgMQ4P
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQnCrhO6AKq+gpRyWcdcxzO02zH/wV4Yr26kZOjwumU=;
        b=MznWP2Lwk3V/UfB60stBBGNHXeP5X8yz7TkshASBtdinY2aNp93qL1Fou+GACLCPf7
         Z+jVrQ02CNzkWmyoM6bphM6C1UKkPyqonmSBLvSu4INR13RNzVWRGBBfmSe6Ds8uglpP
         /37BYAeqwcb1MHLBOgzTb5mhanHAwDjZMzOqeeRInba0mLElcGTF7Ysq20vtnHUpH4cd
         ZN7SSj2wSTMWEID8kQnadj3+Dn1QzSMPOH/gnfTWmja+AVa1aKeP7q1caQluk5sJ1WA2
         1A6pYwrtl1qj62eGLWqV4SsCOY4zndswNuRAcm3o9/2moJ7JWFSSvC+XeGjs3RMOziEM
         0krA==
X-Gm-Message-State: AFqh2kpHb1A24rC+PpWQtmALPA9HAaA/SwXxWw2J1xMUbODSGeBY/t7U
        dtDz2ajMfjpY6njhsgbzLOwJJlAnT1E=
X-Google-Smtp-Source: AMrXdXus8lns6O5PUhZnkXlvB4P0Ybk6baKuuXoHPGfSHLo2hfxQVGqSvzjcLIdbsvZXT1158PMAlw==
X-Received: by 2002:a05:6830:1112:b0:671:b52f:5c3a with SMTP id w18-20020a056830111200b00671b52f5c3amr13488556otq.34.1672245826349;
        Wed, 28 Dec 2022 08:43:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4-20020a9d6d84000000b0066e7e4b2f76sm7910356otp.17.2022.12.28.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:43:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 08:43:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Cormier, Jonathan" <jcormier@criticallink.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: Re: [PATCH v2 2/4] hwmon: ltc2945: Add devicetree match table
Message-ID: <20221228164344.GA1267483@roeck-us.net>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
 <20221220000457.1163446-3-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220000457.1163446-3-jcormier@criticallink.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 07:04:55PM -0500, Cormier, Jonathan wrote:
> Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>

There should still be some description here.

> ---
>  drivers/hwmon/ltc2945.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index 9adebb59f604..9af3e3821152 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -58,6 +58,12 @@
>  #define CONTROL_MULT_SELECT	(1 << 0)
>  #define CONTROL_TEST_MODE	(1 << 4)
> 
> +static const struct of_device_id __maybe_unused ltc2945_of_match[] = {
> +	{ .compatible = "adi,ltc2945" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc2945_of_match);
> +
>  static inline bool is_power_reg(u8 reg)
>  {
>  	return reg < LTC2945_SENSE_H;
> @@ -475,8 +481,9 @@ MODULE_DEVICE_TABLE(i2c, ltc2945_id);
> 
>  static struct i2c_driver ltc2945_driver = {
>  	.driver = {
> -		   .name = "ltc2945",
> -		   },
> +		.name = "ltc2945",
> +		.of_match_table = of_match_ptr(ltc2945_of_match),
> +	},
>  	.probe_new = ltc2945_probe,
>  	.id_table = ltc2945_id,
>  };
> --
> 2.25.1
