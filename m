Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5786E47BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDQM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:29:59 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA7CE5B;
        Mon, 17 Apr 2023 05:29:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B6A735FD1F;
        Mon, 17 Apr 2023 15:29:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681734594;
        bh=jvK4cXeO8Jj4+6kMoLy/DP4MK+U8SvFogPOaVUzPgzM=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=eDdQtACxFXEqW9lv0/TbVuemLFGr05aN/2rtSitOukENevq2YpZU1eJIDGIUzC3op
         IpM60h1IZiEXMQsxT+Lype5cB1mZa2XUi7KJBeTaUltlibH1bZmx9qPU+yR54J0Nv2
         gHeV002pL93tMlt6tfVHZPlsXqxDyhDcrrOTooj2H1bU+pOdjNDCl9PJbN2pF1hf7U
         Df7myAOXL2YSMclFwSiu3k2Zy7VTy6xO5aTH3NhaHqSE+ydMDNx42kww5CgHFVbf60
         kTSRCd10xUeAsFYOboT8GI9umuSD9aXbt7yNaVsr9qWokp1G2cROb58jVVwW3czh5D
         lj2Qe3T++gS9A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 17 Apr 2023 15:29:53 +0300 (MSK)
Date:   Mon, 17 Apr 2023 15:29:52 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>, <yue.wang@amlogic.com>,
        <hanjie.lin@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v1 4/5] usb: dwc3-meson-g12a: support OTG switch
Message-ID: <20230417122952.s6ag2mtc7exdbr4n@CAB-WSD-L081021>
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
 <20230414152423.19842-5-ddrokosov@sberdevices.ru>
 <CAFBinCDyUBWd-V0mDy_edzH=3JM5SAuX=vtT4MG9Fb62Rcv=mA@mail.gmail.com>
 <20230417114739.r7aoiodqybalbn4o@CAB-WSD-L081021>
 <3381d124-1049-16da-bcdb-1cbbec379154@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3381d124-1049-16da-bcdb-1cbbec379154@linaro.org>
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

Hello Neil,

Thank you for review, appreciate it!

On Mon, Apr 17, 2023 at 02:22:26PM +0200, neil.armstrong@linaro.org wrote:
> On 17/04/2023 13:47, Dmitry Rokosov wrote:
> > Hello Martin,
> > 
> > Thank you for quick review, appreciate it!
> > Please find my comments below and in the other replies.
> > 
> > On Sun, Apr 16, 2023 at 10:56:36PM +0200, Martin Blumenstingl wrote:
> > > On Fri, Apr 14, 2023 at 5:24 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> > > [...]
> > > >   static const struct dwc3_meson_g12a_drvdata a1_drvdata = {
> > > > -       .otg_switch_supported = false,
> > > > +       .otg_switch_supported = true,
> > > it would be great if you could also follow up with a patch that
> > > removes otg_switch_supported.
> > > A1 was the only variant that needed it and after this patch it's just dead code.
> > 
> > It makes sense. I thought about it before sending the first version, but
> > I found a counter-argument: future SoCs may use this parameter.
> > But if you ask, I will remove 'otg_switch_supported' in the next version
> > 
> 
> Please remove it, it's easy to add it again if needed.

Sure, no problem. It will be removed in the next version.

-- 
Thank you,
Dmitry
