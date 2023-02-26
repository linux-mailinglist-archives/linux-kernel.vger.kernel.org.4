Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8946A32BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBZQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:14:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525412F22;
        Sun, 26 Feb 2023 08:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 508C3B8068F;
        Sun, 26 Feb 2023 16:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBB0C433EF;
        Sun, 26 Feb 2023 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677428036;
        bh=5/57UEcb5hG9jxwvefMki3lHxSul0hVg5oqN1Je/dZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UIK+gnCV61PqBXjO2M7vmcVY5Inm9YoV1DElXe8YsumvjQgcFGAqAHWibA/3Jz/Su
         n4gurzDK0pGcScd7LmYjpD7qvShML8XjVBvNsisI5ansX0mxonogMyQMf8FhQCCdag
         5T89MJcBbLlcObqgh/FASwv8DHowHMDRy8w+0058DQdSZgY+wRIGYz87jjNPGK79v0
         DpKjhDQNoZKmSBrqhQ9noQKjkPiryIDD5oS9281xBMfCcXm5v3qsblMpydmn1U6/Hc
         I/M6iyhUibJ7V871Anzbwx06DOki8ozaIa/6H11Nhv+wnoQ6EsJnz10pDyOgKn0fKk
         byCDQs0ivyY8Q==
Date:   Sun, 26 Feb 2023 16:28:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Support ROHM BU27034 ALS sensor
Message-ID: <20230226162819.37df158c@jic23-huawei>
In-Reply-To: <cover.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 18:13:43 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BU27034 ALS sensor
> 
> This series adds support for ROHM BU27034 Ambient Light Sensor.
> 
> The BU27034 has configurable gain and measurement (integration) time
> settings. Both of these have direct, inversely proportional relation to
> the sensor's intensity channel scale.
> 
> Many users only set the scale, which means that many drivers attempt to
> 'guess' the best gain+time combination to meet the scale. Usually this
> is the biggest integration time which allows setting the requested
> scale. Typically, increasing the integration time has better accuracy
> than increasing the gain, which often amplifies the noise as well as the
> real signal.
> 
> However, there may be cases where more responsive sensors are needed.
> So, in some cases the longest integration times may not be what the user
> prefers. The driver has no way of knowing this.
> 
> Hence, the approach taken by this series is to allow user to set both
> the scale and the integration time with following logic:
> 
> 1. When scale is set, the existing integration time is tried to be
>    maintained as a first priority.
>    1a) If the requested scale can't be met by current time, then also
>        other time + gain combinations are searched. If scale can be met
>        by some other integration time, then the new time may be applied.
>        If the time setting is common for all channels, then also other
>        channels must be able to maintain their scale with this new time
>        (by changing their gain). The new times are scanned in the order
>        of preference (typically the longest times first).
>    1b) If the requested scale can be met using current time, then only
>        the gain for the channel is changed.
> 
> 2. When the integration time change - scale is maintained.
>    When integration time change is requested also gain for all impacted
>    channels is adjusted so that the scale is not changed. If gain can't
>    be changed for some channel, then the request is rejected.
> 
> I think this fits the existing 'modes' where scale setting 'guesses' the
> best scale + integration time config - and integration time setting does
> not change the scale.
> 
> This logic is really simple. When total gain (either caused by time or
> hw-gain) is doubled, the scale gets halved. Also, the supported times
> are given a 'multiplier' value which tells how much they increase the
> total gain. However, when I wrote this logic in bu27034 driver, I made
> quite a few errors on the way - and driver got pretty big. As I am
> writing drivers for two other sensors (RGB C/IR + flicker BU27010 and RGB
> C/IR BU27008) with similar gain-time-scale logic I thought that adding
> common helpers for these computations might be wise. I hope this way all
> the bugs will be concentrated in one place and not in every individual
> driver ;) Hence, this RFC also intriduces IIO gain-time-scale helpers +
> couple of KUnit tests for the most hairy parts.
> 
> I can't help thinking that there should've been simpler way of computing
> the gain-time-scale conversions. Also, pretty good speed improvements
> might be available if some of the do_div()s could be replaced by >>.
> This, however, is not a priority for my light-sensor use-case where
> speed demands are not that big. I am open to all improvements and
> suggestions though!

I wouldn't worry too much on performance as we hopefully aren't doing this
often or in fast paths.

> 
> What is still missing is advertising the available scales / integration
> times. The list of available integration times is not static but depend
> on channel gain configurations. Hence, I wonder if there is a way to
> not only advertise available integration times with current gain
> configuration - but also the available scales with different gains?

We may want to just keep going for 'best match' rather than ruling out any
particular integration time. If the scale can't be maintained - change it.
That way if someone really wants to change the integration time they get
to pick up the pieces and deal with the fact the scaling just changed.

That's how we typically handle really nasty interacting choices where
we can't do the stuff you've done here because there isn't an obvious
'right' answer.

> 
> Finally, this patch series is an RFC becasue the helper logic could
> benefit from extra pairs of eyes - and because the sensor has been
> only very limitedly tested this far.
> 
> 
> Matti Vaittinen (6):
>   dt-bindings: iio: light: Support ROHM BU27034
>   iio: light: Add gain-time-scale helpers
>   iio: test: test gain-time-scale helpers
>   MAINTAINERS: Add IIO gain-time-scale helpers
>   iio: light: ROHM BU27034 Ambient Light Sensor
>   MAINTAINERS: Add ROHM BU27034
> 
>  .../bindings/iio/light/rohm-bu27034.yaml      |   46 +
>  MAINTAINERS                                   |   13 +
>  drivers/iio/light/Kconfig                     |   16 +
>  drivers/iio/light/Makefile                    |    2 +
>  drivers/iio/light/gain-time-scale-helper.c    |  446 ++++++
>  drivers/iio/light/gain-time-scale-helper.h    |  111 ++
>  drivers/iio/light/rohm-bu27034.c              | 1212 +++++++++++++++++
>  drivers/iio/test/Kconfig                      |   15 +
>  drivers/iio/test/Makefile                     |    1 +
>  drivers/iio/test/iio-test-gts.c               |  331 +++++
>  10 files changed, 2193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu27034.yaml
>  create mode 100644 drivers/iio/light/gain-time-scale-helper.c
>  create mode 100644 drivers/iio/light/gain-time-scale-helper.h
>  create mode 100644 drivers/iio/light/rohm-bu27034.c
>  create mode 100644 drivers/iio/test/iio-test-gts.c
> 
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

