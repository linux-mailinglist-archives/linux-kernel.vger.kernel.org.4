Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A248681A78
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjA3T1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbjA3T1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402515548
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675106809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zReAwY9Qd1mvDcwb5xa4eZkleNP48xcTFspo+kBenI=;
        b=dWlUD+2fsd8XQ9Cu22pfjNX6xbwxft8xtXyFJDsHbQ2q6biqDdBztn7nMaB4CmJDdkw/XI
        H1e/F1HR5WB+fYzCq6Djqwhta5GEZkirb3SM4WACR5DtmxH3yzLCJrIz+aEwDLnvoVae0J
        sMA5V7yjyTi1mFB0znFWgicTf4u5+ww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-ZVNSc0C_MfKZOKfOrJB8-w-1; Mon, 30 Jan 2023 14:26:48 -0500
X-MC-Unique: ZVNSc0C_MfKZOKfOrJB8-w-1
Received: by mail-wm1-f72.google.com with SMTP id iz20-20020a05600c555400b003dc53fcc88fso2408298wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zReAwY9Qd1mvDcwb5xa4eZkleNP48xcTFspo+kBenI=;
        b=44bdF4/HKwFu5CbobnUO4rG4Mt5XasYkwsJDQ3uBOHCcFUX9zD6+xVIbumy2eB3TzG
         l0W3mVj0Ao5t3IQmytQ2eeZ0fM+zmOjDK/ZUWLk5UxHrZz4iYlUzqafZ5QT6Rv6nSjie
         hiGDec2zS/BZi37VHhsw/4mZzGKBTNjW9s09wsx6T/cxzwUqMhmLc5t4UVRQz+KvKhLW
         BMtLn9WY46UbZH7zRIhefN8q+1eJkju4bL9C8gbXzLmaoUFJvX+KRpYAVzKMODAjIZw0
         HjCmYhHzoCZ5W5I1AmVuclApSQ6JniZ85Kwf/SMEJZPByVhNaJjIeNbQ69HYkCj9st0T
         couA==
X-Gm-Message-State: AO0yUKV/y7hJJ5rNcY9/q8JDQLHX811fZf6TZJR0y2BYM7TM1035STbt
        bnjQNA4lO8RVJ1Q3ibJ/GY8tBcDWKJlc8JWpNUNeqqlomrlxlB0HADgIxN9obpvKbFRYpvDxC1W
        YYOll56TYx5bj2+CaGJxV0uWL
X-Received: by 2002:a05:600c:2043:b0:3dc:5622:5ded with SMTP id p3-20020a05600c204300b003dc56225dedmr5615011wmg.12.1675106807284;
        Mon, 30 Jan 2023 11:26:47 -0800 (PST)
X-Google-Smtp-Source: AK7set+HKEF9qcmjdJeRfPmi1S0Zd9e5l2jeadeqVtxapSUKMx1q9Jxjx+GC52FTU98gwddsnpi9XA==
X-Received: by 2002:a05:600c:2043:b0:3dc:5622:5ded with SMTP id p3-20020a05600c204300b003dc56225dedmr5615000wmg.12.1675106807099;
        Mon, 30 Jan 2023 11:26:47 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm18781196wmn.11.2023.01.30.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:26:46 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:26:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 7/9] tools/virtio: use canonical ftrace path
Message-ID: <20230130142616-mutt-send-email-mst@kernel.org>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-8-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130181915.1113313-8-zwisler@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:19:13AM -0700, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> A few spots in tools/virtio still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  tools/virtio/virtio-trace/README        | 2 +-
>  tools/virtio/virtio-trace/trace-agent.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
> index b64845b823ab..cea29a2a4c0a 100644
> --- a/tools/virtio/virtio-trace/README
> +++ b/tools/virtio/virtio-trace/README
> @@ -95,7 +95,7 @@ Run
>  
>  1) Enable ftrace in the guest
>   <Example>
> -	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +	# echo 1 > /sys/kernel/tracing/events/sched/enable
>  
>  2) Run trace agent in the guest
>   This agent must be operated as root.
> diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
> index cdfe77c2b4c8..805942d02e9f 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -19,7 +19,7 @@
>  #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
>  #define PIPE_MAX_SIZE		(1024*1024)
>  #define READ_PATH_FMT	\
> -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> +		"/sys/kernel/tracing/per_cpu/cpu%d/trace_pipe_raw"

Should we try both old and new path then?

>  #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
>  #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog

