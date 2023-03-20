Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975446C2569
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCTXGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCTXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:06:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFEE34F6C;
        Mon, 20 Mar 2023 16:06:02 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KLhc3O012069;
        Mon, 20 Mar 2023 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=/axE91rUg/cJj4LJMDVEwCwWQ5EZAkcEoYjeNyf1wIk=;
 b=JDeNfhBFRy0/5ZPXqmZxo6nnWgQw8LiXU0Tt/qNX1LFqj3/znE+DVgP97ZEdJxVK5gzP
 PL4U6PWrCC3b4hjFYk74mgmBKTuVKhE8Mq+WqdzwCtm+gpn+ulo1WKKu5hds9MBUalv2
 Z0KCdktfN1q0hUiSVC5CCl6YHrdVMPUwTm3DkfIpuX73JVl7U0FoTz/ikvxQlVEq0DyZ
 7urhil97gfHBqgsszWw8YUi/3Xh3NUOx/29A6Wzapa4z+8Kp7GaPfCpTL4rGNaIUheJb
 Jzt7g8JU3piBjmUtrLsrQZlqYcsqGVQhWKTYRcfGZVLFTshFetxTklHfoS6JGLiRfJvp Kw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pest044rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:06:01 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KLVcNo017002;
        Mon, 20 Mar 2023 23:06:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pd4jfb881-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 23:06:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KN5vW320578838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 23:05:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 794B220043;
        Mon, 20 Mar 2023 23:05:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE2462004E;
        Mon, 20 Mar 2023 23:05:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 23:05:56 +0000 (GMT)
Received: from bgray-lenovo-p15.ibm.com (unknown [9.177.79.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 42948600F5;
        Tue, 21 Mar 2023 10:05:51 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH] init/initramfs: Fix argument forwarding to panic() in panic_show_mem()
Date:   Tue, 21 Mar 2023 10:05:34 +1100
Message-Id: <20230320230534.50174-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ww-6Jq3H909M665UBrFCdaSd7ClcJV7y
X-Proofpoint-ORIG-GUID: Ww-6Jq3H909M665UBrFCdaSd7ClcJV7y
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding variadic argument lists can't be done by passing a va_list
to a function with signature foo(...) (as panic() has). It ends up
interpreting the va_list itself as a single argument instead of
iterating it. printf() happily accepts it of course, leading to corrupt
output.

Convert panic_show_mem() to a macro to allow forwarding the arguments.
The function is trivial enough that it's easier than trying to introduce
a vpanic() variant.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---

After sending these patches [1] I wondered why the kernel accepted a
corrupt archive. The streaming parser makes it difficult to see
where to add a completeness check (possibly can assert the state is
Start or Reset at the end?), but adding an error() to cover my issue
revealed that the error message was never printed.

[1]: https://lore.kernel.org/all/20230320040839.660475-1-bgray@linux.ibm.com/
---
 init/initramfs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index f6c112e30bd4..e7a01c2ccd1b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -60,15 +60,8 @@ static void __init error(char *x)
 		message = x;
 }
 
-static void panic_show_mem(const char *fmt, ...)
-{
-	va_list args;
-
-	show_mem(0, NULL);
-	va_start(args, fmt);
-	panic(fmt, args);
-	va_end(args);
-}
+#define panic_show_mem(fmt, ...) \
+	({ show_mem(0, NULL); panic(fmt, ##__VA_ARGS__); })
 
 /* link hash */
 

base-commit: 065ffaee73892e8a3629b4cfbe635697807a3c6f
prerequisite-patch-id: 6e3cfc6bf9c5686ad29c7feed8e283d30b1957fd
prerequisite-patch-id: 933a7bd2f29223dba7f2cac7e9aa72aae730292d
-- 
2.39.2

