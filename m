Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E039874E912
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGKI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjGKI1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A819A8;
        Tue, 11 Jul 2023 01:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AC561389;
        Tue, 11 Jul 2023 08:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8C9C433C8;
        Tue, 11 Jul 2023 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689064019;
        bh=PCKozz0+7V4ZjKYNb9oGgbtQkCXocWxACK9gad1/ew0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgKZ/3ltDT50I2i4sWUJpP9HQB+iUVXHq/JwaCVx2oAgIzz7YY2iD2kze4L44Hy0A
         +Mba7Lh5rlZXoaJrCdLc8sagL5LNW6fT2P7+IAcCPDkdPi9YJqH7510VErP2cadCWV
         mG5XGIgYPr/dbFm/CLJQuSAWd5g4hdL9QArcKZO/xj6e+Rxo/frkJ123IfgbX7Xw8+
         O9KfT6O2YCzrvK9WZcDjxa/+M371EVCyygUg7rvN3LfOU+/3+TG4z40lFO69XMXjHX
         eofCQ+KAyMsr0LbxZFzOTzjDnLNkBfNfgJi37YXf87VbkPuFe7Nvkp4iyiF5DTCWkI
         GsL9LvD2XeCGg==
Date:   Tue, 11 Jul 2023 09:26:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 08/15] spi: Clean up headers
Message-ID: <da48f031-d93b-4a30-bad6-f80f58b35853@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pIeIB6/zdeGPnfkv"
Content-Disposition: inline
In-Reply-To: <20230710154932.68377-9-andriy.shevchenko@linux.intel.com>
X-Cookie: Do not use if foil seal is broken.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pIeIB6/zdeGPnfkv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:49:25PM +0300, Andy Shevchenko wrote:
> There is a few things done:
> - include only the headers we are direct user of
> - when pointer is in use, provide a forward declaration
> - add missing headers
> - group generic headers and subsystem headers
> - sort each group alphabetically

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/gpio/gpio-xra1403.c: In function =E2=80=98xra140=
3_probe=E2=80=99:
/build/stage/linux/drivers/gpio/gpio-xra1403.c:161:22: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
  161 |         reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset", =
GPIOD_OUT_LOW);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/gpio/gpio-xra1403.c:161:66: error: =E2=80=98GPIO=
D_OUT_LOW=E2=80=99 undeclared (first use in this function)
  161 |         reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset", =
GPIOD_OUT_LOW);
      |                                                                  ^~=
~~~~~~~~~~~
/build/stage/linux/drivers/gpio/gpio-xra1403.c:161:66: note: each undeclare=
d identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[5]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/gpio/g=
pio-xra1403.o] Error 1
make[5]: Target 'drivers/gpio/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/gpio] =
Error 2
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c: In function =E2=
=80=98byt_wm5102_spkvdd_power_event=E2=80=99:
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c:46:9: error: impli=
cit declaration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
   46 |         gpiod_set_value_cansleep(priv->spkvdd_en_gpio,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c: In function =E2=
=80=98snd_byt_wm5102_mc_probe=E2=80=99:
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c:421:32: error: imp=
licit declaration of function =E2=80=98gpiod_get=E2=80=99; did you mean =E2=
=80=98bio_get=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  421 |         priv->spkvdd_en_gpio =3D gpiod_get(codec_dev, "wlf,spkvdd-e=
na", GPIOD_OUT_LOW);
      |                                ^~~~~~~~~
      |                                bio_get
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c:421:71: error: =E2=
=80=98GPIOD_OUT_LOW=E2=80=99 undeclared (first use in this function)
  421 |         priv->spkvdd_en_gpio =3D gpiod_get(codec_dev, "wlf,spkvdd-e=
na", GPIOD_OUT_LOW);
      |                                                                    =
   ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c:421:71: note: each=
 undeclared identifier is reported only once for each function it appears in
/build/stage/linux/sound/soc/intel/boards/bytcr_wm5102.c:465:9: error: impl=
icit declaration of function =E2=80=98gpiod_put=E2=80=99; did you mean =E2=
=80=98bio_put=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  465 |         gpiod_put(priv->spkvdd_en_gpio);
      |         ^~~~~~~~~
      |         bio_put
cc1: all warnings being treated as errors
make[7]: *** [/build/stage/linux/scripts/Makefile.build:243: sound/soc/inte=
l/boards/bytcr_wm5102.o] Error 1
make[7]: Target 'sound/soc/intel/boards/' not remade because of errors.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:477: sound/soc/inte=
l/boards] Error 2
make[6]: Target 'sound/soc/intel/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: sound/soc/inte=
l] Error 2
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c: In function =E2=
=80=98ssd130x_spi_write=E2=80=99:
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c:38:17: error: impl=
icit declaration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-W=
error=3Dimplicit-function-declaration]
   38 |                 gpiod_set_value_cansleep(t->dc, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c: In function =E2=
=80=98ssd130x_spi_probe=E2=80=99:
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c:70:14: error: impl=
icit declaration of function =E2=80=98devm_gpiod_get=E2=80=99; did you mean=
 =E2=80=98em_pd_get=E2=80=99? [-Werror=3Dimplicit-function-declaration]
   70 |         dc =3D devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
      |              ^~~~~~~~~~~~~~
      |              em_pd_get
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c:70:40: error: =E2=
=80=98GPIOD_OUT_LOW=E2=80=99 undeclared (first use in this function)
   70 |         dc =3D devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
      |                                        ^~~~~~~~~~~~~
/build/stage/linux/drivers/gpu/drm/solomon/ssd130x-spi.c:70:40: note: each =
undeclared identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[7]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/gpu/dr=
m/solomon/ssd130x-spi.o] Error 1
make[7]: Target 'drivers/gpu/drm/solomon/' not remade because of errors.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/gpu/dr=
m/solomon] Error 2
/build/stage/linux/drivers/net/ethernet/asix/ax88796c_main.c: In function =
=E2=80=98ax88796c_hard_reset=E2=80=99:
/build/stage/linux/drivers/net/ethernet/asix/ax88796c_main.c:950:22: error:=
 implicit declaration of function =E2=80=98gpiod_get=E2=80=99; did you mean=
 =E2=80=98guid_gen=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  950 |         reset_gpio =3D gpiod_get(dev, "reset", 0);
      |                      ^~~~~~~~~
      |                      guid_gen
/build/stage/linux/drivers/net/ethernet/asix/ax88796c_main.c:950:20: error:=
 assignment to =E2=80=98struct gpio_desc *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
  950 |         reset_gpio =3D gpiod_get(dev, "reset", 0);
      |                    ^
/build/stage/linux/drivers/net/ethernet/asix/ax88796c_main.c:957:9: error: =
implicit declaration of function =E2=80=98gpiod_direction_output=E2=80=99 [=
-Werror=3Dimplicit-function-declaration]
  957 |         gpiod_direction_output(reset_gpio, 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/net/ethernet/asix/ax88796c_main.c:960:9: error: =
implicit declaration of function =E2=80=98gpiod_put=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  960 |         gpiod_put(reset_gpio);
      |         ^~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/net/et=
hernet/asix/ax88796c_main.o] Error 1
make[7]: Target 'drivers/net/ethernet/asix/' not remade because of errors.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/net/et=
hernet/asix] Error 2
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c: In functio=
n =E2=80=98td043mtea1_power_on=E2=80=99:
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c:147:9: erro=
r: implicit declaration of function =E2=80=98gpiod_set_value=E2=80=99 [-Wer=
ror=3Dimplicit-function-declaration]
  147 |         gpiod_set_value(lcd->reset_gpio, 0);
      |         ^~~~~~~~~~~~~~~
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c: In functio=
n =E2=80=98td043mtea1_probe=E2=80=99:
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c:438:27: err=
or: implicit declaration of function =E2=80=98devm_gpiod_get=E2=80=99; did =
you mean =E2=80=98em_pd_get=E2=80=99? [-Werror=3Dimplicit-function-declarat=
ion]
  438 |         lcd->reset_gpio =3D devm_gpiod_get(&spi->dev, "reset", GPIO=
D_OUT_HIGH);
      |                           ^~~~~~~~~~~~~~
      |                           em_pd_get
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c:438:62: err=
or: =E2=80=98GPIOD_OUT_HIGH=E2=80=99 undeclared (first use in this function)
  438 |         lcd->reset_gpio =3D devm_gpiod_get(&spi->dev, "reset", GPIO=
D_OUT_HIGH);
      |                                                              ^~~~~~=
~~~~~~~~
/build/stage/linux/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c:438:62: not=
e: each undeclared identifier is reported only once for each function it ap=
pears in
cc1: all warnings being treated as errors
make[7]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/gpu/dr=
m/panel/panel-tpo-td043mtea1.o] Error 1
make[7]: Target 'drivers/gpu/drm/panel/' not remade because of errors.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/gpu/dr=
m/panel] Error 2
/build/stage/linux/drivers/spi/spi-fsl-dspi.c: In function =E2=80=98dspi_as=
sert_cs=E2=80=99:
/build/stage/linux/drivers/spi/spi-fsl-dspi.c:908:9: error: implicit declar=
ation of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  908 |         gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), true);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-fsl-dspi.c: In function =E2=80=98dspi_se=
tup=E2=80=99:
/build/stage/linux/drivers/spi/spi-fsl-dspi.c:1076:9: error: implicit decla=
ration of function =E2=80=98gpiod_direction_output=E2=80=99; did you mean =
=E2=80=98pinctrl_gpio_direction_output=E2=80=99? [-Werror=3Dimplicit-functi=
on-declaration]
 1076 |         gpiod_direction_output(spi_get_csgpiod(spi, 0), false);
      |         ^~~~~~~~~~~~~~~~~~~~~~
      |         pinctrl_gpio_direction_output
cc1: all warnings being treated as errors
make[5]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/spi/sp=
i-fsl-dspi.o] Error 1
make[6]: Target 'drivers/net/ethernet/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/net/et=
hernet] Error 2
/build/stage/linux/drivers/media/i2c/ar0521.c: In function =E2=80=98ar0521_=
power_off=E2=80=99:
/build/stage/linux/drivers/media/i2c/ar0521.c:850:17: error: implicit decla=
ration of function =E2=80=98gpiod_set_value=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
  850 |                 gpiod_set_value(sensor->reset_gpio, 1); /* assert R=
ESET signal */
      |                 ^~~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ar0521.c: In function =E2=80=98ar0521_=
probe=E2=80=99:
/build/stage/linux/drivers/media/i2c/ar0521.c:1114:30: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 1114 |         sensor->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
      |                              ^~~~~~~~~~~~~~~~~~~~~~~
      |                              devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/ar0521.c:1115:54: error: =E2=80=98GPIO=
D_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 1115 |                                                      GPIOD_OUT_HIGH=
);
      |                                                      ^~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ar0521.c:1115:54: note: each undeclare=
d identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/ar0521.o] Error 1
make[6]: Target 'drivers/gpu/drm/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/gpu/dr=
m] Error 2
make[5]: Target 'drivers/gpu/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/gpu] E=
rror 2
/build/stage/linux/drivers/media/i2c/imx334.c: In function =E2=80=98imx334_=
parse_hw_config=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx334.c:1081:30: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 1081 |         imx334->reset_gpio =3D devm_gpiod_get_optional(imx334->dev,=
 "reset",
      |                              ^~~~~~~~~~~~~~~~~~~~~~~
      |                              devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/imx334.c:1082:54: error: =E2=80=98GPIO=
D_OUT_LOW=E2=80=99 undeclared (first use in this function)
 1082 |                                                      GPIOD_OUT_LOW);
      |                                                      ^~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/imx334.c:1082:54: note: each undeclare=
d identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/imx334.c: In function =E2=80=98imx334_=
power_on=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx334.c:1176:9: error: implicit decla=
ration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
 1176 |         gpiod_set_value_cansleep(imx334->reset_gpio, 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/imx334.o] Error 1
/build/stage/linux/drivers/media/i2c/imx335.c: In function =E2=80=98imx335_=
parse_hw_config=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx335.c:785:30: error: implicit decla=
ration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean =
=E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decla=
ration]
  785 |         imx335->reset_gpio =3D devm_gpiod_get_optional(imx335->dev,=
 "reset",
      |                              ^~~~~~~~~~~~~~~~~~~~~~~
      |                              devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/imx335.c:786:54: error: =E2=80=98GPIOD=
_OUT_LOW=E2=80=99 undeclared (first use in this function)
  786 |                                                      GPIOD_OUT_LOW);
      |                                                      ^~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/imx335.c:786:54: note: each undeclared=
 identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/imx335.c: In function =E2=80=98imx335_=
power_on=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx335.c:871:9: error: implicit declar=
ation of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  871 |         gpiod_set_value_cansleep(imx335->reset_gpio, 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/imx335.o] Error 1
/build/stage/linux/drivers/media/i2c/imx412.c: In function =E2=80=98imx412_=
parse_hw_config=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx412.c:937:30: error: implicit decla=
ration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean =
=E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decla=
ration]
  937 |         imx412->reset_gpio =3D devm_gpiod_get_optional(imx412->dev,=
 "reset",
      |                              ^~~~~~~~~~~~~~~~~~~~~~~
      |                              devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/imx412.c:938:54: error: =E2=80=98GPIOD=
_OUT_LOW=E2=80=99 undeclared (first use in this function)
  938 |                                                      GPIOD_OUT_LOW);
      |                                                      ^~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/imx412.c:938:54: note: each undeclared=
 identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/imx412.c: In function =E2=80=98imx412_=
power_on=E2=80=99:
/build/stage/linux/drivers/media/i2c/imx412.c:1040:9: error: implicit decla=
ration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
 1040 |         gpiod_set_value_cansleep(imx412->reset_gpio, 0);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/imx412.o] Error 1
make[5]: Target 'drivers/net/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/net] E=
rror 2
/build/stage/linux/drivers/spi/spi-tegra114.c: In function =E2=80=98tegra_s=
pi_setup_transfer_one=E2=80=99:
/build/stage/linux/drivers/spi/spi-tegra114.c:835:25: error: implicit decla=
ration of function =E2=80=98gpiod_set_value=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
  835 |                         gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
      |                         ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/spi/sp=
i-tegra114.o] Error 1
make[5]: Target 'drivers/spi/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/spi] E=
rror 2
make[5]: Target 'sound/soc/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: sound/soc] Err=
or 2
make[4]: Target 'sound/' not remade because of errors.
make[3]: *** [/build/stage/linux/scripts/Makefile.build:477: sound] Error 2
/build/stage/linux/drivers/media/i2c/ov5648.c: In function =E2=80=98ov5648_=
sensor_power=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov5648.c:1878:17: error: implicit decl=
aration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
 1878 |                 gpiod_set_value_cansleep(sensor->reset, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov5648.c: In function =E2=80=98ov5648_=
probe=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov5648.c:2476:29: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 2476 |         sensor->powerdown =3D devm_gpiod_get_optional(dev, "powerdo=
wn",
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
      |                             devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/ov5648.c:2477:53: error: =E2=80=98GPIO=
D_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 2477 |                                                     GPIOD_OUT_HIGH);
      |                                                     ^~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov5648.c:2477:53: note: each undeclare=
d identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/ov5648.o] Error 1
/build/stage/linux/drivers/media/i2c/ov5693.c: In function =E2=80=98ov5693_=
sensor_powerdown=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov5693.c:793:9: error: implicit declar=
ation of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  793 |         gpiod_set_value_cansleep(ov5693->privacy_led, 0);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov5693.c: In function =E2=80=98ov5693_=
configure_gpios=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov5693.c:1317:25: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 1317 |         ov5693->reset =3D devm_gpiod_get_optional(ov5693->dev, "res=
et",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~
      |                         devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/ov5693.c:1318:49: error: =E2=80=98GPIO=
D_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 1318 |                                                 GPIOD_OUT_HIGH);
      |                                                 ^~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov5693.c:1318:49: note: each undeclare=
d identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/ov5693.c:1332:55: error: =E2=80=98GPIO=
D_OUT_LOW=E2=80=99 undeclared (first use in this function)
 1332 |                                                       GPIOD_OUT_LOW=
);
      |                                                       ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/ov5693.o] Error 1
/build/stage/linux/drivers/media/i2c/ov8865.c: In function =E2=80=98ov8865_=
sensor_power=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov8865.c:2403:17: error: implicit decl=
aration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
 2403 |                 gpiod_set_value_cansleep(sensor->reset, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov9282.c: In function =E2=80=98ov9282_=
parse_hw_config=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov9282.c:1129:30: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 1129 |         ov9282->reset_gpio =3D devm_gpiod_get_optional(ov9282->dev,=
 "reset",
      |                              ^~~~~~~~~~~~~~~~~~~~~~~
      |                              devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/ov8865.c: In function =E2=80=98ov8865_=
probe=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov8865.c:2999:29: error: implicit decl=
aration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean=
 =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
 2999 |         sensor->powerdown =3D devm_gpiod_get_optional(dev, "powerdo=
wn",
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
      |                             devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/ov9282.c:1130:54: error: =E2=80=98GPIO=
D_OUT_LOW=E2=80=99 undeclared (first use in this function)
 1130 |                                                      GPIOD_OUT_LOW);
      |                                                      ^~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov9282.c:1130:54: note: each undeclare=
d identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/ov8865.c:3000:53: error: =E2=80=98GPIO=
D_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 3000 |                                                     GPIOD_OUT_HIGH);
      |                                                     ^~~~~~~~~~~~~~
/build/stage/linux/drivers/media/i2c/ov8865.c:3000:53: note: each undeclare=
d identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/ov8865.o] Error 1
/build/stage/linux/drivers/media/i2c/ov9282.c: In function =E2=80=98ov9282_=
power_on=E2=80=99:
/build/stage/linux/drivers/media/i2c/ov9282.c:1238:9: error: implicit decla=
ration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
 1238 |         gpiod_set_value_cansleep(ov9282->reset_gpio, 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/ov9282.o] Error 1
/build/stage/linux/drivers/staging/media/max96712/max96712.c: In function =
=E2=80=98max96712_probe=E2=80=99:
/build/stage/linux/drivers/staging/media/max96712/max96712.c:411:28: error:=
 implicit declaration of function =E2=80=98devm_gpiod_get_optional=E2=80=99=
; did you mean =E2=80=98devm_regulator_get_optional=E2=80=99? [-Werror=3Dim=
plicit-function-declaration]
  411 |         priv->gpiod_pwdn =3D devm_gpiod_get_optional(&client->dev, =
"enable",
      |                            ^~~~~~~~~~~~~~~~~~~~~~~
      |                            devm_regulator_get_optional
/build/stage/linux/drivers/staging/media/max96712/max96712.c:412:52: error:=
 =E2=80=98GPIOD_OUT_HIGH=E2=80=99 undeclared (first use in this function)
  412 |                                                    GPIOD_OUT_HIGH);
      |                                                    ^~~~~~~~~~~~~~
/build/stage/linux/drivers/staging/media/max96712/max96712.c:412:52: note: =
each undeclared identifier is reported only once for each function it appea=
rs in
/build/stage/linux/drivers/staging/media/max96712/max96712.c:416:9: error: =
implicit declaration of function =E2=80=98gpiod_set_consumer_name=E2=80=99 =
[-Werror=3Dimplicit-function-declaration]
  416 |         gpiod_set_consumer_name(priv->gpiod_pwdn, "max96712-pwdn");
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/staging/media/max96712/max96712.c:417:9: error: =
implicit declaration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]
  417 |         gpiod_set_value_cansleep(priv->gpiod_pwdn, 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/stagin=
g/media/max96712/max96712.o] Error 1
make[7]: Target 'drivers/staging/media/max96712/' not remade because of err=
ors.
make[6]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/stagin=
g/media/max96712] Error 2
/build/stage/linux/drivers/media/i2c/tc358746.c: In function =E2=80=98tc358=
746_probe=E2=80=99:
/build/stage/linux/drivers/media/i2c/tc358746.c:1538:32: error: implicit de=
claration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you me=
an =E2=80=98devm_clk_get_optional=E2=80=99? [-Werror=3Dimplicit-function-de=
claration]
 1538 |         tc358746->reset_gpio =3D devm_gpiod_get_optional(dev, "rese=
t",
      |                                ^~~~~~~~~~~~~~~~~~~~~~~
      |                                devm_clk_get_optional
/build/stage/linux/drivers/media/i2c/tc358746.c:1539:56: error: =E2=80=98GP=
IOD_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 1539 |                                                        GPIOD_OUT_HI=
GH);
      |                                                        ^~~~~~~~~~~~=
~~
/build/stage/linux/drivers/media/i2c/tc358746.c:1539:56: note: each undecla=
red identifier is reported only once for each function it appears in
/build/stage/linux/drivers/media/i2c/tc358746.c: In function =E2=80=98tc358=
746_resume=E2=80=99:
/build/stage/linux/drivers/media/i2c/tc358746.c:1637:9: error: implicit dec=
laration of function =E2=80=98gpiod_set_value=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
 1637 |         gpiod_set_value(tc358746->reset_gpio, 1);
      |         ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/media/=
i2c/tc358746.o] Error 1
make[6]: Target 'drivers/media/i2c/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/media/=
i2c] Error 2
make[6]: Target 'drivers/staging/media/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/stagin=
g/media] Error 2
make[5]: Target 'drivers/staging/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/stagin=
g] Error 2
make[5]: Target 'drivers/media/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/media]=
 Error 2
/build/stage/linux/drivers/iio/amplifiers/ada4250.c: In function =E2=80=98a=
da4250_init=E2=80=99:
/build/stage/linux/drivers/iio/amplifiers/ada4250.c:307:25: error: implicit=
 declaration of function =E2=80=98device_property_read_bool=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
  307 |         st->refbuf_en =3D device_property_read_bool(&spi->dev, "adi=
,refbuf-enable");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/addac/ad74413r.c: In function =E2=80=98ad744=
13r_reset=E2=80=99:
/build/stage/linux/drivers/iio/addac/ad74413r.c:413:17: error: implicit dec=
laration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3D=
implicit-function-declaration]
  413 |                 gpiod_set_value_cansleep(st->reset_gpio, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/addac/ad74115.c: In function =E2=80=98ad7411=
5_reset=E2=80=99:
/build/stage/linux/drivers/iio/addac/ad74115.c:1765:22: error: implicit dec=
laration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mea=
n =E2=80=98devm_regulator_get_optional=E2=80=99? [-Werror=3Dimplicit-functi=
on-declaration]
 1765 |         reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      devm_regulator_get_optional
cc1: all warnings being treated as errors
/build/stage/linux/drivers/iio/addac/ad74115.c:1765:60: error: =E2=80=98GPI=
OD_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 1765 |         reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
      |                                                            ^~~~~~~~=
~~~~~~
/build/stage/linux/drivers/iio/addac/ad74115.c:1765:60: note: each undeclar=
ed identifier is reported only once for each function it appears in
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/am=
plifiers/ada4250.o] Error 1
make[6]: Target 'drivers/iio/amplifiers/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/am=
plifiers] Error 2
/build/stage/linux/drivers/iio/addac/ad74413r.c: In function =E2=80=98ad744=
13r_probe=E2=80=99:
/build/stage/linux/drivers/iio/addac/ad74413r.c:1375:26: error: implicit de=
claration of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you me=
an =E2=80=98devm_regulator_get_optional=E2=80=99? [-Werror=3Dimplicit-funct=
ion-declaration]
 1375 |         st->reset_gpio =3D devm_gpiod_get_optional(st->dev, "reset"=
, GPIOD_OUT_LOW);
      |                          ^~~~~~~~~~~~~~~~~~~~~~~
      |                          devm_regulator_get_optional
/build/stage/linux/drivers/iio/addac/ad74413r.c:1375:68: error: =E2=80=98GP=
IOD_OUT_LOW=E2=80=99 undeclared (first use in this function)
 1375 |         st->reset_gpio =3D devm_gpiod_get_optional(st->dev, "reset"=
, GPIOD_OUT_LOW);
      |                                                                    =
^~~~~~~~~~~~~
/build/stage/linux/drivers/iio/addac/ad74413r.c:1375:68: note: each undecla=
red identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
dac/ad74413r.o] Error 1
/build/stage/linux/drivers/iio/addac/ad74115.c:1773:17: error: implicit dec=
laration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3D=
implicit-function-declaration]
 1773 |                 gpiod_set_value_cansleep(reset_gpio, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
dac/ad74115.o] Error 1
make[6]: Target 'drivers/iio/addac/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/ad=
dac] Error 2
/build/stage/linux/drivers/iio/dac/ad3552r.c: In function =E2=80=98ad3552r_=
trigger_hw_ldac=E2=80=99:
/build/stage/linux/drivers/iio/dac/ad3552r.c:521:9: error: implicit declara=
tion of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
  521 |         gpiod_set_value_cansleep(ldac, 0);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c: In function =E2=80=98ad3552r_=
reset=E2=80=99:
/build/stage/linux/drivers/iio/dac/ad3552r.c:661:27: error: implicit declar=
ation of function =E2=80=98devm_gpiod_get_optional=E2=80=99; did you mean =
=E2=80=98devm_regulator_get_optional=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
  661 |         dac->gpio_reset =3D devm_gpiod_get_optional(&dac->spi->dev,=
 "reset",
      |                           ^~~~~~~~~~~~~~~~~~~~~~~
      |                           devm_regulator_get_optional
/build/stage/linux/drivers/iio/dac/ad3552r.c:662:51: error: =E2=80=98GPIOD_=
OUT_LOW=E2=80=99 undeclared (first use in this function)
  662 |                                                   GPIOD_OUT_LOW);
      |                                                   ^~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:662:51: note: each undeclared =
identifier is reported only once for each function it appears in
/build/stage/linux/drivers/iio/dac/ad3552r.c: In function =E2=80=98ad3552r_=
configure_custom_gain=E2=80=99:
/build/stage/linux/drivers/iio/dac/ad3552r.c:810:22: error: implicit declar=
ation of function =E2=80=98fwnode_get_named_child_node=E2=80=99 [-Werror=3D=
implicit-function-declaration]
  810 |         gain_child =3D fwnode_get_named_child_node(child,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:810:20: error: assignment to =
=E2=80=98struct fwnode_handle *=E2=80=99 from =E2=80=98int=E2=80=99 makes p=
ointer from integer without a cast [-Werror=3Dint-conversion]
  810 |         gain_child =3D fwnode_get_named_child_node(child,
      |                    ^
/build/stage/linux/drivers/iio/dac/ad3552r.c:821:15: error: implicit declar=
ation of function =E2=80=98fwnode_property_read_u32=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  821 |         err =3D fwnode_property_read_u32(gain_child, "adi,gain-scal=
ing-p", &val);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:870:9: error: implicit declara=
tion of function =E2=80=98fwnode_handle_put=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
  870 |         fwnode_handle_put(gain_child);
      |         ^~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c: In function =E2=80=98ad3552r_=
configure_device=E2=80=99:
/build/stage/linux/drivers/iio/dac/ad3552r.c:888:63: error: =E2=80=98GPIOD_=
OUT_HIGH=E2=80=99 undeclared (first use in this function)
  888 |         dac->gpio_ldac =3D devm_gpiod_get_optional(dev, "ldac", GPI=
OD_OUT_HIGH);
      |                                                               ^~~~~=
~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:899:21: error: implicit declar=
ation of function =E2=80=98device_property_read_bool=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
  899 |                 if (device_property_read_bool(dev, "adi,vref-out-en=
"))
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:931:15: error: implicit declar=
ation of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  931 |         err =3D device_property_read_u32(dev, "adi,sdo-drive-streng=
th", &val);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:946:23: error: implicit declar=
ation of function =E2=80=98device_get_child_node_count=E2=80=99 [-Werror=3D=
implicit-function-declaration]
  946 |         dac->num_ch =3D device_get_child_node_count(dev);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:952:9: error: implicit declara=
tion of function =E2=80=98device_for_each_child_node=E2=80=99; did you mean=
 =E2=80=98device_for_each_child=E2=80=99? [-Werror=3Dimplicit-function-decl=
aration]
  952 |         device_for_each_child_node(dev, child) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         device_for_each_child
/build/stage/linux/drivers/iio/dac/ad3552r.c:952:47: error: expected =E2=80=
=98;=E2=80=99 before =E2=80=98{=E2=80=99 token
  952 |         device_for_each_child_node(dev, child) {
      |                                               ^~
      |                                               ;
/build/stage/linux/drivers/iio/dac/ad3552r.c:1024:1: error: label =E2=80=98=
put_child=E2=80=99 defined but not used [-Werror=3Dunused-label]
 1024 | put_child:
      | ^~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:886:27: error: unused variable=
 =E2=80=98ch=E2=80=99 [-Werror=3Dunused-variable]
  886 |         u32 vals[2], val, ch;
      |                           ^~
/build/stage/linux/drivers/iio/dac/ad3552r.c:886:13: error: unused variable=
 =E2=80=98vals=E2=80=99 [-Werror=3Dunused-variable]
  886 |         u32 vals[2], val, ch;
      |             ^~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:885:18: error: unused variable=
 =E2=80=98cnt=E2=80=99 [-Werror=3Dunused-variable]
  885 |         int err, cnt =3D 0, voltage, delta =3D 100000;
      |                  ^~~
/build/stage/linux/drivers/iio/dac/ad3552r.c: At top level:
/build/stage/linux/drivers/iio/dac/ad3552r.c:799:12: error: =E2=80=98ad3552=
r_configure_custom_gain=E2=80=99 defined but not used [-Werror=3Dunused-fun=
ction]
  799 | static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:778:12: error: =E2=80=98ad3552=
r_find_range=E2=80=99 defined but not used [-Werror=3Dunused-function]
  778 | static int ad3552r_find_range(u16 id, s32 *vals)
      |            ^~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/dac/ad3552r.c:738:13: error: =E2=80=98ad3552=
r_calc_gain_and_offset=E2=80=99 defined but not used [-Werror=3Dunused-func=
tion]
  738 | static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, =
s32 ch)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/da=
c/ad3552r.o] Error 1
/build/stage/linux/drivers/iio/adc/ad7280a.c: In function =E2=80=98ad7280_p=
robe=E2=80=99:
/build/stage/linux/drivers/iio/adc/ad7280a.c:974:17: error: implicit declar=
ation of function =E2=80=98device_property_read_bool=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
  974 |                 device_property_read_bool(dev, "adi,thermistor-term=
ination");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ad7280a.c:976:13: error: implicit declar=
ation of function =E2=80=98device_property_present=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
  976 |         if (device_property_present(dev, "adi,acquisition-time-ns")=
) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ad7280a.c:979:23: error: implicit declar=
ation of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  979 |                 ret =3D device_property_read_u32(dev, "adi,acquisit=
ion-time-ns", &val);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ad7280a.o] Error 1
/build/stage/linux/drivers/iio/frequency/adf4371.c: In function =E2=80=98ad=
f4371_setup=E2=80=99:
/build/stage/linux/drivers/iio/frequency/adf4371.c:492:13: error: implicit =
declaration of function =E2=80=98device_property_read_bool=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
  492 |         if (device_property_read_bool(&st->spi->dev, "adi,mute-till=
-lock-en")) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/fr=
equency/adf4371.o] Error 1
/build/stage/linux/drivers/iio/adc/ad7606_spi.c: In function =E2=80=98ad760=
6B_sw_mode_config=E2=80=99:
/build/stage/linux/drivers/iio/adc/ad7606_spi.c:261:17: error: implicit dec=
laration of function =E2=80=98gpiod_set_array_value=E2=80=99 [-Werror=3Dimp=
licit-function-declaration]
  261 |                 gpiod_set_array_value(ARRAY_SIZE(os),
      |                 ^~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ad7606_spi.c:262:50: error: invalid use =
of undefined type =E2=80=98struct gpio_descs=E2=80=99
  262 |                                       st->gpio_os->desc, st->gpio_o=
s->info, os);
      |                                                  ^~
/build/stage/linux/drivers/iio/adc/ad7606_spi.c:262:69: error: invalid use =
of undefined type =E2=80=98struct gpio_descs=E2=80=99
  262 |                                       st->gpio_os->desc, st->gpio_o=
s->info, os);
      |                                                                    =
 ^~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ad7606_spi.o] Error 1
/build/stage/linux/drivers/iio/adc/ad7768-1.c: In function =E2=80=98ad7768_=
set_channel_label=E2=80=99:
/build/stage/linux/drivers/iio/adc/ad7768-1.c:552:18: error: implicit decla=
ration of function =E2=80=98dev_fwnode=E2=80=99; did you mean =E2=80=98dev_=
of_node=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  552 |         fwnode =3D dev_fwnode(device);
      |                  ^~~~~~~~~~
      |                  dev_of_node
/build/stage/linux/drivers/iio/adc/ad7768-1.c:552:16: error: assignment to =
=E2=80=98struct fwnode_handle *=E2=80=99 from =E2=80=98int=E2=80=99 makes p=
ointer from integer without a cast [-Werror=3Dint-conversion]
  552 |         fwnode =3D dev_fwnode(device);
      |                ^
/build/stage/linux/drivers/iio/dac/ad5766.c: In function =E2=80=98ad5766_ge=
t_output_range=E2=80=99:
/build/stage/linux/drivers/iio/dac/ad5766.c:500:15: error: implicit declara=
tion of function =E2=80=98device_property_read_u32_array=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
  500 |         ret =3D device_property_read_u32_array(&st->spi->dev,
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ad7768-1.c:553:9: error: implicit declar=
ation of function =E2=80=98fwnode_for_each_child_node=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
  553 |         fwnode_for_each_child_node(fwnode, child) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ad7768-1.c:553:50: error: expected =E2=
=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token
  553 |         fwnode_for_each_child_node(fwnode, child) {
      |                                                  ^~
      |                                                  ;
/build/stage/linux/drivers/iio/adc/ad7768-1.c:550:13: error: unused variabl=
e =E2=80=98crt_ch=E2=80=99 [-Werror=3Dunused-variable]
  550 |         int crt_ch =3D 0;
      |             ^~~~~~
/build/stage/linux/drivers/iio/adc/ad7768-1.c:549:21: error: unused variabl=
e =E2=80=98label=E2=80=99 [-Werror=3Dunused-variable]
  549 |         const char *label;
      |                     ^~~~~
/build/stage/linux/drivers/iio/adc/ad7768-1.c:545:30: error: unused variabl=
e =E2=80=98st=E2=80=99 [-Werror=3Dunused-variable]
  545 |         struct ad7768_state *st =3D iio_priv(indio_dev);
      |                              ^~
/build/stage/linux/drivers/iio/adc/ad7768-1.c:567:1: error: no return state=
ment in function returning non-void [-Werror=3Dreturn-type]
  567 | }
      | ^
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ad7768-1.o] Error 1
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/da=
c/ad5766.o] Error 1
/build/stage/linux/drivers/iio/frequency/admv4420.c: In function =E2=80=98a=
dmv4420_fw_parse=E2=80=99:
/build/stage/linux/drivers/iio/frequency/admv4420.c:194:15: error: implicit=
 declaration of function =E2=80=98device_property_read_u32=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
  194 |         ret =3D device_property_read_u32(dev, "adi,lo-freq-khz", &t=
mp);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/frequency/admv4420.c:198:42: error: implicit=
 declaration of function =E2=80=98device_property_read_bool=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
  198 |         st->ref_block.ref_single_ended =3D device_property_read_boo=
l(dev,
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/fr=
equency/admv4420.o] Error 1
/build/stage/linux/drivers/iio/adc/ad7949.c: In function =E2=80=98ad7949_sp=
i_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/ad7949.c:353:9: error: implicit declarat=
ion of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
  353 |         device_property_read_u32(dev, "adi,internal-ref-microvolt",=
 &tmp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ad7949.o] Error 1
make[6]: Target 'drivers/iio/frequency/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/fr=
equency] Error 2
/build/stage/linux/drivers/iio/pressure/bmp280-spi.c: In function =E2=80=98=
bmp280_spi_probe=E2=80=99:
/build/stage/linux/drivers/iio/pressure/bmp280-spi.c:61:21: error: implicit=
 declaration of function =E2=80=98device_get_match_data=E2=80=99; did you m=
ean =E2=80=98device_match_any=E2=80=99? [-Werror=3Dimplicit-function-declar=
ation]
   61 |         chip_info =3D device_get_match_data(&spi->dev);
      |                     ^~~~~~~~~~~~~~~~~~~~~
      |                     device_match_any
/build/stage/linux/drivers/iio/pressure/bmp280-spi.c:61:19: error: assignme=
nt to =E2=80=98const struct bmp280_chip_info *=E2=80=99 from =E2=80=98int=
=E2=80=99 makes pointer from integer without a cast [-Werror=3Dint-conversi=
on]
   61 |         chip_info =3D device_get_match_data(&spi->dev);
      |                   ^
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/pr=
essure/bmp280-spi.o] Error 1
/build/stage/linux/drivers/iio/proximity/as3935.c: In function =E2=80=98as3=
935_probe=E2=80=99:
/build/stage/linux/drivers/iio/proximity/as3935.c:366:15: error: implicit d=
eclaration of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
  366 |         ret =3D device_property_read_u32(dev,
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/pr=
oximity/as3935.o] Error 1
make[6]: Target 'drivers/iio/proximity/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/pr=
oximity] Error 2
/build/stage/linux/drivers/iio/temperature/ltc2983.c: In function =E2=80=98=
ltc2983_probe=E2=80=99:
/build/stage/linux/drivers/iio/temperature/ltc2983.c:1639:16: error: implic=
it declaration of function =E2=80=98devm_gpiod_get_optional=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
 1639 |         gpio =3D devm_gpiod_get_optional(&st->spi->dev, "reset", GP=
IOD_OUT_HIGH);
      |                ^~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/temperature/ltc2983.c:1639:64: error: =E2=80=
=98GPIOD_OUT_HIGH=E2=80=99 undeclared (first use in this function)
 1639 |         gpio =3D devm_gpiod_get_optional(&st->spi->dev, "reset", GP=
IOD_OUT_HIGH);
      |                                                                ^~~~=
~~~~~~~~~~
/build/stage/linux/drivers/iio/temperature/ltc2983.c:1639:64: note: each un=
declared identifier is reported only once for each function it appears in
/build/stage/linux/drivers/iio/temperature/ltc2983.c:1646:17: error: implic=
it declaration of function =E2=80=98gpiod_set_value_cansleep=E2=80=99 [-Wer=
ror=3Dimplicit-function-declaration]
 1646 |                 gpiod_set_value_cansleep(gpio, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/te=
mperature/ltc2983.o] Error 1
make[6]: Target 'drivers/iio/temperature/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/te=
mperature] Error 2
/build/stage/linux/drivers/iio/dac/max5522.c: In function =E2=80=98max5522_=
spi_probe=E2=80=99:
/build/stage/linux/drivers/iio/dac/max5522.c:147:28: error: implicit declar=
ation of function =E2=80=98device_get_match_data=E2=80=99; did you mean =E2=
=80=98device_match_any=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  147 |         state->chip_info =3D device_get_match_data(&spi->dev);
      |                            ^~~~~~~~~~~~~~~~~~~~~
      |                            device_match_any
/build/stage/linux/drivers/iio/dac/max5522.c:147:26: error: assignment to =
=E2=80=98const struct max5522_chip_info *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
  147 |         state->chip_info =3D device_get_match_data(&spi->dev);
      |                          ^
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/da=
c/max5522.o] Error 1
make[6]: Target 'drivers/iio/dac/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/da=
c] Error 2
/build/stage/linux/drivers/iio/adc/max11205.c: In function =E2=80=98max1120=
5_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/max11205.c:119:25: error: implicit decla=
ration of function =E2=80=98device_get_match_data=E2=80=99; did you mean =
=E2=80=98device_match_any=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
  119 |         st->chip_info =3D device_get_match_data(&spi->dev);
      |                         ^~~~~~~~~~~~~~~~~~~~~
      |                         device_match_any
/build/stage/linux/drivers/iio/adc/max11205.c:119:23: error: assignment to =
=E2=80=98const struct max11205_chip_info *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
  119 |         st->chip_info =3D device_get_match_data(&spi->dev);
      |                       ^
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/max11205.o] Error 1
/build/stage/linux/drivers/iio/adc/max11410.c: In function =E2=80=98max1141=
0_parse_channels=E2=80=99:
/build/stage/linux/drivers/iio/adc/max11410.c:707:18: error: implicit decla=
ration of function =E2=80=98device_get_child_node_count=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
  707 |         num_ch =3D device_get_child_node_count(dev);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:723:9: error: implicit declar=
ation of function =E2=80=98device_for_each_child_node=E2=80=99; did you mea=
n =E2=80=98device_for_each_child=E2=80=99? [-Werror=3Dimplicit-function-dec=
laration]
  723 |         device_for_each_child_node(dev, child) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         device_for_each_child
/build/stage/linux/drivers/iio/adc/max11410.c:723:47: error: expected =E2=
=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token
  723 |         device_for_each_child_node(dev, child) {
      |                                               ^~
      |                                               ;
/build/stage/linux/drivers/iio/adc/max11410.c:705:18: error: unused variabl=
e =E2=80=98i=E2=80=99 [-Werror=3Dunused-variable]
  705 |         int ret, i;
      |                  ^
/build/stage/linux/drivers/iio/adc/max11410.c:705:13: error: unused variabl=
e =E2=80=98ret=E2=80=99 [-Werror=3Dunused-variable]
  705 |         int ret, i;
      |             ^~~
/build/stage/linux/drivers/iio/adc/max11410.c:702:24: error: unused variabl=
e =E2=80=98scale=E2=80=99 [-Werror=3Dunused-variable]
  702 |         u32 inputs[2], scale;
      |                        ^~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:702:13: error: unused variabl=
e =E2=80=98inputs=E2=80=99 [-Werror=3Dunused-variable]
  702 |         u32 inputs[2], scale;
      |             ^~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:701:21: error: unused variabl=
e =E2=80=98node_name=E2=80=99 [-Werror=3Dunused-variable]
  701 |         const char *node_name;
      |                     ^~~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:700:24: error: unused variabl=
e =E2=80=98sig_path=E2=80=99 [-Werror=3Dunused-variable]
  700 |         u32 reference, sig_path;
      |                        ^~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:700:13: error: unused variabl=
e =E2=80=98reference=E2=80=99 [-Werror=3Dunused-variable]
  700 |         u32 reference, sig_path;
      |             ^~~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:697:41: error: unused variabl=
e =E2=80=98cfg=E2=80=99 [-Werror=3Dunused-variable]
  697 |         struct max11410_channel_config *cfg;
      |                                         ^~~
/build/stage/linux/drivers/iio/adc/max11410.c:695:30: error: unused variabl=
e =E2=80=98chanspec=E2=80=99 [-Werror=3Dunused-variable]
  695 |         struct iio_chan_spec chanspec =3D chanspec_template;
      |                              ^~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c: In function =E2=80=98max1141=
0_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/max11410.c:976:19: error: implicit decla=
ration of function =E2=80=98fwnode_irq_get_byname=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
  976 |         irqs[0] =3D fwnode_irq_get_byname(dev_fwnode(dev), "gpio0");
      |                   ^~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/max11410.c:976:41: error: implicit decla=
ration of function =E2=80=98dev_fwnode=E2=80=99; did you mean =E2=80=98dev_=
of_node=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  976 |         irqs[0] =3D fwnode_irq_get_byname(dev_fwnode(dev), "gpio0");
      |                                         ^~~~~~~~~~
      |                                         dev_of_node
cc1: all warnings being treated as errors
make[6]: Target 'drivers/iio/pressure/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/pr=
essure] Error 2
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/max11410.o] Error 1
/build/stage/linux/drivers/iio/adc/ti-lmp92064.c: In function =E2=80=98lmp9=
2064_adc_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/ti-lmp92064.c:265:15: error: implicit de=
claration of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
  265 |         ret =3D device_property_read_u32(dev, "shunt-resistor-micro=
-ohms",
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c: In function =E2=80=98ads=
131e08_alloc_channels=E2=80=99:
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:701:15: error: implicit d=
eclaration of function =E2=80=98device_property_read_u32=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
  701 |         ret =3D device_property_read_u32(dev, "ti,vref-internal", &=
tmp);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c: In function =E2=80=98tsc20=
46_adc_parse_fwnode=E2=80=99:
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c:721:9: error: implicit decl=
aration of function =E2=80=98device_for_each_child_node=E2=80=99; did you m=
ean =E2=80=98device_for_each_child=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
  721 |         device_for_each_child_node(dev, child) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         device_for_each_child
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c:721:47: error: expected =E2=
=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token
  721 |         device_for_each_child_node(dev, child) {
      |                                               ^~
      |                                               ;
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ti-lmp92064.o] Error 1
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c: In function =E2=80=98tsc20=
46_adc_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c:807:16: error: implicit dec=
laration of function =E2=80=98device_get_match_data=E2=80=99; did you mean =
=E2=80=98device_match_any=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
  807 |         dcfg =3D device_get_match_data(dev);
      |                ^~~~~~~~~~~~~~~~~~~~~
      |                device_match_any
/build/stage/linux/drivers/iio/adc/ti-tsc2046.c:807:14: error: assignment t=
o =E2=80=98const struct tsc2046_adc_dcfg *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
  807 |         dcfg =3D device_get_match_data(dev);
      |              ^
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:717:24: error: implicit d=
eclaration of function =E2=80=98device_get_child_node_count=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
  717 |         num_channels =3D device_get_child_node_count(dev);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ti-tsc2046.o] Error 1
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:739:9: error: implicit de=
claration of function =E2=80=98device_for_each_child_node=E2=80=99; did you=
 mean =E2=80=98device_for_each_child=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
  739 |         device_for_each_child_node(dev, node) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         device_for_each_child
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:739:46: error: expected =
=E2=80=98;=E2=80=99 before =E2=80=98{=E2=80=99 token
  739 |         device_for_each_child_node(dev, node) {
      |                                              ^~
      |                                              ;
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:789:9: error: implicit de=
claration of function =E2=80=98fwnode_handle_put=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
  789 |         fwnode_handle_put(node);
      |         ^~~~~~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:788:1: error: label =E2=
=80=98err_child_out=E2=80=99 defined but not used [-Werror=3Dunused-label]
  788 | err_child_out:
      | ^~~~~~~~~~~~~
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:698:22: error: unused var=
iable =E2=80=98channel=E2=80=99 [-Werror=3Dunused-variable]
  698 |         unsigned int channel, tmp;
      |                      ^~~~~~~
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c: In function =E2=80=98ads=
131e08_probe=E2=80=99:
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:809:16: error: implicit d=
eclaration of function =E2=80=98device_get_match_data=E2=80=99; did you mea=
n =E2=80=98device_match_any=E2=80=99? [-Werror=3Dimplicit-function-declarat=
ion]
  809 |         info =3D device_get_match_data(&spi->dev);
      |                ^~~~~~~~~~~~~~~~~~~~~
      |                device_match_any
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:809:14: error: assignment=
 to =E2=80=98const struct ads131e08_info *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion]
  809 |         info =3D device_get_match_data(&spi->dev);
      |              ^
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c: At top level:
/build/stage/linux/drivers/iio/adc/ti-ads131e08.c:320:12: error: =E2=80=98a=
ds131e08_validate_channel_mux=E2=80=99 defined but not used [-Werror=3Dunus=
ed-function]
  320 | static int ads131e08_validate_channel_mux(struct ads131e08_state *s=
t,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/build/stage/linux/scripts/Makefile.build:243: drivers/iio/ad=
c/ti-ads131e08.o] Error 1
make[6]: Target 'drivers/iio/adc/' not remade because of errors.
make[5]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio/ad=
c] Error 2
make[5]: Target 'drivers/iio/' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers/iio] E=
rror 2
make[4]: Target 'drivers/' not remade because of errors.
make[3]: *** [/build/stage/linux/scripts/Makefile.build:477: drivers] Error=
 2
make[3]: Target './' not remade because of errors.
make[2]: *** [/build/stage/linux/Makefile:2020: .] Error 2
make[2]: Target '__all' not remade because of errors.
make[1]: *** [/build/stage/linux/Makefile:234: __sub-make] Error 2
make[1]: Target '__all' not remade because of errors.

--pIeIB6/zdeGPnfkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStEkMACgkQJNaLcl1U
h9CILAf9Exi+erWC7ZAr2PRsAPUY7ejWGlN+v2Iw3ymd2lZVd0+iurSqwe3Fb+YM
I/LZgKV4ELU3Ovcoc1NrBd2kDnn0quhlk4LEdPfdQE968I/hRdUmQ7xGLH7Laasp
x993A8sXEk2cZ6WVJ2xUfiaAIMWw/RYaz27pp7s8mefD6m8MvIgjbbfmLjkkSJI6
L8S4nR6kbjjw0ojXnXcF3+k0tzl77CMp3XXm4jHr8QugvIRYNNaSh6uX1Glf3pi/
Fs2R89kwg3RkYtyvzHOlErMHMyG4f5i1vBlIqCj60t2u9hfYQ8sip1dqN9PKm7kh
oslneaSjeUDmssFhS9QAh6EY7aXGPw==
=kWPL
-----END PGP SIGNATURE-----

--pIeIB6/zdeGPnfkv--
