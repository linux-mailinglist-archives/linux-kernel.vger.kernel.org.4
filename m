Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD53073FB72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF0Lx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjF0LxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:53:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8948DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:53:22 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5224E1EC068B;
        Tue, 27 Jun 2023 13:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687866801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=QVMqZQIXUOVG5eYZAyqFtJFEjSnD1IRV6U7Mbt88SAo=;
        b=Sl6nRiSL5vsXMqI9fYXwubLzKiGooiprAOUHYQ9llbTAazYYREiWu9IoO9VEQs7CnvZH90
        nLDGAgqgcQODa+oiCXdH5W6T4SeBqY1S9k/b9ykuHJINqymZJX0kLedt0gVLWbDcCt3Ad4
        jJlSp03x2jdzCGDuAUr46FiZ/FkkUXk=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yf7zup4Kvp_z; Tue, 27 Jun 2023 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687866798; bh=QVMqZQIXUOVG5eYZAyqFtJFEjSnD1IRV6U7Mbt88SAo=;
        h=Date:From:To:Cc:Subject:From;
        b=bjA7XTCVvv1bFynBtGa78lIxaRIWXCXz+7ecOtNZltuym7GCJvV6IIhlWeSJhEQre
         xII9Ulk184/CSYhClj4XAAWOMlnFnVUCiJqz5JQ4akDR4Lux7Pam1AvlDX32yg1gg2
         He1ER6d8SSbX9gfyUOTLtER047L4sIjQPZnD9b4+x3SEFn28qQceCumeSLc0/6wwN1
         nQfnWRjR8I/OHS/pOwpWicqXO/ZKPEAHHyVwPHrwUyoaqgVfHMF2drJcZKNzvIwwtY
         NSOHSTdkHy+duZpY9aHydMh+ESMCvbdZEC4dFr+pNBNl9XxamZ+pKnLuym4dxX6q7g
         68i3XfyntVDLMyXYFQ55WwS+PW+d5QcMgcgnvqbAJhZuH5e7LrIC64a4JTzJoF5E3r
         l5G0hDp0zkjc1uDZuFEmBo9Qdhmn/Pa74YtA297k8uMZ5YjR7d0it5g3oOyv2lFPi9
         9fyL+sZTL7sQPzj8Gsk0imFrFZDBJOCAZzqFn0/apfrEupgXaTRuCGj+ezGkXa4y+R
         xOG71IMJ0WkuEmfR2ZnujAaR2zEcfZAfQ2sBm6jXREikwhdXzm0nftrgnmarCxrL/x
         SK+AjdGB0VaBR73xB/nf0K5+FeAyp8Zi1TWQALUIKcVfR6xOkOPnKjztsaGIjejfRD
         WjRUJm1fy3td7TZ9g6cPoXsw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5E5240E0035;
        Tue, 27 Jun 2023 11:53:15 +0000 (UTC)
Date:   Tue, 27 Jun 2023 13:53:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mtrr for 6.5
Message-ID: <20230627115311.GEZJrNp+K+a3qqNKGO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the MTRR cleanup Juergen has been working on for a while
now, for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.5

for you to fetch changes up to 30d65d1b19850c9bc8c17dba8ebe9be5e0c17054:

  x86/xen: Set default memory type for PV guests to WB (2023-06-16 11:22:33 +0200)

----------------------------------------------------------------
- A serious scrubbing of the MTRR code including adding a new map
  mechanism in order to look up the memory type of a region easily. Also
  address memory range lookup issues like returning an invalid memory
  type. Furthermore, this handles the decoupling of PAT from MTRR more
  naturally. All work by Juergen Gross

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/mtrr: Unify debugging printing

Juergen Gross (17):
      x86/mtrr: Remove physical address size calculation
      x86/mtrr: Replace size_or_mask and size_and_mask with a much easier concept
      x86/mtrr: Support setting MTRR state for software defined MTRRs
      x86/hyperv: Set MTRR state when running as SEV-SNP Hyper-V guest
      x86/xen: Set MTRR state when running as Xen PV initial domain
      x86/mtrr: Replace vendor tests in MTRR code
      x86/mtrr: Have only one set_mtrr() variant
      x86/mtrr: Move 32-bit code from mtrr.c to legacy.c
      x86/mtrr: Allocate mtrr_value array dynamically
      x86/mtrr: Add get_effective_type() service function
      x86/mtrr: Construct a memory map with cache modes
      x86/mtrr: Add mtrr=debug command line option
      x86/mtrr: Use new cache_map in mtrr_type_lookup()
      x86/mtrr: Don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
      x86/mm: Only check uniform after calling mtrr_type_lookup()
      x86/mtrr: Remove unused code
      x86/xen: Set default memory type for PV guests to WB

 Documentation/admin-guide/kernel-parameters.txt |   4 +
 arch/x86/hyperv/ivm.c                           |   4 +
 arch/x86/include/asm/mtrr.h                     |  51 +-
 arch/x86/include/uapi/asm/mtrr.h                |  14 +-
 arch/x86/kernel/cpu/mtrr/Makefile               |   2 +-
 arch/x86/kernel/cpu/mtrr/amd.c                  |   2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c              |  11 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c              |  87 ++-
 arch/x86/kernel/cpu/mtrr/cyrix.c                |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c              | 675 ++++++++++++++++--------
 arch/x86/kernel/cpu/mtrr/legacy.c               |  90 ++++
 arch/x86/kernel/cpu/mtrr/mtrr.c                 | 206 ++------
 arch/x86/kernel/cpu/mtrr/mtrr.h                 |  31 +-
 arch/x86/kernel/setup.c                         |   2 +
 arch/x86/mm/pgtable.c                           |  24 +-
 arch/x86/xen/enlighten_pv.c                     |  54 ++
 16 files changed, 777 insertions(+), 482 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/legacy.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
