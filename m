Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7B6DC103
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDISgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDISgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 14:36:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31C2718;
        Sun,  9 Apr 2023 11:36:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb12so7888176ejc.11;
        Sun, 09 Apr 2023 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681065390; x=1683657390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2y4ygWlp1XtLpzWSCbAKMVQBAQ+UpChcysa/+QsWFe8=;
        b=FXntkwshA1IsfYDjrBcvGOpZG+U4tpT5QTkAhX6HCQrlE8Jhbb+4XWAIEzoDq+i6fT
         pTD2oxQOcOnY/V/hq49mBE2Nr8wCI/2iHQ3bWQv9hAPW8xgmk3OI4e2TpU2orpAuqNDR
         73BrLafMJRgkLsUsIPI3JxN1GSH/ZQmWcoROZX8Ry4gAiKSv3gl8XybaUu6BrXeohDOK
         tQbI+290+EuuaiCvNSjl2ApHpvU+dAiEoWYfhy+tfbZp1qNfTptQf4ciHKxZ25EI4Lsh
         k2msxKKPCyf9oq9nWrEmPswmAsGdGe930O0X/roiPlFmEsw8QsMh0IF3KR5uqzSjEEwE
         UpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681065390; x=1683657390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2y4ygWlp1XtLpzWSCbAKMVQBAQ+UpChcysa/+QsWFe8=;
        b=Y5GoIstmSAgn0KRPCsqJ+DQ2GUG1d2gqD66nRZ5QH13CNaN9Xziqa27nMq6+lqLuzE
         w98htGt8fLlKJ55Au+qMdIBng9dCwiO4/RtjgXt0upKn3uXuzX0baRjAWT+PRcrFuKRy
         qi9eCG4XeJvsbzVPmcx3LDuEILwNA9ke4NNd/4UutBS5Jp5B2lnz/qnRbBBpCgzgHCVv
         T+kshmffTSW+LfqBq+QTpnj/h9vcRVQvREc0M4Ok5Fr2yGFM/tugv6Cm2e4P1k/uyhBy
         0hsMhh/wwXf3aWBh03gpV4Xvqv3xsamBXmLeB7NdI4UCoEEnR4HLW6I3HRjI58LvpEtZ
         c6CQ==
X-Gm-Message-State: AAQBX9f84TsnIBc4usEHOp6Smx1gBfETEhFGSaCGqEKt4McmjlqBzsUK
        yws6oDnyaTYD7wNYJN3j3z9FevJu6fI=
X-Google-Smtp-Source: AKy350a9BGbXQ/bwENqDYNOrVOCh458scs764LYZBb4cZGGoHX/9GIVTrCU9v4dc9bkFjYoZhT5auw==
X-Received: by 2002:a17:907:1ca3:b0:92e:eecf:b742 with SMTP id nb35-20020a1709071ca300b0092eeecfb742mr6688894ejc.2.1681065389722;
        Sun, 09 Apr 2023 11:36:29 -0700 (PDT)
Received: from fedora.. ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id op14-20020a170906bcee00b0093408d33875sm4324095ejb.49.2023.04.09.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 11:36:29 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Fix alignment of function call params
Date:   Sun,  9 Apr 2023 20:35:49 +0200
Message-Id: <20230409183549.12683-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch warns that alignment of parameters of function call around
line 869 is off. Indent them properly.

Fixes: 6f5cdf9b9a86 ("hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 3bd35d833e69..7db7769fe044 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -867,8 +867,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		switch (priv->kind) {
 		case aquaero:
 			ret = aqc_get_ctrl_val(priv,
-				AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
-				val, AQC_BE16);
+					       AQUAERO_CTRL_PRESET_START +
+					       channel * AQUAERO_CTRL_PRESET_SIZE, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			*val = aqc_percent_to_pwm(*val);
-- 
2.39.2

