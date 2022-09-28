Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81B5EE953
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiI1WXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiI1WXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:23:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9291F1845;
        Wed, 28 Sep 2022 15:23:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nb11so29954976ejc.5;
        Wed, 28 Sep 2022 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WDKi9txDnR96mWTFi3TxoUHk50O1PPK5PS3apLyu50E=;
        b=Q420+RDZ9YEImmbhuVex18abBnGNeUJaYkULZCE8MjRpGLkAWraDBnm6acQt441jzu
         RjeaPZsS63KonbulSz8DMxk8X+imZFpCnh9pJqW0SGcB8zFAdOGRkhSmAzhH8IVJPRmB
         Y8DljLGoLv3Q6M0C4hBOcy00fuZYZwE0rBICqMbHUJKn1j92nUEHXKUInKQm4IvNUNu0
         ZbLp2Lw0GWNKfdfohKOpNY2o8evaC+b842lHyu4VFiid5JfYoWJ3tvrdzyEcnJ11sf3s
         sCnlgdumCwyTRSzDRQajZndUn+pOz62W6ZM3oCRtURFdFnP4W16tSLjpybhpZzAqwYNx
         a/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WDKi9txDnR96mWTFi3TxoUHk50O1PPK5PS3apLyu50E=;
        b=TT31nLoZO6xo0MjP0XOgE00DGF+YFUBREaTOhypw6yeRxB3HVkTCBPgnNvjgDTcs/a
         3f5J6TTTa2o5itTuEgU6WIBaZWAHYHP/lCJITxkY7W7BFWWfy+jIDtT77l96achLvHq/
         XhtVBLa8L1PH68nzrfaA45haswQbWP4DHNnbSORTGT5vYY1vRaFTmO5aOnPUOdEvNquG
         F1tkNjvX1tjJKfMNWx+AHZXZWBUDmlataUWlPgUb5F41hsoFRwyMBd6jvUPn9CUx53jH
         fBPIu7ZztT6JbR8q5r6Om4Kjx9U+37r0ZfRPKsYbepZD2ZTA2nxpY9OzvXXiWkRVcs4/
         9Zhw==
X-Gm-Message-State: ACrzQf0j5Kxb/ROnG36hYKE2UAnV3ELeWfRlZ4a7s0RQcqbhzkssxQ8u
        pL0oCSU55dWnH2hcZq1Ir8z0UBm7/0k=
X-Google-Smtp-Source: AMsMyM5JP6IoEv35aAYdToM34wFs3ep9GC12AMZr1h0AB7Qa5VpmC8ivQ9oOPASEe+12mtWYAGlxlw==
X-Received: by 2002:a17:907:6d98:b0:782:a1b5:9636 with SMTP id sb24-20020a1709076d9800b00782a1b59636mr86475ejc.177.1664403824416;
        Wed, 28 Sep 2022 15:23:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810d:6e40:e18:7e7c:1993:f196:df58])
        by smtp.gmail.com with ESMTPSA id kt27-20020a170906aadb00b0073d9a0d0cbcsm2939537ejb.72.2022.09.28.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:23:43 -0700 (PDT)
From:   Markus Fuchs <mklntf@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Markus Fuchs <mklntf@gmail.com>
Subject: [PATCH] scsi: ufs: Remove unneeded casts from void *
Date:   Thu, 29 Sep 2022 00:22:42 +0200
Message-Id: <20220928222241.131334-1-mklntf@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The end_io_data member of the "struct request" type has type "void *", so no
cast is necessary.

Signed-off-by: Markus Fuchs <mklntf@gmail.com>
---
 drivers/ufs/core/ufshpb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index a1a7a1175a5a..0ce5063bedc5 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -615,14 +615,14 @@ static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
 
 static void ufshpb_umap_req_compl_fn(struct request *req, blk_status_t error)
 {
-	struct ufshpb_req *umap_req = (struct ufshpb_req *)req->end_io_data;
+	struct ufshpb_req *umap_req = req->end_io_data;
 
 	ufshpb_put_req(umap_req->hpb, umap_req);
 }
 
 static void ufshpb_map_req_compl_fn(struct request *req, blk_status_t error)
 {
-	struct ufshpb_req *map_req = (struct ufshpb_req *) req->end_io_data;
+	struct ufshpb_req *map_req = req->end_io_data;
 	struct ufshpb_lu *hpb = map_req->hpb;
 	struct ufshpb_subregion *srgn;
 	unsigned long flags;
-- 
2.37.3

