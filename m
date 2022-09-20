Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546745BDD62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiITGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiITGf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5121809;
        Mon, 19 Sep 2022 23:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73FACB824F9;
        Tue, 20 Sep 2022 06:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A531C433C1;
        Tue, 20 Sep 2022 06:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663655603;
        bh=Kx95UqRhjI3UeTGV/4rW6sPpJIP0PglZOZlpHtmZksw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfhofTxj0ogMjG7dJh6lAOC7Si2KTr5/bdmSwuBOWBnEiaqyIHNwZH6ZGjO1UEaXQ
         7dGG0KNm4YgB42U7O14fjhQQq6CC19TkVhmBTsTUEQi5oVDcPhNj5jXqtQbE6w01K/
         ylRx/TihGFqk4SrJ6rXOcwRkqBqh7Fg4ofz83nb7clOPDztyYwZMA2SCtu2NEoDr0h
         Q/GxevS8X6ccXvZ89gZwRucr558GXOTEaYDkmgxNwescnTdgDgL8u9RHJt9ka74xNJ
         wDNz6Qpltfm6JQhwdB/NUfFaeg2nD6L0LtlsDLpJtxgwpb917MLKGWiIrWISMFsGcO
         TmOueC1NkbRDQ==
Date:   Tue, 20 Sep 2022 12:03:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        bhsieh@nvidia.com, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Message-ID: <Yyler0lWvEQeKiW2@matsya>
References: <20220816082353.13390-1-jilin@nvidia.com>
 <20220816082353.13390-2-jilin@nvidia.com>
 <YxS6FBeyS1Cs7xhI@matsya>
 <8d33abb0-51ab-67c4-50b3-ae95a5d9fb55@nvidia.com>
 <YyCVBVRQo+qPo5vH@matsya>
 <42ae1deb-bbdd-2a16-c671-0bc17d3e2647@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ae1deb-bbdd-2a16-c671-0bc17d3e2647@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 10:59, JC Kuo wrote:
> On 9/13/22 22:34, Vinod Koul wrote:
> > On 06-09-22, 10:43, JC Kuo wrote:

> > Thanks for this explanation... It helps!
> > 
> > Just a suggestion, can this be moved into phy_init() you have detected
> > connection in phy_power_on(), the transceiver can be enabled in
> > phy_int... Would that work?
> > That would work, too. However, because Tegra USB has separate phys for USB3 SS
> and USB2, I'd like to keep the USB2 phy operations as they are now, so that USB
> host and device controller drivers do not have to distinguish the phy type and
> invoke different phy stubs. Furthermore, PD_ZI=0 does really power on the USB2
> phy, partially.
> 
> For example:
> 1. in .probe(),
>     for_each_usb_phy {
>          phy_init(phy);
>     }
> 
>     for_each_usb3_phy {
>          phy_power_on(phy);
>     };
> 
> 2. upon detecting connection,
> 
>     phy_power_on(the_target_usb2_phy);

It should be always phy_init() in probe and once detection
phy_power_on()

that should be generic flow for all...

-- 
~Vinod
