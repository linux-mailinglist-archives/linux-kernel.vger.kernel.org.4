Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B862F310
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiKRK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiKRK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:56:03 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 02:56:01 PST
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B86A91523
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:56:01 -0800 (PST)
Received: (qmail 7247 invoked by uid 1019); 18 Nov 2022 10:49:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2022 10:49:18 -0000
Date:   Fri, 18 Nov 2022 10:49:18 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
cc:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 2/4] Documentation: RISC-V: Allow patches for non-standard
 behavior
In-Reply-To: <20221013045619.18906-3-palmer@rivosinc.com>
Message-ID: <alpine.DEB.2.21.999.2211181027590.4480@utopia.booyaka.com>
References: <20221013045619.18906-1-palmer@rivosinc.com> <20221013045619.18906-3-palmer@rivosinc.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Wed, 12 Oct 2022, Palmer Dabbelt wrote:

> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The patch acceptance policy forbids accepting support for non-standard
> behavior.  This policy was written in order to both steer implementers
> towards the standards and to avoid coupling the upstream kernel too
> tightly to vendor-specific features.  Those were good goals, but in
> practice the policy just isn't working: every RISC-V system we have
> needs vendor-specific behavior in the kernel and we end up taking that
> support which violates the policy.  That's confusing for contributors,
> which is the main reason we have a written policy in the first place.
> 
> So let's just start taking code for vendor-defined behavior.

I think I understand the motivation behind this patch: to align the stated 
patch acceptance policy with the actual maintenance practice for 
arch/riscv.  Along those lines, how about the following tweaks, based on 
your original patch?

Probably the most significant proposed change from what you wrote is to 
temporarily drop the section about accepting patches for hardware that 
doesn't yet exist.  I know arch/x86 does this, but my recollection is that 
the maintainers there started doing that after the key x86 hardware 
manufacturers established a track record of consistently releasing 
mass-market hardware that implemented what they promised.  Not sure we're 
at that point with RISC-V yet.  We'll get there at some point, but maybe 
we can add that clause back in once that happens?


- Paul

From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Fri, 18 Nov 2022 02:16:17 -0600
Subject: [PATCH] Documentation: RISC-V: Allow patches for widely available
 hardware

This patch, based on an earlier patch from Palmer, updates the patch
acceptance policy to note that the maintainers may also accept patches
for RISC-V hardware that contains features that may not be strictly
RISC-V-compliant, but which is widely available.  The intention here
is to align the stated policy with the de-facto upstream Linux policy.

Link: https://lore.kernel.org/linux-riscv/20221013045619.18906-3-palmer@rivosinc.com/  # Palmer's original patch
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 Documentation/riscv/patch-acceptance.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
index 5da6f9b273d6..2e3f9ecdd977 100644
--- a/Documentation/riscv/patch-acceptance.rst
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -29,7 +29,12 @@ their own custom extensions.  These custom extensions aren't required
 to go through any review or ratification process by the RISC-V
 Foundation.  To avoid the maintenance complexity and potential
 performance impact of adding kernel code for implementor-specific
-RISC-V extensions, we'll only accept patches for extensions that
-have been officially frozen or ratified by the RISC-V Foundation.
-(Implementors, may, of course, maintain their own Linux kernel trees
-containing code for any custom extensions that they wish.)
+RISC-V extensions, we'll only consider patches for extensions that
+either:
+
+- Have been officially frozen or ratified by the RISC-V Foundation, or
+- Have been implemented in hardware that is widely available, per standard
+  Linux practice
+
+(Implementors, may, of course, maintain their own Linux kernel
+trees containing code for any custom extensions that they wish.)
-- 
2.38.1

