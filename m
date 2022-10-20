Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7086056F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJTFrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTFrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:47:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CB159D5F;
        Wed, 19 Oct 2022 22:46:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e129so18272363pgc.9;
        Wed, 19 Oct 2022 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovO4Wn2KciXjhfhIU1Ht+t+UirFlYYyzrqGDJdPLqqI=;
        b=Ko+4G9InvfhExZOlJfPtkMVy/D5gdhgAia6F8iPargASMfbh6TDIkDbuK6cxdw5MUI
         6IAiGIKEEoodin9JQjbz4cFOq0loHWMlsMPs6EpJDR7+IRrAzRNDOEl9PTDKJPQpOgq1
         cdXUH05ZeMS9Rq+xGcQ/cfjjjeOZIY4rAfNrVhIx+sUvXHZvjCaAk40IhmZzfAhFm2dt
         uGxoHw+EOvF4C5aCq1OCafCBUUP093CdYJYYDNpab1RsU3EhQELMmAUzWjuL3aw569Mt
         CNP/xTEjj27zgCAjwatHvaL1XRTHyKoqlSOv3EoYAASFFEP419W8tttiP7R340T0kGPo
         ErkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovO4Wn2KciXjhfhIU1Ht+t+UirFlYYyzrqGDJdPLqqI=;
        b=h21fgMfG731dh3HlLi/zj79RbzTg2hbquaoojkJFRFg0p8BPWheLTPntNIkCSA56qJ
         S2Dsy1q81PNOMjlRNsMO+J1R+C+LCB3vZYiyRk2Xdwey3ncQLxFWJVqJwe17TP+qG1So
         uQgiy60/AB9qkI/Tqsm0E5OSJnFtD/EMqv1GdPxXVawIDs25LMIsapWdrDyPxRWJZByj
         +uesG5+cAHL708VubJwMGV4zxhFf5XlMczgAscYF52av2HOjdXkQtf+f2yxDsXqAePg0
         aTRvDFL6rQu/6WPHqwbYNALBdO7/KBa5wDvgJAX1aP1/p3uuX5kyAgh3BHLsRfwfeM6s
         eKXw==
X-Gm-Message-State: ACrzQf3yuuKxW1ogszIlCvm1G5YVOtozK914EMXoR3cpoIzK1Rm1M45i
        +mfXrRX63BVpx/XYB+jtbDL6PvoeIno=
X-Google-Smtp-Source: AMsMyM7Ueen3Nu9ppQUHWRCrMntwIJPRbnc9qTy4XNKiB3UH010g2eyTQdJH2TCd9WHa7Nx8FtdFfw==
X-Received: by 2002:a63:194b:0:b0:457:7295:8de0 with SMTP id 11-20020a63194b000000b0045772958de0mr10618087pgz.612.1666244818452;
        Wed, 19 Oct 2022 22:46:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r16-20020a63e510000000b004308422060csm10651732pgh.69.2022.10.19.22.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 22:46:57 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: target: core: use strscpy() is more robust and safer
Date:   Thu, 20 Oct 2022 05:46:50 +0000
Message-Id: <20221020054650.394396-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/target/target_core_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index b7f16ee8aa0e..0eec5a3217b9 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -809,10 +809,10 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	xcopy_lun->lun_tpg = &xcopy_pt_tpg;
 
 	/* Preload the default INQUIRY const values */
-	strlcpy(dev->t10_wwn.vendor, "LIO-ORG", sizeof(dev->t10_wwn.vendor));
-	strlcpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
+	strscpy(dev->t10_wwn.vendor, "LIO-ORG", sizeof(dev->t10_wwn.vendor));
+	strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
 		sizeof(dev->t10_wwn.model));
-	strlcpy(dev->t10_wwn.revision, dev->transport->inquiry_rev,
+	strscpy(dev->t10_wwn.revision, dev->transport->inquiry_rev,
 		sizeof(dev->t10_wwn.revision));
 
 	return dev;
-- 
2.25.1

