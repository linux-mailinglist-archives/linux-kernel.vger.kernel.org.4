Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4541B62DD17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiKQNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiKQNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:46:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B871F2C;
        Thu, 17 Nov 2022 05:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3907EB8206F;
        Thu, 17 Nov 2022 13:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435A9C43470;
        Thu, 17 Nov 2022 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668692787;
        bh=EecJOGEYPYmhzQXRbQW6amNA4J6GI5CRTrUe6xQE9Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD94cs96rvcv+HTKDHtXHBa9557YsZ1cfJAdiIgKhDrQUljrl2odEWzQBEG3P+XCw
         kV+NOMlKb30H4p34KAQr2EB5mHAxV1Mt/rPdRF6iIxpjtULTOGXlDgpkxuQigmC8Qk
         ic1CM3D/92pjBxit6yL62I+PAQBvodcazJMRoTCf+FC9ksy4hvyqvHG3gtoHL6lrLg
         qfI1He2OkgzqGoeaDlFkuH2gazPIIho7egqa5lO/qVrQ3p9Y5YK9EajtD6va3ir1Bj
         shH7miKRiFm5EI6g87OQac6FPL69xgYqodJ8Gg9MJvK2h4NmOMib2egyWeoR5UHirj
         T0Ak79YuHK7Ew==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing/osnoise: Fix duration type
Date:   Thu, 17 Nov 2022 14:46:17 +0100
Message-Id: <a93d8a8378c7973e9c609de05826533c9e977939.1668692096.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1668692096.git.bristot@kernel.org>
References: <cover.1668692096.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The duration type is a 64 long value, not an int. This was
causing some long noise to report wrong values.

Change the duration to a 64 bits value.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 78d536d3ff3d..4300c5dc4e5d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -917,7 +917,7 @@ void osnoise_trace_irq_entry(int id)
 void osnoise_trace_irq_exit(int id, const char *desc)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
@@ -1048,7 +1048,7 @@ static void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
 static void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
@@ -1144,7 +1144,7 @@ thread_entry(struct osnoise_variables *osn_var, struct task_struct *t)
 static void
 thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
 {
-	int duration;
+	s64 duration;
 
 	if (!osn_var->sampling)
 		return;
-- 
2.32.0

