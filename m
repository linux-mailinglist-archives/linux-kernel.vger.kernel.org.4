Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570766FC335
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEIJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjEIJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:50:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB2D9;
        Tue,  9 May 2023 02:50:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6436e004954so5828729b3a.0;
        Tue, 09 May 2023 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683625830; x=1686217830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrzAg4b1IL2WebYrz9jjSo4DKTQ6JUzCbfd1CBaJHyY=;
        b=p3VjtkCnEbcJZApi7MnwtJC+ENSPLKsnogxh1eE7XpNpL38JyHqEc3R0AJ1c5/Rpfk
         J0s/v9ibfbZUjaiOy8mIqppXv54z+giTTe5aekZ2+B5vWrCMGGU/vKyKBP2sqZMUDBd2
         iFwfp16swuPZuj6SF1keGvUaahk5XPsqqR/K1inJemmfKiG2AY5nkU7AS7v99/jbw7iU
         bMIlHME7DJCpjnrq1lBtlR82sX9ApJ0uTD7TuFRept33Wl9qNvriJa6nepDtGfcJHUD/
         1ar10D2JM6xSDh+m4sYjMjn5OokhWkwzC5RC0CK80fR9/qlWmhrrUKgnoYwQnSUg/4YZ
         C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683625830; x=1686217830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrzAg4b1IL2WebYrz9jjSo4DKTQ6JUzCbfd1CBaJHyY=;
        b=izL1PcZo97kNH2zjv9js8sLQGBA6dtB5mkz2wyYNSE1T++J8QW2JOKx3S176AqUOLp
         4xOkkrnZk+5Vdkn5Yer9jNmhZHGynZ7tXauYVwHenpT0zjcoXJhn2hiM4rzBMNh9+Z3Z
         717j5YO0rYGcg1PC0lH2KZ1f56tyxtg0mZZXmYgsOVZhaebMPPVKjLOUbUA06myNeQxb
         JHMAMYcM5X0XOsa92hXGapL2d0FQT+w6+V2ZuDQQ07eDeJi5z14brdVR5bmuzTaLl3qp
         h5LVqx+6BMTR0tDQl9+pe87DR9T7/u2GHJmpiWkcu2BMlIklnsZObDGQ4eAoVkntFSCj
         H1/g==
X-Gm-Message-State: AC+VfDy5H9QIyA8EYW8BQlhIRGs3jRcDOVM6F4D5mAsByms/CXRV1feB
        7bSFR1APqUu4EvtGTLDSUhOQNO8JY1Q=
X-Google-Smtp-Source: ACHHUZ7dizfbQsUR7EG0lvH5hXMlJLOJgMC3L/MMYSC+Iz+1q4hFUbkeECPt+ZmNs+WTjBUdu4sA3g==
X-Received: by 2002:a05:6a00:1a06:b0:645:e008:d7ba with SMTP id g6-20020a056a001a0600b00645e008d7bamr8436941pfv.27.1683625830092;
        Tue, 09 May 2023 02:50:30 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b00571cdbd0771sm1361998pfh.102.2023.05.09.02.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:50:29 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Tue,  9 May 2023 09:50:15 +0000
Message-Id: <20230509095016.138890-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509095016.138890-1-raghuhack78@gmail.com>
References: <20230509095016.138890-1-raghuhack78@gmail.com>
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

