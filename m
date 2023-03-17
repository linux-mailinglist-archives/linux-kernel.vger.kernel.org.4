Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61F6BDE54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCQByA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:53:58 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 18:53:39 PDT
Received: from s01.bc.larksuite.com (s01.bc.larksuite.com [209.127.230.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3C77E02
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 18:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1679017401;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=GjTzLmt2J0SuZyIWM5aAtIzr4io0yq067VawbNUY92w=;
 b=y2wP51vgbxyJRwR3GFiAH3jVqIz0fdetoqWjf7sYK6vEHDRVqfsyUX1wiBee2eua3BMUGb
 Rf8ec7a3+20f//lCjoNWsyCSYFTAZRDSdep7SuamTgBxppehKE9WSd9vMMSikj6tdGBRhz
 MoV5hGwaAZLodJnplqRU3Ray8pQ67uMhnWBLmsED/uKEQji4q3MnUmfJSzj736nnqk2C3G
 8GwtsZUnEYafK4RB+MHDZHOdaOgPkvgIAkRdEnQX7o7y1pSoSXaoLtcpQMbM/hdOQCDhJW
 35N1dnVu8eEMDqlqIBGdQ9FFhjNTJE2+FCAloIJPbPDkgIdISrsZcjQ6M/D65A==
From:   "Chunxin Zang" <zangchunxin@lixiang.com>
Subject: [PATCH v2] perf sched: Fix sched latency analysis incorrect
Mime-Version: 1.0
Cc:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chunxin Zang" <zangchunxin@lixiang.com>,
        "Jerry Zhou" <zhouchunhua@lixiang.com>
X-Mailer: git-send-email 2.25.1
To:     <namhyung@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
X-Lms-Return-Path: <lba+26413c5ae+a252d6+vger.kernel.org+zangchunxin@lixiang.com>
Content-Type: multipart/alternative;
 boundary=8568d8a9ebcdc4714e33ddb4f3630dbbbbc309892328f3cdbdc990d13e40
Date:   Fri, 17 Mar 2023 09:43:10 +0800
Message-Id: <20230317014303.949808-1-zangchunxin@lixiang.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8568d8a9ebcdc4714e33ddb4f3630dbbbbc309892328f3cdbdc990d13e40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

'perf sched latency' is incorrect to get process schedule latency
when it used 'sched:sched_wakeup' to analysis perf.data.

Because 'perf record' prefer use 'sched:sched_waking' to
'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
sched_waking event when it exists"). It's very reasonable to
evaluate process schedule latency.

Similarly, update sched latency/map/replay to use sched_waking events.

I used 'perf record -e =E2=80=9Csched:* "' to record both wakeup and waking=
 events,
and use fixed perf version to analysis them, the result is correct.
Because the function "latency_wakeup_event=E2=80=9D will change atom->state=
 to
THREAD_WAIT_CPU at waking event, and judge the 'atom->state !=3D THREAD_SLE=
EPING=E2=80=99
is false then returned at wakeup event.

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Jerry Zhou <zhouchunhua@lixiang.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 86e18575c9be..1af4ec1ac824 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1819,6 +1819,7 @@ static int perf_sched__read_events(struct perf_sched =
*sched)
 	const struct evsel_str_handler handlers[] =3D {
 		{ "sched:sched_switch",	      process_sched_switch_event, },
 		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
+		{ "sched:sched_waking",	      process_sched_wakeup_event, },
 		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
 		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
 		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
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
--8568d8a9ebcdc4714e33ddb4f3630dbbbbc309892328f3cdbdc990d13e40--
