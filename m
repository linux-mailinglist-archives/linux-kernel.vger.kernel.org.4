Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8964611138
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ1MYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1MYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:24:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12F60EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:24:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o12so7989858lfq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkNyqRiedTm3lH/AVehxw07LQ3B/+YJMsP8sTlhH3nE=;
        b=gRJ4praDAGw8E8zTwBp3rS9xfPk35V676mB/QeOxwyzopxEGteUPw9sAoLNXIZcgf9
         jYn1MJrjYBTGJsHpplB7gyPOGRQmuNahGxrApoE5EVDGy8vR2vjaRn7Sc+17KWyDI/D1
         QE7bX1McwmZpoHKNlL4Gj19GfK96ecrbnsK3Umt+aKDeEDJSVjvQAaCY5f+a7X8cwLVk
         /4w2zQ7SYWMSC1EU7AYWfQbkg10qvQqWSy6apCUNGinuTSHph6/Q2VpukkjMiBPEdgPK
         DzCLekHmldZ4N14x04bFscTVIcDtRa5SQROZT3XbBZ2oJCD+C00xk4qbSofI8nbWT3uw
         3vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkNyqRiedTm3lH/AVehxw07LQ3B/+YJMsP8sTlhH3nE=;
        b=6lD1WWS102YDnQlpz1g1OzlSvw//cqOmcPSISdU7VClHsyRI19ITQz3IhOjxtvnd1A
         oTG3SZCOs40l9ZHina9LuUPYuUpWTAgiSJBN3J9FDpaRCQDUQgkSjoyVf9INzlXsf1QZ
         hdnrW/jTXBjv5BGHxiSSLlNm1EZpAov04t8v7Q1xgK4DXuIA4I40X41DjZo5r4ouISfK
         WWz5mvfgu5lio7ZfPkwIvFlY8cOGn3UdNowtgq+eNnkErk303UxF6bGe+N/aoki9C1FW
         G1J1JeL5eqMRaFoUv4sP+Pa3GbOI4xond2m6KSKiv6GxGs8v/FHPK3eu+73VAYHP8ECd
         l62A==
X-Gm-Message-State: ACrzQf3DBKg8VfX07dLu//6I3ZAtLvkIm/kSV0Gm+9KiaXqtnuw3t0YQ
        xp+3Rof9dJqKZDSQroWf0X0=
X-Google-Smtp-Source: AMsMyM6RoZ8X77fBYLy65DpIZTWDdHUBFFqnJHhzGbQmFoLXJxxHjOLEj+VwHQ8LhoccmrYbZDsknA==
X-Received: by 2002:a05:6512:3085:b0:4a2:7d80:d4b4 with SMTP id z5-20020a056512308500b004a27d80d4b4mr21397278lfd.534.1666959865943;
        Fri, 28 Oct 2022 05:24:25 -0700 (PDT)
Received: from localhost.localdomain ([95.79.189.126])
        by smtp.gmail.com with ESMTPSA id x16-20020a056512079000b00498f871f33fsm546686lfr.86.2022.10.28.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:24:25 -0700 (PDT)
From:   Oleg Kanatov <okanatov@gmail.com>
X-Google-Original-From: Oleg Kanatov <okanatov@astralinux.ru>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Oleg Kanatov <okanatov@astralinux.ru>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, Oleg Kanatov <okanatov@gmail.com>
Subject: [PATCH] jfs: makes diUnmount/diMount in jfs_mount_rw atomic
Date:   Fri, 28 Oct 2022 15:22:54 +0300
Message-Id: <20221028122254.21081-1-okanatov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jfs_mount_rw can call diUnmount and then diMount. These calls
change the imap pointer.
In case JFS filesystem is mounted on root (/), between these two
calls there may be calls of function jfs_lookup().
The jfs_lookup() function calls jfs_iget(), which, in its turn,
calls diRead(). The latter references the imap pointer.
That may cause diRead() to refer to a pointer "freed" in
diUnmount().
This commit makes calls diUnmount()/diMount() be atomic so that
nothing will read the imap pointer until the whole remount is
completed.

Signed-off-by: Oleg Kanatov <okanatov@gmail.com>
---
 fs/jfs/jfs_imap.c  | 2 +-
 fs/jfs/jfs_mount.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..390cbfce391f 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -310,8 +310,8 @@ int diRead(struct inode *ip)
 	iagno = INOTOIAG(ip->i_ino);
 
 	/* read the iag */
-	imap = JFS_IP(ipimap)->i_imap;
 	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
+	imap = JFS_IP(ipimap)->i_imap;
 	rc = diIAGRead(imap, iagno, &mp);
 	IREAD_UNLOCK(ipimap);
 	if (rc) {
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 48d1f70f786c..972b9ff18723 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -234,12 +234,18 @@ int jfs_mount_rw(struct super_block *sb, int remount)
 
 		truncate_inode_pages(sbi->ipimap->i_mapping, 0);
 		truncate_inode_pages(sbi->ipbmap->i_mapping, 0);
+
+		IWRITE_LOCK(sbi->ipimap, RDWRLOCK_IMAP);
+
 		diUnmount(sbi->ipimap, 1);
 		if ((rc = diMount(sbi->ipimap))) {
+			IWRITE_UNLOCK(sbi->ipimap);
 			jfs_err("jfs_mount_rw: diMount failed!");
 			return rc;
 		}
 
+		IWRITE_UNLOCK(sbi->ipimap);
+
 		dbUnmount(sbi->ipbmap, 1);
 		if ((rc = dbMount(sbi->ipbmap))) {
 			jfs_err("jfs_mount_rw: dbMount failed!");
-- 
2.30.2

