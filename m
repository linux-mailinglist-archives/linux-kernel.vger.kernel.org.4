Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278CD70D3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjEWG2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjEWG2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:28:15 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E4185
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:28:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230523062812epoutp01bebc71ced1d33a581c830c3486ab5e3b~hsduZgPsX2717327173epoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:28:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230523062812epoutp01bebc71ced1d33a581c830c3486ab5e3b~hsduZgPsX2717327173epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684823292;
        bh=w3jI9nVFjFtaZhjMo1fL28/6y8KVI4J1TL4/ZBRb5RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=CqGTIZCKY3kphi1a1vP303d6nre5wwft4XUVfR374W4gHAcIq78sx9RcJC+6I2Tuw
         pmOCXoBMcuEUr9Pzt6FsvhVK7xAvSgA/ZGpN48gRsZsCnxXYJ/r2g+dJ7BbR/fzPpi
         tJOuCVAMxJH13d1IhUcJ8WytGHqgpRzxQtu06Y1g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230523062811epcas2p243a58112066a5ed5be6622d1b7834f0c~hsdtrWopL3076330763epcas2p2J;
        Tue, 23 May 2023 06:28:11 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QQPWt61Vlz4x9Q1; Tue, 23 May
        2023 06:28:10 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.94.07392.AFC5C646; Tue, 23 May 2023 15:28:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230523062810epcas2p454b203a703524d0ce10577091f63d37d~hsdsnamVU2700227002epcas2p4U;
        Tue, 23 May 2023 06:28:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523062810epsmtrp2bceb0b6a3856d533250df767142c92bf~hsdsmcIAy1738517385epsmtrp2b;
        Tue, 23 May 2023 06:28:10 +0000 (GMT)
X-AuditID: b6c32a47-eedff70000001ce0-8b-646c5cfaf516
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.4F.28392.AFC5C646; Tue, 23 May 2023 15:28:10 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523062810epsmtip1d681ab19704a771b00380ebb61bc8738~hsdsYK6cL1521615216epsmtip1p;
        Tue, 23 May 2023 06:28:10 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1 3/3] ufs: poll pmc until another pa request is completed
Date:   Tue, 23 May 2023 15:19:10 +0900
Message-Id: <65681553332dda2700c9c2d5760c1b74934dfc70.1684822284.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684822284.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1684822284.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmqe6vmJwUg1Vz9C1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
        A3S8kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDA
        yBSoMCE7Y/Hj3+wFDw0rVrYtZ2lgvKnRxcjJISFgInF1/3nWLkYuDiGBHYwS/1d9YYZwPjFK
        HJx8jAnC+cwocb/zJitMy4Ezj6ASuxglJvXfZARJCAn8YJR4sVUVxGYT0JR4enMqE4gtInCD
        SeJJvyiIzSygLrFrwgmwuLCAt8Tiv+tYQGwWAVWJNxc2gy3gFYiWmD5hLRPEMjmJm+c6mUFs
        TgFLiQ2vmtlQ2VxANQs5JE6s28oI0eAisWnOLqhmYYlXx7ewQ9hSEp/f7QVq4ACysyX2LBSD
        CFdILJ72lgXCNpaY9aydEaSEGej+9bv0IaqVJY7cYoG4nk+i4/Bfdogwr0RHmxBEo7LEr0mT
        ofZLSsy8eQdqp4fEvy+n2SEh1cMosaF9G+MERvlZCAsWMDKuYhRLLSjOTU8tNiowhsddcn7u
        JkZwMtVy38E44+0HvUOMTByMhxglOJiVRHhPlGenCPGmJFZWpRblxxeV5qQWH2I0BQbjRGYp
        0eR8YDrPK4k3NLE0MDEzMzQ3MjUwVxLnlbY9mSwkkJ5YkpqdmlqQWgTTx8TBKdXAtNNLcbWG
        5M6N22sq5vy+JaCwwKSlX1L/1rET9UwbXAP2x79bae0cHdQbqdWZVeLxJ8Q+4bGJb/TTnV+b
        NN/GzOHYs6hYZaJ9V47kI9H4+Q3Lnx2s6/z7THr9rDZn+bfBe7edrZi33+/jyZcNG9bVi5q8
        6zjXfN3q2uvN8wVuLY56u/BhF+8LXuNTWzTPP/ZMk9gueE/rpXmJ5rcHeo63HE4vWyZc0Hf0
        w4teP589E6Pmejwu3ZvC2cT1e2rNtMwph/6+3sjrznBNpcvk7+LQRr8XpeH+nYtTA/3mvZ8w
        69xfrj17r02WSO68NUl62eVTs5NWZDfV1QUJKglX3p9k/WfH2omVu9Wc59c3dBosbFViKc5I
        NNRiLipOBAD31wqTLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO6vmJwUg//vhCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJWx+PFv9oKHhhUr25azNDDe1Ohi5OSQEDCROHDmEROILSSw
        g1Hi9nMliLikxImdzxkhbGGJ+y1HWLsYuYBqvjFK7Jr2iwUkwSagKfH05lQmkISIwCsmibn/
        T4F1MAuoS+yacAJsqrCAt8Tiv+vAGlgEVCXeXNjMCmLzCkRLTJ+wlglig5zEzXOdzCA2p4Cl
        xIZXzWxdjBxA2ywkGr/x4RCewCiwgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cDxoae1g3LPqg94hRiYOxkOMEhzMSiK8J8qzU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgOmVsankldGJfpPvpleHvxIsuiZ3muiDt7lUvejp8+8Xk
        z1unOv6t4Dd83ndwylf3j9EfdPnuMr/cf+XRH8mrNf8639sWc8cF23wzn17F5pRx5MTy0M2l
        /rOPOD1qV2fbbLR/+QyT+ysuSWQfWVBtoeyxZ8OvBZW+iQfvfFVkmfJnTpvR4g9zb0c+sdom
        bnCF/2zNzSLFbaUPVafuS316nPlI0j3vK+J20/aWLBTdcCvDLt386tLCKZ8+T7C2Xxz1fk0w
        QzV/UdSpKVdfzjnTLqyzX/1fIGPCbIFVUmFrwtZ55GbNmLnalP3e2ylyLPzGlxXyHJ5933br
        Z5BAT8WvJa2v1iSUy7557rrqWOWbWeFKLMUZiYZazEXFiQAAEJVa9gIAAA==
X-CMS-MailID: 20230523062810epcas2p454b203a703524d0ce10577091f63d37d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230523062810epcas2p454b203a703524d0ce10577091f63d37d
References: <cover.1684822284.git.kwmad.kim@samsung.com>
        <CGME20230523062810epcas2p454b203a703524d0ce10577091f63d37d@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3
1) check time in the loop with jiffies, instead of miliseconds.
2) change a variable's name and fix a typo and wrong alignment.

v1 -> v2
1) remove clearing hba->active_uic_cmd at the end of __ufshcd_poll_uic_pwr
2) change commit message on the cited clause: 5.7.12.11 -> 5.7.12.1.1
3) add mdelay to avoid too many issueing
4) change the timeout for the polling to 100ms because I found it
sometimes takes much longer than expected.

Regarding 5.7.12.1.1 in Unipro v1.8, PA rejects sebsequent
requests following the first request from upper layer or remote.
In this situation, PA responds w/ BUSY in cases
when they come from upper layer and does nothing for
the requests. So HCI doesn't receive ind, a.k.a. indicator
for its requests and an interrupt, IS.UPMS isn't generated.

When LINERESET occurs, the error handler issues PMC which is
recognized as a request for PA. If a host's PA gets or raises
LINERESET, and a request for PMC, this could be a concurrent
situation mentioned above. And I found that situation w/ my
environment.

[  222.929539]I[0:DefaultDispatch:20410] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecdl : 0x80000002
[  222.999009]I[0: arch_disk_io_1:20413] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecpa : 0x80000010
[  222.999200] [6:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufs_pwr_mode_restore_needed : mode = 0x15, pwr_rx = 1, pwr_tx = 1
[  223.002876]I[0: arch_disk_io_3:20422] exynos-ufs 13500000.ufs: ufshcd_update_uic_error: uecpa : 0x80000010
[  223.501050] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: pwr ctrl cmd 0x2 with mode 0x11 completion timeout
[  223.502305] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_change_power_mode: power mode change failed -110
[  223.502312] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_err_handler: Failed to restore power mode, err = -110
[  223.502392] [4:  kworker/u16:2:  132] exynos-ufs 13500000.ufs: ufshcd_is_pwr_mode_restore_needed : mode = 0x11, pwr_rx = 1, pwr_tx = 1

This patch is to poll PMC's result w/o checking its ind until
the result is not busy, i.e. 09h, to avoid the rejection.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 93 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a772f92..3cf2fbe 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -98,6 +98,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Polling time to wait until PA is ready */
+#define UIC_PA_RDY_TIMEOUT	100	/* millisecs */
+
 /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
 static bool use_mcq_mode = true;
 
@@ -4146,6 +4149,62 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 }
 EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
 
+static int __ufshcd_poll_uic_pwr(struct ufs_hba *hba, struct uic_command *cmd,
+		struct completion *cnf)
+{
+	unsigned long flags;
+	int ret;
+	u32 mode = cmd->argument3;
+	unsigned long deadline = jiffies +
+		msecs_to_jiffies(UIC_PA_RDY_TIMEOUT);
+
+	do {
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		hba->active_uic_cmd = NULL;
+		if (ufshcd_is_link_broken(hba)) {
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
+			ret = -ENOLINK;
+			goto out;
+		}
+		hba->uic_async_done = cnf;
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+		cmd->argument2 = 0;
+		cmd->argument3 = mode;
+		ret = __ufshcd_send_uic_cmd(hba, cmd, true);
+		if (ret) {
+			dev_err(hba->dev,
+				"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
+				cmd->command, cmd->argument3, ret);
+			goto out;
+		}
+
+		/* This value is heuristic */
+		if (!wait_for_completion_timeout(&cmd->done,
+						 msecs_to_jiffies(5))) {
+			ret = -ETIMEDOUT;
+			dev_err(hba->dev,
+				"pwr ctrl cmd 0x%x with mode 0x%x timeout\n",
+				cmd->command, cmd->argument3);
+			if (cmd->cmd_active)
+				goto out;
+
+			dev_info(hba->dev, "%s: pwr ctrl cmd has already been completed\n", __func__);
+		}
+
+		/* retry only for busy cases */
+		ret = cmd->argument2 & MASK_UIC_COMMAND_RESULT;
+		if (ret != UIC_CMD_RESULT_BUSY)
+			break;
+
+		dev_info(hba->dev, "%s: PA is busy and can't handle a requeest, %d\n", __func__, ret);
+		mdelay(1);
+
+	} while (time_before(jiffies, deadline));
+out:
+	return ret;
+}
+
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -4168,33 +4227,13 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	unsigned long flags;
 	u8 status;
 	int ret;
-	bool reenable_intr = false;
 
-	mutex_lock(&hba->uic_cmd_mutex);
-	ufshcd_add_delay_before_dme_cmd(hba);
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (ufshcd_is_link_broken(hba)) {
-		ret = -ENOLINK;
-		goto out_unlock;
-	}
-	hba->uic_async_done = &uic_async_done;
-	if (ufshcd_readl(hba, REG_INTERRUPT_ENABLE) & UIC_COMMAND_COMPL) {
-		ufshcd_disable_intr(hba, UIC_COMMAND_COMPL);
-		/*
-		 * Make sure UIC command completion interrupt is disabled before
-		 * issuing UIC command.
-		 */
-		wmb();
-		reenable_intr = true;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
+	ret = __ufshcd_poll_uic_pwr(hba, cmd, &uic_async_done);
 	if (ret) {
-		dev_err(hba->dev,
-			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-			cmd->command, cmd->argument3, ret);
-		goto out;
+		if (ret == -ENOLINK)
+			goto out_unlock;
+		else
+			goto out;
 	}
 
 	if (!wait_for_completion_timeout(hba->uic_async_done,
@@ -4231,14 +4270,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->active_uic_cmd = NULL;
 	hba->uic_async_done = NULL;
-	if (reenable_intr)
-		ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
 	if (ret) {
 		ufshcd_set_link_broken(hba);
 		ufshcd_schedule_eh_work(hba);
 	}
-out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+out_unlock:
 	mutex_unlock(&hba->uic_cmd_mutex);
 
 	return ret;
-- 
2.7.4

