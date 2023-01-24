Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372006790AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjAXGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAXGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:13:59 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054102CC5A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:13:57 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h5so734174ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BqbyDPFS6fv/cYC1uzpvtzR0SG8Rw0pjke3RGXRVQX4=;
        b=R/P4oKRXADOer7BEcL+Qt6Zm5zSetYuE69gWDmDHVMIzdTogwZgqT5wPj1DAq9jXQt
         /3vFukIe7lVx04Pd7T5XXqqTVo4Rhp+G16rmhcgLX3zF5x9DfOCM19T9q7MprwhNhxgw
         VzeOB9ZI2b832ucY+ELa5qEMYGuGNc4jRJQ8u7tJxN7HHD7Jdt8rJsH3aiHjaq/RLhZ0
         wpKZa4e7bbTZpemvkp+pdeAgFePEFG6ePGBZfZ9IRedMLA1PYONKFQ3CylOm1sMq2EJc
         Ac2pc/wJ3/jwEqo9OPZz/XuIkuLG3DzbcnCF2W6uk49ZcMTrLlduRpuKa7mZrD+gYBEb
         KlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqbyDPFS6fv/cYC1uzpvtzR0SG8Rw0pjke3RGXRVQX4=;
        b=4fwWuv6y8Otd1mPkd5Qe7P2WduuyllykkTyDqaCYKd5z91B8AIf/FbqiITvALM9lbw
         oIMKVm/VcOLQ9DpZuc3Rr5inwNZfG5w5oB1Ba9GXdlkbnTHanxWHLzKaaVBrngh/0bTb
         CCmLGCxP4khnvaCMCkLCtKJxeGWlHPjfIyoqS+Iw2PAvTMLlKDNsPCUiqD3lQV+LUvPN
         zSkZl1MRpmNua6xPPVGaoC/s/k9cFHkvb27NJh9Ql1MR4wHcnQNuY7yzRD0dxl+PmZTo
         d4TnGd1FYn3nbdG6aru6WMFkrF8zllkwK/nzpWRXDy5dDnO5cm2FaHbHBqUw0IMQe5nb
         ubyA==
X-Gm-Message-State: AO0yUKXpzcjakSfyMKt8bCe/gNeoGeGcOCjaUbig0zr4AI+vIiqRQ7a1
        DctTO00AsYP9CZdzjhD/OKcuvVBlvYCGe4c6lDnV
X-Google-Smtp-Source: AK7set/bXN9gp3NQtnIMwKBtmWdsSOsBy4hPegSVxwz3cXdeOEFHvFvfdlNxDSYJojHgWPA6sofSzuHkNW/lRBmYmdw=
X-Received: by 2002:a25:a28e:0:b0:80b:72cc:ba35 with SMTP id
 c14-20020a25a28e000000b0080b72ccba35mr18588ybi.330.1674540836144; Mon, 23 Jan
 2023 22:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
In-Reply-To: <20230123182728.825519-1-kan.liang@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 23 Jan 2023 22:13:45 -0800
Message-ID: <CANDhNCo-+rV5+2pxAbpX4Lj6EhR9gsP0SqWpipm3j_G_e8cMzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Convert TSC to monotonic clock for PEBS
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> A Processor Event Based Sampling (PEBS) record includes a field that
> provide the time stamp counter value when the counter was overflowed
> and the PEBS record was generated. The accurate time stamp can be used
> to reconcile user samples. However, the current PEBS codes only can
> convert the time stamp to sched_clock, which is not available from user
> space. A solution to convert a given TSC to user visible monotonic
> clock is required.
>
> The perf_event subsystem only converts the TSC in a NMI handler. The
> converter function must be fast and NMI safe.
>
> Considered the below two existing functions, but none of them fulfill
> the above requirements.
> - The ktime_get_mono_fast_ns() is NMI safe, but it can only return the
>   current clock monotonic rather than a given time's monotonic.
> - The get_device_system_crosststamp() can calculate the system time from
>   a given device time. But it's not fast and NMI safe.

So, apologies if this is a silly question (my brain quickly evicts the
details on get_device_system_crosststamp every time I look at it), but
rather then introducing a new interface, what would it take to rework
the existing get_device_system_crosststamp() logic to be usable for
both use cases?

thanks
-john
