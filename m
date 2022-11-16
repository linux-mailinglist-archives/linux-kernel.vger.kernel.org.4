Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D962C36C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKPQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKPQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:07:00 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281F56541;
        Wed, 16 Nov 2022 08:06:59 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 376F43EEAA;
        Wed, 16 Nov 2022 17:06:56 +0100 (CET)
Date:   Wed, 16 Nov 2022 17:06:54 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Brian Masney <bmasney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <20221116160654.3dofnzvouwfzt3sw@SoMainline.org>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
 <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
 <Y3S62i7OzocP5QrT@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3S62i7OzocP5QrT@orome>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-16 11:26:34, Thierry Reding wrote:
> On Tue, Nov 15, 2022 at 12:18:00PM +0100, Marijn Suijten wrote:
> > On 2022-11-14 16:15:25, Brian Masney wrote:
> > > On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > The OF node store in chip->fwnode is used to explicitly override the FW
> > > > node for a GPIO chip. For chips that use the default FW node (i.e. that
> > > > of their parent device), this will be NULL and cause the chip not to be
> > > > fully registered.
> > > > 
> > > > Instead, use the GPIO device's FW node, which is set to either the node
> > > > of the parent device or the explicit override in chip->fwnode.
> > > > 
> > > > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > 
> > > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > > Tested-by: Brian Masney <bmasney@redhat.com>
> > > 
> > > I separately sent a similar type of patch to fix the same issue today:
> > > https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@redhat.com/T/#u
> > 
> > For completeness, your linked patch fixes a synchronous external abort
> > on multiple Qualcomm platforms pointed out in [1].  This patch however
> > does not, are you sure they fix the exact same issue?
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/
> 
> Can you check if the below fixes the MSM issue that you're seeing
> (applied on top of my earlier patch, though with Brian's reverted
> temporarily)?

Yes that solves it too, thanks!

- Marijn
