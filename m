Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F96C8B41
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjCYGIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CE5B83;
        Fri, 24 Mar 2023 23:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA4F608D6;
        Sat, 25 Mar 2023 06:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3398AC433D2;
        Sat, 25 Mar 2023 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724525;
        bh=QPzy71xE64/SsB5HZiR2p+8ayTfHE+kLq9Bs2237hX0=;
        h=From:To:Cc:Subject:Date:From;
        b=JBRN3rCiUE7oatyCO1ntcs7l+Ygz/TFZ1MhPgjxriIbDUkM3cN8w4/ZOr3pRBzwcv
         iGmFCD1UJbb8yyn2abrAg5wsr3JNsRJylaybW0eUGVa2aWzb608pnWLc27USlHufxS
         Dk2wghv0HZwFNYqpbHmYss+l/fa5ftq/XnFJr6K9B0X59TOO6QRSvJVTyHfOlKdLGF
         54Ci8dpwCXl96AJ8gkbhujTgy2KgRU31aG9drErxh2HlIn6sGOfYZF2Dm8QjBggrY4
         4bOpTxAaFt6ZKLsW7Da/u16QI+zHrS/Nh/iGzj4q8lqxrVIyYb/Dy2pavbalKqrD6C
         IIfbUAwR8oh7A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 00/14] arch,mm: cleanup Kconfig entries for ARCH_FORCE_MAX_ORDER
Date:   Sat, 25 Mar 2023 09:08:14 +0300
Message-Id: <20230325060828.2662773-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Several architectures have ARCH_FORCE_MAX_ORDER in their Kconfig and
they all have wrong and misleading prompt and help text for this option.

Besides, some define insane limits for possible values of
ARCH_FORCE_MAX_ORDER, some carefully define ranges only for a subset of
possible configurations, some make this option configurable by users for no
good reason.

This set updates the prompt and help text everywhere and does its best to
update actual definitions of ranges where applicable.

kbuild generated a bunch of false positives because it assigns -1 to
ARCH_FORCE_MAX_ORDER, hopefully this will be fixed soon.

v3:
* fix rebase fallouts (Zi Yan)

v2: https://lore.kernel.org/all/20230324052233.2654090-1-rppt@kernel.org
* arm64: show prompt for ARCH_FORCE_MAX_ORDER only if EXPERT (Catalin)
* Add Acked- and Reviewed-by tags (thanks Geert, Kirill and Max)

v1: https://lore.kernel.org/all/20230323092156.2545741-1-rppt@kernel.org

Mike Rapoport (IBM) (14):
  arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
  arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
  arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
  csky: drop ARCH_FORCE_MAX_ORDER
  ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
  m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
  nios2: reword ARCH_FORCE_MAX_ORDER prompt and help text
  nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  powerpc: reword ARCH_FORCE_MAX_ORDER prompt and help text
  powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
  sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
  xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text

 arch/arm/Kconfig      | 16 +++++++++-------
 arch/arm64/Kconfig    | 26 ++++++++++++--------------
 arch/csky/Kconfig     |  4 ----
 arch/ia64/Kconfig     |  3 +--
 arch/m68k/Kconfig.cpu | 16 +++++++++-------
 arch/nios2/Kconfig    | 17 +++++++++--------
 arch/powerpc/Kconfig  | 22 +++++++++-------------
 arch/sh/mm/Kconfig    | 19 +++++++++----------
 arch/sparc/Kconfig    | 16 +++++++++-------
 arch/xtensa/Kconfig   | 16 +++++++++-------
 10 files changed, 76 insertions(+), 79 deletions(-)


base-commit: 51551d71edbc998fd8c8afa7312db3d270f5998e
-- 
2.35.1

*** BLURB HERE ***

Mike Rapoport (IBM) (14):
  arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
  arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
  arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
  csky: drop ARCH_FORCE_MAX_ORDER
  ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
  m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
  nios2: reword ARCH_FORCE_MAX_ORDER prompt and help text
  nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  powerpc: reword ARCH_FORCE_MAX_ORDER prompt and help text
  powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
  sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
  sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
  xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text

 arch/arm/Kconfig      | 16 +++++++++-------
 arch/arm64/Kconfig    | 26 ++++++++++++--------------
 arch/csky/Kconfig     |  4 ----
 arch/ia64/Kconfig     |  3 +--
 arch/m68k/Kconfig.cpu | 16 +++++++++-------
 arch/nios2/Kconfig    | 17 +++++++++--------
 arch/powerpc/Kconfig  | 22 +++++++++-------------
 arch/sh/mm/Kconfig    | 19 +++++++++----------
 arch/sparc/Kconfig    | 16 +++++++++-------
 arch/xtensa/Kconfig   | 16 +++++++++-------
 10 files changed, 76 insertions(+), 79 deletions(-)


base-commit: 51551d71edbc998fd8c8afa7312db3d270f5998e
-- 
2.35.1

