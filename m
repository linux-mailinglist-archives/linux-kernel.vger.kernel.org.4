Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BC6BD62D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCPQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCPQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:45:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19049D5A54
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:45:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br6so3121394lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678985138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzczH5eeETrO7u41+m+SAJvV1HKn3xHPG5FRk5R4iDQ=;
        b=DHLOy20m7MCDF1oySL4i4+zU0a7eMUX/+SZRLSoPMJgKFNZiKHjoLPQZItQgcW13Fo
         uuTPnKUIEgXJ8BuHhjHRUQ00mgE7jbTgNVQ1AEfXOSDbi99xmwmLM1B+4EKqtfJHzutu
         YXb0dxfGOKIljeS57sZZvTp0BlqRSmQHPaBQoxpKbYvFaMNZTPu+EUk342AtQC7nkPUR
         MHxc1H/fmeQ/zyejLGhIHUFEWCaows+ShNYynYN6oqghBdqnM390JD87pWRg/PbOTOUt
         UTsbz3nEp8gagd+xEEUouJ1f58S13Fyi/XzGLCrdCy0bAVMyQ8SVLpY9Zt0Okj006Utt
         yhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzczH5eeETrO7u41+m+SAJvV1HKn3xHPG5FRk5R4iDQ=;
        b=U+TQ5sn58IBp+bgqgvQrkYMGKVSS5pVCaumiGOvHa33cEknR2tFoVHEiR1r2aDAIR2
         /o0jegN2F2OZeedY7ndjiIJfDzYutkC1W5zn7hiiUC4Wd6awEox2wzbxCtNNNnSTaDd9
         ZHsJzD0sZ3MsV8mqIziu8H1WRllcwF8CyAkR4Za/4bII3P6Nwe5PiDdpAmdHd+ERnhww
         2W9bzc9PG68wvyLqvIcSmia/549iWqsCdEJe6aUAJWtnxsairxJf9ocKu9iC1SYEouE+
         vD+cw5BQ+EF6uLJ2idYK2H2RnVLjiLAVG66eCezSz2+Rx/ALKKc4W1sxERtR0OQHDW02
         CPww==
X-Gm-Message-State: AO0yUKV0QPkqMtSVeIrnEmwrY7K5jhjZTQYYkLxPEFZ+KC2v4AXaPXkL
        aNLcW5QDMX8iuCzeSsWDY0hnSw==
X-Google-Smtp-Source: AK7set9NwftH1chMUKsREfVHPuVlQE8YR02r/umNJjY8L7jifbsaTKunxXrHQLZ/V4OBuS57rrFdhw==
X-Received: by 2002:ac2:5fc1:0:b0:4de:ca63:b2d9 with SMTP id q1-20020ac25fc1000000b004deca63b2d9mr3081110lfg.49.1678985138316;
        Thu, 16 Mar 2023 09:45:38 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u20-20020ac243d4000000b004e8452972a2sm1283996lfl.247.2023.03.16.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:45:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an internal cache
Date:   Thu, 16 Mar 2023 17:45:14 +0100
Message-Id: <20230316164514.1615169-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REQ_FUA translates into so called "reliable writes" (atomic writes) for
eMMC cards, which is generally supported as it was introduced as a
mandatory feature already in the v4.3 (2007) of the eMMC spec. To fully
support the reliable writes (thus REQ_FUA), the mmc host driver needs to
support the CMD23 (MMC_CAP_CMD23) too, which is rather common nowadays.

File systems typically uses REQ_FUA for writing their meta-data and other
important information. Ideally it should provide an increased protection
against data-corruption, during sudden power-failures. This said, file
systems have other ways to handle sudden power-failures too, like using
checksums to detect partly-written data, for example.

It has been reported that the reliable writes are costly for some eMMCs,
leading to performance degradations. Exactly why, is in the implementation
details of the internals of the eMMC.

Moreover, in the v4.5 (2011) of the eMMC spec, the cache-control was
introduced as an optional feature. It allows the host to trigger a flush of
the eMMC's internal write-cache. In the past, before the cache-control
feature was added, the reliable write acted as trigger for the eMMC, to
also flush its internal write-cache, even if that too remains as an
implementation detail of the eMMC.

In a way to try to improve the situation with costly reliable writes and
REQ_FUA, let's add a new card quirk MMC_QUIRK_AVOID_REL_WRITE, which may be
set to avoid announcing the support for it. However, as mentioned above,
due to the specific relationship with the cache-control feature, we must
keep REQ_FUA unless that is supported too.

Reported-by: Wenchao Chen <wenchao.chen666@gmail.com>
Acked-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updated since the RFC:
	Added a card quirk to maintain the current behaviour. The quirk isn't
	set for any cards yet, which is needed (a patch on top) to move forward
	with this.

---
 drivers/mmc/core/block.c | 16 ++++++++++++----
 drivers/mmc/core/card.h  |  5 +++++
 include/linux/mmc/card.h |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672ab90c4b2d..35292e36a1fb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2409,8 +2409,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
-	bool cache_enabled = false;
-	bool fua_enabled = false;
+	bool cache_enabled, avoid_fua, fua_enabled = false;
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
@@ -2494,11 +2493,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
 	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
+	}
+
+	/*
+	 * REQ_FUA is supported through eMMC reliable writes, which has been
+	 * reported to be a bit costly for some eMMCs. In these cases, let's
+	 * rely on the flush requests (REQ_OP_FLUSH) instead, if we can use the
+	 * cache-control feature too.
+	 */
+	cache_enabled = mmc_cache_enabled(card->host);
+	avoid_fua = cache_enabled && mmc_card_avoid_rel_write(card);
+	if (md->flags & MMC_BLK_REL_WR && !avoid_fua) {
 		fua_enabled = true;
 		cache_enabled = true;
 	}
-	if (mmc_cache_enabled(card->host))
-		cache_enabled  = true;
 
 	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index cfdd1ff40b86..2ab448fa2841 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -229,6 +229,11 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 }
 
+static inline int mmc_card_avoid_rel_write(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_AVOID_REL_WRITE;
+}
+
 static inline int mmc_card_disable_cd(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_DISABLE_CD;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c726ea781255..4d297d565c83 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -282,6 +282,7 @@ struct mmc_card {
 						/* for byte mode */
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
+#define MMC_QUIRK_AVOID_REL_WRITE (1<<3)	/* Avoid rel-write (REQ_FUA) */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
-- 
2.34.1

