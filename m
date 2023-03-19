Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8C6C05C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCSVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCSVtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8F12BDB;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=q1oyRes5negp+kybh6kzvflbB5TOrerfJ/RB+Q/Ch1s=; b=pZBIhHv7cXZDXF1lirrj303enp
        wklOMwjYCBzWyqsoMEOrnGgwfOuHf4hwPHl0aSu6eI9NQNmtARVfAk4RaWm+J+dC9jQ7Uw0IED6KV
        /OKpgOT6vD7SQf/520tL2tJlrjo+nzJH4lbhsHR7p0Yb2v0W+CrHX+PSwieOBnHFGULbzvXr4xhSl
        JQvSSXyo5YmPWQVfgFs6P8snnrYBWtrsgHnDoRmwOn/v6bv1DT2qAL9SuVC4ozdj4Pk63ZJ2UP9jY
        wkfMDIYHaXnSWOPBa91dq7dmwyYE9uKpo/G1bM7W733habsgyR62pce40IucVY2sPig2Bpz53R4sk
        rtf4EYxA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u7-007WjN-37;
        Sun, 19 Mar 2023 21:49:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 0/5] module: avoid userspace pressure on unwanted allocations
Date:   Sun, 19 Mar 2023 14:49:21 -0700
Message-Id: <20230319214926.1794108-1-mcgrof@kernel.org>
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

Finally this third patch set spins the first RFC I put out to help
reduce memory pressure [0]. It updates the commit log with some stats
obtained on a guest, but I need to do more tests on more systems and
then also with stress-ng. I posted a patch to run stress-ng for modules,
so it stresses running finit_module() [1]. Using that instead of
kmod test 0008 should be useful as that really puts some heavy load
without going through the kernel module auto-loader, that has a
restriction of just allowing 50 threads concurrently. The issue with
that stress test so far is that unloading doesn't seem to unload yet.

The last patch is purely for testing purposes and its value can only be
shown if it really does help the use case of a large system with many
CPUs. That situation is known currently to cuase issues with subsystems
which end up loading tons of the same drivers and so this tries to be
a bit defensive for subsystems that might need some love in this area.

I have two trees for this patchset, the first one had the ELF checker
and validity tests at the end [2], and the latest one re-adjusts the
ordering to put this patch set as the last series [3], in line with
the order in which I've submitted the patches. I had only run time
tested the patch order on [2] but it makes sense to put more of the
heavier functional changes at the very end, and request for further
testing.

[0] https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org
[1] https://lore.kernel.org/all/ZBUA6E3kYh0Xuu/c@bombadil.infradead.org/?q=stress-ng+mcgrof
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts

Luis Chamberlain (5):
  module: move finished_loading()
  module: extract patient module check into helper
  module: avoid allocation if module is already present and ready
  module: use list_add_tail_rcu() when adding module
  module: add a sanity check prior to allowing kernel module
    auto-loading

 kernel/module/internal.h |   1 +
 kernel/module/kmod.c     |   7 ++
 kernel/module/main.c     | 139 ++++++++++++++++++++++++---------------
 3 files changed, 93 insertions(+), 54 deletions(-)

-- 
2.39.1

