Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6269434D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBMKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631C166FE;
        Mon, 13 Feb 2023 02:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95F68B810A1;
        Mon, 13 Feb 2023 10:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B89FC433A1;
        Mon, 13 Feb 2023 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284996;
        bh=AIFFvMOlcdsA/E6sRshF70eAgmoIe63jSj35tjGCv9k=;
        h=From:To:Cc:Subject:Date:From;
        b=eD7p4UJwQPJh9BvldPsrctsrFPnALwdirXaSusln/9byZ/enNSFZZ13X4i0lC28hV
         L9BNBaWZ/JId+39vvWDG/hqr8C21ZVo6mwZ1DWbSoYgtYJPf0lBTj7ZnNDkAiFQ9H0
         LGCQF1zaY+fO6TgJ3cvPJOjwA5/WRplM2MgzvpIuE21chHgB1gUvfo7pGiOMI8Ic3p
         1fNOVoenGJq88pl0s8SlYyUEIf/rX0YQsHqCnHdWbUU07FSvlBfFUzSQT7o6MxAAww
         uKDnRIzWjWUFgrWnsD5U8jeoi/8da5Y2hEI4LcXlDXc/CKk96MhGjIFad8TjcjU78Q
         1GGbbvzhOa82w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJa-0004WH-RV; Mon, 13 Feb 2023 11:44:06 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v6 00/20] irqdomain: fix mapping race and rework locking
Date:   Mon, 13 Feb 2023 11:42:42 +0100
Message-Id: <20230213104302.17307-1-johan+linaro@kernel.org>
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

This series fixes this mapping race and reworks the irqdomain locking so
that in the end the global irq_domain_mutex is only used for managing
the likewise global irq_domain_list, while domain operations (e.g. IRQ
allocations) use per-domain (hierarchy) locking.

Johan


Changes in v6
 - use common exit path in irq_create_fwspec_mapping() (6/20)
 - fix domain registration race (7/20, new)
 - fix x86/uv commit prefix (13/20)
 - use &domain->root->mutex also for non-hierarchichal domains (20/20)
 - fix kernel doc typo (20/20)

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
  x86/uv: Use irq_domain_create_hierarchy()
  irqchip/alpine-msi: Use irq_domain_add_hierarchy()
  irqchip/gic-v2m: Use irq_domain_create_hierarchy()
  irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
  irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
  irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
  irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
  irqdomain: Switch to per-domain locking

Marc Zyngier (1):
  irqdomain: Fix domain registration race

 arch/x86/kernel/apic/io_apic.c         |   7 +-
 arch/x86/platform/uv/uv_irq.c          |   7 +-
 drivers/irqchip/irq-alpine-msi.c       |   8 +-
 drivers/irqchip/irq-gic-v2m.c          |   5 +-
 drivers/irqchip/irq-gic-v3-its.c       |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
 drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
 drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
 include/linux/irqdomain.h              |   6 +-
 kernel/irq/irqdomain.c                 | 408 +++++++++++++++----------
 10 files changed, 279 insertions(+), 202 deletions(-)

-- 
2.39.1

