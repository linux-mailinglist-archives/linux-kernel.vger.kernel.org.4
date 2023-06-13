Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1D72D900
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbjFMFOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFMFOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:14:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5FE79
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:14:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D4U4gx022408;
        Tue, 13 Jun 2023 05:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+xOblXP6Of44juClUSLRySEfxGA1qt8RGsv8h8ljKLE=;
 b=b8IY0KN8TyAS/wYGkwSqrzsJLg2cCQ4/sAgIoSDBMrA6zr7gMZXnSzaLjfhC8x4tbphU
 xpV/IBKmtNBXEFORaEoUGnDL5oEBSGke6Gy/uN6Dry3htdkoy5EC6uRAvDJ1rMGTjOvE
 +QXgVLdK+pJ6W3tE5iqgv2KsfcZMpoC7lkzQxRVWTJifWr7+aYX5VUfp59wO92xmIhPX
 nWCt+W2obr0GKUY28h0WnOVxG243BtcfkuxqzBYbOz7aYLxtXz9GEUlb8QtdNMlsMgEF
 yzohgnOMIeLXuA7cF0o9pw02GVmhKtWxNYZ0TGHluFpo1w0zgN3pf41bkExuzhmGVLzO Lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r69gx0s9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 05:14:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D5Dx3O021631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 05:13:59 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 22:13:56 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <yury.norov@gmail.com>,
        <mingo@kernel.org>, <mgorman@techsingularity.net>
CC:     <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        "Charan Teja Kalla" <quic_charante@quicinc.com>
Subject: [PATCH] mm: fix gfp-translate for changes in gfp.h
Date:   Tue, 13 Jun 2023 10:43:37 +0530
Message-ID: <1686633217-4397-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2F8eCcU-5At9-eJbJYHjcr4ZTrk_hIyp
X-Proofpoint-GUID: 2F8eCcU-5At9-eJbJYHjcr4ZTrk_hIyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 mlxlogscore=529 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h>
out of <linux/gfp.h>") made all the gfp flags that the gfp-translate
script needed to move from gfp.h to gfp_types.h.  Made changes
accordingly in the gfp-translate scipt.

w/o this patch:
$./scripts/gfp-translate 0xc2cc0
Source: /local/mnt/workspace/linux_next/linux
Parsing: 0xc2cc0

with this patch:
Source: /local/mnt/workspace/linux_next/linux
Parsing: 0xc2cc0
 #define ___GFP_IO               0x40
 #define ___GFP_FS               0x80
 #define ___GFP_DIRECT_RECLAIM   0x400
 #define ___GFP_KSWAPD_RECLAIM   0x800
 #define ___GFP_NOWARN           0x2000
 #define ___GFP_COMP             0x40000
 #define ___GFP_NOMEMALLOC       0x80000

Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 scripts/gfp-translate | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index b2ce416..6c9aed1 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -63,11 +63,11 @@ fi
 
 # Extract GFP flags from the kernel source
 TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp.h
+grep -q ___GFP $SOURCE/include/linux/gfp_types.h
 if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
+	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
 else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
+	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
 fi
 
 # Parse the flags
-- 
2.7.4

