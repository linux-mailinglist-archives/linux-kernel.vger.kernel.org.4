Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2352F70A92A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjETQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE31121;
        Sat, 20 May 2023 09:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C69D60F78;
        Sat, 20 May 2023 16:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF5C433D2;
        Sat, 20 May 2023 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684600232;
        bh=99kybXVVak92KXWTW8T86FBan8p8JbXRhODDLorI754=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PiMSHrkNfmVzqhJFiTqexamm1jVb0xJ81UqPn0BT343IQPdPlrXWgBfTjDkLw0RMz
         o3oQhd8I6X+RITRt8jS7FAwp2+ufn90mQ9s7waHa2ITw70IMA3FIUsGBULkBnIIn/0
         EUHO2inStIJoocmScKlTX4jBkBY7DjDxicy/+TCPDBRIdTBVRvmwLkCIROWNwL9XQ4
         V8vTiRL8NCsrjWqf3sjOBki46OKqboHvda9t70Kyrs34nw+JTCzSz28tIZLU6UIv9i
         ExHGa4WPHhuxEbtXRfL+JHpQCl5f9ff81+IVLg551Jcy5CnjfLBAKcp81W03Xtlnyc
         HPCl7L7UOTNyw==
Date:   Sat, 20 May 2023 17:46:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <20230520174641.162d9027@jic23-huawei>
In-Reply-To: <cover.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 13:30:28 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add support for ROHM BU27008 RGB sensor.

Series applied to the togreg branch of iio.git and pushed out initially
as testing for all the normal reasons.

Thanks,

Jonathan
> 
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> This series supports reading the RGBC and IR channels using IIO
> framework. However, only two of the BC+IR can be enabled at the same
> time. Series adds also support for scale and integration time
> configuration, where scale consists of impact of both the integration
> time and hardware gain. The gain and time support is backed by the newly
> introduced IIO GTS helper. This series depends on GTS helper patches
> added in BU27034 support series which is already merged in iio/togreg
> which this series is based on.
> 
> The hardware allows configuring gain setting by writing a 5-bit gain
> selector value to a register. Part of the gain setting is common for all
> channels (RGBC + IR) but part of the selector value can be set
> separately for RGBC and IR:
> 
> MODE_CONTROL2 REG:
> bit 7	    6	    5	    4	    3	    2	    1	    0
> -----------------------------------------------------------------
> |	RGB	selector		|
> +---------------------------------------+
> -----------------------------------------------------------------
> | high bits IR	|			| low bits IR selector	|
> +---------------+			+-----------------------+
> 
> In theory it would be possible to set certain separate gain values for
> RGBC and IR channels, but this gets pretty confusing because there are a
> few 'unsupported' selector values. If only RGBC or IR was set, some
> extra handling should be done to prevent the other channel from getting
> unsupported value due to change in high-bits. Furthermore, allowing the
> channels to be set different gain values (in some cases when gains are
> such the HW supports it) would make the cases where also integration
> time is changed to achieve correct scale ... interesting. It might also
> be confusing for user to try predicting when setting different scales
> succeeds and when it does not. Furthermore, if for example the scale
> setting for RGBC caused IR selector to be invalid - it could also cause
> the IR scale to "jump" very far from previous value.
> 
> To make the code simpler and more predictable for users, the current
> logic is as follows:
> 
> 1. Prevent setting IR scale. (My assumption is IR is less used than
> RGBC)
> 2. When RGBC scale is set, set also the IR-selector to the same value.
> This prevents unsupported selector values and makes the IR scale changes
> predictable.
> 
> The 2) could mean we effectively have the same scale for all channels.
> Unfortunately, the HW design is slightly peculiar and selector 0 means
> gain 1X on RGBC but gain 2X on IR. Rest of the selectors equal same gain
> values on RGBC and IR. The result is that while changin selector from 0
> => 1 causes RGBC gain to go from 1X => 4X, it causes IR gain to go from  
> 2X => 4X.
> 
> So, the driver provides separate scale entries for all channels (also
> RGB and C will have separate gain entries because these channels are of
> same type as IR channel). This makes it possible for user applications
> to go read the scales for all channels after setting scale for one (in
> order to detect the IR scale difference).
> 
> Having the separate IR scale entry which applications can read to detect
> "arbitrary scale changes" makes it possible for applications to be
> written so they can cope if we need to implement the 'allow setting some
> different gains for IR and RGBC' - later.
> 
> Finally, the scales_available is also provided for all other channels
> except the IR channel, which does not allow the scale to be changed.
> 
> The sensor provides a data-ready IRQ and the driver implements a
> triggered buffer mode using this IRQ as a trigger.
> 
> Finally, the series introduces generic iio_validate_own_trigger() helper
> which can be used as a validate_trigger callback for drivers which
> require the trigger and iio-device to be parented by same device. The
> KX022A driver is converted to use this new callback instead of rolling
> it's own function. The new helper and KX022A can be merged in as
> independent changes if need be.
> 
> 
> Revision history
> v3 => v4:
>   iio_validate_own_trigger:
>     - kernel-doc fix
>   bu27008 driver fixes:
>     - re-enable IRQ in trigger renable-callback
>     - do trigger setup on own function
>     - drop regmap lock
>     - configure channels in appropriate callback
> v3 => v4:
>   bu27008 driver fixes:
>     - Drop thread from device IRQ handler
>     - Styling and some minor improvements
>     - Use kernel-doc for enums
>     - Correctly order entries in Makefile
> v2 => v3:
>   dt-bindings:
>     - No changes
>   iio_validate_own_trigger:
>     - subject fix
>   bu27008:
>     - Mostly styling based on comments from Andy and Andi
> 
>   More accurate changelog in individual patches
> 
> v1 => v2:
>   dt-bindings:
>     - Fix issues pointed by Krzysztof.
>   bu27008 driver:
>     - Fix issues pointed by Jonathan
>   Add new helper for validating own trigger
> 
>   More accurate changelog in individual patches
> 
> ---
> 
> Matti Vaittinen (5):
>   dt-bindings: iio: light: ROHM BU27008
>   iio: trigger: Add simple trigger_validation helper
>   iio: kx022a: Use new iio_validate_own_trigger()
>   iio: light: ROHM BU27008 color sensor
>   MAINTAINERS: Add ROHM BU27008
> 
>  .../bindings/iio/light/rohm,bu27008.yaml      |   49 +
>  MAINTAINERS                                   |    3 +-
>  drivers/iio/accel/kionix-kx022a.c             |   13 +-
>  drivers/iio/industrialio-trigger.c            |   22 +-
>  drivers/iio/light/Kconfig                     |   14 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/rohm-bu27008.c              | 1026 +++++++++++++++++
>  include/linux/iio/trigger.h                   |    1 +
>  8 files changed, 1115 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
>  create mode 100644 drivers/iio/light/rohm-bu27008.c
> 

