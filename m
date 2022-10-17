Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CCA600DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJQL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:29:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E67CD9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:29:21 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okOIy-0007hW-1b; Mon, 17 Oct 2022 13:29:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, John Keeping <john@metanate.com>
Cc:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [BUG] [PATCH] drm/rockchip: use generic fbdev setup
Date:   Mon, 17 Oct 2022 13:29:11 +0200
Message-ID: <2220890.jZfb76A358@phil>
In-Reply-To: <Y00o3M7SKAB/w9sW@donbot>
References: <20211029115014.264084-1-john@metanate.com> <d814394b-86c3-beb1-ddd4-04c65004f138@gmail.com> <Y00o3M7SKAB/w9sW@donbot>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Oktober 2022, 12:05:16 CEST schrieb John Keeping:
> Hi Johan,
> 
> On Mon, Oct 17, 2022 at 10:11:32AM +0200, Johan Jonker wrote:
> > Your patch contribution causes a kernel panic on MK808 with Rockchip rk3066a SoC.
> > Would you like to contribute to fix this issue?
> > The assumtion that drm_fbdev_generic_setup() does what rockchip_drm_fbdev_init did is not true!
> > A revert makes it work again.
> 
> It looks like there are 3 different ways to end up with -ENOMEM here,
> can you track down whether you're hitting one of the cases in
> rockchip_gem_prime_vmap() or if it's the iosys_map_is_null case in
> drm_gem_vmap()?
> 
> I guess the memory usage increases slightly using the generic code and
> RK3066 has less memory available.

also rk3066 and rk3188 do not have an iommu, so rely
on cma allocations.


Heiko


