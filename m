Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A2708B37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjERWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjERWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB2E5E;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q90wEZtoy57yTiX+qUnwxcIu4K08qvGduE+8ufkTtbc=;
        b=KqJdnBj+TO//bnu55swXXJd1dg5O+GrnJZG7fiywLPEZzU1mS6N9Q647XXwsVvqcvKl6W4
        3OdQOCfcDSlhGAIDHljN/c4Pru8bgKLBuEAkfUQuSzda11K8t2S4vD10y9/DozLt0PTNiO
        +ancU/ok8RIJIYlUDI11EiHM2XnxFCNupNzcC4Bj+VAdXXVEflXQw6iP5PE+q1YDO/DgvV
        Qeq5ALHGYBditW0odmSFb0zL1TlZ7VYwjaaolSN2Wb9Fw6NHAOzu4sctAAC5CaTgKjrpCr
        RbBTqkA22YnjBK65m9Fy4QuTV5dWLAIRzXNstqFBv9A1rECAHWbX/EE5iBP73w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q90wEZtoy57yTiX+qUnwxcIu4K08qvGduE+8ufkTtbc=;
        b=lPJlOjPdobLK2l94IyZBttqM4s0xuv5yUwjK6aOki1QRLxxbM4uejzx5uCio3WwjdZKrMS
        lSDScYwmHSNQvxCA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/quirks: Include linux/pnp.h for
 arch_pnpbios_disabled()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739404.404.1981750002519034291.tip-bot2@tip-bot2>
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

Commit-ID:     056b44a4d10907ec8153863b2a0564e808ef1440
Gitweb:        https://git.kernel.org/tip/056b44a4d10907ec8153863b2a0564e808ef1440
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:38 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/quirks: Include linux/pnp.h for arch_pnpbios_disabled()

arch_pnpbios_disabled() is defined in architecture code on x86, but this
does not include the appropriate header, causing a warning:

arch/x86/kernel/platform-quirks.c:42:13: error: no previous prototype for 'arch_pnpbios_disabled' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-10-arnd%40kernel.org
---
 arch/x86/kernel/platform-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index b348a67..b525fe6 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pnp.h>
 
 #include <asm/setup.h>
 #include <asm/bios_ebda.h>
