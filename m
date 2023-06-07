Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EC725280
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjFGDoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjFGDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:44:21 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803AE19BD;
        Tue,  6 Jun 2023 20:44:15 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35705CMk010873;
        Wed, 7 Jun 2023 03:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=mgF+EFo73mChu0H94YLLm3hRHtASY83KiLWkFphr8vA=;
 b=cg572F2ZaFJFui+bP/yPQLmUAqLz+qKHzSetn5/y4rPJD2Rf1JSCxRTQ2YWJUu0ZBDGH
 ryzuuKYd5VJ5R4RHcQr0Z38iCNXDzxCBb8POwoMB5+THCJMHvWQqlj00Zp7hhvC6bT3Z
 dNUTHqr9R0enddqvYNhlsPDXjuwowHC176E+7T2BEWeX2LqLNbcrC5t68lpZ31glIdlf
 Kg4u9sqjP6l+BDzgGWVtmjXZz8zoOJVzkfEkU2a8aI2HmH13d5mXXuNu712XD/ZHFJQT
 Nu9ZIHr3iZOjjpirs1o7t73CEmaCETzGkdoGGQe9yvUrceA5NcNoCEHLSmtasH4iOq8Q dw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r2a8ak5nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 03:44:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D570D80022D;
        Wed,  7 Jun 2023 03:44:10 +0000 (UTC)
Received: from ILEIUN5Z4B.asiapacific.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 19EAE80B3A6;
        Wed,  7 Jun 2023 03:44:07 +0000 (UTC)
From:   James Liu <james.liu@hpe.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hpelk@lists.osp.hpe.com, james.liu@hpe.com
Subject: [PATCH v1] ACPI: reboot: Increase the delay to avoid racing after writing to ACPI RESET_REG on AMD Milan platforms.
Date:   Wed,  7 Jun 2023 11:44:03 +0800
Message-Id: <20230607034403.2885-1-james.liu@hpe.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0BWj7BAlMXdw-YolrWWncbPTmm4o2aFA
X-Proofpoint-ORIG-GUID: 0BWj7BAlMXdw-YolrWWncbPTmm4o2aFA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_01,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=904 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD Milan platforms, the delay of 15ms is insufficient to avoid racing
of reboot mechanisms. That said, the AMD Milan processors don't reboot
in 15ms after invoking acpi_reset().

The proposed 50ms delay can effectively work around this issue.
This extended delay aligns better with ACPI v6.4 (i.e., sec. 4.8.4.6),
which indicates that ideally OSPM should execute spin loops on the CPUs
in the system following a write to this register.

Signed-off-by: James Liu <james.liu@hpe.com>
---
 drivers/acpi/reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index b79b7c99c237..002f7c7814a1 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -78,5 +78,5 @@ void acpi_reboot(void)
 	 * The 15ms delay has been found to be long enough for the system
 	 * to reboot on the affected platforms.
 	 */
-	mdelay(15);
+	mdelay(50);
 }
-- 
2.40.1

