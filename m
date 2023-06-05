Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA9721B73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjFEBZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjFEBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:25:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87322DC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:25:11 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230605012508epoutp039d2b1e8a4e1267bb05a5d3d076e9b259~lnt02bIhk0767707677epoutp033
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230605012508epoutp039d2b1e8a4e1267bb05a5d3d076e9b259~lnt02bIhk0767707677epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685928308;
        bh=cPIoG11yRXiM53MIIBG0bJ0Edj4f+Eu2BRjcUX/fuvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=g4o5mkI3LqRolr5oFpbKKdjtMqapzQXwRqVog9azONu//R2i8TYcwrNl3gE1b2ZgH
         5nEZRdrsPV839D1LisE3IdyQ5xvGYC+Dd/JSIk3fiyQ18P7Q9xynbxcAySLYAFlbNg
         hUuvJkUMa42MGCae1pgTGdiJA2adGAJX8RjRjPj0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230605012508epcas2p4d9c48d56f279c76ad5e1550ec3672d4d~lnt0csqPM1256912569epcas2p4X;
        Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QZGBC1jmBz4x9Q0; Mon,  5 Jun
        2023 01:25:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.34.11450.3793D746; Mon,  5 Jun 2023 10:25:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605012506epcas2p2c487b751827e3a39c74fdbd88dbd1311~lntzQRNua2372223722epcas2p2p;
        Mon,  5 Jun 2023 01:25:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605012506epsmtrp1286b0c50d1d10415d1d928cd80c92f8a~lntzPWGDb2747127471epsmtrp1H;
        Mon,  5 Jun 2023 01:25:06 +0000 (GMT)
X-AuditID: b6c32a45-445fd70000022cba-e3-647d3973764c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.7F.27706.2793D746; Mon,  5 Jun 2023 10:25:06 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605012506epsmtip2a07425b49a4844b9523da333d123f214~lntzCh63P2416324163epsmtip28;
        Mon,  5 Jun 2023 01:25:06 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 1/3] ufs: make __ufshcd_send_uic_cmd not wrapped by
 host_lock
Date:   Mon,  5 Jun 2023 10:15:52 +0900
Message-Id: <002dcd4e99b2e03dcd698493f1f1adbb0375bf5c.1685927620.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmqW6xZW2Kwd2PHBYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XqxQ9YLBbd2MZksetvM5PF1hs7WSxubjnKYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        ATpeSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCd8eLvfvaCA3wVX2+/YG9gnMrTxcjBISFgInHqsGgXIxeHkMAORonzFzYzQTifGCWe
        LTzGDOF8Y5To6dvN2MXICdbxY20/I0RiL6PEok0LoFp+MEqsXnOfFaSKTUBT4unNqUwgtojA
        DSaJJ/2iIDazgLrErgknwOLCAkEST1Y+YQaxWQRUJS7+2ga2gVcgWqLh2gFmiG1yEjfPdYLZ
        nAKWEmff/mFHZXMB1czlkFjx8xDUeS4SD7bvh2oWlnh1fAs7hC0l8bK/jR3i6WyJPQvFIMIV
        EounvWWBsI0lZj1rZwQpYQa6f/0ufYhqZYkjt1ggrueT6Dj8F2oIr0RHmxBEo7LEr0mTofZL
        Ssy8eQeqxEPi67I4SOD0MEpcfvKGdQKj/CyE+QsYGVcxiqUWFOempxYbFRjCoy45P3cTIziV
        arnuYJz89oPeIUYmDsZDjBIczEoivLu8qlOEeFMSK6tSi/Lji0pzUosPMZoCQ3Eis5Rocj4w
        meeVxBuaWBqYmJkZmhuZGpgrifNK255MFhJITyxJzU5NLUgtgulj4uCUamCa5LlBPuH9boUK
        zau2noLiq+78EnB4+e5UX5p8s64PQ+Kz2p+zT2bYHvDZEbiLZWNsW8FeQ09/qdIonX6uNsZH
        YeZHP6x026r0pGB7ZKuATsCvyWs+btE4Zdv+JXzFliNX2XTWs8h2t500vN27he/2znV6oh3p
        p6T397UEvUlSKzJ0Tck7ccTJIDXC8luTgLLXjKALv4IFdap/aumvl9mkeSisc3G08A4Ti4zD
        1zRfv70XmqOScJ07b/e7zH+T4lmOPljh/0q6UN/nWH1p7o8quYm+brbmST8WKdVHW/zWkWTN
        DTeeoFfeZisZ5OMgY/Lr75SQs53fq94qi17ZeEh6qRzj3GbXc++V2l9HKbEUZyQaajEXFScC
        ALo8SZUuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG6RZW2KwZxX6hYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XqxQ9YLBbd2MZksetvM5PF1hs7WSxubjnKYnF51xw2i+7rO9gs
        lh//x2TRdfcGo8XSf29ZHPg9Ll/x9li85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0
        H+hmCuCI4rJJSc3JLEst0rdL4Mp48Xc/e8EBvoqvt1+wNzBO5eli5OSQEDCR+LG2n7GLkYtD
        SGA3o8SpDQ2MEAlJiRM7n0PZwhL3W46wgthCAt8YJW7uNAOx2QQ0JZ7enMoE0iwi8IpJYu7/
        U2ANzALqErsmnGACsYUFAiTmtD1kBrFZBFQlLv7aBlbDKxAt0XDtADPEAjmJm+c6wWxOAUuJ
        s2//sHcxcgAts5Bo3G+MQ3gCo8ACRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        8aCluYNx+6oPeocYmTgYDzFKcDArifDu8qpOEeJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoFph7X5s4MF3Ss/Lis+cuGp5VnFthX13hfWPzmYwCAVm1rx
        J2HCxZeTbe4c+yn85/lpGacul1sXd3RoGobbdYX1cUy7mGj9XOHJjS/mAj0nGfivbVPuWSHg
        OunpLL3jyWemZK5w3rzguXjx/ue9Ox8Vp0WoFme/Ptve5DllRZFGQ/fxCCNVwSnscU89OvZd
        ej7F+P7ESxXnHjW8FxLQ6d/sEstq4/LN7q3im9RnDG0OFj8kVH59kk9+lXvC7m8iQ0Rc/tHa
        tX0vhG2FdtcemWGi7VZmk1VXyCk0oVDlzpYTa/bfvGor8a9hW1kx96I/LRHTLO836IRw6v58
        s1T8rPLJolXvV9/kbXr0rEuvTUVBiaU4I9FQi7moOBEAkz2a9PYCAAA=
X-CMS-MailID: 20230605012506epcas2p2c487b751827e3a39c74fdbd88dbd1311
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605012506epcas2p2c487b751827e3a39c74fdbd88dbd1311
References: <cover.1685927620.git.kwmad.kim@samsung.com>
        <CGME20230605012506epcas2p2c487b751827e3a39c74fdbd88dbd1311@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
its related contexts are accessed within the period wrappted
by uic_cmd_mutex. Thus, wrapping with host_lock is
redundant.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..a89d39a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2457,7 +2457,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);
 
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
@@ -2484,7 +2483,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	int ret;
-	unsigned long flags;
 
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_UIC_CMD)
 		return 0;
@@ -2493,9 +2491,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -4180,8 +4176,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		wmb();
 		reenable_intr = true;
 	}
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	if (ret) {
 		dev_err(hba->dev,
 			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-- 
2.7.4

