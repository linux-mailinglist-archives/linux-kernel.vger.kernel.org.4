Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F386CD18B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC2FaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC2FaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:30:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E1F30FF;
        Tue, 28 Mar 2023 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KLOfytIcH4rEmrgbqWZrqXW6JlCkVbvgRIm3hytVuTY=; b=ROoiZKyehNzSjwkNI60IK7yKO7
        fOShguZIG/ospXSSDk5eEl2XgDhWH+t3YLln9yz3Eu+U+U0PnmCImMTsaMdd2gqKmkEW97UnW2LzB
        bXtZoyCMVOZFDnQVwJW/nNFXK31HjX08x/i16yhJH/PNXN4v8qlY5kNCny/oS4h4XLM4PplwVPd9S
        wsOdcAB0JV/FWLrUYOn5xtbiBHV1n77NaYnB9+Mi/J+ypZMgFY3GQ9pa9c1Jm3VppJYgx2HIlxJic
        kUXFPGW30t+0wt5vVEepKimb/zrDGgRwkJTUauNwO1EARsVUF20ln+ylwOC35REIYqDbAnk4toKD8
        kNlGQwnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phONf-00Gfy0-2S;
        Wed, 29 Mar 2023 05:29:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, mcgrof@kernel.org
Subject: [PATCH 0/7] module: avoid userspace pressure on unwanted allocations
Date:   Tue, 28 Mar 2023 22:29:54 -0700
Message-Id: <20230329052954.3974542-1-mcgrof@kernel.org>
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

This patch set addresses a fix to the vmap allocation presure issues which
David Hildenbrand had reported last year in October. While at it,
I've simplified the kmod concurrency delimiter using Linus' suggestion,
and added debugfs stats to help us keep sane in doing analysis for memory
pressure issues on the finit_module() side of things. That should *also*
help do an empirical evaluation of module .text sizes *actually* present
on systems, given userspace makes it a bit tricky to get that right.

All this would not have been possible without stress-ng and Colin Ian King's
help to getting a modules ops in shape so to reproduce a situation only
reported so far on a system with over 400 CPUs.

I *think* the degugfs stats *should* probably be used to help identify
areas where we perhaps need *more work* to try to mitigate vmalloc()
space, as in the worst case we can end up using vmap space 3 times for
a single module, two just as big as the module, and if you are enabling
compression one with the compressed module size. That's significant memory
pressure on vmalloc() / vmap() space.

If you'd like to give this a spin this is available on my branch based on
modules-next 20230328-module-alloc-opts [2].

[0] https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com
[1] https://github.com/ColinIanKing/stress-ng
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230328-module-alloc-opts

Luis Chamberlain (7):
  module: move finished_loading()
  module: extract patient module check into helper
  module: avoid allocation if module is already present and ready
  sempahore: add a helper for a concurrency limiter
  modules/kmod: replace implementation with a sempahore
  debugfs: add debugfs_create_atomic64_t for atomic64_t
  module: add debug stats to help identify memory pressure

 fs/debugfs/file.c         |  36 +++++++
 include/linux/debugfs.h   |   2 +
 include/linux/semaphore.h |   3 +
 kernel/module/Kconfig     |  32 ++++++
 kernel/module/Makefile    |   4 +
 kernel/module/debug.c     |  16 +++
 kernel/module/internal.h  |  35 +++++++
 kernel/module/kmod.c      |  26 ++---
 kernel/module/main.c      | 164 ++++++++++++++++++++-----------
 kernel/module/stats.c     | 200 ++++++++++++++++++++++++++++++++++++++
 kernel/module/tracking.c  |   7 +-
 11 files changed, 445 insertions(+), 80 deletions(-)
 create mode 100644 kernel/module/debug.c
 create mode 100644 kernel/module/stats.c

-- 
2.39.2

