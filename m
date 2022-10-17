Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05CF601D83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJQXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJQXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:20:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4A5FDFD;
        Mon, 17 Oct 2022 16:20:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g1so19931505lfu.12;
        Mon, 17 Oct 2022 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=hPjgbmyufVQcQ6EQc4g+TbLptg1Ow4K6/gfkQdTeaBk=;
        b=B6/s8a/izQ/nkmMWEUBSlIGceBkIBbBxCyoJTZIZiQ0RsBeQpu80tBqNYIL6+R0eo4
         kO7PHZUKpbPz32g5uarTU10cBEqaYSR7oy8OCNyYfyMzL0RDWirFs7ZGZPtjwXDezgNK
         yF+Aamf5c4G7Tuf2Gs1fq+lbqkuZz9i7b7dC8WvOLXV0B1uqiL5DKnRphq34xw31RkKe
         VzGu/Vn4LF7mOtoQ/8q+TYY8C5KoGgWLMNwXOQK6dT4clhITPAgRnuVOdKGJCP/7ji+n
         ma5WEj2lBjg3tlq+dkpen1j0SSl/TVaoW38fSOgE3GfkV1x1DF65kOtMNR2poiBYNUn4
         2jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPjgbmyufVQcQ6EQc4g+TbLptg1Ow4K6/gfkQdTeaBk=;
        b=bt3hsB9PX4uquSPRIkTswhzSpvcR69Gw1cno6DmWLeFOS2gjodH1EyyYm6mNeE1/Iy
         LnPQh7JTPrHweKnlYhfhKkb/ANSAuxWEmZDcj829zRFVBoTMz+f4L0iGoJbYGjx2S9EB
         T76AV3SuM2dt5Jf5V0r43V5I5FsemJ/Nus5WY7zKATrCJB7h3KNJErmYh6iY4Zu61qwQ
         oBhlYDlhewObOrYFvUYk8b2I7Jh40lCRnapprXYjDPKTGveXf0ibIMjjCUf93yoLzZAr
         LNjmoPKpL6XbNsEyeCqQUw1rMPQaqEP91hOur4/nLECf9YUrm1pzm+YejyN/L3/jrS3A
         4kcg==
X-Gm-Message-State: ACrzQf0Fj4XOnucFxZkCYDJNwVm1QoLP/0D4m/mQ8lWEecNjP9ux7se0
        LbC1PMsMNn+xwcT87KxRdZTTkBobCTtyZA==
X-Google-Smtp-Source: AMsMyM4pCX+WNfC/CXNNsawWuYBaaZwuLJ/RgrcmgBhzoQzrC1lLwHLEE9fH6Fy3w2jJM3+OHQ32FQ==
X-Received: by 2002:a05:6000:184e:b0:22e:4612:496d with SMTP id c14-20020a056000184e00b0022e4612496dmr56928wri.91.1666047969456;
        Mon, 17 Oct 2022 16:06:09 -0700 (PDT)
Received: from localhost (94.197.37.182.threembb.co.uk. [94.197.37.182])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4b02000000b0022ed6ff3a96sm9371634wrq.39.2022.10.17.16.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:06:08 -0700 (PDT)
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
 <20221017184419.62d365c1@jic23-huawei>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lee.jones@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        michael@walle.cc, samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Add support for AXP192 PMIC
Date:   Mon, 17 Oct 2022 23:21:32 +0100
In-reply-to: <20221017184419.62d365c1@jic23-huawei>
Message-ID: <LYfRwE3pxZfgZBDC6gwvsSrHWqcSQXHK@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <jic23@kernel.org> writes:

> On Mon, 17 Oct 2022 00:43:22 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> This series adds support for the AXP192 PMIC to the AXP20x MFD driver
>> framework, including support for regulators, ADCs, and AC/USB/battery
>> power supplies.
>>
>> v6 is a resend of v5 from July -- the patches haven't changed at all
>> but I've rebased them on the latest git master branch.
>
> Hi Aidan,
>
> Lee has recently expressed that he keen to take as much of these sorts
> of series as possible via the various subsystem trees.
>
> As such, it is useful to call out in the cover letter of such a series
> if this can be done.  For example, patch 9 (last IIO one) can't be
> applied without defines in patch 6 (I think).  Thus I'm assuming Lee
> will do an immutable branch with at least those patches on it.
>
> Perhaps worth expressing if that is also the case for the power
> and regulator subsystem patches?
>
> Thanks,
>
> Jonathan

Yep, the IIO, regulator, and power subsystem patches all depend on
the MFD patch. Specifically, patches 6, 9, and 10 depend on patch 5.
I can't get rid of this dependency because the variant ID (AXP192_ID)
has to be defined centrally in the MFD patch.

The axp20x_battery patches (last three of the whole series) don't
depend on the variant ID or other defines, so they could be taken
independently through the power subsystem.

Even though the IIO cleanups (7 and 8) don't depend on anything else
I imagine it'd cause problems to take those via IIO because patch 9
depends on them.

IOW: Lee probably needs to take patches 5-10.

- Aidan

>>
>> Aidan MacDonald (13):
>>   dt-bindings: mfd: add bindings for AXP192 MFD device
>>   dt-bindings: iio: adc: axp209: Add AXP192 compatible
>>   dt-bindings: power: supply: axp20x: Add AXP192 compatible
>>   dt-bindings: power: axp20x-battery: Add AXP192 compatible
>>   mfd: axp20x: Add support for AXP192
>>   regulator: axp20x: Add support for AXP192
>>   iio: adc: axp20x_adc: Minor code cleanups
>>   iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
>>   iio: adc: axp20x_adc: Add support for AXP192
>>   power: supply: axp20x_usb_power: Add support for AXP192
>>   power: axp20x_battery: Add constant charge current table
>>   power: axp20x_battery: Support battery status without fuel gauge
>>   power: axp20x_battery: Add support for AXP192
>>
>>  .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
>>  .../bindings/mfd/x-powers,axp152.yaml         |   1 +
>>  .../x-powers,axp20x-battery-power-supply.yaml |   1 +
>>  .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>>  drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
>>  drivers/mfd/axp20x-i2c.c                      |   2 +
>>  drivers/mfd/axp20x.c                          | 141 +++++++
>>  drivers/power/supply/axp20x_battery.c         | 142 ++++++-
>>  drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
>>  drivers/regulator/axp20x-regulator.c          | 100 ++++-
>>  include/linux/mfd/axp20x.h                    |  84 +++++
>>  11 files changed, 856 insertions(+), 74 deletions(-)
>>
