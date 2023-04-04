Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8A6D6EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjDDVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjDDVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:10 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9414691
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:06 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KMqXn020217;
        Tue, 4 Apr 2023 21:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=TT0BrqDjVdA3VHsClN80ASSbX1qXRCx5MBlvmm5IOtE=;
 b=Nue+P2ehAssGsPSjhiJEd3czq2hBvuvjgZ04zDerwTDoPVs+UdC8RmgAR9c179NyKz16
 oDoOx1xDiLIfcDN08GV9/195BEg0IPBzFfPDTt5DrXhArIyGgeI4gOGR/AUucR9IU6sw
 FUbZsPKAv2sZp5xSDKzoK2wQVRPGj9jFNIIoWfWWrUfJrkEeNd9VHC07W4dSZFgRprPC
 wHeMD4svZYusILyCD8vd1NUP+4bfv9/dX8E3CNvpO3/5ZdpKNgJ6EL/3RhWE6bN1xOWW
 Q2hmisHtL+bNYJ107BmehYEV43E22FOAH3qfun14iD4GkCyujguMs3dZURFD1ZrjjKPF Fw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3prtvegbck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:34 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BA94E130AB;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 1CD08815C22;
        Tue,  4 Apr 2023 21:14:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 0468B30313048; Tue,  4 Apr 2023 16:14:32 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] x86/platform/uv: When searching for minimums, start at INT_MAX not 99999
Date:   Tue,  4 Apr 2023 16:14:27 -0500
Message-Id: <20230404211431.776248-5-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404211431.776248-1-steve.wahl@hpe.com>
References: <20230404211431.776248-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zU0F16GCrc-VISM4wMmX2iBHjGSjINCP
X-Proofpoint-ORIG-GUID: zU0F16GCrc-VISM4wMmX2iBHjGSjINCP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=971
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040193
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a starting value of INT_MAX rather than 999999 or 99999 means
this algorithm won't fail should the numbers being compared ever
exceed this value.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 6d2739eadb71..2da84befabf0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1349,7 +1349,7 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
 	unsigned long lgre = 0, gend = 0;
 	int index = 0;
-	int sock_min = 999999, pnode_min = 99999;
+	int sock_min = INT_MAX, pnode_min = INT_MAX;
 	int sock_max = -1, pnode_max = -1;
 
 	uv_gre_table = gre;
@@ -1694,7 +1694,7 @@ static void __init uv_system_init_hub(void)
 {
 	struct uv_hub_info_s hub_info = {0};
 	int bytes, cpu, nodeid;
-	unsigned short min_pnode = 9999, max_pnode = 0;
+	unsigned short min_pnode = USHRT_MAX, max_pnode = 0;
 	char *hub = is_uv5_hub() ? "UV500" :
 		    is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
-- 
2.26.2

