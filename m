Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F78744ACA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGASIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGASIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:08:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F1E60
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:08:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688234901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z7n65yztowNTsN6knddAU63E2VJZBTfxWUPidBhKx1U=;
        b=d6646aj5wg0yj4mdJao8Dgf0qZu4IG98x0Nvbz5K1JL8XYZ6oXy494B4ZXhZdygACZ9GXV
        8lAZZQ9QGeRPhkAGrNBqvDF6wipLiNc+QlCfUFRuC/UKPWCWkPolVrPfSHNvkNa5vLrwBL
        JjwVY6BftUCbTO/TqOnHjqU7YgrTd2XcBub+O8hb4+kZCjzNLvbbes8r8NaR5zv73GfvPw
        YPoRugeyySvdeq4hWVyJnwUarUmj0b2J55sU4Oy9LFERo6o+kjil79m3203XPFc6UTU3OW
        pxwUzF+rX5QfTJiVAlzpcc9B/XOg9wjG2pIke+i2Vu6J+bOI5Yqo4ddcB4pYfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688234901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z7n65yztowNTsN6knddAU63E2VJZBTfxWUPidBhKx1U=;
        b=Lro8dXmykNRkQq+JZMqMpD3EiSgGFAb6haa2ngyLq6nisDwcUqdrlgbX3J9O2EIyTv2LGN
        Mc2MnNy6/eODpnCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.5-rc1
Message-ID: <168823486244.3978156.6059859588267964136.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sat,  1 Jul 2023 20:08:20 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-=
07-01

up to:  0303c9729afc: x86/efi: Make efi_set_virtual_address_map IBT safe


A single regression fix for x86:

  Moving the invocation of arch_cpu_finalize_init() earlier in the boot
  process caused a boot regression on IBT enabled system.

  The root cause is not the move of arch_cpu_finalize_init() itself. The
  system fails to boot because the subsequent efi_enter_virtual_mode() code
  has a non-IBT safe EFI call inside. This was never noticed because IBT
  was enabled after the EFI initialization.

  Switching the EFI call to use the IBT safe wrapper cures the problem.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/efi: Make efi_set_virtual_address_map IBT safe


 arch/x86/platform/efi/efi_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 232acf418cfb..77f7ac3668cb 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -853,9 +853,9 @@ efi_set_virtual_address_map(unsigned long memory_map_size,
=20
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status =3D efi_call(efi.runtime->set_virtual_address_map,
-			  memory_map_size, descriptor_size,
-			  descriptor_version, virtual_map);
+	status =3D arch_efi_call_virt(efi.runtime, set_virtual_address_map,
+				    memory_map_size, descriptor_size,
+				    descriptor_version, virtual_map);
 	local_irq_restore(flags);
=20
 	efi_fpu_end();

