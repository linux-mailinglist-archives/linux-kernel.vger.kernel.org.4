Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D45B9994
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIOL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIOL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:29:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD27C1E7;
        Thu, 15 Sep 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663241350; x=1694777350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oOITtVIsEkwDAZ3B7W7N8G7w1xIevx2FVYsHBs5ESYU=;
  b=eTgW18T+dEaDE4dFg9JZbbb6oOpb4Z0CBsiRs1gpx4LO5z1YkOMShqUb
   EyOOBlvbITnO77gsG3hYcrkWgSsU2e5LOjRM+bLdnsIfQ6jft38s4scXO
   Qf7OdVmOdmxn2tcXiRLnnb1P/hWV/94fuHqkGNcl03+1P3K7yp7njsdEb
   KynHk2DzySfda2BdmjO5pAk+zKcf5m4oxb2Ae1Zan86h//GrR355PJXlc
   ARdMPbx+4UUGfzVzGuLq4kJf21qQKJ5TK4xlKxJu5yS0InrI6xaujP8vO
   VK54Zv4vwTHF7U4GO56m7iuxO7CkKAXsPq6fSj8MIFNLPn3ocDB4TvwCd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="113816974"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 04:29:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 04:29:09 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 04:29:09 -0700
Date:   Thu, 15 Sep 2022 13:33:33 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220915113333.uwgazi6hoeskpeoi@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <CAHp75VfNjQTVjsjWNJ1oOGuovxt_=ZEZrEfTvj=-Ym9R_ZzPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VfNjQTVjsjWNJ1oOGuovxt_=ZEZrEfTvj=-Ym9R_ZzPoQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/09/2022 18:09, Andy Shevchenko wrote:
> 
> On Fri, Sep 9, 2022 at 5:55 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> 
> Thanks for an update, my comments below.

Thanks for all the help and sorry for late reply.

> 
> ...
> 
> > -       dev_set_drvdata(dev, info->map);
> > +       dev_set_drvdata(dev, info);
> 
> I would also change it to platform_set_drvdata() to keep symmetry with
> ->remove().

Yes, I will change this.

> 
> ...
> 
> > +static int ocelot_pinctrl_remove(struct platform_device *pdev)
> > +{
> > +       struct ocelot_pinctrl *info = platform_get_drvdata(pdev);
> 
> > +       destroy_workqueue(info->wq);
> 
> Is it a synchronous operation? Anyway, what does guarantee that after
> this no other task can schedule a new work due to unmasking an
> interrupt? I think you need to be sure your device is quiescent before
> killing that workqueue. Something like synchronize_irq() +
> disable_irq() or equivalent? (I don't know for sure, you need to
> investigate it yourself and find the best suitable way).

I have look at descriptions of the functions (synchronize_irq(),
disable_irq()) and I think is enough to use only disable_irq().
I also tried something but it didn't have the expected result so I would
need to look more into this. I tried to use disable_irq on returned irq
inside ocelot_gpiochip_register but I was still getting interrupts after
that.
Also I was thinking actually to use gpiochip_remove() here in
ocelot_pinctrl_remove() before calling destroy_workqueue(). But then I
might have problems inside ocelot_irq_work(). I need to check more this.

> 
> > +       return 0;
> > +}
> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
