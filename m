Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B26F567E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjECKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjECKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:46:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14BB49DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:46:34 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230503104632epoutp0150c823596b7f1e231009e4f1efbb2251~bnFkmJIa41408914089epoutp01j
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:46:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230503104632epoutp0150c823596b7f1e231009e4f1efbb2251~bnFkmJIa41408914089epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683110792;
        bh=WBo+Gtt5+fa6g5qjUIPdBB+ssnPfrBNghApCsFJRoCo=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Ac3IemXeKwlZZUNIk93boTjrocnyFS8/ogaVnqdpWLm3yA9sKdC+Q+OxiNEh79/i+
         mafHH06nICsPX+btFDA//YftVcdjTyP7AOCwSbpluPlro6+0hQvmmFtXTeOOOiOatF
         tG4TC9ltqCylQP/y8XyPQcIKmEwl+9xJeYCRrEEU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503104631epcas2p4a09cc4d1324f05d21c1451160058db17~bnFjfm2LO1511615116epcas2p4k;
        Wed,  3 May 2023 10:46:31 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QBDCB3L80z4x9Pv; Wed,  3 May
        2023 10:46:30 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-13-64523b86678c
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.87.03265.68B32546; Wed,  3 May 2023 19:46:30 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Return earlier if
 ufshcd_hba_init_crypto_capabilities() fails
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503104630epcms2p8b82734102ffb920531e9264604086372@epcms2p8>
Date:   Wed, 03 May 2023 19:46:30 +0900
X-CMS-MailID: 20230503104630epcms2p8b82734102ffb920531e9264604086372
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmmW6bdVCKwYmNkhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYtGNbUwWl3fNYbPovr6DzWL58X9MFgs75rJYLN16k9GB2+PyFW+P
        CYsOMHq0nNzP4vF9fQebx8ent1g8Ju6p8+jbsorR4/MmOY/2A91MAZxR2TYZqYkpqUUKqXnJ
        +SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLcqKZQl5pQChQISi4uV9O1s
        ivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izrl5bylpwlaPi1Zp3
        rA2MXexdjJwcEgImEquv72ftYuTiEBLYwSix4PApli5GDg5eAUGJvzuEQWqEBRIl1i+YwwZi
        CwkoSXQt3MoMETeQWDd9D5jNJqAnMeX3HUaQOSICPcwSHbeWsYIkmAXqJHbP+cMGsYxXYkb7
        UxYIW1pi+/KtjBC2hsSPZb3MELaoxM3Vb9lh7PfH5kPViEi03jsLVSMo8eDnbqi4pETrma1Q
        8+slWt+fYgc5QkJgAqNE47E/UIP0Ja51bARbzCvgK7H842ywOIuAqsTJ2z+gml0kDs88yQxx
        tLzE9rdzmEEBwSygKbF+lz6IKSGgLHHkFgtEBZ9Ex+G/7DBvNWz8jZW9Y94TJghbTeLRgi2s
        ELaMxMU555gnMCrNQoT0LCR7ZyHsXcDIvIpRLLWgODc9tdiowBAeucn5uZsYwclWy3UH4+S3
        H/QOMTJxMB5ilOBgVhLh/VDolyLEm5JYWZValB9fVJqTWnyI0RTo44nMUqLJ+cB0n1cSb2hi
        aWBiZmZobmRqYK4kzittezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgUl88u7gwt/TeR/2RQr++PDj
        zhx3yyXyN/32FCz228Ox5dRs5SfXivX4Qs9s9giaZjDZRV/s7KSYzDkKFcFbZsrm7TlimFd3
        3k/G9JYBp3vG3N613VuPmlxObHt1n+VMwRcHj1cF4vLLTZYcYX1T/NW4un7RlekSk6L61K8H
        7/f1+SHNLP+D4cn8K+YrtpoVclXutJupoLxk4Y9a5k0PXs2R9udU9chIvHFPvGjhgz3W2f+y
        Tku4nGtI2xCVtumnq4jBth7m0Ie9NkFnfwUklPvvOqt44MaE6bp/o1/criph1Fz/KU/O747s
        7UdnbX2vrRI8U939YJLFRX63Q0yivrmvvmwL1ZhREXtc43/b5XdKLMUZiYZazEXFiQCbR6a4
        PwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503104630epcms2p8b82734102ffb920531e9264604086372
References: <CGME20230503104630epcms2p8b82734102ffb920531e9264604086372@epcms2p8>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'err' variable is used only as the result of
ufshcd_hba_init_crypto_capabilities(), so return 'err' immediately when
failed. If it is not an error, explicitly return 0.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328ba323..44328eb4158d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2343,18 +2343,20 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 
 	/* Read crypto capabilities */
 	err = ufshcd_hba_init_crypto_capabilities(hba);
-	if (err)
+	if (err) {
 		dev_err(hba->dev, "crypto setup failed\n");
+		return err;
+	}
 
 	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
 	if (!hba->mcq_sup)
-		return err;
+		return 0;
 
 	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
 	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
 				     hba->mcq_capabilities);
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.17.1

