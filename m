Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC91606F53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUFUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJUFUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:20:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB15252AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:20:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L58NFT022788;
        Fri, 21 Oct 2022 05:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=I3Al/klM/XIlOAZML6Oce00yyKO4av5ZtdxYSQ+PnM0=;
 b=KCGk9QZ3pmDWEaFfTxF5VGZwCVsv8wNSP9Puxtkh4+7eoX2i51IXu70G+TjkmfsW84WT
 gKc0GJ3h9+p9RD6li5pWDdUS8ejknMn6ckQZ6QjxuKuDMqdhGFrSD031jNUazNcCmvl0
 qrbH28qVcXo33T/xXCJepH7/XqchYunTxXLXZ2q48DENpPYRm/gEATWsXN4QmG61LNbm
 UNogGWhA1jI8/nW2XAbH+WLvbDycUvwIV6AmwYULC5fLboNNkW13zNMIOQj6qhEbIouL
 lTFer0XWXxGdwaPQhD6V4NUofqlOZLuPLARbudKWAVYQ/LB0N4T9gHU3AKTsRGVklcbn kw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kak1c4g15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:19:57 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Ju3I021913;
        Fri, 21 Oct 2022 05:19:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kbmda88e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:19:56 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29L5Jtqw021908;
        Fri, 21 Oct 2022 05:19:55 GMT
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 29L5JtSh021907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:19:55 +0000
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 22:19:53 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
Subject: [PATCH v2 0/1] mm/page_isolation: fix clang deadcode warning
Date:   Fri, 21 Oct 2022 13:19:35 +0800
Message-ID: <20221021051936.15346-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 20WYxPT3FFz2u60DhpevissDitdhzvzV
X-Proofpoint-ORIG-GUID: 20WYxPT3FFz2u60DhpevissDitdhzvzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=719 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210210030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !CONFIG_VM_BUG_ON, there is warning of
clang-analyzer-deadcode.DeadStores:
Value stored to 'mt' during its initialization
is never read.

Difference with previous patch is just to make it
new lines as it is too long for single line.

Feel free to give comments and suggestions. Thanks.

previous discussion here:
[1] https://lore.kernel.org/linux-mm/20221021030953.34925-1-quic_aiquny@quicinc.com/

Maria Yu (1):
  mm/page_isolation: fix clang deadcode warning

 mm/page_isolation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

