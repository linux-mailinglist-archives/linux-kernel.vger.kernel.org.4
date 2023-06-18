Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD77344F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFRFZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:25:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B7DA
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:25:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66869feb7d1so355590b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687065931; x=1689657931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lEqHyxGtCRDjYgsfTX1nfcI5nfmX6OULc3IM+psge4=;
        b=LCRM+gXkewTc7CVIoPzQl0RbPysH9hV3npvzPDDnu1asWxNE0iZNHZbckrm4KnsB+A
         QDy0VZaR8WOZgfYsYi8yueNybrOfR0ys8QEtBzclC4JOwyS346ECW/qIBqYqhe41/l0f
         ZrJuWg1lBFpq1Vd58dOAnP8TmL5SZtGw5cRsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687065931; x=1689657931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lEqHyxGtCRDjYgsfTX1nfcI5nfmX6OULc3IM+psge4=;
        b=TZ14q7KsOaNyVoUBpGFeD3UV4pjGofi0diVb4ramcqF6+JdHPWgZLtK5dU6bLp3cl7
         gN3x8YUf2iUNwMrUP9WybxukqtRgiKparYKhSyZ+nc7ADm/aT/Ygt6ScQYQ4co0ltzph
         9+vXommntsNSNJ4o59epOBI3v02XHqyurHSiadf8Ozw9GAZCJhO8dk/tyhPd3Ss4uE5K
         /KZXH8rqw/3wtSKJGc4BPUVLooTUnMXwegjX0kEwOsCX/OpO1/bF0vS9ZroX91zx1awQ
         rpvRdN5qftHKz+pU0teUtKLniZGQ/FoqKs3xPQFrf/ezCkZg7pzEpwNSfdXa81NcpE7h
         Uxug==
X-Gm-Message-State: AC+VfDzPtPYbyDdiYlKbDl49bT3n6chvawY84vQsjGe/AZyga7CjSsHx
        KMblM7libZQbwjjOHlAgYeBMTQ==
X-Google-Smtp-Source: ACHHUZ7+beLKa/0zxEEmwU6sXe49M0T5XlPdzQxQmP/BaTPYunD89PVhR+uQkdbx9fTT5GdIFGAy7Q==
X-Received: by 2002:a17:902:d483:b0:1b4:fe23:1eaa with SMTP id c3-20020a170902d48300b001b4fe231eaamr5350017plg.28.1687065931541;
        Sat, 17 Jun 2023 22:25:31 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001b54a88e6adsm1739188plb.309.2023.06.17.22.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 22:25:30 -0700 (PDT)
Date:   Sun, 18 Jun 2023 14:25:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org, linux-mm@kvack.org,
        ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230618052526.GB2417524@google.com>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com>
 <20230618043857.GA2417524@google.com>
 <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/17 21:48), Yosry Ahmed wrote:
> > On (23/06/12 11:38), Domenico Cerasuolo wrote:
> > > +static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > +{
> > > +     struct zswap_header *zhdr;
> > > +     struct zswap_entry *entry;
> > > +     struct zswap_tree *tree;
> > > +     pgoff_t swpoffset;
> > > +     int ret;
> > > +
> > > +     /* Get an entry off the LRU */
> > > +     spin_lock(&pool->lru_lock);
> > > +     if (list_empty(&pool->lru)) {
> > > +             spin_unlock(&pool->lru_lock);
> > > +             return -EINVAL;
> > > +     }
> > > +     entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> > > +     list_del_init(&entry->lru);
> >
> > A quick question: should we zswap_entry_get() here?
> 
> We need to hold the tree lock for that, and the lock ordering is tree
> lock -> lru lock. If we try to grab the tree lock here we may
> deadlock.

We can deadlock doing this?

	lock tree_lock
	lock lru_lock
	list_del_init
	unlock lru_lock
	entry_get
	unlock tree_lock
	writeback
