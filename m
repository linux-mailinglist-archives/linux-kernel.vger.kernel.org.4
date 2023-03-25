Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B076C8E83
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCYN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCYN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:28:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBEAF31
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b20so18343151edd.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679750916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cG1+U1VS4mH8d3SR6UASaJ11y3INr/ZiCFmx1pUYXo=;
        b=gq9tvb7Hv3OJY3O9pPIimpfkWwxyNLV3n4S1GHoza2Fp1Y5BGEuywsmyKyalgbbhOy
         edWYfoUbOSvJz0+cIAAFbCR/Erk4ID1ndbbXj/1/9lzPGm73dXgqGxas47ZPSZFpyhD/
         xSlIg+Pm56UfMOOZFe/5L6TwCI6J2qtMnTgyeqoKO4TlBjcmoP825wt6+Y+JVfsiop79
         v9JfyBhTC1iOJtaRNaC/6uslJyO5eAJu55uKBC2e18NnqNBJ5jlb6Rg4hnV3CE3DFPRG
         b8dyRV4bsjDlI3OAhV8IYweCCvpsZi33HdWQOmZQ8NFsaJYPQY3T1Pwo0AByaMWjfqu2
         +O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cG1+U1VS4mH8d3SR6UASaJ11y3INr/ZiCFmx1pUYXo=;
        b=4OjHEmL31LtXFhhE/9Q8Y628Uu/d8OL8AmV+vwh3dxOHTUdyGrT6tV9pkC/qqfu/yM
         8lbg6HxPOj0eku5x4umwjx9YClsMkq3aynIbzqZuOliKjpcGXegDLcar/ing7r32mkaA
         RBbkLuiEAO5XjiEHUm4NGYoFAehv8+1S2P+A3/SwwUV2YhaqSHx7T8j2sI3/AeYdxUoq
         SIpQ6/zFewSVwZEj6MviZA1mcyOAR1Mp/g0s63D106sf6A74mh+aF/YyWUggzV3zKjhr
         lMbIzkMGvutZkjYazcuqrXXawXocAtvdN63p/7/SSmOmN13O7272F9uJMwq45UwRM+75
         TS7w==
X-Gm-Message-State: AAQBX9eSAKGQ28khDMQ8025tR4WdPFBTIfYBD4/3CgISQEtQ+hUwgvtD
        MO7pgz0wnPo1IBDhJqAtW2M=
X-Google-Smtp-Source: AKy350YQEnwXNX6f6qG5LvZw4wfl292mwIcKULob0AWL8a5z9mspw9Qa0RnXz9CptFat8cvDzR4/Gw==
X-Received: by 2002:aa7:cd71:0:b0:4fa:c7c9:62ea with SMTP id ca17-20020aa7cd71000000b004fac7c962eamr6627224edb.11.1679750916313;
        Sat, 25 Mar 2023 06:28:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbe9.dynamic.kabel-deutschland.de. [95.90.187.233])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm11727610ejb.74.2023.03.25.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:28:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8192e: remove rf_type from struct r8192_priv
Date:   Sat, 25 Mar 2023 14:28:23 +0100
Message-Id: <20230325132823.22872-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325132823.22872-1-straube.linux@gmail.com>
References: <20230325132823.22872-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field rf_type of struct r8192_priv is always RF_1T2R and only used
in one place. Use RF_1T2R directly there and remove rf_type from struct
r8192_priv.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 2 +-
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b237970ecf85..1eb063fe660a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -343,8 +343,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	else
 		priv->tx_pwr_data_read_from_eeprom = false;
 
-	priv->rf_type = RF_1T2R;
-
 	if (priv->card_8192_version > VERSION_8190_BD) {
 		if (!priv->autoload_fail_flag) {
 			tempval = (rtl92e_eeprom_read(dev,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 914cd28897a5..1e99eb833405 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -289,7 +289,6 @@ struct r8192_priv {
 	enum nic_t card_8192;
 	u8 card_8192_version;
 
-	u8 rf_type;
 	u8 ic_cut;
 	char nick[IW_ESSID_MAX_SIZE + 1];
 	u8 check_roaming_cnt;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 46be638677d9..d45808760638 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -532,7 +532,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	priv->rtllib->bdynamic_txpower_enable = false;
 
 	powerlevelOFDM24G = priv->pwr_track >> 24;
-	RF_Type = priv->rf_type;
+	RF_Type = RF_1T2R;
 	Value = (RF_Type<<8) | powerlevelOFDM24G;
 
 	for (j = 0; j <= 30; j++) {
-- 
2.40.0

