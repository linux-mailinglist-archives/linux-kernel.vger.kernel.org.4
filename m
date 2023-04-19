Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D36E73FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjDSH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjDSH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:28:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235765FDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:27:51 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230419072747epoutp02851639227db17b148239161599c6d5ba~XRWCsvkm22005320053epoutp02T
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:27:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230419072747epoutp02851639227db17b148239161599c6d5ba~XRWCsvkm22005320053epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681889267;
        bh=cYZEsz5d+K8VWp4jrREfx47yVwh4hAAGfFBIuF7iU9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Whc62kGiTVE/w35VO3YHUHipDlS7/2nevbbSIXLg3FP/EGlGXIaFMWBhr04WZTK/N
         lFEI9+8zMhjtmE3Q9LfpnKd9YMXYwf8gubj1T8zaWn2WlFdLuN0eguKoOizpEFHxmP
         odQ19Ubvh42RiATD7ZGTqyTNpfM9VtJhR0479Z9Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419072746epcas2p273e27039e5015c6a8f7b45c57b17cd6b~XRWCKojL41716517165epcas2p2x;
        Wed, 19 Apr 2023 07:27:46 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1XSL1mK0z4x9QG; Wed, 19 Apr
        2023 07:27:46 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.24.10686.2F79F346; Wed, 19 Apr 2023 16:27:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419072745epcas2p47b29940fe7e50d947a29546a8e79abb9~XRWBC_UZV0803208032epcas2p4v;
        Wed, 19 Apr 2023 07:27:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419072745epsmtrp2bd3917b0212ee835240ae7a2c75fe91d~XRWA9WYuq0414604146epsmtrp2W;
        Wed, 19 Apr 2023 07:27:45 +0000 (GMT)
X-AuditID: b6c32a46-ed1f8700000029be-1d-643f97f2a2f9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.39.08609.1F79F346; Wed, 19 Apr 2023 16:27:45 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419072745epsmtip19f143d5480c8ccdb0d379064040b3b0b~XRWAtWdzy2103721037epsmtip1b;
        Wed, 19 Apr 2023 07:27:45 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        kwangwon.min@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RFC PATCH v1] ufs: poll pmc until another pa request is completed
Date:   Wed, 19 Apr 2023 16:19:29 +0900
Message-Id: <1681888769-36587-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cpgsproxy5@samsung.com; stanley.chu@mediatek.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTVPfTdPsUgwV/uCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3JYuuNnSwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LA58Hov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MAexR2TYZ
        qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
        hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iznt35
        yVTQp1/RveImWwPjDbUuRg4OCQETiUeHqroYuTiEBHYwSrQu3cIE4XxilLh4+gU7hPOZUeLP
        pRPMXYycYB3LLnxhgUjsYpToft0O5fxglLhx+yYLSBWbgKbE05tTwWaJCBxmkrh1o5cRJMEs
        oC6xa8IJJhBbWMBbouP+FjYQm0VAVaL70TU2kKN4BVwl9jyTh9gmJ3HzXCfYZk4Be4mPb6Yw
        g8yUEOjlkLh5Zg8LRJGLxMOJm6DOE5Z4dXwLO4QtJfH53V42iEezJfYsFIMIV0gsnvYWqtVY
        YtazdkaQEmagm9fv0oeoVpY4cosF4mA+iY7Df9khwrwSHW1CEI3KEr8mTWaEsCUlZt68A7XT
        Q+LOvDfMkBCZxCjxtP0A0wRGuVkICxYwMq5iFEstKM5NTy02KjCCx1dyfu4mRnCK1HLbwTjl
        7Qe9Q4xMHIyHGCU4mJVEeM+4WqUI8aYkVlalFuXHF5XmpBYfYjQFhtxEZinR5Hxgks4riTc0
        sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cBU0JB3r0FOKedp23v3/rT9
        X/c/StB912d6u03vjNZdo2kf5leKLTc75eC3cs695TeX8l/vDlyTwG9yNu9t/rPZK7NsUjwz
        4npdgyTf2nzh8pi8ct5czj6Rr39rfs2avP28lp57zizWCD7XND12t06uvq9sIUeC847pbVrK
        HWA/wWCDjvDMuf2tGbYp8mpzZ87XYfWawFjzYK1zgKh1p/xbfh+P+PoEFttDkjIt9haKlw4F
        OTn+Oqbb5zdLOm5XLpPgCyvNzO9P+qp6bDZVXFi+QC6T7YFzUH60b+eGe4eqVpS5puzNCt2c
        VJby2LV4adgk//uRW7eHXZqRzblnk+2C4+XcfC/l2rhKLmtdVmIpzkg01GIuKk4EADymFYUa
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnO7H6fYpBsc6xS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWLxdekzVovVix+wWCy6sY3JYuuNnSwWN7ccZbG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LA58Hov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MAexRXDYp
        qTmZZalF+nYJXBnP7vxkKujTr+hecZOtgfGGWhcjJ4eEgInEsgtfWEBsIYEdjBIPL7tCxCUl
        Tux8zghhC0vcbznC2sXIBVTzjVFi68ObYA1sApoST29OZQKxRQQuM0k0H5cCsZkF1CV2TTgB
        FhcW8JbouL+FDcRmEVCV6H50Dcjm4OAVcJXY80weYr6cxM1zncwgNqeAvcTHN1OYIe6xk3g8
        sY9tAiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwcGspbWDcc+qD3qHGJk4
        GA8xSnAwK4nwnnG1ShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFM
        lomDU6qBia9xx7mJ7//OOLomXNVq+5ewgI+Sv9pzzf9qXzzzc8eMiaJdx4JOv/V1+dlx6wF/
        FKPQ5q9cW7dcST6yYXJDxkeh2dymni2HRfWvG/Ml6D4Sl5wmP3v5Yb/VRrwrOsqFv3EEKNzX
        EZ0eLC1tkFBp8XPpx8gTDc+KPl0/ePH2PosbDxNF08uF6iWZfdS/Bp77+n2GVOTNBTo7+g5M
        Z3/y+5DUlt2y8Vq38/NVdt6+c1i8nOk5I69q1PeM0Cr3oM3cK2aeKblx6rThhcRFd2Nurr0b
        Ub2X7Y4yb9U56fJlbU6LLMPuSvY388uLfH3g8uVHzdXetX+mxhg9O3M2IVXprNGFqRf0H6ue
        Uz0fznZ6O4MSS3FGoqEWc1FxIgAVqxzi1QIAAA==
X-CMS-MailID: 20230419072745epcas2p47b29940fe7e50d947a29546a8e79abb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419072745epcas2p47b29940fe7e50d947a29546a8e79abb9
References: <cpgsproxy5@samsung.com; stanley.chu@mediatek.com>
        <CGME20230419072745epcas2p47b29940fe7e50d947a29546a8e79abb9@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding 5.7.12.11 in Unipro v1.8, PA rejects sebsequent
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
 drivers/ufs/core/ufshcd.c | 92 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..3fa58d9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -98,6 +98,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Polling time to wait until PA is ready */
+#define UIC_PA_RDY_TIMEOUT	30	/* millisecs */
+
 /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
 static bool use_mcq_mode = true;
 
@@ -4138,6 +4141,64 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 }
 EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
 
+static int __ufshcd_poll_uic_pwr(struct ufs_hba *hba, struct uic_command *cmd,
+		struct completion *cnf)
+{
+	unsigned long flags;
+	int ret;
+	ktime_t timeout;
+	u32 mode = cmd->argument3;
+
+	timeout = ktime_add_ms(ktime_get(), UIC_PA_RDY_TIMEOUT);
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
+		    msecs_to_jiffies(5))) {
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
+		/* retry for only busy cases */
+		ret = cmd->argument2 & MASK_UIC_COMMAND_RESULT;
+		if (ret != UIC_CMD_RESULT_BUSY)
+			break;
+
+		dev_info(hba->dev, "%s: PA is busy and can't handle a requeest\n", __func__);
+
+	} while (ktime_before(ktime_get(), timeout));
+out:
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	hba->active_uic_cmd = NULL;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	return ret;
+}
+
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -4160,33 +4221,16 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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
@@ -4223,14 +4267,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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

