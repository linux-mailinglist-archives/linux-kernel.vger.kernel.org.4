Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7870D3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjEWG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjEWG2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:28:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D2C11A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:28:13 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230523062809epoutp03d26895a2feb52b946accbe7f8e797f45~hsdsIXRTb0596005960epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:28:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230523062809epoutp03d26895a2feb52b946accbe7f8e797f45~hsdsIXRTb0596005960epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684823289;
        bh=8QJgUTaCT3t6W1RKfIC9qVIhEKKpXC2PxxzVeSstsIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=Z6P5WFYT6Q1yHX+AKABfrBckokN5n1LfCYfsuoEG62gWNUdsjaKzyTatIbSyse/xA
         Bny8SZ7Ku8tIZhpKfCwjI/aG4/4pPePdv/N6aJAicuJLcXuRnEs5i/7HjWZWMO75fZ
         qJwUS38q0b8wHmjCudPj0hkd9YUj2t2jZaCSHFAo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230523062809epcas2p21cc8a68ca1d55e5d6c03b5a8958ce055~hsdrVFIKN3076330763epcas2p29;
        Tue, 23 May 2023 06:28:09 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QQPWr1jgHz4x9QG; Tue, 23 May
        2023 06:28:08 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.77.17293.8FC5C646; Tue, 23 May 2023 15:28:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523062807epcas2p1de7227c5b3d16759e9c622d066554b21~hsdqJCWaI2424824248epcas2p1p;
        Tue, 23 May 2023 06:28:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523062807epsmtrp2f3cd2c870cf34f508d577f0a75eb7e19~hsdqIIGPR1738517385epsmtrp2X;
        Tue, 23 May 2023 06:28:07 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-27-646c5cf861f0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.21.27706.7FC5C646; Tue, 23 May 2023 15:28:07 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523062807epsmtip12a52830ee386cd3f6f7004fccb9b40a8~hsdp2WdIs1800218002epsmtip1B;
        Tue, 23 May 2023 06:28:07 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1 1/3] ufs: make __ufshcd_send_uic_cmd not wrapped by
 host_lock
Date:   Tue, 23 May 2023 15:19:08 +0900
Message-Id: <c511c7f03ce77a604aa5211c3ffac96022c3ee40.1684822284.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684822284.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1684822284.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmme6PmJwUg9knuCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
        A3S8kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDA
        yBSoMCE74+qjU+wFK3kqfsz9ytjAuJ6ri5GTQ0LAROLR1UdsXYxcHEICOxglDjy7xgaSEBL4
        xCgx/0Q2ROIbo8TOyY9ZYTruTjzOBJHYyyjx7PERKOcHo8SFX2+YQKrYBDQlnt6cCmaLCNxg
        knjSLwpiMwuoS+yacAIozsEhLBAk8X9fHkiYRUBVYv21DrByXoFoiftLdrFBLJOTuHmukxnE
        5hSwlNjwqpkNlc0FVDOTQ+JS32RWkJkSAi4SE95bQvQKS7w6voUdwpaS+PxuLxtESbbEnoVi
        EOEKicXT3rJA2MYSs561M4KUMANdv36XPkS1ssSRWywQt/NJdBz+yw4R5pXoaBOCaFSW+DVp
        MiOELSkx8+YdqJ0eEv/WQ9hCAj2MEh9XM01glJ+FMH8BI+MqRrHUguLc9NRiowIjeMQl5+du
        YgSnUS23HYxT3n7QO8TIxMF4iFGCg1lJhPdEeXaKEG9KYmVValF+fFFpTmrxIUZTYCBOZJYS
        Tc4HJvK8knhDE0sDEzMzQ3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9TBycUg1M2x1ZXqyW
        rD2Ty9XZJfGBvY7fRWlNPJvfif/fp66suyQ7z2Yh0397/30lmvohBUr2In87mM788lz5yFKq
        quFZwdpY64dL+w+wnbP5kffonkfnFqEd4jzT7f4E+PzPuvj4K0vMFIs1U+ZknTqg7hQqF838
        oHZ9sZ7Douh/fkukXQRii6euZF4SePGJ8tnCfG722m81qrOW9UlK6bEUFfGuKZbmexhTb3e0
        pUPW/MaPS8369rFrQ3SlPTXmfupiPXDp8w7+PSeadvcGX3t9rOP6n93njy5/J8/35q6r2Cq+
        /G/L69sedh3wXuarE7d0o+csJrdb3DMXfRETntbjKHOhZzePgI1e6R/uG0rb+oqVWIozEg21
        mIuKEwFlqbeYLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO73mJwUgwWfVCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJVx9dEp9oKVPBU/5n5lbGBcz9XFyMkhIWAicXficaYuRi4O
        IYHdjBKrWh+yQSQkJU7sfM4IYQtL3G85wgpR9I1R4sj+/6wgCTYBTYmnN6eCdYsIvGKSmPv/
        FFgHs4C6xK4JJ5hAbGGBAIkX29rA4iwCqhLrr3WAxXkFoiXuL9kFtU1O4ua5TmYQm1PAUmLD
        q2agOAfQNguJxm98OIQnMAosYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHBFa
        mjsYt6/6oHeIkYmD8RCjBAezkgjvifLsFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqYZuiu2XNFI93007H5h/5wih6cs3H1vgU7b1YdszFomNn0J+GE
        +d13n4UDbvKoJX4sPHn3a+X+pTOqzxa67Pl//ldQ8ueps0NfCm38f7B8W7mT2Y42xdIvIUu4
        X069dLpH541zb/q7XX12TAeCXY4+uadcb/J4b+GjXR5Ln4SLRvcYHtb0k714wES2/PEsc6cD
        XvzNLadNt0TG8yr4isX4nVubdFjE80H38tM5l7gyGl0ZzpZbqUtN4d+nPlO+OOakrB/7+xcn
        fqxpKZb24eAtfSB+XPOJynelssLQs+/yU9mXMxQelXPx++Le+ai2/fdyg/tskTe6lxbYdmTv
        nXMgM0X8gNqUz5Mmt1zn/D25SYmlOCPRUIu5qDgRAPTid3H3AgAA
X-CMS-MailID: 20230523062807epcas2p1de7227c5b3d16759e9c622d066554b21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230523062807epcas2p1de7227c5b3d16759e9c622d066554b21
References: <cover.1684822284.git.kwmad.kim@samsung.com>
        <CGME20230523062807epcas2p1de7227c5b3d16759e9c622d066554b21@epcas2p1.samsung.com>
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

__ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
its related contexts are accessed within the period wrappted
by uic_cmd_mutex. Thus, wrapping with host_lock is
redundant.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..e096401 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2457,7 +2457,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);
 
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
@@ -2493,9 +2492,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -4180,8 +4177,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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

