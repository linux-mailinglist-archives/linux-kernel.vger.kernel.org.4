Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77515737E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFUJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFUJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:06:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB31CE4D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:06:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b53e1cd0ffso23835655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687338415; x=1689930415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K8HTIhkv++1Fsa2NTQSKbuaibYlj+ipl+Ced2oh/4BE=;
        b=cooEGTq01eez/kjEDOJuayOLBQZWnKWTa/EhoHmXV8T8lPgNAemspEULxzi9lxLzxo
         1RBL/tsTpGGO7+A/qTPx9P7tEbp/6VX2sllhLMSgf6RqlERi1lcZlN3CgEefMMloyLlE
         n4UVA9D/z6NAaIVWN8S0MSVuYnpBUhOnMdPqq3O5z9qI0OgKpL+bxbsNDOspnCeYy8Pz
         t8DXgHvUO3IlGat8t+T6JiEcDgSyhfcLjKMgQtfpg+e47U0hCokU8jmDDAuYb0nWKd1Z
         lcRfp/aKkJnB0b+R+acCjOnu7GvBBqiU5T3wDNuyf2Vojzs0JV/cIfCxXAYLcXokuL3r
         K2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687338415; x=1689930415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8HTIhkv++1Fsa2NTQSKbuaibYlj+ipl+Ced2oh/4BE=;
        b=BDcvN8G2UuCvddNIlMD5GWcq1iOJVTCH66HCAquJ/seFT+bk42/nBsCY0VglXMy6s7
         U6sX6D5bJNSsYwHvtdtpA0aZicRTMxq3odwwtwZM+Hp3Dwl/QjSx+tQ44y/Ad2voZwVn
         bVE1eWhinFwkinm7MFFGrwwLF2GoqnYnM2uCpIz2KNs8fuFV5Tq74v8A/oNPD89GLYzS
         jS4LfhSWuKum/fhKcHV7UQdmPqxbjaoSwiRIdKWyI6a0Dlb3FQfCLWd+kF8KFE9XL0Pf
         Lipta9iRWIGWvs/msoZ4WkpU+njZxXNwU7s8748lMyJfxZhmapSQ0n3gZDa3CA3G/HWe
         5X5g==
X-Gm-Message-State: AC+VfDw9FhAwylFQTr0Y0OcVFf9XsxZzAJhebauhGnb7r+cNu6IF1J5W
        4pDTVqrC2ukHoxpLFjwZ/Us=
X-Google-Smtp-Source: ACHHUZ4JpE0R9/+Dh6vTgNfs0KqO4uOSmg4xuknZOptg40nCdU67XSngubYLl72PO+RACezyJvBriA==
X-Received: by 2002:a17:902:e847:b0:1af:a2a4:837f with SMTP id t7-20020a170902e84700b001afa2a4837fmr14444319plg.26.1687338415193;
        Wed, 21 Jun 2023 02:06:55 -0700 (PDT)
Received: from fedora ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id iy14-20020a170903130e00b001b6771ad27bsm2952449plb.265.2023.06.21.02.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:06:54 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:06:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG mm-unstable] "kernel BUG at mm/swap.c:393!" on commit
 b9c91c43412f2e
Message-ID: <ZJK9qCXAMkjom5dz@fedora>
References: <20230607195143.1473802-1-yosryahmed@google.com>
 <ZJKgThENoFlkJQmB@fedora>
 <CAJD7tkYEZEihcQFVrb5KR18r6o5496uXSRJbDrs+woGHwv6zWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYEZEihcQFVrb5KR18r6o5496uXSRJbDrs+woGHwv6zWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:05:56AM -0700, Yosry Ahmed wrote:
> On Wed, Jun 21, 2023 at 12:01 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > Hi Yosry, I was testing the latest mm-unstable and encountered a bug.
> > It was bisectable and this is the first bad commit.
> >
> >
> > Attached config file and bisect log.
> > The oops message is available at:
> >
> > https://social.kernel.org/media/eace06d71655b3cc76411366573e4a8ce240ad65b8fd20977d7c73eec9dc2253.jpg
> >
> > (the head commit is b9c91c43412f2e07 "mm: zswap: support exclusive loads")
> > (it's an image because I tested it on real machine)
> >
> >
> > This is what I have as swap space:
> >
> > $ cat /proc/swaps
> > Filename                                Type            Size            Used            Priority
> > /var/swap                               file            134217724       0               -2
> > /dev/zram0                              partition       8388604         0               100
> 
> 
> Hi Hyeonggon,
> 
> Thanks for reporting this! I think I know what went wrong. Could you
> please verify if the below fix works if possible?
>

Works fine and I was not able to reproduce the bug with the patch
applied.

Not sure Andrew would prefer squashing it into original one or applying it
as separate patch, though (I'm totally fine with both way).

Anyway:

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Domenico, I believe the below fix would also fix a problem with the
> recent writeback series. If the entry is invalidated before we grab the
> lock to put the local ref in zswap_frontswap_load(), then the entry
> will be freed once we call zswap_entry_put(), and the movement to the
> beginning LRU will be operating on a freed entry. It also modifies
> your recently added commit 418fd29d9de5 ("mm: zswap: invaldiate entry
> after writeback"). I would appreciate it if you also take a look.
> 
> If this works as intended, I can send a formal patch (applies on top
> of fd247f029cd0 ("mm/gup: do not return 0 from pin_user_pages_fast()
> for bad args")):
> 
> From 4b7f949b3ffb42d969d525d5b576fad474f55276 Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Wed, 21 Jun 2023 07:43:51 +0000
> Subject: [PATCH] mm: zswap: fix double invalidate with exclusive loads
> 
> If exclusive loads are enabled for zswap, we invalidate the entry before
> returning from zswap_frontswap_load(), after dropping the local
> reference. However, the tree lock is dropped during decompression after
> the local reference is acquired, so the entry could be invalidated
> before we drop the local ref. If this happens, the entry is freed once
> we drop the local ref, and zswap_invalidate_entry() tries to invalidate
> an already freed entry.
> 
> Fix this by:
> (a) Making sure zswap_invalidate_entry() is always called with a local
>     ref held, to avoid being called on a freed entry.
> (b) Making sure zswap_invalidate_entry() only drops the ref if the entry
>     was actually on the rbtree. Otherwise, another invalidation could
>     have already happened, and the initial ref is already dropped.
> 
> With these changes, there is no need to check that there is no need to
> make sure the entry still exists in the tree in zswap_reclaim_entry()
> before invalidating it, as zswap_reclaim_entry() will make this check
> internally.
> 
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

<...snip...>

-- 
Hyeonggon Yoo

Undergraduate | Chungnam National University
