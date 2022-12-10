Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5F648F03
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLJN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLJN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0F15A1F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F73060C1D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BA3C433B3;
        Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40My-000koK-1w;
        Sat, 10 Dec 2022 08:58:24 -0500
Message-ID: <20221210135824.466047951@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 08/25] tracing: docs: Update histogram doc for .percent/.graph and
 nohitcount
References: <20221210135750.425719934@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Update histogram document for .percent/.graph suffixes and 'nohitcount'
option.

Link: https://lore.kernel.org/linux-trace-kernel/166610815604.56030.4124933216911828519.stgit@devnote2

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/histogram.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 87bd772836c0..f95459aa984f 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -25,7 +25,7 @@ Documentation written by Tom Zanussi
 
         hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
           [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
-          [:clear][:name=histname1][:<handler>.<action>] [if <filter>]
+          [:clear][:name=histname1][:nohitcount][:<handler>.<action>] [if <filter>]
 
   When a matching event is hit, an entry is added to a hash table
   using the key(s) and value(s) named.  Keys and values correspond to
@@ -79,6 +79,8 @@ Documentation written by Tom Zanussi
 	.log2          display log2 value rather than raw number
 	.buckets=size  display grouping of values rather than raw number
 	.usecs         display a common_timestamp in microseconds
+        .percent       display a number of percentage value
+        .graph         display a bar-graph of a value
 	=============  =================================================
 
   Note that in general the semantics of a given field aren't
@@ -137,6 +139,12 @@ Documentation written by Tom Zanussi
   existing trigger, rather than via the '>' operator, which will cause
   the trigger to be removed through truncation.
 
+  The 'nohitcount' (or NOHC) parameter will suppress display of
+  raw hitcount in the histogram. This option requires at least one
+  value field which is not a 'raw hitcount'. For example,
+  'hist:...:vals=hitcount:nohitcount' is rejected, but
+  'hist:...:vals=hitcount.percent:nohitcount' is OK.
+
 - enable_hist/disable_hist
 
   The enable_hist and disable_hist triggers can be used to have one
-- 
2.35.1


