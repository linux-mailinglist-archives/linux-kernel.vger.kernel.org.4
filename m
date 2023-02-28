Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7D6A5EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjB1SlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1SlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:41:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A8C15B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:40:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 548CF1FDE0;
        Tue, 28 Feb 2023 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677609658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQm+5CRB4MooQZ5+WKEamIY+UtdzzUtqSxH+oRSqz8Y=;
        b=O50oe4UAkLYQX5YY88oax1/6TVpNXyIvQARg44ilqYskgYEPv3IFa3xWxm46BlXv2fTg5X
        Mtg2K8SFs/p5XYiG6MW9KaNW83m/zJoozvw1FVVo/4nZoYS9IRbyH/NVNr3rULeNDxfwUm
        SXvaOoQkbrILwE6GAX5t3H14Q61E8fc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 321811333C;
        Tue, 28 Feb 2023 18:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9t6NCbpK/mNsWQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 28 Feb 2023 18:40:58 +0000
Date:   Tue, 28 Feb 2023 19:40:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, tkhai@ya.ru,
        hannes@cmpxchg.org, shakeelb@google.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Message-ID: <Y/5KuUymvxn+QhIz@dhcp22.suse.cz>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/zHbhxnQ2YsP+wX@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-02-23 17:08:30, Mike Rapoport wrote:
[...]
> The results you present do show improvement in IPC for an artificial test
> script. But more interesting would be to see how a real world workloads
> benefit from your changes.

It's been quite some time ago (2018ish) when we have seen bug report
where mount got stalled when racing with memory reclaim. This was
nasty because the said mount was a part of login chain and users simply
had to wait for a long time to get loged in in that particular
deployment.

The mount was blocked on a shrinker registration and the reclaim was
stalled in a slab shrinker IIRC. I do not remember all the details but
the underlying problem was that a shrinker callback took a long time
because there were too many objects to scan or it had to sync with other
fs operation. I believe we ended up using Minchan's break out from slab
shrinking if the shrinker semaphore was contended and that helped to
some degree but there were still some corner cases where a single slab
shrinker could take a noticeable amount of time.

In general using a "big" lock like shrinker_rwsem from the reclaim and
potentially block many unrelated subsystems that just want to register
or unregister shrinkers is a potential source of hard to predict
problems. So this is a very welcome change.
-- 
Michal Hocko
SUSE Labs
