Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88EB733FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjFQJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjFQJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19142D57;
        Sat, 17 Jun 2023 02:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C8760FD3;
        Sat, 17 Jun 2023 09:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B76C433C8;
        Sat, 17 Jun 2023 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686995257;
        bh=CcwbWOQ4OramJFaq7GvKNk6UZrAxKnsXUYiWXTp2YLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omINw6hIKCE2V19jvlvAfpBxjFVYhWclregmAAU1iGSkUXgOf3qDsbaFO69ELoKHv
         fOHMkmYQ2cYVbLZkSlYMiU4nblxel71wYMYUZpAo+OHKcPcDe6nlPDpwjTO3EzVPPu
         chZpCnKSG9i/Ixr3uchf6NzpH6LL8I9JeOrUCNSVJG5ZGT2LfHGEfF+MbXeCQey17s
         AuuTSvv4cNHwThdoQXzOL3VPOpxMhJPnEjckjiInCtpT/D3KbveOl0ygUTYsnuHBq8
         DkkE47kBmzQ59JSqg5xzUtCw1CI04eztT2GiwXrOuTXR9rhSR66/czjNQNwRyf4Hpu
         DYiO0g/TVXUNg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org
Subject: [PATCH 4/5] selftests/ftrace: Add BTF fields access testcases
Date:   Sat, 17 Jun 2023 18:47:34 +0900
Message-ID:  <168699525410.528797.4712561681569320532.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
References:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases for accessing the data structure fields using BTF info.
This includes the field access from parameters and retval, and accessing
string information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index b89de1771655..1c46906ebf54 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -21,6 +21,8 @@ echo 0 > events/enable
 echo > dynamic_events
 
 TP=kfree
+TP2=kmem_cache_alloc
+TP3=getname_flags
 
 if [ "$FPROBES" ] ; then
 echo "f:fpevent $TP object" >> dynamic_events
@@ -33,6 +35,7 @@ echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg1' >> dynamic_events
 grep -q "fpevent.*object=object" dynamic_events
+
 echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg*' >> dynamic_events
@@ -45,6 +48,14 @@ fi
 
 echo > dynamic_events
 
+echo "t:tpevent $TP2 name=s->name:string" >> dynamic_events
+echo "f:fpevent ${TP3}%return path=retval->name:string" >> dynamic_events
+
+grep -q "tpevent.*name=s->name:string" dynamic_events
+grep -q "fpevent.*path=retval->name:string" dynamic_events
+
+echo > dynamic_events
+
 if [ "$KPROBES" ] ; then
 echo "p:kpevent $TP object" >> dynamic_events
 grep -q "kpevent.*object=object" dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 812f5b3f6055..c948095d0d15 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -103,6 +103,10 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
 check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'f kfree%return ^$retval'		# NO_RETVAL
+check_error 'f vfs_read%return retval->^foo'	# NO_PTR_STRCT
+check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
+check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
+check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
 else
 check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
 check_error 't kfree ^$arg*'			# NOSUP_BTFARG

