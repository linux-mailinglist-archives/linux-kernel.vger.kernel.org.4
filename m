Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2574464219F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiLECji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLECjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:39:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55572FCC4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E329860EF7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD4C433C1;
        Mon,  5 Dec 2022 02:39:34 +0000 (UTC)
Date:   Sun, 4 Dec 2022 21:39:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-ID: <20221204213929.2edc730b@rorschach.local.home>
In-Reply-To: <20221205112236.f99c6104e988aa4f3dd89cd0@kernel.org>
References: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <202212022034.OqPXTS9u-lkp@intel.com>
        <20221205112236.f99c6104e988aa4f3dd89cd0@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 11:22:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5cfc95a52bc3..14f18edfe5bc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6572,7 +6572,8 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
>  	return ret;
>  }
>  
> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> +	|| defined(CONFIG_OSNOISE_TRACER)
>  

When it gets this much, we need to put it into the trace.h header and
define it. Actually, we have something that handles this too.

#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
        || defined(CONFIG_OSNOISE_TRACER)) && defined(CONFIG_FSNOTIFY)
#define LATENCY_FS_NOTIFY
#endif


We can add:

 #if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
	|| defined(CONFIG_OSNOISE_TRACER)) && defined(CONFIG_FSNOTIFY)
 #define LATENCY_FS_NOTIFY
+#define USES_MAX_TRACE
 #endif

And use that instead.

-- Steve
