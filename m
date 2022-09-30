Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50F5F16D1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiI3XqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiI3Xpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987577FF9E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52B76B82A72
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0494C433D6;
        Fri, 30 Sep 2022 23:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664581545;
        bh=VIeRlxu7gqZyslh9p93xBVwDRcF0wlz+dNT2nGCJ1vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbimAoLNk/8KE9Dm4mYlBgG+0/rmEiKuIgH3+raELnMECUGvOT4KuR/8Qj/cYaHks
         8Rr+Tq25VPl/N3ZH1WuKCJ46U1/XGYmSZpul5tRIxSJzk4DREUJi4liZGgkpmIrArB
         soJBORyXYW3yFaRf/TJmgKOnz7u2ywGGXjuDs4k32Dul0OG0l7pTzML+XzOmErm6iw
         RWhiO4KZKNeX52jeUuCpe6XsSUIdm4fqHxbr3bZZslSNOnhKXdTklS+Bzm4VC/D6dO
         i3hfULItFcjIu+QCZmiTVUwH+1LBl2m0QU+FHiaP+DJ3EZrgBmlDYMFsEz6+p6JNsh
         xzrbIeKqX950w==
Received: by pali.im (Postfix)
        id DABBE93F; Sat,  1 Oct 2022 01:45:41 +0200 (CEST)
Date:   Sat, 1 Oct 2022 01:45:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Reset COMPHY
 registers before USB 3.0 power on
Message-ID: <20220930234541.hsf6ryketcdukpia@pali>
References: <20220920121154.30115-1-pali@kernel.org>
 <20220921050300.riwyofdncxscrwe3@shindev>
 <20220921080557.jdg5wywpa5qxcyo2@pali>
 <Yy6uaaZUbZsBSqrw@matsya>
 <20220924083127.oht57ivvsr4obrjr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924083127.oht57ivvsr4obrjr@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 September 2022 10:31:27 Pali Rohár wrote:
> On Saturday 24 September 2022 12:44:49 Vinod Koul wrote:
> > On 21-09-22, 10:05, Pali Rohár wrote:
> > > On Wednesday 21 September 2022 05:03:01 Shinichiro Kawasaki wrote:
> > > > On Sep 20, 2022 / 14:11, Pali Rohár wrote:
> > > > > Turris MOX board with older ARM Trusted Firmware version v1.5 is not able
> > > > > to detect any USB 3.0 device connected to USB-A port on Mox-A module after
> > > > > commit 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken
> > > > > reset support"). On the other hand USB 2.0 devices connected to the same
> > > > > USB-A port are working fine.
> > > > > 
> > > > > It looks as if the older firmware configures COMPHY registers for USB 3.0
> > > > > somehow incompatibly for kernel driver. Experiments show that resetting
> > > > > COMPHY registers via setting SFT_RST auto-clearing bit in COMPHY_SFT_RESET
> > > > > register fixes this issue.
> > > > > 
> > > > > Reset the COMPHY in mvebu_a3700_comphy_usb3_power_on() function as a first
> > > > > step after selecting COMPHY lane and USB 3.0 function. With this change
> > > > > Turris MOX board can successfully detect USB 3.0 devices again.
> > > > > 
> > > > > Before the above mentioned commit this reset was implemented in PHY reset
> > > > > method, so this is the reason why there was no issue with older firmware
> > > > > version then.
> > > > > 
> > > > > Fixes: 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support")
> > > > > Reported-by: Marek Behún <kabel@kernel.org>
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > > Shinichiro, could you please check that all USB functionality still
> > > > > works correctly on your board?
> > > > > ---
> > > > 
> > > > Sure. TL;DR, this patch works ok for my espressobin v7 board.
> > > > 
> > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > 
> > > > I prepared base kernel v5.19.10 applying the commit 0a6fc70d76bd. Regardless
> > > > whether this fix patch for Turrix MOX board is applied or not, two USB ports on
> > > > my esprssobin v7 board worked as expected. I confirmed it by using USB thumb
> > > > drive. The drive was detected and its partition was mounted successfully using
> > > > either of the two USB ports.
> > > 
> > > Thank you for testing! Anyway, please check that USB 3.0 device is
> > > working fine. Because as I wrote in commit message, on Turris Mox was
> > > USB 2.0 device working fine, but USB 3.0 not. And maybe check in system
> > 
> > update the log now?
> 
> What do you want to update?

Vinod, could you describe a bit more what is needed to update? Because
this patch fixes regression - USB 3.0 support on Turris Mox board.

> > > (lsusb) that USB 3.0 device was really detected as USB 3.0 because USB
> > > 3.0 devices have supported also fallback USB 2.0/1.x legacy mode.
> > > 
> > > > I also confirmed SATA port is ok (my SSD card was detected without error
> > > > message) and three network ports works ok ("Link is Up" message on network cable
> > > > connection). I did same confirmations with the latest firmware (TF-A and U-boot)
> > > > and old firmware (with version date in 2017). All looks good for me.
> > > > 
> > > > -- 
> > > > Shin'ichiro Kawasaki
> > 
> > -- 
> > ~Vinod
