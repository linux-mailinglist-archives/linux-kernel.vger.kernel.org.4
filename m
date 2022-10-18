Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283F60282F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJRJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJRJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:20:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF7AA37C;
        Tue, 18 Oct 2022 02:20:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so12800015pgb.6;
        Tue, 18 Oct 2022 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m5oTxItBn/6lCKglYoGymxp7X2N7jqkr135BYmrYCw=;
        b=IpfdrNyZsDPBXc/FGZOSy1FhoPRGUDzoLenXgqDEkuDqCTU1oGCZzpTh0AvqTQDtKm
         Uj8RS//OjPHTM//LTuRe3uhckUeU5Rbrzk1wggAXvJ9DY+zs80hh5r90s7cNb9gKCCxP
         Pt9q6a/2BRO3BBjVyJzcMBmYX/eAtPQhAN2MBXPZCW8Dx1Nyp1nf0ly9Z11rhNqEo6vz
         ydH9iCGVh9A9sydT3fva9eLdOWv3hqvDIYi/WaYe04E/UvUBFHRyyLDBizmZlojJTLRv
         VyjUtc9pGgzBtVFN5XMQGbW6NElGke0PxF8PhkdxFfUnl54I+bU/VS+G2Q7VR74MR992
         OO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m5oTxItBn/6lCKglYoGymxp7X2N7jqkr135BYmrYCw=;
        b=jQNjzWijHQ3M00ipVi35EUIlUDjRfwQQP336T68h3gmE7IxVQUg6HNbLEDUqlmzpXW
         78jedKGHOPUPZqOtSNQGGt8ltvbV02mKaHYxjWAk4bHhPICvafBLfw6RtIPi+JM83LZ1
         t5AFOV9k2yMwzkQ7wEQBHpxf4MvXPr0/AqcZ2UzgW3Dqm0fcBgfrijxnTKIm77ftFbiU
         pY9hK2gGTgfonI2G57aj9XsoKReL8yPchE2n4Rl8GTBGh9QVdavEq12hWQ5t69rzeO7x
         9LLJ2vsgQvEGH70EETDzjrSvID50ddIr5ZqAigxKWF3vNB8gQUdHpPPs3eRRAsvIKiZd
         olIQ==
X-Gm-Message-State: ACrzQf2t0bQxdXdVkQhnzU/xLcGhdgeAvNt/avvW7sxUpsM6b3b4jxzg
        bXqr0Wg+3GAFCyway8TCL+wpTj539e63F9Xe
X-Google-Smtp-Source: AMsMyM5oz9A+uCOmRVQ78bVe8vnFMBJxmzhuIz73JNHTMTfO8AOEmmTG03uabKHRAzJnR0X1Go+snQ==
X-Received: by 2002:a63:4750:0:b0:43c:dac:9e4b with SMTP id w16-20020a634750000000b0043c0dac9e4bmr1888341pgk.300.1666084839449;
        Tue, 18 Oct 2022 02:20:39 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b00173411a4385sm8182912plj.43.2022.10.18.02.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:20:39 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] scsi: qla2xxx: simplify conditional
Date:   Tue, 18 Oct 2022 17:20:27 +0800
Message-Id: <20221018092027.264641-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

Fix the following coccicheck warning:
./drivers/scsi/qla2xxx/qla_target.c:1031:20-22: WARNING !A || A && B is equivalent to !A || B

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index bb754a950802..4ee89ef2ab90 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
 		}
 
 		if (ha->flags.edif_enabled &&
-		    (!own || (own &&
-			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
+		    (!own || (own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
 			sess->edif.authok = 0;
 			if (!ha->flags.host_shutting_down) {
 				ql_dbg(ql_dbg_edif, vha, 0x911e,
-- 
2.27.0

