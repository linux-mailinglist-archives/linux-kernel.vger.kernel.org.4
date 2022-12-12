Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D751649F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiLLNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiLLNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:11:28 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574BA6434
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:11:16 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3bf4ade3364so144857587b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtZ2FMA0O4uYUm7aQmSU8L+LI/VWAtJ0XYx+JdwdYTc=;
        b=bnM1/R4J1Rv3B22x4pyyX7Sr+iGQtYWBpJxAZKZHbdRr8rMOoqj5BHaBlBm1ZOFc3g
         rMWE6zp4YfzFuql0n9zxVisIeZ+54UdblGgF0hN4VGbJCUXNCIjTC0Jj4kJ5a06QF3PI
         cqDWaD9DRPDDM5JKgOcwEB3tz0w4ODmDYSX8MxEo5bN6F/Ai4wKZRtiTe1yhOhduJVGg
         sWE5PV0fl4kPt7WbwAMFmlKcS5UKrapGk+9H7d8YMUDJUFF4kE1oepIpMc9IeVVEkFgW
         GO5K789v6/dIEg1Q7vWhvpRKWtiPwybXjGk5qOimxFP5Erng0ly+MQD5rhs/znx+aQJt
         9T+w==
X-Gm-Message-State: ANoB5pnFFwq7gsOBzAbkW+/hwz8xzizMK8++mLeVZaUsLUh0PNTPrx7k
        vWTe1tufxHE4RPyhH02CjA0=
X-Google-Smtp-Source: AA0mqf7+Aixqg4qs18bRCQtwCQMbbfyLdDkUgVLDofTIN7Vq8afs+p552ohMQrOoGgYEsUcaaw5YyQ==
X-Received: by 2002:a05:7508:3a85:b0:47:39b7:aeb8 with SMTP id de5-20020a0575083a8500b0004739b7aeb8mr1124297gbb.10.1670850675322;
        Mon, 12 Dec 2022 05:11:15 -0800 (PST)
Received: from fedora ([216.211.255.155])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a280900b006ff8a122a1asm3626860qkp.78.2022.12.12.05.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:11:13 -0800 (PST)
Date:   Mon, 12 Dec 2022 05:11:11 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, Baoquan He <bhe@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
Message-ID: <Y5cob2jicdNoviU3@fedora>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-11-vbabka@suse.cz>
 <Y4NEkF8DI1uXFRv4@hyeyoo>
 <f318ccc3-eb03-e359-cb6f-157d0b4aed31@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f318ccc3-eb03-e359-cb6f-157d0b4aed31@suse.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 11:54:28AM +0100, Vlastimil Babka wrote:
> On 11/27/22 12:05, Hyeonggon Yoo wrote:
> > On Mon, Nov 21, 2022 at 06:12:00PM +0100, Vlastimil Babka wrote:
> >> SLUB gets most of its scalability by percpu slabs. However for
> >> CONFIG_SLUB_TINY the goal is minimal memory overhead, not scalability.
> >> Thus, #ifdef out the whole kmem_cache_cpu percpu structure and
> >> associated code. Additionally to the slab page savings, this reduces
> >> percpu allocator usage, and code size.
> > 
> > [+Cc Dennis]
> 
> +To: Baoquan also.
> 
> > Wondering if we can reduce (or zero) early reservation of percpu area
> > when #if !defined(CONFIG_SLUB) || defined(CONFIG_SLUB_TINY)?
> 
> Good point. I've sent a PR as it was [1], but (if merged) we can still
> improve that during RC series, if it means more memory saved thanks to less
> percpu usage with CONFIG_SLUB_TINY.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/tag/?h=slab-for-6.2-rc1

The early reservation area not used at boot is then used to serve normal
percpu allocations. Percpu allocates additional chunks based on a free
page float count and is backed page by page, not all at once. I get
slabs is the main motivator of early reservation, but if there are other
users of percpu, then shrinking the early reservation area is a bit
moot.

Thanks,
Dennis

> 
> >> This change builds on recent commit c7323a5ad078 ("mm/slub: restrict
> >> sysfs validation to debug caches and make it safe"), as caches with
> >> enabled debugging also avoid percpu slabs and all allocations and
> >> freeing ends up working with the partial list. With a bit more
> >> refactoring by the preceding patches, use the same code paths with
> >> CONFIG_SLUB_TINY.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> 
