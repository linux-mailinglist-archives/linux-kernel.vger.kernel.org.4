Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C16D4ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjDCRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:22:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F8113
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:22:51 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 047FD60005;
        Mon,  3 Apr 2023 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1680542570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwmDaBfdpINbLHryMxBxZ5HFeF6lCAutGgrkNzu6I1E=;
        b=e9huTgoxQ8SPhnRT9uaDRNRnOX+mnX1uaH/2QYx0+2vNC8gnou5O/G1XE+q5x9Vvv9Qwzj
        gYx8jf30hlF4TKwmYgKxQbR865P3RIE6TwHRC+U5Jb7N3E8UPTn9T3qFTPmInMkt+ePICj
        tiKJUgLLi7Ik0ETtxHa1nb9f6fhhaT4DI94BOziZpaHjvP1p9kIxzzIwYHjboDL0j0bYmA
        gDmFd6bUmzor499mcb1bKJqfnzdf9dQGvtkFLdANepJKmLxz32zS8x/49OY0sa4r6cknfq
        FmO0RQZNtoX8YIIpo5eVceaNOi03MviX//NAR9uQ7lTGH/f7nUDjX3n4wHgs8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 03 Apr 2023 19:22:47 +0200
Message-Id: <CRNAMDCKUUBK.3PPU45G9W5IRQ@iMac.local>
From:   "Roman Beranek" <me@crly.cz>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Cc:     "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm: sun4i: calculate proper DCLK rate for DSI
X-Mailer: aerc 0.14.0
References: <20230331110245.43527-1-me@crly.cz>
 <20230331110245.43527-4-me@crly.cz> <87h6tya70h.fsf@oltmanns.dev>
 <CRN65FVKWIUG.1VSDAH8INXQMT@iMac.local> <87pm8lj709.fsf@oltmanns.dev>
In-Reply-To: <87pm8lj709.fsf@oltmanns.dev>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Apr 3, 2023 at 5:08 PM CEST, Frank Oltmanns wrote:
>
> On 2023-04-03 at 15:52:36 +0200, "Roman Beranek" <me@crly.cz> wrote:
> > As little a change as setting .clock in the default mode of PP's panel
> > to 73500 can fix it. Better yet, dropping pll-video0-2x from the set
> > of acceptable parents for tcon0 fixes it universally. And that's what
> > megi's kernel does, though the measure was introduced with a different
> > rationale:
> > <https://github.com/megous/linux/commit/7374d5756aa0cc3f11e494e3cbc54f6=
c7c01e1a8>
>
> For sake of completeness, the patch you referenced builds on this patch:
> https://github.com/megous/linux/commit/45e0aa8d9e34
>
> Are you saying that your other boards and panels work without these
> patches?

Yes, that was a bit of an oversight on my side as I wrote drivers for
both panels already with the intention of them being used besides
an HDMI output in mind, so I've deliberately picked a timing in each
case such that the dotclock lines up nicely with pll-video0 at 297 MHz.

All the best
Roman Beranek
