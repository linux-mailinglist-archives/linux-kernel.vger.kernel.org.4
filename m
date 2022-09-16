Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389DF5BB4C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIPXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIPXdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 19:33:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D0CB9595;
        Fri, 16 Sep 2022 16:33:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r23so13113105pgr.6;
        Fri, 16 Sep 2022 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FkwcMuPKAyIP/oOmQ4uH+hyF+kMKI0zxNAQqGfbM4Z8=;
        b=S9cmbn4CyhtMlh6aNtSmNTJvFCO+Yuk/HR7QzXFPqpi2dDaDucz2dfmEcw/fswaD0u
         vCn+FvnuVGFtJ0lX49P4LuJHW50golAAP+ehiTfuV4WcWJcjLDv+8c8oqajhE52hSU9S
         3b/X0EqXFkHkCzD9K+qbnJq4fwYM/lUMh1aAfRX+9fWc5hzuGr/CGQtalLuPjwvajL3t
         4Z7klohE2d00G2bCBnrkINzOrND/AcgRZmwNfYCTGNxYmWwmbY+SRF4cuBD46V3D34zt
         Wy+EBjmoII++9HSuIZkc1xgLXJvGyUsrtDZX8oAeVl3+eT9at7TURsRiNDbgNc0Ej/4d
         4jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FkwcMuPKAyIP/oOmQ4uH+hyF+kMKI0zxNAQqGfbM4Z8=;
        b=s0eAbKnMr20Qq6avWrDB3sQzSwVzTacLUyrq8GiHN1V5KrD12t+OqsZ65o/HZ2CCoT
         UC4Bj2nY9NHHeWcVu0l3b1esvmxyr0e2i8v8yExE+tQu2fAE31wMpeEYp6kqSDP5Bdbr
         Ce5ehsUXzJqKKLAKjVvGVjv7QwV56de43YnE8mVm784mJSVbN+zpsg8eiPAJ6JoNr+3h
         RMlBdH1n/BOGLjJtZqB+95u/Z+TP/1rop8bNdGwUfx7sPYHd4kZCd3DfgWVE71FLCWSx
         y6MA3YPK7U6YVmmNMujEZDt8ilhFU8EJ9yAtOxYqUK1+8g4xNlLQsbFijth+soTXO+zz
         QwtQ==
X-Gm-Message-State: ACrzQf3yZ0MdnXdhkdiVkPM0dAKAumBXxn9QYoAPmNotMzNr/ADwWnU/
        XM4mptZwOVeewF1VaWhO10q6WXbMAmk=
X-Google-Smtp-Source: AMsMyM54vHxTNdmLHLU1J//l6ttbSdd442EteUL6rW2u3LeoAdFWAJeGCW+zEpHLpwdaEd/qTAnSmw==
X-Received: by 2002:a63:4714:0:b0:42b:82d9:b617 with SMTP id u20-20020a634714000000b0042b82d9b617mr6308979pga.223.1663371201616;
        Fri, 16 Sep 2022 16:33:21 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id g2-20020a170902d1c200b001781a7c28b9sm14578525plb.240.2022.09.16.16.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 16:33:20 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     song@kernel.org, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] drivers/md/md-bitmap: check the return value of md_bitmap_get_counter()
Date:   Fri, 16 Sep 2022 16:33:05 -0700
Message-Id: <20220916233305.3784826-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the return value of md_bitmap_get_counter() in case it returns
NULL pointer, which will result in a null pointer dereference.

v2: update the check to include other dereference

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/md/md-bitmap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index bf6dffadbe6f..63ece30114e5 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2195,20 +2195,23 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 
 		if (set) {
 			bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
-			if (*bmc_new == 0) {
-				/* need to set on-disk bits too. */
-				sector_t end = block + new_blocks;
-				sector_t start = block >> chunkshift;
-				start <<= chunkshift;
-				while (start < end) {
-					md_bitmap_file_set_bit(bitmap, block);
-					start += 1 << chunkshift;
+			if (bmc_new) {
+				if (*bmc_new == 0) {
+					/* need to set on-disk bits too. */
+					sector_t end = block + new_blocks;
+					sector_t start = block >> chunkshift;
+
+					start <<= chunkshift;
+					while (start < end) {
+						md_bitmap_file_set_bit(bitmap, block);
+						start += 1 << chunkshift;
+					}
+					*bmc_new = 2;
+					md_bitmap_count_page(&bitmap->counts, block, 1);
+					md_bitmap_set_pending(&bitmap->counts, block);
 				}
-				*bmc_new = 2;
-				md_bitmap_count_page(&bitmap->counts, block, 1);
-				md_bitmap_set_pending(&bitmap->counts, block);
+				*bmc_new |= NEEDED_MASK;
 			}
-			*bmc_new |= NEEDED_MASK;
 			if (new_blocks < old_blocks)
 				old_blocks = new_blocks;
 		}
-- 
2.25.1

