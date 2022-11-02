Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C71615D19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiKBHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKBHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:46:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159225C78
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:46:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so15814324plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUw9xWmpIf0XS62mp9HMnjP0huIdNjfhlXFV3m0hYXU=;
        b=ALwiQ3aIbPe1VylTTzdBSb36+7VaoGpR40jzyMrSs+dWBsj61OkBBotNGw2KFClzWu
         eZVG4iT1Q1ikdYQsG49wDAR4YH0KvxRWkGTmqQ4yGn9PLXpewid9khtyHRLkXn1Ybm7n
         ueoe569BEuZBjz6JqPqYqEfyBLAvNQ7ZAJZY0As9oUivEw2rMva0ZaPLBwZMAr+eKU59
         3Dq+DNeefM6yXYdvpIsP3lwVZ3p2ZOxtS7M0sqigJ+LrwS7uxH/YNUVaEOzcq6MeTXSa
         tvHMc7zW4WBaq/5dDyKeba+6Wb/EzIvNbAk0GfNLYfUnFUD5B4VPyIbRRUvc8OGEww7J
         5I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUw9xWmpIf0XS62mp9HMnjP0huIdNjfhlXFV3m0hYXU=;
        b=QHVYdBqjFjAutMCEo0pg3JiCSKg5BlvPXrA/7OyzDWLKactYtkRlqqgMZ2O2EyM2OC
         2i9V1aQybVdDdbJ9nX24IA16p3GLbRLXGErLuaMn+ZlPiLFIOuQDYK2T5gVwzJOuMWgH
         ODvPVaCAsN1M+P6V2TuXBUTYvCDrOutA2BIEPSsDBoTX0TXg+2+hfnQ5MP7l6rcKovxL
         xHz1RIwnjtN18ccW8e9wKY3M5rcfVq0MnE/VBbTeVlXk+jmIVD9x6WoEtB1wDXpgsn8D
         o3muYD8hSWajyftWaxg2c1h1Z0JDmU6BygfyFJpbHxEaqPWwJJ98x9lWOU9WziNHaFn4
         cnVw==
X-Gm-Message-State: ACrzQf1idR6GuICWR4/yVTEf8xGUf2npdIP8iLofCfaBh5/23wZqRYTb
        xp1WDsB9d8leAYk2T3VNiuk=
X-Google-Smtp-Source: AMsMyM5g0umuJwKDdnxNghIjoT8k4b5z28vu7fFz2BeFZE9cAw7CylIrWGBIXzYsDsHIP5BIUQkS5w==
X-Received: by 2002:a17:90a:f0d1:b0:213:473e:6ff0 with SMTP id fa17-20020a17090af0d100b00213473e6ff0mr23905780pjb.87.1667375193476;
        Wed, 02 Nov 2022 00:46:33 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b00186985198a4sm7631816plh.169.2022.11.02.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:46:32 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:46:27 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Refactor __kmem_cache_create() and fix memory leak
Message-ID: <Y2IgUwTH/dO06Tot@hyeyoo>
References: <20221031134747.3049593-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031134747.3049593-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:47:44PM +0800, Liu Shixin wrote:
> I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
> by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
> Following the rules stated in the comment for kobject_init_and_add():

Thank you for reporting this! Indeed it seems tried to fix double free but
introduced a leak.

>  If this function returns an error, kobject_put() must be called to
>  properly clean up the memory associated with the object.
> 
> We should use kobject_put() to free kobject.

But what to do if a cache is created early and later sysfs_slab_add() failed?
(Which is unlikely on normal condition)

With this series it introduces use-after-free if sysfs_slab_add() in
slab_sysfs_init() failed.  Should we just call BUG() or something like that?

> But we can't simply add kobject_put() since it will free kmem_cache too.
> If we use kobject_put(), we need to skip other release functions.
> 
> In this series, We refactor the code to separate sysfs_slab_add() and
> debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
> to free kobject in sysfs_slab_add(). This can fix the memory leak of
> kobject->name.
> 
> v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
> 
> Liu Shixin (3):
>   mm/slab_common: Move cache_name to create_cache()
>   mm/slub: Refactor __kmem_cache_create()
>   mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
> 
>  include/linux/slub_def.h | 11 +++++++++
>  mm/slab_common.c         | 44 ++++++++++++++++++----------------
>  mm/slub.c                | 52 ++++++++++------------------------------
>  3 files changed, 48 insertions(+), 59 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
