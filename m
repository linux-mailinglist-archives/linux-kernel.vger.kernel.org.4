Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48E6B587E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCKFRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCKFRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CA140507;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=G7D4vwbmdXJTfyX+mz4IpTA/4Mn1YMJVyYwpWdRSXRc=; b=wPV2ZKbScOLTUdLYEFrmuJfSCJ
        YYwOp0CtVE0Tkbt8LthQva2www9a40XKPaLpJjJk+YmzHt7IMLI/dJg1xJddnpW8QusXe+aFsLToh
        W7risZHC6iYT6BZ4V2vvN4Prnz66Z1TIYrVrd4wpAjamVX0V3RME65R4kd2SAnA0FWajP2V+piOzW
        drLAZz6cLz8XizQ9a/EeoJWWteSzgefGzad6J/xOhzmCJsaSE+ezSCr0LKMaLQxZj1h5t5SbeE8FZ
        R5X+Na+kUxRfnFOw7N2tpVoPoshKrd5/pU12+qgBrTGcB5q8ONlRxFrSEwJOuV32ZRUhjXoQpti+t
        R/ZlCwYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMm-0G; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
Date:   Fri, 10 Mar 2023 21:17:00 -0800
Message-Id: <20230311051712.4095040-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A long time ago we had some issues with userspace doing stupid stuff.
Well, it turns out even the kernel and do stupid stuff too, as we're
learning with the ACPI modules aliaes and that hammering tons of loads.

So add a bit of code which gets us a bit more in the defensive about
these situations.

To experiment, this also adds in-kernel alias support to see if this helps
with some larger systems.

This is all based on some old code which tried to add defensive
mechanisms the last of which was here and I had dropped the ball:

https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/

I've only compile tested this for now. Will need to stress to test
with kmod tests 0008 and 0009 to see if there's any differences.
I'll have to re-test and re-gnuplot stuff there. But early feedback
is appreciated, hence the RFC.

David Hildenbrand had reported a while ago issues with userspace
doing insane things with allocations bringing a system down to
its knees. This is part of the motivation for this series.

I repeat, I only have compiled tested this so far.

A few Suggested-by there linger since Linus had suggested a few of
these ideas a long time ago and we just never picked them up.

Luis Chamberlain (12):
  module: use goto errors on check_modinfo() and layout_and_allocate()
  module: move get_modinfo() helpers all above
  module: rename next_string() to module_next_tag_pair()
  module: add a for_each_modinfo_entry()
  module: add debugging alias parsing support
  module: move early sanity checks into a helper
  module: move check_modinfo() early to early_mod_check()
  module: move finished_loading()
  module: extract patient module check into helper
  module: avoid allocation if module is already present and ready
  module: use list_add_tail_rcu() when adding module
  module: use aliases to find module on find_module_all()

 include/linux/module.h   |   4 +
 kernel/module/Kconfig    |  19 +++
 kernel/module/Makefile   |   1 +
 kernel/module/aliases.c  | 109 +++++++++++++
 kernel/module/internal.h |  25 +++
 kernel/module/main.c     | 324 +++++++++++++++++++++++----------------
 6 files changed, 346 insertions(+), 136 deletions(-)
 create mode 100644 kernel/module/aliases.c

-- 
2.39.1

