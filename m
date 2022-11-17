Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1C62E7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiKQWEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiKQWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:04:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C278E2A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:02:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so949633pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPXEo0MQxgRgm6aqyfLPfjz5S5PKpe0TNoXL4HtMhrE=;
        b=NSQnSGeFZnhk83HxB8MY5K06i5qW25+/sUJmRp3vkuBWzREzMj0HwT2tnRyLSyMEM0
         FzXTIoUDt4HbbCzqBE7V/grHvkGlENVNlAFYNw22mYQQFrLQafeaTkITc3HUznUk7IEQ
         0jyq86HyDaRZ/dGx5akMptMdoSfPYFkOw6yB5PCN7LWh344/WfxB6kl3GR9Bl1d7pW38
         pcowTBp+wdKbBEIS62Nba2HwuU59rXymTrlcHT2sroSs/bP0kX7qYloZjrOSQFiLeWwQ
         XsaHyCCDP41AKLRLRM7/k9u54UWoapIMzVwznUysjCQ+HVJgqKo124dIBHMmZ3UgvhsW
         nZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPXEo0MQxgRgm6aqyfLPfjz5S5PKpe0TNoXL4HtMhrE=;
        b=psD5syW1TfVNVz8RQGe7YLEJG585fOeWqlIqdef7OTg1tIwE1JxDC/0zp1MiLDmO6e
         yYHCzMHAfxPF2OK6B3HFfkJpyFw444Gjo9KZDzzvzMCYfqrj1xVAZBhDcWm1usftBBwu
         NvYmQlMGZaS7THlw6I0pYeZ3ETahWkrQHZ32K84EjQkqlGtvx0m/At/QsxF/9lGDzEpk
         M+9Y1v2H69pzDV9PLOiP3zy5zFzzHWh8H3sH2/n/xlEkx53bXjmt6/AQnUdgVBg5hnL6
         LpUvHK3uCpL7mESM2vfYyDpUXFu6qyAGdU3sB5xl4oya6lMMOYYVmOo6p7sBoLXEFYLp
         zciQ==
X-Gm-Message-State: ANoB5plrqizhVlmq50kl+EAiBnhy/HWdbiM/UfriVp/pWdhtj5SsS0Jr
        V37l9Mx6GtYnTD770DTdvQI=
X-Google-Smtp-Source: AA0mqf6+M5vs5JBRbs1+WvN9j36Ye4NODUF0M+6IaF85HOTNHo9HuQq4jTGHuNO85sx8UYzvXquS6w==
X-Received: by 2002:a17:903:2787:b0:188:53b9:f003 with SMTP id jw7-20020a170903278700b0018853b9f003mr4501340plb.170.1668722562707;
        Thu, 17 Nov 2022 14:02:42 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id z4-20020aa79f84000000b0056c7b49a011sm1664339pfr.76.2022.11.17.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:02:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 14:02:40 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y3avgN6e8uZEb7+c@google.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117163839.230900-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:38:36AM -0800, Nhat Pham wrote:
> Currently, zsmalloc has a hierarchy of locks, which includes a
> pool-level migrate_lock, and a lock for each size class. We have to
> obtain both locks in the hotpath in most cases anyway, except for
> zs_malloc. This exception will no longer exist when we introduce a LRU
> into the zs_pool for the new writeback functionality - we will need to
> obtain a pool-level lock to synchronize LRU handling even in zs_malloc.
> 
> In preparation for zsmalloc writeback, consolidate these locks into a
> single pool-level lock, which drastically reduces the complexity of
> synchronization in zsmalloc.
> 
> We have also benchmarked the lock consolidation to see the performance
> effect of this change on zram.
> 
> First, we ran a synthetic FS workload on a server machine with 36 cores
> (same machine for all runs), using
> 
> fs_mark  -d  ../zram1mnt  -s  100000  -n  2500  -t  32  -k
> 
> before and after for btrfs and ext4 on zram (FS usage is 80%).
> 
> Here is the result (unit is file/second):
> 
> With lock consolidation (btrfs):
> Average: 13520.2, Median: 13531.0, Stddev: 137.5961482019028
> 
> Without lock consolidation (btrfs):
> Average: 13487.2, Median: 13575.0, Stddev: 309.08283679298665
> 
> With lock consolidation (ext4):
> Average: 16824.4, Median: 16839.0, Stddev: 89.97388510006668
> 
> Without lock consolidation (ext4)
> Average: 16958.0, Median: 16986.0, Stddev: 194.7370021336469
> 
> As you can see, we observe a 0.3% regression for btrfs, and a 0.9%
> regression for ext4. This is a small, barely measurable difference in my
> opinion.
> 
> For a more realistic scenario, we also tries building the kernel on zram.
> Here is the time it takes (in seconds):
> 
> With lock consolidation (btrfs):
> real
> Average: 319.6, Median: 320.0, Stddev: 0.8944271909999159
> user
> Average: 6894.2, Median: 6895.0, Stddev: 25.528415540334656
> sys
> Average: 521.4, Median: 522.0, Stddev: 1.51657508881031
> 
> Without lock consolidation (btrfs):
> real
> Average: 319.8, Median: 320.0, Stddev: 0.8366600265340756
> user
> Average: 6896.6, Median: 6899.0, Stddev: 16.04057355583023
> sys
> Average: 520.6, Median: 521.0, Stddev: 1.140175425099138
> 
> With lock consolidation (ext4):
> real
> Average: 320.0, Median: 319.0, Stddev: 1.4142135623730951
> user
> Average: 6896.8, Median: 6878.0, Stddev: 28.621670111997307
> sys
> Average: 521.2, Median: 521.0, Stddev: 1.7888543819998317
> 
> Without lock consolidation (ext4)
> real
> Average: 319.6, Median: 319.0, Stddev: 0.8944271909999159
> user
> Average: 6886.2, Median: 6887.0, Stddev: 16.93221781102523
> sys
> Average: 520.4, Median: 520.0, Stddev: 1.140175425099138
> 
> The difference is entirely within the noise of a typical run on zram. This
> hardly justifies the complexity of maintaining both the pool lock and
> the class lock. In fact, for writeback, we would need to introduce yet
> another lock to prevent data races on the pool's LRU, further
> complicating the lock handling logic. IMHO, it is just better to
> collapse all of these into a single pool-level lock.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
