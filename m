Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986D621158
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiKHMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiKHMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:48:19 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE853EDF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667911694;
        bh=oVLc4gaktdNCNVvwWLVkFb2ZvH20wWVNUBsMSq/8jp0=;
        h=From:To:Cc:Subject:Date;
        b=p2uJJhg41B0S76vGxe88P+iivQGF2oFPGqLrQ/VYbtEtAfGUBZW7kmdUc/2EXdDL+
         TLPJATz2rir4rgxUvjIxRQZCILYV+gpPEqj91lOi+aFOeyHeQYVEksJjtYk/s+1lKn
         WTPnqnA6fbs9C4geNYTXfpIAduy7535qG/dWdFt0=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id C0BAF88A; Tue, 08 Nov 2022 20:48:11 +0800
X-QQ-mid: xmsmtpt1667911691tuo6mpdjb
Message-ID: <tencent_C9D7A6D118445E036021CE2CB4CB4495E207@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmFNpXVH2eRjE7JTPiOgzhK0+tfEcnsEo7BhLIgc0wKXQ+SgIjF+H
         1Vrbuk1XzFMRi43EVGYY80TZNohlUE2f4iGSDtuqtIJB8nZhl3tAkvPIuHchUMf9B071iiWZ03Cc
         O+Vm4fAB8Or5mnlKb5qbBjGgPYpIkAh3YFK5R63CwPvH5jj4r9y+VUCr9de71vQtbyfe4t8fUPKq
         qJL+H+kykgycJD1GAioNzY8bQzb3ue8bUrZvTVJb8RZiv2CJhvhp+kfBkZCPzPn5w8l1D9b5KxHK
         ekOmRxE+VJybiNfUiqyAcawp6I991iNvq/PcH+lzQtUVVO98cnF+xj0huVTrXqcCUYbx6Ji/rnsj
         iKaZrEcVy1sXF/PmYug8esjM6T5ln0DgtEIHI7p7YNw8DTF3bVrJcs3BZEkbbZa89UvG5jLE7Au6
         I6GrpXEvqFcu2zLuNoUmkxSibxZ1kfv4ZE2gZcIJUB3CicWuuPoX3o9xRqCmICIH16ZlYoaHABBx
         bXUDoCEUM4/5L1XSGtBCx9wa6Jgx8eIS8IIrBVLp6iqvVZiuqiVY9jOl0OKxjljH7AuoqmvWt3zy
         76e0qaf+2r6Y+5F8ayoMJlPogapPNp9ZF4pv/Kd73XLDxbN13bBgwqhypCdAYCo5Ghv7NgGlpzCC
         lfUOHYIJ1VNPmjz7RrgMHwt55ipd091kXRWDwCcrwGU3XxBWoGaZ5+8Gf8iac8A6R/4LfWTG0R2r
         WrxLg9j5nmwQM4O1Cn21I5BV3VM9hIu+SehQwsvrQCdOCAPOTBSoKM40CnChyix+Moas0lQA34d9
         M++X2c4jwaP61h65/dKXkr2JOKMrNfuakcMOE68TSM+i42v6QzYNvqbKylYRgK39OIKZOT3kQT/A
         Ogiro9QKJ1qSldmoVVgYOpgOKVZmn5QdhrQTZFb9eUzZiRiRPKnzlgs37LF1gjJo3ihc/kxm4Aab
         b2tEOgh/F4mYmQP5j4Hn+x3z1d7EUNK/sWIjZFLvoS2984VrVOmHWKyrwLbhnFe9QL3KcekSNqVH
         F0kpSWdA==
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org
Cc:     Rong Tao <rongtao@cestc.cn>, Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/vm/slabinfo: indicates the cause of the EACCES error
Date:   Tue,  8 Nov 2022 20:47:57 +0800
X-OQ-MSGID: <20221108124758.33198-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

If you don't run slabinfo with a superuser, return 0 when read_slab_dir()
reads get_obj_and_str("slabs", &t), because fopen() fails (sometimes
EACCES), causing slabcache() to return directly, without any error during
this time, we should tell the user about the EACCES problem instead of
running successfully($?=0) without any error printing.

 For example:
 $ ./slabinfo
 Permission denied, Try using superuser  <== What this submission did
 $ sudo ./slabinfo
 Name            Objects Objsize   Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
 Acpi-Namespace     5950      48  286.7K         65/0/5   85 0   0  99
 Acpi-Operand      13664      72  999.4K       231/0/13   56 0   0  98
 ...

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/vm/slabinfo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 0fffaeedee76..cfaeaea71042 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -157,9 +157,11 @@ static unsigned long read_obj(const char *name)
 {
 	FILE *f = fopen(name, "r");
 
-	if (!f)
+	if (!f) {
 		buffer[0] = 0;
-	else {
+		if (errno == EACCES)
+			fatal("%s, Try using superuser\n", strerror(errno));
+	} else {
 		if (!fgets(buffer, sizeof(buffer), f))
 			buffer[0] = 0;
 		fclose(f);
-- 
2.31.1

