Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5714E69F8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjBVQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjBVQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:14:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75103D08A;
        Wed, 22 Feb 2023 08:14:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f41so10683733lfv.13;
        Wed, 22 Feb 2023 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBzj6zg5K+yTYjmvzeLzRMbBCszvayJl3H3HpOt/nlw=;
        b=UC3vEvPke7M9kkglNYtM39AXQJRkiNClmclSfsMZQEsoh7gxALSRu5SvRLQvnaK6ff
         60x30fge/XG9sNwxPGDU/fH1+REed0vVFm7BVYGMi8/yQRCZIGYOduZFdRSWpzW+flKg
         L2SXNyTxzIhP71ThED2pFZwSL6MoePM0j1nlSAKhRWYcV9zbEVnyrW0hamNs+6iLzNi8
         h7t9xPQE6FHggbCHcKEvK0fY0VE9LSbAbNnYsZ+VSfF/UETLu2eoqEFOk2UnT/YR4aUP
         oqwTjiE95tnIrBiVZTLZVPycF3ujklrxUEl4fbsU5CcKzn8ZRrZ7//nQsL0uWgIuhzOG
         scjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBzj6zg5K+yTYjmvzeLzRMbBCszvayJl3H3HpOt/nlw=;
        b=XuzdpGWpcJk3FhPuUXCKHon7oHLK40twFoHptypyS5xdJp3LDPWVtx8pN/gvBjy+Oo
         Fn3UfOAKISkaqJoOz/78HL4j7Ac/8vKhVLG1xYHv02/kTgy9qtvEnjx5vzdIvYFlknGh
         +HbDlCNqB9MHNGdX+E77FffDKFJXwmJSld/9lKTs8Xbp/f+rX9i4Z4V9wc3SZD+le/2c
         nR1Pe53Yni0wktpjLD9rBvdPVbLrBpbBBNXfTcyMhTSrg/SJ04u94WlBz7gmhL+WVu3O
         TuFrwU4WeFjLXWMQfWw17bBMow+FiS2Kn9BQ8mAPLokUhb1m4U47gQmcL4TpksSOsV8h
         nZMg==
X-Gm-Message-State: AO0yUKVKzTUn/Ou0bpt6Sv4wKHTZ1qq+YdYDYTOzEkMAmRcf8g0X2XxA
        Kq/4qH4sv26jpLJGJebEVEs=
X-Google-Smtp-Source: AK7set/78fNy14VeGoLWeil8OIdWMpZPum2AXVgVeC14qu4fzwGvVabcmRYiKwUTClEKQOPleH/KNA==
X-Received: by 2002:ac2:51b3:0:b0:4d8:8ad1:a05e with SMTP id f19-20020ac251b3000000b004d88ad1a05emr2266672lfk.52.1677082490747;
        Wed, 22 Feb 2023 08:14:50 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q10-20020ac25a0a000000b004dc4b0ca734sm726053lfn.250.2023.02.22.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:14:49 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:14:45 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
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
Subject: [RFC PATCH 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <3de52eafbf085e8f0048647a1cc01cb73842f367.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mIjt5j1iinulMbq2"
Content-Disposition: inline
In-Reply-To: <cover.1677080089.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mIjt5j1iinulMbq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some light sensors can adjust both the HW-gain and integration time.
There are cases where adjusting the integration time has similar impact
to the scale of the reported values as gain setting has.

IIO users do typically expect to handle scale by a single writable 'scale'
entry. Driver should then adjust the gain/time accordingly.

It however is difficult for a driver to know whether it should change
gain or integration time to meet the requested scale. Usually it is
preferred to have longer integration time which usually improves
accuracy, but there may be use-cases where long measurement times can be
an issue. Thus it can be preferable to allow also changing the
integration time - but mitigate the scale impact by also changing the gain
underneath. Eg, if integration time change doubles the measured values,
the driver can reduce the HW-gain to half.

The theory of the computations of gain-time-scale is simple. However,
some people (undersigned) got that implemented wrong for more than once.

Add some gain-time-scale helpers in order to not dublicate errors in all
drivers needing these computations.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Currently it is only BU27034 using these in this series. I am however worki=
ng
with drivers for RGB sensors BU27008 and BU27010 which have similar
[gain - integration time - scale] - relation. I hope sending those
follows soon after the BU27034 is done.
---
 drivers/iio/light/Kconfig                  |   3 +
 drivers/iio/light/Makefile                 |   1 +
 drivers/iio/light/gain-time-scale-helper.c | 446 +++++++++++++++++++++
 drivers/iio/light/gain-time-scale-helper.h | 111 +++++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/iio/light/gain-time-scale-helper.c
 create mode 100644 drivers/iio/light/gain-time-scale-helper.h

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..671d84f98c56 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -183,6 +183,9 @@ config IIO_CROS_EC_LIGHT_PROX
 	  To compile this driver as a module, choose M here:
 	  the module will be called cros_ec_light_prox.
=20
+config IIO_GTS_HELPER
+	tristate
+
 config GP2AP002
 	tristate "Sharp GP2AP002 Proximity/ALS sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6f23817fae6f..f4705fac7a96 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_CM3323)		+=3D cm3323.o
 obj-$(CONFIG_CM3605)		+=3D cm3605.o
 obj-$(CONFIG_CM36651)		+=3D cm36651.o
 obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) +=3D cros_ec_light_prox.o
+obj-$(CONFIG_IIO_GTS_HELPER)	+=3D gain-time-scale-helper.o
 obj-$(CONFIG_GP2AP002)		+=3D gp2ap002.o
 obj-$(CONFIG_GP2AP020A00F)	+=3D gp2ap020a00f.o
 obj-$(CONFIG_HID_SENSOR_ALS)	+=3D hid-sensor-als.o
diff --git a/drivers/iio/light/gain-time-scale-helper.c b/drivers/iio/light=
/gain-time-scale-helper.c
new file mode 100644
index 000000000000..bd8fc11802ee
--- /dev/null
+++ b/drivers/iio/light/gain-time-scale-helper.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/units.h>
+
+#include "gain-time-scale-helper.h"
+
+static int iio_gts_get_gain(const u64 max, u64 scale)
+{
+	int tmp =3D 1;
+
+	if (scale > max || !scale)
+		return -EINVAL;
+
+	if (0xffffffffffffffffLLU - max < scale) {
+		/* Risk of overflow */
+		if (max - scale < scale)
+			return 1;
+
+		while (max - scale > scale * (u64) tmp)
+			tmp++;
+
+		return tmp + 1;
+	}
+
+	while (max > scale * (u64) tmp)
+		tmp++;
+
+	return tmp;
+}
+
+static int gain_get_scale_fraction(const u64 max, u64 scale, int known,
+				   int *unknown)
+{
+	int tot_gain;
+
+	if (!known)
+		return -EINVAL;
+
+	tot_gain =3D iio_gts_get_gain(max, scale);
+	if (tot_gain < 0)
+		return tot_gain;
+
+	*unknown =3D tot_gain/known;
+
+	/* We require total gain to be exact multiple of known * unknown */
+	if (!*unknown || *unknown * known !=3D tot_gain)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_itime_sel_mul *
+			iio_gts_find_itime_by_time(struct iio_gts *gts, int time)
+{
+	int i;
+
+	if (!gts->num_itime)
+		return NULL;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].time_us =3D=3D time)
+			return &gts->itime_table[i];
+
+	return NULL;
+}
+
+static const struct iio_itime_sel_mul *
+			iio_gts_find_itime_by_sel(struct iio_gts *gts, int sel)
+{
+	int i;
+
+	if (!gts->num_itime)
+		return NULL;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].sel =3D=3D sel)
+			return &gts->itime_table[i];
+
+	return NULL;
+}
+
+static int iio_gts_delinearize(u64 lin_scale, int *scale_whole, int *scale=
_nano,
+			       unsigned long scaler)
+{
+	int frac;
+
+	if (scaler > NANO || !scaler)
+		return -EINVAL;
+
+	frac =3D do_div(lin_scale, scaler);
+
+	*scale_whole =3D lin_scale;
+	*scale_nano =3D frac * (NANO / scaler);
+
+	return 0;
+}
+
+static int iio_gts_linearize(int scale_whole, int scale_nano, u64 *lin_sca=
le,
+			     unsigned long scaler)
+{
+	/*
+	 * Expect scale to be (mostly) NANO or MICRO. Divide divider instead of
+	 * multiplication followed by division to avoid overflow
+	 */
+	if (scaler > NANO || !scaler)
+		return -EINVAL;
+
+	*lin_scale =3D (u64) scale_whole * (u64)scaler + (u64)(scale_nano
+		     / (NANO / scaler));
+
+	return 0;
+}
+
+/**
+ * iio_init_iio_gts - Initialize the gain-time-scale helper
+ * @max_scale_int:	integer part of the maximum scale value
+ * @max_scale_nano:	fraction part of the maximum scale value
+ * @gain_tbl:		table describing supported gains
+ * @num_gain:		number of gains in the gaintable
+ * @tim_tbl:		table describing supported integration times
+ * @num_times:		number of times in the time table
+ * @gts:		pointer to the helper struct
+ *
+ * Initialize the gain-time-scale helper for use. Please, provide the
+ * integration time table sorted so that the preferred integration time is
+ * in the first array index. The search functions like the
+ * iio_gts_find_time_and_gain_sel_for_scale() start search from first
+ * provided time.
+ *
+ * Return: 0 on success.
+ */
+int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
+		     const struct iio_gain_sel_pair *gain_tbl, int num_gain,
+		     const struct iio_itime_sel_mul *tim_tbl, int num_times,
+		     struct iio_gts *gts)
+{
+	int ret;
+
+	ret =3D iio_gts_linearize(max_scale_int, max_scale_nano,
+				   &gts->max_scale, NANO);
+	if (ret)
+		return ret;
+
+	gts->hwgain_table =3D gain_tbl;
+	gts->num_hwgain =3D num_gain;
+	gts->itime_table =3D tim_tbl;
+	gts->num_itime =3D num_times;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_init_iio_gts);
+
+bool iio_gts_valid_time(struct iio_gts *gts, int time_us)
+{
+	return !!iio_gts_find_itime_by_time(gts, time_us);
+}
+EXPORT_SYMBOL_GPL(iio_gts_valid_time);
+
+int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_hwgain; i++)
+		if (gts->hwgain_table[i].gain =3D=3D gain)
+			return gts->hwgain_table[i].sel;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_gain);
+
+bool iio_gts_valid_gain(struct iio_gts *gts, int gain)
+{
+	return !(iio_gts_find_sel_by_gain(gts, gain) < 0);
+}
+EXPORT_SYMBOL_GPL(iio_gts_valid_gain);
+
+int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_hwgain; i++)
+		if (gts->hwgain_table[i].sel =3D=3D sel)
+			return gts->hwgain_table[i].gain;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_gain_by_sel);
+
+int iio_gts_get_int_time_gain_multiplier_by_sel(struct iio_gts *gts,
+						       int sel)
+{
+	const struct iio_itime_sel_mul *time;
+
+	time =3D iio_gts_find_itime_by_sel(gts, sel);
+	if (!time)
+		return -EINVAL;
+
+	return time->mul;
+}
+EXPORT_SYMBOL_GPL(iio_gts_get_int_time_gain_multiplier_by_sel);
+
+/**
+ * iio_gts_find_gain_for_scale_using_time - Find gain by time and scale
+ * @gts:	Gain time scale descriptor
+ * @time_sel:	Integration time selector correspondig to the time gain is
+ *		searhed for
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ * @gain:	Pointer to value where gain is stored.
+ *
+ * In some cases the light sensors may want to find a gain setting which
+ * corresponds given scale and integration time. Sensors which fill the
+ * gain and time tables may use this helper to retrieve the gain.
+ *
+ * Return:	0 on success. -EINVAL if gain matching the parameters is not
+ *		found.
+ */
+int iio_gts_find_gain_for_scale_using_time(struct iio_gts *gts, int time_s=
el,
+					   int scale_int, int scale_nano,
+					   int *gain)
+{
+	u64 scale_linear;
+	int ret, mul;
+
+	ret =3D iio_gts_linearize(scale_int, scale_nano, &scale_linear, NANO);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_get_int_time_gain_multiplier_by_sel(gts, time_sel);
+	if (ret < 0)
+		return ret;
+
+	mul =3D ret;
+
+	ret =3D gain_get_scale_fraction(gts->max_scale, scale_linear, mul, gain);
+
+	if (ret || !iio_gts_valid_gain(gts, *gain))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_gain_for_scale_using_time);
+
+/*
+ * iio_gts_find_gain_sel_for_scale_using_time - Fetch gain selector.
+ * See iio_gts_find_gain_for_scale_using_time() for more information
+ */
+int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int ti=
me_sel,
+					       int scale_int, int scale_nano,
+					       int *gain_sel)
+{
+	int gain, ret;
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(gts, time_sel, scale_int,
+						     scale_nano, &gain);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_find_sel_by_gain(gts, gain);
+	if (ret < 0)
+		return ret;
+
+	*gain_sel =3D ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_gain_sel_for_scale_using_time);
+
+int iio_gts_find_time_and_gain_sel_for_scale(struct iio_gts *gts, int scal=
e_int,
+					     int scale_nano, int *gain_sel,
+					     int *time_sel)
+{
+	int ret, i;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		*time_sel =3D gts->itime_table[i].sel;
+		ret =3D iio_gts_find_gain_sel_for_scale_using_time(gts, *time_sel,
+					scale_int, scale_nano, gain_sel);
+		if (!ret)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_time_and_gain_sel_for_scale);
+
+int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	itime =3D iio_gts_find_itime_by_sel(gts, sel);
+	if (!itime)
+		return -EINVAL;
+
+	return itime->time_us;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_int_time_by_sel);
+
+int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	itime =3D iio_gts_find_itime_by_time(gts, time);
+	if (!itime)
+		return -EINVAL;
+
+	return itime->sel;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_int_time);
+
+int iio_gts_get_total_gain_by_sel(struct iio_gts *gts, int gsel, int tsel)
+{
+	int ret, tmp;
+
+	ret =3D iio_gts_find_gain_by_sel(gts, gsel);
+	if (ret < 0)
+		return ret;
+
+	tmp =3D ret;
+
+	/*
+	 * TODO: Would these helpers provde any value for cases where we just
+	 * use table of gains and no integration time? This would be a standard
+	 * format for gain table representation and regval =3D> gain / gain =3D>
+	 * regval conversions. OTOH, a dummy table based conversion is a memory
+	 * hog in cases where the gain could be computed simply based on simple
+	 * multiplication / bit-shift or by linear_ranges helpers.
+	 *
+	 * Currently we return an error if int-time table is not populated.
+	 */
+	ret =3D iio_gts_get_int_time_gain_multiplier_by_sel(gts, tsel);
+	if (ret < 0)
+		return ret;
+
+	return tmp * ret;
+}
+EXPORT_SYMBOL_GPL(iio_gts_get_total_gain_by_sel);
+
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
+{
+	const struct iio_itime_sel_mul *itime;
+
+	if (!iio_gts_valid_gain(gts, gain))
+		return -EINVAL;
+
+	if (!gts->num_itime)
+		return gain;
+
+	itime =3D iio_gts_find_itime_by_time(gts, time);
+	if (!itime)
+		return -EINVAL;
+
+	return gain * itime->mul;
+}
+EXPORT_SYMBOL(iio_gts_get_total_gain);
+
+static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int tim=
e,
+				    u64 *scale)
+{
+	int total_gain;
+	u64 tmp;
+
+	total_gain =3D iio_gts_get_total_gain(gts, gain, time);
+	if (total_gain < 0)
+		return total_gain;
+
+	tmp =3D gts->max_scale;
+
+	do_div(tmp, total_gain);
+
+	*scale =3D tmp;
+
+	return 0;
+}
+
+int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_=
int,
+		      int *scale_nano)
+{
+	u64 lin_scale;
+	int ret;
+
+	ret =3D iio_gts_get_scale_linear(gts, gain, time, &lin_scale);
+	if (ret)
+		return ret;
+
+	return iio_gts_delinearize(lin_scale, scale_int, scale_nano, NANO);
+}
+EXPORT_SYMBOL_GPL(iio_gts_get_scale);
+
+/**
+ * iio_gts_find_new_gain_sel_by_old_gain_time - compensate time change
+ * @gts:		Gain time scale descriptor
+ * @old_gain:		Previously set gain
+ * @old_time_sel:	Selector corresponding previously set time
+ * @new_time_sel:	Selector corresponding new time to be set
+ * @new_gain:		Pointer to value where new gain is to be written
+ *
+ * We may want to mitigate the scale change caused by setting a new integr=
ation
+ * time (for a light sensor) by also updating the (HW)gain. This helper co=
mputes
+ * new gain value to maintain the scale with new integration time.
+ *
+ * Return: 0 on success. -EINVAL if gain matching the new time is not foun=
d.
+ */
+int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
+					       int old_gain, int old_time_sel,
+					       int new_time_sel, int *new_gain)
+{
+	const struct iio_itime_sel_mul *itime_old, *itime_new;
+	u64 scale;
+	int ret;
+
+	itime_old =3D iio_gts_find_itime_by_sel(gts, old_time_sel);
+	if (!itime_old)
+		return -EINVAL;
+
+	itime_new =3D iio_gts_find_itime_by_sel(gts, new_time_sel);
+	if (!itime_new)
+		return -EINVAL;
+
+	ret =3D iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
+				       &scale);
+	if (ret)
+		return ret;
+
+	ret =3D gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
+				      new_gain);
+	if (ret)
+		return -EINVAL;
+
+	if (!iio_gts_valid_gain(gts, *new_gain))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_gts_find_new_gain_sel_by_old_gain_time);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("IIO light sensor gain-time-scale helpers");
diff --git a/drivers/iio/light/gain-time-scale-helper.h b/drivers/iio/light=
/gain-time-scale-helper.h
new file mode 100644
index 000000000000..70a952a8de92
--- /dev/null
+++ b/drivers/iio/light/gain-time-scale-helper.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef __GAIN_TIME_SCALE_HELPER__
+#define ___GAIN_TIME_SCALE_HELPER__
+
+/**
+ * struct iio_gain_sel_pair - gain - selector values
+ *
+ * In many cases devices like light sensors allow setting signal amplifica=
tion
+ * (gain) using a register interface. This structure describes amplificati=
on
+ * and corresponding selector (register value)
+ *
+ * @gain:	Gain (multiplication) value.
+ * @sel:	Selector (usually register value) used to indicate this gain
+ */
+struct iio_gain_sel_pair {
+	int gain;
+	int sel;
+};
+
+/**
+ * struct iio_itime_sel_mul - integration time description
+ *
+ * In many cases devices like light sensors allow setting the duration of
+ * collecting data. Typically this duration has also an impact to the magn=
itude
+ * of measured values (gain). This structure describes the relation of
+ * integration time and amplification as well as corresponding selector
+ * (register value).
+ *
+ * An example could be a sensor allowing 50, 100, 200 and 400 mS times. The
+ * respective multiplication values could be 50 mS =3D> 1, 100 mS =3D> 2,
+ * 200 mS =3D> 4 and 400 mS =3D> 8 assuming the impact of integration time=
 would be
+ * linear in a way that when collecting data for 50 mS caused value X, dou=
bling
+ * the data collection time caused value 2X etc..
+ *
+ * @time_us:	Integration time in microseconds.
+ * @sel:	Selector (usually register value) used to indicate this time
+ * @mul:	Multiplication to the values caused by this time.
+ */
+struct iio_itime_sel_mul {
+	int time_us;
+	int sel;
+	int mul;
+};
+
+struct iio_gts {
+	u64 max_scale;
+	const struct iio_gain_sel_pair *hwgain_table;
+	int num_hwgain;
+	const struct iio_itime_sel_mul *itime_table;
+	int num_itime;
+};
+
+#define GAIN_SCALE_GAIN(_gain, _sel)			\
+{							\
+	.gain =3D (_gain),				\
+	.sel =3D (_sel),					\
+}
+
+#define GAIN_SCALE_ITIME_MS(_itime, _sel, _mul)		\
+{							\
+	.time_us =3D (_itime) * 1000,				\
+	.sel =3D (_sel),					\
+	.mul =3D (_mul),					\
+}
+
+#define GAIN_SCALE_ITIME_US(_itime, _sel, _mul)		\
+{							\
+	.time_us =3D (_itime),				\
+	.sel =3D (_sel),					\
+	.mul =3D (_mul),					\
+}
+
+int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
+		     const struct iio_gain_sel_pair *gain_tbl, int num_gain,
+		     const struct iio_itime_sel_mul *tim_tbl, int num_times,
+		     struct iio_gts *gts);
+
+bool iio_gts_valid_gain(struct iio_gts *gts, int gain);
+bool iio_gts_valid_time(struct iio_gts *gts, int time_us);
+
+int iio_gts_get_total_gain_by_sel(struct iio_gts *gts, int gsel, int tsel);
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time);
+
+int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain);
+int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time);
+
+int iio_gts_get_int_time_gain_multiplier_by_sel(struct iio_gts *gts,
+						       int sel);
+int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int ti=
me_sel,
+					       int scale_int, int scale_nano,
+					       int *gain_sel);
+int iio_gts_find_gain_for_scale_using_time(struct iio_gts *gts, int time_s=
el,
+					   int scale_int, int scale_nano,
+					   int *gain);
+int iio_gts_find_time_and_gain_sel_for_scale(struct iio_gts *gts, int scal=
e_int,
+					     int scale_nano, int *gain_sel,
+					     int *time_sel);
+int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_=
int,
+		      int *scale_nano);
+int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
+					       int old_gain, int old_time_sel,
+					       int new_time_sel, int *new_gain);
+
+#endif
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--mIjt5j1iinulMbq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2P3UACgkQeFA3/03a
ocVFrAgAqHBMNq2L2MOvf87GywA7nPrKIQXB9oExUElpzz8f5CnWxCXGjvIRLh7q
kOn7gf/cKFHl7rDjO5yLdwxROqNw2YzQOijkphISwOAXICMvGUGPsdM6yvp1XLon
kwppg4AW7eeKA7/SoJCbQSGjCz0gHKAIau8Mvbx4Dq+0YpumHZA8sbUWTrbRbX1Z
p6AEfxJ3h55aDEk0qmdQ5MFothufEFb36PPIqzVvKdNfNOjFBv+asfoPcLKCQ/k2
/wVQQGev7LECW39HL8jUDxBg3/Xl9I6wU2xP4zef5FRnrRehT6HCTcIer68JWcnX
gA/k0wHt1yWBOlxlFNLzeBzzGne98w==
=THa6
-----END PGP SIGNATURE-----

--mIjt5j1iinulMbq2--
