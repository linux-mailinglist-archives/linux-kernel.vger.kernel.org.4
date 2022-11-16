Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815B62CF16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiKPXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiKPXte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:49:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEA31FB9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:49:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so350456pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcCp/eb/WZU+DTJcPCwY2VJkzPTgvyrBuxk1a3NJIuI=;
        b=ckt1W2V8G652pelj9SWyQXDp3Mv8waRL2i3OMs9hnMF6mcaw50zNFpXPInwHGvNbHu
         +/05SMGYIOCZmnCULFWV3HcNsKsxbjUJFbP8+i8+mjo1Du9KTdwQaxJGhhIDvAr48L21
         6Y6ju4t+okBqMFuPtTqqdhNp/Jco9AcwTq72YwTYjop7mF1HZutYfn51uTlqFyuuRovI
         XhJxb89wHORiCO5Tb2aFXXSngUsP11MnFi2WoheScQaTf6+JIpR/7VPv5BfoBrB4fCpG
         De7RZXc+28UE83VKcNIGB8RT8FhP1VOVyJVwpaAPUrg455teh0pMtB/SWGqS/TLs6DBN
         gVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcCp/eb/WZU+DTJcPCwY2VJkzPTgvyrBuxk1a3NJIuI=;
        b=Kg7FMwUxNibqDsVlFCimrHL1Ei1nH7M1O3lVmC2QlMITGtDl57wfk4HoZIvC+aD8Ej
         XU8BKkP7XYGm2f9zIgqBUxsdQf5VzeWJQK864EgEJOQp6SvzFgjbEXTuNRTmPky/bRCu
         ujrk1fKlAR9SL40adugiTzrLWSnBKWeHWdyjOKbSnGSd25FCtdyHV13pZtklSGLR0s4L
         OL9GXmaVpTRafNJ7HJRd2xb20doRU80+smV2rPnvY3v4eGL5YsUZbak7cbvedPRFrh4r
         Vsv4b70opDhlGP8SqhVN7EPZZiOt6ln+1Dqve1splJOP/XOXAXGjLbA/PHsqziyVpkQr
         0Tqg==
X-Gm-Message-State: ANoB5pnL8/DbXM6U8chapLLZ+x6qcaVI22x4+/EFA5RXDNllpR955Dl/
        aNlR3PRTgg4P2Pk5fHbdSV4=
X-Google-Smtp-Source: AA0mqf57O2fw5FRh5h+aqLS29o4QxVpsLSnEs/MpaK/Rn1BzGnLL++2dWwaTAMJ+IUd1DX0r3QpK+A==
X-Received: by 2002:a17:902:e9cc:b0:188:6c5b:ffb0 with SMTP id 12-20020a170902e9cc00b001886c5bffb0mr129205plk.125.1668642572737;
        Wed, 16 Nov 2022 15:49:32 -0800 (PST)
Received: from google.com ([2620:15c:211:201:3439:fe53:7a5f:f579])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7999a000000b00561382a5a25sm11446066pfh.26.2022.11.16.15.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:49:31 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 16 Nov 2022 15:49:29 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3V3CWM1LSGT61e/@google.com>
References: <Y2wh4b3oMaknNqGP@google.com>
 <20221110171831.19176-1-nphamcs@gmail.com>
 <Y21/wAkXt7IH/tXN@google.com>
 <Y3VeEV5Qjbk0/t47@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3VeEV5Qjbk0/t47@cmpxchg.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:02:57PM -0500, Johannes Weiner wrote:
> On Thu, Nov 10, 2022 at 02:48:32PM -0800, Minchan Kim wrote:
> > On Thu, Nov 10, 2022 at 09:18:31AM -0800, Nhat Pham wrote:
> > > > Please put the LRU logic under config ZSMALLOC_LRU since we don't need the
> > > > additional logic to others.
> > > 
> > > I think the existing CONFIG_ZPOOL would be a good option for this purpose. It
> > > should disable the LRU behavior for non-zswap use case (zram for e.g). The
> > > eviction logic is also currently defined under this. What do you think,
> > > Minchan?
> > 
> > That sounds good.
> > 
> > Sergey and I are working to change zsmalloc zspage size.
> > https://lore.kernel.org/linux-mm/20221031054108.541190-1-senozhatsky@chromium.org/
> > 
> > Could you send a new version once we settle those change down
> > in Andrew's tree to minimize conflict?
> > (Feel free to join the review/discussion if you are also interested ;-))
> 
> I've been reading through that thread, and it doesn't look like it'll
> be ready for the upcoming merge window. (I've tried to contribute

Depending on the discussion status :)

> something useful to it, but it's a fairly difficult tuning problem,
> and I don't know if a sysfs knob is the best answer, either...)

That's the point.

> 
> Would you have any objections to putting Nhat's patches here into 6.2?

I don't want to block due to other issues so no objection from my side.

> 
> It doesn't sound like there was any more feedback (except the trivial
> ifdef around the LRU), and the patches are otherwise ready to go.

In fact, I didn't start the review yet so please post it unless
Sergey objects it.

Thank you.
