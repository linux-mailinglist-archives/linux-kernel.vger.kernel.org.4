Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB36F0CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjD0UGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjD0UGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:06:21 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 13:06:19 PDT
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782932D74;
        Thu, 27 Apr 2023 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Qi4Ky9bHoQupBknSueBNjMmFnel/nlUG0MuoAvTepic=; b=X08Kv91mrUTH7bTUkTtL2mdJB+
        7xScUhy7JtNjqms3IHnqX6A8ljNdSxuOtlORC90lmpwouAdphNBj23xdPSWMTqJ9t8KE3ikPiVJVo
        nKI1N7jVFBRUalq3HLDoj59MzcFKAGLHNwLge8psKa+ACPw+2/2zf8z/46DWRlAIkA4g=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:47152 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ps7sX-0002qM-1i; Thu, 27 Apr 2023 16:06:10 -0400
Date:   Thu, 27 Apr 2023 16:06:08 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230427160608.f051241d750404939296f60d@hugovil.com>
In-Reply-To: <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
References: <20230427195538.2718661-1-hugo@hugovil.com>
        <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 17:00:41 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Hugo,
> 
> On Thu, Apr 27, 2023 at 4:56 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > While testing the ethernet interface on a symphony carrier
> > board using an imx8mn SOM with an onboard PHY (EC hardware
> > configuration), the ethernet PHY is not detected.
> >
> > The device tree in Variscite custom linux git repository uses the
> > following property:
> >
> >     phy-reset-post-delay = <20>;
> >
> > Add a new property 'reset-deassert-us' of 20ms to have the same delay
> > inside the ethphy handle.
> 
> Which Ethernet PHY does this board use?
> 
> What does its datasheet recommend?

Hi Fabio,
it uses a ADIN1300 PHY.

The datasheet indicate that the "Management interface active (t4)" state is reached at most 5ms after the reset signal is deasserted.

Hugo.

-- 
Hugo Villeneuve <hugo@hugovil.com>
