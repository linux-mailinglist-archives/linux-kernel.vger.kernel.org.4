Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C036057E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJTHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJTHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:07:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231414C534;
        Thu, 20 Oct 2022 00:07:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K6bZkH031911;
        Thu, 20 Oct 2022 07:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q0IYKObOpZMNiqFVVVJy1j3P8SAwe0uiRVGDkJEZCiI=;
 b=NwiZr1Blw3fofugcqktYfpugtUPG+d4JBVdhHH/qgVIVyfeh9379+5kxXZvNdSGHbKz6
 89v87YoCxDB1O4rSgZOLkBO19tCwavkw0Su7tJwmXCzoKGZSPMwLA/V4H0Rl4yebpf/4
 GVyrvPlbsym4S7oB6G/EyxhP4EauqTgJx5ZTkt49n4ZlUn7gRTDfONQJBqtQX1gXjc24
 XOM/4srKyxCoQFUft0TlPMylJLLib8suInilK6qZHTtLVFafH/mdw9ysaOPGlc2zUaml
 n6tJF0ML0kHpHro1BMp8mbYXx+S3julCfXbm+DBtmXGimVuPR0d8U79oS1kfBS7v1Tr0 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kawfaeaw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:07:33 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29K6vm7v025380;
        Thu, 20 Oct 2022 07:07:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kawfae9u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:07:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K75PXf018395;
        Thu, 20 Oct 2022 07:07:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg98erk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:07:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K772UJ39912032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:07:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8D6552051;
        Thu, 20 Oct 2022 07:07:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.147])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9166B5204E;
        Thu, 20 Oct 2022 07:06:58 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org
Cc:     irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH] [perf/core: Update sample_flags for raw_data in perf_output_sample
Date:   Thu, 20 Oct 2022 12:36:56 +0530
Message-Id: <20221020070657.21571-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nbFTTCCZ7TptiYILTpnzocmdoF73hjwb
X-Proofpoint-GUID: FALzTCHsWx16XgiUS273CkyFJ2I0yCaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
added check for PERF_SAMPLE_RAW in sample_flags in
perf_prepare_sample(). But while copying the sample in memory,
the check for sample_flags is not added in perf_output_sample().
Fix adds the same in perf_output_sample as well.

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..daf387c75d33 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7099,7 +7099,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_RAW) {
 		struct perf_raw_record *raw = data->raw;
 
-		if (raw) {
+		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
 			struct perf_raw_frag *frag = &raw->frag;
 
 			perf_output_put(handle, raw->size);
-- 
2.31.1

