Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED46E1BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNF3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNF3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:29:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB15FCD;
        Thu, 13 Apr 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WTrjq/Hj7xVrgUTwXL4fhU02Kmf9Tqu/Teapat/Qe9U=; b=nrh5SDtLtFVCBqV9LcByXzOdcP
        fXhCPG9ig8aJsOG7gPetVfxNTBbuzPyZkskWLeKVsmjPcuEk2cCOfpxGR02jXC/fUzmWFnPsOyscd
        tc4Qi/T0dBYNpGiQzXWkCgMNGewsl84u+OBVY7+BPnz/UDbbg5Wo1OSWF5IVwBkE4C2kGI+NSmCn+
        Zd4jl1uWkAD/IEm/bTzZtoWpqT1F6I+jvwdCYcLyoAk1+9kA55qTZXnYD7bAe2zgwOUVnZUoeg4Pl
        9iQAxEaW6qucTufLGSa7Swyd2NQedIZfgXzGRsJOVGG30gme0xbCyDq4EiANSdnuqAM+e3dchOhRt
        KlPkdRUg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnBzK-008MsV-0U;
        Fri, 14 Apr 2023 05:28:46 +0000
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
Subject: [RFC 0/2] module: fix virtual memory wasted on finit_module()
Date:   Thu, 13 Apr 2023 22:28:38 -0700
Message-Id: <20230414052840.1994456-1-mcgrof@kernel.org>
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

The graph from my v3 patch series [0] which tries to resolve the virtual
memory lost bytes due to duplicates says it all:

         +----------------------------------------------------------------------------+
    14GB |-+          +            +            +           +           *+          +-|
         |                                                          ****              |
         |                                                       ***                  |
         |                                                     **                     |
    12GB |-+                                                 **                     +-|
         |                                                 **                         |
         |                                               **                           |
         |                                             **                             |
         |                                           **                               |
    10GB |-+                                       **                               +-|
         |                                       **                                   |
         |                                     **                                     |
         |                                   **                                       |
     8GB |-+                               **                                       +-|
waste    |                               **                             ###           |
         |                             **                           ####              |
         |                           **                      #######                  |
     6GB |-+                     ****                    ####                       +-|
         |                      *                    ####                             |
         |                     *                 ####                                 |
         |                *****              ####                                     |
     4GB |-+            **               ####                                       +-|
         |            **             ####                                             |
         |          **           ####                                                 |
         |        **         ####                                                     |
     2GB |-+    **      #####                                                       +-|
         |     *    ####                                                              |
         |    * ####                                                   Before ******* |
         |  **##      +            +            +           +           After ####### |
         +----------------------------------------------------------------------------+
         0            50          100          150         200          250          300
                                          CPUs count

So we really need to debug to see WTF, because really, WTF. The first
patch tries to answer the question if the issue is module auto-loading
being abused and that causing the issues. The patch proves that the
answer is no, but it does also help us find *a few* requests which can
get a bit of love to avoid duplicates. My system at least found one. So
it adds a debugging facility to let you do that.

As I was writing the commit log for my first patch series [0] I was noting
that this is it... and the obvious conclusion is that the culprit is udev
issuing requests per CPU for tons of modules. I didn't feel comfortable in
writing that this is it and we can't really do anything before really
trying hard. So I gave it a good 'ol college try. At first I wondered if
we could use file descriptor hints to just exlude users early on boot
before SYSTEM_RUNNING. I couldn't find much, but if there are some ways
to do that -- then the last patch can be simplified to do just that.
The second patch proves essentially that we can just send -EBUSY to
duplicate requests, at least for duplicate module loads and the world
doesn't fall apart. It *would* solve the issue. The patch however
borrows tons of the code from the first, and if we're realy going to
rely on something like that we may as well share. But I'm hopeful that
perhaps there are some jucier file descriptor tricks we can use to
just make a file mutually exlusivive and introduce a new kread which
lets finit_module() use that. The saving grace is that at least all
finit_module() calls *wait*, contray to request_module() calls and so
the solution can be much simpler.

The end result is 0 wasted virtual memory bytes.

Any ideas how not to make patch 2 suck as-is ?

Yes -- we can also go fix udev, or libkmod, and that's what should be
done. However, it seems silly to not fix if the fix is as trivial as
patch 2 demonstrates.

If you want to test / muck with all this you can use my branch
20230413-module-alloc-opts [1]:

[0] https://lkml.kernel.org/r/20230414050836.1984746-1-mcgrof@kernel.org
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230413-module-alloc-opts

Luis Chamberlain (2):
  module: add debugging auto-load duplicate module support
  kread: avoid duplicates

 fs/kernel_read_file.c    | 150 +++++++++++++++++++++++++
 kernel/module/Kconfig    |  40 +++++++
 kernel/module/Makefile   |   1 +
 kernel/module/dups.c     | 234 +++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h |  15 +++
 kernel/module/kmod.c     |  23 +++-
 kernel/module/main.c     |   6 +-
 7 files changed, 463 insertions(+), 6 deletions(-)
 create mode 100644 kernel/module/dups.c

-- 
2.39.2

