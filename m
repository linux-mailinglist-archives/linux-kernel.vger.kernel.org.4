Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7F6A1971
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBXKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjBXKDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80F2056A;
        Fri, 24 Feb 2023 02:03:18 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O9w2qY009527;
        Fri, 24 Feb 2023 10:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=trFYP0PnNot8TMUWiErzzeZJiH8yUsglQJeJ3IvVbC4=;
 b=bAOGPmVeZ6sLZSU7kBmliNKjMVYWyyYfyWCoTflcQvxgmfySq0+KuAhndVEjpYoEVPR3
 Cx0soh949BCrlajKbZQClGVRUYXJSN0br16GGG6voxW2MguWgEqr7LwAx6uHrCUfDdrM
 cWGZqW2kakgNXCWRN4Zw0UqfzqA0WU7Y/DwhK5XlsWbtCIG/8d08Cvn98nTbs9qS/gaq
 rL66S109s9LfTMJPrQ/XCrMzHLBrVPr1YpfpphOqQ+3v9VpoSJz/IDZPbk4oeRbN0jKw
 CaNw5iNq7pc5YI95uMA/gdisHFiAhspXUL915UeXIEHBr0w3HkfrtqzRep5+OxxBd9tI 0g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxu2jg33d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NNYCl9016621;
        Fri, 24 Feb 2023 10:02:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6ft24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31OA2dL430343522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 10:02:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0E320065;
        Fri, 24 Feb 2023 10:02:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A53F12006C;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] s390/cpum_sf: use READ_ONCE_ALIGNED_128() instead of 128-bit cmpxchg
Date:   Fri, 24 Feb 2023 11:02:37 +0100
Message-Id: <20230224100237.3247871-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230224100237.3247871-1-hca@linux.ibm.com>
References: <20230224100237.3247871-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HGxbm_HP7eCJEvj9vuch5ar-u2Z0bv9-
X-Proofpoint-ORIG-GUID: HGxbm_HP7eCJEvj9vuch5ar-u2Z0bv9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_06,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use READ_ONCE_ALIGNED_128() to read the previous value in front of a
128-bit cmpxchg loop, instead of (mis-)using a 128-bit cmpxchg operation to
do the same.

This makes the code more readable and is faster.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 79904a839fb9..e7b867e2f73f 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1355,8 +1355,7 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		num_sdb++;
 
 		/* Reset trailer (using compare-double-and-swap) */
-		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
@@ -1558,8 +1557,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 	struct hws_trailer_entry *te;
 
 	te = aux_sdb_trailer(aux, alert_index);
-	/* READ_ONCE() 16 byte header */
-	prev.val = __cdsg(&te->header.val, 0, 0);
+	prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 	do {
 		old.val = prev.val;
 		new.val = prev.val;
@@ -1637,8 +1635,7 @@ static bool aux_reset_buffer(struct aux_buffer *aux, unsigned long range,
 	idx_old = idx = aux->empty_mark + 1;
 	for (i = 0; i < range_scan; i++, idx++) {
 		te = aux_sdb_trailer(aux, idx);
-		/* READ_ONCE() 16 byte header */
-		prev.val = __cdsg(&te->header.val, 0, 0);
+		prev.val = READ_ONCE_ALIGNED_128(te->header.val);
 		do {
 			old.val = prev.val;
 			new.val = prev.val;
-- 
2.37.2

