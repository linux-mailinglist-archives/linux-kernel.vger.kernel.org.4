Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A172F3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbjFNElg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjFNElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:41:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22BF1BE9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:41:21 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230614044119epoutp01f6a71aced455f5e769a3bb83877f9c61~obMsSeSOi2480824808epoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230614044119epoutp01f6a71aced455f5e769a3bb83877f9c61~obMsSeSOi2480824808epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686717679;
        bh=ihr6uri5JQnq5ljeBYFG+iPe4bTktOiMFmEJJkwqkcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=bFPlE49MVJ/RXm2HVHQvxWaqaWjTmvPGMN7J5N2FmhSfJ+k0zt3iiVGVAoLCovJU4
         wC4vDQNjfCFIYE7h0azcHdpT4NPPT12Y/zzgwRK/DBg88X9Yims++2I3EwDcI5aG9i
         /i5UJG8tklvepJEsh454MU9F534glLr+WeW7sp3c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230614044119epcas2p2c6be1e03c7bd85be9234f36986cdbf7d~obMrsFkGU0401904019epcas2p2B;
        Wed, 14 Jun 2023 04:41:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Qgt6Q2j51z4x9Q1; Wed, 14 Jun
        2023 04:41:18 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.DF.11450.EE449846; Wed, 14 Jun 2023 13:41:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230614044117epcas2p17e84a99b4cb1ae92a922dea59a5b77a1~obMqbRR9G3163231632epcas2p1j;
        Wed, 14 Jun 2023 04:41:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230614044117epsmtrp10e51e4efe1f5fb729a7ab9ef92007ce0~obMqYxv8o3155031550epsmtrp19;
        Wed, 14 Jun 2023 04:41:17 +0000 (GMT)
X-AuditID: b6c32a45-1dbff70000022cba-ce-648944eee364
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.77.28392.DE449846; Wed, 14 Jun 2023 13:41:17 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230614044117epsmtip1b9f314395fc3a48df4d04cdcf1ac7d4e~obMqJ4X3P0141301413epsmtip1X;
        Wed, 14 Jun 2023 04:41:17 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3 1/2] ufs: make __ufshcd_send_uic_cmd not wrapped by
 host_lock
Date:   Wed, 14 Jun 2023 13:31:55 +0900
Message-Id: <bec84ee1ce8f5c5971b98d8e501aeabb9b5b26d1.1686716811.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686716811.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1686716811.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmue47l84Ug5/TBCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZn+/NYCn4zFcx98oZ1gbGQzxdjJwcEgImEtN3XmXrYuTiEBLYwSixesI8
        RgjnE6PEkZkvWSCcz4wSM+ZdZ4VpufrsFxNEYhejxJuuL1AtPxglWpr62EGq2AQ0JZ7enApW
        JSLwgUni//JtjCAJZgF1iV0TTjCB2MICQRJbZj9iA7FZBFQlzs9fCVbDKxAtsWbjTzaIdXIS
        N891MoPYnAKWEvu2r2RDZXMA1SzkkDisClHuIjG16xDUpcISr45vYYewpSRe9rexQ5RnS+xZ
        KAYRrpBYPO0tC4RtLDHrWTsjSAkz0Pnrd+lDVCtLHLnFAnE7n0TH4b9QQ3glOtqEIBqVJX5N
        mswIYUtKzLx5B2qnh8TBzyfAbCGBHkaJRZ9tJzDKz0KYv4CRcRWjWGpBcW56arFRgSE86pLz
        czcxgpOqlusOxslvP+gdYmTiYDzEKMHBrCTC+1SjPUWINyWxsiq1KD++qDQntfgQoykwDCcy
        S4km5wPTel5JvKGJpYGJmZmhuZGpgbmSOK+07clkIYH0xJLU7NTUgtQimD4mDk6pBqbiF1kn
        7d09T/7Z8iIsmPf1U5l6RUPdr233Hp2R+Lvs7rLZBn8nNv1VmbHZ3fjej5OcHo7ZrLW747N3
        OcwsfLVywazOgJ3zm3mWvMl0a9U3t7doPP/22MXXLY55LTJ23V7bHrKdrGw0YLDWeJW7oCz8
        z7OLGhfLPsrOVHwsWdEttV/Q1N36wMbX9f0LG/VzH399/VR0dmHPa83JGamrk3gnzUiY/qfl
        4vp9b9wFKi2/uIp+8K9ks9TY8n5JpHqPvc2rXUIWMx1kIm1FN7xuMUoXaW+ftLf83Yc1sanV
        IhfaXDu+/Tpfaj57alCF2vaGglPNwWsZjs1bqd1df1je3uuI+Jrb/q+2r+V4/GCzBYsSS3FG
        oqEWc1FxIgA04xIXMwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO5bl84Ug4Pr9SxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI4oLpuU1JzMstQifbsErozP92awFHzmq5h75QxrA+Mhni5GTg4JAROJq89+
        MXUxcnEICexglDi6YhU7REJS4sTO54wQtrDE/ZYjrBBF3xgl/q7tZgZJsAloSjy9ORWsW0Sg
        iVni0uzpLCAJZgF1iV0TTjCB2MICARIn7hwCa2ARUJU4P38l2FRegWiJNRt/skFskJO4ea4T
        rIZTwFJi3/aVYHEhAQuJFcc2MeISn8AosICRYRWjZGpBcW56brFhgVFearlecWJucWleul5y
        fu4mRnB8aGntYNyz6oPeIUYmDsZDjBIczEoivE812lOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJJrNAmKjb5ncvBJi3Zm+Je9k9mmX/Dw1+I46Wey
        Ynbp//rqE9c2TJ/D66z/4kUQp7PH6yDRxX0JkrzdLTNWqyvotp2zKti64OsHwTn1+ssmnNmY
        1bD1c09Xge6tgshOl1nL9W7M5m9/tPyVFdtLF+F/av/jPubqsemaSxs/T9Lt+Df/kVjS/xUf
        5k79eiD1pcnkCy23vt35JfPSe7eqp4qfmNiODVKe+pwe+0rPhAolvfQ/bn9aKyH5sdmRB3pf
        jLWV/K6tmarm71tut6ZlTwTrsYcfYtPXOS/Zr+l+VLbrKveU0kLedztmfr2y0MCy7L5dh+6y
        4q4qV21nl4N9ue8U3lz6xntP75nsXelHIUosxRmJhlrMRcWJAFu9BoH+AgAA
X-CMS-MailID: 20230614044117epcas2p17e84a99b4cb1ae92a922dea59a5b77a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614044117epcas2p17e84a99b4cb1ae92a922dea59a5b77a1
References: <cover.1686716811.git.kwmad.kim@samsung.com>
        <CGME20230614044117epcas2p17e84a99b4cb1ae92a922dea59a5b77a1@epcas2p1.samsung.com>
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

__ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
its related contexts are accessed within the period wrappted
by uic_cmd_mutex. Thus, wrapping with host_lock is
redundant.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

