Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6067AED6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjAYJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjAYJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:51:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C713F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:51:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66B861FD8D;
        Wed, 25 Jan 2023 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674640266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U816CFZ7IbAXIFcz31360lzOFKeBJorvqLhGgrG4qJs=;
        b=Rp9qRKRrWOHbkPC+iFc8/9nFeJElSqqelF21Of0S68es+bJxymVtiP80jNYMMhwV7FztS3
        3aLCR6i339/wZnK9k+q2CeB6UAlGlbN/F8UbiBOv6Czuuw+DEezLxCYUZtTYHUlpeiVb5S
        qFIGqPiYrkKwsPdyvaZlRGNOPOY0Uig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CD981358F;
        Wed, 25 Jan 2023 09:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C3pyDor70GNIJwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 09:51:06 +0000
Date:   Wed, 25 Jan 2023 10:51:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y9D7iXUuLsOURfFv@dhcp22.suse.cz>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
 <Y8vSZ+gOFXWDKC8Z@hyeyoo>
 <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>
 <Y9FNm50H+w1B26yR@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FNm50H+w1B26yR@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-01-23 00:41:15, Hyeonggon Yoo wrote:
[...]
> > Do you happen to have any perf data collected during those runs? I
> > would be interested in the memcg side of things. Maybe we can do
> > something better there.
> 
> Yes, below is performance data I've collected.
> 
> 6.1.8-debug-preempt-dirty
> =========================
>   Overhead  Command       Shared Object     Symbol
> +    9.14%  hackbench        [kernel.vmlinux]  [k] check_preemption_disabled

Thanks! Could you just add callers that are showing in the profile for
this call please?
-- 
Michal Hocko
SUSE Labs
