Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E93622F63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKIPxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:53:46 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E886E0A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:53:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ml12so12573196qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sk2rRztWdJEYKEIMTq5A+Go4tOahbOq/6iV58v2FweA=;
        b=T+N+TL4RWsLhyuBSFtNrfgXKzUzVxDn6urT2Vlc2kkdGVPRzCfvFzEeWrIm6V+dlHt
         KOFeR0bRP75lWMjIKUVbMohw+OImYxCZ3Y4DMrPzPU76FwhFQoClQUiZZ4/wi8l6yGz6
         OvMy0I7n2Z/PMVyzqILHLM+e4IcFnlPG3XwchiOoxD4V15joIbbCZSIlQTxkTdcABKzI
         8+r/KJfbjuCK1q4mpLEZyXeph+FPyVJztyiczmZBcI7OU1AqqhKEKvG6rw5LFFNBZj1g
         7SA2+SBFTCSsPqayJZkcSTyBPg2wdxLtwlrSCdLQxfI/zElX3iKwww5481ZtCVEQEU1/
         xiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk2rRztWdJEYKEIMTq5A+Go4tOahbOq/6iV58v2FweA=;
        b=aQ44DbPCj+tDdnCqVxzv1muRGoslZw69uYOEMoXO3HWa/jkLTXNJDA74cvyB6CFesy
         Iss5hlK0wKUKpRlD9aeWGn0AYsS4tYZ5+SzAB6dQcEysX8/SsqrP58/lwcz/IIvrzbsK
         gpBEZ/Au6PJ22tBqCl2pFQgs+7/Wv917qcJloHeEv43xpEz9hxaxhntH0NmjqdcMg6ZR
         /b/UdTojToMbAPNa1nRaCkVNhrfvlvuv0IgMsQgRC3pfHgDY2GE7R1pGbMTI6TfAo+Jg
         m5vuHssFxfR0dBP7YB++EhpF4hA42RbQyJS0+8uYNnR/oDPY6Fk2+QTcxVRLdLjLaS3N
         Ywpw==
X-Gm-Message-State: ACrzQf1w8A3uLCm0FjmHEQiCBLXlG6nmQVH511tqFbyVMt69lQfvU4Yk
        BgHzFwjePmkC+WNhfrPr2K02/w==
X-Google-Smtp-Source: AMsMyM6hLe/bWjTqpZ703+C5WeszH/T+nBegFkICCNxyXoFrJeAnSB8JYRQ+ZfGcz6od8FqccV6+xg==
X-Received: by 2002:a05:6214:da7:b0:4bb:d8a2:cc2f with SMTP id h7-20020a0562140da700b004bbd8a2cc2fmr52846832qvh.119.1668009189021;
        Wed, 09 Nov 2022 07:53:09 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-3663-3884-f85a-44bb.res6.spectrum.com. [2603:7000:c01:2716:3663:3884:f85a:44bb])
        by smtp.gmail.com with ESMTPSA id u127-20020a379285000000b006faeecef56fsm5629435qkd.68.2022.11.09.07.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:53:08 -0800 (PST)
Date:   Wed, 9 Nov 2022 10:53:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has
 been flushed
Message-ID: <Y2vM6FFQX5GlOyBs@cmpxchg.org>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-4-torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108194139.57604-4-torvalds@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 4 patches look good to me from an MM and cgroup point of view.

And with the pte still locked over rmap, we can continue with the
removal of the cgroup-specific locking and rely on native MM
synchronization, which is great as well.

Thanks,
Johannes
