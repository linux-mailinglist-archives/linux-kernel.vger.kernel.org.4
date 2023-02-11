Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490726932B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBKQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBKQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D81F468C;
        Sat, 11 Feb 2023 08:59:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so8126300wrz.12;
        Sat, 11 Feb 2023 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2taWdDgLTpL4HSFhwsK1VBZDkJon+2YscjEWs17ebXk=;
        b=WLkqV+YDbnq9w/tude0NZVCQkdkwtDVmHXXwbN5QzjcBWFm/vinCEPjNvkbU4AtnLx
         9O7IKWkAToeZjaSBKsSv7tVVkPHGuhJNQWPzksh3fynie3zrJ34unhGhb1bsdzMkue/M
         6GvEx+00Xh3aM6gU1T8hgtU8B3ngqxfdNJ4LidXHPHfP0ctswyFycii4XslrqrODGkDr
         l47hUAZNjUZgXVjt4ZN16Zgb3PJZcYlVYhQwD0YcT8tO0vXJLxTCho36jCCWqtmUVBF6
         r4dEn27wcca4NZXlFeFztbh5HF2hy9ohav/Tgw8eCooHZ8CsfrHslUXkkZsWLWPHd+Uj
         esPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2taWdDgLTpL4HSFhwsK1VBZDkJon+2YscjEWs17ebXk=;
        b=d0iUxVeBfyKeJXG59RatBrAH9uuoYQnEbrmL3dAWyMp98wiz0COD0aRSIntsXftqxH
         f4zv6LuZdPy0ztoyQxuXdP7/jnNp9vxFr3dHOHcP5P+4ZT5nMbK8ybftTBLaLXs04Ri7
         bMjAxE6Uf/DUwVYXiSp0jODDnjP/nsBnH6P8ov/4zG3OwzEGcCEErVlwH3rzvSjHhSik
         zMg9JrGBEPjdcgxpvJSj42pWlU1lo9slA+2tdqzLC0X5O8d57AlzoMnhefUYbpJj2OS0
         hVLLgtO59eGOOoqZ32vcvDVaX9jQn6u3szVAskBLsf9Tzm7YTTE4X7DxWhghs48VsAjC
         UW1Q==
X-Gm-Message-State: AO0yUKXCI4HKZn9vSSKzmrsaQJzJ9m8teLRBsMpEpD51zEfr0SNVgkdB
        6AQb6nxYPZIdUZoO0W4b81APn/LPWXIdKQ==
X-Google-Smtp-Source: AK7set+pzYsN5wGDHt64WllBkjh8BdjpkINHGflTiOkzaQa5dRpmQ4uG36xoe5H9U8nPH6elZFcOHg==
X-Received: by 2002:adf:e80d:0:b0:2c5:51a7:efd4 with SMTP id o13-20020adfe80d000000b002c551a7efd4mr1216289wrm.54.1676134749999;
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:09 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 2/5] hwmon: (aquacomputer_d5next) Support writing multiple control values at once
Date:   Sat, 11 Feb 2023 17:59:20 +0100
Message-Id: <20230211165923.17807-3-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211165923.17807-1-leonard.anderweit@gmail.com>
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new function aqc_set_ctrl_vals() to support changing multiple control
values at once while sending only one control report.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index d69c2396854c..03ef9e0258d2 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -574,9 +574,9 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val, int ty
 	return ret;
 }
 
-static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
+static int aqc_set_ctrl_vals(struct aqc_data *priv, int *offsets, long *vals, int *types, int len)
 {
-	int ret;
+	int ret, i;
 
 	mutex_lock(&priv->mutex);
 
@@ -584,15 +584,17 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int typ
 	if (ret < 0)
 		goto unlock_and_return;
 
-	switch (type) {
-	case AQC_BE16:
-		put_unaligned_be16((s16)val, priv->buffer + offset);
-		break;
-	case AQC_8:
-		priv->buffer[offset] = (u8)val;
-		break;
-	default:
-		ret = -EINVAL;
+	for (i = 0; i < len; i++) {
+		switch (types[i]) {
+		case AQC_BE16:
+			put_unaligned_be16((s16)vals[i], priv->buffer + offsets[i]);
+			break;
+		case AQC_8:
+			priv->buffer[offsets[i]] = (u8)vals[i];
+			break;
+		default:
+			ret = -EINVAL;
+		}
 	}
 	if (ret < 0)
 		goto unlock_and_return;
@@ -604,6 +606,11 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int typ
 	return ret;
 }
 
+static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
+{
+	return aqc_set_ctrl_vals(priv, &offset, &val, &type, 1);
+}
+
 static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
 {
 	const struct aqc_data *priv = data;
-- 
2.39.1

