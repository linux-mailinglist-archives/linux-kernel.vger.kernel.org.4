Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06066421E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiLEDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLEDdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF4DF00
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A466760F56
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C25AC433D6;
        Mon,  5 Dec 2022 03:33:10 +0000 (UTC)
Date:   Sun, 4 Dec 2022 22:33:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-ID: <20221204223308.22e63bac@rorschach.local.home>
In-Reply-To: <20221205122948.809cb1dcbc5c0fa7ed61b415@kernel.org>
References: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <202212022034.OqPXTS9u-lkp@intel.com>
        <20221205112236.f99c6104e988aa4f3dd89cd0@kernel.org>
        <20221204213929.2edc730b@rorschach.local.home>
        <20221205122948.809cb1dcbc5c0fa7ed61b415@kernel.org>
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

On Mon, 5 Dec 2022 12:29:48 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> No, that including defined(CONFIG_FSNOTIFY) :)

Ah I missed that :-)

> 
> So it must be something like 
> 
>   #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
>           || defined(CONFIG_OSNOISE_TRACER)
>   #define USE_MAX_TRACE_OPS
>   #endif
> 
>   #if defined(USE_MAX_TRACE_OPS) && defined(CONFIG_FSNOTIFY)
>   #define LATENCY_FS_NOTIFY
>   #endif
> 
> 
> But this introduces a hidden dependency which is not tracked by
> kconfig. So I think it is better to make those kconfig (non-menu)

Right, that could be done.

> items. (and the question came up, why can't those use (depend on)
> CONFIG_TRACER_MAX_TRACE instead of introducing the USE_MAX_TRACE_OPS.)

Probably just have OSNOISE and HWLAT select TRACER_MAX_TRACE and just
use that.

-- Steve
