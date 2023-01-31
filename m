Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DF6832B9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjAaQbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAaQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:31:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE1159276;
        Tue, 31 Jan 2023 08:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50C1DB81DBB;
        Tue, 31 Jan 2023 16:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29ADC433EF;
        Tue, 31 Jan 2023 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182626;
        bh=fZoiDCo8mlflOUrugKkadGUZAp4uDzg4hv7Jwhv76DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msyrpQY4mIZaB227tBG0zvZdPDhieZGkW2/NAcmkkSaFVw9H9V54DAUAFAT5dMv7I
         30aje5m/jTYFLHQSDKDwKtSGfLSjCjfCvMe9TvJ/HEKPLZ9YbWyatSGKogESZInisi
         Y2vQxoj4SpJ0WfKM9oYQM88vJth0nfiFMZsm2QFngFTR6gl8PuMV2GpBqZAiIcinho
         kfovWuvtpIBAnWga+l3Ql6Y/QQH01ICAuUtQKCaYzPhLeXmcECACC78rKOEoTVSZV8
         P8IvIDgUUVpru4wXRxrximTbNIpIr6w9ydfXqCgNvbUMcZs78gFMTCVB4xwXBAVJS1
         eMo//BjiQtodA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/6] rtla: Add hwnoise tool
Date:   Tue, 31 Jan 2023 17:30:06 +0100
Message-Id: <62a00104b333e52c2d0eff53372718043d94509d.1675181734.git.bristot@kernel.org>
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

The hwnoise tool is a special mode for the osnoise top tool.

hwnoise dispatches the osnoise tracer and displays a summary of the noise.
The difference is that it runs the tracer with the OSNOISE_IRQ_DISABLE
option set, thus only allowing only hardware-related noise, resulting in
a simplified output. hwnoise has the same features of osnoise.

An example of the tool's output:

 # rtla hwnoise -c 1-5 -T 1 -d 10m -q
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
 tools/tracing/rtla/Makefile          |  2 +
 tools/tracing/rtla/src/osnoise.c     |  6 +++
 tools/tracing/rtla/src/osnoise.h     |  1 +
 tools/tracing/rtla/src/osnoise_top.c | 59 +++++++++++++++++++++++++---
 tools/tracing/rtla/src/rtla.c        |  4 ++
 5 files changed, 66 insertions(+), 6 deletions(-)

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
index 6bf877ed8a77..0e47b39992d8 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1072,3 +1072,9 @@ int osnoise_main(int argc, char *argv[])
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
index 5bb0dc998f58..4dcf22ccd704 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -103,3 +103,4 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
 int osnoise_hist_main(int argc, char *argv[]);
 int osnoise_top_main(int argc, char **argv);
 int osnoise_main(int argc, char **argv);
+int hwnoise_main(int argc, char **argv);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index fd2104050e3c..562f2e4b18c5 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -16,6 +16,7 @@
 
 enum osnoise_mode {
 	MODE_OSNOISE = 0,
+	MODE_HWNOISE
 };
 
 /*
@@ -148,15 +149,23 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
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
 
@@ -167,7 +176,14 @@ static void osnoise_top_header(struct osnoise_tool *top)
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
@@ -186,6 +202,7 @@ static void clear_terminal(struct trace_seq *seq)
  */
 static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 {
+	struct osnoise_top_params *params = tool->params;
 	struct trace_seq *s = tool->trace.seq;
 	struct osnoise_top_cpu *cpu_data;
 	struct osnoise_top_data *data;
@@ -210,6 +227,12 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 
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
@@ -251,7 +274,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 	int i;
 
 	static const char * const msg[] = {
-		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-P priority]",
 		"",
@@ -282,9 +305,22 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 	if (usage)
 		fprintf(stderr, "%s\n", usage);
 
-	fprintf(stderr, "rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
+	if (params->mode == MODE_OSNOISE) {
+		fprintf(stderr,
+			"rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
+			VERSION);
+
+		fprintf(stderr, "  usage: rtla osnoise [top]");
+	}
+
+	if (params->mode == MODE_HWNOISE) {
+		fprintf(stderr,
+			"rtla hwnoise: a summary of hardware-related noise (version %s)\n",
 			VERSION);
 
+		fprintf(stderr, "  usage: rtla hwnoise");
+	}
+
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 	exit(1);
@@ -304,6 +340,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 	if (!params)
 		exit(1);
 
+	if (strcmp(argv[0], "hwnoise") == 0)
+		params->mode = MODE_HWNOISE;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -500,6 +539,14 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
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

