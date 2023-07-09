Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECE74C18A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGIII5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGIIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:08:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF67194
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:08:53 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B4531EC08BF;
        Sun,  9 Jul 2023 10:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688890132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=tDLrM/F46YK8Ho3wbOd7ZV5bua+7Hf02VpjlvZYmid0=;
        b=HTvvTEMXgUbwOs+jWyeM6WG7IcN41/d6AAiY3m8go5MF42Y5FpOuhDZeU3L6PcizEYTy5P
        3wF4vd9mpGxvgRxFL8aGMrrwUZDE3UYIQbUos4Xa97MwDEMnc3s+f/sGDj/ULyxn2Sqmzh
        t73540YRLyNHeopDBejpeP23S6LOP5o=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PuO51O8CLGW6; Sun,  9 Jul 2023 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688890129; bh=tDLrM/F46YK8Ho3wbOd7ZV5bua+7Hf02VpjlvZYmid0=;
        h=Date:From:To:Cc:Subject:From;
        b=dgSJ09X+L8mptGwaz80oty+HD8DqLFAj6L1nDRr51WGotChDpog1F2tOe73vX9lFX
         zb1+Ur7KNRCW00WtG8I5dyQ7FLrj08cldD07AwRLN49OICMlfBmstBRv9k2YOtE9jf
         VO+/9ABcg88tGXUu/rKdIGsVZOLCrhMRDEnRejpL6NO0ramtyfBGbqmKRIexgNrF2Y
         tFps0H9XZW5vpIHVrwehs7fRIQzFtcKr5v7QWKSEDsXsoFxCbzTaXyueZ8feMKsRID
         5z3a/9BYbt82ydOucpTJaQcbDvDJwiHE3G6ECxhLVTH5lVjTFnvdVLLXZT93qFOmZU
         EWPgg3vSyZt87L48jEQTbTVfWwGomJcjs++H2t/NfJQkoOOWKARVu+jMk0EWn8hWbh
         pYnHoJoQhnKZOLsjtYyCMbvTkbp9havwuJawdJk/ROvXs3E51XmXqN04loQENRouBb
         34JBUL3cCKzPheO1bf8HcOJm/Zs0fEnZtHMNJS8RtTbBBvVbCIFrBukLT5Swc9/W8d
         aN8bUZpUw/5qqO2vTWDT61dY6MdMlDDizg8eRlG5fHIJ4bRtlhafUAdqEs73T4jwYG
         2Hprs3Pz4yjpNxFdo78L6Rl4fnhhMuKGoY+ZImQnf3QRhB3URLNWWAmFTpWBV4u96n
         INsiRfyD+U0k6OQNb4WD+6dA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3808640E01A4;
        Sun,  9 Jul 2023 08:08:46 +0000 (UTC)
Date:   Sun, 9 Jul 2023 10:08:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.5-rc1
Message-ID: <20230709080838.GAZKprBjZs9TAzdAHk@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent x86 fix for 6.5-rc1.

Thx.

---

The following changes since commit 0303c9729afc4094ef53e552b7b8cff7436028d6:

  x86/efi: Make efi_set_virtual_address_map IBT safe (2023-06-30 15:26:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc1

for you to fetch changes up to fe3e0a13e597c1c8617814bf9b42ab732db5c26e:

  x86/xen: Fix secondary processors' FPU initialization (2023-07-05 11:44:16 +0200)

----------------------------------------------------------------
- Do FPU AP initialization on Xen PV too which got missed by the recent
  boot reordering work

----------------------------------------------------------------
Juergen Gross (1):
      x86/xen: Fix secondary processors' FPU initialization

 arch/x86/xen/smp_pv.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
