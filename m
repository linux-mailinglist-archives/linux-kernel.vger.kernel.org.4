Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F316D6EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjDDVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjDDVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440149DE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:07 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334L2OUm011267;
        Tue, 4 Apr 2023 21:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=BJHA943ji6p+WFfL+5qIIveTVtDXjl/o6BKXr5YMnh8=;
 b=lKq6xQu16UYYqXESCBJV25i/8da8rgn1uGOt82uqvZBbDyrtOR5y8MVwYNcM/UeVRaQL
 /vhH1eUHJAGIpGibB9zMzb5IrixINx1MgRs85Slb2Jv2rm2dSLApbkcz2QNK5TegNkTb
 edHcjbgH/c3uOHit2hgumlFAoU1aORKkQoME1BEOLNmASZNWR2i6ruMFhd8JLXpbd/gt
 NrlbfNCQxU3+97q3b29/ztvxHRuR6U/xu7txYJSior1IoAA1GBf4DAlTYzSoK2Y5iheS
 EDepxISSS1JK7ng48Fp/HRzdmXR1c0c2A0ToNGVuSZOrxgkwXqYXhyhc+V1KKZVP78EI QQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3prnwpb2tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:34 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1292A80025F;
        Tue,  4 Apr 2023 21:14:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A35BE80AB06;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id F24AC30062B11; Tue,  4 Apr 2023 16:14:31 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] x86/platform/uv: Add platform resolving #defines for misc GAM_MMIOH_REDIRECT*
Date:   Tue,  4 Apr 2023 16:14:24 -0500
Message-Id: <20230404211431.776248-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404211431.776248-1-steve.wahl@hpe.com>
References: <20230404211431.776248-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6eiDwa7ZVqrg9ZozHHgntQGk6-WYErCy
X-Proofpoint-GUID: 6eiDwa7ZVqrg9ZozHHgntQGk6-WYErCy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=977 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040193
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming changes will require use of new #defines
UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK and
UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK, which provide the
appropriate values on different uv platforms.

Also, fix typo that defined a couple of "*_CONFIG0_*" values twice
where "*_CONFIG1_*" was intended.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_mmrs.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 57fa67373262..bb45812889dd 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -4199,6 +4199,13 @@ union uvh_rh_gam_mmioh_overlay_config1_u {
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_SHFT	0
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK	0x0000000000007fffUL
 
+/* UVH common defines */
+#define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK (			\
+	is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	is_uv(UV4)  ?  UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	is_uv(UV3)  ?  UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :	\
+	0)
+
 
 union uvh_rh_gam_mmioh_redirect_config0_u {
 	unsigned long	v;
@@ -4247,8 +4254,8 @@ union uvh_rh_gam_mmioh_redirect_config0_u {
 	0)
 
 /* UV4A unique defines */
-#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_SHFT	0
-#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK	0x0000000000000fffUL
+#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
+#define UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK	0x0000000000000fffUL
 
 /* UV4 unique defines */
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
@@ -4258,6 +4265,13 @@ union uvh_rh_gam_mmioh_redirect_config0_u {
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_SHFT	0
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK	0x0000000000007fffUL
 
+/* UVH common defines */
+#define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK (			\
+	is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	is_uv(UV4)  ?  UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	is_uv(UV3)  ?  UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :	\
+	0)
+
 
 union uvh_rh_gam_mmioh_redirect_config1_u {
 	unsigned long	v;
-- 
2.26.2

