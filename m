Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B4708B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjERWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjERWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E080E6E;
        Thu, 18 May 2023 15:03:18 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cBpMz4rE0JEZOPy7/OVV0tk2GJk3DPo5oNqv9QFqpmI=;
        b=KwOjbB0IOJVFACU1Ow0TJ4Q0UhU6ZxnTWEwU3kF0O3VhRtzNmcmRAvuOZ+jmE21aY1hF9j
        eItIy3PkSivFVYX88ONCrb35k+kK/V4tL6sbTiJHx5fUTtvEu78BYtCGyYSN05tCsptDUr
        /4Z99l8ZZe7+2YsyHB6eYY1PY4bRXSsfPKRphVsGWnhTbos7h9C/UQGcMfKT8V36iYlds6
        gdsudbeVZGqLrA4sIzXqrce4E9KhUaCcx3gw2GIWsX/0ENKGA2MSqjzvbyxTJKDPuUDqxv
        huHSo8SGkIcsT0Thqj4L8nBnDSNXpY4fhb0HaX+K5Y7Ts35CAQpCBItgnDSiLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cBpMz4rE0JEZOPy7/OVV0tk2GJk3DPo5oNqv9QFqpmI=;
        b=HKUxvA2fddnqZADF2Ku2yk5/K0EiretlmgDsgDD2ajvf8LOSqmEJJidYqa+m8x2fdQNvbi
        +8IrEFs6AXkMIrDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/fpu: Include asm/fpu/regset.h
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739489.404.10346160308726239812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     16db7e9c6e974a0935494cd31179c819d4cbf86e
Gitweb:        https://git.kernel.org/tip/16db7e9c6e974a0935494cd31179c819d4cbf86e
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:35 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/fpu: Include asm/fpu/regset.h

The fpregs_soft_set/fpregs_soft_get functions are declared in a
header that is not included in the file that defines them, causing
a W=1 warning:

/home/arnd/arm-soc/arch/x86/math-emu/fpu_entry.c:638:5: error: no previous prototype for 'fpregs_soft_set' [-Werror=missing-prototypes]
  638 | int fpregs_soft_set(struct task_struct *target,
      |     ^~~~~~~~~~~~~~~
/home/arnd/arm-soc/arch/x86/math-emu/fpu_entry.c:690:5: error: no previous prototype for 'fpregs_soft_get' [-Werror=missing-prototypes]
  690 | int fpregs_soft_get(struct task_struct *target,

Include the file here to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-7-arnd%40kernel.org
---
 arch/x86/math-emu/fpu_entry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 7fe56c5..91c52ea 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -32,6 +32,7 @@
 #include <asm/traps.h>
 #include <asm/user.h>
 #include <asm/fpu/api.h>
+#include <asm/fpu/regset.h>
 
 #include "fpu_system.h"
 #include "fpu_emu.h"
