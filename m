Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743D620578
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiKHA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiKHA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:58:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01712D1D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:58:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gw22so12331225pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gubzl0YEUi8edKts0iVkW8bTbZEcmyzMNwtHakxV1DQ=;
        b=dnNam+nry5paMbo3UhYDeo/STVJh4H5BuTwjCI76NrtplJI7JqDyeEYROKEPqeT9oT
         ed0uXqiPoZnORUBfHIkxzM9Ldr4BsXz1AWtdU/mIcfNRD0MBaW47mMX9V6kqA5sZ4P2M
         YrnFIkRyJzi7yQf8D7ScxFGwCMHvLrtKqw16lutgdyO3GT34MCgL0ISHOFifBfy0/xzt
         0xRO1VXi2rczB/9+Joe5Z0HQYpuikBW0qGt6GGBT8ZPGqzkvvB2AHEmEeWL/a46Y1RTp
         Ty/bRRE8F9LtETbB34IAZVnYqBhnTAr+GB2MctMnNAEzDGC2AvXZ1vJJP0VmoVYDtkUw
         Cydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gubzl0YEUi8edKts0iVkW8bTbZEcmyzMNwtHakxV1DQ=;
        b=aDS3I6N30kj9xnWDIe2F+ddgDW2BVg0pD4QqldNAOcogQTNeDEx88GujtBYpPLKeK1
         qerqlZsV9zI33NbOYB5dgFCZ54RUTgzC8DECBqQ26SdRfThespY+B0/ZNpD3K1ghyxEp
         BJ4MaIsPOiggQoszxiugcQY88Ie2Ow8EeligFdXcCAYe4grL5gSMkSachIgAKCt+/T5D
         z15K0NT5zgHFh7KWecrix736x+RcDeETv/QGGoKCpVa5yl94FYDPb7aPYYkTshR37SGl
         qqDTmQmpZhnMtqFE4s2kXHUOZeD7TKvHNB2PYaepahGvNW1UwYsgXqjVN+xMqrBxbca1
         yUYA==
X-Gm-Message-State: ACrzQf2FIrSs7jCCJFDEjW8gqwv4LAxVtAPoCVnNJglOfIzDDjohoHIH
        PbXeA9SL5rtfaUTrs7AcKu0QBQ==
X-Google-Smtp-Source: AMsMyM6mBXg5PMqnQ7JzOldZSxkf7Q7kodUfnLZHCgQVvF9iOVj9puqqGr5N9Whvxfeyk9FFn0M/qA==
X-Received: by 2002:a17:902:e352:b0:187:c4c:26ff with SMTP id p18-20020a170902e35200b001870c4c26ffmr50260985plc.162.1667869120007;
        Mon, 07 Nov 2022 16:58:40 -0800 (PST)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090a460a00b00213202d77d9sm4882094pjg.43.2022.11.07.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:58:39 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:58:36 -0800
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] mm: don't warn if the node is offlined
Message-ID: <Y2mpvAy2W0hhI7Yl@google.com>
References: <20221103213641.7296-1-shy828301@gmail.com>
 <20221103213641.7296-2-shy828301@gmail.com>
 <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz>
 <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
 <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com>
 <Y2VtNfkwciJ5hHF6@dhcp22.suse.cz>
 <CAHbLzkrcqc4rcH4iq3tU81=AsFi6MMpkwAFbdJf2vVPDy5HoXA@mail.gmail.com>
 <Y2i6Bway4H/tKkuf@dhcp22.suse.cz>
 <CAHbLzkp=fq5qeuMBxiN14Y1F945N4DiNmArgi4nEACse5b9dWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp=fq5qeuMBxiN14Y1F945N4DiNmArgi4nEACse5b9dWQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07 10:48, Yang Shi wrote:
> On Sun, Nov 6, 2022 at 11:55 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 04-11-22 13:52:52, Yang Shi wrote:
> > > On Fri, Nov 4, 2022 at 12:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 04-11-22 10:42:45, Yang Shi wrote:
> > > > > On Fri, Nov 4, 2022 at 2:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Fri 04-11-22 10:35:21, Michal Hocko wrote:
> > > > > > [...]
> > > > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > > index ef4aea3b356e..308daafc4871 100644
> > > > > > > --- a/include/linux/gfp.h
> > > > > > > +++ b/include/linux/gfp.h
> > > > > > > @@ -227,7 +227,10 @@ static inline
> > > > > > >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> > > > > > >  {
> > > > > > >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > > > > > > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> > > > > > > +     if((gfp & __GFP_THISNODE) && !node_online(nid)) {
> > > > > >
> > > > > > or maybe even better
> > > > > >         if ((gfp & (__GFP_THISNODE|__GFP_NOWARN) == __GFP_THISNODE|__GFP_NOWARN) && !node_online(nid))
> > > > > >
> > > > > > because it doesn't really make much sense to dump this information if
> > > > > > the allocation failure is going to provide sufficient (and even more
> > > > > > comprehensive) context for the failure. It looks more hairy but this can
> > > > > > be hidden in a nice little helper shared between the two callers.
> > > > >
> > > > > Thanks a lot for the suggestion, printing warning if the gfp flag
> > > > > allows sounds like a good idea to me. Will adopt it. But the check
> > > > > should look like:
> > > > >
> > > > > if ((gfp & __GFP_THISNODE) && !(gfp & __GFP_NOWARN) && !node_online(nid))
> > > >
> > > > The idea was to warn if __GFP_NOWARN _was_ specified. Otherwise we will
> > > > get an allocation failure splat from the page allocator and there it
> > > > will be clear that the node doesn't have any memory associated. It is
> > > > exactly __GFP_NOWARN case that would be a silent failure and potentially
> > > > a buggy code (like this THP collapse path). See my point?
> > >
> > > Aha, yeah, see your point now. I didn't see the splat from the
> > > allocator from the bug report, then I realized it had not called into
> > > allocator yet before the warning was triggered.
> >
> > And it would trigger even if it did because GFP_TRANSHUGE has
> > __GFP_NOWARN
> 
> Yeah, the syzbot has panic on warn set, so kernel just panicked before
> entering the allocator.
> 

Sorry I'm late to the party here.  I think Michal's suggestion is sound --
catches instances like we saw with MADV_COLLAPSE, but no risk of panic-on-warn.
Thanks for the suggestion.

Best,
Zach

> > --
> > Michal Hocko
> > SUSE Labs
