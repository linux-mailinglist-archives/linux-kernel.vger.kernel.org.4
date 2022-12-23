Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD0655155
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiLWOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLWOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:24:48 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B7389D1;
        Fri, 23 Dec 2022 06:24:47 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 9534E7E2AE;
        Fri, 23 Dec 2022 14:24:42 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671805486;
        bh=dNPzty6+3wvC9UOMJf16amTH8c8ZgOehht68bpqpb34=;
        h=From:To:Cc:Subject:Date:From;
        b=pZBNuHiv1L3TiQm7thqehXucGb6L40REIbArmLM03emV+BgTKq3/OCg803rdwgeFf
         OpWJzEcQOzg+CswI1uWQVKKUEWhNSMw93Xrm7Ev3ktK05lx37pbQqXheSUPx0xJuaD
         1dCTzhhuWQ4N8b10GcdIaFcdNO9dVU77KjG//R3hDBvQVBLD1cSd0Zk3Pd/PkIjop+
         ne4pdS94/I6emwPbIsSQYvB6vb7OOKnw4ew2XSRfqMzekusyV+ye/U4ktj/3sRxL8C
         NdL/WvOr7Lj2+gMQx7vPvKBMSW9A2To7itbYbISMDw6oF+JhE3ZoKq93Kd5urLdL9K
         y3IZgrj2vflVQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Len Brown <lenb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPICA Mailing List <devel@acpica.org>,
        LLVM Mailing List <llvm@lists.linux.dev>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1 0/2] clang warning cleanups
Date:   Fri, 23 Dec 2022 21:24:17 +0700
Message-Id: <20221223142419.3781410-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Hi,

On top of Linus' tree. This series fixes clang warnings.

Base commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

# Patch 1:

  Compiling with clang-16:

    drivers/acpi/acpi_lpit.c:142:6: error: no previous prototype \
    for function 'acpi_init_lpit' [-Werror,-Wmissing-prototypes]

    drivers/acpi/ioapic.c:212:6: error: no previous prototype \
    for function 'pci_ioapic_remove' [-Werror,-Wmissing-prototypes]

    drivers/acpi/ioapic.c:229:5: error: no previous prototype \
    for function 'acpi_ioapic_remove' [-Werror,-Wmissing-prototypes]

  Include "internal.h" to silence them.

# Patch 2:

  @num_carats is used for debugging, passed to the 'ACPI_DEBUG_PRINT()'
  macro. But this macro will expand to nothing when debug is disabled,
  resulting in the following (clang-16):

    drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set \
    but not used [-Werror,-Wunused-but-set-variable]
          u32 num_carats;
              ^
    1 error generated.

  Move the variable declaration inside the else block to reduce the scope,
  then add '(void)num_carats' to silence the warning when debug is disabled.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  ACPI: Silence missing prototype warnings
  ACPICA: Silence 'unused-but-set variable' warning

 drivers/acpi/acpi_lpit.c       | 1 +
 drivers/acpi/acpica/nsaccess.c | 4 ++--
 drivers/acpi/ioapic.c          | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)


base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
-- 
Ammar Faizi

