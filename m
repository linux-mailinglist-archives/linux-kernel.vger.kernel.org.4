Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF36EAA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjDUMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjDUMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:42:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63FD309;
        Fri, 21 Apr 2023 05:42:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 036DE40004;
        Fri, 21 Apr 2023 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682080915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecGQES+IctsZxeHGmbZiv99zRKwWx/U6QMun/YsCg54=;
        b=Y2Uy4aX0fJLJin3UbJuHlp6xKyONaXP+q/4E6traJCaV4jgmMdm3TsvfcgIBmqlsoee0CF
        zT9VC+AnT8ScfxXu35DaKXKyN6XZvWtUjwQULTMwh1h5C0fRNf2CwmQWLmbfleahnmYjXX
        SiI8pO1SgPpnwt3yS6RAHsotNbZlJdp3oPLXK5KZudsMH/cQGQy27Yy5X0sWHIZ/BZMdIV
        h3GITU6Nxe+bCB+QzISMmVKb1l6g/nrEiMkI0RPMX6YxPeQ3ClFV9qjERP4OZmjJCKbKd9
        DtCX5vjcjqW7EPRdRpqZLWwK6U9FfWcsg03OZmma3d+DiL2V/zpDZMehsrVBvw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/4] iio: inkern: Add a helper to query an available minimum raw value
Date:   Fri, 21 Apr 2023 14:41:20 +0200
Message-Id: <20230421124122.324820-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421124122.324820-1-herve.codina@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A helper, iio_read_max_channel_raw() exists to read the available
maximum raw value of a channel but nothing similar exists to read the
available minimum raw value.

This new helper, iio_read_min_channel_raw(), fills the hole and can be
used for reading the available minimum raw value of a channel.
It is fully based on the existing iio_read_max_channel_raw().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/iio/inkern.c         | 67 ++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 11 ++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..914fc69c718a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -912,6 +912,73 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 }
 EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
 
+static int iio_channel_read_min(struct iio_channel *chan,
+				int *val, int *val2, int *type,
+				enum iio_chan_info_enum info)
+{
+	int unused;
+	const int *vals;
+	int length;
+	int ret;
+
+	if (!val2)
+		val2 = &unused;
+
+	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	switch (ret) {
+	case IIO_AVAIL_RANGE:
+		switch (*type) {
+		case IIO_VAL_INT:
+			*val = vals[0];
+			break;
+		default:
+			*val = vals[0];
+			*val2 = vals[1];
+		}
+		return 0;
+
+	case IIO_AVAIL_LIST:
+		if (length <= 0)
+			return -EINVAL;
+		switch (*type) {
+		case IIO_VAL_INT:
+			*val = vals[--length];
+			while (length) {
+				if (vals[--length] < *val)
+					*val = vals[length];
+			}
+			break;
+		default:
+			/* FIXME: learn about min for other iio values */
+			return -EINVAL;
+		}
+		return 0;
+
+	default:
+		return ret;
+	}
+}
+
+int iio_read_min_channel_raw(struct iio_channel *chan, int *val)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
+	int ret;
+	int type;
+
+	mutex_lock(&iio_dev_opaque->info_exist_lock);
+	if (!chan->indio_dev->info) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read_min(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
+err_unlock:
+	mutex_unlock(&iio_dev_opaque->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_min_channel_raw);
+
 int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..956120d8b5a3 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -297,6 +297,17 @@ int iio_write_channel_raw(struct iio_channel *chan, int val);
  */
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
 
+/**
+ * iio_read_min_channel_raw() - read minimum available raw value from a given
+ *				channel, i.e. the minimum possible value.
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ *
+ * Note raw reads from iio channels are in adc counts and hence
+ * scale will need to be applied if standard units are required.
+ */
+int iio_read_min_channel_raw(struct iio_channel *chan, int *val);
+
 /**
  * iio_read_avail_channel_raw() - read available raw values from a given channel
  * @chan:		The channel being queried.
-- 
2.39.2

