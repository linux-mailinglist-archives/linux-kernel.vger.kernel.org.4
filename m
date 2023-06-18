Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7511E7344FB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFRFa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFRFaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:30:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A880123
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:30:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7624e8ceef7so76268685a.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687066254; x=1689658254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsGyRHqK4EuHl2bJ+uhiAszhiKWXB1PI+cgzbdYIUDQ=;
        b=gtFw7xRjcRk5yQdSCg0we7e9JTOV1Y5o9gghZd9gFJCLYigZr/kc6bDOsl5GIPyvSn
         RLvdQatTgWyGPfAsOlCRvUwEiAXJGK+64Ph4+LeAGPHsnBqRtO8q+x22o5egI0agdUuu
         FbPhvRP3SU/MjFh/PlVklOYdC3KxIUc4i6GqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687066254; x=1689658254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsGyRHqK4EuHl2bJ+uhiAszhiKWXB1PI+cgzbdYIUDQ=;
        b=TOd4yYzmfZMC5GQmlyigQC4W4dnfjYn42XgF0rG8QBBOnOlxjIFfpstpn6Zx/r0h5X
         GXowrdMw5KIE573DfzQnrS8JhPMPybxS9MeQ/PsOWuUtbdxDMDDbsT6fAdG33kMW3Qbi
         KJgNXn7hx7HSH2yTDrO/uUa6bpd4hYiygDm6nvaYySHxDz9Aj2yLjuOmb9zS0mVKNyeo
         taoTOw9B16ghbPB4VyEjyETdbUmiO+I65czXVHBSvTl7XAEpktni+c4k9223uKrPRTj7
         i49AWHMqaNmWIcKQEHir+e0oDO0HYGA8utyRgoykJH/kHoKNocX5EpFEIaiyNnLXydzY
         Bgag==
X-Gm-Message-State: AC+VfDwHuKZ+QI1Dbqzap9TsuadSsc9sVhc7pwDxfdhnS21jMGanYWbJ
        +f+WF5/MbpBJay5dZ1rNaVI1hQ==
X-Google-Smtp-Source: ACHHUZ5LcXZMYweCzK2ZRsSCMFoC8ArwuqUovpJlDipyHNlM0ZFC2Ptyquf2PMRoc+zk4yK3a5q9gg==
X-Received: by 2002:a05:6214:29e9:b0:630:1a9d:c23 with SMTP id jv9-20020a05621429e900b006301a9d0c23mr315903qvb.52.1687066253795;
        Sat, 17 Jun 2023 22:30:53 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b001b1920cffd5sm3246036pls.267.2023.06.17.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 22:30:53 -0700 (PDT)
Date:   Sun, 18 Jun 2023 14:30:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org, linux-mm@kvack.org,
        ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230618053048.GC2417524@google.com>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com>
 <20230618043857.GA2417524@google.com>
 <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com>
 <20230618052526.GB2417524@google.com>
 <CAJD7tkbcf+MEMJdGeruB7XL=J8tJNgkB7_1UQ2S4VEKjob-NQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbcf+MEMJdGeruB7XL=J8tJNgkB7_1UQ2S4VEKjob-NQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/17 22:28), Yosry Ahmed wrote:
> > On (23/06/17 21:48), Yosry Ahmed wrote:
> > > > On (23/06/12 11:38), Domenico Cerasuolo wrote:
> > > > > +static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > > > +{
> > > > > +     struct zswap_header *zhdr;
> > > > > +     struct zswap_entry *entry;
> > > > > +     struct zswap_tree *tree;
> > > > > +     pgoff_t swpoffset;
> > > > > +     int ret;
> > > > > +
> > > > > +     /* Get an entry off the LRU */
> > > > > +     spin_lock(&pool->lru_lock);
> > > > > +     if (list_empty(&pool->lru)) {
> > > > > +             spin_unlock(&pool->lru_lock);
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +     entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> > > > > +     list_del_init(&entry->lru);
> > > >
> > > > A quick question: should we zswap_entry_get() here?
> > >
> > > We need to hold the tree lock for that, and the lock ordering is tree
> > > lock -> lru lock. If we try to grab the tree lock here we may
> > > deadlock.
> >
> > We can deadlock doing this?
> >
> >         lock tree_lock
> >         lock lru_lock
> >         list_del_init
> >         unlock lru_lock
> >         entry_get
> >         unlock tree_lock
> >         writeback
> 
> We don't know which tree the zswap entry belongs to

Oh... I must be blind. You are right. Sorry for the noise.
