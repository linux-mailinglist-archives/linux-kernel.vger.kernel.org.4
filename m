Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0969E2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjBUPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjBUPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:02:53 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24A6597;
        Tue, 21 Feb 2023 07:02:52 -0800 (PST)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31LF2mKS073435;
        Wed, 22 Feb 2023 00:02:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 22 Feb 2023 00:02:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31LF2mkP073432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Feb 2023 00:02:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp>
Date:   Wed, 22 Feb 2023 00:02:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] scsi: message: fusion: avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
macro") says, flush_scheduled_work() is dangerous and will be forbidden.

Commit 4d4109d0eb69 ("[SCSI] mpt fusion: Power Management fixes for MPT
SAS PCI-E controllers") added flush_scheduled_work() call into
mptscsih_suspend(). As of commit 4d4109d0eb69, there were several
schedule{,_delayed}_work() calls where flush_scheduled_work() from
mptscsih_suspend() meant to wait for completion, but which work items
is this flush_scheduled_work() call for was not explained.

Then, schedule_work("struct mptsas_hotplug_event"->work) and
schedule_work(MPT_ADAPTER->sas_persist_task) has been removed by
commit 3eb0822c6740 ("[SCSI] mpt fusion: Firmware event implementation
using seperate WorkQueue"), and
schedule_work("struct mptsas_send_discovery_event"->work) has been
removed by commit f9c34022eae9 ("[SCSI] mpt fusion: SAS topology scan
changes, expander events").

There still remains schedule_work("struct work_queue_wrapper"->work) call
in mptspi.c and schedule_delayed_work("struct mpt_lan_priv"->work) call in
mptlan.c , but I guess that these are not work items which
commit 4d4109d0eb69 meant to wait for completion because these are not per
MPT_ADAPTER work items. If my guess is correct, we no longer need to call
flush_scheduled_work() from mptscsih_suspend().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/message/fusion/mptscsih.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 276084ed04a6..2bc17087d17d 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1231,7 +1231,6 @@ mptscsih_suspend(struct pci_dev *pdev, pm_message_t state)
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 
 	scsi_block_requests(ioc->sh);
-	flush_scheduled_work();
 	mptscsih_shutdown(pdev);
 	return mpt_suspend(pdev,state);
 }
-- 
2.18.4
