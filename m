Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A46CB673
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjC1GBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1GBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:01:04 -0400
Received: from s01.bc.larksuite.com (s01.bc.larksuite.com [209.127.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE01BF9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1679983257;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jpLFn1EB/s/kA9RQruQf4U4Q6B7nI3s0AhEY/DRWrXo=;
 b=rFSfZSORcFwrLAS8aAiGcJ4OOGn/SiX8z1CONCyFeXQyo9oTL2kbY8W4Dt+yAbrs5MQURo
 BC8L7/2UMFT1uW+yLE9HNzMYABZ12bUGFF7xqBQCeBse8+iS56EfgXMPBxh6BEtqd9iRlQ
 jDaC5RmE0OyxOG+sR71QMxjJZt5evDVZZcIIlW9S038Om46QUSzvHM5gnuUWYqHhlQBVfm
 zfKZCC6sLmq7EFcsVlSotba63ZbPpwWB0nXDGfMkYkkQJ9vkHg3c4QZO1hQOWfP+Xb12bK
 4n9WtX/SK5tlx8fqE+rjZmO9bqD8QrHoP3Gohh39KxWnZP10bTXtfvCIqWc+NQ==
Cc:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chunxin Zang" <zangchunxin@lixiang.com>,
        "Jerry Zhou" <zhouchunhua@lixiang.com>
Subject: [PATCH v4] perf sched: Fix sched latency analysis incorrect
Content-Transfer-Encoding: 8bit
X-Lms-Return-Path: <lba+264228299+e347b3+vger.kernel.org+zangchunxin@lixiang.com>
X-Mailer: git-send-email 2.25.1
Content-Type: multipart/alternative;
 boundary=c06cf611ac4b5bb7591f9094a904a7d660872499e5c5876a889ba50c92b8
From:   "Chunxin Zang" <zangchunxin@lixiang.com>
Date:   Tue, 28 Mar 2023 14:00:57 +0800
Message-Id: <20230328060038.2346935-1-zangchunxin@lixiang.com>
Mime-Version: 1.0
To:     <namhyung@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c06cf611ac4b5bb7591f9094a904a7d660872499e5c5876a889ba50c92b8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

'perf sched latency' is incorrect to get process schedule latency
when it used 'sched:sched_wakeup' to analysis perf.data.

Because 'perf record' prefer use 'sched:sched_waking' to
'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
sched_waking event when it exists"). It's very reasonable to
evaluate process schedule latency.

Similarly, update sched latency/map/replay to use sched_waking events.

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Jerry Zhou <zhouchunhua@lixiang.com>
---

	changelogs in v4:
	1) disable to process wakeup event if wakingup event is found.

	changelogs in v3:
	1) fix non-ASCII characters in commit log.

	changelogs in v2:
	1) fix email address disappearing in 'signed off by'

 tools/perf/builtin-sched.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 86e18575c9be..ec443df8e05c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1516,6 +1516,14 @@ static int process_sched_wakeup_event(struct perf_to=
ol *tool,
 	return 0;
 }
=20
+static int process_sched_wakeup_ignore(struct perf_tool *tool __maybe_unus=
ed,
+				      struct evsel *evsel __maybe_unused,
+				      struct perf_sample *sample __maybe_unused,
+				      struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
 union map_priv {
 	void	*ptr;
 	bool	 color;
@@ -1816,10 +1824,11 @@ static int perf_sched__process_comm(struct perf_too=
l *tool __maybe_unused,
=20
 static int perf_sched__read_events(struct perf_sched *sched)
 {
-	const struct evsel_str_handler handlers[] =3D {
+	struct evsel_str_handler handlers[] =3D {
 		{ "sched:sched_switch",	      process_sched_switch_event, },
 		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
 		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
+		{ "sched:sched_waking",	      process_sched_wakeup_event, },
 		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
 		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
 	};
@@ -1839,6 +1848,10 @@ static int perf_sched__read_events(struct perf_sched=
 *sched)
=20
 	symbol__init(&session->header.env);
=20
+	/* prefer sched_waking if it is captured */
+	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"=
))
+		handlers[2].handler =3D process_sched_wakeup_ignore;
+
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
=20
--=20
2.25.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
--c06cf611ac4b5bb7591f9094a904a7d660872499e5c5876a889ba50c92b8--
