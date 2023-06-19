Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B157356F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFSMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:35:42 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55FDB;
        Mon, 19 Jun 2023 05:35:39 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qBE6a-00AyAW-F4; Mon, 19 Jun 2023 13:35:37 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qBE6b-001MTk-07;
        Mon, 19 Jun 2023 13:35:37 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, serge@hallyn.com,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] capabilities: fix sparse warning about __user access
Date:   Mon, 19 Jun 2023 13:35:35 +0100
Message-Id: <20230619123535.324632-1-ben.dooks@codethink.co.uk>
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

The two syscalls for capget and capset are producing sparse warnings
as sparse is thinking that the "struct __user_cap_data_struct" is marked
user, which seems to be down to the declaration and typedef at the same
time.

Fix the following warnings by splutting the struct declaration and then
the user typedef into two:

kernel/capability.c:191:35: warning: incorrect type in argument 2 (different address spaces)
kernel/capability.c:191:35:    expected void const *from
kernel/capability.c:191:35:    got struct __user_cap_data_struct [noderef] __user *
kernel/capability.c:168:14: warning: dereference of noderef expression
kernel/capability.c:168:45: warning: dereference of noderef expression
kernel/capability.c:169:14: warning: dereference of noderef expression
kernel/capability.c:169:45: warning: dereference of noderef expression
kernel/capability.c:170:14: warning: dereference of noderef expression
kernel/capability.c:170:45: warning: dereference of noderef expression
kernel/capability.c:244:29: warning: incorrect type in argument 1 (different address spaces)
kernel/capability.c:244:29:    expected void *to
kernel/capability.c:244:29:    got struct __user_cap_data_struct [noderef] __user ( * )[2]
kernel/capability.c:247:42: warning: dereference of noderef expression
kernel/capability.c:247:64: warning: dereference of noderef expression
kernel/capability.c:248:42: warning: dereference of noderef expression
kernel/capability.c:248:64: warning: dereference of noderef expression
kernel/capability.c:249:42: warning: dereference of noderef expression
kernel/capability.c:249:64: warning: dereference of noderef expression

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 3d61a0ae055d..5bb906098697 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -41,11 +41,12 @@ typedef struct __user_cap_header_struct {
 	int pid;
 } __user *cap_user_header_t;
 
-typedef struct __user_cap_data_struct {
+struct __user_cap_data_struct {
         __u32 effective;
         __u32 permitted;
         __u32 inheritable;
-} __user *cap_user_data_t;
+};
+typedef struct __user_cap_data_struct __user *cap_user_data_t;
 
 
 #define VFS_CAP_REVISION_MASK	0xFF000000
-- 
2.39.2

