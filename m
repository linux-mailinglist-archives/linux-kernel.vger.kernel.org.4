Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9565F9F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjAFDJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFDJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:09:52 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C661302;
        Thu,  5 Jan 2023 19:09:47 -0800 (PST)
X-UUID: e61e0c375c4c44d18ad8c0e2949f8c61-20230106
X-CPASD-INFO: d01806789bfc403fbe00a7c65ba0d0cc@rYBrWF1oZWhlgqivg3N-oIKWYGCSY4O
        Fd5yBYJJgj4OVhH5xTV5nX1V9gnNXZF5dXFV3dnBQY2BhXVJ3i3-XblBgXoZgUZB3s3JrWGBkZw==
X-CLOUD-ID: d01806789bfc403fbe00a7c65ba0d0cc
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:197.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:102.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:8,DUF:11735,ACD:193,DCD:193,SL:0,EISP:0,AG:0,CFC:0.139,CFSR:0.205,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: e61e0c375c4c44d18ad8c0e2949f8c61-20230106
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: e61e0c375c4c44d18ad8c0e2949f8c61-20230106
X-User: xurui@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xurui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 889724476; Fri, 06 Jan 2023 11:09:46 +0800
From:   xurui <xurui@kylinos.cn>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        xurui <xurui@kylinos.cn>
Subject: [RFC] MIPS: Fix a compilation issue
Date:   Fri,  6 Jan 2023 11:09:56 +0800
Message-Id: <20230106030956.1589041-1-xurui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/include/asm/mach-rc32434/pci.h:377:
cc1: error: result of ‘-117440512 << 16’ requires 44 bits to represent, but ‘int’ only has 32 bits [-Werror=shift-overflow=]

I guss we don`t need a left shift here?

Signed-off-by: xurui <xurui@kylinos.cn>
---
 arch/mips/include/asm/mach-rc32434/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-rc32434/pci.h b/arch/mips/include/asm/mach-rc32434/pci.h
index 9a6eefd12757..3eb767c8a4ee 100644
--- a/arch/mips/include/asm/mach-rc32434/pci.h
+++ b/arch/mips/include/asm/mach-rc32434/pci.h
@@ -374,7 +374,7 @@ struct pci_msu {
 				 PCI_CFG04_STAT_SSE | \
 				 PCI_CFG04_STAT_PE)
 
-#define KORINA_CNFG1		((KORINA_STAT<<16)|KORINA_CMD)
+#define KORINA_CNFG1		(KORINA_STAT | KORINA_CMD)
 
 #define KORINA_REVID		0
 #define KORINA_CLASS_CODE	0
-- 
2.25.1

