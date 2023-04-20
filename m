Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFD6E9A99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjDTRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjDTRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:21:14 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6CE5A;
        Thu, 20 Apr 2023 10:21:10 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Q2PZS65dvz9sTS;
        Thu, 20 Apr 2023 19:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682011264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDcMmxBtkKkSUHZeVxIXXpyPKTciaaqs1ASjEx9+mnM=;
        b=TUNuIIKbsWhVz3dtfNXcA78yEahkQBwGrGEz+N2KmrKrdfXTmatGWkQ6HLNY8BQ0cA8irt
        G0a7q/dTYGUrCrASz98nWGDouNPyrh4dYNHBDZ+RaKkSfWiy9Kb+ooxZig6pCh0+HZbnhj
        YeEGGdt9iXS6K27SeU+tvx3vAfKpmcne1e7uQm261mI97W6PHfX9Q4U1EL+vVPMYhN///7
        R7wRKx/1ef5C3r3nVl1rFOeEX1MfwO6RgjRXFQmP1m6dyulCTM4dWUfOzRQiUigHNuxZWQ
        Bv6vYTyXF3t1JbY+TmX1l9dtcS1fEkvAEc24YQZXvCUNaFDfI8lcljYQKZMSDQ==
Message-ID: <5fb32c56-ac2d-0e1d-370d-d199f5b92775@mariushoch.de>
Date:   Thu, 20 Apr 2023 19:21:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] iio: st_sensors: Add lsm303d support
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230415231130.115094-1-mail@mariushoch.de>
 <3eb3de24-41b4-9566-9b11-a12d21904793@redhat.com>
Content-Language: en-US
From:   Marius Hoch <mail@mariushoch.de>
Cc:     Marius Hoch <marius@mariushoch.de>
In-Reply-To: <3eb3de24-41b4-9566-9b11-a12d21904793@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Q2PZS65dvz9sTS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 16/04/2023 22:19, Hans de Goede wrote:
> Hi Marius,
>
> On 4/16/23 01:11, Marius Hoch wrote:
>> Hi!
>>
>> This patch series adds support for the LSM303D accelerometer and
>> magnetometer. As the LSM303D is basically, as far as I can tell,
>> the LSM9DS0 without gyroscope, we can easily re-use its definitions.
>>
>> This was tested on a Lenovo Yoga Tablet 2 1051-F.
> Thank you for your work on this. I have had this on my own todo list
> since 2020 at least and I did not realize that Andy already added ST IMU
> support in 2021 so this just needed some extra device-ids :)
>
> I have tested this successfully on the following models:
>
> Lenovo Yoga Tablet 2 851F (Windows version 8")
>
> This version needs an accel-mount-matrix quick in hwdb since it has
> a portrait screen rather then a landscape screen (so 90° rotated):
> https://github.com/systemd/systemd/pull/27295
> Note I've made sure that this quirk only applies to the 851 and not to the 1051.
>
> Lenovo Yoga Tablet 2  830F (Android version 8")
>
> Since the ACPI tables are broken in the Android BIOS these need
> a patch to x86-android-tablets to instantiate the i2c_client
> for the sensor, I'm still finalizing this patch and I'll submit
> it upstream when its finished.
>
> Tested-by: Hans de Goede <hansg@kernel.org>
>
> Regards,
>
> Hans
>
>
> p.s.
>
> 1: I noticed that auto-screen rotation using iio-sensor-proxy is quite slow
> so I wrote a patch to fix this :)   :
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/366
Nice, that should make rotating fast (well, as fast these devices can 
handle).
>
> 2: There are some other unsupported sensors on these models too,
> perhaps you are interested in adding support for these too?
>
> Here are my personal notes on this:
>   -Light sensor should work with drivers/iio/light/al3320a.c
>    https://github.com/JideTechnology/remixos-kernel/commit/c52d55b4bd907e87b7b115b3943219f3e089a77a
That indeed worked like a charm, I'll post the patch later today.
>
>   -MXM1120 HALL sensor, have datasheet, measures angle of kickstand thingie, use
>    for SW_TABLET_MODE. Do a pdx86 driver just for the Tab 2 which checks that the
>    kick stand is out *and* the BT keyboard is paired, in that case report
>    SW_TABLET_MODE=0, in all other cases report SW_TABLET_MODE=1 ??
>    For the commit msg:
>    Datasheet available here: http://haechitech.com/tech-support/
>    Requires creating an account, once you have an account you can immediately download
>    the provided datasheets (or let me know if you want me to email you a copy)
Thanks for the pointers, that sounds like a nice little project. I'll 
give it a shot :)
>
> Especially the light sensor should be an easy win and light sensors
> are already supported in e.g. iio-sensor-proxy

Cheers,
Marius
>
>
>
>
>
>
>
>
>
>> Changes in v3:
>> Simplified the ACPI tables in the LSM9DS0 IMU driver, per Jonathan Cameron.
>>
>> Marius Hoch (6):
>>    iio: accel: st_accel: Add LSM303D
>>    iio: magnetometer: st_accel: Add LSM303D
>>    iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
>>    iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU
>>      driver
>>    iio: Comment that the LSM303D also has the Magnetometer DRDY
>>    dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
>>
>>   .../devicetree/bindings/iio/st,st-sensors.yaml       |  1 +
>>   drivers/iio/accel/st_accel_core.c                    |  1 +
>>   drivers/iio/imu/st_lsm9ds0/Kconfig                   |  3 ++-
>>   drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c          | 12 ++++++++++++
>>   drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c          | 12 ++++++++++++
>>   drivers/iio/magnetometer/st_magn_core.c              |  1 +
>>   include/linux/iio/common/st_sensors.h                |  1 +
>>   include/linux/platform_data/st_sensors_pdata.h       |  2 +-
>>   8 files changed, 31 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d

