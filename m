Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1326EE512
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjDYP5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjDYP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF26C17A;
        Tue, 25 Apr 2023 08:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3DC62F86;
        Tue, 25 Apr 2023 15:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC6DC433EF;
        Tue, 25 Apr 2023 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682438258;
        bh=KcEPijgDMdf9nIE4sARugIAJD7IOSpJYhKwFnLJ3HO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hzj48BJD7HDVIcCpfUAUlKgOQpEObIOdSRuNksz8vCQ1nOnYUAGrvLUym8/OUEMzj
         Ih+eGIDjtCiX8nISHz2EVQ/+iE2otHFIBlXsNdYXOW6v6RJolKIoKdf8BEUgvfOZa9
         67uhMXFemFrfr6MSBdF/hJmkDFA8dXeNxj620oLBGIRXFuWpcbwejz+ilygabxrwXy
         k8pXvk3Up/uYnD05ZvKTdjV6mWT624P/u6dBx4OTG3s5VEFnIV/8AYpeUPn7Tdtupw
         c0sWU3EHpdiOclNtXkVpwdT6pl+swQk4CrWwoLQslxB6qu84KEy/5QdIHpV+Mh6qZh
         M4+PR51atzXTA==
Date:   Tue, 25 Apr 2023 17:57:34 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

On Tue, Apr 25, 2023 at 12:22:25AM +0200, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.

Could you please split this in different patches? Add id in one
patch and refactor in a different patch. Please, also the
refactorings need to be split.

I see here that this is a general code cleanup, plus some other
stuff.

[...]

> @@ -22,22 +23,28 @@ static int kx022a_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	chip_info = device_get_match_data(&spi->dev);
> +	if (!chip_info) {
> +		const struct spi_device_id *id = spi_get_device_id(spi);
> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;

you don't need the cast here... if you don't find it messy, I
wouldn't mind this form... some hate it, I find it easier to
read:

	chip_info = spi_get_device_id(spi)->driver_data;

your choice.

Andi
