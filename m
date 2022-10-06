Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA075F5F98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJFD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJFDZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:25:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B00FAE8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:24:23 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2963OCjD010359;
        Thu, 6 Oct 2022 03:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qREY61YDonaxY7QHfNEBxxtHhu6S9Pr7EFSQqHzt6Lo=;
 b=Tx4V/Cp38XnIKISvq3iTor3kVd9tFthWgBXw16ktZwnmAka900U5eGKQ3z1cvqLt3Hod
 w1DOy2bKE9vLEb9s8lbRk9zJqANF80il9R/R/DQxgNE3M80ZIHpqwgAa38Y3iO6dNxXs
 eFHWIkoq6abrT7xULLD6OCMkmjgFimIEvQwTh2O90LRnhXaw5oHeNJQ/1KNIktzyPITM
 hSKaV95HKxWo50RrExDEgGPxz4D7HGM6+wIvSdSAOg3lhqIj1gWhpAMHJwoJFHKGwbzv
 RTIZp0cldxwZWOCo+bnV77B1LKGCLdCJXjNtmeYEglufgj96gtCr9U4wxp9I7HUpb0fE nw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0hxpvkbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 03:24:12 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2963OB2F001703;
        Thu, 6 Oct 2022 03:24:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3k0q8tgxju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 03:24:11 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2963OBcS001698;
        Thu, 6 Oct 2022 03:24:11 GMT
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 2963OBgZ001695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 03:24:11 +0000
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 20:24:10 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 2/2] scripts/clang-tools: Remove core.uninitialized.Assign check
Date:   Wed, 5 Oct 2022 20:24:00 -0700
Message-ID: <edc9712e479c433471a5c6b14d3e7ede9c228f5c.1665026261.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
References: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xg43Hpf9ts3M07FU1tXOXMJpxvez7V_a
X-Proofpoint-ORIG-GUID: xg43Hpf9ts3M07FU1tXOXMJpxvez7V_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=927 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove this check as it leads to false positives in some cases (not all):

warning: Assigned value is garbage or undefined
[clang-analyzer-core.uninitialized.Assign]
      list_for_each_entry_safe(page, tmp_page, &pages, lru)
      ^

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 scripts/clang-tools/run-clang-tools.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index a72c4c7..714cb82 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -54,6 +54,7 @@ def run_analysis(entry):
         # List of checks to be excluded
         exclude = []
         exclude.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
+        exclude.append("-clang-analyzer-core.uninitialized.Assign")
 
         checks += ''.join(["," + e for e in exclude])
     p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
-- 
2.7.4

