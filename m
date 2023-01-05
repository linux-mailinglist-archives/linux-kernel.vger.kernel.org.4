Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9731765E292
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAEBmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjAEBmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:42:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4E2F7AF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:42:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c9so19403287pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUrfx5rymV6PAvjGCkeIctTq/mmMCexOy9WfgvwN1Yg=;
        b=gtIa7MIVyvGMax/CEKEhY/D/ZiZmkvm0uNj297J+blrWhmKvjxfJHG5Z9jXEgIskts
         vz5mkXbYrV0lJmBZyLTFXFwiy2ejJ/J5kDvGMOUWFX1/5Qe7AlBMf1APcdunfrDmOEg4
         qHXsClzZuMiG0/tLMAdJ/P9truPq8u9PHcMNNfZlj2VfUmP031eOYYftEy66RZs1Kgy3
         Jhmobu5DaESqXDtE0MBS35YlBisuDInr8UYg4CQVnPppDXtRcoDoDwYs95jkyROk/ck1
         DhixM7ZZmxeNrr81wZCxSjmH0mkBiZMFmQBa8EEObfKklE5YByuPDr6Hh1f9luh8a4d1
         3KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUrfx5rymV6PAvjGCkeIctTq/mmMCexOy9WfgvwN1Yg=;
        b=mgMSQRVmfPJmEjvt5u9X2vhiSJCvCaj3r1U8rGNiRjRQLF8K5GQMd/7IcaACFAGCW+
         09FsRTawxqhuH1d5G8i/VJFMk+4rGTp9JrTrbc0Xbjf4xjC57Eku8FEUdtpWic9OC51H
         xsBcDFLy/bGuY95fQBm9SLX0S5u9x0yNnDnYffwX6Dla4ySAR041Keje+p8qiLvDtacQ
         WwK4UdQqiSdQP5tdCNriAHt1l1NxjRF6q8YNsooHXjDbvR4DHW65KrPHFNiAzcH8Qd+3
         /sm2eZQTWWS1KFlk7OAUjSsDPJgyM16BdQJRNsgEV4+6+psdETYl2ssc7nA1WeUfzCK9
         BRMA==
X-Gm-Message-State: AFqh2kpD4inSAqmpcV1QseCDqZW9GHe8aAgtJ2ECA9KNTeycxtUBo01c
        8lDNEZFyskFrn1+7CjHfILLhkQ==
X-Google-Smtp-Source: AMrXdXuvgTarXCqrA23rBkL31VEvzXqUxRYkMRYM1V7m9460cS0WvKQF9e6nBxAyfny75qm+ijKFKg==
X-Received: by 2002:a62:e413:0:b0:582:13b5:d735 with SMTP id r19-20020a62e413000000b0058213b5d735mr62623pfh.0.1672882931539;
        Wed, 04 Jan 2023 17:42:11 -0800 (PST)
Received: from [2620:15c:29:203:fc97:724c:15bb:25c7] ([2620:15c:29:203:fc97:724c:15bb:25c7])
        by smtp.gmail.com with ESMTPSA id p5-20020a622905000000b005749f5d9d07sm23726355pfp.99.2023.01.04.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:42:10 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:42:10 -0800 (PST)
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
Subject: Re: [Patch v3 -mm 2/2] mm/kasan: simplify and refine kasan_cache
 code
In-Reply-To: <20230104060605.930910-2-feng.tang@intel.com>
Message-ID: <b0d265fb-1b0a-902a-c23f-176b29792b37@google.com>
References: <20230104060605.930910-1-feng.tang@intel.com> <20230104060605.930910-2-feng.tang@intel.com>
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

> struct 'kasan_cache' has a member 'is_kmalloc' indicating whether
> its host kmem_cache is a kmalloc cache. With newly introduced
> is_kmalloc_cache() helper, 'is_kmalloc' and its related function can
> be replaced and removed.
> 
> Also 'kasan_cache' is only needed by KASAN generic mode, and not by
> SW/HW tag modes, so refine its protection macro accordingly, suggested
> by Andrey Konoval.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
