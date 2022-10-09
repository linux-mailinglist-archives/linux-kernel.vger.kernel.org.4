Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08A5F8A97
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJIKbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIKbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CED2AE07
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665311490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ur59h4Gzxec5OQKFCImezmA3LfEStLslhTEwx4u0Fao=;
        b=P8r6r7P/jCL1za1AZ5o6t5VnNAJkSYpp7GqMoW/teXYRK9D9bSA76gSpMqFxdcSU5k0m3+
        QNTfJH8YK0POSWXnct8qt/MlcJFJGncpvyfIf+P3YpQJR+mkrwJjp47bAHVA8vuIGzTe/b
        VqR4eYSTbAPgtvIeWYZyKgcjE/z3Scc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-iycmVzFSPTiBfeboNOpbog-1; Sun, 09 Oct 2022 06:31:24 -0400
X-MC-Unique: iycmVzFSPTiBfeboNOpbog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B44B529AB3FB;
        Sun,  9 Oct 2022 10:31:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FF0840D298B;
        Sun,  9 Oct 2022 10:31:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, bhe@redhat.com
Subject: [PATCH v3 00/11] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way
Date:   Sun,  9 Oct 2022 18:31:03 +0800
Message-Id: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, many architecutres have't taken the standard GENERIC_IOREMAP
way to implement ioremap_prot(), iounmap(), and ioremap_xx(), but make
these functions specifically under each arch's folder. Those cause many
duplicated codes of ioremap() and iounmap().

In this patchset, firstly adapt the hooks io[re|un]map_allowed, then
make use of them to convert those ARCH-es to take GENERIC_IOREMAP method.
With these change, duplicated ioremap/iounmap() code uder ARCH-es are
removed.

This is suggested by Christoph in below discussion:
https://lore.kernel.org/all/Yp7h0Jv6vpgt6xdZ@infradead.org/T/#u

And it's basically further action after arm64 has converted to
GENERIC_IOREMAP way in below patchset.
[PATCH v5 0/6] arm64: Cleanup ioremap() and support ioremap_prot()
https://lore.kernel.org/all/20220607125027.44946-1-wangkefeng.wang@huawei.com/T/#u

v2->v3:
- Rewrite log of all patches to add more details as Christoph suggested.

- Merge the old patch 1 and 2 which adjusts return values and
  parameters of arch_ioremap() into one patch, namely the current
  patch 3. Christoph suggested this.

- Change the return value of arch_iounmap() to bool type since we only
  do arch specific address filtering or address checking, bool value
  can reflect the checking better. This is pointed out by Niklas when
  he reviewed the s390 patch.
  
- Put hexagon patch at the beginning of patchset since hexagon has the
  same ioremap() and iounmap() as standard ones, no arch_ioremap() and
  arch_iounmap() hooks need be introduced. So the later arch_ioremap
  and arch_iounmap() adjustment are not related in hexagon. Christophe
  suggested this.

- Remove the early ioremap code from openrisc ioremap() firstly since
  openrisc doesn't have early ioremap handling in openrisc arch code. 
  This simplifies the later converting to GENERIC_IOREMAP method.
  Christoph and Stafford suggersted this.

- Fix compiling erorrs reported by lkp in parisc and sh patches.
  Adding macro defintions for those port|mem io functions in
  <asm/io.h> to avoid repeated definition in <asm-generic/io.h>.

v1->v2:
- Rename io[re|un]map_allowed() to arch_io[re|un]map() and made
  some minor changes in patch 1~2 as per Alexander and Kefeng's
  suggestions. Accordingly, adjust patches~4~11 because of the renaming
  arch_io[re|un]map().

Testing:
- It's running well on arm64 system with the latest upstream kernel
  and this patchset applied.
- Cross compiling passed on arc, ia64, parisc, s390, sh, xtensa.
- cross compiling is not tried on hexagon and openrisc because
  - Didn't find cross compiling tools for hexagon;
  - there's error with openrisc compiling, while I have no idea how to
    fix it. Please see below pasted log:
    ---------------------------------------------------------------------
    [root@intel-knightslanding-lb-02 linux]# make ARCH=openrisc defconfig
    *** Default configuration is based on 'or1ksim_defconfig'
    #
    # configuration written to .config
    #
    [root@intel-knightslanding-lb-02 linux]# make ARCH=openrisc -j320 CROSS_COMPILE=/usr/bin/openrisc-linux-gnu-
      SYNC    include/config/auto.conf.cmd
      CC      scripts/mod/empty.o
    ./scripts/check-local-export: /usr/bin/openrisc-linux-gnu-nm failed
    make[1]: *** [scripts/Makefile.build:250: scripts/mod/empty.o] Error 1
    make[1]: *** Deleting file 'scripts/mod/empty.o'
    make: *** [Makefile:1275: prepare0] Error 2
    ----------------------------------------------------------------------

Baoquan He (11):
  hexagon: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: remove unneeded early ioremap code
  mm/ioremap: change the return value of io[re|un]map_allowed and rename
  mm: ioremap: allow ARCH to have its own ioremap definition
  arc: mm: Convert to GENERIC_IOREMAP
  ia64: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: Convert to GENERIC_IOREMAP
  parisc: mm: Convert to GENERIC_IOREMAP
  s390: mm: Convert to GENERIC_IOREMAP
  sh: mm: Convert to GENERIC_IOREMAP
  xtensa: mm: Convert to GENERIC_IOREMAP

 arch/arc/Kconfig                  |  1 +
 arch/arc/include/asm/io.h         | 19 ++++++---
 arch/arc/mm/ioremap.c             | 60 ++++-----------------------
 arch/arm64/include/asm/io.h       |  5 ++-
 arch/arm64/mm/ioremap.c           | 16 +++++---
 arch/hexagon/Kconfig              |  1 +
 arch/hexagon/include/asm/io.h     |  9 ++++-
 arch/hexagon/mm/ioremap.c         | 44 --------------------
 arch/ia64/Kconfig                 |  1 +
 arch/ia64/include/asm/io.h        | 26 +++++++-----
 arch/ia64/mm/ioremap.c            | 50 +++++------------------
 arch/openrisc/Kconfig             |  1 +
 arch/openrisc/include/asm/io.h    | 12 ++++--
 arch/openrisc/mm/ioremap.c        | 62 ++--------------------------
 arch/parisc/Kconfig               |  1 +
 arch/parisc/include/asm/io.h      | 19 ++++++---
 arch/parisc/mm/ioremap.c          | 65 +++---------------------------
 arch/s390/Kconfig                 |  1 +
 arch/s390/include/asm/io.h        | 25 +++++++-----
 arch/s390/pci/pci.c               | 65 ++++++------------------------
 arch/sh/Kconfig                   |  1 +
 arch/sh/include/asm/io.h          | 67 +++++++++++++++++--------------
 arch/sh/include/asm/io_noioport.h |  7 ++++
 arch/sh/mm/ioremap.c              | 63 ++++++-----------------------
 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/include/asm/io.h      | 39 ++++++++----------
 arch/xtensa/mm/ioremap.c          | 56 ++++++--------------------
 include/asm-generic/io.h          | 30 ++++++++------
 mm/ioremap.c                      | 13 ++++--
 29 files changed, 248 insertions(+), 512 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

-- 
2.34.1

