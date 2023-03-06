Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2A6ACEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCFUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCFUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:13:09 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4255B9;
        Mon,  6 Mar 2023 12:12:57 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7A1975FD0A;
        Mon,  6 Mar 2023 23:12:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678133575;
        bh=7YzJ4n0LkJWTv0y1sIUu/5QnS+qJKq/YOM7rUrZOA3w=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=C151YZQdAz0Bz88TQsdKRRQ0Bf6gR1nZebxKGqwlCIMWMryZvEOVrlcAyu/0kWtsQ
         KWVpxd1sSKOhnwz/IaeHXJXrUcSd5+QZppEzlnJwX0LZBd9fMtrutXtjkgFfVERjNt
         WzFe0t5sQi2qzyRbpTYKNTPFiuB0eOGqv5tFrSGXzofGmLGpTGUm69+131FsJ+5iIS
         kefGqyvq33eeK4KbSlGSFX26UVjFxpJEOsrVvWT19vVdjiZt5wO6RCF70Vl4I6UXDQ
         r444maPrAip2nDeqAzyk1lXJb3Tcz16Ra5BOAOIWZSwhs/q63JXqqXYFK8r0Ax1vs4
         5UsF+GcdIcCug==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  6 Mar 2023 23:12:55 +0300 (MSK)
Date:   Mon, 6 Mar 2023 23:12:54 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 1/5] clk: meson: add support for A1 PLL clock ops
Message-ID: <20230306201254.tgyfztzqukzzeaqi@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-2-ddrokosov@sberdevices.ru>
 <1jy1oab06v.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jy1oab06v.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/06 16:19:00 #20919562
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:09:35PM +0100, Jerome Brunet wrote:
> 
> On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > From: Jian Hu <jian.hu@amlogic.com>
> >
> > Modern meson PLL IPs are a little bit different from early known PLLs.
> > The main difference is located in the init/enable/disable sequences; the
> > rate logic is the same.
> 
> For the record, I find very odd that PLLs used to have an 'rst' bit in
> CTRL0:29 (see g12 for example), this bit goes un-documented in the a1
> datasheet, and following SoCs like s4 still have a rst bit, still in
> CTRL0:29
> 
> I would not be surpized if the rst is actually still there in the a1.
> It is just my guess ...
> 

We don't know it for sure. Datasheet doesn't have any information about
CTRL0:29 bit, CTRL0:28 (enable) bit is last one I see.
Vendor Amlogic driver doesn't have it in the init sequence as well.
BTW, vendor driver doesn't use clk_pll common logic, it achieves PLL
power-on goals using init_regs sequence.

> > Compared with the previous SoCs, self-adaption current module
> > is newly added for A1, and there is no reset parameter except the
> > fixed pll. In A1 PLL, the PLL enable sequence is different, using
> > the new power-on sequence to enable the PLL.
> 
> Please split this patch:
> #1 make the rst optional (if you must)
> #2 add the self current adapt param.
> 
> Apart from this, it looks good
> 

Thank you, I'll split it in the next version!

[...]
-- 
Thank you,
Dmitry
