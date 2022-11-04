Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28393618F53
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKDD6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDD6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:58:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BD11C1B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:58:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 64so3393734pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 20:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHL1xFrbNHnWDyb+sE00zVoxKUK+JI+O6GLJxn6wij8=;
        b=N2RqmlDsYfsvjfdHNzzjMFZSQWHzsiWcFngBJWUdvjQGUcSCJv8cpYZN/FDuG/vUcC
         1G05GIYrxXjoFjtJRoR24SI0/VRtvS++O72hDuBDCqmws7kb9hyXgzQb2WmSzMEEOlfF
         ueZw3JKUdlm4PUjGU65zu6T3U46wpja3IeQX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHL1xFrbNHnWDyb+sE00zVoxKUK+JI+O6GLJxn6wij8=;
        b=kAFFL0LCnPmp3gPs4cDK34yKtKRqAQEzskFdPz9PrrYqVbHbQt+wHnYJXnQ7AhP7gN
         Ql+H4C4ZeXT7O6hZQXs0UAcfExwGDE5HgQr+qXCLVxrufGtXXlVa1B9tP7bv4szFI5aI
         Sggtb1sCeOlQG5n6XggZBlZQWjmuwo1UPdGSP0v5i2UhvKF9IzZ6iuMmLkTaz8Q0NV47
         /an64nfv7gau730UqwG14BjfLN6SMLt5z2rp6x8N/JKvoaXn07CYYOFuPhjtYMYG/dFr
         HdOVR/SbI1rNg3VJHqaEJAozVS8QX7TdtTuF3SUGeCLSQ8YiHIa9CwGmH5SMnBossjAh
         JHhQ==
X-Gm-Message-State: ACrzQf3SyZuHe11J0iRxBZIxjK1oh3hQ9mosN85aHdtgkQt5RsMIAIr3
        f6gLJ2Zz+LGGPPACSIwL2+69LQ==
X-Google-Smtp-Source: AMsMyM4D+HSyRRPySEiDj2be671NufwvYKpaDdLtGciiyAawWoHzYmmb5rs3RBfYL0a5S+0xgcBeTA==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df8 with SMTP id z2-20020a056a00240200b0052c81cf8df8mr34238451pfh.60.1667534315977;
        Thu, 03 Nov 2022 20:58:35 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id s9-20020a656449000000b0041ae78c3493sm1467952pgv.52.2022.11.03.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:58:35 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:58:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2SN5tMH8CqYHsYK@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PbrOqRMLDsYev0@cmpxchg.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 11:18), Johannes Weiner wrote:
> > > I'm not in love with this, to be honest. One big pool lock instead
> > > of 255 per-class locks doesn't look attractive, as one big pool lock
> > > is going to be hammered quite a lot when zram is used, e.g. as a regular
> > > block device with a file system and is under heavy parallel writes/reads.
> 
> TBH the class always struck me as an odd scope to split the lock. Lock
> contention depends on how variable the compression rate is of the
> hottest incoming data, which is unpredictable from a user POV.
> 
> My understanding is that the primary usecase for zram is swapping, and
> the pool lock is the same granularity as the swap locking.

That's what we thought until a couple of merge windows ago we figured
(the hard way) that SUSE uses ZRAM as a normal block device with a real
file-system on it. And they use it often enough to immediately spot the
regression which we landed.

> Do you have a particular one in mind? (I'm thinking journaled ones are
> not of much interest, since their IO tends to be fairly serialized.)
> 
> btrfs?

Probably some parallel fio workloads? Seq, random reads/writes from
numerous workers.

I personally sometimes use ZRAM when I want to compile something and
I care only about the package, I don't need .o for recomplilation or
something, just the final package.
