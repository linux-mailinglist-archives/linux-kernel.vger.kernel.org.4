Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71511664D09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAJUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAJUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:08:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC62D1;
        Tue, 10 Jan 2023 12:08:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9845B8197F;
        Tue, 10 Jan 2023 20:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B6AC433F0;
        Tue, 10 Jan 2023 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673381304;
        bh=HUp0DzrBJhEg098mAGHnx7aoj0shJFUV+i6XYx2y+04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtJK/8ZyfQbnMQeQJz+X37II6DDOdwT1bgc3lLt5k610wUyodg+S/r9YX4A7geXm1
         HeKSKMSJDaOxwM/FlopIixGkhr6rFOp4rxK+gyI9gMvfAgzLokVx5ZgmEbusqFFm0Z
         ODJZLOOEWamxGPI610mEsEK61B8p2LvRiSDFlp+b506BBc7KZqmiSdfR6Sv7LxCMxn
         rLIRds/10H/qxXJhjqQTPhK/fPoxv0uXq3RZWd2xsxMKXn7EFOn3Ka3a1yDbgFPUl+
         N6hf7i5tnlThAqxh6WL65r5q1WWJObJZH0JQV07teR26gTLKoILbc5npkiZwsKWf5I
         0enJWVmFvmFTw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] rtla/osnoise: Add OSNOISE_IRQ_DISABLE option
Date:   Tue, 10 Jan 2023 21:08:03 +0100
Message-Id: <5e5cede08247fe55f4a66ac0f0d81d5549953395.1673380089.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673380089.git.bristot@kernel.org>
References: <cover.1673380089.git.bristot@kernel.org>
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

Add OSNOISE_IRQ_DISABLE to the set of possible options in the osnoise
context. Do not use it yet.

In preparation for the hwnoise tool.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/tracing/rtla/src/osnoise.c | 6 ++++++
 tools/tracing/rtla/src/osnoise.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 050a9997191c..6bf877ed8a77 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -842,6 +842,8 @@ static void osnoise_put_##name(struct osnoise_context *context)				\
 	context->orig_opt_##name = OSNOISE_OPTION_INIT_VAL;				\
 }
 
+OSNOISE_OPTION(irq_disable, "OSNOISE_IRQ_DISABLE");
+
 /*
  * enable_osnoise - enable osnoise tracer in the trace_instance
  */
@@ -906,6 +908,9 @@ struct osnoise_context *osnoise_context_alloc(void)
 	context->orig_tracing_thresh	= OSNOISE_OPTION_INIT_VAL;
 	context->tracing_thresh		= OSNOISE_OPTION_INIT_VAL;
 
+	context->orig_opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
+	context->opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
+
 	osnoise_get_context(context);
 
 	return context;
@@ -932,6 +937,7 @@ void osnoise_put_context(struct osnoise_context *context)
 	osnoise_put_timerlat_period_us(context);
 	osnoise_put_print_stack(context);
 	osnoise_put_tracing_thresh(context);
+	osnoise_put_irq_disable(context);
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 04a4384cc544..5bb0dc998f58 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -38,6 +38,10 @@ struct osnoise_context {
 	/* -1 as init value because 0 is disabled */
 	long long		orig_print_stack;
 	long long		print_stack;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_irq_disable;
+	int			opt_irq_disable;
 };
 
 /*
@@ -79,6 +83,8 @@ void osnoise_restore_print_stack(struct osnoise_context *context);
 int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
+int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
+
 /*
  * osnoise_tool -  osnoise based tool definition.
  */
-- 
2.38.1

