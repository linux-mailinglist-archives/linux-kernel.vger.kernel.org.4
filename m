Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB017619EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKDRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKDRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:37:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0A31FBA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:37:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v17so5552987plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WJVNtgyt9yQIAQP4rGtMlIS+jIsXpnGPsRO7taD5C0=;
        b=maWU6xxaIgdZI6etWPmNC9wyUJnic8/26HvAqDHTw2egJeR4aQ7meZcPEurtYlCHyR
         wJ2i3kqsaduQJea56AO1pSMUp0DUmn53+6s89V7vq0KIvfwXKls0g+YGZ1ScH97iOOnX
         XTsDdXfcw0ZtmkUXw/ZvHkE1E2lGO8jZueWHFjfyKBFKzxXONjBMELcVleHc9lizV4xr
         WJ0QQj7Fp+zLA/vdzTb2yRkTI5p6TySvYbCdtKGiyLXrel+cd584xtVNBzHk7+jd/nOc
         yaPSJsJex8qrYiG+AMQYbgDmP4uDfRETQKHQW0b0fTY9G9rs0HupZpYVazF5bZPdcPAF
         8nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WJVNtgyt9yQIAQP4rGtMlIS+jIsXpnGPsRO7taD5C0=;
        b=rda2Zy5RWrfNsk1FhpyTyKHUyuAgwVMQL4CK9zGkhzI7tfEWeh/ZLajvznCb3slBVo
         DqOqA3BtmC9o/28o4VchyIwgB7b0XKiLgGyDX7EwlH/IGg0gCtxEQH08Guz7xjYo1j/U
         DRK3mofKp4E/9+TdVFZkfYqnZwU52dx0MhqD7k0oCptYPD7KhQU/nPmVhK6RQBiUHnxH
         q8NjlU6if7i1vFiE+uLfd3TYBun//d98X06CEiF8OPzQlPl5LBFeXYwm1wAtfRO6btch
         ZeR6Vy6T/Y9/ny9MGeLa0KKvL0y5JOKsUoVwtBNnuD+lklKEiwXzdZ5C+ppmNwIGvPgD
         otUA==
X-Gm-Message-State: ACrzQf0wYulpF44+q7k8oSe7hNyUqRREK5mYzR7oAcs3Z3eVuRNBd1NH
        mInOZKg2M4FwW7VdUHY5whrdlPy5NFvaO2su1KG5i5n4
X-Google-Smtp-Source: AMsMyM4aZ2Mu3gPp9wEirY7n+iM73dkatT2xVVDSugb86smFkyUY3Y0zdRRZ0DONUznEqQS/KkwXQbHtiKkHMV8zWcY=
X-Received: by 2002:a17:90a:558c:b0:213:8cf1:2ac2 with SMTP id
 c12-20020a17090a558c00b002138cf12ac2mr41822574pji.67.1667583471878; Fri, 04
 Nov 2022 10:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <Y2TOAdHk97pPYwJY@dhcp22.suse.cz>
In-Reply-To: <Y2TOAdHk97pPYwJY@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Nov 2022 10:37:39 -0700
Message-ID: <CAHbLzkpPioG8kiTHtepEtTC8sr8JAc2JTJk0s7WQH+fCh6YFKA@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] mm: khugepaged: allow page allocation fallback to
 eligible nodes
To:     Michal Hocko <mhocko@suse.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 1:32 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 03-11-22 14:36:40, Yang Shi wrote:
> [...]
> > So use nodemask to record the nodes which have the same hit record, the
> > hugepage allocation could fallback to those nodes.  And remove
> > __GFP_THISNODE since it does disallow fallback.  And if nodemask is
> > empty (no node is set), it means there is one single node has the most
> > hist record, the nodemask approach actually behaves like __GFP_THISNODE.
> >
> > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/khugepaged.c | 32 ++++++++++++++------------------
> >  1 file changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ea0d186bc9d4..572ce7dbf4b0 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -97,8 +97,8 @@ struct collapse_control {
> >       /* Num pages scanned per node */
> >       u32 node_load[MAX_NUMNODES];
> >
> > -     /* Last target selected in hpage_collapse_find_target_node() */
> > -     int last_target_node;
> > +     /* nodemask for allocation fallback */
> > +     nodemask_t alloc_nmask;
>
> This will eat another 1k on the stack on most configurations
> (NODE_SHIFT=10). Along with 4k of node_load this is quite a lot even
> on shallow call chains like madvise resp. khugepaged.  I would just
> add a follow up patch which changes both node_load and alloc_nmask to
> dynamically allocated objects.

The collapse_control is allocated by kmalloc dynamically for
MADV_COLLAPSE path, and defined as a global variable for khugepaged
(khugepaged_collapse_control). So it is not on stack.

>
> Other than that LGTM. I thought we want to keep __GFP_THISNODE but after
> a closer look it seems that this flag is not really compatible with
> nodemask after all. node_zonelist() will simply return a trivial zone
> list for a single (preferred node) so no fallback to other nodes is

Yes, exactly.

> possible. My bad to not realize it earlier.

It is fine, never mind.

> --
> Michal Hocko
> SUSE Labs
