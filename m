Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF66E347B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDOXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:17:42 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33C2117;
        Sat, 15 Apr 2023 16:17:41 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PzTkB0FmKz9t5J;
        Sun, 16 Apr 2023 01:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ID7qo9GtR2DnSaTsjeNTaKbxdx00/tMw/AKSjHfLv28=;
        b=lW/MmLQqe7UtJ9dH4xrygrRu8KmrS99uBQ5FexOHK4SjEeJQeixh95VuVu5pUpcVp+QIyH
        uMEjL0M/E2aGNIji3ZZYxmAZ0IxyxU8XziKdR8TqHTaHv2+kD86vWNvK4WyeU2irrbeFm2
        QW5f8FZ+JDghLJ0Yx/q4bsQ0ULV8hKbUfYaM9nbeDMLdt+lG62N4szRpHV3WeP031s6zi1
        +G93Qh+depD9Jf3xVCxMPuLFTVoqytrDJZkxIgEuHJJ/tVeQfgPdzzZ8Gi39bc9D6V2yvI
        KS6dORBo8B+ONhVfCilY7AHJL7dVGX6vmvsl/Co0zRQ36ym1Q90CSLijHgYvIQ==
Message-ID: <ab701060-00d3-246f-cad3-885cf49f73ff@mariushoch.de>
Date:   Sun, 16 Apr 2023 01:17:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] iio: st_sensors: Add ACPI support for lsm303d to
 the LSM9DS0 IMU driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <20230413024013.450165-1-mail@mariushoch.de>
 <20230413024013.450165-5-mail@mariushoch.de>
 <20230415175520.65adfc60@jic23-huawei>
Content-Language: en-US
From:   Marius Hoch <mail@mariushoch.de>
In-Reply-To: <20230415175520.65adfc60@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4PzTkB0FmKz9t5J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 18:55, Jonathan Cameron wrote:
> On Thu, 13 Apr 2023 04:40:11 +0200
> Marius Hoch <mail@mariushoch.de> wrote:
>
>> The lsm303d can be found as ACCL0001 on various Lenovo devices,
>> including the Lenovo Yoga Tablet 2 1051-F, where I tested this
>> patch.
>>
>> Signed-off-by: Marius Hoch <mail@mariushoch.de>
>> ---
>>   drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 10 ++++++++++
>>   drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 10 ++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
>> index 64fa77d302e2..79be8d28d965 100644
>> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
>> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/regmap.h>
>> +#include <linux/acpi.h>
>>   
>>   #include <linux/iio/common/st_sensors_i2c.h>
>>   
>> @@ -37,6 +38,14 @@ static const struct i2c_device_id st_lsm9ds0_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
>>   
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
>> +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
>> +#endif
> The table is tiny so I'd prefer dropping the complexity of ifdefs
> and getting rid of the ACPI_PTR() below. Just assign the pointer
> unconditionally.
>
> Rest of the series looks good to me
>
> Thanks,
>
> Jonathan
Thanks for your review, applied in v3.
>> +
>>   static const struct regmap_config st_lsm9ds0_regmap_config = {
>>   	.reg_bits	= 8,
>>   	.val_bits	= 8,
>> @@ -73,6 +82,7 @@ static struct i2c_driver st_lsm9ds0_driver = {
>>   	.driver = {
>>   		.name = "st-lsm9ds0-i2c",
>>   		.of_match_table = st_lsm9ds0_of_match,
>> +		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
>>   	},
>>   	.probe_new = st_lsm9ds0_i2c_probe,
>>   	.id_table = st_lsm9ds0_id_table,
>> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
>> index 997b5ff792be..27c5d99ce0e3 100644
>> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
>> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/regmap.h>
>>   #include <linux/spi/spi.h>
>> +#include <linux/acpi.h>
>>   
>>   #include <linux/iio/common/st_sensors_spi.h>
>>   
>> @@ -37,6 +38,14 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
>>   
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
>> +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
>> +#endif
>> +
>>   static const struct regmap_config st_lsm9ds0_regmap_config = {
>>   	.reg_bits	= 8,
>>   	.val_bits	= 8,
>> @@ -72,6 +81,7 @@ static struct spi_driver st_lsm9ds0_driver = {
>>   	.driver = {
>>   		.name = "st-lsm9ds0-spi",
>>   		.of_match_table = st_lsm9ds0_of_match,
>> +		.acpi_match_table = ACPI_PTR(st_lsm9ds0_acpi_match),
>>   	},
>>   	.probe = st_lsm9ds0_spi_probe,
>>   	.id_table = st_lsm9ds0_id_table,

