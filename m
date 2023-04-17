Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0446E46C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDQLuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDQLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:50:14 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B365AF;
        Mon, 17 Apr 2023 04:49:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 18A545FD28;
        Mon, 17 Apr 2023 14:47:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681732061;
        bh=UFOQ7zl15XBdCKDP1PBa7gWSCuhGytq2kMbaG0PLdoc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=l3oCzl5MJATaLtjposS07ZcWREmdW4Z4JqkdE5ALl7zbPpEgBtFlhtj8kWx6ooy7O
         IasWd1VK1kgPIueM2Od6VLJWmA7IvsvEaZ/z/AA8uMBCcJKV4ZpmYKXKmgdrXcSZaD
         /dLFxE4K784BXu0cOxqOU/CKULHj7FC48gpyuaYalocdi/HCjehD36QZ6qpYwzav+I
         WB9I9KJuZaNn4hYCCSR3gdqmg5vf4gEnCo0/muMQJo/mOupgs6RqQIXVYh7fPBfgjw
         b001/EpgNTtDPcUvqqppiw2o+bQLDrWf45kA7DyN3Wn39hy0cpO5EQ0Ijdf5DI9RPz
         4w+nL9GaUb/Cw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 17 Apr 2023 14:47:39 +0300 (MSK)
Date:   Mon, 17 Apr 2023 14:47:39 +0300
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
Subject: Re: [PATCH v1 4/5] usb: dwc3-meson-g12a: support OTG switch
Message-ID: <20230417114739.r7aoiodqybalbn4o@CAB-WSD-L081021>
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
 <20230414152423.19842-5-ddrokosov@sberdevices.ru>
 <CAFBinCDyUBWd-V0mDy_edzH=3JM5SAuX=vtT4MG9Fb62Rcv=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCDyUBWd-V0mDy_edzH=3JM5SAuX=vtT4MG9Fb62Rcv=mA@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
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

Hello Martin,

Thank you for quick review, appreciate it!
Please find my comments below and in the other replies.

On Sun, Apr 16, 2023 at 10:56:36PM +0200, Martin Blumenstingl wrote:
> On Fri, Apr 14, 2023 at 5:24 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> >  static const struct dwc3_meson_g12a_drvdata a1_drvdata = {
> > -       .otg_switch_supported = false,
> > +       .otg_switch_supported = true,
> it would be great if you could also follow up with a patch that
> removes otg_switch_supported.
> A1 was the only variant that needed it and after this patch it's just dead code.

It makes sense. I thought about it before sending the first version, but
I found a counter-argument: future SoCs may use this parameter.
But if you ask, I will remove 'otg_switch_supported' in the next version

-- 
Thank you,
Dmitry
