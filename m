Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF05672483
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjARRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjARRJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:09:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C653C577FC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:09:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q64so36442437pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WGfWh/zHmol+2Tw3XXG4jVv6PUDBSBBQZSscxBuklU=;
        b=mK6kGMN/rEiKZDELQxhZim27kifJzxaqluXyKU+4ExEOuZ40hTiclMDYcWW5SMzcnd
         z/B626AVqbpaIScKxqXmmeO6/A42ZcYj3fwOdRK2Q/HuXaltTF/hSwC7aVqKCZI5X203
         NjwdBAab4rV13ti/tjDwe906nKzz72rWoJBik50lusX0rDs3noH7ZehEvggmuIHHeqWk
         dwyulZ2TwCGjOoMxtn4njf6AJeYX7php6fvqp2PbSmEQSQdfGyaJCRxVid+qqPacTaSD
         4g6Ry4Qqij026xFUvHbsMrwHzQLbjUAhk64362DLL4IvTmhIBBrR5mqWkgPYmIgoFIZa
         6esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WGfWh/zHmol+2Tw3XXG4jVv6PUDBSBBQZSscxBuklU=;
        b=pQ5Z0DHgk9C4J/wNbH2p4cXB18Qi5O6vdST2KG7eJYzPhFWBbJGQrIGukUM4t26Teq
         3nmJSXvgY+MuUjt94PgxqsXG07u5eiXkyK6Iy8M+2PkP9FKsZSTETawCFXVNbYuI0wH/
         MWPS9v1jMwL5gLZJzDanbBR1nrf8E+lZrKULs4s4fPICMYZZICDEO7HNXrGz6J7Cml7w
         ysurzGvqElpT3x9pA2opOjC6nZYTInqimDfMNxOrNkSwx9BmjzEjlTJAqudP3JPNaXhQ
         Vs2e1rKd7h2dgKV7YS4W0rHfso5ID5995cyO7RYmqn6OVY4WE3sIJipVmB572racaTCO
         /Grw==
X-Gm-Message-State: AFqh2kq0jSgw2cNwLMKQVGafk92W1ahgiCLnflblIWvqkQqLgWE4i99d
        iwf/HFTmdGLucIIDZG12+4I=
X-Google-Smtp-Source: AMrXdXvr0eQnszyMROWr11Gg6xDwKAU+pPtxVu/K5xZECg96vcWBYEH9NSp4CfBFov/AYkfX1RBoUg==
X-Received: by 2002:a17:90b:1197:b0:229:46f0:6f6d with SMTP id gk23-20020a17090b119700b0022946f06f6dmr8475165pjb.42.1674061778863;
        Wed, 18 Jan 2023 09:09:38 -0800 (PST)
Received: from google.com ([2620:15c:211:201:68ba:bd93:858:15d5])
        by smtp.gmail.com with ESMTPSA id r89-20020a17090a43e200b0022941908b80sm1560900pjg.47.2023.01.18.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:09:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 18 Jan 2023 09:09:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8gn0KQDWC/5CZ/w@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:10:44AM +0100, Michal Hocko wrote:
> On Tue 17-01-23 15:16:30, Minchan Kim wrote:
> > The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> > pages paged-out successfully, not only the number of reclaimed pages
> > in the operation because those pages paged-out successfully will be
> > reclaimed easily at the memory pressure due to asynchronous writeback
> > rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> > 
> > This patch renames the reclaim_pages with paging_out(with hope that
> > it's clear from operation point of view) and then adds a additional
> > stat in reclaim_stat to represent the number of paged-out but kept
> > in the memory for rotation on writeback completion.
> > 
> > With that stat, madvise_pageout can know how many pages were paged-out
> > successfully as well as reclaimed. The return value will be used for
> > statistics in next patch.
> 
> I really fail to see the reson for the rename and paging_out doesn't
> even make much sense as a name TBH.

Currently, what we are doing to reclaim memory is

reclaim_folio_list
    shrink_folio_list
        if (folio_mapped(folio))
            try_to_unmap(folio)

        if (folio_test_dirty(folio))
            pageout

Based on the structure, pageout is just one of way to reclaim memory.

With MADV_PAGEOUT, what user want to know how many pages
were paged out as they requested(from userspace PoV, how many times
pages fault happens in future accesses), not the number of reclaimed
pages shrink_folio_list returns currently.

In the sense, I wanted to distinguish between reclaim and pageout.
