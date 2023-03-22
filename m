Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4236C406B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVCdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCVCdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71902113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679452374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
        b=IZi4b9wmRy2VokAZnpLkAKbkn5axwxhLgeVPtxgXzygCWcbs+UFiE1m/7dus1a2yL1JPG9
        R/C4B3Vi0DbeVa9TzpUzMUWudO4sRywTZQ8x63hRwwVRfD7ofV+WLaSLsUa55IE+XHg3rM
        IbyeFgD7Ac5J4+2JMimt7QWbKOKom40=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-LniuuGb6OsSkA7qrJqI_rQ-1; Tue, 21 Mar 2023 22:32:53 -0400
X-MC-Unique: LniuuGb6OsSkA7qrJqI_rQ-1
Received: by mail-wr1-f70.google.com with SMTP id y4-20020adfc7c4000000b002d633dc129aso841526wrg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679452372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
        b=m0sqI0v1nqEgXVa9aIcwj09C3hqgEK90eq6PJfuj7ptv4Vdxan1oz9vVp7h4l5kkzg
         85STUuGVtF3Zw37R5esiH2QlRuPJSCxKnPoNx6AzHWfkBsLcih/GBXO7f44XidJBVPyM
         g3FJKJI+QVdlg869mfUeezuKKYMNw7owT9SivxP9UxJFfKIyNHcUl0oONfiNwKi+EYnE
         J/skHa/Dr2YeIVpHi7vXhnT/7F6hz0lunJLLZ/smrxrHxRiFrJ55EYvr97HCXg2HNX4k
         q63kK9tO9obhSOrlSYRNsLut6mxbrUWOm/ERf09N5hbLiIUbShwaV56wog5MZiKNTBem
         Mvqg==
X-Gm-Message-State: AO0yUKVD3QXw0PgKJR5euuKlnUC8j9UnOb/u+Qv3m9eCn7PMmJ2PDTqp
        OyzYCWlRI+VMd8qiz2BUe5aorGl8BbsTZY3cE7GUHiiKWMpu0v3gH3Fzr2diHwzJn2PShDAIH0Z
        5uMLnD58R8QIeh4jpYp6bKBYb
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id j1-20020a5d4521000000b002cfe827b597mr3982525wra.10.1679452371928;
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set+IAoeXaV5Ezy2+ySyjfqstu/owf9Mg6SdCShB52Q1gVgr7GbSGeNN3VY0ntYreU5GIBMrYUQ==
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id j1-20020a5d4521000000b002cfe827b597mr3982509wra.10.1679452371580;
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm12661630wrw.108.2023.03.21.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:32:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230321223139-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> Changes in v2:
>  * Dropped patches which were pulled into maintainer trees.
>  * Split BPF patches out into another series targeting bpf-next.
>  * trace-agent now falls back to debugfs if tracefs isn't present.
>  * Added Acked-by from mst@redhat.com to series.
>  * Added a typo fixup for the virtio-trace README.
> 
> Steven, assuming there are no objections, would you feel comfortable
> taking this series through your tree?

for merging up to patch 5 through another tree:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll merge patch 6, no problem.


> ---
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
> There are many places where this older debugfs path is still used in
> code comments, selftests, examples and tools, so let's update them to
> avoid confusion.
> 
> I've broken up the series as best I could by maintainer or directory,
> and I've only sent people the patches that I think they care about to
> avoid spamming everyone.
> 
> Ross Zwisler (6):
>   tracing: always use canonical ftrace path
>   selftests: use canonical ftrace path
>   leaking_addresses: also skip canonical ftrace path
>   tools/kvm_stat: use canonical ftrace path
>   tools/virtio: use canonical ftrace path
>   tools/virtio: fix typo in README instructions
> 
>  include/linux/kernel.h                        |  2 +-
>  include/linux/tracepoint.h                    |  4 ++--
>  kernel/trace/Kconfig                          | 20 +++++++++----------
>  kernel/trace/kprobe_event_gen_test.c          |  2 +-
>  kernel/trace/ring_buffer.c                    |  2 +-
>  kernel/trace/synth_event_gen_test.c           |  2 +-
>  kernel/trace/trace.c                          |  2 +-
>  samples/user_events/example.c                 |  4 ++--
>  scripts/leaking_addresses.pl                  |  1 +
>  scripts/tracing/draw_functrace.py             |  6 +++---
>  tools/kvm/kvm_stat/kvm_stat                   |  2 +-
>  tools/lib/api/fs/tracing_path.c               |  4 ++--
>  .../testing/selftests/user_events/dyn_test.c  |  2 +-
>  .../selftests/user_events/ftrace_test.c       | 10 +++++-----
>  .../testing/selftests/user_events/perf_test.c |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c  |  4 ++--
>  tools/tracing/latency/latency-collector.c     |  2 +-
>  tools/virtio/virtio-trace/README              |  4 ++--
>  tools/virtio/virtio-trace/trace-agent.c       | 12 +++++++----
>  19 files changed, 49 insertions(+), 44 deletions(-)
> 
> -- 
> 2.39.1.637.g21b0678d19-goog

