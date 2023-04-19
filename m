Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8366E7FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjDSQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C922421F;
        Wed, 19 Apr 2023 09:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167B26360F;
        Wed, 19 Apr 2023 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E17C433D2;
        Wed, 19 Apr 2023 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681921813;
        bh=sEVV20b4y3jjUWYRjOhrLBZndBzScBmsUh19a92XqvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNe0hDpw2kgnpTFFR+an8adqixCrkW2cC6NzKuw7QVwxocDg7vqF1il0W8zOys5Mx
         alsaFzl/kbHkdndzf1bZmylt9hdOf0kS//TIcBvfCov8A12A2P/jixVl64NScUcMPv
         KMp019u/g7G7Nu/aO4WLyS2lSGL3B7iJh+wuRyZDj5RfftHb3IPWT8GLoH7URd32u3
         op2+PxU8obmRQLrlXx+41VCFvcoOc+4OLsXMaGiMEhvnQLOR8h2BkxH9vWgSySwCWG
         g32Z40bb+UWj3xiCTYuFORxMMBPks6+1D67p/9ioMev9LnhAJmG3D/dP412NlUob4d
         Q067AVhfXm7hQ==
Date:   Wed, 19 Apr 2023 09:30:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@gmail.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <20230419163011.GA1865368@dev-arch.thelio-3990X>
References: <20230414125913.851920-1-broonie@kernel.org>
 <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
 <8c90b4db-3075-4275-bea8-01f501b00885@sirena.org.uk>
 <ZEAVxeIEOny81EGY@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEAVxeIEOny81EGY@phenom.ffwll.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:24:37PM +0200, Daniel Vetter wrote:
> On Tue, Apr 18, 2023 at 07:34:44PM +0100, Mark Brown wrote:
> > On Sun, Apr 16, 2023 at 09:58:50AM +0200, Daniel Vetter wrote:
> > 
> > > Note there was a ppc compile fail, which is why we pushed the ttm revert.
> > > That /should/ be fixed now, but would be good if you can confirm?
> > 
> > According to Nathan (CCed) there's still issues with the interaction
> > with the PowerPC tree.
> 
> So this revert was supposed to fix this: 56e51681246e ("drm/ttm: revert
> "Reduce the number of used allocation orders for TTM pages"")
> 
> If there's anything left then I need to chase that asap since the merge
> window will open soon.

I think we are talking about two different issues here. My issue is not
a compilation failure, it is an incorrect merge resolution that is
happening in -next because of two independent changes in the drm and
powerpc tree, the thread below should have more information.

https://lore.kernel.org/20230413184725.GA3183133@dev-arch.thelio-3990X/

I do not think this is something that either tree can solve
independently of each other, -next has to resolve the conflict correctly
(which is what I point out in the message above) and a note of it should
be passed along to Linus so it can be resolved correctly in mainline
when the time comes.

Cheers,
Nathan
