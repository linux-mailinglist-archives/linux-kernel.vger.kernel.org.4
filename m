Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAD66CC35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjAPRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjAPRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:22:36 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 449CE36FE9;
        Mon, 16 Jan 2023 09:00:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AB5638108;
        Mon, 16 Jan 2023 17:00:31 +0000 (UTC)
Date:   Mon, 16 Jan 2023 19:00:30 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <Y8WCrkrOA8w/1KGp@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
 <Y8VkjQ2yZQssx/wJ@atomide.com>
 <4EFDE2C4-0BBB-4804-AA46-C40EB0D97AC4@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EFDE2C4-0BBB-4804-AA46-C40EB0D97AC4@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [230116 15:29]:
> Hi,
> 
> > Am 16.01.2023 um 15:51 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > Hi,
> > 
> > * Adam Ford <aford173@gmail.com> [230116 14:16]:
> >> Would it make sense to make this default in the omap3.dtsi file and
> >> enable them in the individual boards that need it?
> > 
> > In general disabling the unused devices by default for omaps will break
> > the power management. The disabled devices are completely ignored by the
> > kernel, and the devices are left to whatever the bootloader state might
> > be.
> 
> Yes, indeed.

See my further clarification based on what Adam commented too, I was
thinking status = "disabled" at the ti-sysc parent level.

> > For SoCs using firmware to manage devices it's a bit different story
> > however. The firmware can still idle disabled devices based on a
> > late_initcall for example, even if the kernel knows nothing about the
> > disabled devices.
> 
> But how can we then handle all devices being "okay" by default and
> eating up more dma channels than are available?

1. Set the child device (not the ti-sysc node) with status = "disabled"
   in the board specific file as needed

2. Use /delete-property/ for dma channels in the board specific file
   if the device is in use but does not need dma

3. Or if this is a generic problem, we could disable dma by default for
   some devices

> We can't put all under power management AND dma by default.
> 
> Or can dma channel usage be postponed until the device is really used?

Sure.

Regards,

Tony
