Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262B5EC470
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiI0N3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiI0N2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:28:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA7638D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:23:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i17so2984719qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=vjjvifvRbyamwiKwXAGlU+rtv6BwVcIgFInlxUxWOFk=;
        b=Me2NuFx7YYw5/6VUYsnM6+enyki04bmQjGYAmmDKSrf5RtYBaK9xqhr2G7e1NqO0QF
         Ul827IrzQJQRfEOyZkgCsX2wki8XYKYL5cf9AzTRaaapKaLlle+822jZUhlylP3lvpFO
         UzIDaN64+l2wrTV3kGjAhxlCc5+oL3qZq2hKSlJPIpr5pmyESjbis/n61/yAxqrx5wJe
         nBoHEvtvfn/inr7H2QrVltHXGms0vN5cgTjxAgUBCyKQ/QUm7FsmTSNJUwJhqi8aZIvu
         fYk0CsF+jffSBWIMmB3n81wwlP0GqE6NeVwKpmS/G7hpZxBC7g//LH0VSKKAmF+MH6yz
         nEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vjjvifvRbyamwiKwXAGlU+rtv6BwVcIgFInlxUxWOFk=;
        b=2dOhErJsOu7cGVdIV3ZFZ/DFiafJ1xVQ+UUOyVORIz8y4uz0Ie+EMCc3VV6OZILFtr
         ZA75qLbR2QQPSgnq2uVpigZX65ZKJT1uuuTlS78h6ajq+kXvNX8gcsyFQaqXMYTpA/eD
         Ww/0Wn75M9CRtuuAbki22DW2pub/BvKrUk0nv3FqmGO9W/N0SmxhnYZg3J2c/hC0yHxt
         rL7gfM7pPjl/1PyD3lP1qgwHSLis0A03abhMXp4XlreK+a8QLEmGYHo/3Aykoy/M5qbA
         FvVvdpJf49NNjctmuhJU4ZDNVzyt1DNXlP5DqwQ90+8KkNUsSDBUBPpUruuwTysRd9N8
         S9Cw==
X-Gm-Message-State: ACrzQf200YRZmMNW+YTQEQsLgybHdnKMTGPo41f7bIoIIUq+6pmFJC7R
        lF7hgi2HO/QAxJ3kkR2Q2VLcnw==
X-Google-Smtp-Source: AMsMyM65yqybhnl7GHNiayZJMKpPszKKQOL9Jzw6Xdn4Vy42enBAU5bETyNDytnE3YEGZgVI1i+Rvw==
X-Received: by 2002:a05:620a:1922:b0:6ce:fbfc:d19e with SMTP id bj34-20020a05620a192200b006cefbfcd19emr17944366qkb.22.1664284990061;
        Tue, 27 Sep 2022 06:23:10 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id f6-20020ac80146000000b0035a70a25651sm838545qtg.55.2022.09.27.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:23:09 -0700 (PDT)
Date:   Tue, 27 Sep 2022 09:23:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks
 allocations"
Message-ID: <YzL5PNgp/43a5N6K@cmpxchg.org>
References: <20220926195931.2497968-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:59:31PM +0000, Shakeel Butt wrote:
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
> 
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.
> 
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
