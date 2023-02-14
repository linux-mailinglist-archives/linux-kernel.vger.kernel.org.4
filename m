Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76838695CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBNIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBNIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:31:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38356AD1A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:31:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B30BD336B8;
        Tue, 14 Feb 2023 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676363492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA7VF9zg98MXho4gucCPM2gEisZygGvmQmXCbTESl2A=;
        b=LaLBveM8vNL7Zh+CPiPZh7amtYKo04GzYyXROb79ZaqlAOVJtXfC1l2ZuwdBEl7qlXgQJN
        h+IJ8LCPJtexw4SGiu3AyuC7uIelWUIPFgAOq8J1IbjCc2tWS4eRdLyhFUQ/eE7pPZz2ep
        EChxdkqNj9aKwjt/DJcsK/23wvPVTx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2C93138E3;
        Tue, 14 Feb 2023 08:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ikrpJuRG62OaKwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Feb 2023 08:31:32 +0000
Date:   Tue, 14 Feb 2023 09:31:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: rename memcg_kmem_enabled()
Message-ID: <Y+tG5NopD5DTZSSh@dhcp22.suse.cz>
References: <20230213192922.1146370-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213192922.1146370-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-02-23 11:29:22, Roman Gushchin wrote:
> Currently there are two kmem-related helper functions with a confusing
> semantics: memcg_kmem_enabled() and mem_cgroup_kmem_disabled().
> 
> The problem is that an obvious expectation
> memcg_kmem_enabled() == !mem_cgroup_kmem_disabled(),
> can be false.
> 
> mem_cgroup_kmem_disabled() is similar to mem_cgroup_disabled(): it
> returns true only if CONFIG_MEMCG_KMEM is not set or the kmem
> accounting is disabled using a boot time kernel option
> "cgroup.memory=nokmem". It never changes the value dynamically.
> 
> memcg_kmem_enabled() is different: it always returns false until
> the first non-root memory cgroup will get online (assuming the kernel
> memory accounting is enabled). It's goal is to improve the performance
> on systems without the cgroupfs mounted/memory controller enabled or
> on the systems with only the root memory cgroup.
> 
> To make things more obvious and avoid potential bugs, let's rename
> memcg_kmem_enabled() to memcg_kmem_online().
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-mm@kvack.org

Makes sense
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

-- 
Michal Hocko
SUSE Labs
