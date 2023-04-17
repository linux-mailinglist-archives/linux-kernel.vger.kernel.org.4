Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37CF6E474E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDQMNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDQMNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:13:18 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4F4499;
        Mon, 17 Apr 2023 05:12:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 70C3B5FD28;
        Mon, 17 Apr 2023 14:57:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681732628;
        bh=iw1ARucM/xufZ3PIY5MlxUVdgnsDiUvAkRlREVNWQsw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=bsIliiOemS+7Us65TsC1UYc2EnsgwRkpA1vS5+MdbvaNpSsOdTZ+uwjQVnrH6WrFX
         gwdAzfZJBsFlXxbAW3xS3EuUh5HSqrPu9GqrQtubQ16fqCkgYrJxn1qtX5d+jgbskl
         jHKdMkpJTHa9rqCEb7eMmxUbkrg2wdw6+V0so9+rndyj0okTIy6FzNVBEvQAhzdFTU
         DguPVJtO3RSNDltSr/K+qEYjmtMZKeCdyxL8QoZZkPGAKUaKHxpp0HUV/aeHqEOJbf
         1y/cE+PEYfYctE9X+zywjYa4eHYv+c65/swsh+NcMW6VzSi0ljchvhDzNqQgEdC5AB
         epGeyRW58N/LQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 17 Apr 2023 14:57:07 +0300 (MSK)
Date:   Mon, 17 Apr 2023 14:57:07 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <hminas@synopsys.com>, <Thinh.Nguyen@synopsys.com>,
        <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v1 1/5] phy: amlogic: during USB PHY clkin obtaining,
 enable it
Message-ID: <20230417115707.p5btzzg4rlyzf7ni@CAB-WSD-L081021>
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
 <20230414152423.19842-2-ddrokosov@sberdevices.ru>
 <CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/17 09:07:00 #21118574
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:54:17PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> On Fri, Apr 14, 2023 at 5:24 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > -       priv->clk = devm_clk_get(dev, "xtal");
> > +       priv->clk = devm_clk_get_enabled(dev, "xtal");
> Generally this works fine but I wouldn't recommend this approach if:
> - there's some required wait time after the clock has been enabled
> (see phy_meson_g12a_usb2_init - there's already some required wait
> time after triggering the reset)
> - clock gating (for power saving) is needed when the dwc3 driver is
> unloaded by the PHY driver is not
> 
> In this case: just manually manage the clock in phy_meson_g12a_usb2_{init,exit}

I'm sorry, but I'm not fully understanding your point. Currently, no
sleeps are required for this clock and we don't have any logic for
power saving (g12a phy_ops doesn't have power_on()/power_off()
implementation).
However, I believe all of your arguments make sense for the future
development of the phy_meson_g12a_usb2 driver. Is that correct?

-- 
Thank you,
Dmitry
