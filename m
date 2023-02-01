Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3FF67B9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAYSzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Jan 2023 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjAYSzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:55:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00186C15A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:54:59 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGPjQU019302
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:54:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3najv1qt5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:54:59 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 10:54:57 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 65B4C1469A25A; Wed, 25 Jan 2023 10:54:48 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
        <live-patching@vger.kernel.org>
CC:     <x86@kernel.org>, Song Liu <song@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v11 1/2] x86/module: remove unused code in __apply_relocate_add
Date:   Wed, 25 Jan 2023 10:54:00 -0800
Message-ID: <20230125185401.279042-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fbMq_g4eyq7aPdPwM8aejIn-BH-m8SQz
X-Proofpoint-ORIG-GUID: fbMq_g4eyq7aPdPwM8aejIn-BH-m8SQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "#if 0" block has been untouched for many years. Remove it to clean
up the code.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/x86/kernel/module.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 705fb2a41d7d..1dee3ad82da2 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -188,10 +188,6 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 				goto invalid_relocation;
 			val -= (u64)loc;
 			write(loc, &val, 4);
-#if 0
-			if ((s64)val != *(s32 *)loc)
-				goto overflow;
-#endif
 			break;
 		case R_X86_64_PC64:
 			if (*(u64 *)loc != 0)
-- 
2.30.2

