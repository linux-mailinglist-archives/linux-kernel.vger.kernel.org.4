Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8A72F8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbjFNJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbjFNJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:19:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CA1FC3;
        Wed, 14 Jun 2023 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686734383; x=1718270383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0XZw+j/FdvN2xh0GYQ60fvo/5fvviEYz34uuugDuqY=;
  b=DaJShv7kOx7lhYaStKwgx0eebev8T3X/3tMPWfSkPzb6kPugxFjFaQ+7
   tXouYNUhGNUYY3x4MQaCJp12NrLdfUPzLoHzdq6CAAefeJYGTQNeWfr2s
   mefX7W6m3CRBAQrs/5GNL86bfZLSs9tUOfbYm9DOtyNNIg4X9LeZgmmte
   DVLfa4WVlIE8tzwuERBB34z5iAYUWIx6R4guVu9mqEwMjjQ1FGEZxGXrv
   iozhEG9ZUWsJ4NcRjnUcAzP1aJHwJ19wKv/L0l/vBy4BS+FjIvB4IRuPV
   kW2liOPyOp7bEAfoaogtLUYtLQP8QyIPdA9+drpPrjtZpuL+qJMXBe261
   w==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="230044072"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 02:19:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 02:19:29 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 14 Jun 2023 02:19:29 -0700
Date:   Wed, 14 Jun 2023 11:19:28 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Richard Cochran <richardcochran@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: micrel: Schedule work to read
 seconds for lan8841
Message-ID: <20230614091928.5oi5r7sw7tac27lt@soft-dev3-1>
References: <20230613094526.69532-1-horatiu.vultur@microchip.com>
 <20230613094526.69532-3-horatiu.vultur@microchip.com>
 <ZIlG4otXfQ7uhMsc@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZIlG4otXfQ7uhMsc@hoboy.vegasvil.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/13/2023 21:49, Richard Cochran wrote:

Hi Richard,

> 
> On Tue, Jun 13, 2023 at 11:45:26AM +0200, Horatiu Vultur wrote:
> > @@ -3840,6 +3847,12 @@ static void lan8841_ptp_enable_processing(struct kszphy_ptp_priv *ptp_priv,
> >                              LAN8841_PTP_INSERT_TS_32BIT,
> >                              LAN8841_PTP_INSERT_TS_EN |
> >                              LAN8841_PTP_INSERT_TS_32BIT);
> > +
> > +             /* Schedule the work to read the seconds, which will be used in
> > +              * the received timestamp
> > +              */
> > +             schedule_delayed_work(&ptp_priv->seconds_work,
> > +                                   nsecs_to_jiffies(LAN8841_GET_SEC_LTC_DELAY));
> 
> Why not do this in the PTP kworker thread?

I presume you mean the work of reading the second part to be done in the
PTP kworker thread and not scheduling the seconds_work.
Because then it make sense to me and I think is a great idea.
> 
> The thread's scheduling can be easily tuned with chrt to give it
> appropriate priority, but work can't.

Nice, I didn't know about this.

> 
> Also, If you have seconds thread, then you don't have to defer the
> received frames.

Exactly, the PTP kworker thread will cache the seconds value while
lan8841_rxtstamp will read this value, so no need to defer these frames.

In this way I can get rid of seconds_work.

> 
> Thanks,
> Richard
> 

-- 
/Horatiu
