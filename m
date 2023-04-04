Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3D6D6EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjDDVPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjDDVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:12 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A724C13
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:05 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334L23OG009526;
        Tue, 4 Apr 2023 21:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=i3YXDfMP+UH9NTSWYzAJ6EiweJ7Xf7At9N6j69CwHqw=;
 b=dplI7skgEzgkhnfgLsdinda4Femu206V+sCvwOKFlPyyvaqkAiW40yhaGlhfaFku2NX9
 FnBjRj7HyaHwTO5n5JRxGfS7m03XLDqVZKIDE5QcF4hWcG0xKhTaZt2A6VUxdAnaLAdl
 CQ02UfCNBCOCn2iU+DcSGYVyWlzk4vCPmyD0NXwMtm4ImkFqecf6LRqDTsPLCO9xuNVK
 EOS2LaN6f/wdmPlqnqdUWghbq9ercpD5FAiKAL1FxOrnROuj/vEk2DpBEurmtBl10e5a
 MiYAq/nZVSpVpbQY7ieCb2vm2hYDPPQ3eJqPn52qcrjEsCDGcsKzp0oWK0P8jF/cE+1G Gw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3prttu8bud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:35 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B67F41304B;
        Tue,  4 Apr 2023 21:14:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 3647C816652;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 00A6830313045; Tue,  4 Apr 2023 16:14:31 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] x86/platform/uv: Fix printed information in calc_mmioh_map
Date:   Tue,  4 Apr 2023 16:14:26 -0500
Message-Id: <20230404211431.776248-4-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404211431.776248-1-steve.wahl@hpe.com>
References: <20230404211431.776248-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: blqDZEJEb3-GVFOom763VjjORKZqTu5i
X-Proofpoint-ORIG-GUID: blqDZEJEb3-GVFOom763VjjORKZqTu5i
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040193
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect mask names and values in calc_mmioh_map() that caused it
to print wrong NASID information. And an unused blade position is not
an error condition, but will yield an invalid NASID value, so change
the invalid NASID message from an error to a debug message.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 482855227964..6d2739eadb71 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1022,7 +1022,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 	switch (index) {
 	case UVY_MMIOH0:
 		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0;
-		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+		nasid_mask = UVYH_RH10_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
 		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
 		min_nasid = min_pnode;
 		max_nasid = max_pnode;
@@ -1030,7 +1030,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVY_MMIOH1:
 		mmr = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1;
-		nasid_mask = UVH_RH10_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		nasid_mask = UVYH_RH10_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
 		n = UVH_RH10_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
 		min_nasid = min_pnode;
 		max_nasid = max_pnode;
@@ -1038,7 +1038,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVX_MMIOH0:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0;
-		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
+		nasid_mask = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
 		min_nasid = min_pnode * 2;
 		max_nasid = max_pnode * 2;
@@ -1046,7 +1046,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 		break;
 	case UVX_MMIOH1:
 		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1;
-		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
+		nasid_mask = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
 		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_DEPTH;
 		min_nasid = min_pnode * 2;
 		max_nasid = max_pnode * 2;
@@ -1072,8 +1072,9 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 
 		/* Invalid NASID check */
 		if (nasid < min_nasid || max_nasid < nasid) {
-			pr_err("UV:%s:Invalid NASID:%x (range:%x..%x)\n",
-				__func__, index, min_nasid, max_nasid);
+			/* Not an error: unused table entries get "poison" values */
+			pr_debug("UV:%s:Invalid NASID(%x):%x (range:%x..%x)\n",
+			       __func__, index, nasid, min_nasid, max_nasid);
 			nasid = -1;
 		}
 
-- 
2.26.2

