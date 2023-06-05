Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3A721B75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFEBZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjFEBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:25:15 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37FE9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:25:12 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605012510epoutp042e2f2688788d9161a15f729a0cb4dbf6~lnt3DB8jj1577615776epoutp04T
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605012510epoutp042e2f2688788d9161a15f729a0cb4dbf6~lnt3DB8jj1577615776epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685928310;
        bh=uB0axnIB7n3lHdidCRVklE/hsOCcBdNuiaEUV7BL5mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=NX7aBh593A8vwFSVFYbfAJiE9gVswiUQUNjP/BhR3WnlqoupBVOAcn6aRtyl0e+bi
         fvqylOmGa0KavQfZr1f/OOsiV8hquZ6E/xSlpCgacoxNaTkaRpv9j0RpXO86p9QL+Q
         0hzDkNA4IsNN7KzDV9PcUGIWRiCg8Ab0oaY/+AV4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230605012510epcas2p442821da981822592b07d89c28f344b86~lnt2WYYKb1275112751epcas2p4U;
        Mon,  5 Jun 2023 01:25:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QZGBF2396z4x9Ps; Mon,  5 Jun
        2023 01:25:09 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.D8.07392.5793D746; Mon,  5 Jun 2023 10:25:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230605012508epcas2p140e42906361b870e20b1e734e9e4df06~lnt1BoySC2538425384epcas2p1M;
        Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605012508epsmtrp17154e47f9e50a7e341f678726eb1d7ce~lnt1AakJk2751527515epsmtrp1A;
        Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
X-AuditID: b6c32a47-157fd70000001ce0-68-647d39757a0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.7F.27706.4793D746; Mon,  5 Jun 2023 10:25:08 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605012508epsmtip20b921ed74dadf808d7f59d1bfc4cbe53~lnt0xXe2l3118531185epsmtip2T;
        Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 3/3] ufs: poll pmc until another pa request is completed
Date:   Mon,  5 Jun 2023 10:15:54 +0900
Message-Id: <67ce698df39ca0c277c078dca729d7f607b9feb2.1685927620.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhW6pZW2Kwe5pXBYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XqxQ9YLBbd2MZksetvM5PF1hs7WSxubjnKYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        ATpeSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCdseffAsaCh4YV2/susjcw3tToYuTkkBAwkXi+r5mti5GLQ0hgB6PEmy//2UASQgKf
        GCXmH4qESHxjlNjd3szcxcgB1nFsRjREfC+jxK22B6wQzg9GiZZlX5hAutkENCWe3pwKZosI
        3GCSeNIvCmIzC6hL7JpwAiwuLOAt8erHE7BtLAKqEt+Wv2cEsXkFoiXez5rBCnGenMTNc53M
        IDangKXE2bd/2FHZXEA1czkkPpz+zQLR4CLx9t07NghbWOLV8S3sELaUxMv+NnaID7Il9iwU
        gwhXSCye9haq1Vhi1rN2RpASZqD71+/Sh6hWljhyiwXiej6JjsN/oYbwSnS0CUE0Kkv8mjSZ
        EcKWlJh58w7UTg+JS+/mMUNCp4dR4sb2s0wTGOVnISxYwMi4ilEstaA4Nz212KjAGB51yfm5
        mxjBqVTLfQfjjLcf9A4xMnEwHmKU4GBWEuHd5VWdIsSbklhZlVqUH19UmpNafIjRFBiME5ml
        RJPzgck8ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampBahFMHxMHp1QDU3Rg6PLq
        PFMhg/Pf01Y+WCsSOCOwUivXUVtMjf/ckUpdq+Ui0gmSRsE/vi0VznApv+7hZ8JwvulUVZK8
        k2Cm6TutLe0luUcjAwQ+717d++FzOJN9jVzo7LfPb7sc47u6WYojmHn/9TkSM5INGGcxL7v+
        Ieaojkv7Fce2B73PVu1ILAzb0T7l0fN1jxbKbztrnczUJ//su9rZ/N+iUXv316x9GcR7oeez
        zt6zN6LXBSd4BX9fv2Hdc5aNwjJqW9cwpsT8U9uue1P9hFNDYMSO0xyXTjbw3mI9dGPK6027
        dznlOmvtNnVeGyy4oOBDUtd6r1lyk1quC8Ws2/Lph4/l+YLuLf8LrJb4NSxz0C4zV2Ipzkg0
        1GIuKk4EAEQJSmkuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG6JZW2KwasmJYuTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csDvwel694eyze85LJY8KiA4we39d3sHl8fHqLxaNvyypGj8+b5Dza
        D3QzBXBEcdmkpOZklqUW6dslcGXs+beAseChYcX2vovsDYw3NboYOTgkBEwkjs2I7mLk4hAS
        2M0oMfHKFbYuRk6guKTEiZ3PGSFsYYn7LUdYIYq+MUp86lzEBJJgE9CUeHpzKhNIQkTgFZPE
        3P+nwDqYBdQldk04AVYkLOAt8erHE7CpLAKqEt+Wvwer4RWIlng/awYrxAY5iZvnOplBbE4B
        S4mzb/+wg1wnJGAh0bjfGIfwBEaBBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        guNBS3MH4/ZVH/QOMTJxMB5ilOBgVhLh3eVVnSLEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDU73bm4WrtCac62RS23Uj1e9yimZOZ93//YoRz2Z9PPjJ
        YcOSmfxKZppPVrG33pVxs9/3lvnfcmfnGofp6V/j7R96vBEMf7ZMaaMdH/cxd8vzD00XF1/8
        1XHH4va5TNvE5br2a1+stRDm/RG1L2qJouaJXSZtObFdRrnTZOrvrSxIbA3yn7bicfm7RpuX
        Xyt4fkczzGSdKOGoG5nOseo9j1le10mJ+VevK1nwJEZ8XzXNUoDBv+ewpbZBaV2h30+TYFGB
        tFurEl2itJJ+Kl9j8M721s6anOjXqZ5utdtQWXyGRlrp/M2nE/ha07SPRVmG2J9Wufq/LqFx
        5evupZvUGL59bjqYI+yW5dco563EUpyRaKjFXFScCAChSBrs9gIAAA==
X-CMS-MailID: 20230605012508epcas2p140e42906361b870e20b1e734e9e4df06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605012508epcas2p140e42906361b870e20b1e734e9e4df06
References: <cover.1685927620.git.kwmad.kim@samsung.com>
        <CGME20230605012508epcas2p140e42906361b870e20b1e734e9e4df06@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 1f58a20..9480233 100644
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
 
@@ -4145,6 +4148,62 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
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
@@ -4167,33 +4226,13 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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
@@ -4230,14 +4269,12 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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

