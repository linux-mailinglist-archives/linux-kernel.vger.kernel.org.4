Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA27416A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF1QpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:45:11 -0400
Received: from out-33.mta0.migadu.com ([91.218.175.33]:31749 "EHLO
        out-33.mta0.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF1QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:45:09 -0400
Date:   Wed, 28 Jun 2023 09:44:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687970708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=be6Km9iULXCw10IaJhTWcFxq+2/V3fGhnk/J8/la0pk=;
        b=jqSGDyTe+WJU1j9J91rqQE8qyZB7PDS3relCxloVTnDWqQvqWWIoapbC/1f4TAgUA0pdCG
        +C/WsndvHQZU87/1RYoUa1ofvytnjRRQOLAjULzMD2enO531Gbvo/TZmv3CjpX+7MwXy/7
        I9lebYnkO7amCvVyPi/qUDvKYQvzNlo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Rientjes <rientjes@google.com>
Cc:     Julian Pidancet <julian.pidancet@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
Message-ID: <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
 <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:32:15PM -0700, David Rientjes wrote:
> On Tue, 27 Jun 2023, Julian Pidancet wrote:
> 
> > Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> > enabled. Benefits of slab merging is limited on systems that are not
> > memory constrained: the overhead is negligible and evidence of its
> > effect on cache hotness is hard to come by.
> > 
> 
> I don't have an objection to this, I think it makes sense.

+1

I believe the overhead was much larger when we had per-memcg slab caches,
but now it should be fairly small on most systems.

But I wonder if we need a new flag (SLAB_MERGE?) to explicitly force merging
on per-slab cache basis. I believe there are some cases when slab caches can
be created in noticeable numbers and in those cases the memory footprint might
be noticeable.

Thanks!
