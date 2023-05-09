Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDB6FCBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjEIQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEIQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:52:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76721BD3;
        Tue,  9 May 2023 09:52:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so4257366a91.0;
        Tue, 09 May 2023 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651153; x=1686243153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrzAg4b1IL2WebYrz9jjSo4DKTQ6JUzCbfd1CBaJHyY=;
        b=EBtnPLaE9IhJzG6EU9DHfnUGk950MAheAVNyDRdH92n+XxoAXpfbDHIkIPRRLF/Wv6
         pXuZn+VO9YDQs9fttlQU1VsMywC4P4pTQePt+QmyM1k8uYqOianw94J3gFb/K9NbNOsf
         dx1SpIboVTxK89m5yhMRA6Nq9c2RAaT1hebFI1NQClKcKI1zXkpU2MuWFJ/L4Br38tdd
         S8LbqxMHrUMEZH0zjSumPkJ/MZVTCuEkFy3a6+faAvu90wsb4vkhAZBE2zEQOHcttTrN
         TIrTZkvToWUC1b2wq09rWMzzZnQ1PKnSgmT5j8VDXzTdIjy1DRoqBoADSzdRInwQysv5
         TYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651153; x=1686243153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrzAg4b1IL2WebYrz9jjSo4DKTQ6JUzCbfd1CBaJHyY=;
        b=d4KAyTHPPaQUuLBxd0nVsMbQkSr9j/iNblq1aiAbTH2+ztfg8G/gH5JAIS6JBJwcby
         CyXVrmp0e+tGc7XFelP3W30LIgVrQ9oTfVTU5R1dE1Iejiz+/uAgxgddYPLh/4lpEPF6
         1o14DSXNcHkj3aiKTN5/UUDrA51It+eJA6c494xN5pGYA4mdV28bOP/Kgh0cCRN2aX1I
         VqFG2kQwjVpmr+jFyuauRW10q1wtB62vQBILw0f6527uPoM/IDoPHYk2eGs9biBJ5uKg
         3ZC81IYPjRuQVCmDk2hBwKt3gvN4hq8yPGgeMVSDN+czWFNO0kqFIaSqi7dk92Dk+xzz
         5lPQ==
X-Gm-Message-State: AC+VfDwLOf8lyZKju9wtSxanTEelXCeMtanIUuHWLRmoWD1qy01n1aJT
        B7gG8Psox98vZSg7HSGUO3ac/33isT4=
X-Google-Smtp-Source: ACHHUZ7DXpQbxKcrVivCCV+L9RdZZPI6fMa5rxR7MnawmK2vcr0LkFSSp0RPC+CfG5RTxjj/ujpa9A==
X-Received: by 2002:a17:90b:19d4:b0:24e:46f8:492a with SMTP id nm20-20020a17090b19d400b0024e46f8492amr14099171pjb.46.1683651152985;
        Tue, 09 May 2023 09:52:32 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id lw6-20020a17090b180600b002505f8b9c53sm5503986pjb.38.2023.05.09.09.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:32 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v5 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Tue,  9 May 2023 16:52:16 +0000
Message-Id: <20230509165218.139568-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509165218.139568-1-raghuhack78@gmail.com>
References: <20230509165218.139568-1-raghuhack78@gmail.com>
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

Issue found with checkpatch

A return of errno should be good enough if the memory allocation fails,
the error message here is redundant as per the coding style, removing it.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
---
 drivers/cxl/core/mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..11ea145b4b1f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	struct cxl_dev_state *cxlds;
 
 	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
-	if (!cxlds) {
-		dev_err(dev, "No memory available\n");
+	if (!cxlds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
-- 
2.39.2

