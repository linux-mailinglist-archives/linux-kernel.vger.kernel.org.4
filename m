Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DA6E57B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDRDFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDRDFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:05:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B030E8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:05:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a66911f5faso11920455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681787148; x=1684379148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOJuZ4mIPzt5F0DJllOV4ZkHX5DeqvTCiU6JGDixwwQ=;
        b=eBXlVh5peYX73LusmM4JjASgjEcrYjgy5dKc/k9GHFgBzHwO9ZJjAQqpwb9iWc0igu
         YhUY3ZArQAGcg8vjPGKt/NR1ZpSbb0/RndHZFwDGEz4GiPa7e/5jjUZxZyOhAqFRk+xs
         kqinRj4JAQ2UsZuy1rEXL8Q5gNrTZlH1AIjZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681787148; x=1684379148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOJuZ4mIPzt5F0DJllOV4ZkHX5DeqvTCiU6JGDixwwQ=;
        b=UPttWPIdQHHbuADdN6FTuRGxVuBN3Jk07lZxi+8H1lKws2JCRVF6rsAKamE4sXMLIL
         eaELsP28G3fhIc7asYUxDilTsL3lplsvGK7x529ip4V9VaFNIi/7UBffevmV5KpdNBIe
         FPSKFdeE7koZ67jy4y304VamKANe3f134pN4Kmk+lvaugeu0/ixrWyBElPrJk6cEaG3A
         XNe03xIjkOrNo+rwFdyQCxTw697xKgKwscYIJ7iCrJg3ouoGKAx3ruiQmFWWnHCA6FqV
         x0rNSa+cfg5qMZ9rnKET/oABixFD18WHocKF9EN+pGF4NSzlHG3H2EHntww+S79CNBOa
         nREQ==
X-Gm-Message-State: AAQBX9fv5RujibWb0kKkTzEEvCOWeuxRWga9tHJ2rQOJ/cAbSW1Eellm
        9vgYH6qKJdblKUvv6fgfiwL/FQ==
X-Google-Smtp-Source: AKy350bHk3PY5dWCECEECusc5D+Fv4G9g4VDR/o4nC6ceUaXcOblYSMAODNymspLQvMLfoS2fwoXZQ==
X-Received: by 2002:a17:903:11c4:b0:1a5:180d:c317 with SMTP id q4-20020a17090311c400b001a5180dc317mr762782plh.43.1681787148317;
        Mon, 17 Apr 2023 20:05:48 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm8383003plt.44.2023.04.17.20.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 20:05:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 12:05:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
Message-ID: <20230418030544.GS25053@google.com>
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
 <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/17 17:41), Andrew Morton wrote:
> On Mon, 17 Apr 2023 22:54:20 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > Introduce pool compaction mutex and permit only one compaction
> > context at a time. This reduces overall pool->lock contention.
> 
> That isn't what the patch does!  Perhaps an earlier version used a mutex?

Oh, yes.

[..]
> > @@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
> >  	struct size_class *class;
> >  	unsigned long pages_freed = 0;
> >  
> > +	if (atomic_xchg(&pool->compaction_in_progress, 1))
> > +		return 0;
> > +
> 
> A code comment might be appropriate here.

OK.

> Is the spin_is_contended() test in __zs_compact() still relevant?

I'd say yes, pool->lock is "big pool lock", we use it for everything:
zs_map_object() when we read objects, zs_malloc() when we allocate objects,
zs_free() when we free objects, etc.

> And....  single-threading the operation seems a pretty sad way of
> addressing a contention issue.  zs_compact() is fairly computationally
> expensive - surely a large machine would like to be able to
> concurrently run many instances of zs_compact()?

Compaction is effective only when zspool suffers from internal fragmentation.
Concurrent compaction threads iterate size classes in the same order and are
likely to compete for pool->lock to just find out that previous pool->lock
owner has compacted the class already and there isn't much left to do.

As of concurrent compaction on big machines, the thing is - concurrent
compaction doesn't really happen. We always have just one thread compacting
size classes under pool->lock, the remaining compaction threads just spin on
pool->lock. I believe it used to be slightly different in the past when we
had per size-class lock instead of "global" pool->lock. Commit c0547d0b6a4b
("zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks") has
basically made compaction single-threaded.
