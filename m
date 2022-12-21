Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AA652AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLUAwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiLUAwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:52:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7771D66C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:52:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D22126162C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E65FC433F0;
        Wed, 21 Dec 2022 00:52:28 +0000 (UTC)
Date:   Tue, 20 Dec 2022 19:52:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alessandro Carminati <acarmina@redhat.com>
Subject: [for-linus][PATCH] rv/monitors: Move monitor structure in rodata
Message-ID: <20221220195226.13f244cc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Missed this patch in pulling in my queue for 6.2.

commit bfa87ac86ce9ff879c5ac49bf09c3999859a8968
Author: Alessandro Carminati <acarmina@redhat.com>
Date:   Tue Nov 22 18:36:48 2022 +0100

    rv/monitors: Move monitor structure in rodata
    
    It makes sense to move the important monitor structure into rodata to
    prevent accidental structure modification.
    
    Link: https://lkml.kernel.org/r/20221122173648.4732-1-acarmina@redhat.com
    
    Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
    Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index dacc37b62a2c..2e373f2c65ed 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -27,7 +27,7 @@ struct automaton_wip {
 	bool final_states[state_max_wip];
 };
 
-static struct automaton_wip automaton_wip = {
+static const struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
 		"non_preemptive"
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 118e576b91b4..d0d9c4b8121b 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -27,7 +27,7 @@ struct automaton_wwnr {
 	bool final_states[state_max_wwnr];
 };
 
-static struct automaton_wwnr automaton_wwnr = {
+static const struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
 		"running"
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index be8a364a469b..87d8a1e1470c 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -111,7 +111,7 @@ class Dot2c(Automata):
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append("static const struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
