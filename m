Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6F662C86
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjAIRTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjAIRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:19:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E32C60CC;
        Mon,  9 Jan 2023 09:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6B68CE10B2;
        Mon,  9 Jan 2023 17:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38656C433F0;
        Mon,  9 Jan 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673284777;
        bh=k98eTFMnCh2bl+CHsBnGrUnv2E5uAoeU3YRVbWMwWaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oj3KFgt+El/gXk/L3K/Q4dyuhC1AhwOyyrzH1+p+Id0Lnzwr0vPSL02+pdhzGX2WI
         l5Lt6HTLBhLiMTJVRKdUxz7/yRkEgXinUOX/KQEv7ITnpaBSx95V3ymKpPFiVhW7cs
         JlkP3doH5GOWov0gbR8id7VKH9xDbN96qpQ3IogXcE/xJHdv7mugvKvMKjjrcsEV8v
         36T3lJE57ts8OTJRzxhpOEtMflhw6QvOdYTEED6PzR0mWGn2yePCBX5o5dj3u1Mssz
         8OwKqBunSIfAYByoiiKdRoBdRqMLsxmhF9aSLgb7wOv5FuyYJeswRj5wUlhn4lgsVe
         F4Qvfg9fdDwRQ==
Date:   Mon, 9 Jan 2023 17:19:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, andy.shevchenko@gmail.com,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] Add a multicolor LED driver for groups of
 monochromatic LEDs
Message-ID: <Y7xMogUbXCFktH65@google.com>
References: <20230102081021.138648-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230102081021.138648-1-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023, Jean-Jacques Hiblot wrote:
> Some HW design implement multicolor LEDs with several monochromatic LEDs.
> Grouping the monochromatic LEDs allows to configure them in sync and use
> the triggers.
> The PWM multicolor LED driver implements such grouping but only for
> PWM-based LEDs. As this feature is also desirable for the other types of
> LEDs, this series implements it for any kind of LED device.

Another for Pavel.
 
> changes v6->v7:
>  - in led_mcg_probe() increment the counter at the end of the loop for
>    clarity.
> 
> changes v5->v6:
>  - restore sysfs access to the leds when the device is removed
> 
> changes v4->v5:
>  - Use "depends on COMPILE_TEST || OF" in Kconfig to indicate that OF
>    is a functional requirement, not just a requirement for the
>    compilation.
>  - in led_mcg_probe() check if devm_of_led_get_optional() returns an
>    error before testing for the end of the list.
>  - use sysfs_emit() instead of sprintf() in color_show().
>  - some grammar fixes in the comments and the commit logs.
> 
> changes v2->v3, only minor changes:
>  - rephrased the Kconfig descritpion
>  - make the sysfs interface of underlying LEDs read-only only if the probe
>    is successful.
>  - sanitize the header files
>  - removed the useless call to dev_set_drvdata()
>  - use dev_fwnode() to get the fwnode to the device.
> 
> changes v1->v2:
>  - Followed Rob Herrings's suggestion to make the dt binding much simpler.
>  - Added a patch to store the color property of a LED in its class
>    structure (struct led_classdev).
> 
> 
> Jean-Jacques Hiblot (6):
>   devres: provide devm_krealloc_array()
>   leds: class: simplify the implementation of devm_of_led_get()
>   leds: provide devm_of_led_get_optional()
>   leds: class: store the color index in struct led_classdev
>   dt-bindings: leds: Add binding for a multicolor group of LEDs
>   leds: Add a multicolor LED driver to group monochromatic LEDs
> 
>  Documentation/ABI/testing/sysfs-class-led     |   9 +
>  .../bindings/leds/leds-group-multicolor.yaml  |  64 +++++++
>  drivers/leds/led-class.c                      |  65 +++++--
>  drivers/leds/rgb/Kconfig                      |  10 ++
>  drivers/leds/rgb/Makefile                     |   1 +
>  drivers/leds/rgb/leds-group-multicolor.c      | 166 ++++++++++++++++++
>  include/linux/device.h                        |  13 ++
>  include/linux/leds.h                          |   3 +
>  8 files changed, 317 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>  create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
> 
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
