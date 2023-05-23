Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455570E2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbjEWRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjEWRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC8C2;
        Tue, 23 May 2023 10:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F57463564;
        Tue, 23 May 2023 17:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CFAC433D2;
        Tue, 23 May 2023 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863878;
        bh=oWpv0JJ4KVfHOHESY1z8zrd5HeQS1i0jsjMhHlSCsd4=;
        h=From:To:Cc:Subject:Date:From;
        b=o7ALmsTxImOubWs8UMvaMoPKWvnaroijVaeu5M/wpU1QfSimwxK3COphovNq6Bh6Z
         IJmTVyI1Ob96tNwvcM5FWFLmTI9WHST9C0pocBSRPhgC83CxofM2gF3k7KLhAkRM7e
         gp5vVTkiHV4TgE5u43++uzct4hjPzqFs6zieXZU1qMnL7ddKl/22eMTOn2/8Z9AW7A
         oaEL0EAudrcdUT06vaLqeIu3palPkZayV8oWIKrDFkLP8lEzIz94H0NnpMcmzpFIQg
         VufBbc5cAWEPzAImWbCSy7NcTLgHr+3DBUbjZoB9CLRfwMuVvT+ZAHh1G5mb8JG/V9
         acdvM8AqYUGGQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 0/9] rtla improvements
Date:   Tue, 23 May 2023 19:44:22 +0200
Message-Id: <cover.1684863094.git.bristot@kernel.org>
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
and to collect the additional field via rtla timerlat top.

Changes from V1:
  - Add the user-space thread support to rtla timerlat top
    Link: https://lore.kernel.org/lkml/cover.1683827510.git.bristot@kernel.org/

Daniel Bristot de Oliveira (9):
  rtla: Add -C cgroup support
  rtla: Add --house-keeping option
  rtla: Change monitored_cpus from char * to cpu_set_t
  rtla: Automatically move rtla to a house-keeping cpu
  rtla/timerlat: Give timerlat auto analysis its own instance
  rtla/timerlat_hist: Add auto-analysis support
  rtla: Start the tracers after creating all instances
  rtla/hwnoise: Reduce runtime to 75%
  rtla: Add timerlat user-space support for timerlat top

 Documentation/tools/rtla/common_options.rst   |   8 +
 .../tools/rtla/common_timerlat_aa.rst         |   7 -
 .../tools/rtla/rtla-timerlat-hist.rst         |   7 +-
 .../tools/rtla/rtla-timerlat-top.rst          |  14 +
 tools/tracing/rtla/src/osnoise.c              |  65 ++++
 tools/tracing/rtla/src/osnoise.h              |   5 +
 tools/tracing/rtla/src/osnoise_hist.c         |  90 ++++-
 tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
 tools/tracing/rtla/src/timerlat_aa.c          |  35 +-
 tools/tracing/rtla/src/timerlat_aa.h          |   5 +-
 tools/tracing/rtla/src/timerlat_hist.c        | 139 +++++++-
 tools/tracing/rtla/src/timerlat_top.c         | 229 +++++++++++--
 tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++
 tools/tracing/rtla/src/timerlat_u.h           |  18 +
 tools/tracing/rtla/src/utils.c                | 324 +++++++++++++++++-
 tools/tracing/rtla/src/utils.h                |   7 +
 16 files changed, 1162 insertions(+), 98 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat_u.c
 create mode 100644 tools/tracing/rtla/src/timerlat_u.h

-- 
2.38.1

