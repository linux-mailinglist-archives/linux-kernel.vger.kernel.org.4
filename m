Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E265E28F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAEBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:41:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B42F795
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:41:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so540342pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGDoBgnyiYUBevy+lcv+gZmYeTZ3heicEZ82qgGjf80=;
        b=mNT9PCRmSK5R/h9+uKGj5dxdTVAGdqmjsR1kJT78IdrV/ydEvB5Ik4OOaTbvoi5Rb7
         IHVTgm9vRrkRmwDv6/YmzLN0vnubKKuiKPN2k+XXjZlxf7D8qyFWvErd6BaYZ5DIGj6q
         FKWSHC2r1h3KahIgH4uIHGH6evbbVqAsSD7nIFs25WUDIP3/YuyL739B6f6n5GAEvRGm
         SAUBb1g2O5rf/x2q2beHW5bL/AZ+u832EhD40RIUcSEh3FKiDxiGJYa7v6UASuSINkCQ
         SDPcKxlpDDPGcpW93uOaWaH1asr9Dr/ZTiJpUAEpowyNPk0eYSOrK5dLzLcsm1Q4FnEu
         ziRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGDoBgnyiYUBevy+lcv+gZmYeTZ3heicEZ82qgGjf80=;
        b=Q4M6A7ktWh3EMjbqjfw+Oi4++H85lVXCY3jVwjrX5l+tCgA8TJddoECwPX/rSxtpb2
         uDH1YWRmAXzTyyPoyZXFTVrQdw6s+HRssoHe6DuxKDZUTuLzVuZ4RLHbRWzlI3RSuT1i
         skNkpYA7eccf3Ek3kRZbFwrBfXE3CdocT4VCBl8YLx+VoRxSjXhNNAMnNuT5wdXbs8vs
         s8V92Fta3rD1+GgqEN33BG2lXe3Xq2WwsjTg6K/IXcSp3VPSRVPl47qCUVyWFfiXEaI4
         8GZRuv69I/x9FS2lG/ylBPE6zfZ0PkNOwbhEcVTjRHwcn726H3XnU7bHVtyn56LLZivF
         NnUw==
X-Gm-Message-State: AFqh2kpAKtvlDHEmoYy9AsUip+4kQF3q85MabhVL6pModNxQlzKNzKkQ
        VbbFEbCGMu+5oqz3rvsuX/2b8w==
X-Google-Smtp-Source: AMrXdXt5W2cZGp/t+4vYOQ7mktqc3l2RVi2Iv7IKNxYpD7fD1n/Pp0Uqe5/XeWjpznoLZYxswl4rXw==
X-Received: by 2002:a17:90a:c903:b0:219:f970:5119 with SMTP id v3-20020a17090ac90300b00219f9705119mr45423pjt.1.1672882912921;
        Wed, 04 Jan 2023 17:41:52 -0800 (PST)
Received: from [2620:15c:29:203:fc97:724c:15bb:25c7] ([2620:15c:29:203:fc97:724c:15bb:25c7])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b00183c67844aesm7454159plg.22.2023.01.04.17.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:41:51 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:41:50 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Feng Tang <feng.tang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 -mm 1/2] mm/slab: add is_kmalloc_cache() helper
 function
In-Reply-To: <20230104060605.930910-1-feng.tang@intel.com>
Message-ID: <8d8a3e03-d019-df20-9525-ea4b4043540f@google.com>
References: <20230104060605.930910-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023, Feng Tang wrote:

> commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
> kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
> kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
> dedicated kmalloc caches).
> 
> Add a helper inline function for other components like kasan to
> simplify code.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
