Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D356117FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJ1QsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1QsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:01 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E141EEF01
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=noL9/NeDUTGkTM9TkwKb+qB4g92MFSxxMDGz/3I26JY=; b=tTloeFQWZ0uoDO5GJamaoriva2
        cIFPvVdZJsD4tqdlzlbICcPKZ7oX/ZY+D14hvxMfOE+WoHtE30EY66VVrh/WS/z13sIo3uWCMbyhm
        QFC5lsr6yq8M4lpXjTYjcE3JU8CqnfGeT5tHIKgpxxDcVg2Ghhh3Tym6zM4wrXQcWLclX501T6R3a
        mTs50+ZSY4ziba5+FuQlDKf2TEPIf9Ma+dnc18tsVY8VcD2LA+scbJScXjkglrg8bvjKMuh6tkJlc
        3+QIcPkgxg85h+O+Pp1gzgO67hoiR1tQ1WjteSZI3bKACJ8dzRr1Q5+RLw2WitLDyWA4d7OGa9Dn7
        bHS7g84Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55696 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ooSWU-00006h-RW; Fri, 28 Oct 2022 17:47:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1ooSWU-000FE4-9D; Fri, 28 Oct 2022 17:47:58 +0100
In-Reply-To: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] ARM: findbit: provide more efficient ARMv7 implementation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ooSWU-000FE4-9D@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 Oct 2022 17:47:58 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a more efficient ARMv7 implementation to determine the first
set bit in the supplied value.

Signed-off-by: Russell King (Oracle) <rmk@armlinux.org.uk>
---
 arch/arm/lib/findbit.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 4c584bc4704b..256e095d490b 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -170,7 +170,11 @@ ENDPROC(_find_next_bit_be)
  * One or more bits in the LSB of r3 are assumed to be set.
  */
 .L_found:
-#if __LINUX_ARM_ARCH__ >= 5
+#if __LINUX_ARM_ARCH__ >= 7
+		rbit	r3, r3			@ reverse bits
+		clz	r3, r3			@ count high zero bits
+		add	r0, r2, r3		@ add offset of first set bit
+#elif __LINUX_ARM_ARCH__ >= 5
 		rsb	r0, r3, #0
 		and	r3, r3, r0		@ mask out lowest bit set
 		clz	r3, r3			@ count high zero bits
-- 
2.30.2

