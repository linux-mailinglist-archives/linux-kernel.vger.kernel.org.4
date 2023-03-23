Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD06C6A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCWOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCWOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:05:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFF20A2D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:04:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k2so22384974pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679580241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/FSVIgFkJKT5jPFJCXaDrLahDNeQHDN2HW+X//0cEg=;
        b=J7irfwBK/AlyWjxu7eOdGZc3k24K4lB+89Vl/zz4hK5xhMiv41olFotAiTc+3WCGgy
         4cMirpt3fatv777O2iGcdLsHqFxgzg0Of+Dx+r9KaQi3ZcX3E9Lncwgmy7noLBDjikH4
         qeFPxJMXmBJ7rl7xsVcBu3NrRU89/WTJx5Y/FmB5rkNHCTn354ln3Hu1p+V0UCD4z7q+
         lZ7EoPbT6M4jOPrAj1w3LZOiSIxcjONMuB+R15oUGS+9n2BS5pt2GsGMTGnVqeshSECB
         PvejD3n6QPnwaE1fyXtLr7FvpOotEGMK3LXpiL4twfF5nd37v0qBb4ILaEy1GnA4JSbY
         Bjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679580241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/FSVIgFkJKT5jPFJCXaDrLahDNeQHDN2HW+X//0cEg=;
        b=bLj2uEIC5wqyJ2DDE35SEwUTI7cw/dCM9RkG0IfiVYMkOMWy4i0B26bTPg2tB42l9T
         cSjELj/3T9jVxTKuDH1SY57ktN+8GdsOw/JBNx4NXxANxAvROFvQLT3bHSaoo9vPZuST
         9v+NTu26Cdt25gKoOu2cydEHuFPXN0qYG+WU1iND3eXpdWBuLu/+5+1sEjoKbY+jByXi
         XiA6MykRf2Kd0pue+epJY1b3m5wksu1Io7WvkcP9JQtlm3BwaIYdDKVL2E8SoSyQZdkX
         ZcbMh6goGqZ5TUkhUGE8nvUQfMBTXTsx+TrIkJj26/zadaTuJatC00Srl/Y+JBppkVnX
         scxQ==
X-Gm-Message-State: AO0yUKX53CxS8vO47TmxkLwYK7rwbi7soFuwflZAFNrmaCVFVg4STnfr
        8NjmPlIA0OMfImZpkdtUtE0=
X-Google-Smtp-Source: AK7set+No4CboYrqtpIMXSn3p5AoVWa7v7kwsrrDO8wk4wxo/FiN6fQ5stgd6ORe1owxLtO0hvB1mA==
X-Received: by 2002:a17:902:ebcf:b0:1a1:dc27:202b with SMTP id p15-20020a170902ebcf00b001a1dc27202bmr6165242plg.20.1679580241020;
        Thu, 23 Mar 2023 07:04:01 -0700 (PDT)
Received: from localhost.localdomain ([115.204.224.149])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b001a1a9a639c2sm11967376plv.134.2023.03.23.07.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:04:00 -0700 (PDT)
From:   Bang Li <libang.linuxer@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] mtdblock: tolerate corrected bit-flips
Date:   Thu, 23 Mar 2023 22:03:50 +0800
Message-Id: <20230323140350.69908-1-libang.linuxer@gmail.com>
X-Mailer: git-send-email 2.25.1
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

mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
particular condition should not be treated like an error.

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 drivers/mtd/mtdblock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 1e94e7d10b8b..a0a1194dc1d9 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -153,7 +153,7 @@ static int do_cached_write (struct mtdblk_dev *mtdblk, unsigned long pos,
 				mtdblk->cache_state = STATE_EMPTY;
 				ret = mtd_read(mtd, sect_start, sect_size,
 					       &retlen, mtdblk->cache_data);
-				if (ret)
+				if (ret && !mtd_is_bitflip(ret))
 					return ret;
 				if (retlen != sect_size)
 					return -EIO;
@@ -188,8 +188,12 @@ static int do_cached_read (struct mtdblk_dev *mtdblk, unsigned long pos,
 	pr_debug("mtdblock: read on \"%s\" at 0x%lx, size 0x%x\n",
 			mtd->name, pos, len);
 
-	if (!sect_size)
-		return mtd_read(mtd, pos, len, &retlen, buf);
+	if (!sect_size) {
+		ret = mtd_read(mtd, pos, len, &retlen, buf);
+		if (ret && !mtd_is_bitflip(ret))
+			return ret;
+		return 0;
+	}
 
 	while (len > 0) {
 		unsigned long sect_start = (pos/sect_size)*sect_size;
@@ -209,7 +213,7 @@ static int do_cached_read (struct mtdblk_dev *mtdblk, unsigned long pos,
 			memcpy (buf, mtdblk->cache_data + offset, size);
 		} else {
 			ret = mtd_read(mtd, pos, size, &retlen, buf);
-			if (ret)
+			if (ret && !mtd_is_bitflip(ret))
 				return ret;
 			if (retlen != size)
 				return -EIO;
-- 
2.25.1

