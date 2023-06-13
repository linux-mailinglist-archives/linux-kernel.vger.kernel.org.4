Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391E72EEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjFMWI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CA10DE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0605631CF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF7C433C0;
        Tue, 13 Jun 2023 22:08:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9CBb-000EBN-1C;
        Tue, 13 Jun 2023 18:08:23 -0400
Message-ID: <20230613220750.330146797@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 13 Jun 2023 18:07:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 00/11] tracing/tools: Updates for 6.5
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

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
