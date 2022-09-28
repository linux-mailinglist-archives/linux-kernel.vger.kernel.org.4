Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB15ED454
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiI1FtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI1FtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:49:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46364106A3A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:49:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w20so10893460ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KTIrhAnCo7Q8nBsj9dKt8KXzxa7ebHjNhFw7IocgNC0=;
        b=iCHf+be3FtlT33TDk1Et/B/ZefVpMlI2VNofVOlyS5BGBvsXRrfYHxNkfRrT3nUkmT
         kq1YNXVP1sdW4u1ehTVVYql9vzl/7bp9D/WrfPFyHZQRZtlXcKAjxvpsJhVzmjndU8AP
         yoRAcTYmIgRwonvHV4ibixDUOgeCHXuHugLdJXrjvfmrHyrKsgsbhDsZpV56Kf/NUEMw
         o0eJ18A6D5+qNBC11knWhW7C60lzX5HUcHub+RGZM7+wq57vyQi4mPM19GlEcQo+9Bq0
         ic3ndpkDHwA7RpRfuWUmjt4kFRZ3W+UZ4+EnszHJw2mmDO6+XNh/J6cE5MrY1di/FfUl
         Tk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KTIrhAnCo7Q8nBsj9dKt8KXzxa7ebHjNhFw7IocgNC0=;
        b=NA1297m7MYdDPqHpcggnJn2td1yIIJlOYZK7EPPFaCLcPXhJtkVp5iNxsRPmvudt0G
         FNYfwmkux99ktwMR2nqmIvggR0CdKIWYBrBVeNuLRagv1XS1U+/lpbuI9Ioa2A6HVen5
         7DOyA/ecZAbk3bxDGAzOWgqdKXcX557wPzWZxIqqjM9IQvJYJKIGs6GxwBblR3wIaZG+
         9m52FaCeRX6AOfTle9fGcIahjxjYw7kIQHRTscUN/XGtd96b75gb6eT2Ucxlf7FJY25A
         3SjaHfUmVro+2hMhllfokDUSJ4ybempnkG4SBKpmjmd8sL/+wporZ5bQiMaX1/V4iBzL
         G3/g==
X-Gm-Message-State: ACrzQf0UNlM9aEw+qCociBIh07c5doknb3lPW4JPSdWamf3wK8XoJK2H
        xQy5DR+R60uMI0iMTrPUT98=
X-Google-Smtp-Source: AMsMyM4+FU/AHFYfnQDb1VzBw6Qffz6mEv1lxbPXq04zkQ43fApUIOfbAFjZbVWrRRa0picHWIW5tg==
X-Received: by 2002:a17:90b:4a89:b0:202:d56e:e202 with SMTP id lp9-20020a17090b4a8900b00202d56ee202mr8390750pjb.22.1664344149718;
        Tue, 27 Sep 2022 22:49:09 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id y8-20020aa79ae8000000b005364e0ec330sm2831387pfp.59.2022.09.27.22.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:49:08 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:49:02 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzPgTtFzpKEfwPbK@hyeyoo>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> It's a bug in linux-next, but taking me too long to identify which
> commit is "to blame", so let me throw it over to you without more
> delay: I think __PageMovable() now needs to check !PageSlab().
> 
> I had made a small experimental change somewhere, rebuilt and rebooted,
> was not surprised to crash once swapping and compaction came in,
> but was surprised to find the crash in isolate_movable_page(),
> called by compaction's isolate_migratepages_block().
> 
> page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
> which expects struct movable_operations at page->mapping minus low bits.
> But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.
> 
> Over to you! Thanks,
> Hugh

Wow, didn't expect this.
Thank you for report!

That should be due to commit 65505d1f2338e7
("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
as now rcu_head can use some bits that shares with mapping.

Hmm IMO we have two choices...

1. simply drop the commit as it's only for debugging (RCU folks may not like [1])
2. make __PageMovable() to use true page flag, with approach [2])

[1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
[2] https://lore.kernel.org/linux-mm/20220919125708.276864-1-42.hyeyoo@gmail.com/

Thanks!

-- 
Thanks,
Hyeonggon
