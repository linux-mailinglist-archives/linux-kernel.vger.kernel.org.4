Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F8263668C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiKWRGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiKWRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:06:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA8A9963;
        Wed, 23 Nov 2022 09:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1804361DF7;
        Wed, 23 Nov 2022 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CDC433D6;
        Wed, 23 Nov 2022 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669223192;
        bh=Bv+gg9QsVueJO7E+n5Q2iX6/w77b8aeX5SBwgMpol3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ml5eeCLV3q9PB5lnsVbFjpEZNZfEthRtv6kmtwD/gl7fqVM+CnAhx1hkxr42fOJzC
         6zGXYhy0ClkCfve+FJnXp98fdTdxa2gEOgayNaw+fk45fMoYP0/O2caP3yrlg4zLTL
         P8X/HB5GI8dn/cn872xr/itsAcLDUykhkDbzkChVyQLTgxMwkMRGmxv6k557emQG1O
         2Pc7omffgZtUltUfee0ePvkQrKzdZfIOB8DzbXMR0cbkYcOXLgTQQRx1J7eMz0RlKl
         M5YbixpK9BwcPBt8J0w0BswMo3XwCZyGlx/fm06760eW/Dr0N9iJCx6XKnZ45DOFv5
         Eu2kpvo2Zd/kA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] tracing/osnoise: Fix duration type
Date:   Wed, 23 Nov 2022 18:06:19 +0100
Message-Id: <eb25d7d2735ee3d2b0b5c262321dc13bed10ccbf.1669115208.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1669115208.git.bristot@kernel.org>
References: <cover.1669115208.git.bristot@kernel.org>
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
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

