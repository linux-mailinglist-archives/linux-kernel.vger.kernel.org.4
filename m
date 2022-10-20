Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8964A606A07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJTVFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJTVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4794402F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D286661D1C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE37C433C1;
        Thu, 20 Oct 2022 21:04:39 +0000 (UTC)
Date:   Thu, 20 Oct 2022 17:04:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [GIT PULL] rv/dot2c: Make automaton definition static
Message-ID: <20221020170444.2177b0b3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fix fell through the cracks.

Note, we are working on making "topic" branches for tracing. So we
will be having different pull requests for each topic.

Tracing/tools updates for 6.1-rc1:

- Make dot2c generate monitor's automata definition static


Please pull the latest trace-tools-6.1-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-6.1-rc1

Tag SHA1: 1ee5bf9e2eff62eb25ac0e904c1a48f7c55d26ff
Head SHA1: 21a1994b6492b12e55dbf39d15271430ef6839f0


Daniel Bristot de Oliveira (1):
      rv/dot2c: Make automaton definition static

----
 tools/verification/dot2/dot2c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 21a1994b6492b12e55dbf39d15271430ef6839f0
Author: Daniel Bristot de Oliveira <bristot@kernel.org>
Date:   Tue Aug 23 17:20:28 2022 +0200

    rv/dot2c: Make automaton definition static
    
    Monitor's automata definition is only used locally, so make dot2c generate
    a static definition.
    
    Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
    Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com
    Link: https://lkml.kernel.org/r/ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org
    
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Fixes: e3c9fc78f096 ("tools/rv: Add dot2c")
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index fa73353f7e56..be8a364a469b 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -111,7 +111,7 @@ class Dot2c(Automata):
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
