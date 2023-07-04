Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687397472BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGDN3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGDN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C6107
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE0856125F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 13:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4DDC433C7;
        Tue,  4 Jul 2023 13:29:44 +0000 (UTC)
Date:   Tue, 4 Jul 2023 09:29:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [GIT PULL] tracing tooling: Updates for 6.5
Message-ID: <20230704092942.6d140594@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

[ As the merge window opened up while I was in Prague, I almost forgot
  about the tooling branch (even though I was also with Daniel who did
  all these changes!) ]

Tracing tooling updates for 6.5:

- Add cgroup support for rtla via the -C option

- Add --house-keeping option that tells rtla where to place the housekeeping
  threads.

- Have rtla/timerlat have its own tracing instance instead of using the top
  level tracing instance that is the default for other tracing users to use.

- Add auto analysis to timerlat_hist

- Have rtla start the tracers after creating the instances

- Reduce rtla hwnoise down to 75% from 100% as it runs with preemption disabled
  and can cause system instability at 100%.

- Add support to run timerlat_top and timerlat_hist threads in user-space
  instead of just using the kernel tasks.

- Some minor clean ups and documentation changes.


Please pull the latest trace-tools-v6.5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.5

Tag SHA1: 9dedca3671c6bfa589bd14415a71e69d40d83b3d
Head SHA1: 6127383217741615f3450b684ecbee1ff570ee98


Daniel Bristot de Oliveira (11):
      rtla: Add -C cgroup support
      rtla: Add --house-keeping option
      rtla: Change monitored_cpus from char * to cpu_set_t
      rtla: Automatically move rtla to a house-keeping cpu
      rtla/timerlat: Give timerlat auto analysis its own instance
      rtla/timerlat_hist: Add auto-analysis support
      rtla: Start the tracers after creating all instances
      rtla/hwnoise: Reduce runtime to 75%
      rtla/timerlat_top: Add timerlat user-space support
      rtla/timerlat_hist: Add timerlat user-space support
      Documentation: Add tools/rtla timerlat -u option documentation

----
 Documentation/tools/rtla/common_options.rst        |   8 +
 Documentation/tools/rtla/common_timerlat_aa.rst    |   7 -
 .../tools/rtla/common_timerlat_options.rst         |   7 +
 Documentation/tools/rtla/rtla-timerlat-hist.rst    |   7 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst     |   7 +
 tools/tracing/rtla/src/osnoise.c                   |  65 +++++
 tools/tracing/rtla/src/osnoise.h                   |   5 +
 tools/tracing/rtla/src/osnoise_hist.c              |  90 +++++-
 tools/tracing/rtla/src/osnoise_top.c               |  83 +++++-
 tools/tracing/rtla/src/timerlat_aa.c               |  35 ++-
 tools/tracing/rtla/src/timerlat_aa.h               |   5 +-
 tools/tracing/rtla/src/timerlat_hist.c             | 262 +++++++++++++++--
 tools/tracing/rtla/src/timerlat_top.c              | 229 +++++++++++++--
 tools/tracing/rtla/src/timerlat_u.c                | 224 ++++++++++++++
 tools/tracing/rtla/src/timerlat_u.h                |  18 ++
 tools/tracing/rtla/src/utils.c                     | 324 +++++++++++++++++++--
 tools/tracing/rtla/src/utils.h                     |   7 +
 17 files changed, 1277 insertions(+), 106 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat_u.c
 create mode 100644 tools/tracing/rtla/src/timerlat_u.h
---------------------------
