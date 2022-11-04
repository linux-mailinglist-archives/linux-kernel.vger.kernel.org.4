Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F65619F15
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKDRod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiKDRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:43:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6243AC4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:42:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5so5111216pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+XDeehPqNp624nEDoMBsjLPMyAJCxTSXH00KpaKjDM=;
        b=Z9W5ylLMWmuZ9SryJuhJRN6uHAb5shD1HeVtH7f/1sPFa5bCW/gxHhDhv2U2xM0Q9+
         WzD9zdducnvmd5a6yJzl1cfcMvqit9cJVTro5URoQJAFZ+90rBzTHX1dhXzm0AS+LaQ0
         RwH6JBMH5aseoQrkbqKBdSQmkqEii7Gh3tee5eMtjU97xH5U7JkPmgL0fgNnx9mL7rLS
         5ts9zHbGGk9kploiu77beLpy/dX99+U3p1rsGV8uG/LictREBLL+3DVatyh64o0lHVU6
         6FbetaecqW/LW4x2dMmOy+poShuQEHIZs42AmBOsWemA815kMtYmoCo+lbK5Jkz2w3hf
         RyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+XDeehPqNp624nEDoMBsjLPMyAJCxTSXH00KpaKjDM=;
        b=Bf3nIfwIiuCcFS6IWPZz27f2XFp7ntI76PBL6WxFoB8gHIK7BGrfaXT1CBWa7VLe+0
         jKC0wK13euCaeUUGhRE4iahzxVp6o0upTS8M/uK0wh23kTX/sSxnm4mPHdrI3ZbGUG4l
         Uq3mhNpKscSCfiuR5BSn6QzVSJqoAJVkuTZQrGc+3W+3vmMPPk5EJqpYfQLplbFWKhF1
         YTDPaD7GJbm63xdgeGIE4goQyoOOt81se6D964Gz0MhFitSOWJNrXTQK3Mv7Y17OX85u
         fTE4WbWHPOHGKUjfaiPffcw1D93zqjt18KMHoLHWFgJBPnG5Jowiwf5QaUbtZcLDzbJM
         DUvA==
X-Gm-Message-State: ACrzQf3hUQo7ZMkYIMBAIHDh5+z56OVe5DTkTrsXdXsEXR6GnvC2pSw9
        pTB44OThZBdrt00yS0hr2+JqyTr6cQOFVs222Fk=
X-Google-Smtp-Source: AMsMyM70dPgb2K+IgBGRdaJsonN7jpbfLhYHMku638SrYX6NPEC+Uhr7/ynyZFb+QSitnc0TS3Ro9fKFeVQxHoWYvjQ=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr37068477plg.102.1667583777463; Fri, 04
 Nov 2022 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <20221103213641.7296-2-shy828301@gmail.com>
 <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz> <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
In-Reply-To: <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Nov 2022 10:42:45 -0700
Message-ID: <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com>
Subject: Re: [v2 PATCH 2/2] mm: don't warn if the node is offlined
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

On Fri, Nov 4, 2022 at 2:56 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-11-22 10:35:21, Michal Hocko wrote:
> [...]
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index ef4aea3b356e..308daafc4871 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -227,7 +227,10 @@ static inline
> >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> >  {
> >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> > +     if((gfp & __GFP_THISNODE) && !node_online(nid)) {
>
> or maybe even better
>         if ((gfp & (__GFP_THISNODE|__GFP_NOWARN) == __GFP_THISNODE|__GFP_NOWARN) && !node_online(nid))
>
> because it doesn't really make much sense to dump this information if
> the allocation failure is going to provide sufficient (and even more
> comprehensive) context for the failure. It looks more hairy but this can
> be hidden in a nice little helper shared between the two callers.

Thanks a lot for the suggestion, printing warning if the gfp flag
allows sounds like a good idea to me. Will adopt it. But the check
should look like:

if ((gfp & __GFP_THISNODE) && !(gfp & __GFP_NOWARN) && !node_online(nid))

>
> > +             pr_warn("%pGg allocation from offline node %d\n", &gfp, nid);
> > +             dump_stack();
> > +     }
> >
> >       return __folio_alloc(gfp, order, nid, NULL);
> >  }
> > --
> > Michal Hocko
> > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
