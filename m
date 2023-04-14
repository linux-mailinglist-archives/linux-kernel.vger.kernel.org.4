Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0476E2921
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDNRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjDNRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:17:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E135AA;
        Fri, 14 Apr 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3HOFuNsuGVoqF4T3OjWzrAAkX2klavHlrB4YyoEVapI=; b=YTXbS1xlcj8FcBaWMo0FtPuL+/
        Q/iTd1fMbg7k9DDh5hPJ+m7zGYI8JAFV3exc3f/znHwwzGjYtWUUWdRzZm6DSFelzBY7qlCx3luVX
        UkQbo2PuD2NleGtLLnBzwIOm1O8AYvSSzHPro4dXnALi3bTLpJ0lInAUNGCGOei8wSPGelph/sd3G
        DzPQmw49lM54pq9Q0grd/npKBiI+6N3l+KWP5kb5HY+CU+dPpALIQTlap2Nh+/xZ/zeneFCpFt1rQ
        +leqaRyoOioslLFZZxxzf+Lk08HGydap6kSzWK85unYJRdX9vvJXN8r1x9fCdlK0zzP4ktwi+4szt
        mwhmklzw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnN2k-00ADLX-2W;
        Fri, 14 Apr 2023 17:17:02 +0000
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
Subject: [PATCH v4 0/2] modules/kmod: replace implementation with a sempahore
Date:   Fri, 14 Apr 2023 10:16:42 -0700
Message-Id: <20230414171644.2434448-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on this v4:

  o Really add Matthew Wilcox' preferred tribal knowledge docs
  o Add all the pending tags

Changes on v3:

  o Tons of spell checks thanks to Miroslav Benes
  o Fixed a stupid bug where I was using the timeout without HZ as
    reported by Miroslav Benes
  o Enanced the tribal knowledge docs for the semaphore Vs mutex
    considerations folks might make as suggested by Matthew Wilcox
  o Added tags for patches   

Changes on v2:                                                                                                                                                                                   
  o split the series up into its own
  o adopt Peter's patch and extend it with some documentation as to why
    some folks stick to binary semaphores over mutexes
  o modify kmod.c to use the preferred declaration

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
 include/linux/semaphore.h                     | 10 +++++--
 kernel/module/kmod.c                          | 26 +++++--------------
 kernel/printk/printk.c                        |  2 +-
 net/rxrpc/call_object.c                       |  6 ++---
 13 files changed, 27 insertions(+), 35 deletions(-)

-- 
2.39.2

