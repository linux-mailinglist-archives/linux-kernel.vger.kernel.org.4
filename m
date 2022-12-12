Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798EE64A872
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiLLUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLLUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9C1759E;
        Mon, 12 Dec 2022 12:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114C1B80DF3;
        Mon, 12 Dec 2022 20:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED96C433F0;
        Mon, 12 Dec 2022 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670875838;
        bh=xjPNwIng7u1uKDxLjTcDpGgKuppTqeqW9PKsY49SEQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJYomxaA99ir8eHhjqRgawYsNX4ylOTi/afgmFMvA1bTfcpGHfTO+IQvVvbUqnVEG
         Qe7J4AKGgcAMBRmJpN9wF6PBzk831ktzMixJuaMzmc0D9jDAJrXdJH+agnvdYdpgT9
         xwnpSOPZKkoUy+tz3Qh7VXE5BqLyfNMMG5c6mKkhlvH/DZhWQ/VsZDRG0X38rOqmwH
         1bjbmPS/O0ms4mt5Z3NQriIGLHbpsVDU0Hzr3gEnjgK7TIWJZZgQ+VxrooqGLpzOCf
         OCvM4ePltH6b/oQk1YAqKISuQnmxTn8GZKaG37pkQt8sq2CmmKYSTtK6nXUxhJ5oB2
         3EMpbVZRL6rww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 297A740483; Mon, 12 Dec 2022 17:10:36 -0300 (-03)
Date:   Mon, 12 Dec 2022 17:10:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 4/4] tools lib traceevent: Remove libtraceevent
Message-ID: <Y5eKvNYbRvhzRdKZ@kernel.org>
References: <20221130062935.2219247-1-irogers@google.com>
 <20221130062935.2219247-5-irogers@google.com>
 <Y5eGj4CuQKjr2I6h@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eGj4CuQKjr2I6h@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 12, 2022 at 04:52:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 29, 2022 at 10:29:35PM -0800, Ian Rogers escreveu:
> > libtraceevent is now out-of-date and it is better to depend on the
> > system version. Remove this code that is no longer depended upon by
> > any builds.
> 
> 
> 
> Thanks, applied and Added Steven's Acked-by.

Had to add this to keep 'make perf-tar-src-pkg' working:

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index c8e8e05b4ff1f56f..1da7f4b91b4f8af5 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -3,7 +3,6 @@ tools/arch
 tools/scripts
 tools/build
 tools/include
-tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
 tools/lib/subcmd
