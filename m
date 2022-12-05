Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC96421DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiLED35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLED3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:29:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E413D04
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2647B80D3D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54DC433C1;
        Mon,  5 Dec 2022 03:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670210991;
        bh=NinKr9TPNy5b7aiD7g/Y6E+7ERnGpivGkysf0wBlaHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QQB5W33ph1SB5874W4XgarOAFUoSle/OulowAMoeehNn8Tv0TsVSFUXOimBtbt38Q
         RUt5pPuhYlZAbM5RYjd1e0eVa02WsIXLu/yBAGshBoSpAryZJn3sdVIgNACqg/BCpm
         O7/Zd1eNbxkSACh0aoEkuWGb67A/pUB/42HNoZtAwevPETsApKlZZFQaedkBQwEP5K
         tZXPWlOY/m6SIaaNGtjbBupcElH3/ZjAY11xLvtOL+I2d+NiATuR0FoRWHigW9fSvK
         ND74xZ+qDB4F+pn9SdOU5XXDUQBfswIH7l/JMfXRm3NbkOLvkZu+hxIWMIuJbAYgYt
         XEEpzXog7kxDw==
Date:   Mon, 5 Dec 2022 12:29:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-Id: <20221205122948.809cb1dcbc5c0fa7ed61b415@kernel.org>
In-Reply-To: <20221204213929.2edc730b@rorschach.local.home>
References: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <202212022034.OqPXTS9u-lkp@intel.com>
        <20221205112236.f99c6104e988aa4f3dd89cd0@kernel.org>
        <20221204213929.2edc730b@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 21:39:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 5 Dec 2022 11:22:36 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 5cfc95a52bc3..14f18edfe5bc 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6572,7 +6572,8 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
> >  	return ret;
> >  }
> >  
> > -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> > +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> > +	|| defined(CONFIG_OSNOISE_TRACER)
> >  
> 
> When it gets this much, we need to put it into the trace.h header and
> define it. Actually, we have something that handles this too.
> 
> #if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
>         || defined(CONFIG_OSNOISE_TRACER)) && defined(CONFIG_FSNOTIFY)
> #define LATENCY_FS_NOTIFY
> #endif
> 
> 
> We can add:
> 
>  #if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> 	|| defined(CONFIG_OSNOISE_TRACER)) && defined(CONFIG_FSNOTIFY)
>  #define LATENCY_FS_NOTIFY
> +#define USES_MAX_TRACE
>  #endif

No, that including defined(CONFIG_FSNOTIFY) :)

So it must be something like 

  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
          || defined(CONFIG_OSNOISE_TRACER)
  #define USE_MAX_TRACE_OPS
  #endif

  #if defined(USE_MAX_TRACE_OPS) && defined(CONFIG_FSNOTIFY)
  #define LATENCY_FS_NOTIFY
  #endif


But this introduces a hidden dependency which is not tracked by
kconfig. So I think it is better to make those kconfig (non-menu)
items. (and the question came up, why can't those use (depend on)
CONFIG_TRACER_MAX_TRACE instead of introducing the USE_MAX_TRACE_OPS.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
