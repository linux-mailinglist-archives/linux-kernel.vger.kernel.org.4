Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2170E004
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjEWPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjEWPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:13:00 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1118E;
        Tue, 23 May 2023 08:12:49 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id E0A95C0003;
        Tue, 23 May 2023 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6wIbPlk+sj6CdZp+Zuzd40lnLgxHVN50MgCxORNnY8=;
        b=jP6jBYujyeZx6X332heui2VJL16U7AzCW3vRSIz0ewZFtPtxlyxjZtVeFB8kQkprD8paxU
        Yr0eWkm1yaW/OOQ6+vlTRY1zscjzVn1COnKeZ4GmVPc3eNVFbJuaSb1l+vwojg3zSloMf3
        yIEj34rk/kxXtdQkEODM+DqhBLca6pwBDT+t9e23wopKuP6BqTJ4MoORm6el/gcdZW1V+L
        ZF2I/SqzRV4SH6nwka6/tzPUwQUsX6mSPhgZSL9HAf2SAPbLbk1dGA7H4ry/qOZlNovOst
        cysuG+zyzlqXbP3bRZFmE7YApdvmeYBXjnZy/dsTnVxeGZAsXGyuvJp+ad08ug==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 5/9] iio: inkern: Add a helper to query an available minimum raw value
Date:   Tue, 23 May 2023 17:12:19 +0200
Message-Id: <20230523151223.109551-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
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
 drivers/iio/inkern.c         | 70 ++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 12 +++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f738db9a0c04..07b26ff8a334 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -915,6 +915,76 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
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
+	if (ret < 0)
+		return ret;
+
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
+		return -EINVAL;
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
index f536820b9cf2..e9910b41d48e 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -301,6 +301,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val);
  */
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
 
+/**
+ * iio_read_min_channel_raw() - read minimum available raw value from a given
+ *				channel, i.e. the minimum possible value.
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ *
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
+ */
+int iio_read_min_channel_raw(struct iio_channel *chan, int *val);
+
 /**
  * iio_read_avail_channel_raw() - read available raw values from a given channel
  * @chan:		The channel being queried.
-- 
2.40.1

