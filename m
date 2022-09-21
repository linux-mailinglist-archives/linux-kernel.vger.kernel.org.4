Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403BE5BF4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiIUDsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIUDsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:48:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686187C30B;
        Tue, 20 Sep 2022 20:48:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x1so4394178plv.5;
        Tue, 20 Sep 2022 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zuUTrKEQfr4sTAkgNNcxkQQm8I/DlTKY/sYvpN04CR0=;
        b=UQ0NYQxyERDLPcyJTHUVOAlubjXits94UXZaEE8wQN5td+CsnsaZPwiMBon6QtK4YI
         lmpzLrH2r3Xg6zlv36JgVKynEauD/hPI8QWUwSLVpQ5CXDaBF9pHK2Beqat0ZPYKLPCx
         2l09Fcrr3//pD6/aV6YFZ7Qad5NT5XfGnSQntyYOV//0qNGbvSEI2Ds54km2Abrc07pX
         VkisyPGoXZHLRWNaripFL1ZMNVDAzjJVnqvsSCgdADYfau4TySmIkX1O1LRx73WNXNrC
         w6UWGb4Ri4u8xJQUMSbd/EnQO85UBjyhFgaGDy+TLPrrBtPKmvh3K34AH8oKZMqtQWiR
         9b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zuUTrKEQfr4sTAkgNNcxkQQm8I/DlTKY/sYvpN04CR0=;
        b=qC8Lnta2skrMeFa0xhLpIrxVQ8OvJPGDlIeygcyvfcr9+Pbdy4MZXrv8eugGVXeRkh
         c8bdLLYZlP9PbSxXk7EoJyD/IhD59XyBrXzxTlVDqvGmWHEpeok/3cVR+N+IwkSPLT3J
         6KFTnJQC+/cQxxTS6eclcbK4CDD3FiQ8bx2ANB/JUcUcy2VWTAMoZZQ2+SpsjYqLPx6J
         I93HWtv4Ib07WHLLOe25cX4G0U3meV62ozDLfecMOmE+djS/wpjyddNFb+nl5BrlQv2P
         Gjkd79KvSeSiF6Bh3nYM/pMZ9OGJ93Ge/mwp9xequReYg7/bGTTMgOmLnBBqy5T5+zt4
         FuOw==
X-Gm-Message-State: ACrzQf3aoCFDngOHKy3eH52BVvlDaL0FICoHcS9RuNaRriiQGQo82Rrn
        u9dms9UridBa7sKoQUDseHbFcRlQ+lk=
X-Google-Smtp-Source: AMsMyM6iAQlVotRUQUZQaswiJv6u3+w5s3DtVcydPlyR1T/6pUjy+073DQrTO740x4ig+LDmxUD2yg==
X-Received: by 2002:a17:902:d482:b0:178:1585:40b6 with SMTP id c2-20020a170902d48200b00178158540b6mr2842044plg.134.1663732089814;
        Tue, 20 Sep 2022 20:48:09 -0700 (PDT)
Received: from carrot.. (i118-19-12-172.s42.a014.ap.plala.or.jp. [118.19.12.172])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b00176ca74c58bsm686016plf.245.2022.09.20.20.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:48:08 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nilfs2: delete unnecessary checks before brelse()
Date:   Wed, 21 Sep 2022 12:48:02 +0900
Message-Id: <20220921034803.2476-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921034803.2476-1-konishi.ryusuke@gmail.com>
References: <20220921034803.2476-1-konishi.ryusuke@gmail.com>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The brelse() inline function tests whether its argument is NULL
and then returns immediately.
Thus remove the tests which are not needed around the shown calls.

Link: https://lkml.kernel.org/r/20220819081700.96279-1-chi.minghao@zte.com.cn
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 9f4d9432d38a..b9d15c3df3cc 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -1668,8 +1668,7 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
 	maxkey = nilfs_btree_node_get_key(node, nchildren - 1);
 	nextmaxkey = (nchildren > 1) ?
 		nilfs_btree_node_get_key(node, nchildren - 2) : 0;
-	if (bh != NULL)
-		brelse(bh);
+	brelse(bh);
 
 	return (maxkey == key) && (nextmaxkey < NILFS_BMAP_LARGE_LOW);
 }
@@ -1717,8 +1716,7 @@ static int nilfs_btree_gather_data(struct nilfs_bmap *btree,
 		ptrs[i] = le64_to_cpu(dptrs[i]);
 	}
 
-	if (bh != NULL)
-		brelse(bh);
+	brelse(bh);
 
 	return nitems;
 }
-- 
2.34.1

