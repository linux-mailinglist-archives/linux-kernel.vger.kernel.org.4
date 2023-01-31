Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A76832B0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAaQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAaQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:30:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794259245;
        Tue, 31 Jan 2023 08:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76CBEB81DAF;
        Tue, 31 Jan 2023 16:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A62C433A4;
        Tue, 31 Jan 2023 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182616;
        bh=kIvdU2JXZCM/uMeSvxhALScq2znezox8CF2FXFHJHL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCswl4whe/e49oD1yXNPcGVCBm1aflNv44zq/3v0gJuMjnf+Iw16Xr8zP8k1a1B/N
         /hrtimHEhylF57yoDoAJksdVHgu+k2lHfHZpCxYIsGeErOWUT2l8q4Nq8AyLX/VBBy
         GmcDh2fualZ/KIHGzNOpKcw7dQ0ugt7j1IL0oElOAbiirY7zPmmym6rj1deWNvixtZ
         j2PYpgsmcu2Nl1hy9m9gGpfqFTcTIJNLo7VlSmz01wwqHFocBbWVROSB3bK8OFpxOo
         n9UqeCrl4W7AmYje3ZdZA1rHAVrEp14zkk+09QSXRjMH0a4HpXFwL1fiei7d0ZNP4w
         BAoOkcu6sz/MA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] rtla/osnoise: Add helper functions to manipulate osnoise/options
Date:   Tue, 31 Jan 2023 17:30:02 +0100
Message-Id: <930c4ef71c7bcb1158d2a8cad905f4de425b8d1e.1675181734.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675181734.git.bristot@kernel.org>
References: <cover.1675181734.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

