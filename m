Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8B603019
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJRPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiJRPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910CC96DF;
        Tue, 18 Oct 2022 08:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7F161553;
        Tue, 18 Oct 2022 15:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAF7C433B5;
        Tue, 18 Oct 2022 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108159;
        bh=Se1jgISa/ShCTPfJ44VmplkGxxjQVjFu0CQ3G/F1Jts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p80qb6SqOk2bAztterNKvKM1efYuyA7UcmMPFQUbfGniRC9XQF3qNVweqGx0lfwRQ
         C0FdZVOl504+BXTO2Us1HWumNIvFjZ9r+ZDyYSHJcpnTcnIvnoAezFK2k+Of/dmXO9
         C6hOw28Sm+omxzbMKWbbFp1HgOu4sgqvPwERy/PbaTdt2ig2eJNH+yZ1nWFke8UlKn
         tasl+dXZXh43631Dq3QFt8oJ62mDSHZbD45kL4SPKi1Q8POsLWnnMls8o8AmwDzcTG
         6potF/gD2A0DoKjwsbW0/fNh5YhgGJQZr2YgMUwrLJo1MaWXBlKGKiELx1hDrUUNBz
         ufdl184sW4SXA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'
Date:   Wed, 19 Oct 2022 00:49:16 +0900
Message-Id: <166610815604.56030.4124933216911828519.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166610811353.56030.10023036046735082272.stgit@devnote2>
References: <166610811353.56030.10023036046735082272.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Update histogram document for .percent/.graph suffixes and 'nohitcount'
option.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/histogram.rst |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 859fd1b76c63..b2da4e9c62e8 100644
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

