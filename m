Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324D6DAFE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjDGPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:53:47 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318F659E;
        Fri,  7 Apr 2023 08:53:46 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v2-20020a4ac902000000b005419421eff5so585463ooq.4;
        Fri, 07 Apr 2023 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882826; x=1683474826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgLq1lLSsDmAvhlkfqySIdrzLKSlARFYe4cd65NX3XE=;
        b=MKCwCBHYX6iM2yMKTa5W14RP9oxZZZFKYfkI5pVRwfEn6n/H/excv8smjoTLBUOKe6
         tIud0rhqWv3SYtqIdF6S/gAwYPNkeg6sbWZx3ZS8lQx3YfLW0SDEF8LQrPODEH5KuYIF
         ml5OjPVhtS/m6+JW3oeP5LacNd9yr+piSzfhFViThaRh1OK4Z2E6w8Y9qmop1dIZEyrS
         RIe7Mz2AHfKsn/7m+m08+GHfoKmMwUR8vmWIZtFxmfdXS0j4I2p5gh8Jkw0IBjQydC54
         YLCXroHhLFrO7S4h2JiwpuMX76CT8rUTL1cgPPpiQI2bbDyJhN/XxmTzvxq+uc8AwWus
         AaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882826; x=1683474826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgLq1lLSsDmAvhlkfqySIdrzLKSlARFYe4cd65NX3XE=;
        b=eg7GTENSiUH4bgNsrV3H8qIjk/8w0SOuEcmgy0d+78CGgBNYUTkvkdr4sf4bioBL0w
         2ugTGJqTWva6gcajNRksFZ5mHhO+xC2fbfm1ElZ7cI7CryBCby/zUmRzDtw4FAGqAYe0
         PwoSAVExkix7sNeGjqH+ITkFx004ymT90Pc/mFLXabprNuj3CQFyE5GPHcun5u2PMUTQ
         0n6yZq/3Un+lPtQ8JDaiNm6FRNhG9Wd7yJNZFhWfP7BC4j3xcxqqgaRfV9VvzsGYKLO4
         XvcysIm7NPU2UpXI7mIZ3P5U8fx2VodTZj60zlQRKW9+iWnKdZLPaOmWJY5v44j1tHSk
         DEYw==
X-Gm-Message-State: AAQBX9fb35YNqLl2eLY7xc9qEeDXLzWyYr3WAXROPNVezdN9PuBjNaHl
        AndtNekPx+Cjtp3e4Vjn0UqNs1Kfs2U=
X-Google-Smtp-Source: AKy350YIzWAHSaoOySyB8iCBw0nia4Whk6aGTWbkBqUDgicBNQYru2uFvkqtKB4h0dDe1fRFk2jSeA==
X-Received: by 2002:a4a:4f46:0:b0:536:a447:b270 with SMTP id c67-20020a4a4f46000000b00536a447b270mr1493678oob.6.1680882826021;
        Fri, 07 Apr 2023 08:53:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1-20020a4a8941000000b005252407f6cbsm1762981ooi.30.2023.04.07.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:53:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 08:53:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     fireflame90051 <cacoukoulis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (asus-ec-sensors) add ProArt B550-Creator
Message-ID: <2eed6cdb-00cc-477c-bc25-ca02088c7a1b@roeck-us.net>
References: <20230405224339.358675-1-eugene.shalygin@gmail.com>
 <20230405224339.358675-2-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405224339.358675-2-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 12:43:38AM +0200, Eugene Shalygin wrote:
> From: fireflame90051 <cacoukoulis@gmail.com>
> 
> Add support for the ASUS ProArt B550-Creator board, was tested
> with the hardware [1].
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/35
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: fireflame90051 <cacoukoulis@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index a4039f2f9ca4..f1c9b1e11268 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -8,6 +8,7 @@ Supported boards:
>   * PRIME X570-PRO
>   * Pro WS X570-ACE
>   * ProArt X570-CREATOR WIFI
> + * ProArt B550-CREATOR
>   * ROG CROSSHAIR VIII DARK HERO
>   * ROG CROSSHAIR VIII HERO (WI-FI)
>   * ROG CROSSHAIR VIII FORMULA
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 2768b7511684..594fe7241111 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -303,6 +303,14 @@ static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
>  	.family = family_amd_500_series,
>  };
>  
> +static const struct ec_board_info board_info_pro_art_b550_creator = {
> +	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +		SENSOR_TEMP_T_SENSOR |
> +		SENSOR_FAN_CPU_OPT,
> +	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
> +	.family = family_amd_500_series,
> +};
> +
>  static const struct ec_board_info board_info_pro_ws_x570_ace = {
>  	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
> @@ -435,6 +443,8 @@ static const struct dmi_system_id dmi_table[] = {
>  					&board_info_prime_x570_pro),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
>  					&board_info_pro_art_x570_creator_wifi),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
> +					&board_info_pro_art_b550_creator),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
>  					&board_info_pro_ws_x570_ace),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO",
