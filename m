Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF30704434
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjEPEBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEPEBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:01:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A073430F3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 21:01:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230516040119epoutp039dec83acfbf9907b78fc962a996efe51~fg8fCwQva1511715117epoutp032
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:01:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230516040119epoutp039dec83acfbf9907b78fc962a996efe51~fg8fCwQva1511715117epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684209679;
        bh=41PEes32p8FwGExYNj2+6P7XqlOV/tTVTud/1oZSrqQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=luEpNzeGjxZBc3lvNgW/qgzR9/Ej0ULUUCvD3LxLOpCILDcmP3+ov5HG9TT4fLbXV
         p40PnHO0wpalUsJt0mFariETzGx/aqn/8nCqmPjATyqUq0GvS90tgGM+e+fI9AHELG
         c5oxpnIJ2FI0j6ZQPipXCe31i99XqZdGs9I8anXo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230516040119epcas2p33343c3003c4838d477d04ac720d482e8~fg8ecL2Z70349303493epcas2p3T;
        Tue, 16 May 2023 04:01:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QL2bf0q5mz4x9Pv; Tue, 16 May
        2023 04:01:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.A7.03265.D0003646; Tue, 16 May 2023 13:01:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230516040117epcas2p4477bbc8aedf05a8c3bc0bd755eeadba0~fg8dJOzj30805708057epcas2p47;
        Tue, 16 May 2023 04:01:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516040117epsmtrp1a93059137bd743aaa3631d89e1ac2cf8~fg8dIApQ10383803838epsmtrp1b;
        Tue, 16 May 2023 04:01:17 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-25-6463000d5825
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.BE.28392.D0003646; Tue, 16 May 2023 13:01:17 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516040117epsmtip1b0e1089cc06cc97bb1fbfeee3668a31d~fg8c37GoS1749617496epsmtip1H;
        Tue, 16 May 2023 04:01:17 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3] ufs: poll pmc until another pa request is completed
Date:   Tue, 16 May 2023 12:52:32 +0900
Message-Id: <1684209152-115304-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTJePITnF4Ggrs8XJJ2vYLB7M28Zm
        8fLnVTaLgw87WSymffjJbLF68QMWi0U3tjFZ7PrbzGSx9cZOFoubW46yWFzeNYfNovv6DjaL
        5cf/MVl03b3BaLH031sWB36Py1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWjx+dNch7t
        B7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gI5XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgY
        mQIVJmRn3N4yn63gnmHFzn+tLA2MVzW6GDk4JARMJH7c1exi5OIQEtjBKDG/4xULhPOJUWLf
        zydQzmdGiWtzOpm6GDnBOlbPmc4EkdjFKLGzfw4bhPODUWL70tNgVWwCmhJPb04Fs0UEbjBJ
        POkXBbGZBdQldk04wQSyW1jAXeLBZx2QMIuAqkT3izeMIDavgJvE2c5vjBDL5CRunutkhrAb
        OSR+vcyEsF0krl1ayw5hC0u8Or4FypaSeNnfxg7xWrbEnoViEOEKicXT3rJA2MYSs561M4KU
        MANduX6XPkS1ssSRWywQN/JJdBz+CzWEV6KjTQiiUVni16TJUHdJSsy8eQdqp4fEso4OVhBb
        SCBWouvoCvYJjLKzEOYvYGRcxSiWWlCcm55abFRgCI+g5PzcTYzgtKjluoNx8tsPeocYmTgY
        DzFKcDArifC2z4xPEeJNSaysSi3Kjy8qzUktPsRoCgysicxSosn5wMScVxJvaGJpYGJmZmhu
        ZGpgriTOK217MllIID2xJDU7NbUgtQimj4mDU6qBKUD24TRfccOnh6tOFp0uVWq4/6h82af/
        xy83emhI1mhrOZ8svrOluTP71FUD7fLJ4R7Vmyx3T2hwtOzZGRts/TZg6dS84l1HGDemze8S
        sY/Yy6C90ks/clZC0bpzgUrbmV/rpUpeEnJbd+dPvoq9BEs89w+jIBM+eUEeRvb1obM/x7Be
        YZCadk7nq7D3Zo3zKhPOlF2vPHGKXfdnvrTMWZW7ab7h8ULbPhyc0DE1yKxAluPOxLYc+WWe
        pYnex14rhV5Yyrxh7ZsXMzbsni99YPbJhlNhHpPEN3TnJi7o3548mUfL7OnhnC/mWrZqE77u
        PP9hz8XX+jJTlVSye8T0St+IZfbNUS2I/Xy0uTJMiaU4I9FQi7moOBEA2lTFRBQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnC4vQ3KKwcSj0hYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XqxQ9YLBbd2MZksetvM5PF1hs7WSxubjnKYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCI4rJJSc3JLEst0rdL4Mq4vWU+W8E9w4qd/1pZGhivanQxcnJICJhIrJ4znamLkYtD
        SGAHo8SHFVuYIBKSEid2PmeEsIUl7rccYYUo+sYosX/mHLAEm4CmxNObU8G6RQReMUnM/X8K
        LMEsoC6xa8IJoAQHh7CAu8SDzzogYRYBVYnuF2/ASngF3CTOdn6DWiAncfNcJ/MERp4FjAyr
        GCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCQ1ZLawfjnlUf9A4xMnEwHmKU4GBWEuFt
        nxmfIsSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTzfcF
        G2SbAtdcWe+/9EnZyb0NJ2UmX84SMnV4s15zwjILju9B4qe/+u6wvcHzIE5fqu06k83GN9cD
        Shyy52gJpq4ofehZdfDRKw+5pTOLSif3umQ+P9DjZ19Zqt7ZHZ0gpHP1+Vnjy4xWl59/2vh1
        xacJC17V7T996cnay41X6ji6r3dOflYm+OBUYkmk1QuHTZ+9Ql/Ihv/wWhY+Zevh92bnlise
        Xs2SxLXJb8vtez49+afO9aotKDlQIXR1jo6S7DOrxQVrYjYvKO+urHsgJ/zfjuvGzjMbjnyd
        lPm83yvghayblfBcl307KqtmlvBNLmd/Kp3XN/vnqz//3+f/fWpyZT/b4sbe10/Ev58+tF2J
        pTgj0VCLuag4EQDPprzXyAIAAA==
X-CMS-MailID: 20230516040117epcas2p4477bbc8aedf05a8c3bc0bd755eeadba0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230516040117epcas2p4477bbc8aedf05a8c3bc0bd755eeadba0
References: <CGME20230516040117epcas2p4477bbc8aedf05a8c3bc0bd755eeadba0@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufshcd.c | 89 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..2359367 100644
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
 
@@ -4138,6 +4141,61 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
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
+		cmd->argument2 = 0;
+		cmd->argument3 = mode;
+		ret = __ufshcd_send_uic_cmd(hba, cmd, true);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
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
@@ -4160,33 +4218,16 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	unsigned long flags;
 	u8 status;
 	int ret;
-	bool reenable_intr = false;
 
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
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
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
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
@@ -4223,14 +4264,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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

