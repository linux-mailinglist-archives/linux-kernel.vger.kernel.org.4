Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE2655157
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiLWOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLWOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:24:53 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41117389FD;
        Fri, 23 Dec 2022 06:24:52 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 95EA27E2BE;
        Fri, 23 Dec 2022 14:24:47 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671805491;
        bh=oWmzG5ovwki5HhFnqDbqYkTDAdh4eDUJl7OeVnUrGBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8mFEf26Gx1RBt4uZi7mowHRQxlD8plFc+63Y7K8VG1D0+145z3LEXfvZ9c11us/m
         pCzvfidENFn5qmD+4SA3QDoXtmAqA2PaEiaHR/zF3E3Om0N6hNca44Quh7tMUBpSpl
         1E2gt1BzwL0zAo3YLuAQF0wFgZ+Dw/m2mnolWnwE/qv7L4LnLGszr1vQMcEAHxvMIM
         0ZvpcQXzESrBi6GEiJkPoCun5DpxlTxa9PEaugFsNCUMZ4wt7YrauZlXVcO2LHBD7W
         Ue6OlKQlGQamHoX2QIGGdyfyAMtZSUIZTyhx9pY1wNOyHhd4Ay4HGsagdPYn941bjI
         bYKuPUbpa1gUw==
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
Subject: [PATCH v1 1/2] ACPI: Silence missing prototype warnings
Date:   Fri, 23 Dec 2022 21:24:18 +0700
Message-Id: <20221223142419.3781410-2-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223142419.3781410-1-ammar.faizi@intel.com>
References: <20221223142419.3781410-1-ammar.faizi@intel.com>
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

Compiling with clang-16:

  drivers/acpi/acpi_lpit.c:142:6: error: no previous prototype \
  for function 'acpi_init_lpit' [-Werror,-Wmissing-prototypes]

  drivers/acpi/ioapic.c:212:6: error: no previous prototype \
  for function 'pci_ioapic_remove' [-Werror,-Wmissing-prototypes]

  drivers/acpi/ioapic.c:229:5: error: no previous prototype \
  for function 'acpi_ioapic_remove' [-Werror,-Wmissing-prototypes]

Include "internal.h" to silence them.

Cc: LLVM Mailing List <llvm@lists.linux.dev>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 drivers/acpi/acpi_lpit.c | 1 +
 drivers/acpi/ioapic.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 50540d4d4948..3843d2576d3f 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <asm/msr.h>
 #include <asm/tsc.h>
+#include "internal.h"
 
 struct lpit_residency_info {
 	struct acpi_generic_address gaddr;
diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index a690c7b18623..6677955b4a8e 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -24,6 +24,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <acpi/acpi.h>
+#include "internal.h"
 
 struct acpi_pci_ioapic {
 	acpi_handle	root_handle;
-- 
Ammar Faizi

