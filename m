Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BD6023A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJRFCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:02:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019ED6160
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:02:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e62so15681663yba.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzY2BAB/isdQN2p5Y+ZvqSSp7Piz56EgRowPXUCvBn8=;
        b=J/N3oT+Xxc8eoy6hyho3U90hlZGSykeUdVbloq6HGu2sDy4frC+DlIdZhduIAXqgIm
         Nzrx/DkbICo3jIlH55O2A8wwx+XQzxJwAo2R9rEt3thypECOmu8GpkUieb8yFNUcUGmX
         ESOBRUfowgFr6G6rckedDXwuWYUl4ianbOHPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzY2BAB/isdQN2p5Y+ZvqSSp7Piz56EgRowPXUCvBn8=;
        b=kvsISlcGMRkocbwdY0o96ssxMPo09VkfDqQl/thAWjLgbEIKS4FNzUqVUEG2F/ljIY
         fKrCxVW+BLs2AHnHrGCCy8RslYY8VApU/DcuCgYpQAWGcjuomRWe3tizDhljyk2KNKCr
         GNWPVtb7z8m/jtiEqzrsJFGxzDsyUYq2Rc+I8IuYojn2XMsMVgN4J6YONUeAFngXd4Y3
         sA8UfeWo+2J3SQqlUKoyNxChztiCpEG06KBgKYtdwIpQqe5MdMSmllV7ry2jRIZr4y3m
         qy9osctrTsssDSXhXsTcgkWB55/Pf48om8FS/lldYwzrqV/srUpAz/3xeC8lXs/dPrDk
         MY4w==
X-Gm-Message-State: ACrzQf2iApb2ZG9esKSRMVhre8ZdBmOdSpft/RVT91j2CPSbIJAylnMw
        QNRSU4+yNXD8KYwCzyl0ZmCEyhwOz71wYHBhQEEGHQNk1Q968q4A
X-Google-Smtp-Source: AMsMyM6GfG7oTQH1AG8NRV/sS/2CjqBYUWRAygvEnHJA3bqQRMLC0A0vKYO7qucOhb0v53r7q4wEU+FCMtSTVJPTOA8=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr1075221ybu.134.1666069358532; Mon, 17
 Oct 2022 22:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224027.59266-1-ivan@cloudflare.com> <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
In-Reply-To: <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 17 Oct 2022 22:02:28 -0700
Message-ID: <CABWYdi1UJsi1iGOAME1tW5eJdqvo3XJidWyO97ksxS85w3ZUPQ@mail.gmail.com>
Subject: Re: [PATCH v2] proc: report open files as size in stat() for /proc/pid/fd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 6:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > +
> > +             fdt = files_fdtable(p->files);
> > +             size = fdt->max_fds;
> > +
> > +             for (i = size / BITS_PER_LONG; i > 0;)
> > +                     open_fds += hweight64(fdt->open_fds[--i]);
>
> Could BITMAP_WEIGHT() or __bitmap_weight() or bitmap_weight() be used here?

That's a great suggestion. I tested it with bitmap_weight() and it
looks much cleaner while providing the same result.

I just sent the v3 with this suggestion applied.
