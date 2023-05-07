Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED26F98AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEGNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC75150CD;
        Sun,  7 May 2023 06:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E5560ED3;
        Sun,  7 May 2023 13:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B702C433EF;
        Sun,  7 May 2023 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683466470;
        bh=qeewV7R2Z6nha4ADLSckFtdAh5rT3VHQDSGqNbrAmF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oe66ZkrC46pqwo1MLneM2Lgjvke8ZaBe57WVLloxiMR/ZYTbmu2U+c1GWxeWNL+Tc
         heWZUvoYZwl5oy6cBnfFcmmK3kQBe5ZdTty5CoTh7b0WAiDR+u2rlvyP2sshvIlWQx
         hQpKP4FZFqbZU2BqudKUkTG+lGz4HNgRA+08gWSeFadinMqtKUsLQzgftVTtds39HB
         0H9Es7Rg84zVxivOIwBjok3WbrslfBMCKwZI4lYLG/yiqTp32AD2VBUsguiC4+CDcL
         ufS+sZ1Im8ypAT6CXHUYe6EkwEy6ViYAu4675Xi3Hl+HVBeOn0zIs1rktXOGldvL2R
         qWx1I0DzCfAiA==
Date:   Sun, 7 May 2023 14:50:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <marius@mariushoch.de>
Subject: Re: [PATCH v3 4/6] iio: st_sensors: Add ACPI support for lsm303d to
 the LSM9DS0 IMU driver
Message-ID: <20230507145022.1465b89d@jic23-huawei>
In-Reply-To: <e669d656-1474-ad95-4667-3a6ae79605e3@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
        <20230415231130.115094-5-mail@mariushoch.de>
        <e669d656-1474-ad95-4667-3a6ae79605e3@mariushoch.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 16:51:42 +0200
Marius Hoch <mail@mariushoch.de> wrote:

> Hi,
> 
> On 16/04/2023 01:11, Marius Hoch wrote:
> <snip>
> > diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> > index 997b5ff792be..55f3738193af 100644
> > --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> > +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> > @@ -37,6 +37,12 @@ static const struct spi_device_id st_lsm9ds0_id_table[] = {
> >   };
> >   MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
> >   
> > +static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
> > +	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
> > +
> >   static const struct regmap_config st_lsm9ds0_regmap_config = {
> >   	.reg_bits	= 8,
> >   	.val_bits	= 8,
> > @@ -72,6 +78,7 @@ static struct spi_driver st_lsm9ds0_driver = {
> >   	.driver = {
> >   		.name = "st-lsm9ds0-spi",
> >   		.of_match_table = st_lsm9ds0_of_match,
> > +		.acpi_match_table = st_lsm9ds0_acpi_match,
> >   	},
> >   	.probe = st_lsm9ds0_spi_probe,
> >   	.id_table = st_lsm9ds0_id_table,  
> I just realized that these changes (the SPI ones, not the I2C ones) are 
> entirely superfluous, and I'm not sure why I added this in the first 
> place. In the Lenovo Yoga Tablet 2 series (which seem to be the only 
> devices exposing this as "ACCL0001"), the device is accessible via I2C. 
> Just to make sure, I re-tested the patch chain without this change.
> 
> @Jonathan: Shall I upload an entirely new patch set (v4), do this in a 
> separate new clean up commit, or do you want to just drop these changes 
> to drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c? I'm fine with any of 
> these options.

I'll drop it and push out a new version of the togreg tree.

Thanks for pointing this out.

Jonathan

> 
> Cheers,
> Marius

