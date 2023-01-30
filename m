Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16026806C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjA3H44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3H4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:56:55 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17853279AA;
        Sun, 29 Jan 2023 23:56:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o12so11710042ljp.11;
        Sun, 29 Jan 2023 23:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxjejnf+qHKVQ1YQcmwOkN18hl/Nwiz0oq4H7oGqOVc=;
        b=ifbLiIwx1QkjeNx4VZUd7c/9Ix9+6W76OsYE4tFo9MEGqrgzWgmdmxMyISn2y9Bq2z
         Av6mgrwEczL5nbgHCmYTbSYzU65n8GHfV/RW83oC9pglKDw1ogpJWqeJwbtFDRwop+hn
         Blvz6ae3YaON6Bx0/voPe/5uMDX3p/mgoPZWVSJ6LJI8m/Teen9tZuuhu+6ZGe8x3nmv
         UAgUMuxxeFwld8omz4boagZ7UQbVYw7itSOYlbXs4qPzY/R59wenWoj29KCakXVwscM3
         Bv03aRCw9CTpycfuRvNdYKmA73xN2mTiox1Pj7Fjb2fQzP2bHzIPogtfX/kCAeL1cd8R
         htCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxjejnf+qHKVQ1YQcmwOkN18hl/Nwiz0oq4H7oGqOVc=;
        b=bNWBtPY6aaBwYT+6dwJvsLxKpKcaODAK0AaHR0eqNIAooKyI3F54tJpcSG9RC7ZvGv
         0NEzhTQffORLK6y67d0VQ4aVA88eihJ1wSArGoVLLcmGh5M5v5lMroOSZVIkGs2vfIzv
         8W/g8xIvZjhI1ul7sbuJJZNVxTtYFkWARRo7yI1kFaq5N5OlN7G4g0atJIPzCErEcaIU
         pMpWtycZXsV1WIIS77V7K40sRv42J1P60XcbZjpgxWKc6kseZ3slwj0Jdyb7aHFNsgpw
         H202yfVdLY3Zw0A4pQs72rPNGNqODNEsgSldfOoYt/dy8O3T3HjUzm3LX9ajIDmnYT8l
         6DvQ==
X-Gm-Message-State: AO0yUKVOzmR3fRZpOxENqEdU6h87fcd4fea2IxuBuksQVhTFiq2zeS0e
        bKEtQ2fNW05Ay7SmiUXrECZlu2JE3xE=
X-Google-Smtp-Source: AMrXdXt2UFDcrXI0Shm47v8sKGf2D+KdwABvPpv8QquopCYW43xOw2FHor6i1oOWHOyQocqVchI+tQ==
X-Received: by 2002:a17:906:60d0:b0:877:612e:516e with SMTP id f16-20020a17090660d000b00877612e516emr145029435ejk.61.1675065401916;
        Sun, 29 Jan 2023 23:56:41 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:893:4a0f:7898:3492])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170906f6d100b008785b914883sm6481176ejb.116.2023.01.29.23.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 23:56:41 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: ufs: qcom: include specific ops when GENERIC_MSI_IRQ is set
Date:   Mon, 30 Jan 2023 08:56:15 +0100
Message-Id: <20230130075615.17108-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") removes
the config GENERIC_MSI_IRQ_DOMAIN and replaces all references with
GENERIC_MSI_IRQ.

Probably due to concurrent development, commit 519b6274a777 ("scsi: ufs:
qcom: Add MCQ ESI config vendor specific ops") adds an ifdef block
conditional under the config GENERIC_MSI_IRQ_DOMAIN.

Make this code conditional under the existing config GENERIC_MSI_IRQ.

Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 681da3ea7154..14283f6dc3f7 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1538,7 +1538,7 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
 	return 0;
 }
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-- 
2.17.1

