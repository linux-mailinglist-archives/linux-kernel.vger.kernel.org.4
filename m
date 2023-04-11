Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B075D6DE00A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjDKPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDKPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:53:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952744C1A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:52:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso6611761pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681228373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oG+epnuD83PJFUb1t02t41ha4irl9qgnZRV9WS+FJU=;
        b=LsSi16s2QaAhnD5StmBi3qTbTfu6k5otTIp04Kgepy4OBb/g3EV75jjw2fZ4qPtK4J
         6IWcwGzEMkbVCNc4GZJ1Cxn5YbdAChFrvivl1t1n0YwzFBCvTj6DQfh3H3zCElqbbRqG
         yrngWHTv3NUJp9du0NHTNGxPyIxCOTVzfY0PQatHPH2RDfxl24kq2036Du9OU44/6Ia0
         aNGBIFFhfAo1MwMBdlJqTq35nVZIDHE9FLZuZip9A/6Q7urdq9FMRXrsvZpb1+ReO4kO
         vKBQEfLc3aF3btYS4rqRTyBD+dbMdSgx3XG9NLfD7vs5/Q4abLA867CPbVe9wTxOmgxL
         espA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oG+epnuD83PJFUb1t02t41ha4irl9qgnZRV9WS+FJU=;
        b=LcTurx+2oe7W5c+wT6Eu37fws8vOhA878ri9vpaeSmTvNpOqkaXOigMS7UfnepD66X
         9t6veDMx38CskSTMj4gPCJMP0Kugvb1kC+ZZE+dA9sBro3p+en36DvqmMvqytEYkr9iq
         jl9wKklneWSywTjOPjsAprnljXbFm0JXt7wnJWat6F7E1KadT8ACAFE9rzGr7ChsqQB3
         2+pNzcE+bIaj0GQNgdXqKJ0lBUv3rmV21MCQJnqtn104hfpvTzLori1vk/EJj4cnZ5gx
         Oe3DRrdp/OxbAN7NJkmWrRdYw2uE4mFHQmeGCRHGIiJ1BnopE2Tmu4gxp2pdqwp4P7ce
         ar3w==
X-Gm-Message-State: AAQBX9c8jYmfEyFZ71NjVnVUcnObwY7Dr8p39fil4vOjEtOknlqIgzoK
        qP9TRR8atxiwYD8mYMUCx8k=
X-Google-Smtp-Source: AKy350bP4ymDA4siTeWNM3hYExZR4vah/5d51CIzH8d82fybAJuDqzPeiRRg5VWjKUeDoSbGI8uAvA==
X-Received: by 2002:a17:902:f9c5:b0:1a5:f36:ae09 with SMTP id kz5-20020a170902f9c500b001a50f36ae09mr12465163plb.7.1681228373132;
        Tue, 11 Apr 2023 08:52:53 -0700 (PDT)
Received: from arm4c24g.vcn09251619.oraclevcn.com ([144.24.45.176])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b0019e60c645b1sm3940765plb.305.2023.04.11.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:52:52 -0700 (PDT)
From:   Xiaobing Luo <luoxiaobing0926@gmail.com>
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Subject: [PATCH] ubi: fastmap: Reserve PEBs and init fm_work when fastmap is used.
Date:   Tue, 11 Apr 2023 15:46:34 +0000
Message-Id: <20230411154634.149350-1-luoxiaobing0926@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't reserve the two fastmap PEBs when fastmap is disabled, then we can
use the two PEBs in small ubi device.
And don't init the fm_work when fastmap is disabled.

Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>
---
 drivers/mtd/ubi/build.c      | 3 ++-
 drivers/mtd/ubi/fastmap-wl.c | 2 +-
 drivers/mtd/ubi/wl.c         | 6 +++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index ad025b2ee417..a98a717b0e66 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1120,7 +1120,8 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 		kthread_stop(ubi->bgt_thread);
 
 #ifdef CONFIG_MTD_UBI_FASTMAP
-	cancel_work_sync(&ubi->fm_work);
+	if (!ubi->fm_disabled)
+		cancel_work_sync(&ubi->fm_work);
 #endif
 	ubi_debugfs_exit_dev(ubi);
 	uif_close(ubi);
diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index 863f571f1adb..b3df17a782c7 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -344,7 +344,7 @@ static struct ubi_wl_entry *get_peb_for_wl(struct ubi_device *ubi)
 		/* We cannot update the fastmap here because this
 		 * function is called in atomic context.
 		 * Let's fail here and refill/update it as soon as possible. */
-		if (!ubi->fm_work_scheduled) {
+		if (!ubi->fm_work_scheduled && !ubi->fm_disabled) {
 			ubi->fm_work_scheduled = 1;
 			schedule_work(&ubi->fm_work);
 		}
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 26a214f016c1..8906db89808f 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1908,7 +1908,11 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	ubi_assert(ubi->good_peb_count == found_pebs);
 
 	reserved_pebs = WL_RESERVED_PEBS;
-	ubi_fastmap_init(ubi, &reserved_pebs);
+
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	if (!ubi->fm_disabled)
+		ubi_fastmap_init(ubi, &reserved_pebs);
+#endif
 
 	if (ubi->avail_pebs < reserved_pebs) {
 		ubi_err(ubi, "no enough physical eraseblocks (%d, need %d)",
-- 
2.34.1

