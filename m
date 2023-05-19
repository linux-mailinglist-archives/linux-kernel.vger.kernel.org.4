Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45172709FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjESTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjESTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:37 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3510F5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:13 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JIogLR021319;
        Fri, 19 May 2023 19:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=BJHA943ji6p+WFfL+5qIIveTVtDXjl/o6BKXr5YMnh8=;
 b=W6ZTrPALWbpgUvupKx0CVsYIhxqABYgTsZJEly9Qf+xUOpBzWZ9OaPCamd1/tNsMsXbb
 56EFNw9dEBJCB+izJ2z85QYHIBXKK+2mFDsrsVLfCREky7JWK5KeCvqA2yXWCYA/QhbP
 B1GwtrLCKVrCf/hXYFnvjniY8vmDEWsRUMPZlfv2RlijJX3BWoicIjxMqd6H6zORC97l
 REsM+sOwtN7BZGsArU7ufNdSNk5fK3Xf0Imy0+nW6d9jEu1lzQQy5tT7TejvmnzHfoqs
 dovkvSNMj0wXlrVNWT+d4XoocwE+UzM0EKClMEvGygXPKBG/jGKV857u+kKvnYkX0LT1 Kw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qper4r3k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E621A130CA;
        Fri, 19 May 2023 19:07:53 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6E5C6809A8E;
        Fri, 19 May 2023 19:07:53 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 4EBFC30062B3A; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 1/8] x86/platform/uv: Add platform resolving #defines for misc GAM_MMIOH_REDIRECT*
Date:   Fri, 19 May 2023 14:07:45 -0500
Message-Id: <20230519190752.3297140-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SVPTaRkHV4nP6xQLgNnm2jDGUjkqQQuX
X-Proofpoint-GUID: SVPTaRkHV4nP6xQLgNnm2jDGUjkqQQuX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=965 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

