Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4536C9D53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjC0INo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjC0IN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:13:29 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F40C449CA;
        Mon, 27 Mar 2023 01:13:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4411C8108;
        Mon, 27 Mar 2023 08:13:28 +0000 (UTC)
Date:   Mon, 27 Mar 2023 11:13:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, aford173@gmail.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <20230327081327.GE7501@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113211151.2314874-1-andreas@kemnade.info>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230113 23:12]:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> OMAP processors support 32 channels but there is no check or
> inspect this except booting a device and looking at dmesg reports
> of not available channels.
> 
> Recently some more subsystems with DMA (aes1+2) were added filling
> the list of dma channels beyond the limit of 32 (even if other
> parameters indicate 96 or 128 channels). This leads to random
> subsystem failures i(e.g. mcbsp for audio) after boot or boot
> messages that DMA can not be initialized.
> 
> Another symptom is that
> 
> /sys/kernel/debug/dmaengine/summary
> 
> has 32 entries and does not show all required channels.
> 
> Fix by disabling unused (on the GTA04 hardware) mcspi1...4.
> Each SPI channel allocates 4 DMA channels rapidly filling
> the available ones.
> 
> Disabling unused SPI modules on the OMAP3 SoC may also save
> some energy (has not been checked).

Applying this into omap-for-v6.4/dt based on what we discussed
in this thread earlier.

Thanks,

Tony
