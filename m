Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291E66E3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjAQQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAQQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:38:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E161303CD;
        Tue, 17 Jan 2023 08:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27951614DB;
        Tue, 17 Jan 2023 16:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263ABC433D2;
        Tue, 17 Jan 2023 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673973518;
        bh=K6sp7vxwz2kbyJDM0TQqlfRJA30AWKr6mOQv83dI0PA=;
        h=From:To:Cc:Subject:Date:From;
        b=Wfs8Li5beijwB4/pPLy54lafHB/pKGjIBEDJqNJykOC0XG7rusmyBtaWLETWAGofy
         iDG2fPKsnqZYSgdCdoxcYOP84l4oIvbEHcv4vI23t+amVbLbhWA2ewK0tvfAUDpbIZ
         qaLOKpM2kvCzH0nxGXt6ATu/J7NMSKj1ZZM5mpsY3peQASWh+cS6iDI9RlgTAeLIxo
         XCy2iHVSmDQq4nQGHuCpE5AAEaakJ/GUKKjjQnweunX/D5UArtHUKFioUHDlXA3Pr9
         s4wFY/NeVhKCJQcHotuuLdzsy1+JD9ENKh/5aYLjSGgAi10F3bzEDEYLP5jQgf2hqm
         PcC6ed4Ui6mrw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: stex: fix MU_MAX_DELAY typecheck
Date:   Tue, 17 Jan 2023 17:38:27 +0100
Message-Id: <20230117163834.1053763-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

time_after() expects arguments of the same type, but gcc-13 changed the
way that typeof(MU_MAX_DELAY) is determined, causing a build warning as
'before + MU_MAX_DELAY * HZ' gets promoted to a 64-bit integer:

In file included from include/linux/bitops.h:7,
                 from include/linux/kernel.h:22,
                 from drivers/scsi/stex.c:13:
drivers/scsi/stex.c: In function 'stex_common_handshake':
include/linux/typecheck.h:12:25: error: comparison of distinct pointer types lacks a cast [-Werror]
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
include/linux/jiffies.h:106:10: note: in expansion of macro 'typecheck'
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
drivers/scsi/stex.c:1035:29: note: in expansion of macro 'time_after'
 1035 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {

Change the enum definition so all values fit into an unsigned
32-bit number.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/stex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 8def242675ef..23462d3c9850 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -110,7 +110,7 @@ enum {
 	TASK_ATTRIBUTE_ORDERED			= 0x2,
 	TASK_ATTRIBUTE_ACA			= 0x4,
 
-	SS_STS_NORMAL				= 0x80000000,
+	SS_STS_NORMAL				= 0x80000000u,
 	SS_STS_DONE				= 0x40000000,
 	SS_STS_HANDSHAKE			= 0x20000000,
 
@@ -120,7 +120,7 @@ enum {
 
 	SS_I2H_REQUEST_RESET			= 0x2000,
 
-	SS_MU_OPERATIONAL			= 0x80000000,
+	SS_MU_OPERATIONAL			= 0x80000000u,
 
 	STEX_CDB_LENGTH				= 16,
 	STATUS_VAR_LEN				= 128,
@@ -173,7 +173,7 @@ enum {
 	ST_ADDITIONAL_MEM_MIN			= 0x80000,
 	PMIC_SHUTDOWN				= 0x0D,
 	PMIC_REUMSE					= 0x10,
-	ST_IGNORED					= -1,
+	ST_IGNORED					= -1u,
 	ST_NOTHANDLED				= 7,
 	ST_S3						= 3,
 	ST_S4						= 4,
-- 
2.39.0

