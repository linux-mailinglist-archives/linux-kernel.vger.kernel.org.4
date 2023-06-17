Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4F73430F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjFQSbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFQSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770371999;
        Sat, 17 Jun 2023 11:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFE1560F35;
        Sat, 17 Jun 2023 18:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3DFC433C0;
        Sat, 17 Jun 2023 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687026656;
        bh=6hrbYsQQgXYfdajRygxvYG4WDgbYQYtHSRvAvrjQrwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fwMwpaypVk1gmDLklBfADvYqfttlaOmqiwt/IWQrUOs7o4T0Vzcyh5/GOy3dXuo2X
         I/xqcC04lgHBY1ibGeNnq/aEyB3mOEiKcxchp57R2vi2ZQgySkYztVUPigmQnMxy5F
         w+PKv8QUjlOqTxZb4jrw3CwUIIXs+vbyhzrE5OGHnZ+AuxCpVh7SJt4KDXM44hJVbK
         /xAmaUO346Te9wfrUJm+T1C7V4iUUCIVUtwxGhNk6leIT4cIBJo3VNsUiR04LpRlpi
         CjdQXogpsaK4gb1zbx/TU4uzrUNu9F3cJ+bMDXaCzQsYNJl8g18O0jiXTaitKtlfre
         SpCpD65Bkgb5w==
Date:   Sat, 17 Jun 2023 19:30:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kim Seer Paller <kimseer.paller@analog.com>, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: max14001: New driver
Message-ID: <20230617193049.21d0ff1b@jic23-huawei>
In-Reply-To: <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
References: <20230614004857.134980-1-kimseer.paller@analog.com>
        <20230614004857.134980-2-kimseer.paller@analog.com>
        <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 12:11:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 14, 2023 at 3:49=E2=80=AFAM Kim Seer Paller
> <kimseer.paller@analog.com> wrote:
> >
> > The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs. =20
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> One question below.
>=20
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> > V5 -> V6: Replaced fixed length assignment with dynamic size
> > assignment in xfers struct initialization. Removed .channel
> > assignment in max14001_channels definition.
> > V4 -> V5: No changes.
> > V3 -> V4: Removed regmap setup, structures, and include.
> >
> >  MAINTAINERS                |   1 +
> >  drivers/iio/adc/Kconfig    |  10 ++
> >  drivers/iio/adc/Makefile   |   1 +
> >  drivers/iio/adc/max14001.c | 327 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 339 insertions(+)
> >  create mode 100644 drivers/iio/adc/max14001.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dcea2c31f920..b527cf471d7a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12676,6 +12676,7 @@ L:      linux-iio@vger.kernel.org
> >  S:     Supported
> >  W:     https://ez.analog.com/linux-software-drivers
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > +F:     drivers/iio/adc/max14001.c
> >
> >  MAXBOTIX ULTRASONIC RANGER IIO DRIVER
> >  M:     Andreas Klinger <ak@it-klinger.de>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index eb2b09ef5d5b..e599d166e98d 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -706,6 +706,16 @@ config MAX11410
> >           To compile this driver as a module, choose M here: the module=
 will be
> >           called max11410.
> >
> > +config MAX14001
> > +       tristate "Analog Devices MAX14001 ADC driver"
> > +       depends on SPI
> > +       help
> > +         Say yes here to build support for Analog Devices MAX14001 Con=
figurable,
> > +         Isolated 10-bit ADCs for Multi-Range Binary Inputs.
> > +
> > +         To compile this driver as a module, choose M here: the module=
 will be
> > +         called max14001.
> > +
> >  config MAX1241
> >         tristate "Maxim max1241 ADC driver"
> >         depends on SPI_MASTER
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index e07e4a3e6237..9f8964258f03 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX11100) +=3D max11100.o
> >  obj-$(CONFIG_MAX1118) +=3D max1118.o
> >  obj-$(CONFIG_MAX11205) +=3D max11205.o
> >  obj-$(CONFIG_MAX11410) +=3D max11410.o
> > +obj-$(CONFIG_MAX14001) +=3D max14001.o
> >  obj-$(CONFIG_MAX1241) +=3D max1241.o
> >  obj-$(CONFIG_MAX1363) +=3D max1363.o
> >  obj-$(CONFIG_MAX9611) +=3D max9611.o
> > diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> > new file mode 100644
> > index 000000000000..b4d10539398b
> > --- /dev/null
> > +++ b/drivers/iio/adc/max14001.c
> > @@ -0,0 +1,327 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Analog Devices MAX14001 ADC driver
> > + *
> > + * Copyright 2023 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitrev.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +/* MAX14001 Registers Address */
> > +#define MAX14001_ADC                   0x00
> > +#define MAX14001_FADC                  0x01
> > +#define MAX14001_FLAGS                 0x02
> > +#define MAX14001_FLTEN                 0x03
> > +#define MAX14001_THL                   0x04
> > +#define MAX14001_THU                   0x05
> > +#define MAX14001_INRR                  0x06
> > +#define MAX14001_INRT                  0x07
> > +#define MAX14001_INRP                  0x08
> > +#define MAX14001_CFG                   0x09
> > +#define MAX14001_ENBL                  0x0A
> > +#define MAX14001_ACT                   0x0B
> > +#define MAX14001_WEN                   0x0C
> > +
> > +#define MAX14001_VERIFICATION_REG(x)   ((x) + 0x10)
> > +
> > +#define MAX14001_CFG_EXRF              BIT(5)
> > +
> > +#define MAX14001_ADDR_MASK             GENMASK(15, 11)
> > +#define MAX14001_DATA_MASK             GENMASK(9, 0)
> > +#define MAX14001_FILTER_MASK           GENMASK(3, 2)
> > +
> > +#define MAX14001_SET_WRITE_BIT         BIT(10)
> > +#define MAX14001_WRITE_WEN             0x294
> > +
> > +struct max14001_state {
> > +       struct spi_device       *spi;
> > +       /*
> > +        * lock protect against multiple concurrent accesses, RMW seque=
nce, and
> > +        * SPI transfer
> > +        */
> > +       struct mutex            lock;
> > +       int                     vref_mv;
> > +       /*
> > +        * DMA (thus cache coherency maintenance) requires the
> > +        * transfer buffers to live in their own cache lines.
> > +        */
> > +       __be16                  spi_tx_buffer __aligned(IIO_DMA_MINALIG=
N);
> > +       __be16                  spi_rx_buffer;
> > +};
> > +
> > +static int max14001_read(void *context, unsigned int reg_addr, unsigne=
d int *data)
> > +{
> > +       struct max14001_state *st =3D context;
> > +       int ret;
> > +
> > +       struct spi_transfer xfers[] =3D {
> > +               {
> > +                       .tx_buf =3D &st->spi_tx_buffer,
> > +                       .len =3D sizeof(st->spi_tx_buffer),
> > +                       .cs_change =3D 1,
> > +               }, {
> > +                       .rx_buf =3D &st->spi_rx_buffer,
> > +                       .len =3D sizeof(st->spi_rx_buffer),
> > +               },
> > +       };
> > +
> > +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_=
ADDR_MASK,
> > +                                                               reg_add=
r)));
> > +
> > +       ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +       if (ret)
> > +               return ret;
> > +
> > +       *data =3D bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_D=
ATA_MASK;
> > +
> > +       return 0;
> > +}
> > +
> > +static int max14001_write(void *context, unsigned int reg_addr, unsign=
ed int data)
> > +{
> > +       struct max14001_state *st =3D context;
> > +
> > +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(
> > +                       FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) |
> > +                       FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> > +                       FIELD_PREP(MAX14001_DATA_MASK, data)));
> > +
> > +       return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx=
_buffer));
> > +}
> > +
> > +static int max14001_write_verification_reg(struct max14001_state *st,
> > +                                               unsigned int reg_addr)
> > +{
> > +       unsigned int reg_data;
> > +       int ret;
> > +
> > +       ret =3D max14001_read(st, reg_addr, &reg_data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return max14001_write(st, MAX14001_VERIFICATION_REG(reg_addr), =
reg_data);
> > +}
> > +
> > +static int max14001_reg_update(struct max14001_state *st,
> > +                               unsigned int reg_addr,
> > +                               unsigned int mask,
> > +                               unsigned int val)
> > +{
> > +       int ret;
> > +       unsigned int reg_data;
> > +
> > +       /* Enable SPI Registers Write */
> > +       ret =3D max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_read(st, reg_addr, &reg_data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       reg_data =3D FIELD_PREP(mask, val);
> > +
> > +       ret =3D max14001_write(st, reg_addr, reg_data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Write Verification Register */
> > +       ret =3D max14001_write_verification_reg(st, reg_addr);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Disable SPI Registers Write */
> > +       return max14001_write(st, MAX14001_WEN, 0);
> > +}
> > +
> > +static int max14001_read_raw(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            int *val, int *val2, long mask)
> > +{
> > +       struct max14001_state *st =3D iio_priv(indio_dev);
> > +       unsigned int data;
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               mutex_lock(&st->lock);
> > +               ret =3D max14001_read(st, MAX14001_ADC, &data);
> > +               mutex_unlock(&st->lock);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               *val =3D data;
> > +
> > +               return IIO_VAL_INT;
> > +
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val =3D st->vref_mv;
> > +               *val2 =3D 10;
> > +
> > +               return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info max14001_info =3D {
> > +       .read_raw =3D max14001_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec max14001_channels[] =3D {
> > +       {
> > +               .type =3D IIO_VOLTAGE,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE),
> > +       }
> > +};
> > +
> > +static void max14001_regulator_disable(void *data)
> > +{
> > +       struct regulator *reg =3D data;
> > +
> > +       regulator_disable(reg);
> > +}
> > +
> > +static int max14001_init(struct max14001_state *st)
> > +{
> > +       int ret;
> > +
> > +       /* Enable SPI Registers Write */
> > +       ret =3D max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * Reads all registers and writes the values back to their appr=
opriate
> > +        * verification registers to clear the Memory Validation fault.
> > +        */
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_FLTEN);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_THL);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_THU);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_INRR);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_INRT);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_INRP);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_CFG);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D max14001_write_verification_reg(st, MAX14001_ENBL);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Disable SPI Registers Write */
> > +       return max14001_write(st, MAX14001_WEN, 0);
> > +}
> > +
> > +static int max14001_probe(struct spi_device *spi)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct max14001_state *st;
> > +       struct regulator *vref;
> > +       struct device *dev =3D &spi->dev;
> > +       int ret;
> > +
> > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st =3D iio_priv(indio_dev);
> > +       st->spi =3D spi;
> > +
> > +       indio_dev->name =3D "max14001";
> > +       indio_dev->info =3D &max14001_info;
> > +       indio_dev->channels =3D max14001_channels;
> > +       indio_dev->num_channels =3D ARRAY_SIZE(max14001_channels);
> > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +       ret =3D max14001_init(st);
> > +       if (ret)
> > +               return ret;
> > +
> > +       vref =3D devm_regulator_get_optional(dev, "vref");
> > +       if (IS_ERR(vref)) {
> > +               if (PTR_ERR(vref) !=3D -ENODEV)
> > +                       return dev_err_probe(dev, PTR_ERR(vref),
> > +                                            "Failed to get vref regula=
tor");
> > +
> > +               /* internal reference */
> > +               st->vref_mv =3D 1250;
> > +       } else {
> > +               ret =3D regulator_enable(vref);
> > +               if (ret)
> > +                       return dev_err_probe(dev, ret,
> > +                                       "Failed to enable vref regulato=
rs\n");
> > +
> > +               ret =3D devm_add_action_or_reset(dev, max14001_regulato=
r_disable,
> > +                                              vref);
> > +               if (ret)
> > +                       return ret; =20
>=20
> > +               /* select external voltage reference source for the ADC=
 */
> > +               ret =3D max14001_reg_update(st, MAX14001_CFG,
> > +                                         MAX14001_CFG_EXRF, 1);
> > +

ret not checked.

> > +               ret =3D regulator_get_voltage(vref);
> > +               if (ret < 0)
> > +                       return dev_err_probe(dev, ret,
> > +                                            "Failed to get vref\n"); =
=20
>=20
> Is it important to choose the external reference source _before_
> getting the voltage of the regulator? If not, I would swap these
> calls, otherwise the comment is needed to explain why the sequence is
> important in the way it's written.
>=20
> > +               st->vref_mv =3D ret / 1000;
> > +       }
> > +
> > +       mutex_init(&st->lock);
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id max14001_of_match[] =3D {
> > +       { .compatible =3D "adi,max14001" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, max14001_of_match);
> > +
> > +static struct spi_driver max14001_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "max14001",
> > +               .of_match_table =3D max14001_of_match,
> > +       },
> > +       .probe =3D max14001_probe,
> > +};
> > +module_spi_driver(max14001_driver);
> > +
> > +MODULE_AUTHOR("Kim Seer Paller");
> > +MODULE_DESCRIPTION("MAX14001 ADC driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> > =20
>=20
>=20

