Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D25BF737
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIUHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIUHLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:11:04 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8683054
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663744258; x=1695280258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5aFQ+gY4ZhKXyhCePaw76R9ZtER/5cnGJ7n9ZPauJE8=;
  b=NYCgkcEPTU8GaROn4GUqvMRVHgYQs/4Zp847YLdhMyvWW/4HNVT1EMIu
   /b9TWOayQ4UwU4kraJSGPegIYJQwKvWDY9nBZB4wnFtsjmvZSSa4rYOWm
   6Rov0M5XJzj6NwDzwSkpSm6wCi8H7bwTdDxn0xEyVm3BewKm0SRaOaGEO
   JPBFAn9r4fbvIzXlbFpnmlGDCXRhr4MPMd1pFF8UGrjoQ93bYjfwo9vFc
   XLA9OiIuwh+4tE5qfR8fHZv5EB4LgNaRQGxKg0NnfjN2LoCe3non04M0/
   RRJ2NXCsLCcfWJW4pZYqLdcWAsKeFFTRpLFm1w9Hqjqg0zNy5rNYIVFb8
   g==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="26300574"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Sep 2022 09:10:57 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 21 Sep 2022 09:10:57 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 21 Sep 2022 09:10:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663744257; x=1695280257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5aFQ+gY4ZhKXyhCePaw76R9ZtER/5cnGJ7n9ZPauJE8=;
  b=nSsEZw4DD0HSsxOBAsabn425cJ3m3Y9yQ61gqT3awltbvRlCTkG0WbfS
   tW86JKbexX/rnAD76G5/GmSPxC31BLroyafH9yPOTiO5An/YfVlIs9iKA
   i5Rb0JCSRotCKYPqjDRIuAJUXy/vljF23iWmBw6PrT5k6e8ReuFWAkOZ0
   Ga9lR33ijWwi7OvotLES7Rl0JiiLFmQ/A3/p89BBY1WG4Iq/alHWBjqTy
   XD5UTjbk78Omj35BoLSlP4ROEiHMmrJyzb5Byo4VOIJXIwe2J1wzt6/Yv
   N66bXwQ4CZ1N3LVNdhvGAKqmPKSHl4yzdx8Sw/vIdvzEMACvyJuCav0vl
   g==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="26300573"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Sep 2022 09:10:57 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DA52E280056;
        Wed, 21 Sep 2022 09:10:56 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] regmap: cache: downgrade log level for no cache defaults message
Date:   Wed, 21 Sep 2022 09:10:54 +0200
Message-Id: <20220921071054.3132504-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having no cache defaults is not a mistake, especially for devices
which do have some kind of strapping values which can't be provided
statically. For this case a warning is the wrong log level, the initial
cache values do need to be read form hardware. Reduce level to info.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..89b92eda8b02 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -54,7 +54,7 @@ static int regcache_hw_init(struct regmap *map)
 
 	if (!map->reg_defaults_raw) {
 		bool cache_bypass = map->cache_bypass;
-		dev_warn(map->dev, "No cache defaults, reading back from HW\n");
+		dev_info(map->dev, "No cache defaults, reading back from HW\n");
 
 		/* Bypass the cache access till data read from HW */
 		map->cache_bypass = true;
-- 
2.25.1

