Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142996C8EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCYOG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 10:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DEF113C4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679753165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1lbJBPwhH6Cq9r2UgzRHc6kwTuKIZL2sdzIekbj7z0w=;
        b=M0WjYVY4Endfd3wsBcY0gooZu3PfbSv4Mq5rOxb63ir4HHaxcDNcTxGdClYxFkeEtf/2PS
        5SLNfDg5Z3mkmjpE/K9afWza4Az/0VvBuVaFhDiRnKEV/S4Tir40u3ISZsQoYeZDMoCjIA
        LBCVdtUL/lpCgT6FPFVsBr7vs9T34pk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-aZnmkOPAMke1eYy9SLoXzw-1; Sat, 25 Mar 2023 10:06:03 -0400
X-MC-Unique: aZnmkOPAMke1eYy9SLoXzw-1
Received: by mail-qv1-f70.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so2110219qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 07:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679753163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lbJBPwhH6Cq9r2UgzRHc6kwTuKIZL2sdzIekbj7z0w=;
        b=MwWHw7ZL/0+thiEi2CTGQZoieIKhd8xIBmRVB+q4zIdwFx9YOPgQh4dlJsmAtro/GY
         0uQMHwY0e4s7WZ4XK4BAG8KzFMesyDu5P9G1ntnSMgyjUNh+UDI2sAA6jJpt+/0oGiKi
         UbgnrObNYNNQI2S+xMAIKryPQZMJPfzF+BilM0A4yff6EmYSQ0I2qU2OLCWiD9uxsmC+
         sqkbOp53t9dPtqn5GyXJ7Ji9VYCgT1i2BFyWgT4NY/WUnjHkRYbiKWCxP3W8hSTalnAZ
         VLpUxDjBgxTPE3ZhfhEmD4Lejt0K8gaapSSa0AocfDfOpPDYHWSh7aV3YAOTvBlj2bLI
         R0Kg==
X-Gm-Message-State: AAQBX9cXwZduFW0QJ9woIFG6S+kZxkP5fVKmHKLygzlQNjyTtLe8a3yJ
        jWS86LYh5B5HFvVZMw0lwqG9tQUFooThH4WKbNOYG1xrpy+TuG5NmCBj3F8N1QsXPnie3d5zBjQ
        vS4qYdR/KiVx9aODuYBD4B/Gl
X-Received: by 2002:a05:6214:cc1:b0:5d9:cb0b:3de4 with SMTP id 1-20020a0562140cc100b005d9cb0b3de4mr12296845qvx.45.1679753163300;
        Sat, 25 Mar 2023 07:06:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/EL6Tkp3U6JqLt4Li2rJy95cscsYC+qqgT2enwwScQiVROP52ZEJU7J0WILTQqrJ+SkA3kQ==
X-Received: by 2002:a05:6214:cc1:b0:5d9:cb0b:3de4 with SMTP id 1-20020a0562140cc100b005d9cb0b3de4mr12296776qvx.45.1679753162854;
        Sat, 25 Mar 2023 07:06:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id oj9-20020a056214440900b005dd8b9345bbsm1478977qvb.83.2023.03.25.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 07:06:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/bnxt_re: remove unused num_srqne_processed and num_cqne_processed variables
Date:   Sat, 25 Mar 2023 10:05:59 -0400
Message-Id: <20230325140559.1336056-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/infiniband/hw/bnxt_re/qplib_fp.c:303:6: error: variable
  'num_srqne_processed' set but not used [-Werror,-Wunused-but-set-variable]
        int num_srqne_processed = 0;
            ^
drivers/infiniband/hw/bnxt_re/qplib_fp.c:304:6: error: variable
  'num_cqne_processed' set but not used [-Werror,-Wunused-but-set-variable]
        int num_cqne_processed = 0;
            ^
These variables are not used so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 96e581ced50e..0ba14087dfcd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -300,8 +300,6 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 {
 	struct bnxt_qplib_nq *nq = from_tasklet(nq, t, nq_tasklet);
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
-	int num_srqne_processed = 0;
-	int num_cqne_processed = 0;
 	struct bnxt_qplib_cq *cq;
 	int budget = nq->budget;
 	u32 sw_cons, raw_cons;
@@ -340,9 +338,7 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 					    DBC_DBC_TYPE_CQ_ARMENA);
 			spin_lock_bh(&cq->compl_lock);
 			atomic_set(&cq->arm_state, 0);
-			if (!nq->cqn_handler(nq, (cq)))
-				num_cqne_processed++;
-			else
+			if (nq->cqn_handler(nq, (cq)))
 				dev_warn(&nq->pdev->dev,
 					 "cqn - type 0x%x not handled\n", type);
 			cq->cnq_events++;
@@ -361,11 +357,9 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 			srq = (struct bnxt_qplib_srq *)q_handle;
 			bnxt_qplib_armen_db(&srq->dbinfo,
 					    DBC_DBC_TYPE_SRQ_ARMENA);
-			if (!nq->srqn_handler(nq,
-					      (struct bnxt_qplib_srq *)q_handle,
-					      nqsrqe->event))
-				num_srqne_processed++;
-			else
+			if (nq->srqn_handler(nq,
+					     (struct bnxt_qplib_srq *)q_handle,
+					     nqsrqe->event))
 				dev_warn(&nq->pdev->dev,
 					 "SRQ event 0x%x not handled\n",
 					 nqsrqe->event);
-- 
2.27.0

