Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBF6A0D29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjBWPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjBWPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ADF59434
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677166646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Q7pkbj+FzfjczKYbQGqr5IkroT9Qr7LdVvF+CqKZgQ=;
        b=WLnitXfxfnOJSbVFbyYGkATinhTsd7nyK910K9rYtoALoBkoMrcMejpGyfzwnodzVJL5YT
        qriVg/VhyI0IEYVs5LMEdUY46f9CiJLKbxbGzXDbcBjyipXI12FSlvIQbbAD/dEni70USv
        mfr4SUp+JaeLhkrgs/wl0brb8D+Oa/8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-FjtCGLjFPlOHfariD-14eQ-1; Thu, 23 Feb 2023 10:37:25 -0500
X-MC-Unique: FjtCGLjFPlOHfariD-14eQ-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a165300b007389d2f57f3so5460894qko.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q7pkbj+FzfjczKYbQGqr5IkroT9Qr7LdVvF+CqKZgQ=;
        b=1Gw4eLIIa06XUTeo+7te/UjEM1CzQf5tZTLNAO2p6dG1+a/VxAtZSWPjKpBEfJ3FmV
         wAEhRdlmzuK4f2oyXhJevFC8tlbF4s+47PzchrHYdIKTmR5l9c9hAnluOmJ5psbvjB3Q
         EuIH1XdUgRP6CjckygbJDh/BjRyBl12+1qr9c+UR18MRc7iX7au4u2cD9zLmZuGXP2GW
         vEdLyxh5ZpOuVIzsvkajVTkKCQrtCY+/QrI161WqabO6UcXJ+UzrOTzzbz1aE6kc9cZS
         FXFSySaqrxLrQKpOX1ehEhfkn2kYo68gMaARTt50wVPOd9HLbl2kbn9/2VigfC7O282R
         z07g==
X-Gm-Message-State: AO0yUKVHENOW/OgGFwh3RNXdzF4N7jGbi42q5HLuMII1DFVbY8Mtc/Ib
        2zvkMgq4N/iVP7wQNjziBB0V4GG+PH3gnEdII7111DtXzIiohqQBpnNMRZTAkx5HyBiNB39jYY5
        dlLZ4V6UQlajaRbn7xJbUFpdI
X-Received: by 2002:a05:6214:528d:b0:537:727f:ac28 with SMTP id kj13-20020a056214528d00b00537727fac28mr21466995qvb.27.1677166644511;
        Thu, 23 Feb 2023 07:37:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/0Qh6CfWVZgZGCPRngqO01OgjmJ5IJcPL8T2jkdO4zYHLFqpPmk7F32Itj10FnuzxLI94tiw==
X-Received: by 2002:a05:6214:528d:b0:537:727f:ac28 with SMTP id kj13-20020a056214528d00b00537727fac28mr21466961qvb.27.1677166644201;
        Thu, 23 Feb 2023 07:37:24 -0800 (PST)
Received: from optiplex-fbsd (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id dw16-20020a05620a601000b0073bad2f9380sm3042966qkb.14.2023.02.23.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:37:23 -0800 (PST)
Date:   Thu, 23 Feb 2023 10:37:21 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Message-ID: <Y/eIMXtEJVszprNb@optiplex-fbsd>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/eFtTO+8kXlsW7x@optiplex-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/eFtTO+8kXlsW7x@optiplex-fbsd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:26:45AM -0500, Rafael Aquini wrote:
> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
> > The shrinker_rwsem is a global lock in shrinkers subsystem,
> > it is easy to cause blocking in the following cases:
> > 
> > a. the write lock of shrinker_rwsem was held for too long.
> >    For example, there are many memcgs in the system, which
> >    causes some paths to hold locks and traverse it for too
> >    long. (e.g. expand_shrinker_info())
> > b. the read lock of shrinker_rwsem was held for too long,
> >    and a writer came at this time. Then this writer will be
> >    forced to wait and block all subsequent readers.
> >    For example:
> >    - be scheduled when the read lock of shrinker_rwsem is
> >      held in do_shrink_slab()
> >    - some shrinker are blocked for too long. Like the case
> >      mentioned in the patchset[1].
> > 
> > Therefore, many times in history ([2],[3],[4],[5]), some
> > people wanted to replace shrinker_rwsem reader with SRCU,
> > but they all gave up because SRCU was not unconditionally
> > enabled.
> > 
> > But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
> > the SRCU is unconditionally enabled. So it's time to use
> > SRCU to protect readers who previously held shrinker_rwsem.
> > 
> > [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> > [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
> > [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
> > [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
> > [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
> > 
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > ---
> >  mm/vmscan.c | 27 +++++++++++----------------
> >  1 file changed, 11 insertions(+), 16 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9f895ca6216c..02987a6f95d1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
> >  
> >  LIST_HEAD(shrinker_list);
> >  DECLARE_RWSEM(shrinker_rwsem);
> > +DEFINE_SRCU(shrinker_srcu);
> >  
> >  #ifdef CONFIG_MEMCG
> >  static int shrinker_nr_max;
> > @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
> >  void register_shrinker_prepared(struct shrinker *shrinker)
> >  {
> >  	down_write(&shrinker_rwsem);
> 
> I think you could revert the rwsem back to a simple mutex, now.
>

NVM, that's exactly what patch 7 does. :)

 

