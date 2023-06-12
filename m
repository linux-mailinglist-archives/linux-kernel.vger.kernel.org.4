Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4272BE39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjFLKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjFLJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431D4C2B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3WIPm4z3+5JGaYbfhg2L2EMz9XADf68AcDZRHShQv4=;
        b=GJTV87DUEE67fLmNtfs8yr86FU2ZUcWP8xlW5N2HC9hh5Ad4rb9n0FmDghQuh5aV9e0t6t
        p8JkpdNhEae6Yxr+iD58FBPHBwHrLNRSL7d2hyJrCCGxT/S4zdq70DrTt7D1twshfjOx/+
        fQLb6QNGdp4zNKcTl4R13yJNad2Wv+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-WHiiV8xsOKmrj6eVzeUj2g-1; Mon, 12 Jun 2023 05:41:59 -0400
X-MC-Unique: WHiiV8xsOKmrj6eVzeUj2g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so17553025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562918; x=1689154918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3WIPm4z3+5JGaYbfhg2L2EMz9XADf68AcDZRHShQv4=;
        b=mBu3VSNj155IrDlxQmiWjoM6rr37qfRYqvIIJmlq+BRcENz1LIutpb4FN93XnIwqeg
         kZ8equ5qzpxinmGtLJnChugSj9n7A33h3T7OdFU2SjM6CgWT51nL3mpB/M9JAk52czHf
         3yIui1UmuhB8PbVyNX1gYez1aSN1zySCL0I3xwJcbuhXdtHKJkupZEEbZCmN+Q/GJIQp
         V/sQnoLrgXikbO44PLoue8uvQsF/EtiqjQSFcHCxfLNB8TbjCD2kyk7y+V4LJ5ju0tur
         eQBB3CpCpeS/ia597FLaIiHehMU4KHg/ctqPaN0c+rkkRoXw8tUVjDlzbo/ByZk0du9o
         Cjpw==
X-Gm-Message-State: AC+VfDwOu+ycsABu1aYMcxmhzsX1bYHqbypT+8bJSTHuGbS1afe3IauI
        AoTdcQF9WyNJnlJzQdJkrbEIYxfS91p/B8ySEDwszv+jbPqPET57fUazF1mbp+//ek6HcQQgk4G
        aORg650oMFHM6tySbRwfxMqGT
X-Received: by 2002:a05:600c:2254:b0:3f7:e535:ff3b with SMTP id a20-20020a05600c225400b003f7e535ff3bmr5477921wmm.3.1686562918184;
        Mon, 12 Jun 2023 02:41:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sm436YTX68TNCme7HngotSe4eDUtAGeZuBK92RHWCc1ajo1ryGkbEfHpBQKOiPAD0EO+q1A==
X-Received: by 2002:a05:600c:2254:b0:3f7:e535:ff3b with SMTP id a20-20020a05600c225400b003f7e535ff3bmr5477906wmm.3.1686562917812;
        Mon, 12 Jun 2023 02:41:57 -0700 (PDT)
Received: from localhost.localdomain ([151.29.46.22])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm10886705wma.24.2023.06.12.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:41:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:41:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V3 00/11] rtla improvements
Message-ID: <ZIboY08U6SMS1tiO@localhost.localdomain>
References: <cover.1686066600.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/06/23 18:12, Daniel Bristot de Oliveira wrote:
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
> and to collect the additional field via rtla timerlat top/hist.
> 
> Changes from V2:
>   - Add timerlat hist -u option
>   - Link: https://lore.kernel.org/lkml/cover.1684863094.git.bristot@kernel.org/
> Changes from V1:
>   - Add the user-space thread support to rtla timerlat top
>   - Link: https://lore.kernel.org/lkml/cover.1683827510.git.bristot@kernel.org/
> 
> Daniel Bristot de Oliveira (11):
>   rtla: Add -C cgroup support
>   rtla: Add --house-keeping option
>   rtla: Change monitored_cpus from char * to cpu_set_t
>   rtla: Automatically move rtla to a house-keeping cpu
>   rtla/timerlat: Give timerlat auto analysis its own instance
>   rtla/timerlat_hist: Add auto-analysis support
>   rtla: Start the tracers after creating all instances
>   rtla/hwnoise: Reduce runtime to 75%
>   rtla: Add timerlat user-space support for timerlat top
>   rtla: Add timerlat user-space support for
>   Documentation: Add tools/rtla timerlat -u option documentation
> 
>  Documentation/tools/rtla/common_options.rst   |   8 +
>  .../tools/rtla/common_timerlat_aa.rst         |   7 -
>  .../tools/rtla/common_timerlat_options.rst    |   7 +
>  .../tools/rtla/rtla-timerlat-hist.rst         |   7 +-
>  .../tools/rtla/rtla-timerlat-top.rst          |   7 +
>  tools/tracing/rtla/src/osnoise.c              |  65 ++++
>  tools/tracing/rtla/src/osnoise.h              |   5 +
>  tools/tracing/rtla/src/osnoise_hist.c         |  90 ++++-
>  tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
>  tools/tracing/rtla/src/timerlat_aa.c          |  35 +-
>  tools/tracing/rtla/src/timerlat_aa.h          |   5 +-
>  tools/tracing/rtla/src/timerlat_hist.c        | 262 ++++++++++++--
>  tools/tracing/rtla/src/timerlat_top.c         | 229 +++++++++++--
>  tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++
>  tools/tracing/rtla/src/timerlat_u.h           |  18 +
>  tools/tracing/rtla/src/utils.c                | 324 +++++++++++++++++-
>  tools/tracing/rtla/src/utils.h                |   7 +
>  17 files changed, 1277 insertions(+), 106 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.c
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.h
> 
> -- 

I've been heavily relying on these for debugging various issues with
latency sensitive workloads and they work like a charm.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

