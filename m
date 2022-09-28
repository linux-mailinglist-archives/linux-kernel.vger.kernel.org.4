Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4E5EDFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiI1PJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiI1PJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:09:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3D9C2FC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:09:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2677355pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=45h6jBSLrKRgv8GqveYuR0XNqAwOaqvbHIMgSH3kRfc=;
        b=OWF2hHMYcL2y3Klh2IeJVHtIBJTrP2wcwuXoRK1g0n8xP2eCucKlBbgRujeIQtsuhI
         ftL9O1rd6ph/Ca94aGCNKl8I73e3svcFZFDhITk/8LZM8WleC9+zmszKjyUe68LmGTsC
         lvWwhYzXiQTcH7Am18CUTSTqF8G/O+moFsNzlS/ymy+y2ujzkVpMIHNzOwwkdnIDxdVr
         9AQdTUMOqgQjc1Lsz1wYYUDPtqV3PosuBGetl9s06CNz9wEuSJ9uDrNxvsIJw4RxMpQ0
         0D7Dl+mGXAv6lrvDU9fQodILq4kCQ3s8JI+bk57z3pFglxGH9IDHwjfKU40zNT5//mP3
         7brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=45h6jBSLrKRgv8GqveYuR0XNqAwOaqvbHIMgSH3kRfc=;
        b=qVS0xXGXk8YNHIE4Pqp6fmDJyNjH6cVdf0FHkCqZlZ0YZfnA+GpZubYX6zTa1kTPiM
         kc7uM9PL5yGYK2FGXWlezRlGddJZk5eU6mBt+I4LgQ0tY2EFAw5xTSg0fnYvr/dyXPhR
         K32o4pg1eoVHMGsEL9HJDElbtzf9XIuG+59Jmwawc/R9fh/qBqTUipLUmGcSQ5/XjNyp
         UdA4CrTDSM9YIlWrtMsx/cX6uRNqY5FKo1qq89o7WB5/rkyPRz6d+pPFaxLITA9eDOto
         Kmg9hLb1zDbVDRxoJt4qPRdY2gszvFa5AGHXGOkfrlUsfRWhCBXe5s7cMWIEjpVFWhuW
         5wqQ==
X-Gm-Message-State: ACrzQf2hJcRXj5nLYC4zz6hH0p58I7T2s2A0J/uCR4DiGgOzmpqidL81
        /0S1Qk/VjyL6VMOycXYUEuw=
X-Google-Smtp-Source: AMsMyM5KeEtk4K2u0R+xgn8vxplIG0zX+Xt0Kni9OYYb+MQGGGDnEtJvvONA3jsa2zADbiRg3AH4mQ==
X-Received: by 2002:a17:902:bd02:b0:178:1a1c:889 with SMTP id p2-20020a170902bd0200b001781a1c0889mr253524pls.107.1664377752359;
        Wed, 28 Sep 2022 08:09:12 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f12-20020aa7968c000000b0055a5a3bda9asm4015403pfk.109.2022.09.28.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:09:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 00:09:05 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzRjR8r/dzU17Sw2@hyeyoo>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRQvoVsnJzsauwb@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:48:46PM +0000, Joel Fernandes wrote:
> On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
> > On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
> > > It's a bug in linux-next, but taking me too long to identify which
> > > commit is "to blame", so let me throw it over to you without more
> > > delay: I think __PageMovable() now needs to check !PageSlab().
> > > 
> > > I had made a small experimental change somewhere, rebuilt and rebooted,
> > > was not surprised to crash once swapping and compaction came in,
> > > but was surprised to find the crash in isolate_movable_page(),
> > > called by compaction's isolate_migratepages_block().
> > > 
> > > page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
> > > which expects struct movable_operations at page->mapping minus low bits.
> > > But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
> > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.
> > > 
> > > Over to you! Thanks,
> > > Hugh
> > 
> > Wow, didn't expect this.
> > Thank you for report!
> > 
> > That should be due to commit 65505d1f2338e7
> > ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
> > as now rcu_head can use some bits that shares with mapping.
> > 
> > Hmm IMO we have two choices...
> > 
> > 1. simply drop the commit as it's only for debugging (RCU folks may not like [1])
> 
> Yeah definitely don't like this option as patches are out that depend on
> this (not yet merged though). :-)

Yeah, better to avoid that.

> > 2. make __PageMovable() to use true page flag, with approach [2])
> 
> What are the drawbacks of making it a true flag?

We don't have free bit in page flags unless we free one ;)

> thanks,
> 
>  - Joel
> > [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> > [2] https://lore.kernel.org/linux-mm/20220919125708.276864-1-42.hyeyoo@gmail.com/

-- 
Thanks,
Hyeonggon
