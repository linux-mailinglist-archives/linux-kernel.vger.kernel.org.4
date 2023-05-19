Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26B709FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjESTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjESTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:42 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE36A10C0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:17 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JE0NVo031664;
        Fri, 19 May 2023 19:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=TT0BrqDjVdA3VHsClN80ASSbX1qXRCx5MBlvmm5IOtE=;
 b=cn/pi5qvF9mqLkHpcPGbMsa+Q90rMlvSSJ6xtRHvtHIkTTh3u91ZmQVLyTr3DxesPSX/
 b2bRI1ukwMlHWOBgVFW8h2e+q5A7Uxrbqb/1kLNzRbxWW4ZboZNGqWFkxVGtcknUcsir
 0BMi2Myq0HS4VxsAWyKaashwWdKWT27ToQtQYiQTeQhVJJGNpRrpX25BlfDu2j4oXtbT
 V4gAxR2ppeZ4iSOGp4zgnYcGodNb/bZTyEpPPFR6HjNGfia1LyRybfoH3wzhRqcM79/9
 36/iJiQexfMufuwz91wKfLXeI5ZRldAHPPO9xkFoC1i0ruAvulrI98KQf76yvSj4jPc6 3g== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qp1rnetga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E667E12E9A;
        Fri, 19 May 2023 19:07:53 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 78C208097FC;
        Fri, 19 May 2023 19:07:53 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 5111E30313048; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 4/8] x86/platform/uv: When searching for minimums, start at INT_MAX not 99999
Date:   Fri, 19 May 2023 14:07:48 -0500
Message-Id: <20230519190752.3297140-5-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cupTB5sazIprDdann-4dLOtLEvBMKSQg
X-Proofpoint-ORIG-GUID: cupTB5sazIprDdann-4dLOtLEvBMKSQg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=961 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

