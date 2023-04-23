Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE76EBF2B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDWLsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDWLsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A09170A;
        Sun, 23 Apr 2023 04:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8430B61330;
        Sun, 23 Apr 2023 11:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B10DC433EF;
        Sun, 23 Apr 2023 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682250518;
        bh=hErTz5t9x0AM8g4QeFoVm2oxdxsrHJy+stuvEPuj/0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=od2z6hYNvjZlcY0vM55hBTc6hfuLkxbWcIhAMu7H1iFAVGVcbeBCucaSrXXOxfI5L
         3TtghdAROcUnzO09mYkqrVG8QjRvHfN3CD+R7fIHF1TDQBIGctWJ5GyGsDP7739bTg
         hEqB+LCZQOjzQ0Fp8Z7XPwPKGA2tgrso/1MOotAF4ZzuRPTMPAIkYLKg9atJscXj2m
         S7YK9Fws2iLZzEa/ozamCV1pDR7OO2Z9qIz/ngAHKI/9ev+1NgleCmlIEXgCvgNUns
         UeH5tn5hCV/SeMwoo2SC91Ka7rNVwQt2/wMzaNzTOsCzkLVOjI8hA3b8cKzETdqp/U
         S7xD7pZJ1FotA==
Date:   Sun, 23 Apr 2023 13:04:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] Support ROHM BU27008 RGB sensor
Message-ID: <20230423130413.73960299@jic23-huawei>
In-Reply-To: <cover.1682067567.git.mazziesaccount@gmail.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 12:37:30 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add support for ROHM BU27008 RGB sensor.
> 
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> This series supports reading the RGBC and IR channels using IIO
> frameeork. However, only two of the BC+IR can be enabled at the same

framework

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

Hmm. I'm not sure preventing it is the best approach.  That makes for an
interface that is perhaps even less intuitive than having it affect the
scales of the other channels.  Still having it configurable at all is
optional from an ABI point of view, so we could go with what you have
here and see if anyone shouts about it in future.

Jonathan

> 
> Finally, the scales_available is also provided for all other channels
> except the IR channel, which does not allow the scale to be changed.
> 
> The sensor provides a data-ready IRQ and the driver implements a
> triggered buffer mode using this IRQ as a trigger.
> 
> ---
> 
> Matti Vaittinen (3):
>   dt-bindings: iio: light: ROHM BU27008
>   iio: light: ROHM BU27008 color sensor
>   MAINTAINERS: Add ROHM BU27008
> 
>  .../bindings/iio/light/rohm-bu27008.yaml      |   49 +
>  MAINTAINERS                                   |    3 +-
>  drivers/iio/light/Kconfig                     |   14 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/rohm-bu27008.c              | 1028 +++++++++++++++++
>  5 files changed, 1094 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
>  create mode 100644 drivers/iio/light/rohm-bu27008.c
> 
> 
> base-commit: 52cc189b4fc6af6accc45fe7b7053d76d8724059

