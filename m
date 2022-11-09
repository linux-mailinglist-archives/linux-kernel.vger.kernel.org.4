Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20856237B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKIXv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKIXvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:51:24 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77756433
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:51:23 -0800 (PST)
Received: from darkstar.musicnaut.iki.fi (85-76-49-22-nat.elisa-mobile.fi [85.76.49.22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id A397C1B001CB;
        Thu, 10 Nov 2022 01:51:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1668037880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTBJWXlCBEfCiw4GBwY4/JZJS0qKN69t0qMTsAB6HnM=;
        b=R5/i0NbIj0ldEWrC8Qy75Q4TF1M+TyecNlnwlrsxx0vXYCCxQ6kgiSLabq/JhfrJQKpnlV
        rUNB+chWopbLcgFsxi8ES6pVX/YafvfwZqDgFkatSrazGLUphe+0PgO+IOh5VNpkaKbFGe
        ABdEtWingRU95fvFjaFb5RR8VoBMRaG2qBFf9iKnH9WSgEQdynIFmLkspLjcR2ZrIl7WVs
        zatGRi44sNE2Bs/oN0M6vvDeO+O50k4y9pF9tsDPMZrqstSbHKolr+hLsfFZ5YrbN9HjB3
        dYZrvHy7lTHVfUvpbORO4P1XokKxmCjOrZKDrZd5nwbeBNuLHml+TCshWxjwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1668037880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTBJWXlCBEfCiw4GBwY4/JZJS0qKN69t0qMTsAB6HnM=;
        b=TWbYl6CBdt0Fueo5ahZxJaZ9LKJaYXsqQHWaEXO0xj/58N3+Uue37k1fqEYqY5Pzs9MFjf
        sUynLdKbpty2fzxpkYBz59WI1CHSkrELo4gOPagTx25rnBRniOCWxB3NJb9mU2j9MpA22+
        dvDdthmmIlm6bZolLDZhRtFLTo/Q0iCXibNZQcrqtSCSMVABzJtFaIDuOajFkYS04yN9V9
        DxOTt4/yXdp4nSDkGWcJu1Y1/d9/OjYkUDlaftKESTKlq51wO9qOtqWmpA31CuPbRGSYH3
        Iw2zpbpoXqSmeTfqhyKFxFWFfIUuYqrUQmSWVHHbGvtdDcraiMDY0afpXtXrtw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1668037880; a=rsa-sha256;
        cv=none;
        b=uThBGmKuK9wlvI2NpAFDNVFZ4b298nVsXVyDRUme9jtirSPh044fSdBxIRlFqPdYApZ2lq
        2IKs+397PCjI8Qgc8YoTIjMPOd0Tnvq5E0MhrwmBcP0PLAV/gCzQN23Ld30LS542nXGnJH
        LjddpyuzQj3X6ejEBgpYP6TowQU7IGSOKK13rJ/YBWRA3ToJQQQ+IZsDO4CyOBV1dkjRy+
        tNNlQ3LZx3J0aSUQJesvvb7DupIDvAq1jfMZFuqhcvGfmBGB9OzNDQc3dfqQYh0o3Rov0O
        aidklaZfzKgM69Q08VL/ZPslk1t5Gcl7UNjYd3D/xosE2gc+3My4RIG0pNk75Q==
Date:   Thu, 10 Nov 2022 01:51:17 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, vbabka@suse.cz,
        42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, rkovhaev@gmail.com,
        roman.gushchin@linux.dev, willy@infradead.org
Subject: Re: Deprecating and removing SLOB
Message-ID: <20221109235117.GF307514@darkstar.musicnaut.iki.fi>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:48:35AM +0200, Aaro Koskinen wrote:
> On Wed, Nov 09, 2022 at 01:39:12PM -0800, Linus Torvalds wrote:
> > On Wed, Nov 9, 2022 at 12:56 PM Paul Cercueil <paul@crapouillou.net> wrote:
> > >
> > > It worked fine on some boards, but on others it had about a 25% chance
> > > of booting, and 75% chance of hanging at boot. I tried printk-debugging
> > > it, and was coming to the conclusion that it's memory corruption of
> > > some sort.
> > >
> > > Then I switched to SLUB and all the problems are gone. Same with SLAB.
> > >
> > > So while I can't say for sure that SLOB is broken (it might be
> > > triggering a bug somewhere else), I am highly suspicious that it is.
> > 
> > I have this distinct memory of having seen other reports like this,
> > but my google-fu is not strong enough to back that up.
> > 
> > There definitely has been recurring noise about SLOB issues. There's a
> > reason people have wanted to remove it for years and years.
> 
> Some of the reported SLOB issues have been actually real driver bugs,
> that go unnoticed when SLUB/SLAB are used (unless perhaps debug stuff
> is enabled). I'm not saying kernel should keep SLUB, but it's good at
                                                 ^^^^
                                                 SLOB, sorry for a typo.

> failing early when there is a bug. See e.g. commit 120ee599b5bf ("staging:
> octeon-usb: prevent memory corruption")
> 
> A.
