Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE374F33C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGKPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:21:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBB7100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:21:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so38294945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689088909; x=1691680909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/t6qi+ZyC/g4PTUhHmZaN3Bd0vINMuJ9GK/6w6tG3Y=;
        b=NGdSCtEbbcI54tvXZi5EFRKNLYcvV4MbW+cSR1SllhjKokjuRkbK8nXanzVnbroUKY
         8VhyP2t+Eye9PN0czoBYcdnN/2/JPSe71Jb3tcNsp3AmeoW14BMFRocoKBesooLATb+E
         uN7AD8lykUwjmTEQwMAyZ5mPsr7IDHTgkQD/Lp890sUWlaEk7JI8pA3USaWCxT3c3mCC
         sEDtz6R4N1niSTZAJhTKMvXyWLtI3DN1y8iMYj9D7jOpfTknUa0Lv4wM2FgLDcTmrDie
         Q3qOguTpN8D+dVx3V/2qFKF0tR+0NYpURe8QYSngakjyYVThsVY5PR0bR5W7+tc83pWT
         5aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088909; x=1691680909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/t6qi+ZyC/g4PTUhHmZaN3Bd0vINMuJ9GK/6w6tG3Y=;
        b=j+dYrKjaAGW2pU7PDnmttxCKU59Wxq+nj0ZUJLTg6jRmM9XUTFlpKv/uVK0QlAVABs
         wGBMHk6pvAjQ4D6KOgN68rbItZb4/3UmMrJRZNVsHt/ssCE+1Ag30yi1+w8H46jmpzoi
         yZXduLDxUzJQzCi94IWLJPg39cf/n9H6Nc1Ly12aukuO35Mj7ng7NRfHiYbws/JuEH3n
         XYDmJb33KTWvpPFpvZFI+fia8Icee1FMbNK93Nj0EqkUX6NdzV/cQx23s6vhJ0f11J1G
         1GQs5ZVHJ8iWdhETdrRq04o/3pO5PCiv/drNoK+brqPy5tXGLX1TwlUMJpjTS3qFo8j1
         TlyQ==
X-Gm-Message-State: ABy/qLZVVSRqdwlkEcd85mYwqD5VocshnjWHOqiPBm9yBJe7APuHOHLI
        5H24uZsjWIHyj1LiG3eVeRa9aA==
X-Google-Smtp-Source: APBJJlGoF48cAVirjD+BVx9K2iUXnkdsU3a+i47sE/S/Bueis1YDVOqdkrh/SI21rEPghqLoMX1I1g==
X-Received: by 2002:a7b:c7d9:0:b0:3f8:f6fe:26bf with SMTP id z25-20020a7bc7d9000000b003f8f6fe26bfmr14903024wmk.12.1689088908735;
        Tue, 11 Jul 2023 08:21:48 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003fbdd9c72aasm2822762wml.21.2023.07.11.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:21:48 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH] hwmon: (dimmtemp) Support more than 32 DIMMs
Date:   Tue, 11 Jul 2023 17:21:43 +0200
Message-ID: <20230711152144.755177-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch introduces support for handling more than 32 DIMMs by
utilizing bitmap operations. The changes ensure that the driver can
handle a higher number of DIMMs efficiently.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/dimmtemp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index ed968401f93c..ce89da3937a0 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -219,19 +219,21 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
 {
 	int chan_rank_max = priv->gen_info->chan_rank_max;
 	int dimm_idx_max = priv->gen_info->dimm_idx_max;
-	u32 chan_rank_empty = 0;
-	u32 dimm_mask = 0;
-	int chan_rank, dimm_idx, ret;
+	DECLARE_BITMAP(dimm_mask, DIMM_NUMS_MAX);
+	DECLARE_BITMAP(chan_rank_empty, CHAN_RANK_MAX);
+
+	int chan_rank, dimm_idx, ret, i;
 	u32 pcs;
 
-	BUILD_BUG_ON(BITS_PER_TYPE(chan_rank_empty) < CHAN_RANK_MAX);
-	BUILD_BUG_ON(BITS_PER_TYPE(dimm_mask) < DIMM_NUMS_MAX);
 	if (chan_rank_max * dimm_idx_max > DIMM_NUMS_MAX) {
 		WARN_ONCE(1, "Unsupported number of DIMMs - chan_rank_max: %d, dimm_idx_max: %d",
 			  chan_rank_max, dimm_idx_max);
 		return -EINVAL;
 	}
 
+	bitmap_zero(dimm_mask, DIMM_NUMS_MAX);
+	bitmap_zero(chan_rank_empty, CHAN_RANK_MAX);
+
 	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
 		ret = peci_pcs_read(priv->peci_dev, PECI_PCS_DDR_DIMM_TEMP, chan_rank, &pcs);
 		if (ret) {
@@ -242,7 +244,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
 			 * detection to be performed at a later point in time.
 			 */
 			if (ret == -EINVAL) {
-				chan_rank_empty |= BIT(chan_rank);
+				bitmap_set(chan_rank_empty, chan_rank, 1);
 				continue;
 			}
 
@@ -251,7 +253,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
 
 		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
 			if (__dimm_temp(pcs, dimm_idx))
-				dimm_mask |= BIT(chan_rank * dimm_idx_max + dimm_idx);
+				bitmap_set(dimm_mask, chan_rank * dimm_idx_max + dimm_idx, 1);
 	}
 
 	/*
@@ -260,7 +262,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
 	 * host platform boot. Retrying a couple of times lets us make sure
 	 * that the state is persistent.
 	 */
-	if (chan_rank_empty == GENMASK(chan_rank_max - 1, 0)) {
+	if (bitmap_full(chan_rank_empty, chan_rank_max)) {
 		if (priv->no_dimm_retry_count < NO_DIMM_RETRY_COUNT_MAX) {
 			priv->no_dimm_retry_count++;
 
@@ -274,14 +276,16 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
 	 * It's possible that memory training is not done yet. In this case we
 	 * defer the detection to be performed at a later point in time.
 	 */
-	if (!dimm_mask) {
+	if (bitmap_empty(dimm_mask, DIMM_NUMS_MAX)) {
 		priv->no_dimm_retry_count = 0;
 		return -EAGAIN;
 	}
 
-	dev_dbg(priv->dev, "Scanned populated DIMMs: %#x\n", dimm_mask);
+	for_each_set_bit(i, dimm_mask, DIMM_NUMS_MAX) {
+		dev_dbg(priv->dev, "Found DIMM%#x\n", i);
+	}
 
-	bitmap_from_arr32(priv->dimm_mask, &dimm_mask, DIMM_NUMS_MAX);
+	bitmap_copy(priv->dimm_mask, dimm_mask, DIMM_NUMS_MAX);
 
 	return 0;
 }

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

