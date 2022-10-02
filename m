Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919B5F2373
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJBN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJBN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7532B91;
        Sun,  2 Oct 2022 06:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63255B80D31;
        Sun,  2 Oct 2022 13:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897D1C433C1;
        Sun,  2 Oct 2022 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664719016;
        bh=YF4OVbnB9hzRJnIWJLAOYnGD8RwPg/JYl59+Nox2ao8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APKOMb73H16T4v6RELKk2SVdyPtc3sBbH8Zrei+IE9X+o7aCnOaWW/9g++kq5DBwA
         hXE5uCMN0d/L9PoSXp/z0nQVbQlwnvGm4RDe1MeBvuGz4sYyRXS4jk2hFtLgHou8jc
         M+plTVFqC31zxaHq0TcS5lwIY7AeKwte2jwSrkgV7NE5eQvI0i7KHQJRCwjjkPCWY9
         tzNTg2LNZs68IkAlYLGWCsZ34sAxuMVA+bhI7wDz2KTNV/JRbf3cBLTv8ZvcSpBiD4
         lxEFip93DkwZepsZ/5Xlit2UHNKwevdrHkSDtAovppNIvMb0LBHJqLPFKs8uPsw5hL
         4m+05kvY4ddrA==
Date:   Sun, 2 Oct 2022 14:57:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: Re: [RFT PATCH v2 2/2] iio: Fix unsafe buffer attributes
Message-ID: <20221002145644.16db3aec@jic23-huawei>
In-Reply-To: <614bb5336c2922578da60a43570f42018623557a.1664610071.git.mazziesaccount@gmail.com>
References: <cover.1664610071.git.mazziesaccount@gmail.com>
        <614bb5336c2922578da60a43570f42018623557a.1664610071.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 10:44:23 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The iio_triggered_buffer_setup_ext() was changed by
> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> to silently expect that all attributes given in buffer_attrs array are
> device-attributes. This expectation was not forced by the API - and some
> drivers did register attributes created by IIO_CONST_ATTR().
> 
> The added attribute "wrapping" does not copy the pointer to stored
> string constant and when the sysfs file is read the kernel will access
> to invalid location.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")

Hi Matti,

This feels like we are doing too much in one go.
I would start with fixes for each individual driver, then once those are in we
come around again and do the refactor.

So for the first patch set (one per driver) just siwtch to yor new
dev_attr but still use a struct attribute * array.
Second series then does the refactor so we don't introduce any new instances
in future. More churn but the code to backport is more tightly confined.

Thanks,

Jonathan

> 
> ---
> 
> v1 => v2:
> fix also industrialio-buffer-dmaengine.c and cros_ec_sensors_core.c
> 
> The fix is only superficially tested by a ROHM/kionix KX022A driver.
> Proper testing with real in-tree IIO stuff is _highly_ appreciated.

