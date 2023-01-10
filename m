Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AF664D05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjAJUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjAJUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:08:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691F2D1;
        Tue, 10 Jan 2023 12:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBC2BB819A9;
        Tue, 10 Jan 2023 20:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A56C433F1;
        Tue, 10 Jan 2023 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673381300;
        bh=kIvdU2JXZCM/uMeSvxhALScq2znezox8CF2FXFHJHL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbqkykMhdwPVg9XMV8DXbSXT12ucK4zeB0QbjxCdEqAPK0Ty7nJNiL/+VFNYXi3rU
         Ihl3ODzppp+ygeIztbBGXPr2paqWUnYb9E88j1UkS9stWo961PrGfURDO0QmrKZY49
         BE+cLPgMwGPfs2hbMrSlci+ow6eOW+tmdrxVOOgCLzlUp9+YLES8wfuxNd3UErhvQs
         mQpX1ldAl9I+BQpGwl659rnWHdO7tyfqRklUlDEWvZG9ZJFrDHgYbHrxowVsFtzV2S
         qyDHJqmV/88SDF/kXwWSZWbkRVyWYv0pg6ajHAmpprSPzb+EPyXNP2GDpsBbVoJY0x
         P0yvphVU93cJA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] rtla/osnoise: Add helper functions to manipulate osnoise/options
Date:   Tue, 10 Jan 2023 21:08:02 +0100
Message-Id: <9bc53eae8804b4068a7e3f3e2b0b7c5a3e023c99.1673380089.git.bristot@kernel.org>
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

Add some helper functions to read and set the on/off osnoise/options.
No usage in this patch.

In preparation for hwnoise tool.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/tracing/rtla/src/osnoise.c | 108 +++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4dee343909b1..050a9997191c 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -734,6 +734,114 @@ void osnoise_put_tracing_thresh(struct osnoise_context *context)
 	context->orig_tracing_thresh = OSNOISE_OPTION_INIT_VAL;
 }
 
+static int osnoise_options_get_option(char *option)
+{
+	char *options = tracefs_instance_file_read(NULL, "osnoise/options", NULL);
+	char no_option[128];
+	int retval = 0;
+	char *opt;
+
+	if (!options)
+		return OSNOISE_OPTION_INIT_VAL;
+
+	/*
+	 * Check first if the option is disabled.
+	 */
+	snprintf(no_option, sizeof(no_option), "NO_%s", option);
+
+	opt = strstr(options, no_option);
+	if (opt)
+		goto out_free;
+
+	/*
+	 * Now that it is not disabled, if the string is there, it is
+	 * enabled. If the string is not there, the option does not exist.
+	 */
+	opt = strstr(options, option);
+	if (opt)
+		retval = 1;
+	else
+		retval = OSNOISE_OPTION_INIT_VAL;
+
+out_free:
+	free(options);
+	return retval;
+}
+
+static int osnoise_options_set_option(char *option, bool onoff)
+{
+	char no_option[128];
+
+	if (onoff)
+		return tracefs_instance_file_write(NULL, "osnoise/options", option);
+
+	snprintf(no_option, sizeof(no_option), "NO_%s", option);
+
+	return tracefs_instance_file_write(NULL, "osnoise/options", no_option);
+}
+
+#define	OSNOISE_OPTION(name, option_str)						\
+static int osnoise_get_##name(struct osnoise_context *context)				\
+{											\
+	if (context->opt_##name != OSNOISE_OPTION_INIT_VAL)				\
+		return context->opt_##name;						\
+											\
+	if (context->orig_opt_##name != OSNOISE_OPTION_INIT_VAL)			\
+		return context->orig_opt_##name;					\
+											\
+	context->orig_opt_##name = osnoise_options_get_option(option_str);		\
+											\
+	return context->orig_opt_##name;						\
+}											\
+											\
+int osnoise_set_##name(struct osnoise_context *context, bool onoff)			\
+{											\
+	int opt_##name = osnoise_get_##name(context);					\
+	int retval;									\
+											\
+	if (opt_##name == OSNOISE_OPTION_INIT_VAL)					\
+		return -1;								\
+											\
+	if (opt_##name == onoff)							\
+		return 0;								\
+											\
+	retval = osnoise_options_set_option(option_str, onoff);				\
+	if (retval < 0)									\
+		return -1;								\
+											\
+	context->opt_##name = onoff;							\
+											\
+	return 0;									\
+}											\
+											\
+static void osnoise_restore_##name(struct osnoise_context *context)			\
+{											\
+	int retval;									\
+											\
+	if (context->orig_opt_##name == OSNOISE_OPTION_INIT_VAL)			\
+		return;									\
+											\
+	if (context->orig_opt_##name == context->opt_##name)				\
+		goto out_done;								\
+											\
+	retval = osnoise_options_set_option(option_str, context->orig_opt_##name);	\
+	if (retval < 0)									\
+		err_msg("Could not restore original osnoise " #option_str " option\n");	\
+											\
+out_done:										\
+	context->orig_opt_##name = OSNOISE_OPTION_INIT_VAL;				\
+}											\
+											\
+static void osnoise_put_##name(struct osnoise_context *context)				\
+{											\
+	osnoise_restore_##name(context);						\
+											\
+	if (context->orig_opt_##name == OSNOISE_OPTION_INIT_VAL)			\
+		return;									\
+											\
+	context->orig_opt_##name = OSNOISE_OPTION_INIT_VAL;				\
+}
+
 /*
  * enable_osnoise - enable osnoise tracer in the trace_instance
  */
-- 
2.38.1

