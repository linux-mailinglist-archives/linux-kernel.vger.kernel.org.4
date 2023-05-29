Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B29714647
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjE2I2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2I2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB5A7;
        Mon, 29 May 2023 01:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01088611E1;
        Mon, 29 May 2023 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998B8C4339B;
        Mon, 29 May 2023 08:28:43 +0000 (UTC)
Date:   Mon, 29 May 2023 04:28:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 0/9] rtla improvements
Message-ID: <20230529042839.5d4af427@rorschach.local.home>
In-Reply-To: <cover.1684863094.git.bristot@kernel.org>
References: <cover.1684863094.git.bristot@kernel.org>
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

Hi Daniel,

Could you make sure to Cc linux-trace-kernel@vger.kernel.org and not
linux-trace-devel. The former is for any patch that goes into the
kernel repo, the later is for the tracing libraries (like libtracefs).
The reason why this matters is that the patchwork that is associated to
the Linux kernel tree will not get these (and I will not work on them
when I'm working on kernel patches). But it will go into the 
patchwork for the libraries (and never be processed by the patchwork
infrastructure), and I will likely not work on them, because when I
look at the library patchwork, I ignore anything that goes into the
kernel.

Perhaps resend with the proper Cc and it will then be processed. I
allowed this to happen before, but that's because I did everything
manually and not with my scripts. And I'm tired of doing that.

Thanks,

-- Steve


On Tue, 23 May 2023 19:44:22 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> This is a series of improvements for rtla, mainly as a result of our
> daily usage of the tool debugging problems at red hat.
> 
> The cgroup support and house keeping options are from our usage
> of the tool debugging containers.
> 
> The auto-analysis overhead reduction is needed when we go to
> large boxes - but it is really hand in practice, as it gives an idea
> of the problem without having to look at the trace.
> 
> Running hwnoise 100 % of CPU time might cause some systems
> to slow down too much. Reduce its utilization to 75% by default to
> avoid problems for people using it for the first time.
> 
> Finally, it adds support for running timerlat user-space threads,
> and to collect the additional field via rtla timerlat top.
> 
> Changes from V1:
>   - Add the user-space thread support to rtla timerlat top
>     Link: https://lore.kernel.org/lkml/cover.1683827510.git.bristot@kernel.org/
> 
> Daniel Bristot de Oliveira (9):
>   rtla: Add -C cgroup support
>   rtla: Add --house-keeping option
>   rtla: Change monitored_cpus from char * to cpu_set_t
>   rtla: Automatically move rtla to a house-keeping cpu
>   rtla/timerlat: Give timerlat auto analysis its own instance
>   rtla/timerlat_hist: Add auto-analysis support
>   rtla: Start the tracers after creating all instances
>   rtla/hwnoise: Reduce runtime to 75%
>   rtla: Add timerlat user-space support for timerlat top
> 
>  Documentation/tools/rtla/common_options.rst   |   8 +
>  .../tools/rtla/common_timerlat_aa.rst         |   7 -
>  .../tools/rtla/rtla-timerlat-hist.rst         |   7 +-
>  .../tools/rtla/rtla-timerlat-top.rst          |  14 +
>  tools/tracing/rtla/src/osnoise.c              |  65 ++++
>  tools/tracing/rtla/src/osnoise.h              |   5 +
>  tools/tracing/rtla/src/osnoise_hist.c         |  90 ++++-
>  tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
>  tools/tracing/rtla/src/timerlat_aa.c          |  35 +-
>  tools/tracing/rtla/src/timerlat_aa.h          |   5 +-
>  tools/tracing/rtla/src/timerlat_hist.c        | 139 +++++++-
>  tools/tracing/rtla/src/timerlat_top.c         | 229 +++++++++++--
>  tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++
>  tools/tracing/rtla/src/timerlat_u.h           |  18 +
>  tools/tracing/rtla/src/utils.c                | 324 +++++++++++++++++-
>  tools/tracing/rtla/src/utils.h                |   7 +
>  16 files changed, 1162 insertions(+), 98 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.c
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.h
> 

