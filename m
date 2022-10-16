Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4F5FFEE3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJPLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJPLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426263DF00;
        Sun, 16 Oct 2022 04:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E79EA60A54;
        Sun, 16 Oct 2022 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E45C433D6;
        Sun, 16 Oct 2022 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665918854;
        bh=hIeR0HjC/MFtqIOCqjFNizhJMZwtz0fSkbUOXk7wnmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NkmdpPVSMBptLWUOcjeMi0SObz1Amo9AEWB0YE7rrZKz5TaDhnmpHZaM8IXX6KDDf
         cPe8wNxZry6rdepcnEX4Ocpur/ecNRXrRa/hfcVJe2T5jKXde/XD2cWngNbsoPd6Vl
         uuabzsgFAcd+bfT+dCveGJlCHIYzU0S8vouZtVI++LA32ItCVUFZkltGbaGfM5SRAc
         GAksFqGvuCCdm2VC7cxqHVaCsz/VkwbFKaklsO2/8vdsZo3P7K3SutAnfNwv4YyLjC
         UMDglvVIEK+QjWFmZGGW3Cb/WJBFFZenRwjoGh1GBvwj1xyX4DdUKOWUK3RXY1dt80
         q2N3oPTMXtd2g==
Date:   Sun, 16 Oct 2022 12:14:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <mazziesaccount@gmail.com>, <matti.vaittinen@fi.rohmeurope.com>,
        <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] iio: at91-sama5d2_adc: Fix unsafe buffer
 attributes
Message-ID: <20221016121441.5e792a52@jic23-huawei>
In-Reply-To: <2d150d6d-17bb-3e18-3174-e769f4cc8417@microchip.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <be69775aa302159f088b8b91894e6ec449bca65b.1664782676.git.mazziesaccount@gmail.com>
        <2d150d6d-17bb-3e18-3174-e769f4cc8417@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 08:34:17 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 03.10.2022 11:11, Matti Vaittinen wrote:
> > The iio_triggered_buffer_setup_ext() was changed by
> > commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> > to silently expect that all attributes given in buffer_attrs array are
> > device-attributes. This expectation was not forced by the API - and some
> > drivers did register attributes created by IIO_CONST_ATTR().
> > 
> > The added attribute "wrapping" does not copy the pointer to stored
> > string constant and when the sysfs file is read the kernel will access
> > to invalid location.
> > 
> > Change the IIO_CONST_ATTRs from the driver to IIO_DEVICE_ATTR in order
> > to prevent the invalid memory access.
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")  
> 
> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> on SAMA5D2
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

For the reset of the series I'll need to wait for these first 4 patches to make their
way to upstream of the togreg branch then queue the rest up on top of that.

Jonathan

> 

