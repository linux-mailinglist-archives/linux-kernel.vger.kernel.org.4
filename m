Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FD62973F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKOLUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiKOLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:18:44 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442826AC9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:18:04 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 18AB61F644;
        Tue, 15 Nov 2022 12:18:02 +0100 (CET)
Date:   Tue, 15 Nov 2022 12:18:00 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Kv7XoBytwwy9pC@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-14 16:15:25, Brian Masney wrote:
> On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The OF node store in chip->fwnode is used to explicitly override the FW
> > node for a GPIO chip. For chips that use the default FW node (i.e. that
> > of their parent device), this will be NULL and cause the chip not to be
> > fully registered.
> > 
> > Instead, use the GPIO device's FW node, which is set to either the node
> > of the parent device or the explicit override in chip->fwnode.
> > 
> > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Tested-by: Brian Masney <bmasney@redhat.com>
> 
> I separately sent a similar type of patch to fix the same issue today:
> https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@redhat.com/T/#u

For completeness, your linked patch fixes a synchronous external abort
on multiple Qualcomm platforms pointed out in [1].  This patch however
does not, are you sure they fix the exact same issue?

[1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/

- Marijn
