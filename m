Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB9A68E323
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBGVtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBGVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:49:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900561027A;
        Tue,  7 Feb 2023 13:49:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21A47B819CA;
        Tue,  7 Feb 2023 21:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2AAC433D2;
        Tue,  7 Feb 2023 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675806542;
        bh=bZL4DTGNtZyVOwBQQfohx9Ie5UQUHV6jr0Ndhag2aEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEqTJq/kGn5Px5I/tq2raS962RzJ2uMhDNkAMeo4qFqbj4bOrCtgtYjkQ4t6nxnmy
         +AidPTqS4zaYcHh9DKFYoPrAvV236Msza5jLfxFkH+7ipiNyBUb5XbanftPztRmvpN
         pavUoq8uaqpmksE/T2Ed5o/iag7ksFFb/WNRbmjZuJcwJY+5oxhECmMIWXo2LAg0CC
         Pz2uCOooLEXYEOxHqPTnBQGNYNz9SUoYSBcXtETI6GkDyC4bJEBGa2neZfAkcLUqlV
         P76lcZ07pKwL/6xI7J4L0JuccYA/xTOSWenx/mGbMRf7oZO1Be8StKEUwIc16d6jPx
         tEg6zsAK2XBcQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] rtla: Add hwnoise tool
Date:   Tue,  7 Feb 2023 22:48:50 +0100
Message-Id: <2d6f49a6f3a4f8b51b2c806458b1cff71ad4d014.1675805361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675805361.git.bristot@kernel.org>
References: <cover.1675805361.git.bristot@kernel.org>
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

The hwnoise tool is a special mode for the osnoise top tool.

hwnoise dispatches the osnoise tracer and displays a summary of the noise.
The difference is that it runs the tracer with the OSNOISE_IRQ_DISABLE
option set, thus only allowing only hardware-related noise, resulting in
a simplified output. hwnoise has the same features of osnoise.

An example of the tool's output:

 # rtla hwnoise -c 1-11 -T 1 -d 10m -q
                                           Hardware-related Noise
 duration:   0 00:10:00 | time is in us
 CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI
   1 #599       599000000          138    99.99997           3            3           4           74
   2 #599       599000000           85    99.99998           3            3           4           75
   3 #599       599000000           86    99.99998           4            3           6           75
   4 #599       599000000           81    99.99998           4            4           2           75
   5 #599       599000000           85    99.99998           2            2           2           75

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/tracing/rtla/Makefile          |   2 +
 tools/tracing/rtla/src/osnoise.c     | 117 +++++++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h     |   7 ++
 tools/tracing/rtla/src/osnoise_top.c |  84 +++++++++++++++----
 tools/tracing/rtla/src/rtla.c        |   4 +
 5 files changed, 198 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 22e28b76f800..2456a399eb9a 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -119,6 +119,8 @@ install: doc_install
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
 	ln -s rtla $(DESTDIR)$(BINDIR)/osnoise
+	@test ! -f $(DESTDIR)$(BINDIR)/hwnoise || rm $(DESTDIR)$(BINDIR)/hwnoise
+	ln -s rtla $(DESTDIR)$(BINDIR)/hwnoise
 	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
 	ln -s rtla $(DESTDIR)$(BINDIR)/timerlat
 
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4dee343909b1..3ca7a3853943 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -734,6 +734,113 @@ void osnoise_put_tracing_thresh(struct osnoise_context *context)
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
+static int osnoise_get_irq_disable(struct osnoise_context *context)
+{
+	if (context->opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
+		return context->opt_irq_disable;
+
+	if (context->orig_opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
+		return context->orig_opt_irq_disable;
+
+	context->orig_opt_irq_disable = osnoise_options_get_option("OSNOISE_IRQ_DISABLE");
+
+	return context->orig_opt_irq_disable;
+}
+
+int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff)
+{
+	int opt_irq_disable = osnoise_get_irq_disable(context);
+	int retval;
+
+	if (opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
+		return -1;
+
+	if (opt_irq_disable == onoff)
+		return 0;
+
+	retval = osnoise_options_set_option("OSNOISE_IRQ_DISABLE", onoff);
+	if (retval < 0)
+		return -1;
+
+	context->opt_irq_disable = onoff;
+
+	return 0;
+}
+
+static void osnoise_restore_irq_disable(struct osnoise_context *context)
+{
+	int retval;
+
+	if (context->orig_opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	if (context->orig_opt_irq_disable == context->opt_irq_disable)
+		goto out_done;
+
+	retval = osnoise_options_set_option("OSNOISE_IRQ_DISABLE", context->orig_opt_irq_disable);
+	if (retval < 0)
+		err_msg("Could not restore original OSNOISE_IRQ_DISABLE option\n");
+
+out_done:
+	context->orig_opt_irq_disable = OSNOISE_OPTION_INIT_VAL;
+}
+
+static void osnoise_put_irq_disable(struct osnoise_context *context)
+{
+	osnoise_restore_irq_disable(context);
+
+	if (context->orig_opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	context->orig_opt_irq_disable = OSNOISE_OPTION_INIT_VAL;
+}
+
 /*
  * enable_osnoise - enable osnoise tracer in the trace_instance
  */
@@ -798,6 +905,9 @@ struct osnoise_context *osnoise_context_alloc(void)
 	context->orig_tracing_thresh	= OSNOISE_OPTION_INIT_VAL;
 	context->tracing_thresh		= OSNOISE_OPTION_INIT_VAL;
 
+	context->orig_opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
+	context->opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
+
 	osnoise_get_context(context);
 
 	return context;
@@ -824,6 +934,7 @@ void osnoise_put_context(struct osnoise_context *context)
 	osnoise_put_timerlat_period_us(context);
 	osnoise_put_print_stack(context);
 	osnoise_put_tracing_thresh(context);
+	osnoise_put_irq_disable(context);
 
 	free(context);
 }
@@ -958,3 +1069,9 @@ int osnoise_main(int argc, char *argv[])
 	osnoise_usage(1);
 	exit(1);
 }
+
+int hwnoise_main(int argc, char *argv[])
+{
+	osnoise_top_main(argc, argv);
+	exit(0);
+}
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 04a4384cc544..4dcf22ccd704 100644
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
@@ -97,3 +103,4 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
 int osnoise_hist_main(int argc, char *argv[]);
 int osnoise_top_main(int argc, char **argv);
 int osnoise_main(int argc, char **argv);
+int hwnoise_main(int argc, char **argv);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 76479bfb2922..562f2e4b18c5 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -14,6 +14,11 @@
 #include "osnoise.h"
 #include "utils.h"
 
+enum osnoise_mode {
+	MODE_OSNOISE = 0,
+	MODE_HWNOISE
+};
+
 /*
  * osnoise top parameters
  */
@@ -32,6 +37,7 @@ struct osnoise_top_params {
 	int			set_sched;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
+	enum osnoise_mode	mode;
 };
 
 struct osnoise_top_cpu {
@@ -143,15 +149,23 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
  */
 static void osnoise_top_header(struct osnoise_tool *top)
 {
+	struct osnoise_top_params *params = top->params;
 	struct trace_seq *s = top->trace.seq;
 	char duration[26];
 
 	get_duration(top->start_time, duration, sizeof(duration));
 
 	trace_seq_printf(s, "\033[2;37;40m");
-	trace_seq_printf(s, "                                          Operating System Noise");
-	trace_seq_printf(s, "                                     ");
-	trace_seq_printf(s, "                                     ");
+	trace_seq_printf(s, "                                          ");
+
+	if (params->mode == MODE_OSNOISE) {
+		trace_seq_printf(s, "Operating System Noise");
+		trace_seq_printf(s, "                                       ");
+	} else if (params->mode == MODE_HWNOISE) {
+		trace_seq_printf(s, "Hardware-related Noise");
+	}
+
+	trace_seq_printf(s, "                                   ");
 	trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
@@ -162,7 +176,14 @@ static void osnoise_top_header(struct osnoise_tool *top)
 	trace_seq_printf(s, "       Noise ");
 	trace_seq_printf(s, " %% CPU Aval ");
 	trace_seq_printf(s, "  Max Noise   Max Single ");
-	trace_seq_printf(s, "         HW          NMI          IRQ      Softirq       Thread");
+	trace_seq_printf(s, "         HW          NMI");
+
+	if (params->mode == MODE_HWNOISE)
+		goto eol;
+
+	trace_seq_printf(s, "          IRQ      Softirq       Thread");
+
+eol:
 	trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
@@ -181,6 +202,7 @@ static void clear_terminal(struct trace_seq *seq)
  */
 static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 {
+	struct osnoise_top_params *params = tool->params;
 	struct trace_seq *s = tool->trace.seq;
 	struct osnoise_top_cpu *cpu_data;
 	struct osnoise_top_data *data;
@@ -205,6 +227,12 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 
 	trace_seq_printf(s, "%12llu ", cpu_data->hw_count);
 	trace_seq_printf(s, "%12llu ", cpu_data->nmi_count);
+
+	if (params->mode == MODE_HWNOISE) {
+		trace_seq_printf(s, "\n");
+		return;
+	}
+
 	trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
 	trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
 	trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
@@ -241,12 +269,12 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
 /*
  * osnoise_top_usage - prints osnoise top usage message
  */
-void osnoise_top_usage(char *usage)
+static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 {
 	int i;
 
 	static const char * const msg[] = {
-		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-P priority]",
 		"",
@@ -277,9 +305,22 @@ void osnoise_top_usage(char *usage)
 	if (usage)
 		fprintf(stderr, "%s\n", usage);
 
-	fprintf(stderr, "rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
+	if (params->mode == MODE_OSNOISE) {
+		fprintf(stderr,
+			"rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
 			VERSION);
 
+		fprintf(stderr, "  usage: rtla osnoise [top]");
+	}
+
+	if (params->mode == MODE_HWNOISE) {
+		fprintf(stderr,
+			"rtla hwnoise: a summary of hardware-related noise (version %s)\n",
+			VERSION);
+
+		fprintf(stderr, "  usage: rtla hwnoise");
+	}
+
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 	exit(1);
@@ -299,6 +340,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 	if (!params)
 		exit(1);
 
+	if (strcmp(argv[0], "hwnoise") == 0)
+		params->mode = MODE_HWNOISE;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -345,7 +389,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
-				osnoise_top_usage("\nInvalid -c cpu list\n");
+				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
 		case 'D':
@@ -354,7 +398,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage("Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -D duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
@@ -370,17 +414,17 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'h':
 		case '?':
-			osnoise_top_usage(NULL);
+			osnoise_top_usage(params, NULL);
 			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
-				osnoise_top_usage("Period longer than 10 s\n");
+				osnoise_top_usage(params, "Period longer than 10 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->sched_param);
 			if (retval == -1)
-				osnoise_top_usage("Invalid -P priority");
+				osnoise_top_usage(params, "Invalid -P priority");
 			params->set_sched = 1;
 			break;
 		case 'q':
@@ -389,7 +433,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
 			if (params->runtime < 100)
-				osnoise_top_usage("Runtime shorter than 100 us\n");
+				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
 			break;
 		case 's':
 			params->stop_us = get_llong_from_str(optarg);
@@ -415,7 +459,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 					exit(EXIT_FAILURE);
 				}
 			} else {
-				osnoise_top_usage("--trigger requires a previous -e\n");
+				osnoise_top_usage(params, "--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -426,11 +470,11 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 					exit(EXIT_FAILURE);
 				}
 			} else {
-				osnoise_top_usage("--filter requires a previous -e\n");
+				osnoise_top_usage(params, "--filter requires a previous -e\n");
 			}
 			break;
 		default:
-			osnoise_top_usage("Invalid option");
+			osnoise_top_usage(params, "Invalid option");
 		}
 	}
 
@@ -495,6 +539,14 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		}
 	}
 
+	if (params->mode == MODE_HWNOISE) {
+		retval = osnoise_set_irq_disable(tool->context, 1);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_IRQ_DISABLE option\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 52e8f1825281..7635c70123ab 100644
--- a/tools/tracing/rtla/src/rtla.c
+++ b/tools/tracing/rtla/src/rtla.c
@@ -26,6 +26,7 @@ static void rtla_usage(int err)
 		"",
 		"  commands:",
 		"     osnoise  - gives information about the operating system noise (osnoise)",
+		"     hwnoise  - gives information about hardware-related noise",
 		"     timerlat - measures the timer irq and thread latency",
 		"",
 		NULL,
@@ -47,6 +48,9 @@ int run_command(int argc, char **argv, int start_position)
 	if (strcmp(argv[start_position], "osnoise") == 0) {
 		osnoise_main(argc-start_position, &argv[start_position]);
 		goto ran;
+	} else if (strcmp(argv[start_position], "hwnoise") == 0) {
+		hwnoise_main(argc-start_position, &argv[start_position]);
+		goto ran;
 	} else if (strcmp(argv[start_position], "timerlat") == 0) {
 		timerlat_main(argc-start_position, &argv[start_position]);
 		goto ran;
-- 
2.38.1

