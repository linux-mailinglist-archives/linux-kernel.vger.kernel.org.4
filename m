Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9B705ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjEPW5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjEPW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:57:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012B1A7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684277829; x=1715813829;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3XDD4m5d+o+lCx8J0eN+3I2dpLqKtUQvdlaP+TmByIo=;
  b=GsJTCoul2mrqFTLe2XVawMBYzn295CqX5Syy1pq0ZrhV4swbX6obN51X
   Z9TsElspFvzrHIPCqqC1MNBWiVTVUDLUeyaWhXTFzSoXwDmTIRLqUXQkp
   LwhOExrj4LQhk+bLoRlYMCCy0luL4zsqL2q9WSyIU4IIlhsCNkOhAA3NS
   uUtuFBXAGLGJHZJ7MktS4Qe10zDYgh2s+hcEdJKRbh9GJyr4yVjq6O9fK
   Bt95f+GuPb6yHO4Gy22VU5vFswDXC1QZiK4OD0kZH/H2sKyDMD5SoJXL5
   5tzMon84zWiy46iddqk1Twk150Zb5SfmWFTyJ9CGzZHWklv2e8SsFnpW3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="354781279"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="354781279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="652001920"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="652001920"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:57:08 -0700
Message-ID: <bcc218470b66bbeb96e20adcb27e768221f0668e.camel@linux.intel.com>
Subject: Re: MTD: Patch to spi-nor hangs Lenovo ThinkPad X1 on suspend,
 sleep, and shutdown.
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     miquel.raynal@bootlin.com, pratyush@kernel.org,
        tudor.ambarus@linaro.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 16 May 2023 15:57:08 -0700
In-Reply-To: <51293660791f4a5fbcf4d86abe548c11fc91722f.camel@linux.intel.com>
References: <51293660791f4a5fbcf4d86abe548c11fc91722f.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just sent out a fix patch for 6.4-rc2, let's move the discussion to
that mail:

[PATCH] MTD SPI-NOR: BUG FIX of divide by zero in new n_banks value
https://marc.info/?l=linux-kernel&m=168427739123254&w=2

On Tue, 2023-05-16 at 12:12 -0700, Todd Brandt wrote:
> This is the kernel bugzilla: 
> https://bugzilla.kernel.org/show_bug.cgi?id=217448
> 
> This is the system I'm having troubles with:
> 
> os-version              : Ubuntu 20.04.2 LTS
> baseboard-manufacturer  : LENOVO
> baseboard-product-name  : 20QA000FUS
> baseboard-serial-number : W1KS11R111D
> baseboard-version       : SDK0J40697 WIN
> bios-release-date       : 05/20/2021
> bios-vendor             : LENOVO
> bios-version            : N2MET49W (1.14 )
> chassis-manufacturer    : LENOVO
> chassis-serial-number   : R911Q4MM
> chassis-version         : None
> processor-manufacturer  : Intel(R) Corporation
> processor-version       : 11th Gen Intel(R) Core(TM) i7-1160G7 @
> 1.20GHz
> system-manufacturer     : LENOVO
> system-product-name     : 20QA000FUS
> system-serial-number    : R911Q4MM
> system-version          : ThinkPad X1 Titanium Gen 1
> cpucount                : 8
> memtotal                : 15939728 kB
> memfree                 : 8428028 kB
> 
> Ever since 6.4-rc1 this system has hung on every S3/S2idle suspend
> and
> shutdown during reboot. I've bisected it to a patch to the MTD: SPI-
> NOR 
> subsystem about introducing the "concept of a bank"
> 
> 9d6c5d64f0288a814d4435b7da39e360a4c39e40 is the first bad commit
> commit 9d6c5d64f0288a814d4435b7da39e360a4c39e40
> Author: Miquel Raynal <miquel.raynal@bootlin.com>
> Date:   Tue Mar 28 17:40:58 2023 +0200
> 
>     mtd: spi-nor: Introduce the concept of bank
> 
>     SPI NOR chips are made of pages, which gathered in small groups
> make
>     (erase) sectors. Sectors, gathered together, make banks inside
> the
>     chip. Until now, there was only one bank per device supported,
> but
> we
>     are about to introduce support for new chips featuring several
> banks (up
>     to 4 so far) where different operations may happen in parallel.
> 
>     Let's allow describing these additional bank parameters, and
> let's
> do
>     this independently of any other value (like the number of
> sectors)
> with
>     an absolute value.
> 
>     By default we consider that all chips have a single bank.
> 
>     Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>     Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>     Link: 
> 
https://lore.kernel.org/r/20230328154105.448540-2-miquel.raynal@bootlin.com
>     Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
>  drivers/mtd/spi-nor/core.c   |  1 +
>  drivers/mtd/spi-nor/core.h   | 16 +++++++++++-----
>  drivers/mtd/spi-nor/xilinx.c |  1 +
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> Basically something about the new code is improperly handling the
> memory size on this machine. It's not complex but I haven't dug any
> deeper since I want it posted as quickly as possible. To reproduce,
> run
> any of these 3 commands and the system will hang:
> 
> echo freeze > /sys/power/state
> echo mem > /sys/power/state
> sudo reboot

