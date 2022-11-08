Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697E6209D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiKHHFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:05:20 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3477DFEF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:05:19 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 136so8773047pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 23:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgUztr1FPkYMtGAcAUkcMTH2+l5bzJxJ8ksi2QtEabw=;
        b=n3jmX9wlUeuxE0iaEBgyCFGRJ0/Yl4UQS4wsnlufHSOzKaaOSiEeRuz4RRhmnziM5q
         nWrYKqQoVlNqvAQYEALwmek2f1AyrxXXqeXNujjL56eAykQWqxm28cTrWj5n/peI+ddS
         nmS+KwvPMQu6sGr3Jo/6lzXmSg1iDMw2DiqieMiIdaD4zF6D6apgWFH8Rggvk+9EWH6u
         zlG63rYQYJI8aVM4Wuf3SH9XV88XFlIDn4IsIvE2tKdlN2eHTJvzEPXmzlMk3Hpxa4cz
         f6HTpiaMnWqvB3OZMcROtcIyPMQVvs6BLyD0qvWuaONhiEgqz4D/K6rFJRylCEiHZY44
         iFLQ==
X-Gm-Message-State: ACrzQf1FQ8uZcIJdE5WDWlCOBAN7J8e3CoOvUcusuHt5hYY+l8cgkNpM
        33/ostgZpL74N5Fjtw4hNVI=
X-Google-Smtp-Source: AMsMyM4vhZW1/UQizBr+4XX2IUhDCxHW6YrneV+b9hSQ3GolbJ3TSm8SY8t1czJDSYw/ghq6ve+rDQ==
X-Received: by 2002:aa7:9298:0:b0:56b:b6dc:988a with SMTP id j24-20020aa79298000000b0056bb6dc988amr55054724pfa.5.1667891118976;
        Mon, 07 Nov 2022 23:05:18 -0800 (PST)
Received: from fedora ([136.24.99.118])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b001886ff822ffsm6095316plk.186.2022.11.07.23.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 23:05:18 -0800 (PST)
Date:   Mon, 7 Nov 2022 23:05:16 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] Cleanup and optimization patches for percpu
Message-ID: <Y2n/rEu7HzRbXZXL@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-1-bhe@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baoquan,

On Mon, Oct 24, 2022 at 04:14:27PM +0800, Baoquan He wrote:
> These were found out when reading percpu code, and queued in my local
> branch for long time. Send them out for reviewing.
> 
> Baoquan He (8):
>   mm/percpu: remove unused pcpu_map_extend_chunks
>   mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
>   mm/percpu: Update the code comment when creating new chunk
>   mm/percpu: add comment to state the empty populated pages accounting
>   mm/percpu: replace the goto with break
>   mm/percpu.c: remove the lcm code since block size is fixed at page
>     size
>   mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
>   mm/slub, percpu: correct the calculation of early percpu allocation
>     size
> 
>  include/linux/percpu.h |  7 +++----
>  mm/percpu.c            | 44 +++++++++++++++++-------------------------
>  mm/slub.c              |  3 ++-
>  3 files changed, 23 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

I've applied patches 1-7 to for-6.2.

Thanks,
Dennis
