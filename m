Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688D6DCFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDKCuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKCuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:50:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0BAE55
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:50:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230411025008epoutp0348d39b12e258e9986e2ec22601dd5b6f~UwZWGyggn2358623586epoutp03U
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:50:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230411025008epoutp0348d39b12e258e9986e2ec22601dd5b6f~UwZWGyggn2358623586epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681181408;
        bh=bKN2lCoddiXVm6pUI8D2ej5iHDRTVAidYa5VCvdXMqQ=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=bYnFbVodglaL7wa1oQ90ZPafPbq8oFgofb+xotcqgvJ5oCoBHjGMx9W9lo+DGPIhR
         kQGfFyRc9tXwwN5aaxLn2VMmp4ZRJ/GCMj4xiv2bJ359+WRSobaeqoMaOBdNX3mC94
         wfWjDZKJffXlP6/C9m0VU6qmqBe6qC/Wg5HfI4fg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230411025008epcas2p427ce51ee81e997761eac4c0af6a0f996~UwZVrCA8y0570805708epcas2p46;
        Tue, 11 Apr 2023 02:50:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PwVgh0ZJwz4x9Pv; Tue, 11 Apr
        2023 02:50:08 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-7c-6434cadf780f
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.9B.09650.FDAC4346; Tue, 11 Apr 2023 11:50:07 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Use proper power management API
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230411025007epcms2p17ffdb87332484608daf446c7fde6ceac@epcms2p1>
Date:   Tue, 11 Apr 2023 11:50:07 +0900
X-CMS-MailID: 20230411025007epcms2p17ffdb87332484608daf446c7fde6ceac
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmme79UyYpBmfWWlg8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni5SFNi0e3nzFaHD/0lcWit38rm8WiG9uYLC7vmsNm0X19B5vF8uP/mCy2
        fvrN6sDrcfmKt8fshossHhMWHWD0aDm5n8Xj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAM6o
        bJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoLOVFMoS
        c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ
        M/t/MBesZ6841/mdrYFxPlsXIyeHhICJxN9125i6GLk4hAR2MEqsPXaMvYuRg4NXQFDi7w5h
        kBphAUeJty0rWUBsIQElia6FW5kh4gYS66bvAbPZBPQkpvy+wwgyR0RgGYvEm/NvmCEW8ErM
        aH/KAmFLS2xfvpURwtaQ+LGsF6pGVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjwczdUXFKi9cxW
        qAfqJVrfn2IHWSwhMIFRovHYH6hB+hLXOjaCLeYV8JV4fLuZFcRmEVCVWLt1M9QgF4l9iw+B
        1TMLyEtsfzuHGeR5ZgFNifW79EFMCQFliSO3WCAq+CQ6Dv9lh3mrYeNvrOwd854wQdhqEo8W
        bGGFsGUkLs45B/WKh8Tck69YJjAqzkKE9CwkN8xCuGEBI/MqRrHUguLc9NRiowITeOQm5+du
        YgSnYC2PHYyz337QO8TIxMF4iFGCg1lJhPfrf+MUId6UxMqq1KL8+KLSnNTiQ4ymQN9PZJYS
        Tc4HZoG8knhDE0sDEzMzQ3MjUwNzJXHejx3KKUIC6YklqdmpqQWpRTB9TBycUg1MU178EXg/
        bVpewzp75i/T7md8qEreZWypIsgwc/WFqdO6ll0vTQ1dXuTUZt1utz3yfNKU2cfPbDEyOlTI
        UWJjynb51qbkixbyp+bM917jH/VO+egBfdUPdVFTFipvvbEnven/p12qF1NvPHiyrXKasOTv
        t21O1ws2883Kb5SXnn7O74DoDpakefGLXkUem+f+tCurfPYpxes1ym2n00tf7Sn9aC21VDDE
        ZbvyhkNsHsEPHPU71WY8sbt6a2dkgLlSQur8279SOHy3H/PptLWVvCbcte3w53/8i1LZ7Dcf
        ly598P/aG7M15ypb+69qJtgEnT9dUfxaJ+l9/eW1W37/zDqs+tloq/LWCYkxJRqNdUosxRmJ
        hlrMRcWJACdJrStKBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411025007epcms2p17ffdb87332484608daf446c7fde6ceac
References: <CGME20230411025007epcms2p17ffdb87332484608daf446c7fde6ceac@epcms2p1>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
modified the driver core to use ufshcd_rpm_{get,put}_sync() APIs.

Switch to these APIs in sysfs as well.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 883f0e44b54e..b683a43ea089 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -167,11 +167,11 @@ static ssize_t auto_hibern8_show(struct device *dev,
 		goto out;
 	}
 
-	pm_runtime_get_sync(hba->dev);
+	ufshcd_rpm_get_sync(hba);
 	ufshcd_hold(hba, false);
 	ahit = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
 	ufshcd_release(hba);
-	pm_runtime_put_sync(hba->dev);
+	ufshcd_rpm_put_sync(hba);
 
 	ret = sysfs_emit(buf, "%d\n", ufshcd_ahit_to_us(ahit));
 
-- 
2.17.1

