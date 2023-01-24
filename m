Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00F167920F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjAXHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjAXHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:34:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66250360B0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:34:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lp10so10560342pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DHkmWBhytipLZt74n7gOq2YE5+gKWvx1oE4IKr1YKM=;
        b=XnAv9pbknaf+wHIv7LivSusgOHbiMMHeUT0rGmYnz1KFe6yh2ONtwzlthUDMJM7aEG
         ItCw8Dxrb19u8HgwerZ1R3fXMliP2gTP8A+np8gpuKGZf3lUD1fuYHTOlnmYDjyvvKTE
         hMEJ12B5hOWMrHftl/4buXzT5dQVVnj1JIvxrA2pIAkq7OcgUe03e4NF/fuosdO2jiJT
         4xIndDHdSKl9w7Ff3eSfsLYBiss8xe9xvVKrcWXO9PN6PMqy0zIaXvjo1j+GI/2EBLYs
         Ts/zY1Mh4VJc2iTWeTLOCMzYF5qi0Z8GhEu9ajb7ZO1TWZ/Y0LDz7wuKjoExlXol73ky
         rvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DHkmWBhytipLZt74n7gOq2YE5+gKWvx1oE4IKr1YKM=;
        b=oj9L4rz69cF6PstnhsHjwWRv4rZ7CB3+azrQRqQ7YWzHiPVeeO4lcoMe1O82ih4LB7
         HhRghonglZ4Bn1CqbUW7tPg1uRQIl8fzYwsWVW+VozFiTrXiGvIFHAZAAERCxSFsWWU0
         Tbn/mVt/lfJnLwfbSbhY5KUABlOKFo24I0Yu8oF3l0R99H5WkXx+FTVUDpXkf6jZ8nhq
         Ece3BdTvNAEEJtK1HRqwjaRuGBZH6R7KBCVqfmu1VHQJaZE7zGnss3Mbqr443+gbt312
         slZYkWCEr4dPvsYDxahnCoMz+8f/DQNQ+zXdR8yG3PQT+Qv+CjtROd1/Unc4PQ2eDyRD
         EMhA==
X-Gm-Message-State: AFqh2krLbSm3FwxY3bJ117VkNLNyZlmKjKzKl+HQ7Vd8FH+jpsbNTqW7
        grRa5G2U2IF7fVB+T2970Pg=
X-Google-Smtp-Source: AMrXdXsU9irGf2tcLowt038y9Pbyaiy3Xq7pwWoBxc7ojm/ZL7Sr8tjAPOxhpxkeJlD49DbBwtOG/g==
X-Received: by 2002:a17:902:cad3:b0:194:7abf:742b with SMTP id y19-20020a170902cad300b001947abf742bmr23803909pld.47.1674545679856;
        Mon, 23 Jan 2023 23:34:39 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902b21100b00186f0f59c85sm916965plr.235.2023.01.23.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:34:37 -0800 (PST)
Date:   Wed, 25 Jan 2023 01:34:23 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <Y9AIj5OLmPAH8cXF@hyeyoo>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
 <Y8vSZ+gOFXWDKC8Z@hyeyoo>
 <d23a77b8-e9dd-9fc3-4311-4597e310e7a8@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23a77b8-e9dd-9fc3-4311-4597e310e7a8@gentwo.de>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:05:00PM +0100, Christoph Lameter wrote:
> On Sat, 21 Jan 2023, Hyeonggon Yoo wrote:
> 
> > Whew, I still get confused about who to Cc, thanks for adding them.
> > and I also didn't include the percpu memory allocator maintainers, who may
> > have opinion. let's add them too.
> 
> Well looks ok to me.

Thanks for looking at!

> However, I thought most distro kernels disable PREEMPT anyways for
> performance reasons? So DEBUG_PREEMPT should be off as well. I guess that
> is why this has not been an issue so far.

It depends on PREEMPTION, and PREEMPT_DYNAMIC ("Preemption behaviour defined on boot")
selects PREEMPTION even if I end up using PREEMPT_VOLUNTARY.

Not so many distros use DEBUG_PREEMPT, but I am occationally hit by this
because debian and fedora enabled it :)
