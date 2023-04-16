Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80E6E3BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDPUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C726B2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681676395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4VfgdWy79fScFpHd8ztN3EfNO1Bs6qzR+h66uHi/sM=;
        b=i5AxEbG0cSngHWhXf5C2ZjZqVTKNboqSncT57H8g5NdtgMKUVT3/6bhd/YaABYS5rVM4F3
        CTAm+Lew6LLkA/7keh6bqNnATBV9ENVw+aEdwesRfQKdBMq23qGg08fVVi1MKEmmLbfP4K
        JFNDWX9xrAdn1gjm7J0p34RioamNom0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-7yf3GhVmOd6IM13ocEV_iQ-1; Sun, 16 Apr 2023 16:19:54 -0400
X-MC-Unique: 7yf3GhVmOd6IM13ocEV_iQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355c9028so337675566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681676392; x=1684268392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4VfgdWy79fScFpHd8ztN3EfNO1Bs6qzR+h66uHi/sM=;
        b=IIviXxtLWYrd73LxtyJ2qe4g3mIgg3G6GaaFZ2v9pSNeg5BFORDQP5MBK5ujwxpa6y
         zdNn7C8B3DpOMltWxPyYHmWVSFwLCvOGMPcpan37MDbi7wbSIXOEK9JYV7gSS6q6UuMQ
         b5orjSAgZZca/J9Kz/5vUNWGzXhf9XbLyxfU3ea3hLfS9sC0kM8UjM7lVnfLB8UED/5A
         cTO55RsunnE9HH6nwCAuBajFeEAQ8d3/AiVJCJZNLJJBwscvqovldUeZrgnc2bfPRmRM
         fdW3rKV7NyhW10CqEeoi1Qq3AFRINegi6Bj4f58P2tyBcG+Go77JV6WfnO25OsXgcz8Z
         2i1Q==
X-Gm-Message-State: AAQBX9eeittP2ERf50BNp7x6f0EaJ6rBT70avZazq76mxWIKlBApmv3N
        3wNwvR+uw8h/ErCoutYnxISp9X8B6/xbojZyJLDNlkQH9d7LrLba5P31Yw1YBMxMvlE4RcGSsXT
        OEkhXe6CsrO8USnYe8kmi1JtaImSw27aM
X-Received: by 2002:aa7:d814:0:b0:506:9701:8436 with SMTP id v20-20020aa7d814000000b0050697018436mr3928492edq.16.1681676392498;
        Sun, 16 Apr 2023 13:19:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350b+Rx8aYCm1+2MZmFymKF7qHzMlh5iqmEBr7hABMtGp1cN0/0bG3sAD9IZSP+SnHgtLZmAN+Q==
X-Received: by 2002:aa7:d814:0:b0:506:9701:8436 with SMTP id v20-20020aa7d814000000b0050697018436mr3928477edq.16.1681676392105;
        Sun, 16 Apr 2023 13:19:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7ccc2000000b004c2158e87e6sm4878686edt.97.2023.04.16.13.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 13:19:51 -0700 (PDT)
Message-ID: <3eb3de24-41b4-9566-9b11-a12d21904793@redhat.com>
Date:   Sun, 16 Apr 2023 22:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/6] iio: st_sensors: Add lsm303d support
To:     Marius Hoch <mail@mariushoch.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230415231130.115094-1-mail@mariushoch.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230415231130.115094-1-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marius,

On 4/16/23 01:11, Marius Hoch wrote:
> Hi!
> 
> This patch series adds support for the LSM303D accelerometer and
> magnetometer. As the LSM303D is basically, as far as I can tell,
> the LSM9DS0 without gyroscope, we can easily re-use its definitions.
> 
> This was tested on a Lenovo Yoga Tablet 2 1051-F.

Thank you for your work on this. I have had this on my own todo list
since 2020 at least and I did not realize that Andy already added ST IMU
support in 2021 so this just needed some extra device-ids :)

I have tested this successfully on the following models:

Lenovo Yoga Tablet 2 851F (Windows version 8")

This version needs an accel-mount-matrix quick in hwdb since it has
a portrait screen rather then a landscape screen (so 90° rotated):
https://github.com/systemd/systemd/pull/27295
Note I've made sure that this quirk only applies to the 851 and not to the 1051.

Lenovo Yoga Tablet 2  830F (Android version 8")

Since the ACPI tables are broken in the Android BIOS these need
a patch to x86-android-tablets to instantiate the i2c_client
for the sensor, I'm still finalizing this patch and I'll submit
it upstream when its finished.

Tested-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


p.s.

1: I noticed that auto-screen rotation using iio-sensor-proxy is quite slow
so I wrote a patch to fix this :)   :
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/366

2: There are some other unsupported sensors on these models too,
perhaps you are interested in adding support for these too?

Here are my personal notes on this:
 -Light sensor should work with drivers/iio/light/al3320a.c
  https://github.com/JideTechnology/remixos-kernel/commit/c52d55b4bd907e87b7b115b3943219f3e089a77a

 -MXM1120 HALL sensor, have datasheet, measures angle of kickstand thingie, use
  for SW_TABLET_MODE. Do a pdx86 driver just for the Tab 2 which checks that the
  kick stand is out *and* the BT keyboard is paired, in that case report
  SW_TABLET_MODE=0, in all other cases report SW_TABLET_MODE=1 ??
  For the commit msg:
  Datasheet available here: http://haechitech.com/tech-support/
  Requires creating an account, once you have an account you can immediately download
  the provided datasheets (or let me know if you want me to email you a copy)

Especially the light sensor should be an easy win and light sensors
are already supported in e.g. iio-sensor-proxy










> Changes in v3:
> Simplified the ACPI tables in the LSM9DS0 IMU driver, per Jonathan Cameron.
> 
> Marius Hoch (6):
>   iio: accel: st_accel: Add LSM303D
>   iio: magnetometer: st_accel: Add LSM303D
>   iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
>   iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU
>     driver
>   iio: Comment that the LSM303D also has the Magnetometer DRDY
>   dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
> 
>  .../devicetree/bindings/iio/st,st-sensors.yaml       |  1 +
>  drivers/iio/accel/st_accel_core.c                    |  1 +
>  drivers/iio/imu/st_lsm9ds0/Kconfig                   |  3 ++-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c          | 12 ++++++++++++
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c          | 12 ++++++++++++
>  drivers/iio/magnetometer/st_magn_core.c              |  1 +
>  include/linux/iio/common/st_sensors.h                |  1 +
>  include/linux/platform_data/st_sensors_pdata.h       |  2 +-
>  8 files changed, 31 insertions(+), 2 deletions(-)
> 
> 
> base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d

