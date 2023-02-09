Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A88690A33
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBINb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBINaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8BE23C66;
        Thu,  9 Feb 2023 05:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A4EB8212D;
        Thu,  9 Feb 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECFFC433D2;
        Thu,  9 Feb 2023 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949442;
        bh=ZXuSjWIj3uDvd8CX7vRwjMmFnZyGhqGjPSsai6Ql/Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=Ui9Agq8EjxGpxpsLEAVyUwjzwSOxBtorTPgisj1DadHSCFz9ytQnRm7J5WlxMKHlN
         cJ09OUcdFwQiUFBsRmu+DemvX/L143kPWpE2qBVJkatp7Pe6h/G76SH/akZw/DgIqv
         FONte1k/Ij+QDroWyCvBiAXowSAM3qlyobUTwHjmvNOJbybOPIscfAw6/fv/xsrEon
         ag1UJ+E4MseLR74BRXw3qFjtAauMj7JxuLVRdcxzO/Duk5yG2AUJj4Pcgw3ovdCfDH
         oIWQH6Wnmj70WhjUuDMFxIEisqt5G/jGrlEeWIINX1HP82Twe0w9hPSRI3+UYeGdDA
         JOPU1cAjoQn+g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71F-0001Kf-Ai; Thu, 09 Feb 2023 14:31:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v5 00/19] irqdomain: fix mapping race and clean up locking
Date:   Thu,  9 Feb 2023 14:23:04 +0100
Message-Id: <20230209132323.4599-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel probing (e.g. due to asynchronous probing) of devices that
share interrupts can currently result in two mappings for the same
hardware interrupt to be created.

This series fixes this mapping race and clean up the irqdomain locking
so that in the end the global irq_domain_mutex is only used for managing
the likewise global irq_domain_list, while domain operations (e.g.
IRQ allocations) use per-domain (hierarchy) locking.

Johan


Changes in v5
 - reorder patches (since we do care about stable after all)
 - tweak commit messages and add stable tags
 - use '__locked' suffix for new helper functions
 - drop a line break from an argument list (11/19)

Changes in v4
 - add a comment to __irq_domain_add() as further documentation of the
   domain lock and root pointer (19/19)
 - add a comment documenting that the lockdep assertion in
   irq_domain_set_mapping() also verifies that the domains in a
   hierarchy point to the same root (19/19)

Changes in v3
 - drop dead and bogus code (1--3/19, new)
 - fix racy mapcount accesses (5/19, new)
 - drop revmap mutex (6/19, new)
 - use irq_domain_mutex to address mapping race (9/19)
 - clean up irq_domain_push/pop_irq() (10/19, new)
 - use irq_domain_create_hierarchy() to construct hierarchies
   (11--18/19, new)
 - switch to per-domain locking (19/19, new)

Changes in v2
 - split out redundant-lookup cleanup (1/4)
 - use a per-domain mutex to address mapping race (2/4)
 - move kernel-doc to exported function (2/4)
 - fix association race (3/4, new)
 - use per-domain mutex for associations (4/4, new)


Johan Hovold (19):
  irqdomain: Fix association race
  irqdomain: Fix disassociation race
  irqdomain: Drop bogus fwspec-mapping error handling
  irqdomain: Look for existing mapping only once
  irqdomain: Refactor __irq_domain_alloc_irqs()
  irqdomain: Fix mapping-creation race
  irqdomain: Drop revmap mutex
  irqdomain: Drop dead domain-name assignment
  irqdomain: Drop leftover brackets
  irqdomain: Clean up irq_domain_push/pop_irq()
  x86/ioapic: Use irq_domain_create_hierarchy()
  x86/apic: Use irq_domain_create_hierarchy()
  irqchip/alpine-msi: Use irq_domain_add_hierarchy()
  irqchip/gic-v2m: Use irq_domain_create_hierarchy()
  irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
  irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
  irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
  irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
  irqdomain: Switch to per-domain locking

 arch/x86/kernel/apic/io_apic.c         |   7 +-
 arch/x86/platform/uv/uv_irq.c          |   7 +-
 drivers/irqchip/irq-alpine-msi.c       |   8 +-
 drivers/irqchip/irq-gic-v2m.c          |   5 +-
 drivers/irqchip/irq-gic-v3-its.c       |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
 drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
 drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
 include/linux/irqdomain.h              |   6 +-
 kernel/irq/irqdomain.c                 | 341 ++++++++++++++-----------
 10 files changed, 232 insertions(+), 182 deletions(-)

-- 
2.39.1

