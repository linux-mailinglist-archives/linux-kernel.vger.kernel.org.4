Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE8073EB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFZUQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFZUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA9E4;
        Mon, 26 Jun 2023 13:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FF3860DFA;
        Mon, 26 Jun 2023 20:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B296C433C0;
        Mon, 26 Jun 2023 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687810572;
        bh=5BDJLetXXf3y8IYgHBV9UPex77ekTt4y/ajL2pcgjdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=P9u+7v/Ye/PUDn5GmLPJ0/nM8sGaVBDBsCgui9Nl9qEC0FZWtAW6lvfyyrYNgJPto
         0JHkmIqcvnwZUMKJwi/PT4iAyjuiCPYGusStHTQZkFpTitl5rWW0MUJiqm/vALG5+M
         MmhSHI030QvblwCFOarjCuSnip8HN8bAnD50m2s52242LUhVQEx16WHlWH/6E2p+1w
         ym0ZofAT2qaM/lyVW3UfNOPKdJbw0+a7OIzR8zSLu/3/voyHIA+m3ZlTZ/9OpybfQ+
         W6scvHIcTcXCN5xEaKSgxvzptwckxqpeASYKefAg3Gcqn7vG/C4hLvr+nPLhQHyNSC
         wjLhGedJ4R9fQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Add missing else to cmd_daemon subcommand condition
Date:   Mon, 26 Jun 2023 22:16:05 +0200
Message-ID: <20230626201606.2514679-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung reported segfault in perf daemon start command.

It's caused by extra check on argv[0] which is set to NULL by previous
__cmd_start call. Adding missing else to skip the extra check.

Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index f5674d824a40..83954af36753 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1524,7 +1524,7 @@ int cmd_daemon(int argc, const char **argv)
 	if (argc) {
 		if (!strcmp(argv[0], "start"))
 			ret = __cmd_start(&__daemon, daemon_options, argc, argv);
-		if (!strcmp(argv[0], "signal"))
+		else if (!strcmp(argv[0], "signal"))
 			ret = __cmd_signal(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "stop"))
 			ret = __cmd_stop(&__daemon, daemon_options, argc, argv);
-- 
2.41.0

