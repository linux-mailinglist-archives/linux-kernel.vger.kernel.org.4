Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAFB6870D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjBAWHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjBAWHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:07:36 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729C70D5E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:07:35 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m15so46679ilh.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgGSCmWoJAXYNph/eZ/fOJqcJGkXlgjA5b6ycn0lPOU=;
        b=UdL1DBAG9PXFlsln9DlmkNlvyKKhk1B8HaRvYZ+OukzPriTLI1eGwRLmm+2VEyzj5y
         dlB13lJB3ba6RmCATw5cMzcyHv8MkMHo7eZbYM+Ba76S/0zmEcdRz9Ui2slBL2tOunkP
         bB0LYhDIUdmsb7L5bhr48Qkv8YSwAXgiJiWLtUs40HQlJB9ktPCVnjKVZ2zCUFStjijE
         OF+qAtKJ1+n7tI/5imR7ezcIUnsRRXknCFd881wRg268PUnDIfvodK1TBvjsUXSu1czc
         gYuqe2jnhHLeLmUHb939endReEVSVe3LyBe6DtuYbcuOw1bBYdcfoo8btAfB0e9HHQyS
         DRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgGSCmWoJAXYNph/eZ/fOJqcJGkXlgjA5b6ycn0lPOU=;
        b=RfRZc54DEKR786s0FkVoQ+7sRrh4wwcvB/gy+hBic+9dD5o5ZM0+5DKR+Hg3oCfvsu
         p0Lb9fEiG2sCRPEO+4CqsTRcrMoVmtACS7rfEhCuJKZfXMtmXw1yF/6OqP6sgAfWmGX1
         eJ5T8LcEvP0sS/J7Nl0FbFZSbQ5/EzKoxtsvnDf9amR2/hCuV/7MnK4nYB8do+90g7Ju
         /+W9ZcjnXpJjMdeWTEydcYwlkKVvEoPwg0yr49dJrWMAg+KwLpm3fX071brrDNhjMQXB
         Yefg2njrqCGHC/pDInbTGVcqDeCbzIii6P9Ak+rMl5ut01j8DE0lNs1wdeWFOCdWXzXI
         fMhQ==
X-Gm-Message-State: AO0yUKVdgGizyMaE2EiRU/Hqxkl9Wy4Ym071AihT96R3ieYHugF0SZmx
        sSlZUILblMvK+SVNyKgR3FWheg==
X-Google-Smtp-Source: AK7set9e9SOti8Km7bTvUM53/+/fq3flDPPT7TlLmUYqHiJWXkW0iA8DdIXm+S9j+vF0+NFw/yxudg==
X-Received: by 2002:a05:6e02:1be5:b0:30e:efe0:8b10 with SMTP id y5-20020a056e021be500b0030eefe08b10mr346997ilv.11.1675289254682;
        Wed, 01 Feb 2023 14:07:34 -0800 (PST)
Received: from google.com ([2620:15c:183:200:f8e7:6a84:e0d7:128])
        by smtp.gmail.com with ESMTPSA id h6-20020a926c06000000b00300b9b7d594sm5309285ilc.20.2023.02.01.14.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:07:34 -0800 (PST)
Date:   Wed, 1 Feb 2023 15:07:30 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 7/9] tools/virtio: use canonical ftrace path
Message-ID: <Y9rioglGan9fZdcv@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-8-zwisler@google.com>
 <20230130142616-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130142616-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:26:43PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 30, 2023 at 11:19:13AM -0700, Ross Zwisler wrote:
> > The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> > 
> > But, from Documentation/trace/ftrace.rst:
> > 
> >   Before 4.1, all ftrace tracing control files were within the debugfs
> >   file system, which is typically located at /sys/kernel/debug/tracing.
> >   For backward compatibility, when mounting the debugfs file system,
> >   the tracefs file system will be automatically mounted at:
> > 
> >   /sys/kernel/debug/tracing
> > 
> > A few spots in tools/virtio still refer to this older debugfs
> > path, so let's update them to avoid confusion.
> > 
> > Signed-off-by: Ross Zwisler <zwisler@google.com>
> > ---
> >  tools/virtio/virtio-trace/README        | 2 +-
> >  tools/virtio/virtio-trace/trace-agent.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
> > index b64845b823ab..cea29a2a4c0a 100644
> > --- a/tools/virtio/virtio-trace/README
> > +++ b/tools/virtio/virtio-trace/README
> > @@ -95,7 +95,7 @@ Run
> >  
> >  1) Enable ftrace in the guest
> >   <Example>
> > -	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> > +	# echo 1 > /sys/kernel/tracing/events/sched/enable
> >  
> >  2) Run trace agent in the guest
> >   This agent must be operated as root.
> > diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
> > index cdfe77c2b4c8..805942d02e9f 100644
> > --- a/tools/virtio/virtio-trace/trace-agent.c
> > +++ b/tools/virtio/virtio-trace/trace-agent.c
> > @@ -19,7 +19,7 @@
> >  #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
> >  #define PIPE_MAX_SIZE		(1024*1024)
> >  #define READ_PATH_FMT	\
> > -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> > +		"/sys/kernel/tracing/per_cpu/cpu%d/trace_pipe_raw"
> 
> Should we try both old and new path then?

Sure, I think it makes sense to have all the comments & documentation point
only to the preferred location, but I think for tools it makes sense to check
both places so that we don't see field regressions.  This is what the BPF code
does:

https://elixir.bootlin.com/linux/latest/source/tools/bpf/bpftool/tracelog.c#L98

I'll add a check and fallback to this tool & send out v2.  Thanks for the
review.

> >  #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
> >  #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
> >  
> > -- 
> > 2.39.1.456.gfc5497dd1b-goog
> 
