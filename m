Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850A96D4B56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjDCPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjDCPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:03:25 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 08:03:16 PDT
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FADE74;
        Mon,  3 Apr 2023 08:03:16 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 947A0102391;
        Mon,  3 Apr 2023 17:36:15 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 8F7D1102390;
        Mon,  3 Apr 2023 17:35:30 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 333EZ6iP016467;
        Mon, 3 Apr 2023 17:35:06 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] scsi: megaraid: Fix null dereference
Date:   Mon,  3 Apr 2023 17:34:40 +0300
Message-Id: <20230403143440.1923323-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230403 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmdid == CMDID_INT_CMDS, the 'mbox' pointer is NULL but is
dereferenced below.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f2bb84d2a68 ("[SCSI] megaraid: simplify internal command handling")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/scsi/megaraid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index bf491af9f0d6..4fbf92dc717e 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1441,6 +1441,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			mbox = (mbox_t *)scb->raw_mbox;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
-- 
2.30.2

