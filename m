Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1EE6EE05A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjDYK3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjDYK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:29:51 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02DB5257;
        Tue, 25 Apr 2023 03:29:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C33525FD3A;
        Tue, 25 Apr 2023 13:29:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682418556;
        bh=7hJUvsqyjWvVw7Khab8QmwY8D6Cfdc1hwURLPhG6nao=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=R8pi8/0owL2UIrCSxT7v/uznrT6w4UND+ouhHulfzffi8K9KU7C0DQcQhAhVmfAUO
         bHj8WqBB6H3BW1VsgjG3heM0vG131VbHEWGjsGvYd6WiRfhLDQC+BjixfJoQWUJeiz
         ROjtBRLmM6MkBYX2seBbll/WzJT3znwgbP3HS2VrCZQ5nh/kBIi7sdABi4Fqda4bgR
         7INi08hXNI89fs09g1mxsJ/25OH3jp7k2WWjMjIm5VGQsmkI1P6sBaNM8CrPG8UyB8
         lnkB6hSsKBEYNlxyImd8z94Jdf+255FWgkHqsDP4ABG6+1fWhF2DEYPaq3rK9kj7H1
         e1HLqiXav4S0Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Apr 2023 13:29:12 +0300 (MSK)
Date:   Tue, 25 Apr 2023 13:29:12 +0300
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
Subject: Re: [PATCH v2 1/5] phy: amlogic: enable/disable clkin during Amlogic
 USB PHY init/exit
Message-ID: <20230425102912.qhey7fpbuqvwg44j@CAB-WSD-L081021>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
 <20230418111612.19479-2-ddrokosov@sberdevices.ru>
 <CAFBinCDyhBQ5Nob38EmXor1PtcO09dRdReDTW+tc5CN4i20HhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCDyhBQ5Nob38EmXor1PtcO09dRdReDTW+tc5CN4i20HhA@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/25 07:55:00 #21159618
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

Thanks a lot for the review! Appreciate it!
Please find my comments below.

On Sun, Apr 23, 2023 at 07:42:25PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> On Tue, Apr 18, 2023 at 1:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > Previously, all Amlogic boards used the XTAL clock as the default board
> > clock for the USB PHY input, so there was no need to enable it.
> > However, with the introduction of new Amlogic SoCs like the A1 family,
> > the USB PHY now uses a gated clock. Hence, it is necessary to enable
> > this gated clock during the PHY initialization sequence, or disable it
> > during the PHY exit, as appropriate.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > index 9d1efa0d9394..80938751da4f 100644
> > --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > @@ -172,10 +172,16 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
> >         int ret;
> >         unsigned int value;
> >
> > -       ret = reset_control_reset(priv->reset);
> > +       ret = clk_prepare_enable(priv->clk);
> >         if (ret)
> >                 return ret;
> >
> > +       ret = reset_control_reset(priv->reset);
> > +       if (ret) {
> > +               clk_disable_unprepare(priv->clk);
> > +               return ret;
> > +       }
> > +
> This part looks good. You asked why I suggested this approach instead
> of enabling the clock at probe time and only now I have time to reply
> to it.
> Consider the following scenario:
> - modprobe phy-meson-g12a-usb2
> - modprobe dwc3-meson-g12a (this will call phy_init)
> - rmmod dwc3-meson-g12a (this will call phy_exit)
> 
> If the clock was enabled at probe time then it would only be disabled
> when using rmmod phy-meson-g12a-usb2.
> By manually calling clk_prepare_enable/clk_disable_unprepare we ensure
> that the clock gets disabled when we don't need the PHY anymore.
> Whether this makes any difference in terms of power draw: I can't say.
> 

It makes sense. I fully agree with your approach, which looks better
compared to using the automatic devm_clk API.

> >         udelay(RESET_COMPLETE_TIME);
> >
> >         /* usb2_otg_aca_en == 0 */
> > @@ -277,8 +283,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
> >  static int phy_meson_g12a_usb2_exit(struct phy *phy)
> >  {
> >         struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> > +       int ret = reset_control_reset(priv->reset);
> > +
> > +       clk_disable_unprepare(priv->clk);
> >
> > -       return reset_control_reset(priv->reset);
> > +       return ret;
> I think this can cause issues in case when reset_control_reset returns
> an error: If I understand the code in phy-core.c correctly it will
> only decrease the init ref-count if exit returns 0.
> Whenever phy_exit is called for the second time
> clk_disable_unprepare() will be called with a clock ref-count of 0, so
> it'll likely print some warning.
> 
> My suggestion is to return early if reset_control_reset() fails and
> not call clk_disable_unprepare() in that case.
> What do you think?

After taking a closer look at the phy_exit core code, it appears that
your idea is spot on. Exiting immediately when reset fails seems like
the better choice.
I will work on a new version of the code accordingly.

-- 
Thank you,
Dmitry
