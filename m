Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57503685DED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBAD3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBAD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:29:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75E521FC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:29:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r8so10307351pls.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmQeZUBoUZX187HUvjWB4P6UVqNd4TUY8OlUmfszjwc=;
        b=C+/vfvAZe3T0QD4/Auf4b3emxIXToLiwD+krbxlLJ6pc3648rd/EHau9U23OQVy3Uz
         H3FDo23DJgzarhcEsQYrQoY11tCyIYRXiX2Y3ZIS61IsZwe3v3EIONXuuj1wgq3UKuax
         yEOSKQJxjRi0RqnHT1XA3n+TXBXbdT5mqg1JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmQeZUBoUZX187HUvjWB4P6UVqNd4TUY8OlUmfszjwc=;
        b=SImdZebRRxEi1Sl6zKq/YO9eqmanTrj0DJBAZEHaZ50BRmX43edY6hNQke2jWewplH
         6lvRvRQypQdVt8aeULDqX50VX/afIIst3CGXiS06C8x+0MqiGCX0FVd/u/0DqK8DRPeZ
         iv5udEcjmT0DrFIN10CLP/w0ZNn93Awos+hj7eykPld+Q8GCuiDAVTN7QeS8MPR7BrVB
         xxDs4qzf1PNcavaeY2iZrL/sqozlVHffKYuO1HeRtkOfHThmTrL5RzitFg8RSUE2fRm1
         TaamuYcBfzL2fBnWcrS+4v/8BWb9xglWfPqrYfggE/izERtNd2vQFkYbqgGSz+G5I6re
         hcyA==
X-Gm-Message-State: AO0yUKUOaS7pUwHOlXKR0bK6Pk46Rx6AQkIhC0TJiNB9JKglaiVbLIug
        /X/+C709OHGB1zLJYtRJ3bka8g==
X-Google-Smtp-Source: AK7set9Ptx0OBM9znPq+YxMiAFHJ6xv76F2CTVkEIVYgI4mPR0y/gu7skJmJbwpZV7suEHrjPsuZJQ==
X-Received: by 2002:a17:90b:1b50:b0:22b:e590:68d0 with SMTP id nv16-20020a17090b1b5000b0022be59068d0mr429228pjb.49.1675222162568;
        Tue, 31 Jan 2023 19:29:22 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a7a8800b0022c01052e92sm175027pjf.56.2023.01.31.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 19:29:22 -0800 (PST)
Date:   Wed, 1 Feb 2023 12:29:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: fix a race with deferred_handles storing
Message-ID: <Y9ncjPEFEU33ENVq@google.com>
References: <20230110231701.326724-1-nphamcs@gmail.com>
 <Y9nDXBt2OR3hg5X7@google.com>
 <CAKEwX=My-B=KkocO0heMm=7e+Qxkg2RdRJ8pRHm9dBk+Cceyzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=My-B=KkocO0heMm=7e+Qxkg2RdRJ8pRHm9dBk+Cceyzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/31 18:28), Nhat Pham wrote:
> > On (23/01/10 15:17), Nhat Pham wrote:
> > [..]
> > >  #ifdef CONFIG_ZPOOL
> > > +static void restore_freelist(struct zs_pool *pool, struct size_class *class,
> > > +             struct zspage *zspage)
> > > +{
> > > +     unsigned int obj_idx = 0;
> > > +     unsigned long handle, off = 0; /* off is within-page offset */
> > > +     struct page *page = get_first_page(zspage);
> > > +     struct link_free *prev_free = NULL;
> > > +     void *prev_page_vaddr = NULL;
> > > +
> > > +     /* in case no free object found */
> > > +     set_freeobj(zspage, (unsigned int)(-1UL));
> >
> > I'm not following this. I see how -1UL works for link_free, but this
> > cast of -1UL to 4 bytes looks suspicious.
> 
> (resending this since I forgot to forward this to other recipients)
> 
> It is a bit convoluted indeed. But the idea is that for the last object,
> the last link is given by:
> 
> link->next = -1UL << OBJ_TAG_BITS
> 
> And at malloc time, we update freeobj as follows
> set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
> 
> Which means the freeobj value would be set to something like this:
> (-1UL << OBJ_TAG_BITS) >> OBJ_TAG_BITS

Oh, good point. I see what you did there.

> I want to emulate this here (i.e in the case we have no free object).

Makes sense.

> As for the casting, I believe set_freeobj requires an unsigned int for
> the second field.
> 
> Alternatively, to be 100% safe, we can do something like this:
> (unsigned int)((-1UL << OBJ_TAG_BITS) >> OBJ_TAG_BITS)
> 
> But I think I got the same result as just (unsigned int)(-1UL)

Yeah, I guess they should be the same, as we take the lower 4 bytes
only.
