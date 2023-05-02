Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7886F465F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjEBOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEBOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:51:55 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A010E6;
        Tue,  2 May 2023 07:51:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q9jhd2jwKz9sdK;
        Tue,  2 May 2023 16:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1683039105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCfcf6FSM/bUYl403EMZyHDqpdSAF9tPFEUHDQUYu2E=;
        b=CObgluT8g4B7ZcUl430iOjj2Uv0J7Zl0Rwbp3njGw0qTdArA2BPGZB3MoNLwgVcVvMDAQ8
        h91i07Dsw0OexvV0e6UeBc+bG/B1Ua9ZkC36RwipEyukOQz6ai0bGsSXP/oEwIk80hesAy
        fEP6QB068g2kTYK5TdXhnwcgilMikK/YCX61Y6mb4Qh5ofUSk5XB4Uahg5Lc3RdNV/+o9F
        RRlpDsw761pGKoupAFFAq+aKqodXJBKwfklLlyOjirVjEE2tkluC3/WBu013dEq5WAODpS
        u03AOwk5Hj5Dd7L/jT29XJ+h3J0u02Dh2yFlayP8a+7354pbiFLsloITIh+bjQ==
Message-ID: <e669d656-1474-ad95-4667-3a6ae79605e3@mariushoch.de>
Date:   Tue, 2 May 2023 16:51:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/6] iio: st_sensors: Add ACPI support for lsm303d to
 the LSM9DS0 IMU driver
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <marius@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
 <20230415231130.115094-5-mail@mariushoch.de>
Content-Language: en-US
From:   Marius Hoch <mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-5-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Q9jhd2jwKz9sdK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/04/2023 01:11, Marius Hoch wrote:
<snip>
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> index 997b5ff792be..55f3738193af 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> @@ -37,6 +37,12 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
>   };
>   MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
>   
> +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
> +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
> +
>   static const struct regmap_config st_lsm9ds0_regmap_config = {
>   	.reg_bits	= 8,
>   	.val_bits	= 8,
> @@ -72,6 +78,7 @@ static struct spi_driver st_lsm9ds0_driver = {
>   	.driver = {
>   		.name = "st-lsm9ds0-spi",
>   		.of_match_table = st_lsm9ds0_of_match,
> +		.acpi_match_table = st_lsm9ds0_acpi_match,
>   	},
>   	.probe = st_lsm9ds0_spi_probe,
>   	.id_table = st_lsm9ds0_id_table,
I just realized that these changes (the SPI ones, not the I2C ones) are 
entirely superfluous, and I'm not sure why I added this in the first 
place. In the Lenovo Yoga Tablet 2 series (which seem to be the only 
devices exposing this as "ACCL0001"), the device is accessible via I2C. 
Just to make sure, I re-tested the patch chain without this change.

@Jonathan: Shall I upload an entirely new patch set (v4), do this in a 
separate new clean up commit, or do you want to just drop these changes 
to drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c? I'm fine with any of 
these options.

Cheers,
Marius
