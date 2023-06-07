Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99FE725408
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjFGGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFGGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:23:44 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE5AA;
        Tue,  6 Jun 2023 23:23:42 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 9167742455; Wed,  7 Jun 2023 07:23:41 +0100 (BST)
Date:   Wed, 7 Jun 2023 07:23:41 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
Message-ID: <20230607062341.GA30618@srcf.ucam.org>
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org>
 <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org>
 <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:13:31PM +0800, AceLan Kao wrote:
> Matthew Garrett <mjg59@srcf.ucam.org> 於 2023年6月7日 週三 下午1:27寫道：
> >
> > On Wed, Jun 07, 2023 at 01:19:40PM +0800, AceLan Kao wrote:
> > > Gfx drivers(i915/amdgpu/nvidia) depend on the drm driver, so delaying
> > > the loading of dell_laptop after drm can ease the issue the most.
> > > Right, it's still possible to encounter the issue, unfortunately, we
> > > do not have a better solution for it at the moment.
> >
> > We could unregister inappropriate backlight drivers when a more
> > appropriate one is loaded, or the policy decision around which driver to
> > use could be made in userland?
> It's hard to decide which backlight driver is redundant, and it's kind of ugly
> to unregister the backlight driver which is registered by other driver and maybe
> problematic.

But you're relying on registering the working backlight first, which is 
an inherently racy thing? We shouldn't be relying on order of 
initialisation to make this work, either we should only export a working 
interface or we should expose enough information for whatever is using 
the interfaces to make an appropriate policy decision itself.
