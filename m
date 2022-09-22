Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6675E6BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiIVTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiIVTih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:38:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F010B232;
        Thu, 22 Sep 2022 12:38:32 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MIlMRJ009291;
        Thu, 22 Sep 2022 19:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a2ZHrjSOmetjLTAzI4FxKlACz/dALJaSDE7BGJpKrAk=;
 b=JQwt2ycrhazHtj6wVpCa2HFZgsEpf9qvhR0cjbK1JHT6itvGfuKwEr+YY+SULO7uPe8k
 0ZwXF3iipeM+BjLlOZ+gLx8s1J+wVNCIz3qa63JaFbMeS2dzo+/ZMxcE3A7NE/QTdDXi
 LMRmGgTcntbDsIBzL2/6HS0SvUikY939MOtPREc3pMc8IjWIeJj18fzVY3kq1wph7KSf
 GC2n1ZEWOSO+/TbotEAc1ip0qMy1OTvTBRJH/ycrWM5MT9XquW6uUqh3Zjth7QSTHWTg
 XBdKRreEsDZ9aWr63neweilCM/9qP0IxhuwXg0RDFVJLAzenuCc3MxKKzGBGcnltzUQG tA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrvtrjhuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:38:20 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MJadJ2007777;
        Thu, 22 Sep 2022 19:38:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3jn5v9txpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:38:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MJcJrx4457106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 19:38:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A66D5803F;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5678158061;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmorris@namei.org, mpe@ellerman.id.au, paul@paul-moore.com,
        serge@hallyn.com, ajd@linux.ibm.com, gcwilson@linux.ibm.com,
        nayna@linux.ibm.com
Subject: [PATCH 1/2] powerpc/pseries: block untrusted device tree changes when locked down
Date:   Thu, 22 Sep 2022 14:38:16 -0500
Message-Id: <20220922193817.106041-2-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922193817.106041-1-nathanl@linux.ibm.com>
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yPTDTIhBVKuhg-hbW0Np0JmBchhm2y1l
X-Proofpoint-GUID: yPTDTIhBVKuhg-hbW0Np0JmBchhm2y1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/powerpc/ofdt interface allows the root user to freely alter
the in-kernel device tree, enabling arbitrary physical address writes
via drivers that could bind to malicious device nodes, thus making it
possible to disable lockdown.

Historically this interface has been used on the pseries platform to
facilitate the runtime addition and removal of processor, memory, and
device resources (aka Dynamic Logical Partitioning or DLPAR). Years
ago, the processor and memory use cases were migrated to designs that
happen to be lockdown-friendly: device tree updates are communicated
directly to the kernel from firmware without passing through untrusted
user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
remains the sole legitimate user of /proc/powerpc/ofdt, but it is
already broken in lockdown since it uses /dev/mem to allocate argument
buffers for the rtas syscall. So only illegitimate uses of the
interface should see a behavior change when running on a locked down
kernel.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
 include/linux/security.h                  | 1 +
 security/security.c                       | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index cad7a0c93117..599bd2c78514 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -361,6 +362,10 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
 	char *kbuf;
 	char *tmp;
 
+	rv = security_locked_down(LOCKDOWN_DEVICE_TREE);
+	if (rv)
+		return rv;
+
 	kbuf = memdup_user_nul(buf, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..1ca8dbacd3cc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -122,6 +122,7 @@ enum lockdown_reason {
 	LOCKDOWN_XMON_WR,
 	LOCKDOWN_BPF_WRITE_USER,
 	LOCKDOWN_DBG_WRITE_KERNEL,
+	LOCKDOWN_DEVICE_TREE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/security.c b/security/security.c
index 4b95de24bc8d..2863fc31eec6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -60,6 +60,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_XMON_WR] = "xmon write access",
 	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
+	[LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
-- 
2.37.3

