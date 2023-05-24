Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2B710015
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjEXVgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEXVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:36:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEEAC5;
        Wed, 24 May 2023 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WAKoqUN95n3fVgR2gHhetTOzf1TmlU2sJtM2C/TK2Mc=; b=zZvtruf52Q7ffeHQ5bphR02la/
        Fn8L4xH0iakr0/r8/YHx/Ep+FALG1qw7qd1rxcWBgVbm4dOIeSSgRBBIUdIjz6vs41eNWIIrErLb4
        ZCnmzF7lzqL/9kw71rXSrgim2ExYTBDqUqgnxCXwviRyZ+z8w/9ok2+xIi9w6DEV2ahxS6NKUPvVG
        PHfmLgw0iKB1YoF7VJwKcu2+0TcP605ieh40OgUtVQ9WFSXXFnFwY68mrQw6iC1wv0vGQXFWHabNq
        3EHp1IRfqwvGBePzAAQ4+hTRD9S3CuT6g4lfyFDFzIZiEzF2MLOiYCj9TfoTjpP67+gQAweqIVpA8
        OhqWrOjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1w9d-00EitF-0h;
        Wed, 24 May 2023 21:36:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, lennart@poettering.net
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, mcgrof@kernel.org
Subject: [PATCH 0/2] module: avoid all memory pressure due to duplicates
Date:   Wed, 24 May 2023 14:36:18 -0700
Message-Id: <20230524213620.3509138-1-mcgrof@kernel.org>
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

We now know that duplicate kernel module loading can incur considerable
vmalloc memory pressure on boot. Module loading uses vmalloc space 3 times
in the worst case. Detecting duplicates early before processing the module
name was the last mile we had to go and we recently were debating if userspace
should fix this or the kernel should fix this. We decided to punt the problem
to userspace.

At LSFMM 2023 in Vancouver this year I talked to Lennart Poettering about this
and described the issue with udev. Fixing this in userspace would be complex,
and it was preferable if we could resolve this in-kernel. And indeed it is
possible to resolve it relatively easily in-kernel with just the inode. So
let's do that and be done with the issue.

Patch #2 has the details on the savings on a 255 CPU system.

With this we get 0 bytes wasted incurred due to duplicates.

Luis Chamberlain (2):
  fs/kernel_read_file: add support for duplicate detection
  module: add support to avoid duplicates early on load

 fs/Kconfig                       |   3 +
 fs/kernel_read_file.c            | 124 +++++++++++++++++++++++++++++++
 include/linux/kernel_read_file.h |  14 ++++
 include/linux/module.h           |   1 +
 kernel/module/Kconfig            |  20 +++++
 kernel/module/internal.h         |   1 +
 kernel/module/main.c             |  19 +++--
 7 files changed, 175 insertions(+), 7 deletions(-)

-- 
2.39.2

