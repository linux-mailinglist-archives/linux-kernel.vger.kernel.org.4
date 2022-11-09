Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3115D6237AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiKIXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiKIXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:48:39 -0500
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80C642B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:48:37 -0800 (PST)
Received: from darkstar.musicnaut.iki.fi (85-76-49-22-nat.elisa-mobile.fi [85.76.49.22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id E120B2024D;
        Thu, 10 Nov 2022 01:48:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1668037714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJTJOn9jstyUEzsYgJ/tqc7eioOfTr+ik31YpBBRsgk=;
        b=auWrSkoEd999srUucLgYvptD6WOJmRi+vSGbQ5/hqi9ZLwSH2ILN716AgJxr7MHAC7GHsT
        lGMAxyqYDSH+HBeu1+tI4QLaOrlAJVwxIZPtQjLi9cZhzXWSFS0nsqUhlT0Qy/k7V3yOX0
        lOD6UKeYm1m0Cdv65pLwYaXI5YxPa4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1668037714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJTJOn9jstyUEzsYgJ/tqc7eioOfTr+ik31YpBBRsgk=;
        b=xESqOqCC3hAiixbH+oEmoxspY65y12L6LHOET7DiT+z/LyWA8yLOlUp2P6kh+tz49EE0FD
        bo1I7e1zVAWNHJzJAp1Izzo0OhYeUG2NZeaq/6OnLNtBMfsqSOUYSaa/C1HaXdc72qfYl/
        wQ10Hm392R7jVjbDj/rSVLmABsdPrgs=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1668037714; a=rsa-sha256; cv=none;
        b=ShDkGCFFaJKzXmIDK6dsPKZWpEUvNh5spDKcHZro9JEecIW+we79zsgOUXokLbecmNyh/o
        VIajcoy3COJ7Dvb8wUkiLMGWmKnIf8wLOfqoUAwzDvCcre/qFVcw6PsrdH/9c605ZSGEtN
        14qsHhNN5SaPeDLCZucD/cWeY3Dxqbc=
Date:   Thu, 10 Nov 2022 01:48:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, vbabka@suse.cz,
        42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, rkovhaev@gmail.com,
        roman.gushchin@linux.dev, willy@infradead.org
Subject: Re: Deprecating and removing SLOB
Message-ID: <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 09, 2022 at 01:39:12PM -0800, Linus Torvalds wrote:
> On Wed, Nov 9, 2022 at 12:56 PM Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > It worked fine on some boards, but on others it had about a 25% chance
> > of booting, and 75% chance of hanging at boot. I tried printk-debugging
> > it, and was coming to the conclusion that it's memory corruption of
> > some sort.
> >
> > Then I switched to SLUB and all the problems are gone. Same with SLAB.
> >
> > So while I can't say for sure that SLOB is broken (it might be
> > triggering a bug somewhere else), I am highly suspicious that it is.
> 
> I have this distinct memory of having seen other reports like this,
> but my google-fu is not strong enough to back that up.
> 
> There definitely has been recurring noise about SLOB issues. There's a
> reason people have wanted to remove it for years and years.

Some of the reported SLOB issues have been actually real driver bugs,
that go unnoticed when SLUB/SLAB are used (unless perhaps debug stuff
is enabled). I'm not saying kernel should keep SLUB, but it's good at
failing early when there is a bug. See e.g. commit 120ee599b5bf ("staging:
octeon-usb: prevent memory corruption")

A.
