Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD569BF46
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBSJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBSJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:03:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C84301117C;
        Sun, 19 Feb 2023 01:03:00 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pTfaz-0000LC-04; Sun, 19 Feb 2023 10:02:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9ADB6C28CF; Sun, 19 Feb 2023 10:02:48 +0100 (CET)
Date:   Sun, 19 Feb 2023 10:02:48 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Message-ID: <20230219090248.GE2924@alpha.franken.de>
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
 <20230205161929.GD4459@alpha.franken.de>
 <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
 <20230217173708.GA14134@alpha.franken.de>
 <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:27:05PM +0100, Olliver Schinagl wrote:
> It is the Realtek series of SoC, specifically in my case, the RTL9302b,
> which doesn't have a PCI peripherial, at all :) Nor configured in the
> devicetree, but of course generic_mips_kernel enables the drivers, which
> should be noop. I don't see anything related to PCI during boot.
> 
> Having said that, the RTL930x series take their heritage from the RTL819x
> (and probably older) wifi SoC series from realtek, which did contain a PCIe
> peripherial, as that is where the (external) wifi chip was connected too.

I see, and you want to use the already existing wifi driver ?

> > Do you have a programmers manual for it,
> > which contains details about the PCI bridge ?
> 
> If only. There are some (leaked) datasheets, that do contain the PCI
> registers, mostly (obviously) the rtl819x datasheets. https://github.com/libc0607/Realtek_switch_hacking/blob/files/REALTEK-RTL8196E.pdf
> is one such example that contains the PCIe registers.

that's just the PCIe PHY part, but not the localbus<->PCIe bridge
part. But if the wifi part of ypur SOC is directly connected to
the localbus, having the some PCI register won't help anyway.
I am afraid you need to go the route via extra Kconfig section.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
