Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA86F16F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbjD1Lnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjD1Lni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D634527E;
        Fri, 28 Apr 2023 04:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B08C6164B;
        Fri, 28 Apr 2023 11:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9643BC433D2;
        Fri, 28 Apr 2023 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682682216;
        bh=TVVIq4lzr9bsO6ulKf/8nLSnB2gElMuLQd5D9aQ0yBQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KE5VOs9kq3isj4iX5gVsWs7/Iw1HPAdfDdmWdEIjC8iIwDiv7B5Bg6pjYfRia/DAy
         SRbUafjNdUJCVjgXAi2iKRIzpVWdHFoscN4otY5Yv/EZJ5E/who2E8JQEdH1qqXwdM
         27x3wlarLFDj2yFeLhJRhAOIOLFwveCxvWexCMg9WQR9d2xDXp7byPbRhvV6BsegO2
         6tNuGZ/eXuucqo9jQqIMoN9TmQG2RrSY+VOGN+nhJ7Ns+nluujxUeklTZ89Xc+Iprm
         Yryu04l4Pyy78YqiWKvB9TF9pFL0Ax7yzQa2HIDsAKCjdJrZIoNgwK5gUaxrZVs8wH
         OZewdKq375WVw==
From:   broonie@kernel.org
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Florent Revest <revest@chromium.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qing Zhang <zhangqing@loongson.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Youling Tang <tangyouling@loongson.cn>
Subject: linux-next: manual merge of the loongarch tree with the origin tree
Date:   Fri, 28 Apr 2023 12:43:31 +0100
Message-Id: <20230428114331.41923-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the loongarch tree got conflicts in:

  samples/ftrace/ftrace-direct-modify.c
  samples/ftrace/ftrace-direct-too.c
  samples/ftrace/ftrace-direct.c

between commits:

  23edf48309b14 ("ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi")
  da8bdfbd42233 ("ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs")

from the origin tree and commit:

  89451e0111632 ("LoongArch: ftrace: Add direct call trampoline samples support")

from the loongarch tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc samples/ftrace/ftrace-direct-modify.c
index 25fba66f61c05,ca72c3b710eb5..0000000000000
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@@ -96,8 -96,40 +96,42 @@@ asm 
  
  #endif /* CONFIG_S390 */
  
+ #ifdef CONFIG_LOONGARCH
+ 
+ asm (
+ "	.pushsection    .text, \"ax\", @progbits\n"
+ "	.type		my_tramp1, @function\n"
+ "	.globl		my_tramp1\n"
+ "   my_tramp1:\n"
+ "	addi.d	$sp, $sp, -16\n"
+ "	st.d	$t0, $sp, 0\n"
+ "	st.d	$ra, $sp, 8\n"
+ "	bl	my_direct_func1\n"
+ "	ld.d	$t0, $sp, 0\n"
+ "	ld.d	$ra, $sp, 8\n"
+ "	addi.d	$sp, $sp, 16\n"
+ "	jr	$t0\n"
+ "	.size		my_tramp1, .-my_tramp1\n"
+ 
+ "	.type		my_tramp2, @function\n"
+ "	.globl		my_tramp2\n"
+ "   my_tramp2:\n"
+ "	addi.d	$sp, $sp, -16\n"
+ "	st.d	$t0, $sp, 0\n"
+ "	st.d	$ra, $sp, 8\n"
+ "	bl	my_direct_func2\n"
+ "	ld.d	$t0, $sp, 0\n"
+ "	ld.d	$ra, $sp, 8\n"
+ "	addi.d	$sp, $sp, 16\n"
+ "	jr	$t0\n"
+ "	.size		my_tramp2, .-my_tramp2\n"
+ "	.popsection\n"
+ );
+ 
+ #endif /* CONFIG_LOONGARCH */
+ 
 +static struct ftrace_ops direct;
 +
  static unsigned long my_tramp = (unsigned long)my_tramp1;
  static unsigned long tramps[2] = {
  	(unsigned long)my_tramp1,
diff --cc samples/ftrace/ftrace-direct-too.c
index f28e7b99840f0,ef64d75097737..0000000000000
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@@ -70,13 -70,37 +70,40 @@@ asm 
  
  #endif /* CONFIG_S390 */
  
+ #ifdef CONFIG_LOONGARCH
+ 
+ asm (
+ "	.pushsection	.text, \"ax\", @progbits\n"
+ "	.type		my_tramp, @function\n"
+ "	.globl		my_tramp\n"
+ "   my_tramp:\n"
+ "	addi.d	$sp, $sp, -48\n"
+ "	st.d	$a0, $sp, 0\n"
+ "	st.d	$a1, $sp, 8\n"
+ "	st.d	$a2, $sp, 16\n"
+ "	st.d	$t0, $sp, 24\n"
+ "	st.d	$ra, $sp, 32\n"
+ "	bl	my_direct_func\n"
+ "	ld.d	$a0, $sp, 0\n"
+ "	ld.d	$a1, $sp, 8\n"
+ "	ld.d	$a2, $sp, 16\n"
+ "	ld.d	$t0, $sp, 24\n"
+ "	ld.d	$ra, $sp, 32\n"
+ "	addi.d	$sp, $sp, 48\n"
+ "	jr	$t0\n"
+ "	.size		my_tramp, .-my_tramp\n"
+ "	.popsection\n"
+ );
+ 
+ #endif /* CONFIG_LOONGARCH */
+ 
 +static struct ftrace_ops direct;
 +
  static int __init ftrace_direct_init(void)
  {
 -	return register_ftrace_direct((unsigned long)handle_mm_fault,
 -				     (unsigned long)my_tramp);
 +	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
 +
 +	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
  }
  
  static void __exit ftrace_direct_exit(void)
diff --cc samples/ftrace/ftrace-direct.c
index d81a9473b5851,9be720957bf8d..0000000000000
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@@ -63,13 -63,33 +63,36 @@@ asm 
  
  #endif /* CONFIG_S390 */
  
+ #ifdef CONFIG_LOONGARCH
+ 
+ asm (
+ "	.pushsection	.text, \"ax\", @progbits\n"
+ "	.type		my_tramp, @function\n"
+ "	.globl		my_tramp\n"
+ "   my_tramp:\n"
+ "	addi.d	$sp, $sp, -32\n"
+ "	st.d	$a0, $sp, 0\n"
+ "	st.d	$t0, $sp, 8\n"
+ "	st.d	$ra, $sp, 16\n"
+ "	bl	my_direct_func\n"
+ "	ld.d	$a0, $sp, 0\n"
+ "	ld.d	$t0, $sp, 8\n"
+ "	ld.d	$ra, $sp, 16\n"
+ "	addi.d	$sp, $sp, 32\n"
+ "	jr	$t0\n"
+ "	.size		my_tramp, .-my_tramp\n"
+ "	.popsection\n"
+ );
+ 
+ #endif /* CONFIG_LOONGARCH */
+ 
 +static struct ftrace_ops direct;
 +
  static int __init ftrace_direct_init(void)
  {
 -	return register_ftrace_direct((unsigned long)wake_up_process,
 -				     (unsigned long)my_tramp);
 +	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 +
 +	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
  }
  
  static void __exit ftrace_direct_exit(void)
