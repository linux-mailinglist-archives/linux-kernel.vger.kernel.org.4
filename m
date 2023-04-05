Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8508D6D88AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjDEUfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjDEUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:35:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB6C6E8C;
        Wed,  5 Apr 2023 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CGo2H4hJTPWzaMtaGj7Lktm7eVtZzNMbcJEtAOG6yWg=; b=UKqf4X5JbNA9vkONPxrzgBYW92
        y09XAlnqRA7OvwgxflCIdnp0Um5FQLBJESmL9GajFwNqWNyPMsr3IH7WOA01XyOMbP4CP1z8jS3gz
        AoIFfDcZsDikZEyuzzGAs5QUAnyQnHqoorkaoXlh7AByLTwd+Tl1z/5xmLxuSwe1tdotRtxaIDwTm
        S5WOlqzZjRDkZPBG7HK9G4F/DbwDDRXcusDUt3P4eYN87AjkvhbHYj4R0LtL81zjvauwnezN+HlhK
        4cwNNLBjtpvOE5WSXvIrFookL368xlZp4zhHqffGNtMeaRt5iCteXQXi8mm98bIUr3hlamASpWN8S
        aqZYwOfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk9qT-005dWW-2P;
        Wed, 05 Apr 2023 20:35:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v2 0/2] kmod: simplify with a semaphore
Date:   Wed,  5 Apr 2023 13:35:03 -0700
Message-Id: <20230405203505.1343562-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I split the semaphore simplification work out from my first patch series [0]
because as although the changes came out of that effort, in the end this set
of patches are slightly orthogonal to the goal behind that series and this
ended up being mostly a cleanup with mild bike shedding exercise.

As revealed from the first series, there is some tribal knowledge around
why some binary semaphores are not just mutexes, so we cannot just convert
them all to mutex. So I've extended Peter's patch with some of that tribal
knowledge.

Changes on this v2:

  o split this series up into its own
  o adopt Peter's patch and extend it with some documentation as to why
    some folks stick to binary semaphores over mutexes
  o modify kmod.c to use the preferred declaration

This goes boot tested.

[0] https://lkml.kernel.org/r/20230329053149.3976378-1-mcgrof@kernel.orgsemaphore

Luis Chamberlain (1):
  modules/kmod: replace implementation with a sempahore

Peter Zijlstra (1):
  Change DEFINE_SEMAPHORE() to take a number argument

 arch/mips/cavium-octeon/setup.c               |  2 +-
 arch/x86/kernel/cpu/intel.c                   |  2 +-
 drivers/firmware/efi/runtime-wrappers.c       |  2 +-
 drivers/firmware/efi/vars.c                   |  2 +-
 drivers/macintosh/adb.c                       |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +-
 drivers/platform/x86/intel/ifs/sysfs.c        |  2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c            |  2 +-
 .../interface/vchiq_arm/vchiq_arm.c           |  2 +-
 include/linux/semaphore.h                     | 11 ++++++--
 kernel/module/kmod.c                          | 26 +++++--------------
 kernel/printk/printk.c                        |  2 +-
 net/rxrpc/call_object.c                       |  6 ++---
 13 files changed, 28 insertions(+), 35 deletions(-)

-- 
2.39.2

