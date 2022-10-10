Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD45F97BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJJFTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJJFTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C396152
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 22:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC3D60D14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54BC433C1;
        Mon, 10 Oct 2022 05:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665379179;
        bh=HaGmHno5erThB6Bn0fYha6MKL7fBwTI32d41TKkMykY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rx0Ath96VHMbEDYGaqMT2zQ13EDipPadTQEx2jmANH0z+EqDnRXyJ5jCfUSQR39l4
         hM2hAOgxZJxZVGzZCm2vfqJ40g4iZNSTl5F/8KKsaaz8oaOrhwNbIOI+0nNr3O8uZm
         CxUZagacTpkavKoBpguBEz+13vr8LprmR7bbCW7KHKJrVnhd/yi3p7V7oHJ4ZpK4wI
         PpQLeOF5EYovk6x67XoPzeZ9ao/LHq8wXeWZ7IzoSzZooEOUnoKq3En7fPal+bxmWB
         n57dJTtkCirZRO8b4/JdSGJQcC+z4mpAllzBL/FSZOndJPt0NyoL/pFejO5BEj15Dy
         MIJE0rBJWSUBQ==
Date:   Mon, 10 Oct 2022 10:49:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Reset COMPHY
 registers before USB 3.0 power on
Message-ID: <Y0OrZ8d4GBC0Cp8q@matsya>
References: <20220920121154.30115-1-pali@kernel.org>
 <20220921050300.riwyofdncxscrwe3@shindev>
 <20220921080557.jdg5wywpa5qxcyo2@pali>
 <Yy6uaaZUbZsBSqrw@matsya>
 <20220924083127.oht57ivvsr4obrjr@pali>
 <20220930234541.hsf6ryketcdukpia@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930234541.hsf6ryketcdukpia@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-22, 01:45, Pali Rohár wrote:
> On Saturday 24 September 2022 10:31:27 Pali Rohár wrote:
> > On Saturday 24 September 2022 12:44:49 Vinod Koul wrote:
> > > On 21-09-22, 10:05, Pali Rohár wrote:
> > > > On Wednesday 21 September 2022 05:03:01 Shinichiro Kawasaki wrote:
> > > > > On Sep 20, 2022 / 14:11, Pali Rohár wrote:
> > > > > > Turris MOX board with older ARM Trusted Firmware version v1.5 is not able
> > > > > > to detect any USB 3.0 device connected to USB-A port on Mox-A module after
> > > > > > commit 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken
> > > > > > reset support"). On the other hand USB 2.0 devices connected to the same
> > > > > > USB-A port are working fine.
> > > > > > 
> > > > > > It looks as if the older firmware configures COMPHY registers for USB 3.0
> > > > > > somehow incompatibly for kernel driver. Experiments show that resetting
> > > > > > COMPHY registers via setting SFT_RST auto-clearing bit in COMPHY_SFT_RESET
> > > > > > register fixes this issue.
> > > > > > 
> > > > > > Reset the COMPHY in mvebu_a3700_comphy_usb3_power_on() function as a first
> > > > > > step after selecting COMPHY lane and USB 3.0 function. With this change
> > > > > > Turris MOX board can successfully detect USB 3.0 devices again.
> > > > > > 
> > > > > > Before the above mentioned commit this reset was implemented in PHY reset
> > > > > > method, so this is the reason why there was no issue with older firmware
> > > > > > version then.
> > > > > > 
> > > > > > Fixes: 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support")
> > > > > > Reported-by: Marek Behún <kabel@kernel.org>
> > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > ---
> > > > > > Shinichiro, could you please check that all USB functionality still
> > > > > > works correctly on your board?
> > > > > > ---
> > > > > 
> > > > > Sure. TL;DR, this patch works ok for my espressobin v7 board.
> > > > > 
> > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > 
> > > > > I prepared base kernel v5.19.10 applying the commit 0a6fc70d76bd. Regardless
> > > > > whether this fix patch for Turrix MOX board is applied or not, two USB ports on
> > > > > my esprssobin v7 board worked as expected. I confirmed it by using USB thumb
> > > > > drive. The drive was detected and its partition was mounted successfully using
> > > > > either of the two USB ports.
> > > > 
> > > > Thank you for testing! Anyway, please check that USB 3.0 device is
> > > > working fine. Because as I wrote in commit message, on Turris Mox was
> > > > USB 2.0 device working fine, but USB 3.0 not. And maybe check in system
> > > 
> > > update the log now?
> > 
> > What do you want to update?
> 
> Vinod, could you describe a bit more what is needed to update? Because
> this patch fixes regression - USB 3.0 support on Turris Mox board.

Sorry to have missed this...

Somehow I misunderstood that the USB 3.0 was not working and log needs
update... I will apply this once merge window closes

-- 
~Vinod
