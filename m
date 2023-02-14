Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB2696D85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjBNTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjBNTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:46 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA52FCE2;
        Tue, 14 Feb 2023 11:02:41 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h29so4835774ila.8;
        Tue, 14 Feb 2023 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFajPTMRcCMM2sMtnpqlL+/MlXEk9UiKBjz1wMnJjFA=;
        b=cpuu8RHhLHTB9Kf5s0trAt7bengNbUN4ZN2xoDYyF+XdtzVhnHEooRlP9BzRHtxlEP
         r3Rf1jjDg8BQhkHtx/TVMG/uS8NRXNag+1UWtBCkPSLdTJy+q87vzrf0AACu9OupPfqI
         GnrPCavwpOhXW44xfYvrtpkf/gp3krMsKHx7/M6K8g4qqClwoz6f8Iz7CE+WhipAL6FO
         UTRQhaQ8FC74Ihf+tDyxdXiJdWD3uKM5/g54L2eY5a93eT0WfuzvRIFE1gDaP91Cbjii
         8/IghgHlkNLzreTfyh7VixSz1DQiCh+dNirmbfzL8nalJsFlCCsVvFn1fwk40nyxGMlR
         tFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFajPTMRcCMM2sMtnpqlL+/MlXEk9UiKBjz1wMnJjFA=;
        b=IuEiHuGUNJla3aUfPhcUTLYEiI/u35EM/Xo+0RDpbUp9jZGg7WrhBT5uTFtns77V8S
         +LB8Wqd2qL29ylm2EAHykH55d+zgZ+W0rVYNm+oTjMfGtQpEYKOBOtCSktaxLuPdQ/e8
         Vp/RmfeNry39F0LqaA/f4S55IDSJSo7hX1Vuceh9C22qq0cI7dP6rCof00EJ+OSgkoZB
         Uqn6wnjwx9OEP/oCdGwrabmPaDvReQfg9CSzCofNqKzN9Mu/VokSMzcv8SOKygrm8hgF
         gkOWmJdOPNIh5FIrCWSJmd653W7hewNnmT6YE/deQ6kNfYoY+lHvhQWfr0NdBUqOnTxh
         /xtQ==
X-Gm-Message-State: AO0yUKXZhs6R73jkw9ginp6EXCM6OlIz4rCsA7gTnZ1SKyrGomjiyaZG
        hT5U+J0gGqE9Rhg5RyfjMVc=
X-Google-Smtp-Source: AK7set+zChOBkvDmv8upovQoaKfuAxrbFAxXV5MZ5rjassuOdi24vOvvtuhY+6wN48rk9TwI/nKFhA==
X-Received: by 2002:a05:6e02:1b8c:b0:315:45c5:9185 with SMTP id h12-20020a056e021b8c00b0031545c59185mr3407244ili.31.1676401360782;
        Tue, 14 Feb 2023 11:02:40 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:40 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/5] md: dm-crypt: move crypt_free_buffer_pages ahead
Date:   Tue, 14 Feb 2023 11:02:20 -0800
Message-Id: <20230214190221.1156876-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
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
 drivers/md/dm-crypt.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2653516bcdef..73069f200cc5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1639,7 +1639,17 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 	return 0;
 }
 
-static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone);
+
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
@@ -1707,17 +1717,6 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
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
2.39.0

