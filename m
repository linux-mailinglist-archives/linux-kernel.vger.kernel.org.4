Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5021709FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjESTJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjESTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:43 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFC10C6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:19 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JI24mN001398;
        Fri, 19 May 2023 19:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=UMdJ6dPRWg9qYBO+924mw4Sp9YYoC2nRG2nYkjyua60=;
 b=o/6BPIdmcGnULaL2UMNQ7Xhrg4JxtznEP69bTDZJyrKz7uCisppIBq8rWpgdDCfXWlLl
 rryVoDJYjGk5ImEeyP0EGkKEHgBvkeAlG8mTF9ukN7DeEv7PJfJT2XOdoSFVjZGoHF/C
 9tgFcDYqdIlT985llyU0TnDnCcV/kPkfRlfPlvO6mTP46hespnPAtuUWg8HOuWOvy5xg
 LScFvcwKjwfmDc+xDUyH9pVS72rtTGFrk/H/LVWHb/egd789WBVAuIhe5Q5A8lDNFPp+
 2yt8+aXPHPIdWlzNtZ4t3SwhGZvznOteDR7I4va7bZ/voyEUYCLbaUKJrZ/07Lx4k/Hz 4Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qp3xs5yag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:56 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CC2F1804DC5;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 29F90808736;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 567F53031304C; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 7/8] x86/platform/uv: Remove remaining BUG_ON() and BUG() calls
Date:   Fri, 19 May 2023 14:07:51 -0500
Message-Id: <20230519190752.3297140-8-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KlCvAKV32Pnum7iWRGr-vMdqa9utnj9q
X-Proofpoint-GUID: KlCvAKV32Pnum7iWRGr-vMdqa9utnj9q
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Replace BUG and BUG_ON with WARN_ON_ONCE and carry on as best as we
can.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 10d3bdf874a0..1836330ff7b3 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -617,7 +617,8 @@ static __init void build_uv_gr_table(void)
 
 	bytes = _gr_table_len * sizeof(struct uv_gam_range_s);
 	grt = kzalloc(bytes, GFP_KERNEL);
-	BUG_ON(!grt);
+	if (WARN_ON_ONCE(!grt))
+		return;
 	_gr_table = grt;
 
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
@@ -1548,7 +1549,8 @@ static void __init build_socket_tables(void)
 			return;
 		}
 		pr_err("UV: Error: UVsystab address translations not available!\n");
-		BUG();
+		WARN_ON_ONCE(!gre);
+		return;
 	}
 
 	numn = num_possible_nodes();
-- 
2.26.2

