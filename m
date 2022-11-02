Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A66160E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKBKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKBKfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:35:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3328E0D;
        Wed,  2 Nov 2022 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667385302; x=1698921302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cnMTJX1z5oF/MNXmXzDoIQqydCI7Jem3sz3HAcS6ejI=;
  b=yi+OAtnpgRRo/k9kwGY7fcaYrWv0jE+5rPjlHeQ9elrlnEnza4H+dU81
   9/1Kwhzr1u0h4nWJeKAl6l9pMHihSjEdkBHLnKlMzJsgwv148yw+rZ8Qi
   8VwmR8ezRT8ayWAPqSQPOnLBTHetcK3Vy5R4kL3nMN1eaXjPTtz8h/ngB
   xveU+/yxQUQ4PXNiYQLAOpac3zbgYEb84d1z7XtZU5gS3bscBgMKAlfqk
   xYBZLFa+Ee5jQilJI+V+9o0ikD7hWeLUSQm91cLdPsLJu19sD3BW6lSm3
   nROq9BNhEd+759lcrjefpaZ+HXrMtYv2/kk2epHS/k8cqL6FTMsF5Jitd
   g==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="184990970"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2022 03:35:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 2 Nov 2022 03:35:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 2 Nov 2022 03:34:58 -0700
Date:   Wed, 2 Nov 2022 10:34:43 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <palmer@dabbelt.com>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 0/6] RISC-V: stop selecting device drivers in Kconfig.socs
Message-ID: <Y2JHw/y1oWkLpOb2@wendy>
References: <20221005171348.167476-1-conor@kernel.org>
 <Y15nwXmn7rToJkH2@spud>
 <Y2IXrD4FpXNmDDPk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2IXrD4FpXNmDDPk@kroah.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:09:32AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Oct 30, 2022 at 12:02:09PM +0000, Conor Dooley wrote:
> > On Wed, Oct 05, 2022 at 06:13:43PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > As my RFC [0] series doing the symbol name changes has not yet reached
> > > consensus, I've split out the removal of device driver selects into a
> > > new series. I kept the plic as a direct select - although given how Maz
> > > is treating the SiFive plic driver as the RISC-V plic driver, maybe that
> > > should just be selected by default at an arch level...
> > > 
> > > I assume the individual patches can go via their subsystems & I'll
> > > resubmit the arch/riscv patches a cycle later? I'm not in any rush.
> > 
> > Hey,
> > 
> > What's the story here with the two serial patches, they just waiting for
> > an Ack? I think these are archived on the riscv patchwork, so if that is
> > the case I'll unarchive them and mark as needing one.
> 
> Sorry for the delay, I'll take both of them through the tty/serial tree.

nw Greg, thanks.

@Palmer, I'll re-submit the Kconfig.socs bits of this after v6.2-rc1.

Thanks,
Conor.



