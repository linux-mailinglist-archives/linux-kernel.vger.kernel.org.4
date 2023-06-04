Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07C072141D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjFDC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFDC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 22:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16249E1;
        Sat,  3 Jun 2023 19:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80DFA614FD;
        Sun,  4 Jun 2023 02:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEEC433EF;
        Sun,  4 Jun 2023 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685845745;
        bh=zfEkmBPuZFLSZLn5IlKeELqqgyZdzHiaAiDXC1xJHhg=;
        h=From:To:Cc:Subject:Date:From;
        b=lbhB6zltz8j434oatnR9CPUQMgCNKN24ZCbUpIknBpJBIkGy2mHjEcrCSme6q2c+K
         pbL7vAdUxslk88IUzAJCkJfvaz1zurDFpgcNCZ5PcDPthgYcyTrqg52Tp4IDfTcsxd
         KA+xdUOY5sy3vI9zMl7ykTac+m6Ew1X8vY83K9Kt7dKYgBw8K1zPmI5fauhn5mv2+9
         oQF3Bg1zRIe5GpX7ugHh7EzLL3vIOXMq0jy2eSCeNcZZY9PZgPFLFXpuqDhnMIHRJu
         lVOrcT4XsK52czIprPz4d4mzaablHRcwAJFW1/5Yt+t/VxIiO2RRyzG/ixUiqPwPQn
         AmLDGiaBuxqVw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] tracing/probes: Fix to return NULL and keep using current argc
Date:   Sun,  4 Jun 2023 11:29:00 +0900
Message-ID:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to return NULL and keep using current argc when there is
$argN and the BTF is not available.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306030940.Cej2JoUx-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ba1c6e059b51..473e1c43bc57 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1273,7 +1273,8 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 			trace_probe_log_err(0, NOSUP_BTFARG);
 			return (const char **)params;
 		}
-		return 0;
+		*new_argc = argc;
+		return NULL;
 	}
 	ctx->params = params;
 	ctx->nr_params = nr_params;

