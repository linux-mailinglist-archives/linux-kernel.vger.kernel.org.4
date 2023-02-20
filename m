Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240C69C4EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBTFYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBTFY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:24:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14616D509
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:24:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K4fjEr023488;
        Mon, 20 Feb 2023 05:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uFyLlrrpU4udXtdDccdTtgT062VruvZ1i2ZTSd7SEO0=;
 b=l7R056qKf6SxjqJLsVfZAoPFcr4EpGyd+V1qkrJsABwuJ7BaZAw5rVXHoJTUkg0CtoQK
 5eToMtC2rfMIVuZbRN8V4ajVIe8zi5O0PPaLyImkE/YE1us1rMwGg2UTtZbbNwqa4xdS
 I8TsCvB1sfDlHnhGLONdvY2jm6vlT84wQUlN2p0XX9xbqsTQvEm/f52RmG7kP3z6V2nw
 xXLX+rQ7kMIpODjQ3CqPZYRz2rAbCEiW9aZoUyHhLij+8LDKunJm+mnwbM1NZEmKMaxc
 Y+7JDC5q5QO6uTKIOj5G/WmR2j1vMo9YQmt+n82kcg2ReixAJFDn3UZO/kr2k0dVb8yi pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv22e0u2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:16 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31K55eop007242;
        Mon, 20 Feb 2023 05:24:16 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv22e0u1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JK18TI026612;
        Mon, 20 Feb 2023 05:24:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf267t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31K5OAkG43909430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 05:24:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE252004B;
        Mon, 20 Feb 2023 05:24:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C37FE20043;
        Mon, 20 Feb 2023 05:24:07 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.in.ibm.com (unknown [9.109.216.99])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 05:24:07 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH 1/2] arch/powerpc/kvm: kvmppc_hv_entry: remove .global scope
Date:   Mon, 20 Feb 2023 10:53:54 +0530
Message-Id: <20230220052355.109033-2-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230220052355.109033-1-kconsul@linux.vnet.ibm.com>
References: <20230220052355.109033-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mefHSiXT74Wnp9ZGcGHdjNRpb03ZpB7K
X-Proofpoint-GUID: 0z_rvfVf9VLuP4ikrzRDhN6Xudd8F5iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_02,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmppc_hv_entry isn't called from anywhere other than
book3s_hv_rmhandlers.S itself. Removing .global scope for
this function.

Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index acf80915f406..7e063fde7adc 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -502,7 +502,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  *                                                                            *
  *****************************************************************************/
 
-.global kvmppc_hv_entry
 kvmppc_hv_entry:
 
 	/* Required state:
-- 
2.31.1

