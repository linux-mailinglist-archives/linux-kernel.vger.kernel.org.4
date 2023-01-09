Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFED662026
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjAIIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjAIIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:38:18 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D37679;
        Mon,  9 Jan 2023 00:38:16 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 387DD240008;
        Mon,  9 Jan 2023 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673253494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQQWmYnUWL8FGGPocWw3A7tYGPi+h3c92ZhNSnoyivk=;
        b=pt1MHMToZ+5z36CKHlRqaFZq3uh+7xSa75vm94eOaNt07aLAK1ljREmtNqvQUSMaTx6aeE
        iH1hdp5eo9jbo5Bwh2goi2AyT1xskW2FRXOjMv2eqYxkpH/USV6UB0k4lsrOgvsTHnYaYl
        3Fp3MBFlGp7C0OZ8vRYW97v+rMHCJRlc9jZ0sW1yByDhnowkwUlbcOlbkX7CmlWcFUC92M
        RBuIAFZvtN62sEmClKs+nbXzXHUmwzRU4fjXE/qla/0GBopSXmQXafjX3HObWOE8jv7Kyn
        Wc1DNuTAQ/9yIZ+1o9z83U1936TInbKsEpc7cRnLk1tIzYCixmvd8/PLiDTQEw==
Date:   Mon, 9 Jan 2023 09:40:09 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Message-ID: <20230109094009.3878c30e@fixe.home>
In-Reply-To: <20221011092654.6c7d7ec3@fixe.home>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
        <20220624034327.2542112-2-frowand.list@gmail.com>
        <20220624141320.3c473605@fixe.home>
        <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
        <20221011092654.6c7d7ec3@fixe.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

Le Tue, 11 Oct 2022 09:26:54 +0200,
Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :

> Le Fri, 24 Jun 2022 11:44:07 -0500,
> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
>=20
> > On 6/24/22 08:13, Cl=C3=A9ment L=C3=A9ger wrote: =20
> > > Le Thu, 23 Jun 2022 22:43:26 -0500,
> > > frowand.list@gmail.com a =C3=A9crit :
> > >    =20
> > >> =20
> > >> +/*
> > >> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
> > >> + * scripts/Makefile.lib
> > >> + */
> > >> +extern void *__dtb_empty_root_begin;
> > >> +
> > >>  /*
> > >>   * of_fdt_limit_memory - limit the number of regions in the /memory=
 node
> > >>   * @limit: maximum entries
> > >> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
> > >>   */
> > >>  void __init unflatten_device_tree(void)
> > >>  {   =20
> > >  =20
>=20
>=20
> Any news on this series ?
>=20

Hi Frank,

Do you plan on resubmitting this series ? If not, could I resubmit it
after fixing problems that were raised in the review ?

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
