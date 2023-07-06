Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1809749780
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGFIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGFIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:30:08 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607E172B;
        Thu,  6 Jul 2023 01:30:06 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36682iDb008793;
        Thu, 6 Jul 2023 01:29:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=1ZEpEJ3wY0qfhKSF5ra0D99Xg8RU0YVV0USN/1rtEzU=;
 b=bDvZoMAZyo1vcoa2A07TH0AdTbtio8HE2pehf/dzOUFjWDyq2X8gZvVul5YIyAxnieqq
 BsQqjcn/b0Z6nQvN1kJKhD5OV8WIZoy7io1cJSrs71pBgQ9BzavT2snLggLbppjf8D2B
 JMSqzECQ5tqAekrXgFHDccITaprRkLfj1yPx9lhsa987VT3Wqxq21A03PY5jx+lDnpxH
 kFy5AAgpDo3E6IM6oSrWajSOJuA8za7hLkpoxT+XlEm1BCBtqZTPvtRH0M+L0z9hlNPM
 3ahyeM4ap8e0ho3PEqTRMVLO298+Um8YW3lqjwltcFQrjtq8YMzuQtZCkSAsIiBfZmxw Mg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rnsc2837c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 01:29:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Jul
 2023 01:29:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 6 Jul 2023 01:29:42 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
        by maili.marvell.com (Postfix) with ESMTP id E08AE3F706D;
        Thu,  6 Jul 2023 01:29:38 -0700 (PDT)
From:   Sai Krishna <saikrishnag@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <dan.carpenter@linaro.org>, <maciej.fijalkowski@intel.com>
CC:     Sai Krishna <saikrishnag@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [net PATCH v3] octeontx2-af: Move validation of ptp pointer before its usage
Date:   Thu, 6 Jul 2023 13:59:36 +0530
Message-ID: <20230706082936.1945653-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xLjCUjwt1bbyJpGtOKAHO4gDVs6coe-X
X-Proofpoint-ORIG-GUID: xLjCUjwt1bbyJpGtOKAHO4gDVs6coe-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_04,2023-07-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved PTP pointer validation before its use to avoid smatch warning.
Also used kzalloc/kfree instead of devm_kzalloc/devm_kfree.

Fixes: 2ef4e45d99b1 ("octeontx2-af: Add PTP PPS Errata workaround on CN10K silicon")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
v3:
    - Addressed review comments given by Dan Carpenter
	1. Modified probe return value in normal way.
	2. Fixed crash in PTP probe fail case
	3. Returning error from AF probe in case of PTP probe fail
v2:
    - Addressed review comments given by Maciej Fijalkowski
	1. Modified patch title, commit message
	2. Used kzalloc/kfree instead of devm_kzalloc/devm_kfree

 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 19 +++++++++----------
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 3411e2e47d46..0ee420a489fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -208,7 +208,7 @@ struct ptp *ptp_get(void)
 	/* Check driver is bound to PTP block */
 	if (!ptp)
 		ptp = ERR_PTR(-EPROBE_DEFER);
-	else
+	else if (!IS_ERR(ptp))
 		pci_dev_get(ptp->pdev);
 
 	return ptp;
@@ -388,11 +388,10 @@ static int ptp_extts_on(struct ptp *ptp, int on)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
-	struct device *dev = &pdev->dev;
 	struct ptp *ptp;
 	int err;
 
-	ptp = devm_kzalloc(dev, sizeof(*ptp), GFP_KERNEL);
+	ptp = kzalloc(sizeof(*ptp), GFP_KERNEL);
 	if (!ptp) {
 		err = -ENOMEM;
 		goto error;
@@ -428,20 +427,19 @@ static int ptp_probe(struct pci_dev *pdev,
 	return 0;
 
 error_free:
-	devm_kfree(dev, ptp);
+	kfree(ptp);
 
 error:
 	/* For `ptp_get()` we need to differentiate between the case
 	 * when the core has not tried to probe this device and the case when
-	 * the probe failed.  In the later case we pretend that the
-	 * initialization was successful and keep the error in
+	 * the probe failed.  In the later case we keep the error in
 	 * `dev->driver_data`.
 	 */
 	pci_set_drvdata(pdev, ERR_PTR(err));
 	if (!first_ptp_block)
 		first_ptp_block = ERR_PTR(err);
 
-	return 0;
+	return err;
 }
 
 static void ptp_remove(struct pci_dev *pdev)
@@ -449,16 +447,17 @@ static void ptp_remove(struct pci_dev *pdev)
 	struct ptp *ptp = pci_get_drvdata(pdev);
 	u64 clock_cfg;
 
-	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
-		hrtimer_cancel(&ptp->hrtimer);
-
 	if (IS_ERR_OR_NULL(ptp))
 		return;
 
+	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
+		hrtimer_cancel(&ptp->hrtimer);
+
 	/* Disable PTP clock */
 	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
+	kfree(ptp);
 }
 
 static const struct pci_device_id ptp_id_table[] = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 8dbc35c481f6..73df2d564545 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3252,7 +3252,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rvu->ptp = ptp_get();
 	if (IS_ERR(rvu->ptp)) {
 		err = PTR_ERR(rvu->ptp);
-		if (err == -EPROBE_DEFER)
+		if (err)
 			goto err_release_regions;
 		rvu->ptp = NULL;
 	}
-- 
2.25.1

