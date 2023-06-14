Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F472F3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbjFNE64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFNE6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:58:51 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C3135
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:58:47 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230614045843epoutp0481b5a2121732883c784e457cbc47c373~obb4TqOD50959209592epoutp04u
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230614045843epoutp0481b5a2121732883c784e457cbc47c373~obb4TqOD50959209592epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686718723;
        bh=OCbooCOCoON9qKh/petA99mWecUAvrQA0xN3SqT4+Vg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MqTAKLkTrfAuChjOKaZcNsA3joasTkyoZ3mLF1w+m/jmtyq72hTEStoe8OGK6vP/1
         hp57eCuVtMsT9fb9LCfvKeuC3iEqoWmbsMRJ5n2DTqFIytUKQQOZM4OiQmJPb+WYtQ
         Stf88q2sN6EvO07VoXi8HzkLWm0Z5rW1oUVlL6os=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230614045842epcas2p129cf3d12daf8e30d4aaa9e3dd65da624~obb3tIldY1512415124epcas2p1g;
        Wed, 14 Jun 2023 04:58:42 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QgtVV1DwRz4x9Px; Wed, 14 Jun
        2023 04:58:42 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.7A.11450.20949846; Wed, 14 Jun 2023 13:58:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230614045841epcas2p32c488c50ca94b492023d00023189338a~obb2oRqM61309713097epcas2p3W;
        Wed, 14 Jun 2023 04:58:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230614045841epsmtrp2607d90310646f066a96d8924b8175bd2~obb2ncaFV2412224122epsmtrp27;
        Wed, 14 Jun 2023 04:58:41 +0000 (GMT)
X-AuditID: b6c32a45-445fd70000022cba-c3-64894902a9d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.F2.27706.10949846; Wed, 14 Jun 2023 13:58:41 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230614045841epsmtip2e5d9736b00a72d33f61da1cb7ac172fe~obb2WA_oF0826608266epsmtip2g;
        Wed, 14 Jun 2023 04:58:41 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v4] ufs: poll pmc until another pa request is completed
Date:   Wed, 14 Jun 2023 13:49:18 +0900
Message-Id: <1686718158-154271-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVJfJszPF4MBXNouTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csFpsvfWNxEPC4fMXbY/Gel0weExYdYPT4vr6DzePj01ssHn1bVjF6
        fN4k59F+oJspgCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGxP+NTAUfjCuuPF7E1sB4QquLkYNDQsBE4vrj0i5GLg4hgR2MErNeL2KG
        cD4xSmy9shvI4QRyvjFKvD7PCGKDNHx4/ZcFomgvo0TPlA5GCOcHo8SDtXvAqtgENCWe3pzK
        BJIQEfjAJPF/+TawBLOAusSuCSeYQGxhAXeJ7Qvug61gEVCVOHRmKwuIzSvgJrG/9RHUOjmJ
        m+c6wW6SEGjlkNg1Zx1UwkVix6lGJghbWOLV8S3sELaUxOd3e9kgnsuW2LNQDCJcIbF42lsW
        CNtYYtazdkaQEmagQ9fv0oeoVpY4cosF4ko+iY7Df9khwrwSHW1CEI3KEr8mTYbaLykx8+Yd
        qJ0eEtvv/YGGVazE9RVd7BMYZWchzF/AyLiKUSy1oDg3PbXYqMAQHkXJ+bmbGMFJUst1B+Pk
        tx/0DjEycTAeYpTgYFYS4X2q0Z4ixJuSWFmVWpQfX1Sak1p8iNEUGFoTmaVEk/OBaTqvJN7Q
        xNLAxMzM0NzI1MBcSZxX2vZkspBAemJJanZqakFqEUwfEwenVAPTCkn7id0Hbyt47OszmVXZ
        Uax3zkzv7TQZljn/JmcYeUm131Pp0I9aydLI7Xdbf+LFAyL6OU6G1guspn3x9P+r1zO93GSn
        //NdbS8Z+Y9ycR798mxb2QE/p6YlxukaLbEz1lXP75t+ytA431ta/KnAd8UZtTsv+B4+IeYW
        0KZ2JJktdS4HR5fBudJdGXYzl+z8/PlYbM1F5mk7uZfeSqqdrLIm4paM0Z0H/35NfnBZiXVd
        zuNd5s/7Zj17tE4rzSi2vD0/7fv0puXM9/RfREfLrtjDXtUoFnL805JTd5eWib0MXaEXGVNZ
        2r/AUnhCyjJNt1cC3NaWhuvaGJLaLFv0zU7q/zyq6zC38aqb30olluKMREMt5qLiRAA4OPoM
        GwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvC6jZ2eKwauFahYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XqxQ9YLBbd2MZksetvM5PF1hs7WSxubjnKYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZLDZf+sbiIOBx+Yq3x+I9L5k8Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0
        +LxJzqP9QDdTAEcUl01Kak5mWWqRvl0CV8bE/41MBR+MK648XsTWwHhCq4uRk0NCwETiw+u/
        LF2MXBxCArsZJT4+mMUCkZCUOLHzOSOELSxxv+UIK0TRN0aJRasWsYMk2AQ0JZ7enMoEkhAR
        aGKWuDR7Olg3s4C6xK4JJ5hAbGEBd4ntC+4zg9gsAqoSh85sBavhFXCT2N/6CGqDnMTNc53M
        Exh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5fLc0djNtXfdA7xMjEwXiI
        UYKDWUmE96lGe4oQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwc
        nFINTMdvXpAsutgm6yNaoplocPn6+Vtb3Sf9mHH6TKf5196mupXTE1/mFOmus2u5uvx3/3nt
        FresiEecLgftM7bkJl8z8MjMdIuVe9tbpcSfdyWr93i7Q4y/fbaQVWhqsmYT4xHuV9UC5nLn
        /pSb9321Wy/S9fme8cV5Vct+z4tfJsk+3de2bbOtRlbX/QUBfumH++sWKOyNeLZo9uolzzWX
        MYjKcR1IYXOf1Xh8Xa3O6W5Fqdo0IeYvxhvs5vho/VWKV1j40oMrpcB5/coVzEt0o+66Vdt3
        Hf2zoTWfTf/suWO/ebRluvc5/JSWDZnYf8Gj+b7ptUzOPb8qvOqLdxaZ1LWeX75DbJnZjM1q
        njuVWIozEg21mIuKEwG5u7c2zgIAAA==
X-CMS-MailID: 20230614045841epcas2p32c488c50ca94b492023d00023189338a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614045841epcas2p32c488c50ca94b492023d00023189338a
References: <CGME20230614045841epcas2p32c488c50ca94b492023d00023189338a@epcas2p3.samsung.com>
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

And this patch requires the following patch because it assumes
__ufshcd_send_uic_cmd doesn't require host_lock.
https://lore.kernel.org/linux-scsi/bec84ee1ce8f5c5971b98d8e501aeabb9b5b26d1.1686716811.git.kwmad.kim@samsung.com/

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>

---
v3 -> v4
1) change description

v2 -> v3
1) check time in the loop with jiffies, instead of miliseconds.
2) change a variable's name and fix a typo and wrong alignment.

v1 -> v2
1) remove clearing hba->active_uic_cmd at the end of __ufshcd_poll_uic_pwr
2) change commit message on the cited clause: 5.7.12.11 -> 5.7.12.1.1
3) add mdelay to avoid too many issueing
4) change the timeout for the polling to 100ms because I found it
sometimes takes much longer than expected.
---
 drivers/ufs/core/ufshcd.c | 93 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 10ccc85..9a0f781 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -99,6 +99,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Polling time to wait until PA is ready */
+#define UIC_PA_RDY_TIMEOUT	100	/* millisecs */
+
 /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
 static bool use_mcq_mode = true;
 
@@ -4139,6 +4142,62 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
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
@@ -4161,33 +4220,13 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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
@@ -4224,14 +4263,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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

