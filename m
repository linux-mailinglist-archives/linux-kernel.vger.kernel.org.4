Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE320700898
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbjELNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjELNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:05:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB409004;
        Fri, 12 May 2023 06:05:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f13c41c957so2187553e87.1;
        Fri, 12 May 2023 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683896737; x=1686488737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCQRjBkP8l0PQhKcHh5TnNSnWxhKMBpH5u3PrLqP5bw=;
        b=gSVtugdu0QcsPWfCv177WCPgmmUIXwjpkxJncUPS9gWAroAhjf8n1PyBgvo+yG2FyM
         AGT9UxdYd/iV5HYbxAg9G9PhyPppuGSo1xmNnevlv70djo7FF012iIYPdJpg5AsdbYkh
         BhKFg/OYk3YHdh1O8qtxffpfw51RxOOQW+P+CwbWqQSmLdWVWQh3m8bTVR2Q2kAcKTn5
         Xq35VcJY+bPGNGQgRBOfkxDfA6iUiHEOy7GH+nXrxZP+Pw3H3QSN06hnvofVCsOxM0c6
         3r/11TnBKqscTYtpRisEqtsEx1pQOf5S1bTLHSrlWu3QEq3HoV0vtxnpxklSaOl3y8Wr
         gdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896737; x=1686488737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCQRjBkP8l0PQhKcHh5TnNSnWxhKMBpH5u3PrLqP5bw=;
        b=bMMB9T4hh+c7GEKUHc+FBe3OLsqNd5V2UpFf5rkQo8z2nZfgyxd14EXX5a7pZnpZoA
         RFxpmAjoaBZpmiHITaDxvOv/knH+lswSSZELbEw8ovt95wvjr2gIaiSGGKZYDt+D4hE7
         IbEbcMMiClRT+CS838YTmfuqkkFglyBfIv7PiZjFVD+kzkcUdZjYEPI/yl0KdQ5fcwkB
         Z6Np4eq5jhd4iE4/SfjrstHIbNZKF9lqidSDsrk8lpM08oGkY+VaeFhLYlhmR7ZrcfQ3
         3zIHoyZ2pAPktpT/48lRdKBgy/EQ85JXwWf10D1LTEkhqChrTsM/CODC4PjvkJVSryA3
         WGyA==
X-Gm-Message-State: AC+VfDxNkB+591sb3pvj7KDQ7E3VjvItcI5SlohpbCMmGu5ImHS2vOBN
        1xk7sgFccaXsi7kqWRr/43E=
X-Google-Smtp-Source: ACHHUZ5HB45FEo0/mPj5ucpEmu76J/nqzc0NAvE+NhUO19q+o09XnzL1yhjtyYr9YcK/hWKQCkXung==
X-Received: by 2002:a05:6512:208:b0:4ee:d640:91eb with SMTP id a8-20020a056512020800b004eed64091ebmr6572026lfo.3.1683896736794;
        Fri, 12 May 2023 06:05:36 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id p17-20020a05651211f100b004f155762085sm1473028lfs.122.2023.05.12.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:05:36 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] nbd: Fix debugfs_create_dir error checking
Date:   Fri, 12 May 2023 17:05:32 +0400
Message-Id: <20230512130533.98709-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9c35c958f2c8..65ecde3e2a5b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1666,7 +1666,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1692,7 +1692,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.34.1

