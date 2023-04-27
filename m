Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D46F03EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbjD0KHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbjD0KHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D11FC0;
        Thu, 27 Apr 2023 03:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21610633E7;
        Thu, 27 Apr 2023 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF70C433EF;
        Thu, 27 Apr 2023 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682590022;
        bh=NpPUxdiGmbPhMzPhGolYoqA+iiu2qAbTIUmG3IlvkBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uopaMlnxAadrlJeOvUyXERVtGXrAzEIpeMldv/tk06iMcNE7F3/hWfRj+Ca/EUtXb
         YdUsi6lCe8viviR8eAZm5/Mnv2f3WZ1wmXnrniXiesePc/22nBQmZe6vdlGPiPjsH1
         jZssnpP9l4KgpFNHBQeeMoM6ebmwHpWYxqoDMsDOgYwByzaBkJALj6i+dGbH2Inby6
         pgWeOqazPR8GxI6JJUoI64n6zcMvKDj9OajMirX+Bb3VrtSvPa5zWdkv1PY/PKjulx
         7nNWEq7qTf2PJpukuqRlk21euEUCxN1l/ctfm6C/5c2AhQJqLMSS6gvez1G09U6EMk
         j8aceljwHzt7A==
Date:   Thu, 27 Apr 2023 11:06:57 +0100
From:   Will Deacon <will@kernel.org>
To:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Message-ID: <20230427100656.GA10855@willie-the-truck>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx>
 <AS1PR10MB5675F26ADC112F008B52F195EB6A9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR10MB5675F26ADC112F008B52F195EB6A9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 09:38:59AM +0000, Bouska, Zdenek wrote:
> > Why is this interrupt handling specific? Just because it's the place
> > where you observed it?
> Yes.
> 
> > So if that helps, then this needs to be addressed globaly and not with
> > some crude hack in the interrupt handling code.
> I just wrote, what helps for me. I didn't mean it as a proposal for merge.
> Sorry for confusion.
> 
> I tried using Will's cpu_relax() implementation [1] everywhere but I was not 
> successful with that yet. ARM64's VDSO makes it complicating and even
> if I left original cpu_relax() just in VDSO, Linux did not boot for me.

It definitely seemed to work when I posted it all those years ago, but I'm
not surprised if it needs some TLC to revive it on more recent kernels.

Will
