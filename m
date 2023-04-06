Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7857A6DA41D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbjDFU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDFU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED5AE6;
        Thu,  6 Apr 2023 13:56:31 -0700 (PDT)
Date:   Thu, 06 Apr 2023 20:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+A8lo5ONOHktWl6dqH6/xaISHAXuz58cuUsDMYfnqIU=;
        b=mFW6ZqBvlPm3IyerNR1QsxLm9vs7Dy6re6qo1bmEqOJlAYsWZjx078RcCECnV1cZe0Genn
        vgAJEAvgOsrWb5RCJUwNr06YST+r/oensPC3/e7J/8Z4rb/YqWCyc5nXVyzUpi+uYfDO1x
        JDgI3yB+nGE5F5kr9PsvQLs4GzEfem13JAYbcyxzuEyuJE3YJe54659+FgkXewhcrAEXWY
        6AZo+qmhFasWzmxz6/XKde4mqSwF7QxN7T0TdfY0iAwcMLHBAjaI2BD+95EDs1kzJkSyNc
        vLceM3tsdt9RfhPsatfkVUMGD0QXUGqs+fY2rNYw4CG2jyhg41hT1TBGJyNlSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+A8lo5ONOHktWl6dqH6/xaISHAXuz58cuUsDMYfnqIU=;
        b=ubcc2YTUhcI6OqryRq9iTTFC9b2nnql1ES5SZP4+Tlawa2v1zLnX8RNT51mJAWMDxJ0L/a
        kOUuDwLQRU5i2PBA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA
 bit from outside
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168081458918.404.18350482081623211324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     97740266de26e5dfe6e4fbecacb6995b66c2e378
Gitweb:        https://git.kernel.org/tip/97740266de26e5dfe6e4fbecacb6995b66c2e378
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 03 Apr 2023 14:10:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 06 Apr 2023 13:45:06 -07:00

x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA bit from outside

arch_prctl(ARCH_FORCE_TAGGED_SVA) overrides the default and allows LAM
and SVA to co-exist in the process. It is expected by called by the
process when it knows what it is doing.

arch_prctl() operates on the current process, but the same code is
reachable from ptrace where it can be called on arbitrary task.

Make it strict and only allow to set MM_CONTEXT_FORCE_TAGGED_SVA for the
current process.

Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/all/20230403111020.3136-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/kernel/process_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bc2ac56..223b223 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -883,6 +883,8 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
 	case ARCH_FORCE_TAGGED_SVA:
+		if (current != task)
+			return -EINVAL;
 		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
 		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
