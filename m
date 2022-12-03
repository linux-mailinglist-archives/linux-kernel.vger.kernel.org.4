Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F5641471
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLCGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLCGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:11:08 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A9BEE1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:11:02 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NPKF10MTrz4y0v7;
        Sat,  3 Dec 2022 14:11:01 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2B36As15085164;
        Sat, 3 Dec 2022 14:10:54 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 3 Dec 2022 14:10:56 +0800 (CST)
Date:   Sat, 3 Dec 2022 14:10:56 +0800 (CST)
X-Zmail-TransId: 2b04638ae870232ee8c4
X-Mailer: Zmail v1.0
Message-ID: <202212031410566533649@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <geert@linux-m68k.org>
Cc:     <gerg@linux-m68k.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG02OGs6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B36As15085164
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638AE875.000 by FangMail milter!
X-FangMail-Envelope: 1670047861/4NPKF10MTrz4y0v7/638AE875.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638AE875.000/4NPKF10MTrz4y0v7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 arch/m68k/kernel/setup_no.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index cb6def585851..37fb663559b4 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -90,8 +90,7 @@ void __init setup_arch(char **cmdline_p)
 	config_BSP(&command_line[0], sizeof(command_line));

 #if defined(CONFIG_BOOTPARAM)
-	strncpy(&command_line[0], CONFIG_BOOTPARAM_STRING, sizeof(command_line));
-	command_line[sizeof(command_line) - 1] = 0;
+	strscpy(&command_line[0], CONFIG_BOOTPARAM_STRING, sizeof(command_line));
 #endif /* CONFIG_BOOTPARAM */

 	process_uboot_commandline(&command_line[0], sizeof(command_line));
-- 
2.15.2
