Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9D63B8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiK2EBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiK2EBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:01:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E634E43A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:01:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so12141173pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoNynUsXcZWRRQTA42Lr8aZhhKDdqzAsGG5E/HJMyjk=;
        b=L+ggEBnUdDJGpqbNThJ/vIeO3gs8VDddvHdRi3e2qz7IQ4S0zDDeDIZbKvwIpy/08f
         /+uKWt9P5uP/Gu6ScjZm80hBBD6oSSJQCHVU+NH/WCPOvocEhb575zy1y6cQL9fEFHbe
         DCx3iUv2XturIqr7QQ50Cw9fwsn6xso0Arp3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoNynUsXcZWRRQTA42Lr8aZhhKDdqzAsGG5E/HJMyjk=;
        b=8LE09NlcCT3Oip0kPQ4Izq8Q6Le58MJ2p9QuwW+Za2QlSWWlhDKxHg6L66LOzeaK3B
         i0xomdqYiLwvKhL+iYPo53QrZzJ6Mc2buwRlzIvouPmgrr4q4tJsFEtLMgGsFBLcvIhu
         UEfSVVXK/JwknwBLfSph6k1zqmzb35gLX1dzZfCzPqULODqKCDL1SH3i1xYJbfan2+Y/
         IcRVPcMyONYVP4TMQDASOdID9AZqLEXu3PtnMPnfvQPsST8myFDMR+zkLg/qW3wp86QK
         6kMFXj4g/gKN+87HK0ihC2flAgsv4fKlsGwiAW6s1GTe+WTZM7+/9iydex1m2Ltvda++
         JMpA==
X-Gm-Message-State: ANoB5plv6TFyadMtmc7JHGObaim9RtwMilbRTzmf+QoY8SRtDE85r97C
        +4x9oMsYrcLyDuoghJTGdC02Qw==
X-Google-Smtp-Source: AA0mqf5cllq8xbDaQrTyt/2TeL7ufjfwuaEUbskEY98DprdDjtJX3d1TQZFhzVs8UlGzzuIZ6lJImA==
X-Received: by 2002:a17:90b:2711:b0:213:9b80:ceee with SMTP id px17-20020a17090b271100b002139b80ceeemr63951801pjb.243.1669694481669;
        Mon, 28 Nov 2022 20:01:21 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id b196-20020a621bcd000000b0056ddd2ac8f1sm8806807pfb.211.2022.11.28.20.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 20:01:20 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:01:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 3/6] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y4WECyoq3fP/cOmi@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/28 11:16), Nhat Pham wrote:
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
> Acked-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
