Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8A720932
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjFBSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjFBSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:34:14 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB019A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:34:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-62885649f6eso9459016d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685730852; x=1688322852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWUTqA4q0RjWmhXjckzUDhYiGP6htvx0NsghNE+3oe4=;
        b=j3DRVuqgktuLBXlDKU5eN75HRp+Cel0gF57DTTtlmlADZJoWmYFDArAsObzsRT/7dX
         WPXmpM69Jq2MeGCh5oFItdUueo165CHgo7QGXQPmKPMDwTt4x15+JhCp2aGG+GxLRmlK
         1RROm55wAFPG0MLjnjpnWS5QX0XS4pwCdXoklRNi0+1h+PJ6dZhrlerMZNHI97TiBf0G
         Lp1O+1bcT3fgMKuCA+X/XPJCRNWBTSUKoh68mjmbTldDuEGEAraDLGUYETyCs4U6SBO7
         tuUyjXk5I2HYQOTd1EHLMl0D9vJKHXuYiVQ8uFYuHjsjV7joPBixRbIzeuuMAUiwqN73
         z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730852; x=1688322852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWUTqA4q0RjWmhXjckzUDhYiGP6htvx0NsghNE+3oe4=;
        b=Bu2hZVwUSOVuVvRYaaO892Wrsoyt8y7NK3NJb6R45UwkGQo9xBX1U3y3v3+3A4BVlp
         GUdY70aVkAqScvO60kHMmvxJ7luZH8c9KoQobnm5qGzn87v1WXsEJsptzXBi26BRDohG
         T1+bWLNqIBE6QI9TPFbh6fwqLb/PG4O7e3pwY6BaYMR78IBhONeituCvD6+RNc4AqzQ6
         bvaNMEjHs968LFut6kC2r4o6BS0ADePazpcItZHL7XSHKDa0RSuuC2ze1UvqoCI9bKhn
         gs/SgLt4A47VyFQf+CJEzEu6FrRB559S3As5rxNidwWRYRuUV74CCkN8ZCZtlIktD3HF
         urxQ==
X-Gm-Message-State: AC+VfDzkyenSPx1FpK32z9Ir/drnPotaTBTaH7JgsyNWfQGN3S4nKmGr
        RQRd1OklkOHmQ3dl+u61XWVZ/Q==
X-Google-Smtp-Source: ACHHUZ7C0QEDL4cPIgHWK1aDPYrfPPSbwglETaUMvNICAem5fOad5UfLe1VYL+QXPm4fDG2CUFZxzQ==
X-Received: by 2002:ad4:5baa:0:b0:623:8214:14c8 with SMTP id 10-20020ad45baa000000b00623821414c8mr13668868qvq.51.1685730851980;
        Fri, 02 Jun 2023 11:34:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfc0b000000b0062618fe128esm1131190qvo.56.2023.06.02.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 11:34:11 -0700 (PDT)
Date:   Fri, 2 Jun 2023 14:34:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: multiple zpool support
Message-ID: <20230602183410.GB215355@cmpxchg.org>
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org>
 <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org>
 <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 09:59:20AM -0700, Yosry Ahmed wrote:
> On Fri, Jun 2, 2023 at 9:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Again, what about the zswap_tree.lock and swap_info_struct.lock?
> > They're the same scope unless you use multiple swap files. Would it
> > make sense to tie pools to trees, so that using multiple swapfiles for
> > concurrency purposes also implies this optimization?
> 
> Yeah, using multiple swapfiles helps with those locks, but it doesn't
> help with the zpool lock.
> 
> I am reluctant to take this path because I am trying to get rid of
> zswap's dependency on swapfiles to begin with, and have it act as its
> own standalone swapping backend. If I am successful, then having one
> zpool per zswap_tree is just a temporary fix.

What about making the pools per-cpu?

This would scale nicely with the machine size. And we commonly deal
with for_each_cpu() loops and per-cpu data structures, so have good
developer intuition about what's reasonable to squeeze into those.

It would eliminate the lock contention, for everybody, right away, and
without asking questions.

It would open the door to all kinds of locking optimizations on top.
