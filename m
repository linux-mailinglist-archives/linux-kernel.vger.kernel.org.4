Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412C0721B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjFEBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFEBZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:25:14 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86791DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:25:11 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230605012508epoutp025d1d9f8cfcf6ede438315e4c04c0ef98~lnt0ehFsw2049920499epoutp02X
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:25:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230605012508epoutp025d1d9f8cfcf6ede438315e4c04c0ef98~lnt0ehFsw2049920499epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685928308;
        bh=2blGkSBBXm4zaLKMkTF38nrbVzbShP93LN6Q/TbaAuM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TVkjGzon02wi1rwrFcwX64+16C+TH5eekeASvMvXhBhZKZA+/9Z1U/cYmRghgutUi
         QXEa+Ihu8gmspgmUhM1dR0++Lb9BmrUCv/NVrS0GkbMOd7Nr71TgjJvPyPUIJaIBIt
         09H4Y+hQQNv3mxRuE5Xhui2EKBoNis6gkuMTE0I8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230605012507epcas2p16feef1a85cd1f1e7c2ce8d1d5ed44acb~lntzuasNx2538025380epcas2p1L;
        Mon,  5 Jun 2023 01:25:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QZGBB53mKz4x9Pp; Mon,  5 Jun
        2023 01:25:06 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.15.44220.2793D746; Mon,  5 Jun 2023 10:25:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230605012505epcas2p4fa6facb5ad68289d0e7904bc77ea8506~lntyLypHN2614626146epcas2p4Q;
        Mon,  5 Jun 2023 01:25:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605012505epsmtrp140d4fb9441fe73f812c40d8b77b481df~lntyKyADN2747127471epsmtrp1E;
        Mon,  5 Jun 2023 01:25:05 +0000 (GMT)
X-AuditID: b6c32a48-9f1ff7000000acbc-a4-647d3972eda7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.28.28392.1793D746; Mon,  5 Jun 2023 10:25:05 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605012505epsmtip2788b0e72cc95051b24bb53b89f6521a8~lntx71Rbv3164931649epsmtip2D;
        Mon,  5 Jun 2023 01:25:05 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 0/3] change UIC command handling
Date:   Mon,  5 Jun 2023 10:15:51 +0900
Message-Id: <cover.1685927620.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQrfIsjbFYN08ZYuTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csDvwel694eyze85LJY8KiA4we39d3sHl8fHqLxaNvyypGj8+b5Dza
        D3QzBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AB2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAw
        MgUqTMjO2DPpDVPBFraKi9v3sTQwbmXtYuTkkBAwkeiavpOpi5GLQ0hgB6NE45nj7BDOJ0aJ
        Wd//QDmfGSWOzT7IDtOy98ELZojELkaJHZefQjk/GCW2/TzCDFLFJqAp8fTmVCYQW0TgBpPE
        k35REJtZQF1i14QTYHFhAWOJrffXsoHYLAKqEseefwXr5RWwkNjavIwJYpucxM1znWALJAQa
        OSQuLdnNDJFwkfhyrZcNwhaWeHV8C9R5UhIv+9uAbA4gO1tiz0IxiHCFxOJpb1kgbGOJWc/a
        GUFKmIHuXL9LH6JaWeLILRaIK/kkOg7/hRrCK9HRJgTRqCzxa9JkRghbUmLmzTtQOz0kvl+7
        CHaLkECsxNe3q5gnMMrOQpi/gJFxFaNYakFxbnpqsVGBCTyOkvNzNzGCk6OWxw7G2W8/6B1i
        ZOJgPMQowcGsJMK7y6s6RYg3JbGyKrUoP76oNCe1+BCjKTC0JjJLiSbnA9NzXkm8oYmlgYmZ
        maG5kamBuZI478cO5RQhgfTEktTs1NSC1CKYPiYOTqkGJvaEuxvLna9+OeFef6Z4+33T9ol1
        N/uW59xQ6az6d/ncxAeq7xfpHfp3cr1N77X9NXHOKUoK3UrMu/N/z99yYWEHN4vA92afdsWA
        CeznX5ZdtC5jszoxY0P6qgO7X/Xtnb7n6qv7DHkGq6WXHj5wz42Ro/CtqPAxH7/9ScudM1P+
        t5zTSWYxnvE/0MIwoOnX4m0WW7un3Ktq/KtSy3iHX29RuNPN4kWrPxeHLFj/3WD7BZbAC37P
        2ORLdQ+X5cndPLUqLFPx5+UOK4VnE3YrGCoxqCQ4XnNYuXLlzXgLeQajx3tv7Vi2RrbI2ePh
        h8RSnWcNVzi/O6ZIOW9ISJlpxPVzV/eKR+t+BYl4Nv81vq/EUpyRaKjFXFScCAD4H9FRFwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvG6hZW2KQeMrOYuTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csDvwel694eyze85LJY8KiA4we39d3sHl8fHqLxaNvyypGj8+b5Dza
        D3QzBXBEcdmkpOZklqUW6dslcGXsmfSGqWALW8XF7ftYGhi3snYxcnJICJhI7H3wgrmLkYtD
        SGAHo0RL639GiISkxImdz6FsYYn7LUdYIYq+MUq0f25lAUmwCWhKPL05lQkkISLwikli7v9T
        YB3MAuoSuyacYAKxhQWMJbbeX8sGYrMIqEoce/6VGcTmFbCQ2Nq8jAlig5zEzXOdzBMYeRYw
        MqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOWi2tHYx7Vn3QO8TIxMF4iFGCg1lJ
        hHeXV3WKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzc
        Vkf3mP/lff/j4L8jf5TKE6+aP+z51egexGJR9vyxwLcgS4tdga6vzmzsuzvLYUNIxIrVM+61
        Tn11y/RaRUx8T+ZV3uOTwg2qqpN7bPNLTut+VZinFBQeuctRMVv664ZX9d4LHkzRM5k42Tx6
        zTe2XxM0Z7aLLD/cwiE+4bRamdy9le3Hbfy0tcK2MN3vFr7uYhy/Yn3Y+5I2M4eZD1a/e2gv
        3BzQ3RwgwbhApvzCkuW8Fw5kfHPPUOm6POsY42Of6qO612SvXo55e+rAF97znzKnFUyfvjEn
        aqfKpxaNVCPRVe5ihYu4LVIP2789pzpzoeaDA5adc18ZG156rfvRYg1HBlfDTot/XErBs5WU
        WIozEg21mIuKEwE0pwG6yQIAAA==
X-CMS-MailID: 20230605012505epcas2p4fa6facb5ad68289d0e7904bc77ea8506
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605012505epcas2p4fa6facb5ad68289d0e7904bc77ea8506
References: <CGME20230605012505epcas2p4fa6facb5ad68289d0e7904bc77ea8506@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd

There are two issues on UIC command handling related to auto hibern8.
https://lore.kernel.org/linux-scsi/1684208012-114324-1-git-send-email-kwmad.kim@samsung.com/
https://lore.kernel.org/linux-scsi/1684209152-115304-1-git-send-email-kwmad.kim@samsung.com/

Now I combine the two things into this thread.
And one thing added to make part of submitting a UIC command apart
from the critical section w/ host_lock.

Kiwoong Kim (3):
  ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
  ufs: poll HCS.UCRDY before issuing a UIC command
  ufs: poll pmc until another pa request is completed

 drivers/ufs/core/ufshcd.c | 110 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 33 deletions(-)

-- 
2.7.4

