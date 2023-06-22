Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0C739DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjFVJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjFVJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:52:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CF2705;
        Thu, 22 Jun 2023 02:46:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31121494630so7952908f8f.3;
        Thu, 22 Jun 2023 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687427205; x=1690019205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHpyFabujAR7xCKXJiA903bm7LVteFnni+c1+YvwBHU=;
        b=Dn+yG8E1DKOoiUlaavLuNEu+TIGc9uNEThriGRqffLiuDOUcOSKDHwPN0Vg3vVepej
         wlWaREY/PEiSZuCwFcuC3adG7M7X14j6dm+yz12gb7wj9QovHmSiY/U0DAfJWHz1bzw7
         SZSDesZbVavI6+ExE70y2niQi+3t9ddGh+jpcSDrykKA2MxoEds2EIVjpTEkD+qmkWrm
         mKI7RL0EIAdXL4H2iL8OIhfAB2m9XwEB5DzJ6xf9fIsTV4XCFjv/P8WMawgVm7g6cXs9
         WeNkpPPQkYIyAMOPhtVyOv8WnErrlsElOVynL7NTmtr/YYqypjUB7QirJC4PzM/TodQ1
         0spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427205; x=1690019205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHpyFabujAR7xCKXJiA903bm7LVteFnni+c1+YvwBHU=;
        b=k5c9r22Xsv/54Muv38I5saR9iB5K96eAWGZ2/VarYzhOmT1tWlw2/d+Eq+pMtzQioD
         F4arbJyJE8bPmEH86ZZ7tfLt4OP05eLWWKLtbR10W9ZFEj6+5GCIuReFN5KWk1VWDxH8
         1USUIXt7oGvEYTBxvXOJrbnefMfpcBbAvM7m8Kl7suxcvVVrJu57Qus1ah7SsbHEbVEZ
         0/KY8D5unyHv5k6SWwOd4CqTq2IgqLhmSIBawSG4S6moVzbPGb0boZIPZekkooj6PwGK
         Sh+b1jZKlOf3Lvd4xmfr7b0dQ31T4YherS0YwtZeDDf5gHle7tpzn+T5egwY+lJFPsZh
         n5kw==
X-Gm-Message-State: AC+VfDxiO23MLCW8mVjYya/lZQkX2setpOTS2MVIay7/wm4btehACOZX
        zqJeYZq+6GNjUNHGOKE5vc36xUqbFC2/jA==
X-Google-Smtp-Source: ACHHUZ4WVcsofhVfB3fHYglrZh6vPocrM3myf2coC3e6xUlfhj83msUrJhYUulr33m1XuYImow6kwA==
X-Received: by 2002:a7b:cbd8:0:b0:3fa:781a:3d07 with SMTP id n24-20020a7bcbd8000000b003fa781a3d07mr135318wmi.35.1687426444609;
        Thu, 22 Jun 2023 02:34:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u16-20020a7bc050000000b003f080b2f9f4sm18276548wmc.27.2023.06.22.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:34:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] xfs: remove redundant initializations of pointers drop_leaf and save_leaf
Date:   Thu, 22 Jun 2023 10:34:03 +0100
Message-Id: <20230622093403.2829382-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Pointers drop_leaf and save_leaf are initialized with values that are never
read, they are being re-assigned later on just before they are used. Remove
the redundant early initializations and keep the later assignments at the
point where they are used. Cleans up two clang scan build warnings:

fs/xfs/libxfs/xfs_attr_leaf.c:2288:29: warning: Value stored to 'drop_leaf'
during its initialization is never read [deadcode.DeadStores]
fs/xfs/libxfs/xfs_attr_leaf.c:2289:29: warning: Value stored to 'save_leaf'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index beee51ad75ce..3091d40a1eb6 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -2285,8 +2285,8 @@ xfs_attr3_leaf_unbalance(
 	struct xfs_da_state_blk	*drop_blk,
 	struct xfs_da_state_blk	*save_blk)
 {
-	struct xfs_attr_leafblock *drop_leaf = drop_blk->bp->b_addr;
-	struct xfs_attr_leafblock *save_leaf = save_blk->bp->b_addr;
+	struct xfs_attr_leafblock *drop_leaf;
+	struct xfs_attr_leafblock *save_leaf;
 	struct xfs_attr3_icleaf_hdr drophdr;
 	struct xfs_attr3_icleaf_hdr savehdr;
 	struct xfs_attr_leaf_entry *entry;
-- 
2.39.2

