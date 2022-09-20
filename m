Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743355BE25F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiITJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiITJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:49:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631E6E2C7;
        Tue, 20 Sep 2022 02:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D597FB82718;
        Tue, 20 Sep 2022 09:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06906C433C1;
        Tue, 20 Sep 2022 09:49:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kFVOYD0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663667345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrvMwoCI44ixpqh7YSb4dPxXv3cUsQw2696cbGcQq18=;
        b=kFVOYD0PjfkVEGINGvpG2ewFoo6pTYq3bfiWb2R+4S2LaW9+6ZWXZuQd9AppIn5x5lUDa9
        VH5aNcsEOd/N8lz4ezyYowQT8lV5rd8r9kac0d9+gxdJTfxhqfl5veXBlhsDRtF5/PQAEb
        wBov3zKhSanD+CzZhDaTVIzRLBnMHYU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b541fdd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Sep 2022 09:49:05 +0000 (UTC)
Date:   Tue, 20 Sep 2022 11:49:02 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Corentin Labbe <clabbe@baylibre.com>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Kyle Copperfield <kmcopper@danwin1210.de>
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <YymMjpeHWV3d+64d@zx2c4.com>
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Sep 20, 2022 at 10:35:44AM +0100, Robin Murphy wrote:
> On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> > The Rockchip driver has long existed out of tree, but not upstream.
> > There is support for it upstream in u-boot, but not in Linux proper.
> > This commit imports the GPLv2 driver written by Lin Jinhan, together
> > with the DTS and config blobs from Wevsty.
> 
> Note that Corentin has a series enabling the full crypto driver for 
> RK3328 and RK3399[1], so it would seem more sensible to add TRNG support 
> to that. Having confliciting compatibles for the same hardware that 
> force the user to change their DT to choose one functionality or the 
> other isn't good (plus there's also no binding for this one).

Kyle, CC'd, pointed out the same thing to me. He apparently has already
done the work to have a hwrng ontop of that series. So hopefully it's
just a matter of having everyone coordinate.

So I'll duck out and let you guys handle it. Just please make sure the
thing you're rejecting this for does actually come to fruition.

Kyle, should you send your thing to Corentin?

Jason
