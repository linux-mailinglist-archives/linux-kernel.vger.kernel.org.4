Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668936FC1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjEIIdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEIIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:33:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E921E7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:33:17 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230509083314epoutp04378d927aafd76d4ea7c2657631c9d1ce~dbI5NxiT91867718677epoutp04F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230509083314epoutp04378d927aafd76d4ea7c2657631c9d1ce~dbI5NxiT91867718677epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683621194;
        bh=uYJN7HQN0yUJfuNCPmL+Vq6L3jpPWUWnbtogStcJ3YA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VuXVwEAmDtpQfVVPSJGIcQSCEIYRs+OvlzwBGewOuBl7gYVs2f6mtlSLX1mUwvIr9
         jiTxaXFH8+RXbB6RnqJAqJKQ0e9+Y+oWw8m850ZDgAtFSCX1DPSJjKgatDJj9j3hkw
         5u4d7gX4xCI9Ar5BZb1RAtXH+1qugZddVFf5u7IQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230509083313epcas2p23e863471d8683288ae83d7fdfaea4b32~dbI4wwKVl0643406434epcas2p28;
        Tue,  9 May 2023 08:33:13 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFryc6t8Cz4x9Q0; Tue,  9 May
        2023 08:33:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.45.22936.8450A546; Tue,  9 May 2023 17:33:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb~dbI3kBlAR1519215192epcas2p3e;
        Tue,  9 May 2023 08:33:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230509083312epsmtrp29bff0b16d99ef7128055f855d2e22645~dbI3jJ__82304923049epsmtrp2O;
        Tue,  9 May 2023 08:33:12 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-0c-645a0548c83f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.34.28392.8450A546; Tue,  9 May 2023 17:33:12 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509083312epsmtip1c6ca7a82229cb5a2cf3310578f1c5d1b~dbI3WMgz90439304393epsmtip1Q;
        Tue,  9 May 2023 08:33:12 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Date:   Tue,  9 May 2023 17:24:34 +0900
Message-Id: <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmma4Ha1SKwdp+Y4uTT9awWTyYt43N
        4uXPq2wWBx92slisXvyAxWLRjW1MFltv7GSxuLnlKIvF5V1z2Cy6r+9gs1h+/B+TRdfdG4wW
        S/+9ZXHg9Vi85yWTx4RFBxg9vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCmCPyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpXSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcfbtEcaCVdwV
        i/4tZmtgXMXZxcjJISFgIrH16xfmLkYuDiGBHYwSk6/uh3I+MUp8vPmbFcL5zCixv3EyC0zL
        pd59UIldjBLrpmxnBEkICfxglGhYbwpiswloSjy9OZUJpEhEYBWTxIeTd9hBEswC6hK7Jpxg
        ArGFBTwk9qx4zgZiswioSkzd9JkVxOYVcJPY9+oTG8Q2OYmb5zrBbpIQeMsu0XL4MztEwkXi
        8ZEfjBC2sMSr41ug4lISn9/tBWrmALKzJfYsFIMIV0gsnvYW6gNjiVnP2hlBSpiBDl2/Sx+i
        WlniyC0WiCv5JDoO/2WHCPNKdLQJQTQqS/yaNBlqp6TEzJt3oHZ6SNz7cwQaCrESXTNOsE5g
        lJ2FMH8BI+MqRrHUguLc9NRiowITeBwl5+duYgQnQC2PHYyz337QO8TIxMF4iFGCg1lJhHdV
        QliKEG9KYmVValF+fFFpTmrxIUZTYGhNZJYSTc4HpuC8knhDE0sDEzMzQ3MjUwNzJXHejx3K
        KUIC6YklqdmpqQWpRTB9TBycUg1MTes+Kgl2bTu/XZdhm1hVzIKlxjHRZd+tTtzY+9N/9+3v
        ZsLBcXPvO7/6Kv7jcfvcu6/Frf/KKCt+feJ0/9NFCbuKlFimj12PX3yNKvlkmM1x/vSf6ZxT
        dhiY7o+xWHWF/03xyayQBe/cy+0CctWtnYwb/NlXd/hPPR+evL6u81Z3fVv3hG0ufC8t5daK
        dl56f3NdYc9vu9PJ2x02X8/2etp5WfL+4xkVewo570hfWvC/SejwJWPzNFO1VJtA59inrSVr
        /Zhb7TQuyjtcssoK6FE5f1kwNTZcfPaTec8vNn6IKV017dE1i8mf7UUUCpN9mjcoTPnyUkUl
        fpF5XadyTOk0pmOXD1vNPh7OZblaiaU4I9FQi7moOBEA3ctkNQkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnK4Ha1SKwdtzAhYnn6xhs3gwbxub
        xcufV9ksDj7sZLFYvfgBi8WiG9uYLLbe2MlicXPLURaLy7vmsFl0X9/BZrH8+D8mi667Nxgt
        lv57y+LA67F4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNoP9DNFMAexWWTkpqTWZZa
        pG+XwJVx9u0RxoJV3BWL/i1ma2BcxdnFyMkhIWAical3H2sXIxeHkMAORolfjSsYIRKSEid2
        PoeyhSXutxyBKvrGKLFx0Vo2kASbgKbE05tTmUASIgI7mCSWPnzMApJgFlCX2DXhBBOILSzg
        IbFnxXOwBhYBVYmpmz6zgti8Am4S+159YoPYICdx81wn8wRGngWMDKsYJVMLinPTc4sNC4zy
        Usv1ihNzi0vz0vWS83M3MYIDU0trB+OeVR/0DjEycTAeYpTgYFYS4V2VEJYixJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5Mp27HOPa+e5QgGKxku2Jt3
        OG1KyFUDSc0HHKpvkx802n2/83vVvZNibzbP8d3YYqUqe+/2w6Apm//tWcybUf+3eW2K9FeN
        5S+3nT3oKXPIYtGrb7er/D0dtivPDxLaZBKQfWtPTurNjfnsjcUlH+8FT7mwPH9XS4rnoenr
        vM/sLSl5fvHZme2s+XIrb8t+eXfhkYvudJOoiG/t5+ZtPfdEQU+FbULsz8/bSvpDJVlMZHlD
        qrKOfJ7FMCO1sHbJEf6KL6xME9Ja3F9c/1snzHquvMjkusPqG+kFLIKxBe87d7p4LDc4xfGP
        PUBCM/XnLCm7fJdpFttXueyW89/wb5dhxtVwm/DbLCudfiwN8lZVYinOSDTUYi4qTgQApLxp
        z7sCAAA=
X-CMS-MailID: 20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
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

With auto hibern8 enabled, UIC could be working
for a while to process a hibern8 operation and HCI
reports UIC not ready for a short term through HCS.UCRDY.
And UFS driver can't recognize the operation.
UFSHCI spec specifies UCRDY like this:
whether the host controller is ready to process UIC COMMAND

The 'ready' could be seen as many different meanings. If the meaning
includes not processing any request from HCI, processing a hibern8
operation can be 'not ready'. In this situation, the driver needs to
wait until the operations is completed.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 96ce6af..fc79539 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2368,7 +2368,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
+	u32 val = 0;
+
+	do {
+		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
+			UIC_COMMAND_READY;
+		if (val)
+			break;
+		usleep_range(500, 1000);
+	} while (ktime_before(ktime_get(), timeout));
+
+	return val ? true : false;
 }
 
 /**
-- 
2.7.4

