Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440B69705A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjBNWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43030B24;
        Tue, 14 Feb 2023 14:01:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so144697wmb.5;
        Tue, 14 Feb 2023 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM8rk8AOAbfRjfXoKyQDHMPFgTmFtxGgcgSbiV7qN7Y=;
        b=oSMZ6mfOvLg0dWdh5AfewbBS1pXTj0PyCri7L8C7dbsDJ2Z6fqb4guvjWT3q7CZsG3
         px/rZI1Hagkn1SvHPt4NVwUFjhdoSUI6qHRjehbfCAZF9NZBHDVHFxBRhM35G4cMTzte
         jE46pbns7UdJaVLrdJUbUTXRIUf5ZiRbtm4M+f7NZkNvVGCWMmWbEryz4W1zBMF/4slX
         ciR3P4ZU8v4kIHgDTq8Xh1bdv8PjJqMElF5PxVudiaTPSUP70b34F2+eHQAmbv4PWQF5
         1K6fXqmSdor1wU3kKwMf2XF/MKetuT7CJLr8bL+W+C7HdVjysk+eUiBGwrEEH/+779fr
         lgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM8rk8AOAbfRjfXoKyQDHMPFgTmFtxGgcgSbiV7qN7Y=;
        b=gxe2p49OIw+LhoXqq1yQ0RUk6AEKj94c4ry0ViVzRW6rXiwVnCKnO5++5AMu1/WR11
         Clf676azJd4AH0100GaSC2TlxJGzV8BQtgWcd95GNZecrgIdQlolw1kcqIreMqT+IoyL
         PbDmjrHgPX11XYfUsKGHOMa/ApLxi9Tnz8pktww3RhxE/cyckv1SiMg/hqsogHtBtFBz
         qTAmcm2lTD+JVYCfF2/4yu5I0lHNimh3u6Mh6tmuvL8z9enVxxGXS3D9rbN8xVhfNJEa
         UTNMDOTz/e0e6XV3JJA+XdC9sR7AstZC2xfvwq3yfO1hreSy0PQeINoe0YxtUHFHLPdo
         OiqQ==
X-Gm-Message-State: AO0yUKXR8OnLvfmwN4F1LFG/YK1FJ8N8avLU6k+mWBI4DScNHsru2zVc
        OvE7XVDN0ECyhOIPT3NWcu7OZM7Epw6/9g==
X-Google-Smtp-Source: AK7set8ndCtMX8GsrLwXKjy5YXLy5mGCx5n+AUH1mEcLQfe28zp3Oz4LQCUB2G2GoyE0gBXqLjatyg==
X-Received: by 2002:a05:600c:2b46:b0:3dc:932f:f7cb with SMTP id e6-20020a05600c2b4600b003dc932ff7cbmr255079wmf.37.1676412112169;
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:51 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 2/6] hwmon: (aquacomputer_d5next) Support writing multiple control values at once
Date:   Tue, 14 Feb 2023 23:02:17 +0100
Message-Id: <20230214220221.15003-3-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214220221.15003-1-leonard.anderweit@gmail.com>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
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
index babfd998e70c..f0c036d38e91 100644
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
@@ -605,6 +607,11 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int typ
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

