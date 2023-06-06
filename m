Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D4724897
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbjFFQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjFFQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D80E8;
        Tue,  6 Jun 2023 09:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919E862D99;
        Tue,  6 Jun 2023 16:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A9C433D2;
        Tue,  6 Jun 2023 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067956;
        bh=NzTyqwK+gbG+XiS2KsPh2vX4Tmt6XxOCACaA21wsJRY=;
        h=From:To:Cc:Subject:Date:From;
        b=HQFKOk4w0f+omkGtP5ehv47JO+C2MKUi590vake2J1F6hmuQQOauUVaLlZilR1t7y
         6dWY+NNMMquHEamZervuU06G10gorAjIyjYA3rYhclIre5sBERr1E5cyAXTooTpTxX
         Xm6KzWcdlugr5nXOkWyn8DLwCO0ZkbZctUBPrMDp3Wz9vbjF9sWHZIS6Mkv9s/hfKH
         uJPHzzREwIomy+GdW+989uaVgSWfxGtSBh77jplXVcp8j2FpLr4nJp21eFF5nmQ88E
         CF9nXwTqeQ7aCl7khnbQ4D6V9n/I6EegQnzFVla8obrfcfyKPjkrEEnmDEP6/0N5GT
         7LXMpTS2uoGdA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 00/11] rtla improvements
Date:   Tue,  6 Jun 2023 18:12:14 +0200
Message-Id: <cover.1686066600.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of improvements for rtla, mainly as a result of our
daily usage of the tool debugging problems at red hat.

The cgroup support and house keeping options are from our usage
of the tool debugging containers.

The auto-analysis overhead reduction is needed when we go to
large boxes - but it is really hand in practice, as it gives an idea
of the problem without having to look at the trace.

Running hwnoise 100 % of CPU time might cause some systems
to slow down too much. Reduce its utilization to 75% by default to
avoid problems for people using it for the first time.

Finally, it adds support for running timerlat user-space threads,
and to collect the additional field via rtla timerlat top/hist.

Changes from V2:
  - Add timerlat hist -u option
  - Link: https://lore.kernel.org/lkml/cover.1684863094.git.bristot@kernel.org/
Changes from V1:
  - Add the user-space thread support to rtla timerlat top
  - Link: https://lore.kernel.org/lkml/cover.1683827510.git.bristot@kernel.org/

Daniel Bristot de Oliveira (11):
  rtla: Add -C cgroup support
  rtla: Add --house-keeping option
  rtla: Change monitored_cpus from char * to cpu_set_t
  rtla: Automatically move rtla to a house-keeping cpu
  rtla/timerlat: Give timerlat auto analysis its own instance
  rtla/timerlat_hist: Add auto-analysis support
  rtla: Start the tracers after creating all instances
  rtla/hwnoise: Reduce runtime to 75%
  rtla: Add timerlat user-space support for timerlat top
  rtla: Add timerlat user-space support for
  Documentation: Add tools/rtla timerlat -u option documentation

 Documentation/tools/rtla/common_options.rst   |   8 +
 .../tools/rtla/common_timerlat_aa.rst         |   7 -
 .../tools/rtla/common_timerlat_options.rst    |   7 +
 .../tools/rtla/rtla-timerlat-hist.rst         |   7 +-
 .../tools/rtla/rtla-timerlat-top.rst          |   7 +
 tools/tracing/rtla/src/osnoise.c              |  65 ++++
 tools/tracing/rtla/src/osnoise.h              |   5 +
 tools/tracing/rtla/src/osnoise_hist.c         |  90 ++++-
 tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
 tools/tracing/rtla/src/timerlat_aa.c          |  35 +-
 tools/tracing/rtla/src/timerlat_aa.h          |   5 +-
 tools/tracing/rtla/src/timerlat_hist.c        | 262 ++++++++++++--
 tools/tracing/rtla/src/timerlat_top.c         | 229 +++++++++++--
 tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++
 tools/tracing/rtla/src/timerlat_u.h           |  18 +
 tools/tracing/rtla/src/utils.c                | 324 +++++++++++++++++-
 tools/tracing/rtla/src/utils.h                |   7 +
 17 files changed, 1277 insertions(+), 106 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat_u.c
 create mode 100644 tools/tracing/rtla/src/timerlat_u.h

-- 
2.38.1

