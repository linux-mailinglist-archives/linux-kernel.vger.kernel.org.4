Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1574BE6F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGHQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094021B5;
        Sat,  8 Jul 2023 09:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E3B560D3E;
        Sat,  8 Jul 2023 16:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F6C433C7;
        Sat,  8 Jul 2023 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688833424;
        bh=A99StwgY1zVXF+35oUPoJCWd4DIdXY+XY+Fo3IdGtGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plJOZS8ECyGooTXfwF7IOYvuuOWM1+09HRUTTotfwfuvmTHIAq8kADJQi4FyKUR1Z
         +OOdRQLXZmBpLAB4Yvad49q6DDJhg5x6ueoQTqa/teoi8P5qo5yYOKbTJYxVRD2KGH
         PZ3pM+liDaluVVK0Dd4SlyCli46Zyh9MFX6qU/AQ5wm7nlYe8TYUQ55R6vSn6bq1I8
         I4IQCfiUszMuaeZ9OxuOGhGzEmyUWttsQXgeNhIEVv3rZXz44VBalFmRPRtGLWWQNW
         wonaGj3XLW/CdjgvmshixOSCm9aiahcCNE7Awt18SdrwNXnv6uu2eDHTPWGz4M/Wbz
         IxfR2cIppiRUw==
Date:   Sat, 8 Jul 2023 17:23:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230708172336.79e68a0f@jic23-huawei>
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 12:22:33 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hello everyone,
> 
> Version 6 for adding support for the kx132-1211 accelerometer
> 
> KX132-1211 accelerometer is a sensor which:
> 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> 	- can be connected to I2C or SPI
> 	- has internal HW FIFO buffer
> 	- supports various ODRs (output data rates)
> 
> The KX132-1211 accelerometer is very similar to the KX022A. 
> One key difference is number of bits to report the number of data bytes that 
> have been stored in the buffer: 8 bits for KX022A vs 10 bits for
> KX132-1211.
> 
Just though I'd say that the series looks fine to me. I'm just waiting
on reply to Matti's query on the last patch before applying it.

Thanks,

Jonathan


> Changes in v6:
> - check for availability of chip_info for the SPI case
> - changed the order of elements in the kx022a_data struct to save memory
> 
> Changes in v5:
> - moved the "kfree" call to match the reverse of what happens in 
>   kx022a_fifo_enable() as suggested by Matti and Jonathan
> - used min_t, checked for availability of chip_info and moved the
>   position of u16 buf_smp_lvl_mask as suggested by Andy
> - introduced buf_smp_lvl_mask in Patch 7 as suggested by Jonathan
> 
> Changes in v4:
> - moved the allocation of the fifo_buffer to kx022a_fifo_enable and
>   kx022a_fifo_disable
> - some fixes to the regmap ranges of kx132-1211 
> 
> Changes in v3:
> - added two new patches by separating the addition of the 
>   i2c_device_id table and the removal of blank lines from other
>   unrelated changes
> - fixes a warning detected by the kernel test robot
> - made all the changes related the chip_info in one patch
> 
> Changes in v2:
> - added a new patch for warning when the device_id match fails in the
>   probe function
> - added a new patch for the function that retrieves the number of bytes
>   in the buffer
> - added a change to the Kconfig file in the patch adding the support
>   for the kx132-1211
> - various fixes and modifications listed under each patch
> 
> Mehdi Djait (7):
>   dt-bindings: iio: Add KX132-1211 accelerometer
>   iio: accel: kionix-kx022a: Remove blank lines
>   iio: accel: kionix-kx022a: Warn on failed matches and assume
>     compatibility
>   iio: accel: kionix-kx022a: Add an i2c_device_id table
>   iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
>   iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
>     in buffer
>   iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
> 
>  .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
>  drivers/iio/accel/Kconfig                     |   8 +-
>  drivers/iio/accel/kionix-kx022a-i2c.c         |  24 +-
>  drivers/iio/accel/kionix-kx022a-spi.c         |  15 +-
>  drivers/iio/accel/kionix-kx022a.c             | 312 ++++++++++++++----
>  drivers/iio/accel/kionix-kx022a.h             | 110 +++++-
>  6 files changed, 406 insertions(+), 75 deletions(-)
> 

