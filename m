Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B973029E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbjFNPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbjFNO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:59:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915101FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:59:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b2d8b5fde6so3062130a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686754795; x=1689346795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dfTAd0/uVK+gWwVM3TF/SLIQlNoUyF/c3rvI5XRmuAQ=;
        b=aSGtMLARzci2di/1Rpdv8xh5c1HJsKdm2H4SR6/LQjfYaNAJxKiz09SlynAzHB0I9h
         66ICKopEL4NhcLH1nLIvsatgho0jHLzitzSn0o2zat7OzwfKAWFwwAWP1mWEVZ06YCNO
         nGPYmmnl5OxWbuteMziKGLn0ZLpxNAkJcxUv7Uizr6qgFw9Xs4VvFAjLR+msqlKyRcKB
         I3U19BEov3D0Km7Zhqg/PdZ7raeuwWY+nuqgsVUgYezn7iV5JXZTe866AtL5/iz/CHOL
         NOTYaKgfoe4Yhc/OcPearfE7+6ld5wXxQrZ9WCV+5hx5+7AybxwaBp4XZ/0rlGFfxX5z
         UwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754795; x=1689346795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfTAd0/uVK+gWwVM3TF/SLIQlNoUyF/c3rvI5XRmuAQ=;
        b=L8cXSiVh2TF2SHQ+zMcrYlSrrBuyRpjku1cWQd4JCdHh5VfcEDt3ymr+5i/nXQ0/re
         MPXGHtUJYHAVhrTUOS+1kQDUSrx6r637DIouGZrMDx95w2DvaKa9AtLL+PLds00hiK8m
         jqRtOn2U51/kQJ0TsYjw3GOIKTkJhGDoKwnQwDH3wZT+1jG0kGfypG9veYEOjVRtTfc0
         jQcbFw6rp0fqQVr1zpnMwPflQ5T3N7/nc2NfD1InttvxFx1abWJq+1RIuHLUgwsYeW9x
         uumyCNky8Mu1BFDwB+Svk7MwlSaG3ii+Ktc89ghLwvKWCRH+Ttpl6VhXf1yO1Rbpzhdz
         2jMg==
X-Gm-Message-State: AC+VfDyiA3SEfXKo66oYByjtFF55GlPTwtv4evk/6Lm2R1vCU6E+SekA
        YPDjj6fAo55dEfHgNXSIii18pg==
X-Google-Smtp-Source: ACHHUZ7zIGFCJJU8MQqg8L9cSdY5qrNalqmf/z+VT8WF0tStfZz8Mq0+DJDKzoSCYzC6GAuN2Tasqw==
X-Received: by 2002:a05:6359:609:b0:12b:da3f:d0e3 with SMTP id eh9-20020a056359060900b0012bda3fd0e3mr6919711rwb.10.1686754794703;
        Wed, 14 Jun 2023 07:59:54 -0700 (PDT)
Received: from localhost ([2601:586:4c7f:f985:f03e:5c2f:42af:384a])
        by smtp.gmail.com with ESMTPSA id p131-20020a817489000000b00560beb1c97bsm3906768ywc.97.2023.06.14.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:59:54 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:59:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: multiple zpool support
Message-ID: <ZInV6Wju2NdLyzC6@cmpxchg.org>
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org>
 <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org>
 <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org>
 <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
 <20230602202453.GA218605@cmpxchg.org>
 <CAJD7tkZBxddm1c4f99KmY+VwKU3jbYBMaNuTtfpis7a1E6242Q@mail.gmail.com>
 <CAJD7tkaraXuLKR8rsKw_8sp9YZga1caM7r0jA8DZC2Y6DxJNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaraXuLKR8rsKw_8sp9YZga1caM7r0jA8DZC2Y6DxJNfQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:13:59PM -0700, Yosry Ahmed wrote:
> On Mon, Jun 5, 2023 at 6:56 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Fri, Jun 2, 2023 at 1:24 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > Sorry, I should have been more precise.
> > >
> > > I'm saying that using NR_CPUS pools, and replacing the hash with
> > > smp_processor_id(), would accomplish your goal of pool concurrency.
> > > But it would do so with a broadly-used, well-understood scaling
> > > factor. We might not need a config option at all.
> > >
> > > The lock would still be there, but contention would be reduced fairly
> > > optimally (barring preemption) for store concurrency at least. Not
> > > fully eliminated due to frees and compaction, though, yes.
> 
> I thought about this again and had some internal discussions, and I am
> more unsure about it. Beyond the memory overhead, having too many
> zpools might result in higher fragmentation within the zpools. For
> zsmalloc, we do not compact across multiple zpools for example.
> 
> We have been using a specific number of zpools in our production for
> years now, we know it can be tuned to achieve performance gains. OTOH,
> percpu zpools (or NR_CPUS pools) seems like too big of a hammer,
> probably too many zpools in a lot of cases, and we wouldn't know how
> many zpools actually fits our workloads.

Is it the same number across your entire fleet and all workloads?

How large *is* the number in relation to CPUs?

> I see value in allowing the number of zpools to be directly
> configurable (it can always be left as 1), and am worried that with
> percpu we would be throwing away years of production testing for an
> unknown.
> 
> I am obviously biased, but I don't think this adds significant
> complexity to the zswap code as-is (or as v2 is to be precise).

I had typed out this long list of reasons why I hate this change, and
then deleted it to suggest the per-cpu scaling factor.

But to summarize my POV, I think a user-facing config option for this
is completely inappropriate. There are no limits, no guidance, no sane
default. And it's very selective about micro-optimizing this one lock
when there are several locks and datastructures of the same scope in
the swap path. This isn't a reasonable question to ask people building
kernels. It's writing code through the Kconfig file.

Data structure scalability should be solved in code, not with config
options.

My vote on the patch as proposed is NAK.
