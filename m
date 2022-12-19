Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AD650E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiLSPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiLSPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:47 -0500
X-Greylist: delayed 970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 07:06:34 PST
Received: from mail.ivk.ru (mail.ivk.ru [185.6.174.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D533B8A;
        Mon, 19 Dec 2022 07:06:34 -0800 (PST)
Received: from localhost.localdomain (unknown [91.190.239.60])
        by mail.ivk.ru (Postfix) with ESMTPA id B063320002;
        Mon, 19 Dec 2022 17:39:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ivk.ru;
        s=FFC20516-06DA-11EA-9F07-2A32BFAFF1B3; t=1671460786;
        bh=EowtjHuj3mSbkT+YGM3kfnkKglQvj+7gOskOHco/nSk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=AFziF1H55xXg2l1Bgc2kVpdBuIyd91i6MYjU714BznG2NnMm2jo5w2xfQxTPcSIGn
         mlFsKENt4Cw0kqXZc6u+maxhw5Byf0YmZUX641f+pSm7ebdMkXWcGtktXkREyWpq2v
         0admCKhx1CKcLxGkrcRuuI6wKNpm+I1QK8KKprZZ/yJk3p7bMyWOgD8y+09TEkJym+
         qZGNKeHv80/3rFSfVD5MplM81tkQ7a6CBm9VC+05HDmNqSv1+yYy4z0CcSkQIY91Kn
         vCBjTBG0YibwplvDfVa5rdNgfqGuVRTzr8mYk92RJgaLl/HTHAvgNdrD6ZKz+eRcnm
         EJRKXGSA22aEbj7637ysTfRbckWac50bLj8CWNAOFcF5WeZ4Kbuqb1oTujrTgFzgks
         yUo+L+uLNipcIP4dyOUF8BVaGsRRXB8fKWcyTItk8mEzm5m7Q56kS+CdDZdclUJmQm
         7apb2Rmm/lPjt2FZocJcUcWABGWPaurkAwMf3Clor1kkSfkwApAR04VxRKkENR8Uiv
         SzcJXZt15kmurdbmlj/LB25DFFXsn09uZdVPfhrajkYDgj0GPBmLLtCljPJicjpuAv
         6F0ds7x0YmyF1YjGM2rvkb54Ool4KykqQTNZAJVJwGK0HEnUoQP6D2woso/KnwXQJn
         3n8SdCMVMc7+OcpuC1rG6D18=
From:   Nikolay Burykin <burikin@ivk.ru>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Nikolay Burykin <burikin@ivk.ru>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        khoroshilov@ispras.ru
Subject: [PATCH] ide: fix for potential NULL-pointer dereference
Date:   Mon, 19 Dec 2022 17:39:17 +0300
Message-Id: <20221219143917.30434-1-burikin@ivk.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having been compared to NULL value at ide-io.c:370,
pointer 'rq->rq_disk' is dereferenced at ide-io.c:381.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikolay Burykin <burikin@ivk.ru>
---
 drivers/ide/ide-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 4867b67b60d6..343e93824b03 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -367,7 +367,11 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 			    pm->pm_step == IDE_PM_COMPLETED)
 				ide_complete_pm_rq(drive, rq);
 			return startstop;
-		} else if (!rq->rq_disk && ata_misc_request(rq))
+		} else if (!rq->rq_disk) {
+			if (!ata_misc_request(rq)) {
+				rq->rq_flags |= RQF_FAILED;
+				goto kill_rq;
+			}
 			/*
 			 * TODO: Once all ULDs have been modified to
 			 * check for specific op codes rather than
@@ -377,6 +381,7 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 			 * dropped entirely.
 			 */
 			return ide_special_rq(drive, rq);
+		}
 
 		drv = *(struct ide_driver **)rq->rq_disk->private_data;
 
-- 
2.38.1

