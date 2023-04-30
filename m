Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98B6F29D8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjD3RNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3RNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA27F125;
        Sun, 30 Apr 2023 10:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B7060B8A;
        Sun, 30 Apr 2023 17:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B8C433D2;
        Sun, 30 Apr 2023 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682874790;
        bh=OIvDQm0vhvXudrMvZb9IGJnC32d5e2xrPDotj5b2xMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGM/fXh4bnTksGkLmlUXIUyIkpIy0nH/ZEMvJ+ICH8IL2dCX8zJUMK8yyW7E7u8V9
         Td7VI0qBYFfylcao6j1S74gIx1FBidAxKEB2BfIXdxrNHXTIM90tvV/HOSRFYHvnon
         VC0iqz6F/ae5NOcuxjefXFmedWxRhWrTjEnTc93BTC87NOMiyKcKbxu+6Z5S+x5buC
         rPYg/DAPsZTdcyzgJnEtbO41u7tGkcKfgGE4Jb3xH/jVabOV7XnPBw5ARRMp8ueUGB
         IvUUs2WRxnziQRhvK69oAK8dcobVPT/Plkz5WnRu+wYgvSlMqXIrc9V1YqcpNDT8WQ
         mPDdnLyHn05Lw==
Date:   Sun, 30 Apr 2023 18:28:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v3 0/2] Support for Texas Instruments OPT4001 Ambient
 Light Sensor
Message-ID: <20230430182855.1ce2ad65@jic23-huawei>
In-Reply-To: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
References: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
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

On Wed, 26 Apr 2023 13:57:28 +0200
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com> wrote:

> This series adds support for Texas Instruments OPT4001 Ambient light sensor.
> 
> The light sensor has a i2c interface and supports continuous, oneshot and
> interruptdriven measurements and has configurable conversion time and range.
> 
> This driver uses the sensors continuous mode so it always has a updated light
> value available. The conversion time which is
>  (integration time + time to set registers) which is used to configure
> integration time through sysfs. The chip also has a configurable light
> range which this driver sets to Auto where the chip chooses range itself
> depending on previously read values.
> 
> Since the OPT4001 has different constants used to calculate lux values
> depeding on packaging of the chip but uses the same device id, two compatible
> string are used depending on the packaging, these are "ti,opt4001-picostar"
> and "ti,opt4001-sot-5x3".
> 
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Hi Stefan,

No need to sign off on cover letters.  They don't go in the git logs so
if doesn't matter either way.

Otherwise, looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
take a look at it.

Note I'll be rebasing that branch on rc1 once available.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Removed unneccesary description from devicetree
> - Use correct subject prefix for devicetree bindings
> - No error on device id miss match
> - Removed opt4001_settings as there was only one needed property int_time
> - Link to v2: https://lore.kernel.org/r/20230323-add-opt4001-driver-v2-0-0bae0398669d@axis.com
> 
> Changes in v2:
> - Added text about differences of sot-5x3 and picostar
> - Added irq and regulator to devicetree bindings
> - Added regulator support to driver
> - Switched from using .remove to devm_action_or_reset
> - Removed own mutex and reenabled regmaps
> - Updated name in sysfs
> - Added i2c_device_id
> - Rename package_const to chip_info
> - Link to v1: https://lore.kernel.org/r/20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com
> 
> ---
> Stefan Windfeldt-Prytz (2):
>       dt-bindings: iio: light: Document TI OPT4001 light sensor
>       iio: light: Add support for TI OPT4001 light sensor
> 
>  .../devicetree/bindings/iio/light/ti,opt4001.yaml  |  68 +++
>  drivers/iio/light/Kconfig                          |  11 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/opt4001.c                        | 467 +++++++++++++++++++++
>  4 files changed, 547 insertions(+)
> ---
> base-commit: 60c5238813fdfbe167eb579d58172106916b8db0
> change-id: 20230323-add-opt4001-driver-99b9aad69319
> 
> Best regards,

