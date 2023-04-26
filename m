Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744B6EED80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbjDZFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:22:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4E2727
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 22:22:07 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230426052155epoutp02986fbc4e6bb31a328578085d4d7505a4~ZZJJDm14Z2166921669epoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:21:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230426052155epoutp02986fbc4e6bb31a328578085d4d7505a4~ZZJJDm14Z2166921669epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682486515;
        bh=Mablksv+xusZx3eIKvm1G4NKxdL629bEN5mQIqNAqMI=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=aOkwRT8O+7N/kDLvepiP0F3NTz9HlX8J32dKmkC5lUdDVXXC2hhrT86xIR2lHO7gV
         bGHbSjqV3SgnE2PRrxpZjypbvKmP3hSpoXw5ZpLIrYCEzmvC1hM8YkHGYH8p926l2O
         Hc8ZgD0o0ZhodUogmOVFXWANRe80uJDsGXlVJw9c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230426052154epcas2p138bcce16ce6281eb794ce0d924dbef36~ZZJIQ-k480119601196epcas2p1B;
        Wed, 26 Apr 2023 05:21:54 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q5nKs2mT8z4x9Q6; Wed, 26 Apr
        2023 05:21:53 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-ac-6448b4f1191a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.E5.22936.1F4B8446; Wed, 26 Apr 2023 14:21:53 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
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
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
Date:   Wed, 26 Apr 2023 14:21:53 +0900
X-CMS-MailID: 20230426052153epcms2p27d64a865f15bfd452d564f77d63605db
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmhe7HLR4pBp8nCVs8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni5SFNi0e3nzFaLLqxjcni8q45bBbd13ewWSw//o/JYmHHXBaLpVtvMjrw
        eFy+4u0xYdEBRo+Wk/tZPL6v72Dz+Pj0FovHxD11Hn1bVjF6fN4k59F+oJspgDMq2yYjNTEl
        tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GAlhbLEnFKgUEBi
        cbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGpumX2Qse
        sFU87L7E2sB4krWLkZNDQsBE4tyl68xdjFwcQgI7GCVeNqwAcjg4eAUEJf7uEAapERawl3jy
        bDUjiC0koCTRtXArM0TcQGLd9D1gNpuAnsSU33cYQeaICHSxSLw+O4UZYgGvxIz2pywQtrTE
        9uVbGSFsDYkfy3qhakQlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93Q8UlJVrPbGWDsOslWt+f
        YgdZLCEwgVGi8dgfqEH6Etc6NoIt5hXwldj7awfYIBYBVYnmbW1QB7lInGg6DTaIWUBeYvvb
        OWDPMwtoSqzfpQ9iSggoSxy5xQJRwSfRcfgvO8xbDRt/Y2XvmPeECcJWk3i0YAs0nGUkLs45
        xwwx0kNi2wz+CYyKsxABPQvJCbMQTljAyLyKUSy1oDg3PbXYqMAEHrfJ+bmbGMFJV8tjB+Ps
        tx/0DjEycTAeYpTgYFYS4eWtdE8R4k1JrKxKLcqPLyrNSS0+xGgK9PxEZinR5Hxg2s8riTc0
        sTQwMTMzNDcyNTBXEuf92KGcIiSQnliSmp2aWpBaBNPHxMEp1cBUdcknt3xxtIXxWa1J6y8w
        vOpZmDRf7/a8NaL/t9ywWPKl6tOr2StnHJ4ufzvpCVO7Y9h5n3uTCtIvmtwpsdB8vM2VW21O
        kpRk5ppJs3emTLlZz7Fp8V1n0ZCN72fP3N1TqxvOsFTO1rTLfllIp7bqvcB23YMu2x8ZTfj0
        X3HKvo2qr5K8OHkuy1SsfXlusskeiWTzzXrO74y/qsXs38qV9XVxS/ZVmxeL/X5XLpducriw
        SHLhC/m7095teuBxy/Pyrvn6YTd6v2yawvxRNEGuzFdz8xxx7zdyedwhHLlftHNfh6UZS5/W
        Ylvv3H19hlGAylQHb3f5AwwfTpiFx7S/u1j4bOK+IisLk8yL24y2KrEUZyQaajEXFScCAFH1
        7khDBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230426052153epcms2p27d64a865f15bfd452d564f77d63605db
References: <CGME20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function does not require the "ret" variable because it returns
only the result of param_set_bool().

Remove unnecessary "ret" variable and simplify the code.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328ba323..46c4ed478ad0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -108,13 +108,7 @@ static bool is_mcq_supported(struct ufs_hba *hba)
 
 static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
 {
-	int ret;
-
-	ret = param_set_bool(val, kp);
-	if (ret)
-		return ret;
-
-	return 0;
+	return param_set_bool(val, kp);
 }
 
 static const struct kernel_param_ops mcq_mode_ops = {
-- 
2.17.1

