Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC5624909
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKJSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKJSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:06:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C10636F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:06:37 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAHkf4a031310;
        Thu, 10 Nov 2022 18:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DpmSL5sS3W0zss4QlY53Iu2CLIrD1N3OiphS+anrYJ0=;
 b=iL+IqVovsJwqo7vtj+O9bYLqc0ebwsq+tUIZOdZuyvc49Ly/owxdKw+WDtaCq012vT3j
 BjqqlycIw3SiDsMTZR+0Ox5uJgYcPCgeGEIok1gNZSjJ6VbsPNVYofGOvSRelgWN52VY
 0O1s2yFDG9DU3BLvbwAL6P80W3jRqi60P8mieZEZOQP52thVkjuTLzvLd45MfyFsM1JL
 a4qzt8hCydJVbRxINGhdiutXqBSvByX7Ct6pOE5SoOPzYLGB/SSfLH1rz81QwvyN9MZt
 fBeFWjM3csGggqV9sgxrpyiO6r/CrIIDKxHGZfzVaL1XprjsVj+IcFJ+Za4Wzsn5nlEE Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks60frk72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAHrNwx021422;
        Thu, 10 Nov 2022 18:06:26 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks60frk61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAI5lRw018865;
        Thu, 10 Nov 2022 18:06:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3kngpgnk07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAI6LqC39125706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:06:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1ABAAE04D;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985FCAE045;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc: export the CPU node count
Date:   Thu, 10 Nov 2022 19:06:18 +0100
Message-Id: <20221110180619.15796-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110180619.15796-1-ldufour@linux.ibm.com>
References: <20221110180619.15796-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lzqmg08Fi39zbCdtzGdQbZE8J7o24bL-
X-Proofpoint-ORIG-GUID: AbXjTEfTdajvO8aZ2mQQ9xwgJFU2Ousx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, the FDT is parsed to compute the number of CPUs.
In addition count the number of CPU nodes and export it.

This is useful when building the FDT for a kexeced kernel since we need to
take in account the CPU node added since the boot time during CPU hotplug
operations.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/include/asm/prom.h | 1 +
 arch/powerpc/kernel/prom.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 2e82820fbd64..c0107d8ddd8c 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -85,6 +85,7 @@ struct of_drc_info {
 extern int of_read_drc_info_cell(struct property **prop,
 			const __be32 **curval, struct of_drc_info *data);
 
+extern unsigned int boot_cpu_node_count;
 
 /*
  * There are two methods for telling firmware what our capabilities are.
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1eed87d954ba..645f4450dfc3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -72,6 +72,7 @@ int __initdata iommu_is_off;
 int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 u64 ppc64_rma_size;
+unsigned int boot_cpu_node_count __ro_after_init;
 #endif
 static phys_addr_t first_memblock_size;
 static int __initdata boot_cpu_count;
@@ -335,6 +336,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	boot_cpu_node_count++;
+
 	/* Get physical cpuid */
 	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
-- 
2.38.1

