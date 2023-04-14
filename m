Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEA6E1B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDNFOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDNFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:13:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511105260;
        Thu, 13 Apr 2023 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rAZqO82F1I0YGFsgUNXQwTj+e9P8wOwZV9QtPxI6P38=; b=bc/u6WCFQZojSgMvyIiz3X7lyZ
        rFHkuz0ynpTeAyRE+/Jk5/cNm1npCGKkZgFqljcPNe9qAAzTX8WLMu4nPRwfQuT5LywMLCs7ld35+
        7Jd9sQIbyPJVlKs16pkNqs6ZP/bjiP4Ui9n24Y1/zPcuRF2nP9nSDlBaNBO7D0JHePLMbBu3s4+A8
        JgLwuN02OniU1Z8SOy+zln93sZ50GAhgw/IJXmQ3LjgDiwydbnYHr6D+JeXKQyBGce5epEa4WF+W3
        BDEIqRchJS7HEKn8unwFyD1nCdbyoCbKUmqdr8adj49tDFNG+Tk+BxUgxXe+9qEKtgb8d3kzRDggu
        zf7VaypQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBks-008KqT-1X;
        Fri, 14 Apr 2023 05:13:50 +0000
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
Subject: [PATCH v3 0/2] modules/kmod: replace implementation with a sempahore
Date:   Thu, 13 Apr 2023 22:13:47 -0700
Message-Id: <20230414051349.1986744-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this v3:

  o Tons of spell checks thanks to Miroslav Benes
  o Fixed a stupid bug where I was using the timeout without HZ as
    reported by Miroslav Benes
  o Enanced the tribal knowledge docs for the semaphore Vs mutex
    considerations folks might make as suggested by Matthew Wilcox
  o Added tags for patches

Luis Chamberlain (1):
  modules/kmod: replace implementation with a semaphore

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

