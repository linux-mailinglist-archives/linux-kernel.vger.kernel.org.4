Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE368328E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAaQ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjAaQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:28:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72B58664;
        Tue, 31 Jan 2023 08:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7143FB80FED;
        Tue, 31 Jan 2023 16:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA51BC433EF;
        Tue, 31 Jan 2023 16:27:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FMCjvAE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675182461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4bJ8ayNL8Vv9SKkQ7MpjnXBwsEDaGM3RccfYdV9qww=;
        b=FMCjvAE1ka/LCINi+0+vlxwAWUsv20/4+wExDLC5VgsDtYNIxcWwAxfESw7VCdPbiOIphk
        PG/b/7q4uOpoUrh8aEJENtXYnSPbXYYBtwK7pJzHoxi6dlGy4V2y7dlWQxpFgFnclGZTCa
        kexypyU3N4MZ8VCg4rzzI2AI61N+Vyg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1320d313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 31 Jan 2023 16:27:41 +0000 (UTC)
Date:   Tue, 31 Jan 2023 17:27:39 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Babis Chalios <bchalios@amazon.es>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        amit@kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
Message-ID: <Y9lBeymca9eFaJ33@zx2c4.com>
References: <20230131145543.86369-1-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131145543.86369-1-bchalios@amazon.es>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You sent a v2, but I'm not back until the 11th to provide comments on
v1. I still think this isn't the right direction, as this needs tie-ins
to the rng to actually be useful. Please stop posting new versions of
this for now, so that somebody doesn't accidentally merge it; that'd be
a big mistake. I'll paste what I wrote you prior:

| Hi Babis,
| 
| As I mentioned to you privately this week, I'm about to be out of town,
| so I won't be able to look at this until I'm back in a few weeks. I
| appreciate your patience.
| 
| But as a cursory look, I'm happy that you've written the hardware-side
| code for this. That's a great starting point. The plumbing is not so
| nice, though. This needs to be integrated more closely with random.c
| itself, similar to how vmgenid works.
| 
| When I'm back in a few weeks, I'll see if I can either write a
| description of what I have in mind, or simply integrate the useful
| hardware work here into an expanded patch series.
| 
| [Please don't merge anything for now.]

So: you wrote some maybe useful hardware code. The rest is wrong. And we
haven't even concluded discussions on whether the virtio interface is
the right one. In fact, I had previously asked if we could schedule this
all until March. Marco from your team then sent an impatient email, so I
said, alright, what about Feb 11 when I'm back. That's annoying for me
but I figured I'd just shuffle everything around and prioritize this.
Then, instead of waiting for that, you posted v1 of this patchset the
next day. I asked you again. And now, while I'm away on the first
holiday in a while with very little connectivity and no laptop, you post
a v2. So I'm really annoyed. In order to avoid all doubt about this, let
me then just NACK this, and I'll lift the nack when I'm back:

    Nacked-by: Jason A. Donenfeld <Jason@zx2c4.com>
