Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485F5FAD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJKHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJKHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:25:27 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC77B1F2F2;
        Tue, 11 Oct 2022 00:25:24 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 82DD82000F;
        Tue, 11 Oct 2022 07:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665473123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R00HyJQ8h7D6q517xGqAlwuwVUZyP19hq6nl7qda6sY=;
        b=JUF0wF5vnUyA7i4HzyyMl7/f1PSqESAkrw1gU4X/0/no9Y5CzumnvMJCUROtfrQxh2McOj
        LudnBkNDwJ9Lk8Q/seixn5BBJB3SU3V52Lr5E90/WWF1IRyuLL1cCFflRrlde8aOxRhJrf
        lY446Y6vulqnRuJCTsEVBje0iSJNIWh10NmkPxlB4Ta648NMDR4ouJUOBgIuUbCcQLbgzq
        IU2uaJFOfKxMV0Hl9Bz1Qu92KRkNVfzDlm/uM6+eLVX5fMmBTmleE/J8wNSPlQ/zIIVbkr
        odi3Ia9Vw1NDIkG4+yp9emQtnuIn0P1y+E4BKjKLNcf5ZAC3VAeB2AtvjdK6Ww==
Date:   Tue, 11 Oct 2022 09:26:54 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Message-ID: <20221011092654.6c7d7ec3@fixe.home>
In-Reply-To: <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
        <20220624034327.2542112-2-frowand.list@gmail.com>
        <20220624141320.3c473605@fixe.home>
        <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, 24 Jun 2022 11:44:07 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 6/24/22 08:13, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Thu, 23 Jun 2022 22:43:26 -0500,
> > frowand.list@gmail.com a =C3=A9crit :
> >  =20
> >> =20
> >> +/*
> >> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
> >> + * scripts/Makefile.lib
> >> + */
> >> +extern void *__dtb_empty_root_begin;
> >> +
> >>  /*
> >>   * of_fdt_limit_memory - limit the number of regions in the /memory n=
ode
> >>   * @limit: maximum entries
> >> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
> >>   */
> >>  void __init unflatten_device_tree(void)
> >>  { =20
> >=20


Any news on this series ?

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
