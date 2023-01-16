Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574266C048
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjAPNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F51D2197D;
        Mon, 16 Jan 2023 05:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07588B80F02;
        Mon, 16 Jan 2023 13:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F863C433F0;
        Mon, 16 Jan 2023 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877040;
        bh=WEDOJyVivaqZHP8mDzZn1TPqLohEFKgOiUS27FM0USs=;
        h=From:To:Cc:Subject:Date:From;
        b=XaAh4QOUuZU9HHz/bKg792uJ2CncCl7t1R7gY2Q5l256Q//MOsuZRWVyPofv03ow1
         Hoh4QKTRVrIeGiC75IUbOnpT8zFxP/FiJx+1BeeDrSbXQ+EJJXrOKwsh4kBi+RLA8e
         V97XeDPe06j9AsslBLEWK9x4jvQx2D9E9t6y4FgVZ1orGnxP8WsLhNnZn6wE1ru7Ix
         kXpcbjOrTCjMmWA8RHtPy1G0rJzhaxZfMMzPzTqyU/tZ0Y74w+3LBbVWUKmbx+NNkn
         9GDe0VIXSInL31BVma2GrXpIGoYmVM8cnqYwXpOgnKnp9pXlO1V3E0llE4BB1sHatW
         bAHNhGLOFhlUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt4-0003ui-PH; Mon, 16 Jan 2023 14:50:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 00/19] irqdomain: fix mapping race and clean up locking
Date:   Mon, 16 Jan 2023 14:50:25 +0100
Message-Id: <20230116135044.14998-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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
  irqdomain: Drop bogus fwspec-mapping error handling
  irqdomain: Drop dead domain-name assignment
  irqdomain: Drop leftover brackets
  irqdomain: Fix association race
  irqdomain: Fix disassociation race
  irqdomain: Drop revmap mutex
  irqdomain: Look for existing mapping only once
  irqdomain: Refactor __irq_domain_alloc_irqs()
  irqdomain: Fix mapping-creation race
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

 arch/x86/kernel/apic/io_apic.c         |   8 +-
 arch/x86/platform/uv/uv_irq.c          |   7 +-
 drivers/irqchip/irq-alpine-msi.c       |   8 +-
 drivers/irqchip/irq-gic-v2m.c          |   5 +-
 drivers/irqchip/irq-gic-v3-its.c       |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
 drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
 drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
 include/linux/irqdomain.h              |   6 +-
 kernel/irq/irqdomain.c                 | 341 ++++++++++++++-----------
 10 files changed, 233 insertions(+), 182 deletions(-)

-- 
2.38.2

