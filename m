Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A16F6CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjEDNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjEDNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B077DA7;
        Thu,  4 May 2023 06:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7396341A;
        Thu,  4 May 2023 13:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E81C4339B;
        Thu,  4 May 2023 13:18:27 +0000 (UTC)
From:   Mark Brown <broonie@finisterre.sirena.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the tip tree with the origin tree
Date:   Thu,  4 May 2023 22:18:24 +0900
Message-Id: <20230504131824.182744-1-broonie@finisterre.sirena.org.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/entry/syscalls/syscall_64.tbl

between commit:

  5c289a59b1d08 ("cachestat: implement cachestat syscall")

from the origin tree and commit:

  a9d48cbbcc40b ("x86/shstk: Introduce map_shadow_stack syscall")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 227538b0ce801,f65c671ce3b14..0000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -372,7 -372,7 +372,8 @@@
  448	common	process_mrelease	sys_process_mrelease
  449	common	futex_waitv		sys_futex_waitv
  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 -451	64	map_shadow_stack	sys_map_shadow_stack
 +451	common	cachestat		sys_cachestat
++452	64	map_shadow_stack	sys_map_shadow_stack
  
  #
  # Due to a historical design error, certain syscalls are numbered differently
