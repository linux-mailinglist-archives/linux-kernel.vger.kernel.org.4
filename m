Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802507254E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjFGG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjFGG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5C1BC3;
        Tue,  6 Jun 2023 23:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7176D63B19;
        Wed,  7 Jun 2023 06:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50E0C433EF;
        Wed,  7 Jun 2023 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686120967;
        bh=kxTWU5cvbYPXD97OfkZe5ZmWUKr+C21Zw9jRkJYbsMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDEk6rrM+92tjnJUIo7PJ6PVQsXMHm1goz4upfVYo17T9b4OBgbYwWBKZ8MpADWpS
         k34PbyoX2LXa5/BTSYCNa6XjLggLCYt9BFWVwkyXIr9DoEBug2nz7vGKcGgA3TII9w
         D64O22jrrQGHK02YQphKJdoMXRS9fvr7fkheX4XtQG+P1gortbckgLeUyVSg34AcGe
         V17l7nwTuMnhS6/GHMnKDb5oSHFQlHuNrGyJEvWkkFJZ2Q4KcWg491YMpxtykiXsGM
         AcM5AktF0GA+mm1dL12KMYjfkgnSA5WMSqsCIdJTiKd+rrRAQ8yfgvzPKUsw47vYyR
         +M58T5kpKH1Iw==
Received: by pali.im (Postfix)
        id A1989759; Wed,  7 Jun 2023 08:56:04 +0200 (CEST)
Date:   Wed, 7 Jun 2023 08:56:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
Message-ID: <20230607065604.yaivqbbd3dkawxo4@pali>
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org>
 <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org>
 <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
 <20230607062341.GA30618@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607062341.GA30618@srcf.ucam.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2023 07:23:41 Matthew Garrett wrote:
> On Wed, Jun 07, 2023 at 02:13:31PM +0800, AceLan Kao wrote:
> > Matthew Garrett <mjg59@srcf.ucam.org> 於 2023年6月7日 週三 下午1:27寫道：
> > >
> > > On Wed, Jun 07, 2023 at 01:19:40PM +0800, AceLan Kao wrote:
> > > > Gfx drivers(i915/amdgpu/nvidia) depend on the drm driver, so delaying
> > > > the loading of dell_laptop after drm can ease the issue the most.
> > > > Right, it's still possible to encounter the issue, unfortunately, we
> > > > do not have a better solution for it at the moment.
> > >
> > > We could unregister inappropriate backlight drivers when a more
> > > appropriate one is loaded, or the policy decision around which driver to
> > > use could be made in userland?
> > It's hard to decide which backlight driver is redundant, and it's kind of ugly
> > to unregister the backlight driver which is registered by other driver and maybe
> > problematic.
> 
> But you're relying on registering the working backlight first, which is 
> an inherently racy thing? We shouldn't be relying on order of 
> initialisation to make this work, either we should only export a working 
> interface or we should expose enough information for whatever is using 
> the interfaces to make an appropriate policy decision itself.

IIRC, drm drivers unregister redundant fbcon drivers (vesafb), so cannot
drm drivers use similar strategy also for backlight drivers and
unregister the redundant? If every backlight driver would have some
"flag" which say if it should be unregistered by drm then maybe it could
work? Or are there some other pitfalls?
