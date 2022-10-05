Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8F5F5983
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJESEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJESD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:03:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD022DABB;
        Wed,  5 Oct 2022 11:03:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d24so16048067pls.4;
        Wed, 05 Oct 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+XlP7a4AbJnWW0mvkyBXtZwa/N1Rx2itITpw13S/3I=;
        b=irYlT/WC2ltGpTTQ+/ZIRFgbI4FjjgprU0/J4MQTS+f+PGfYZscMdNRDCWR1t0WIVx
         c3AYZNDHPpy416tfUu1G8zyv+V5cHRVfZUkxDgecHomcrjiQOfdqM8UBMQ45cbWzCGWg
         zazDiDbvm/NDMfZ5l46WEPP5xf3ZJEE02khGUMoA0I+Farvi51O+6Fjs67U3wM2t0sYP
         UvaWxSVyLhvlrXHXhkJaaiWeJP08MiOSdk9+b0BT/JDvEaH9PkTyGBOtI2scLGj6ZLUw
         C7BNEi67o0WAh7eP3XlaqlT/lfu1VH6+MEYj+lmbNrPqbklHTYrA4qcuJHuwBRb7NHlR
         s4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+XlP7a4AbJnWW0mvkyBXtZwa/N1Rx2itITpw13S/3I=;
        b=LEQI0DD9g+ntC2ihTfKpXTRFXuq4OArrOeo8yTahF8A9ewWO56UQL5fHry1WSr7pNP
         tfqf/pYXOJyJh8dfopZYNWsJBUYoSPFB0biq7mSaj2CAtORcD93xNW44YTdK3LR/F+p7
         pI4s1Ldf7FybImP6dLFF5HX0Sr18HXq1mHFkkahc93AQx5iVN5/QUmVt3isWmoGkiWel
         uWvtJ7t8tzip/hvVHgo2RkRPjKPg829lfI/r4lPm/1j6w9pDpWhjSeIixgO2oXX+9JyZ
         ddZf0zud3MWeaJ7Ecdsql1c7BKZnS/ijZMQlFpeS/06aijMHOI67sc30s1NXDSg5WM8Z
         F2pg==
X-Gm-Message-State: ACrzQf2idRLob+0UcQcfIxnEDRqRSy4c3yyp/bM/hny27dEF4vgfyHbE
        P/F1wvDvTxxS91Oj5HULMUBCV8GWe/w=
X-Google-Smtp-Source: AMsMyM7R2vC6Qn5IEDHgIQVREy/czJWxFA0KW9eqPauuVPkuyU3SUmM3xBqqup3gi735DjAFHPyrow==
X-Received: by 2002:a17:90b:3e83:b0:20a:f3dd:3e2e with SMTP id rj3-20020a17090b3e8300b0020af3dd3e2emr3106527pjb.191.1664993037711;
        Wed, 05 Oct 2022 11:03:57 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001788494b764sm10674639plc.231.2022.10.05.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:56 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] md: dm-crypt: move crypt_free_buffer_pages ahead
Date:   Wed,  5 Oct 2022 11:03:40 -0700
Message-Id: <20221005180341.1738796-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221005180341.1738796-1-shy828301@gmail.com>
References: <20221005180341.1738796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With moving crypt_free_buffer_pages() before crypt_alloc_buffer(), we
don't need an extra declaration anymore.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 drivers/md/dm-crypt.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..85ac1f9b37ae 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1639,7 +1639,16 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 	return 0;
 }
 
-static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone);
+static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bv, clone, iter_all) {
+		BUG_ON(!bv->bv_page);
+		mempool_free(bv->bv_page, &cc->page_pool);
+	}
+}
 
 /*
  * Generate a new unfragmented bio with the given size
@@ -1707,17 +1716,6 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 	return clone;
 }
 
-static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
-{
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bv, clone, iter_all) {
-		BUG_ON(!bv->bv_page);
-		mempool_free(bv->bv_page, &cc->page_pool);
-	}
-}
-
 static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 			  struct bio *bio, sector_t sector)
 {
-- 
2.26.3

