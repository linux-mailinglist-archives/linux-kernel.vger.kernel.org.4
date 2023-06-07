Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52B725993
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjFGJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbjFGJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:08:25 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C01BE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:07:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38dec65ab50so6192538b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686128867; x=1688720867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnoLhVADhihYKgZNBEzok/V+ENlQGgAVYWmM7AcnihM=;
        b=Sz4/tFdNyQ6kCJCvi04tf2Vo5gs9uzqidrUilAUXG/bDicmh6yy4eHQB7r+wSLDlBy
         GNwFW0YF6SdiOYRQEkFF1DO5r+1iRP9qcllczA2709q74ejFiuaEoAFGZ06Uwo44tqYb
         q924mcuYUiFeIyzWAFB3HGYBnO+TULO5nkfAAZag/rvaViZEfaOMpuyNfcMA3c4hpKmC
         ZMKnUKNGFtPd+TYZZjL0mn7fBxfgqiL8b+DE/SHA5twfwgfMVebRFWD/lqNkcisKOyRo
         axXUimwvrRJbdAgVCYWtHMGm6RDxeHpXuJtIciVM1p+P1Li7CzZziLtofhRHaAd60682
         B2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128867; x=1688720867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnoLhVADhihYKgZNBEzok/V+ENlQGgAVYWmM7AcnihM=;
        b=l7M5yDXvN1RHDavDoCixGsbu3UVuTBnrvKL0ucg56+8qT8zRz86PXTNphdWnW0B7k5
         wAqCodDLE5HU2K5MClawABn1BGG+qgIZA1a9KLEWGrzNutA+JVdDn4HVuC0v01GiaTUw
         NM9J42wPQHMeEY/MzP8y3+TmJ+RbWoSsSoIQc67pvSphTbycuXK3hdj+Qt3e6y2qa/KN
         Q+4/NRiW01Wc30o2pfcm7fOqgdFg3VZ8WkQFnBj2/FklRqSqB+880cGN4viK4LJSOk48
         w5uQJPh9UDoRdypUHYphtv264gh0aF4DisJ6dyjklb7nZErcI5YZUU2SAvH1EoxOFE8i
         nwdw==
X-Gm-Message-State: AC+VfDwzarJy+iusyWuJhcPPJLYgDC5TRU0gyALvg1qEKD93WAxvDEVL
        aCVo0+j5Em3VsluIdy1SwDDC4Q==
X-Google-Smtp-Source: ACHHUZ4i49rikND5k3bth3DcOLZpIGFqrTP+M8/PtIDqqxPd5aCNVrqafWofsspNDqktepbzaVEJNg==
X-Received: by 2002:a05:6808:b2f:b0:399:156b:fcc1 with SMTP id t15-20020a0568080b2f00b00399156bfcc1mr4837460oij.32.1686128866811;
        Wed, 07 Jun 2023 02:07:46 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001a69dfd918dsm9967076plh.187.2023.06.07.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:07:46 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/mm_init.c: add debug messsge for dma zone
Date:   Wed,  7 Jun 2023 09:07:34 +0000
Message-Id: <20230607090734.1259-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If freesize is less than dma_reserve, print warning message to report
this case.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 232efac9a929..9a9d6a52471c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1561,9 +1561,14 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		}
 
 		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
+		if (j == 0) {
+			if (freesize >= dma_reserve) {
+				freesize -= dma_reserve;
+				pr_debug("  %s zone: %lu pages reserved\n",
+					 zone_names[0], dma_reserve);
+			} else
+				pr_warn("  %s zone: %lu reserved pages exceeds freesize %lu\n",
+					zone_names[0], dma_reserve, freesize);
 		}
 
 		if (!is_highmem_idx(j))
-- 
2.25.1

