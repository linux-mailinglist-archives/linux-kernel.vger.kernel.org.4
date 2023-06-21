Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A16737C64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjFUH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFUH0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:26:43 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D56269D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:25:33 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qBsDZ-00C8BE-W0; Wed, 21 Jun 2023 08:25:30 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qBsDa-001cqW-1n;
        Wed, 21 Jun 2023 08:25:30 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] kallsysm: make arch_get_kallsym() static for now
Date:   Wed, 21 Jun 2023 08:25:29 +0100
Message-Id: <20230621072529.387643-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_get_kallsym() isn't currnetly being used outside of the file
and is not defined in any header file either. Make it static until there
is a user, to remove the following sparse warning;

kernel/kallsyms.c:662:12: warning: symbol 'arch_get_kallsym' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b..b53c67f5ebb7 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -659,7 +659,7 @@ struct kallsym_iter {
 	int show_value;
 };
 
-int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+static int arch_get_kallsym(unsigned int symnum, unsigned long *value,
 			    char *type, char *name)
 {
 	return -EINVAL;
-- 
2.39.2

