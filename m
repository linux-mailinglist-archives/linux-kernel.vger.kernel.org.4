Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA275BD11F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiISPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:35:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535912D2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:35:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5221BFF802;
        Mon, 19 Sep 2022 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663601721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GrJZdM8oRjwEUaCDb6HQyhFcx0jpFsIYOO3Dzpg3b18=;
        b=j9KRb7OVwmAhuD9cYMCtEp5udKOY72TpX8DpljCzrzfeUzmBoYPpb5WdDDTjeAvbDZs0rS
        o1SxK0F6sWYIgqHG8Dxe+EeZxKdbnbKU1OlxEYY6Tqpi9Qq+OoY/x7FbTtLuETRcuIrOf2
        Zpeg6I33zsFUUEMh0YImy5h2Kvej04bmrllU6xXiXQVJjJrMt1EbEDaaK89XHxD+bLbKwO
        /PbTEzmB0SXaIBRjKhi70BQydWicFC8/wEfmV2xRRDh8gYcQbWhkc5ruPZnLOIPdpB7YcA
        R/NGoy0DqKFUga6b4Uq7aAP15tV8SoQPHozf5bJlJ11KhqLECIDRiL82gt1cAA==
Date:   Mon, 19 Sep 2022 17:35:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH] mtd: rawnand: denali: Fix a possible resource leak in
 denali_pci_probe
Message-ID: <20220919173518.35742b2f@xps-13>
In-Reply-To: <dac8e781-5c2b-4ba1-34a7-d902ba060b29@wanadoo.fr>
References: <20220801080315.1713934-1-gongruiqi1@huawei.com>
        <dac8e781-5c2b-4ba1-34a7-d902ba060b29@wanadoo.fr>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

christophe.jaillet@wanadoo.fr wrote on Mon, 1 Aug 2022 20:26:07 +0200:

> Le 01/08/2022 =C3=A0 10:03, GONG, Ruiqi a =C3=A9crit=C2=A0:
> > Call pci_release_regions() to retrieve the allocated resource when
> > devm_ioremap() or denali_init() failed.
> >  =20
>=20
> Hi,
> this is not correct.
>=20
> First, should you be right, you should also update the .remove() function=
 the same way.
>=20
> Second, at the beginning there is pcim_enable_device() call.
> This looked like magic to me when I first saw it, but this function makes=
 some pci_ functions work just as it they were pcim_ functions.
>=20
> See pcim_enable_device() ([1]), at line 2132.
> When pcim_release() ([2]) is called by the framework, then regions are re=
leased at line 2079

Interesting, I just see this answer now, please ignore my first comment
then, it's not useful.

Thanks Christophe for the feedback.

Cheers,
Miqu=C3=A8l
