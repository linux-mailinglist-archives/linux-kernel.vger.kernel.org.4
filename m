Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC016D6EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjDDVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjDDVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:09 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53D49D6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:05 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Kek2K004693;
        Tue, 4 Apr 2023 21:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=rw11ZEDdVmZVNnDftNTm7kbEAWM1cLoAsbf4DeGCg54=;
 b=YAA/aOx6hq9qQgZr3EeT/CMedwyQg3vKqgVomNYxqgDDN7TCHNXfbagVwyY8+k3AMdcL
 Tlg6Xwsq+/BHdCS+OeFke2lW4bufuObyqDUMAzujk/uKwndzBRqNFo1upLXA6HvVDCPa
 7fuESsjvSbJAFkyxtd2js0dMKsNSvQ4sq+tJraJrBaCc3ouFng5zQLsy6cuqviyAsR9g
 9cO2hk7OEbcKuJpQD61kG/iHTW7THF2VaZBqrc3sDbd4lkP1+4RnJkVMYcKacfWLbKC4
 p4CjF8Pha9UC4f/9MH+9KQMapht6FPgtFyYJCDNcVF7Brlc5CqkEJgm9+4CdKP3zmO6O 3Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3prtvegbcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:34 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E121C13060;
        Tue,  4 Apr 2023 21:14:33 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2F4D780D6A3;
        Tue,  4 Apr 2023 21:14:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id F2E3730313040; Tue,  4 Apr 2023 16:14:31 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] x86/platform/uv: Introduce helper function uv_pnode_to_socket.
Date:   Tue,  4 Apr 2023 16:14:25 -0500
Message-Id: <20230404211431.776248-3-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404211431.776248-1-steve.wahl@hpe.com>
References: <20230404211431.776248-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _riF_xFxE9MV_VdrSf_Rp_drw8qYdC0n
X-Proofpoint-ORIG-GUID: _riF_xFxE9MV_VdrSf_Rp_drw8qYdC0n
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=749
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

Add and use uv_pnode_to_socket() function, which parallels other
helper functions in here, and will enable avoiding duplicate code
in an upcoming patch.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index d3e3197917be..0acfd1734c8b 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -519,18 +519,24 @@ static inline int uv_socket_to_node(int socket)
 	return _uv_socket_to_node(socket, uv_hub_info->socket_to_node);
 }
 
+static inline int uv_pnode_to_socket(int pnode)
+{
+	unsigned short *p2s = uv_hub_info->pnode_to_socket;
+
+	return p2s ? p2s[pnode - uv_hub_info->min_pnode] : pnode;
+}
+
 /* pnode, offset --> socket virtual */
 static inline void *uv_pnode_offset_to_vaddr(int pnode, unsigned long offset)
 {
 	unsigned int m_val = uv_hub_info->m_val;
 	unsigned long base;
-	unsigned short sockid, node, *p2s;
+	unsigned short sockid, node;
 
 	if (m_val)
 		return __va(((unsigned long)pnode << m_val) | offset);
 
-	p2s = uv_hub_info->pnode_to_socket;
-	sockid = p2s ? p2s[pnode - uv_hub_info->min_pnode] : pnode;
+	sockid = uv_pnode_to_socket(pnode);
 	node = uv_socket_to_node(sockid);
 
 	/* limit address of previous socket is our base, except node 0 is 0 */
-- 
2.26.2

