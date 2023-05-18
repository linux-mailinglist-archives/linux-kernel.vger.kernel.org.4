Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F059707DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjERKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjERKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:15:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FD30C4;
        Thu, 18 May 2023 03:14:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e3b69bc99so1504896a91.2;
        Thu, 18 May 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684404827; x=1686996827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKnnzGXKjlifoLEe2ffUscdlzM8XvwS7+Kvj9lIdVco=;
        b=QxWSc6oOabwUF+x65pq/0ZNDCRmnnXk/P00+QMWNOg8rGYAIe/POJMvtKRZ9Gga+O/
         WVpvMkZ3iPjjK+tpd/MAvtMhKGh04IW+1Iohf1jjpFC7RU1ZAEkehPT15cO+C8y7AXT8
         Ubva3NCyCo0xPVqkE8Qy9hjD0+QdklCE5Ic2z1yPhn8rNNj4pd5f+W7iVruilGahhDQh
         19vcqwU9J67nRLMUzwBUU/f3I07qShh9qtrbuG0r7ERWMY8zClHBy3TCblEFY157sY90
         Rl/dbw3KspbIVtgxkj8AQe35dYIwNl4ss5EbRCgiYb2yDD/gNCy/RXnCFFyRflLokEeR
         EPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404827; x=1686996827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKnnzGXKjlifoLEe2ffUscdlzM8XvwS7+Kvj9lIdVco=;
        b=c1rI3sOFh+mXH6/lNDSWidiemQ1LzEl/SVLuM9UJPKAx6uLud08Nhdj7EW26xis9o4
         clwgZ3GBOS/hIggbcLDEIh4ZN1UtEr06LNO6P/iRsV8gfsJXVnF9jBnk86sJ9TdXcbdW
         z3MsrUBLuDsh1HDRamhZBiO9bHgOwNyEvuWmj+6LesZ/5FoLiJ/O718NrCkG+TgPkfM/
         Ma2D3TggFJx/xnJEp274tKveTejKfNp1ziZhYiwvDUDdoe+v5Eq/ZKVOgXkwPdX2ESAa
         f0pmd+bpbr7eX18aveK4nmETHeZc3cMFF4cvHkwVGatyTxIn23AjkjAhwhKoYMInWgaL
         Yf2Q==
X-Gm-Message-State: AC+VfDwxVhGfYL02wJ0+POMo26XY925VFomjatFg9k2HvfnbCo7lR4dc
        2/udOGvWGlG9KNjRyoAVkhI=
X-Google-Smtp-Source: ACHHUZ4XfDhhkXuOC1RR0g4nljcjcD2B2qaFw8mWjZZ92xIBS3E7dNySqykpzyIc2apmTF0rOqvp8Q==
X-Received: by 2002:a17:90a:5e04:b0:24e:4231:ec6b with SMTP id w4-20020a17090a5e0400b0024e4231ec6bmr1989155pjf.21.1684404826766;
        Thu, 18 May 2023 03:13:46 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id q31-20020a63505f000000b0052cbd854927sm894283pgl.18.2023.05.18.03.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:13:46 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, avri.altman@wdc.com, axboe@kernel.dk
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Remove unnecessary error checks and change return type
Date:   Thu, 18 May 2023 18:12:16 +0800
Message-Id: <20230518101216.369970-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <36e805fa-338d-a945-2621-75c5077572fc@intel.com>
References: <36e805fa-338d-a945-2621-75c5077572fc@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error checks in mmc_blk_add_debugfs() and mmc_blk_remove_debugfs()
are extraneous. Therefore, this patch removes all error checks from
both functions.
Additionally, mmc_blk_add_debugfs() has been changed to return void
instead of an integer value that was never used. This simplifies the
function and improves its clarity.

Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
---
 drivers/mmc/core/block.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..81f33200b893 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2894,12 +2894,12 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
 	.llseek		= default_llseek,
 };
 
-static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
+static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 {
 	struct dentry *root;
 
 	if (!card->debugfs_root)
-		return 0;
+		return;
 
 	root = card->debugfs_root;
 
@@ -2908,19 +2908,13 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 			debugfs_create_file_unsafe("status", 0400, root,
 						   card,
 						   &mmc_dbg_card_status_fops);
-		if (!md->status_dentry)
-			return -EIO;
 	}
 
 	if (mmc_card_mmc(card)) {
 		md->ext_csd_dentry =
 			debugfs_create_file("ext_csd", S_IRUSR, root, card,
 					    &mmc_dbg_ext_csd_fops);
-		if (!md->ext_csd_dentry)
-			return -EIO;
 	}
-
-	return 0;
 }
 
 static void mmc_blk_remove_debugfs(struct mmc_card *card,
@@ -2929,22 +2923,17 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 	if (!card->debugfs_root)
 		return;
 
-	if (!IS_ERR_OR_NULL(md->status_dentry)) {
-		debugfs_remove(md->status_dentry);
-		md->status_dentry = NULL;
-	}
+	debugfs_remove(md->status_dentry);
+	md->status_dentry = NULL;
 
-	if (!IS_ERR_OR_NULL(md->ext_csd_dentry)) {
-		debugfs_remove(md->ext_csd_dentry);
-		md->ext_csd_dentry = NULL;
-	}
+	debugfs_remove(md->ext_csd_dentry);
+	md->ext_csd_dentry = NULL;
 }
 
 #else
 
-static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
+static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 {
-	return 0;
 }
 
 static void mmc_blk_remove_debugfs(struct mmc_card *card,
-- 
2.37.2

