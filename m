Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1596B6B20
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCLUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCLUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7742936696
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678653533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/pT5phCMTi5s8pjQ+Qg8pTnSiAKPp+ir9fSlnZIuwYY=;
        b=EVJv7F+xfO5do5dyRqiecMUykSgFbMZgx8UhUbSIi5wx+xX3i7QMggPLFGOeW7aMj8i4Bd
        LXraS7f6+u+/7UvIXl/IyeMm4fYKp3zYAEQRYSsppNC+74WvNYrjg/LmJXAMwhrwNTmqr9
        UpfA1PcatbMfQpD9Kkj5490eZkkqoGU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-bExvjNIWMTWEA7eH1S5vKw-1; Sun, 12 Mar 2023 16:38:52 -0400
X-MC-Unique: bExvjNIWMTWEA7eH1S5vKw-1
Received: by mail-qk1-f200.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso5516569qka.22
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pT5phCMTi5s8pjQ+Qg8pTnSiAKPp+ir9fSlnZIuwYY=;
        b=Dtj6TiAJtSgxLAG8J+3uKMVAitH5veyX2//Bx4iROPvHWyEyWN87BdIGYHDaQDFbMf
         WTw1rNkUfdC9XHa76fbzX/Ar1b1lI9ZTE1e6ELBQevIsAeMM8u0V/qVK6E0SVawq/Byi
         AJz6LcakeJG+/6nZiJcqy6Zykn0kLy/3vl8q7Kw/9du7fYhGroby6MaH6aJOUlX9aC9K
         agfgtnv9YITe8ytSo5s1gXhsZTt8tifnUX3u3WlcaWa9zJrkyWlHc/5cLSeepG3eKXwg
         lPh+JY6IE7/ug4Hix/RF5G8KS8Npt0SUZ2CMq+nRZBDUOuEQeRX5btlHm6f2jrkVWjDl
         WWjA==
X-Gm-Message-State: AO0yUKXaHx4UKlO/J6CFUHx9GgINeCKBmrn5MbaEuJkGUQYJ4Qjd+9Cg
        mWF5lpWJ8fhO+b4/RLUaeG7l0uYfk32r6/pHseE5YEovQ8MPtMDqVYSOO5VZJlydkcyjQ7g9FTW
        g+aj8XmsKgslgJyUCuaTejxpZ
X-Received: by 2002:a05:6214:5195:b0:56b:eceb:2d9d with SMTP id kl21-20020a056214519500b0056beceb2d9dmr9179574qvb.36.1678653531620;
        Sun, 12 Mar 2023 13:38:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set/01AOcYu0WzBjJNTT6hOmhHOVPiKK7FIFjZXYoappbmLrE0dT7+7RHTVc7TIvpWW+88gevpg==
X-Received: by 2002:a05:6214:5195:b0:56b:eceb:2d9d with SMTP id kl21-20020a056214519500b0056beceb2d9dmr9179557qvb.36.1678653531370;
        Sun, 12 Mar 2023 13:38:51 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f17-20020ac840d1000000b003bfc2fc3235sm4200222qtm.67.2023.03.12.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:38:50 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] thermal/drivers/tsens: set some tsens_* variables storage-class-specifier to static
Date:   Sun, 12 Mar 2023 16:38:46 -0400
Message-Id: <20230312203846.474395-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports several warnings
drivers/thermal/qcom/tsens-v1.c:24:40: warning:
  symbol 'tsens_qcs404_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v1.c:45:40: warning:
  symbol 'tsens_8976_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:26:40: warning:
  symbol 'tsens_8916_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:42:40: warning:
  symbol 'tsens_8939_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:62:40: warning:
  symbol 'tsens_8974_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:84:40: warning:
  symbol 'tsens_8974_backup_nvmem' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:106:40: warning:
  symbol 'tsens_9607_nvmem' was not declared. Should it be static?

Most variables are only used in their defining files, so they should be static.

The variables tsens_8976_nvmem, tsens_9607_nvmem and tsens_8939_nvmem
are unused so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 42 +++----------------------------
 drivers/thermal/qcom/tsens-v1.c   | 24 +-----------------
 2 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89c6f39a3ae..0d3670f03227 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -23,7 +23,7 @@
 
 #define BIT_APPEND		0x3
 
-struct tsens_legacy_calibration_format tsens_8916_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	.base_len = 7,
 	.base_shift = 3,
 	.sp_len = 5,
@@ -39,27 +39,7 @@ struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8939_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 12, 0 },
-	.invalid = { 12, 2 },
-	.base = { { 0, 0 }, { 1, 24 } },
-	.sp = {
-		{ { 12, 3 },  { 12, 9 } },
-		{ { 12, 15 }, { 12, 21 } },
-		{ { 12, 27 }, { 13, 1 } },
-		{ { 13, 7 },  { 13, 13 } },
-		{ { 13, 19 }, { 13, 25 } },
-		{ { 0, 8 },   { 0, 14 } },
-		{ { 0, 20 },  { 0, 26 } },
-		{ { 1, 0 },   { 1, 6 } },
-		{ { 1, 12 },  { 1, 18 } },
-	},
-};
-
-struct tsens_legacy_calibration_format tsens_8974_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
@@ -81,7 +61,7 @@ struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
+static struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
@@ -103,22 +83,6 @@ struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_9607_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 2, 20 },
-	.invalid = { 2, 22 },
-	.base = { { 0, 0 }, { 2, 12 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 0 },  { 2, 6 } },
-	},
-};
-
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	u32 p1[5], p2[5];
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index b822a426066d..dc1c4ae2d8b0 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -21,7 +21,7 @@
 #define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
 #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
-struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
+static struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
 	.sp_len = 6,
@@ -42,28 +42,6 @@ struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8976_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 4, 0 },
-	.invalid = { 4, 2 },
-	.base = { { 0, 0 }, { 2, 8 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 8 },  { 2, 14 } },
-		{ { 2, 20 }, { 2, 26 } },
-		{ { 3, 0 },  { 3, 6 } },
-		{ { 3, 12 }, { 3, 18 } },
-		{ { 4, 2 },  { 4, 9 } },
-		{ { 4, 14 }, { 4, 21 } },
-		{ { 4, 26 }, { 5, 1 } },
-	},
-};
-
 static int calibrate_v1(struct tsens_priv *priv)
 {
 	u32 p1[10], p2[10];
-- 
2.27.0

