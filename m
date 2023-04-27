Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC006F0AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244381AbjD0Rfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbjD0Rfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:35:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7E49E1;
        Thu, 27 Apr 2023 10:35:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a98ac97d47so36752185ad.3;
        Thu, 27 Apr 2023 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682616935; x=1685208935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBYUm9tVqCiWDBbjkE4AB7Mv6vETqyrIBGEE8JXsXw4=;
        b=LrXfma4B4uRjtV5mrxJfuWNe9ALomTMeO7kzdfpqbzdUpMObVsWjTjm3rTx6CpB/zw
         i1xQ19YOBxN0f2WUlI1bO1M6iJU+Vx+ftIrcNwqUp6NjkJwB5HobGOw6gXwPiNhjqN/M
         cWirlYmnk+0ze7DGmqWfPJ5AMGk5PEyM18UChZxyNQikCDRPobqYlsubavwURp3lPIJn
         M7R4GDy/krW35Qt9ADZwfDxHwoGZ+xERmduUvd94xfE8s+Ba6/UansxzyEXocgMWvRVk
         N5TgJWBfmJYMRD69D15njSgRVnctV2NMSLrg2Uwh7FV9vsy9emRDKkqk8M6u9zM1IIaY
         ZU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616935; x=1685208935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBYUm9tVqCiWDBbjkE4AB7Mv6vETqyrIBGEE8JXsXw4=;
        b=ICdE76/HjGSXF8ktAHBQkg1CmzswbO7p3v8nqUh2t8mAHhPELUI7QoicDp1HZbshOf
         O9yUWENQw9iKNi/hYeczFFOycmywMJV/O0s95+6PojH1GAYyPDCZ6APj8kxCvVU94tlv
         P3ZGjwnrPbzvapPatosNPUnqX1Boqt3kDK2OOLFCObniwiY0NGVucTMJb4yukRli3qU9
         1ljov+j72AqUtPPFeBxZug12ihMu7zKsca0DTBO70aQxbrocFr5JQeMiCizfMXzvDJeX
         +wrF3c/NeNV1iSG8TiMYoEeofebBj8BzZsKg9v06LMDELxlvsypwZ9g3R5nFT2DNVTAP
         1XAA==
X-Gm-Message-State: AC+VfDyUBLOZ4S661/kEMRaXEkgu3WVfDSP29o2h7yqUbSNkGCWLMmhz
        47fz1L07hod8T7sqcDo72AYokL3kqE0=
X-Google-Smtp-Source: ACHHUZ4lAYEkqhI9ODkld90EOkg8P4e+eAt8YjMGhI3D4DWMTiBkuutAJNggr+xO9wPztYzhDpkUKA==
X-Received: by 2002:a17:902:d2c5:b0:1a1:bf22:2b6e with SMTP id n5-20020a170902d2c500b001a1bf222b6emr2991823plc.43.1682616935057;
        Thu, 27 Apr 2023 10:35:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az6-20020a170902a58600b001a1ca6dc38csm11885579plb.118.2023.04.27.10.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:35:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Apr 2023 10:35:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
Message-ID: <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
References: <20230426184420.99945-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426184420.99945-1-samsagax@gmail.com>
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

On Wed, Apr 26, 2023 at 03:44:20PM -0300, Joaquín Ignacio Aramendía wrote:
> Add support for handhelds with same EC registers
>   - AYANEO 2
>   - AYANEO GEEK
> 
> All functionality tests succeed on AYANEO 2 by "pastaq" user on Discord
> and AYANEO GEEK tested by "oneoc" Discord user.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

CHECK: No space is necessary after a cast
#130: FILE: drivers/hwmon/oxp-sensors.c:72:
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_2},

CHECK: No space is necessary after a cast
#144: FILE: drivers/hwmon/oxp-sensors.c:93:
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_geek},

Please run checkpatch --strict on your patches. Never mind, I'll apply the
patch anyway - I see the other entries are the same.

That makes me have a closer look at the code. What is the purpose of the
odd typecast anyway ? Why not just
	.driver_data = (void *)aya_neo_2,
and
	board = (enum oxp_board)dmi_entry->driver_data;
?

Guenter

> ---
>  Documentation/hwmon/oxp-sensors.rst |  2 ++
>  drivers/hwmon/oxp-sensors.c         | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 566a8d5bde08..4ab442301415 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -25,8 +25,10 @@ Supported devices
>  Currently the driver supports the following handhelds:
>  
>   - AOK ZOE A1
> + - Aya Neo 2
>   - Aya Neo AIR
>   - Aya Neo AIR Pro
> + - Aya Neo Geek
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index ae67207030e8..9093c608dee0 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -42,8 +42,10 @@ static bool unlock_global_acpi_lock(void)
>  
>  enum oxp_board {
>  	aok_zoe_a1 = 1,
> +	aya_neo_2,
>  	aya_neo_air,
>  	aya_neo_air_pro,
> +	aya_neo_geek,
>  	oxp_mini_amd,
>  	oxp_mini_amd_pro,
>  };
> @@ -62,6 +64,13 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_2},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -76,6 +85,13 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_geek},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -178,8 +194,10 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			if (ret)
>  				return ret;
>  			switch (board) {
> +			case aya_neo_2:
>  			case aya_neo_air:
>  			case aya_neo_air_pro:
> +			case aya_neo_geek:
>  			case oxp_mini_amd:
>  				*val = (*val * 255) / 100;
>  				break;
> @@ -217,8 +235,10 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
>  			switch (board) {
> +			case aya_neo_2:
>  			case aya_neo_air:
>  			case aya_neo_air_pro:
> +			case aya_neo_geek:
>  			case oxp_mini_amd:
>  				val = (val * 100) / 255;
>  				break;
