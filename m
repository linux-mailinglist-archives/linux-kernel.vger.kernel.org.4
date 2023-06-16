Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15E3732F37
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbjFPK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345541AbjFPK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DB8682;
        Fri, 16 Jun 2023 03:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DE0635F3;
        Fri, 16 Jun 2023 10:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A5EC433C0;
        Fri, 16 Jun 2023 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911334;
        bh=oSMXR/HjDE60lLaUFRyr17SQk8tUZHFVAN/RdtCRu3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=jSCp6azbb59GRuBgttWXaMakWyX8Vx5k4d1xT7s7Ysgz6BWqZ8SC/n7ipfglPf9O1
         r1v8xYL3MUge44hVseJdrLyGKQ4vvV+/eG4SKFy7CqzjWgciy6GZL22y1hQuOuN4m3
         7ktrhb8AbBNS7TkRdcMLczg+EpSLeQWMEkrL+Md0xWHX0sjsRGSpsjoZC89+iO0Kv/
         PaesfgHwpU4xrOTdZZasqfqzzhXN/vXIHJQwIM0AgLPNvmZdc8xOpjkYq1VmxrPF0I
         mf8HXhB3/aU9SJC306jQ9bVfgStGKDODAzNYXlT3BCYUBymoiVg/tXiPddrM61Q+7g
         mYLFDAMfD/ylw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/5] s390/cio: unregister device when the only path is gone
Date:   Fri, 16 Jun 2023 06:28:47 -0400
Message-Id: <20230616102852.674366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.318
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit 89c0c62e947a01e7a36b54582fd9c9e346170255 ]

Currently, if the device is offline and all the channel paths are
either configured or varied offline, the associated subchannel gets
unregistered. Don't unregister the subchannel, instead unregister
offline device.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d2203cd178138..6721e984782db 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1357,6 +1357,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1389,7 +1390,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1451,6 +1452,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1484,6 +1486,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		if (cdev->private->flags.resuming) {
-- 
2.39.2

