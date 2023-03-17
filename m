Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640EC6BEB98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCQOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCQOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:43:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB039367CD;
        Fri, 17 Mar 2023 07:43:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bi9so6736536lfb.12;
        Fri, 17 Mar 2023 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iF8in9l1T6zbpnXyIS54Ym53qHWHsCbph9y5DNXEN8c=;
        b=qxABR3SGhH3RVHhzgnhmd2WCB5tb4G80tbxpoCg9afuVktDALoT+YUb/2NTJzh+Vjm
         vfuMweZ0xp9yptFXUFSZfKbJlWpwglh2LObh8wnftnmHDbHjUQQpyuar+r1mZP6g5dE4
         jiyuSum7HK9/cq2b7p7v4qJuFBln0EWQYehaZD/AyCdmJNWAERxwLNC8b50yChG83ICu
         LwFFzbKSKoIGNaxdlg9/d+EaN2xjDYkiAXRxYyKut7mORyeaH6sRAzFbSl8gFWYhrz6w
         BwVQbetmQrQX+4uvRVzlWzLb0lLQguYcLES8yRtiMipgdCYf50jq3AAakVyoKRpskMnP
         HKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF8in9l1T6zbpnXyIS54Ym53qHWHsCbph9y5DNXEN8c=;
        b=JMzxY3vIS8TF22x8M71IPsMO1W4Ada700ugguE4cCyiwujkSRAbamC1dLoI4kp7sgt
         IM9jSXjjgxVxkqCx3JyOWKvuum+VT8SO/AxdXYfzEmSp+mVqZBO5rXeequQQNtFFC5iE
         r01yCwy5H7oBLIVD/0WWUk/fKmkxmpmUYqubNmFL/Al3apSg3sjND0hC/VJI7zCgQd8a
         Z/D1ndrSlux7CwXWRs5xP7mnCRV4IxZgvd9R6Ju/jffUqZKbLZQ4KZysLa7G5ghgE0RM
         N5nlkOzeSSM/0notZlrT8h4KUW/V9OH+r/EqO3PRt8Ik9IY4zY4sPC5UyOjqdVyl3ETK
         3aKA==
X-Gm-Message-State: AO0yUKXuoS6AAZ0PoxO4LsqRSWAlWSlBGlPD0P5t4Z31lmV02tB1fWTV
        hL1B/OhKIsKg0zCJm/8rpiN+9bqTLh0=
X-Google-Smtp-Source: AK7set96zTGxOCQQowvjdR8Hhm3TyjA2FGpqHHONuRzLSkGr1rxU73vZnqje27hgs64wCycdbb6twg==
X-Received: by 2002:ac2:5975:0:b0:4e2:1440:b392 with SMTP id h21-20020ac25975000000b004e21440b392mr4029863lfp.56.1679064207645;
        Fri, 17 Mar 2023 07:43:27 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l17-20020ac25551000000b004cc9042c9cfsm393993lfk.158.2023.03.17.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:43:27 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:43:23 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v4 4/8] iio: light: Add gain-time-scale helpers
Message-ID: <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="66ySHrGyfNcLesiy"
Content-Disposition: inline
In-Reply-To: <cover.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--66ySHrGyfNcLesiy
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

Changes:
v3 =3D> v4:
- doc styling
- use memset to zero the helper struct at init
- drop unnecessary min calculation at iio_find_closest_gain_low()
- use namespace to all exports
- many minor stylings
- make available outside iio/light (move code to drivers/iio and move the
  header under include
- rename to look like other files under drivers/iio (s/iio/industrialio)
- drop unused functions
- don't export only internally used functions and make them static
  Note, I decided to keep iio_gts_total_gain_to_scale() exported as it is
  currently needed by the tests outside the helpers.

v2 =3D> v3: (mostly fixes based on review by Andy)
- Fix typos
- Styling fixes
- Use namespace for exported symbols
- Protect allocs against argument overflow
- Fix include protection name
- add types.h inclusion and struct device forward declaration

RFCv1 =3D> v2:
- fix include guardian
- Improve kernel doc for iio_init_iio_gts.
- Add iio_gts_scale_to_total_gain
- Add iio_gts_total_gain_to_scale
- Fix review comments from Jonathan
  - add documentation to few functions
  - replace 0xffffffffffffffffLLU by U64_MAX
  - some styling fixes
  - drop unnecessary NULL checks
  - order function arguments by  in / out purpose
  - drop GAIN_SCALE_ITIME_MS()
- Add helpers for available scales and times
- Rename to iio-gts-helpers
---
 drivers/iio/Kconfig                   |   3 +
 drivers/iio/Makefile                  |   1 +
 drivers/iio/industrialio-gts-helper.c | 990 ++++++++++++++++++++++++++
 include/linux/iio/iio-gts-helper.h    | 113 +++
 4 files changed, 1107 insertions(+)
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 include/linux/iio/iio-gts-helper.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b190846c3dc2..52eb46ef84c1 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -30,6 +30,9 @@ config IIO_CONFIGFS
 	  (e.g. software triggers). For more info see
 	  Documentation/iio/iio_configfs.rst.
=20
+config IIO_GTS_HELPER
+	tristate
+
 config IIO_TRIGGER
 	bool "Enable triggered sampling support"
 	help
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 3be08cdadd7e..9622347a1c1b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -9,6 +9,7 @@ industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
=20
 obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
+obj-$(CONFIG_IIO_GTS_HELPER) +=3D industrialio-gts-helper.o
 obj-$(CONFIG_IIO_SW_DEVICE) +=3D industrialio-sw-device.o
 obj-$(CONFIG_IIO_SW_TRIGGER) +=3D industrialio-sw-trigger.o
 obj-$(CONFIG_IIO_TRIGGERED_EVENT) +=3D industrialio-triggered-event.o
diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
new file mode 100644
index 000000000000..9494ea7cdbcf
--- /dev/null
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -0,0 +1,990 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/types.h>
+
+#define DEFAULT_SYMBOL_NAMESPACE IIO_GTS_HELPER
+
+/**
+ * iio_gts_get_gain - Convert scale to total gain
+ *
+ * Internal helper for converting scale to total gain.
+ *
+ * @max:	Maximum linearized scale. As an example, when scale is created
+ *		in magnitude of NANOs and max scale is 64.1 - The linearized
+ *		scale is 64 100 000 000.
+ * @scale:	Linearized scale to compte the gain for.
+ *
+ * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
+ *		is invalid.
+ */
+static int iio_gts_get_gain(const u64 max, const u64 scale)
+{
+	u64 full =3D max;
+	int tmp =3D 1;
+
+	if (scale > full || !scale)
+		return -EINVAL;
+
+	if (U64_MAX - full < scale) {
+		/* Risk of overflow */
+		if (full - scale < scale)
+			return 1;
+
+		full -=3D scale;
+		tmp++;
+	}
+
+	while (full > scale * (u64)tmp)
+		tmp++;
+
+	return tmp;
+}
+
+/**
+ * gain_get_scale_fraction - get the gain or time based on scale and known=
 one
+ *
+ * @max:	Maximum linearized scale. As an example, when scale is created
+ *		in magnitude of NANOs and max scale is 64.1 - The linearized
+ *		scale is 64 100 000 000.
+ * @scale:	Linearized scale to compute the gain/time for.
+ * @known:	Either integration time or gain depending on which one is known
+ * @unknown:	Pointer to variable where the computed gain/time is stored
+ *
+ * Internal helper for computing unknown fraction of total gain.
+ * Compute either gain or time based on scale and either the gain or time
+ * depending on which one is known.
+ *
+ * Return:	0 on success.
+ */
+static int gain_get_scale_fraction(const u64 max, u64 scale, int known,
+				   int *unknown)
+{
+	int tot_gain;
+
+	tot_gain =3D iio_gts_get_gain(max, scale);
+	if (tot_gain < 0)
+		return tot_gain;
+
+	*unknown =3D tot_gain / known;
+
+	/* We require total gain to be exact multiple of known * unknown */
+	if (!*unknown || *unknown * known !=3D tot_gain)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_itime_sel_mul *
+iio_gts_find_itime_by_time(struct iio_gts *gts, int time)
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
+iio_gts_find_itime_by_sel(struct iio_gts *gts, int sel)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].sel =3D=3D sel)
+			return &gts->itime_table[i];
+
+	return NULL;
+}
+
+static int iio_gts_delinearize(u64 lin_scale, unsigned long scaler,
+			       int *scale_whole, int *scale_nano)
+{
+	int frac;
+
+	if (scaler > NANO)
+		return -EOVERFLOW;
+
+	if (!scaler)
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
+static int iio_gts_linearize(int scale_whole, int scale_nano,
+			     unsigned long scaler, u64 *lin_scale)
+{
+	/*
+	 * Expect scale to be (mostly) NANO or MICRO. Divide divider instead of
+	 * multiplication followed by division to avoid overflow.
+	 */
+	if (scaler > NANO || !scaler)
+		return -EINVAL;
+
+	*lin_scale =3D (u64)scale_whole * (u64)scaler +
+		     (u64)(scale_nano / (NANO / scaler));
+
+	return 0;
+}
+
+/**
+ * iio_gts_total_gain_to_scale - convert gain to scale
+ * @gts:	Gain time scale descriptor
+ * @total_gain:	the gain to be converted
+ * @scale_int:	Pointer to integral part of the scale (typically val1)
+ * @scale_nano:	Pointer to fractional part of the scale (nano or ppb)
+ *
+ * Convert the total gain value to scale. NOTE: This does not separate gain
+ * generated by hwgain or integration time. It is up to caller to decide w=
hat
+ * part of the total gain is due to integration time and what due to hw-ga=
in.
+ *
+ * Return: 0 on success. Negative errno on failure.
+ */
+int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
+				int *scale_int, int *scale_nano)
+{
+	u64 tmp;
+
+	tmp =3D gts->max_scale;
+
+	do_div(tmp, total_gain);
+
+	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
+}
+EXPORT_SYMBOL_GPL(iio_gts_total_gain_to_scale);
+
+/**
+ * iio_init_iio_gts - Initialize the gain-time-scale helper
+ * @max_scale_int:	integer part of the maximum scale value
+ * @max_scale_nano:	fraction part of the maximum scale value
+ * @gain_tbl:		table describing supported gains
+ * @num_gain:		number of gains in the gaintable
+ * @tim_tbl:		table describing supported integration times. Provide
+ *			the integration time table sorted so that the preferred
+ *			integration time is in the first array index. The search
+ *			functions like the
+ *			iio_gts_find_time_and_gain_sel_for_scale() start search
+ *			from first provided time.
+ * @num_times:		number of times in the time table
+ * @gts:		pointer to the helper struct
+ *
+ * Initialize the gain-time-scale helper for use.
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
+	memset(gts, 0, sizeof(*gts));
+
+	ret =3D iio_gts_linearize(max_scale_int, max_scale_nano, NANO,
+				   &gts->max_scale);
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
+/**
+ * iio_gts_purge_avail_scale_table - free-up the available scale tables
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_scale_table(). Please no=
te
+ * that the helpers for getting available scales like the
+ * iio_gts_all_avail_scales() are not usable after this call. Thus, this s=
hould
+ * be only called after these helpers can no longer be called (Eg. after
+ * the iio-device has been deregistered).
+ */
+static void iio_gts_purge_avail_scale_table(struct iio_gts *gts)
+{
+	int i;
+
+	if (gts->per_time_avail_scale_tables) {
+		for (i =3D 0; i < gts->num_itime; i++)
+			kfree(gts->per_time_avail_scale_tables[i]);
+
+		kfree(gts->per_time_avail_scale_tables);
+		gts->per_time_avail_scale_tables =3D NULL;
+	}
+
+	kfree(gts->avail_all_scales_table);
+	gts->avail_all_scales_table =3D NULL;
+
+	gts->num_avail_all_scales =3D 0;
+}
+
+static int iio_gts_gain_cmp(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
+{
+	int ret, i, j, new_idx, time_idx;
+	int *all_gains;
+	size_t gain_bytes;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		/*
+		 * Sort the tables for nice output and for easier finding of
+		 * unique values.
+		 */
+		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
+		     NULL);
+
+		/* Convert gains to scales */
+		for (j =3D 0; j < gts->num_hwgain; j++) {
+			ret =3D iio_gts_total_gain_to_scale(gts, gains[i][j],
+							  &scales[i][2 * j],
+							  &scales[i][2 * j + 1]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
+	all_gains =3D kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
+	if (!all_gains)
+		return -ENOMEM;
+
+	/*
+	 * We assume all the gains for same integration time were unique.
+	 * It is likely the first time table had greatest time multiplier as
+	 * the times are in the order of preference and greater times are
+	 * usually preferred. Hence we start from the last table which is likely
+	 * to have the smallest total gains.
+	 */
+	time_idx =3D gts->num_itime - 1;
+	memcpy(all_gains, gains[time_idx], gain_bytes);
+	new_idx =3D gts->num_hwgain;
+
+	while (time_idx--) {
+		for (j =3D 0; j < gts->num_hwgain; j++) {
+			int candidate =3D gains[time_idx][j];
+			int chk;
+
+			if (candidate > all_gains[new_idx - 1]) {
+				all_gains[new_idx] =3D candidate;
+				new_idx++;
+
+				continue;
+			}
+			for (chk =3D 0; chk < new_idx; chk++)
+				if (candidate <=3D all_gains[chk])
+					break;
+
+			if (candidate =3D=3D all_gains[chk])
+				continue;
+
+			memmove(&all_gains[chk + 1], &all_gains[chk],
+				(new_idx - chk) * sizeof(int));
+			all_gains[chk] =3D candidate;
+			new_idx++;
+		}
+	}
+
+	gts->num_avail_all_scales =3D new_idx;
+	gts->avail_all_scales_table =3D kcalloc(gts->num_avail_all_scales,
+					      2 * sizeof(int), GFP_KERNEL);
+	if (!gts->avail_all_scales_table)
+		ret =3D -ENOMEM;
+	else
+		for (i =3D 0; !ret && i < gts->num_avail_all_scales; i++)
+			ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i],
+					&gts->avail_all_scales_table[i * 2],
+					&gts->avail_all_scales_table[i * 2 + 1]);
+
+	kfree(all_gains);
+	if (ret)
+		kfree(gts->avail_all_scales_table);
+
+	return ret;
+}
+
+/**
+ * iio_gts_build_avail_scale_table - create tables of available scales
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales based on the
+ * originally given gain and time tables. When both time and gain tables a=
re
+ * given this results:
+ * 1. A set of tables representing available scales for each supported
+ *    integration time.
+ * 2. A single table listing all the unique scales that any combination of
+ *    supported gains and times can provide.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_scale_table() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
+{
+	int **per_time_gains, **per_time_scales, i, j, ret =3D -ENOMEM;
+
+	per_time_gains =3D kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
+	if (!per_time_gains)
+		return ret;
+
+	per_time_scales =3D kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
+	if (!per_time_scales)
+		goto free_gains;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		per_time_scales[i] =3D kcalloc(gts->num_hwgain, 2 * sizeof(int),
+					     GFP_KERNEL);
+		if (!per_time_scales[i])
+			goto err_free_out;
+
+		per_time_gains[i] =3D kcalloc(gts->num_hwgain, sizeof(int),
+					    GFP_KERNEL);
+		if (!per_time_gains[i])
+			goto err_free_scale_out;
+
+
+		for (j =3D 0; j < gts->num_hwgain; j++)
+			per_time_gains[i][j] =3D gts->hwgain_table[j].gain *
+					       gts->itime_table[i].mul;
+	}
+
+	ret =3D gain_to_scaletables(gts, per_time_gains, per_time_scales);
+	if (ret)
+		goto err_free_out;
+
+	kfree(per_time_gains);
+	gts->per_time_avail_scale_tables =3D per_time_scales;
+
+	return 0;
+
+err_free_scale_out:
+	kfree(per_time_scales[i]);
+err_free_out:
+	for (i--; i; i--) {
+		kfree(per_time_scales[i]);
+		kfree(per_time_gains[i]);
+	}
+	kfree(per_time_scales);
+free_gains:
+	kfree(per_time_gains);
+
+	return ret;
+}
+
+/**
+ * iio_gts_build_avail_time_table - build table of available integration t=
imes
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the table which can represent the available times to be returned
+ * to users using the read_avail-callback.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_time_table() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_time_table(struct iio_gts *gts)
+{
+	int *times, i, j, idx =3D 0;
+
+	if (!gts->num_itime)
+		return 0;
+
+	times =3D kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
+	if (!times)
+		return -ENOMEM;
+
+	for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
+		int new =3D gts->itime_table[i].time_us;
+
+		if (times[idx] < new) {
+			times[idx++] =3D new;
+			continue;
+		}
+
+		for (j =3D 0; j <=3D idx; j++) {
+			if (times[j] > new) {
+				memmove(&times[j + 1], &times[j],
+					(idx - j) * sizeof(int));
+				times[j] =3D new;
+				idx++;
+			}
+		}
+	}
+	gts->avail_time_tables =3D times;
+	/*
+	 * This is just to survive a unlikely corner-case where times in the
+	 * given time table were not unique. Else we could just trust the
+	 * gts->num_itime.
+	 */
+	gts->num_avail_time_tables =3D idx;
+
+	return 0;
+}
+
+/**
+ * iio_gts_purge_avail_time_table - free-up the available integration time=
 table
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_time_table(). Please note
+ * that the helpers for getting available integration times like the
+ * iio_gts_avail_times() are not usable after this call. Thus, this should
+ * be only called after these helpers can no longer be called (Eg. after
+ * the iio-device has been deregistered).
+ */
+static void iio_gts_purge_avail_time_table(struct iio_gts *gts)
+{
+	if (gts->num_avail_time_tables) {
+		kfree(gts->avail_time_tables);
+		gts->avail_time_tables =3D NULL;
+		gts->num_avail_time_tables =3D 0;
+	}
+}
+
+/**
+ * iio_gts_build_avail_tables - create tables of available scales and int =
times
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales and available
+ * integration times. Availability tables are built based on the originally
+ * given gain and given time tables.
+ *
+ * When both time and gain tables are
+ * given this results:
+ * 1. A set of sorted tables representing available scales for each suppor=
ted
+ *    integration time.
+ * 2. A single sorted table listing all the unique scales that any combina=
tion
+ *    of supported gains and times can provide.
+ * 3. A sorted table of supported integration times
+ *
+ * After these tables are built one can use the iio_gts_all_avail_scales(),
+ * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
+ * implement the read_avail opeations.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_tables() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_tables(struct iio_gts *gts)
+{
+	int ret;
+
+	ret =3D iio_gts_build_avail_scale_table(gts);
+	if (ret)
+		return ret;
+
+	ret =3D iio_gts_build_avail_time_table(gts);
+	if (ret)
+		iio_gts_purge_avail_scale_table(gts);
+
+	return ret;
+}
+
+/**
+ * iio_gts_purge_avail_tables - free-up the availability tables
+ * @gts:	Gain time scale descriptor
+ *
+ * Free the space reserved by iio_gts_build_avail_tables(). Frees both the
+ * integration time and scale tables.
+ *
+ * Note  that the helpers for getting available integration times or scales
+ * like the iio_gts_avail_times() are not usable after this call. Thus, th=
is
+ * should be only called after these helpers can no longer be called (Eg.
+ * after the iio-device has been deregistered).
+ */
+static void iio_gts_purge_avail_tables(struct iio_gts *gts)
+{
+	iio_gts_purge_avail_time_table(gts);
+	iio_gts_purge_avail_scale_table(gts);
+}
+
+static void devm_iio_gts_avail_all_drop(void *res)
+{
+	iio_gts_purge_avail_tables(res);
+}
+
+/**
+ * devm_iio_gts_build_avail_tables - manged add availability tables
+ * @dev:	Pointer to the device whose lifetime tables are bound
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the tables which can represent the available scales and available
+ * integration times. Availability tables are built based on the originally
+ * given gain and given time tables.
+ *
+ * When both time and gain tables are
+ * given this results:
+ * 1. A set of sorted tables representing available scales for each suppor=
ted
+ *    integration time.
+ * 2. A single sorted table listing all the unique scales that any combina=
tion
+ *    of supported gains and times can provide.
+ * 3. A sorted table of supported integration times
+ *
+ * After these tables are built one can use the iio_gts_all_avail_scales(),
+ * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
+ * implement the read_avail opeations.
+ *
+ * The tables are automatically released upon device detach.
+ *
+ * NOTE: after the tables have been purged, the helpers for getting
+ * available scales / integration times are no longer usable. Care must be
+ * taken that unwinding is done in correct order (iio device is deregister=
ed
+ * prior purging the tables).
+ *
+ * Return: 0 on success.
+ */
+int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gt=
s)
+{
+	int ret;
+
+	ret =3D iio_gts_build_avail_tables(gts);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_iio_gts_avail_all_drop, gts);
+}
+EXPORT_SYMBOL_GPL(devm_iio_gts_build_avail_tables);
+
+/**
+ * iio_gts_all_avail_scales - helper for listing all available scales
+ * @gts:	Gain time scale descriptor
+ * @vals:	Returned array of supported scales
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *t=
ype,
+			     int *length)
+{
+	if (!gts->num_avail_all_scales)
+		return -EINVAL;
+
+	*vals =3D gts->avail_all_scales_table;
+	*type =3D IIO_VAL_INT_PLUS_NANO;
+	*length =3D gts->num_avail_all_scales * 2;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_GPL(iio_gts_all_avail_scales);
+
+/**
+ * iio_gts_avail_scales_for_time - list scales for integration time
+ * @gts:	Gain time scale descriptor
+ * @time:	Integration time for which the scales are listed
+ * @vals:	Returned array of supported scales
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Drivers which do not allow scale setting to change integration time can
+ * use this helper to list only the scales whic are valid for given integr=
ation
+ * time.
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
+				  const int **vals, int *type, int *length)
+{
+	int i;
+
+	for (i =3D 0; i < gts->num_itime; i++)
+		if (gts->itime_table[i].time_us =3D=3D time)
+			break;
+
+	if (i =3D=3D gts->num_itime)
+		return -EINVAL;
+
+	*vals =3D gts->per_time_avail_scale_tables[i];
+	*type =3D IIO_VAL_INT_PLUS_NANO;
+	*length =3D gts->num_hwgain * 2;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_GPL(iio_gts_avail_scales_for_time);
+
+/**
+ * iio_gts_avail_times - helper for listing available integration times
+ * @gts:	Gain time scale descriptor
+ * @vals:	Returned array of supported timees
+ * @type:	Type of returned scale values
+ * @length:	Amount of returned values in array
+ *
+ * Return: a value suitable to be returned from read_avail or a negative e=
rror.
+ */
+int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
+			int *length)
+{
+	if (!gts->num_avail_time_tables)
+		return -EINVAL;
+
+	*vals =3D gts->avail_time_tables;
+	*type =3D IIO_VAL_INT;
+	*length =3D gts->num_avail_time_tables;
+
+	return IIO_AVAIL_LIST;
+}
+EXPORT_SYMBOL_GPL(iio_gts_avail_times);
+
+/**
+ * iio_gts_valid_time - check if given integration time is valid
+ * @gts:	Gain time scale descriptor
+ * @time_us:	Integration time to check
+ *
+ * Return:	True if given time is supported by device. False if not.
+ */
+bool iio_gts_valid_time(struct iio_gts *gts, int time_us)
+{
+	return iio_gts_find_itime_by_time(gts, time_us);
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
+	return iio_gts_find_sel_by_gain(gts, gain) >=3D 0;
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
+int iio_gts_get_min_gain(struct iio_gts *gts)
+{
+	int i, min =3D -EINVAL;
+
+	for (i =3D 0; i < gts->num_hwgain; i++) {
+		int gain =3D gts->hwgain_table[i].gain;
+
+		if (min =3D=3D -EINVAL)
+			min =3D gain;
+		else
+			min =3D min(min, gain);
+	}
+
+	return min;
+}
+EXPORT_SYMBOL_GPL(iio_gts_get_min_gain);
+
+/**
+ * iio_find_closest_gain_low - Find the closest lower matching gain
+ * @gts:	Gain time scale descriptor
+ * @gain:	reference gain for which the closest match is searched
+ * @in_range:	indicate if the reference gain was actually in the range of
+ *		supported gains.
+ *
+ * Search for closest supported gain that is lower than or equal to the
+ * gain given as a parameter. This is usable for drivers which do not requ=
ire
+ * user to request exact matching gain but rather fo rounding to a support=
ed
+ * gain value which is equal or lower (setting lower gain is typical for
+ * avoiding saturation)
+ *
+ * Return:	The closest matching supported gain or -EINVAL is reference
+ *		gain was smaller than the smallest supported gain.
+ */
+int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_rang=
e)
+{
+	int i, diff =3D 0;
+	int best =3D -1;
+
+	*in_range =3D false;
+
+	for (i =3D 0; i < gts->num_hwgain; i++) {
+		/*
+		 * It is not expected this function is called for an exactly
+		 * matching gain.
+		 */
+		if (unlikely(gain =3D=3D gts->hwgain_table[i].gain)) {
+			*in_range =3D true;
+			return gain;
+		}
+
+		if (gain > gts->hwgain_table[i].gain) {
+			if (!diff) {
+				diff =3D gain - gts->hwgain_table[i].gain;
+				best =3D i;
+			} else {
+				int tmp =3D gain - gts->hwgain_table[i].gain;
+
+				if (tmp < diff) {
+					diff =3D tmp;
+					best =3D i;
+				}
+			}
+		} else {
+			/*
+			 * We found valid hwgain which is greater than
+			 * reference. So, unless we return a failure below we
+			 * will have found an in-range gain
+			 */
+			*in_range =3D true;
+		}
+	}
+	/* The requested gain was smaller than anything we support */
+	if (!diff) {
+		*in_range =3D false;
+
+		return -EINVAL;
+	}
+
+	return gts->hwgain_table[best].gain;
+}
+EXPORT_SYMBOL_GPL(iio_find_closest_gain_low);
+
+static int iio_gts_get_int_time_gain_multiplier_by_sel(struct iio_gts *gts,
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
+static int iio_gts_find_gain_for_scale_using_time(struct iio_gts *gts, int=
 time_sel,
+						  int scale_int, int scale_nano,
+						  int *gain)
+{
+	u64 scale_linear;
+	int ret, mul;
+
+	ret =3D iio_gts_linearize(scale_int, scale_nano, NANO, &scale_linear);
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
+	if (ret)
+		return ret;
+
+	if (!iio_gts_valid_gain(gts, *gain))
+		return -EINVAL;
+
+	return 0;
+}
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
+static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
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
+	return iio_gts_delinearize(lin_scale, NANO, scale_int, scale_nano);
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
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts=
-helper.h
new file mode 100644
index 000000000000..95c712007962
--- /dev/null
+++ b/include/linux/iio/iio-gts-helper.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* gain-time-scale conversion helpers for IIO light sensors
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef __IIO_GTS_HELPER__
+#define __IIO_GTS_HELPER__
+
+#include <linux/types.h>
+
+struct device;
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
+	int **per_time_avail_scale_tables;
+	int *avail_all_scales_table;
+	int num_avail_all_scales;
+	int *avail_time_tables;
+	int num_avail_time_tables;
+};
+
+#define GAIN_SCALE_GAIN(_gain, _sel)			\
+{							\
+	.gain =3D (_gain),				\
+	.sel =3D (_sel),					\
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
+int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_rang=
e);
+int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain);
+int iio_gts_get_min_gain(struct iio_gts *gts);
+int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel);
+int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time);
+
+int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
+				int *scale_int, int *scale_nano);
+int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int ti=
me_sel,
+					       int scale_int, int scale_nano,
+					       int *gain_sel);
+int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_=
int,
+		      int *scale_nano);
+int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
+					       int old_gain, int old_time_sel,
+					       int new_time_sel, int *new_gain);
+int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gt=
s);
+int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
+			int *length);
+int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *t=
ype,
+			     int *length);
+int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
+				  const int **vals, int *type, int *length);
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

--66ySHrGyfNcLesiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUfIsACgkQeFA3/03a
ocVRsAf+KECI1LANJonjmjuoWocdeApqNsWfraZGfmhcTmahXtmL8T3OmvaIDbw3
KJISQVP9tT6d0F23mxns5uAfdLnbOJMNcWQfkHegNVdeBo/vO3v46rBKowthUyxB
Sb/6Qc2dl1EO21p8XPtuUNCV32uNXBtlrRRB7/qzLdnQEm50l3YOTZz6RLlSnJAz
M3Ge7+LaNPO/CtPztXDX6V6AZYuoZSSSODzyuPF/5ZJkxsx7JbzEY2rPzF+UQrjk
I6YYx0N6pnCo9b0IbFGHVkcUkDNnP82Ly6S90B3n7d+nCB6umXYdpTqT0D6ic8kt
QtiHvepoz5CcOeBEFNgy5HfTwKlUmw==
=88ri
-----END PGP SIGNATURE-----

--66ySHrGyfNcLesiy--
