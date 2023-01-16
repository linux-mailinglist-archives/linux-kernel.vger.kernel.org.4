Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE266CBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjAPRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjAPRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:15:28 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18A52BEE4;
        Mon, 16 Jan 2023 08:56:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C0C1A8108;
        Mon, 16 Jan 2023 16:56:25 +0000 (UTC)
Date:   Mon, 16 Jan 2023 18:56:24 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Adam Ford <aford173@gmail.com>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <Y8WBuKt6mw6TN1Cp@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
 <Y8VkjQ2yZQssx/wJ@atomide.com>
 <20230116173922.585904bf@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116173922.585904bf@aktux>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230116 16:39]:
> On Mon, 16 Jan 2023 16:51:57 +0200
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi,
> > 
> > * Adam Ford <aford173@gmail.com> [230116 14:16]:
> > > Would it make sense to make this default in the omap3.dtsi file and
> > > enable them in the individual boards that need it?  
> > 
> > In general disabling the unused devices by default for omaps will break
> > the power management. The disabled devices are completely ignored by the
> > kernel, and the devices are left to whatever the bootloader state might
> > be.
> > 
> hmm, shouldn't ti-sysc keep things disabled in most cases? It is still a bit
> known because there is no status = "disabled" in the target-module@xxx node.

Oh right, if the child device is tagged disabled (instead of the the parent
ti-sysc tagged disabled) the module should get idled just fine as long as the
module related quirks are implemented for ti-sysc.c.

But still, I'd rather not start tagging devices disabled by default and then
re-enabling everywhere since we never needed it before. It just adds a lot
of pointless status tinkering, see commit 12afc0cf8121 ("ARM: dts: Drop
pointless status changing for am3 musb").

So considering things, IMO it's best to set only the child device with
status disabled, and set it at the board specific dts file in this case.

Also note that the dma channels could be freed with /delete-property/ at the
board specific dts file even for devices that are usable if not really
needed.

Regards,

Tony

