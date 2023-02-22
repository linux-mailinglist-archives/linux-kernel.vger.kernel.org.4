Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C269F8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBVQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjBVQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:15:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB683D908;
        Wed, 22 Feb 2023 08:15:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m7so10639537lfj.8;
        Wed, 22 Feb 2023 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZP+vTX8kZ9XZ4ezQH1LOcOUqExahRwe8VBSIcJ/Cp4=;
        b=Ga0Sx6kVr2RoKHNTK0J3TFrUfJ6LTCnas72I6Guw6oMMAb9U6XMkpBWrmw8CgOFMbw
         2Pf7XMhnKzNUtkfAipWIP5y8bOgQhqpNh5yUw2L/DhJ+Ql93tsZ5WARmIN16OOiYARt4
         pHPujbkc3ngAralwaWixQPNKv4Hg4u45yAuwkvZT0wq2Fi8db9JT0oBsyievMX3hx7PU
         vRyEqcpNZucSKP9du6vKxzO0vTjXLJGVHipsGiuwZh2a79eiwxXTdljIKUeSXXVh9Lt5
         hP2x5U+wQcOaHCMSsrIOsiIv4jGsyyflCGLj/aRqXH7ypC5I7/HGpU8HBGadRlQQjyLv
         3mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZP+vTX8kZ9XZ4ezQH1LOcOUqExahRwe8VBSIcJ/Cp4=;
        b=4NkaLw2zwC2+0KNDoq0RMpJ3qQ104HNpceZ+LGb2lRLPMOnrbYVPIhWDco03ZMyOV2
         4iu22ASELng4dA+S2chJNmtYleyE2fPzCbgvFEV8jXJlbkgoLMkDHD3SMkfBoj1PN29m
         83OIYJ23opgKxBGLtTjFc3uVU+6Kl61G7xRFQlWL8R/mt7PzfiT5EDkV3w3OlR9TuoFf
         fVOXxcjQ13RqoAFWVU6J/kY7ezxcybw8WiRGGtppttq61bAAdB6R/aOdek15ArpuU45/
         2bLyA6+IQLn8vp3xwiBhvnX60g4EOXO9yAPM6ccorXW50NS08r/TmSZY9hYRoSAkhcR0
         jCbw==
X-Gm-Message-State: AO0yUKXFu+TB/1zWLnVSjE4WBnBI6OfLdK4DzPxl5apGy/ajx9dq++0w
        /LWWZ+VYzR14UqzaPQ/s0z0=
X-Google-Smtp-Source: AK7set/Sa+UALc40XgcOoAor4Ql2Cxfh+AGu6Lf1gRR17v4skFwZtYwtMxUL+H/8Y/BHZ5sHk9+U+w==
X-Received: by 2002:ac2:51c6:0:b0:4db:3e39:e8e2 with SMTP id u6-20020ac251c6000000b004db3e39e8e2mr3012237lfm.68.1677082509771;
        Wed, 22 Feb 2023 08:15:09 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w22-20020ac254b6000000b004cb14fa604csm181111lfk.262.2023.02.22.08.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:15:09 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:15:04 +0200
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
Subject: [RFC PATCH 3/6] iio: test: test gain-time-scale helpers
Message-ID: <5e1fdcd95544d40432adbb4ecd380da97a7d93ea.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vD0LhBStuWyBzUeR"
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


--vD0LhBStuWyBzUeR
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
Hence some gain-time-scale helpers were introduced.

Add some simple tests to verify the most hairy functions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/test/Kconfig        |  15 ++
 drivers/iio/test/Makefile       |   1 +
 drivers/iio/test/iio-test-gts.c | 331 ++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 drivers/iio/test/iio-test-gts.c

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 0b6e4e278a2f..b57f1fc440e6 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,19 @@
 #
=20
 # Keep in alphabetical order
+config IIO_GTS_KUNIT_TEST
+	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select IIO_GTS_HELPER
+	default KUNIT_ALL_TESTS
+	help
+	  build unit tests for the IIO light sensor gain-time-scale helpers.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N. Keep in alphabetical order
+
 config IIO_RESCALE_KUNIT_TEST
 	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT && IIO_RESCALE
@@ -27,3 +40,5 @@ config IIO_FORMAT_KUNIT_TEST
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
=20
 	  If unsure, say N.
+
+
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index d76eaf36da82..e9a4cf1ff57f 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -6,4 +6,5 @@
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) +=3D iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) +=3D iio-test-format.o
+obj-$(CONFIG_IIO_GTS_KUNIT_TEST) +=3D iio-test-gts.o
 CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gt=
s.c
new file mode 100644
index 000000000000..0096dd19e009
--- /dev/null
+++ b/drivers/iio/test/iio-test-gts.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unit tests for IIO light sensor gain-time-scale helpers
+ *
+ * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include "../light/gain-time-scale-helper.h"
+
+/*
+ * Please, read the "rant" from the top of the lib/test_linear_ranges.c if
+ * you see a line of helper code which is not being tested.
+ *
+ * Then, please look at the line which is not being tested. Is this line
+ * somehow unusually complex? If answer is "no", then chances are that the
+ * "development inertia" caused by adding a test exceeds the benefits.
+ *
+ * If yes, then adding a test is probably a good idea but please stop for a
+ * moment and consider the effort of changing all the tests when code gets
+ * refactored. Eventually it neeeds to be.
+ */
+
+#define TEST_TSEL_50		1
+#define TEST_TSEL_X_MIN		TEST_TSEL_50
+#define TEST_TSEL_100		0
+#define TEST_TSEL_200		2
+#define TEST_TSEL_400		4
+#define TEST_TSEL_X_MAX		TEST_TSEL_400
+
+#define TEST_GSEL_1		0x00
+#define TEST_GSEL_X_MIN		TEST_GSEL_1
+#define TEST_GSEL_4		0x08
+#define TEST_GSEL_16		0x0a
+#define TEST_GSEL_32		0x0b
+#define TEST_GSEL_64		0x0c
+#define TEST_GSEL_256		0x18
+#define TEST_GSEL_512		0x19
+#define TEST_GSEL_1024		0x1a
+#define TEST_GSEL_2048		0x1b
+#define TEST_GSEL_4096		0x1c
+#define TEST_GSEL_X_MAX		TEST_GSEL_4096
+
+#define TEST_SCALE_1X		64
+#define TEST_SCALE_MIN_X	TEST_SCALE_1X
+#define TEST_SCALE_2X		32
+#define TEST_SCALE_4X		16
+#define TEST_SCALE_8X		8
+#define TEST_SCALE_16X		4
+#define TEST_SCALE_32X		2
+#define TEST_SCALE_64X		1
+
+#define TEST_SCALE_NANO_128X	500000000
+#define TEST_SCALE_NANO_256X	250000000
+#define TEST_SCALE_NANO_512X	125000000
+#define TEST_SCALE_NANO_1024X	62500000
+#define TEST_SCALE_NANO_2048X	31250000
+#define TEST_SCALE_NANO_4096X	15625000
+#define TEST_SCALE_NANO_4096X2	7812500
+#define TEST_SCALE_NANO_4096X4	3906250
+#define TEST_SCALE_NANO_4096X8	1953125
+
+#define TEST_SCALE_NANO_MAX_X TEST_SCALE_NANO_4096X8
+
+static const struct iio_gain_sel_pair gts_test_gains[] =3D {
+	GAIN_SCALE_GAIN(1, TEST_GSEL_1),
+	GAIN_SCALE_GAIN(4, TEST_GSEL_4),
+	GAIN_SCALE_GAIN(16, TEST_GSEL_16),
+	GAIN_SCALE_GAIN(32, TEST_GSEL_32),
+	GAIN_SCALE_GAIN(64, TEST_GSEL_64),
+	GAIN_SCALE_GAIN(256, TEST_GSEL_256),
+	GAIN_SCALE_GAIN(512, TEST_GSEL_512),
+	GAIN_SCALE_GAIN(1024, TEST_GSEL_1024),
+	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
+	GAIN_SCALE_GAIN(4096, TEST_GSEL_4096),
+#define HWGAIN_MAX 4096
+};
+
+static const struct iio_itime_sel_mul gts_test_itimes[] =3D {
+	GAIN_SCALE_ITIME_MS(400, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_MS(200, TEST_TSEL_200, 4),
+	GAIN_SCALE_ITIME_MS(100, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_MS(50, TEST_TSEL_50, 1),
+#define TIMEGAIN_MAX 8
+};
+#define TOTAL_GAIN_MAX	(HWGAIN_MAX * TIMEGAIN_MAX)
+
+static int test_init_iio_gain_scale(struct iio_gts *gts, int max_scale_int,
+				int max_scale_nano)
+{
+	int ret;
+
+	ret =3D iio_init_iio_gts(max_scale_int, max_scale_nano, gts_test_gains,
+			       ARRAY_SIZE(gts_test_gains), gts_test_itimes,
+			       ARRAY_SIZE(gts_test_itimes), gts);
+
+	return ret;
+}
+
+static void test_iio_gts_find_gain_for_scale_using_time(struct kunit *test)
+{
+	struct iio_gts gts;
+	int ret, gain;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_100,
+						     TEST_SCALE_8X, 0, &gain);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_8X matches total gain 8x
+	 * =3D> required HWGAIN 4x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 4, gain);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_256X, &gain);
+	/*
+	 * Meas time 200 =3D> gain by time 4x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/4 =3D> 64x
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 64, gain);
+
+	/* Min time, Min gain */
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_X_MIN,
+						TEST_SCALE_MIN_X, 0, &gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 1, gain);
+
+	/* Max time, Max gain */
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_X_MAX, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 4096, gain);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_100, 0,
+						TEST_SCALE_NANO_256X, &gain);
+	/*
+	 * Meas time 100 =3D> gain by time 2x
+	 * TEST_SCALE_256X matches total gain 256x
+	 * =3D> required HWGAIN 256/2 =3D> 128x (not in gain-table - unsupported)
+	 */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_200, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	ret =3D iio_gts_find_gain_for_scale_using_time(&gts, TEST_TSEL_50, 0,
+						TEST_SCALE_NANO_MAX_X, &gain);
+	/* We can't reach the max gain with integration time smaller than MAX */
+	KUNIT_EXPECT_NE(test, 0, ret);
+}
+
+static void test_iio_gts_find_time_and_gain_sel_for_scale(struct kunit *te=
st)
+{
+	struct iio_gts gts;
+	int ret, gain_sel, time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, 0,
+			TEST_SCALE_NANO_256X, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_32, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_400, time_sel);
+
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, TEST_SCALE_64X,
+						       0, &gain_sel, &time_sel);
+	/*
+	 * We should find time 200 (4x) and gain 64/4 =3D> 16x. The most
+	 * preferred time 400 (8x) would require gain 8x - which is not
+	 * "supported".
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_16, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_200, time_sel);
+
+	/* Min gain */
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, TEST_SCALE_MIN_X,
+						0, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_1, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_50, time_sel);
+
+	/* Max gain */
+	ret =3D iio_gts_find_time_and_gain_sel_for_scale(&gts, 0,
+			TEST_SCALE_NANO_MAX_X, &gain_sel, &time_sel);
+	/*
+	 * We should find time 400 (8x) and gain 256/8 =3D> 32x because the
+	 * time 400 is listed first
+	 */
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, TEST_GSEL_X_MAX, gain_sel);
+	KUNIT_EXPECT_EQ(test, TEST_TSEL_X_MAX, time_sel);
+}
+
+static void test_iio_gts_get_total_gain_by_sel(struct kunit *test)
+{
+	struct iio_gts gts;
+	int ret, gain_sel, time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	/* gain x32, time x4 =3D> total gain 32 * 4 =3D 128 */
+	gain_sel =3D TEST_GSEL_32;
+	time_sel =3D TEST_TSEL_200;
+
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	/* gain x32, time x8 =3D> total gain 32 * 4 =3D 128 */
+	KUNIT_EXPECT_EQ(test, 128, ret);
+
+	gain_sel =3D TEST_GSEL_X_MAX;
+	time_sel =3D TEST_TSEL_X_MAX;
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	KUNIT_EXPECT_EQ(test, TOTAL_GAIN_MAX, ret);
+
+	gain_sel =3D TEST_GSEL_X_MIN;
+	time_sel =3D TEST_TSEL_X_MIN;
+	ret =3D iio_gts_get_total_gain_by_sel(&gts, gain_sel, time_sel);
+	KUNIT_EXPECT_EQ(test, 1, ret);
+}
+
+static void test_iio_gts_find_new_gain_sel_by_old_gain_time(struct kunit *=
test)
+{
+	struct iio_gts gts;
+	int ret, old_gain, new_gain, old_time_sel, new_time_sel;
+
+	ret =3D test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (ret)
+		return;
+
+	old_gain =3D 32;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * Doubling the integration time doubles the total gain - so old
+	 * (hw)gain must be divided by two to compensate. =3D> 32 / 2 =3D> 16
+	 */
+	KUNIT_EXPECT_EQ(test, 16, new_gain);
+
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_200;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 1x =3D> 4x - (hw)gain 4x =3D> 1x
+	 */
+	KUNIT_EXPECT_EQ(test, 1, new_gain);
+
+	old_gain =3D 512;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	/*
+	 * gain by time 8x =3D> 1x - (hw)gain 512x =3D> 4096x)
+	 */
+	KUNIT_EXPECT_EQ(test, 4096, new_gain);
+
+	/* Unsupported gain 2x */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_200;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too small gain */
+	old_gain =3D 4;
+	old_time_sel =3D TEST_TSEL_50;
+	new_time_sel =3D TEST_TSEL_400;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+
+	/* Too big gain */
+	old_gain =3D 1024;
+	old_time_sel =3D TEST_TSEL_400;
+	new_time_sel =3D TEST_TSEL_50;
+	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&gts, old_gain,
+					old_time_sel, new_time_sel, &new_gain);
+	KUNIT_EXPECT_NE(test, 0, ret);
+}
+
+static struct kunit_case iio_gts_test_cases[] =3D {
+		KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
+		KUNIT_CASE(test_iio_gts_find_time_and_gain_sel_for_scale),
+		KUNIT_CASE(test_iio_gts_get_total_gain_by_sel),
+		KUNIT_CASE(test_iio_gts_find_new_gain_sel_by_old_gain_time),
+		{}
+};
+
+static struct kunit_suite iio_gts_test_suite =3D {
+	.name =3D "iio-gain-time-scale",
+	.test_cases =3D iio_gts_test_cases,
+};
+
+kunit_test_suite(iio_gts_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Test IIO light sensor gain-time-scale helpers");
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

--vD0LhBStuWyBzUeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2P4gACgkQeFA3/03a
ocXvcwgAh/XgsmFTQc7hJfkPJzMQpigtOK+Q+J9RY+LbWP90VFEyTYMWRh90j4sG
JguCGf7cOO0uDzpb5K+R39XWbkWYang3LyZpKtSQsriHesbynhcerIO7rM6RG6lk
Ezvd2KDuBstYkgfDcGd9wYvimlcJaA13qKLggBHkZda5xO1ougiLD3TWLhMre548
qdNaJz2JqCEDXG/+j0cu6viPFKHpm7ffqyFGsMTmfshOW97c3xyYCIw4LXZX7vPo
LoomF7cmXhS2zcK7WGwTWeXhw18VKQjQU7yrujxiXS2OWdxLxMYGDg7m5TaQK4LP
I2yJJewjHyc6teqNbmRU6hUCDBtBQg==
=5j16
-----END PGP SIGNATURE-----

--vD0LhBStuWyBzUeR--
