Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50CA7196E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjFAJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjFAJ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:26:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1497
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:26:34 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685611593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbvLgMKoZay1nPQrvjfnnvBwUKGL+yXiiYb/6mR/jLE=;
        b=ksxPjxYVIUrsBA6Mz5B5AOXZmLSfNMJXx5nWTV/o4xssaaufyDdXg0qanOH4ODfS8TXpml
        YJlutT+nEKm3fVj5aS43vWjC1tiV9CVy/ruTUSmVYD75O3MNbcXQ+EOXzoIHJgxm5/EzvT
        nDl8nGGP4HwrHvhKTPKIiwRhfL0YWjpBQBrLW9LUf9ESns6TbynQ4eaaUgK6B4ejCT/zHP
        CXRAQLYb14vK7397OGtngflrEcfhz6CXwyGtkmgK+QBJrltLxhv06Rsssq0D+uYUEwEO0B
        f2VbdCkwXSJ4h2kyt7rh/tEJtUhI/1wI5QG3VPjzAG16xfUi0wELqOCzGMaKEg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B945FF80B;
        Thu,  1 Jun 2023 09:26:31 +0000 (UTC)
Date:   Thu, 1 Jun 2023 11:26:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230601112628.7d2dc77f@xps-13>
In-Reply-To: <2023060142-thyself-flatware-26f7@gregkh>
References: <20230530100929.285235-1-miquel.raynal@bootlin.com>
        <20230530100929.285235-3-miquel.raynal@bootlin.com>
        <2023053132-divorcee-aqueduct-70fa@gregkh>
        <20230601105114.58749075@xps-13>
        <2023060142-thyself-flatware-26f7@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Thu, 1 Jun 2023 10:03:01 +0100:

> On Thu, Jun 01, 2023 at 10:51:14AM +0200, Miquel Raynal wrote:
> > > > +	/* Without exposed cells, successfully exit after
> > > > assigning an empty attributes array */
> > > > +	if (!ncells)
> > > > +		goto unlock_mutex; =20
> > >=20
> > > Shouldn't this check be higher up _before_ you allocate any memory?
> > > If the attribute group list is empty, nothing should be created,
> > > right?  Or will the driver core crash?
> >=20
> > As you rightfully guessed it, the core will crash if no list is
> > provided at all. I need to provide an empty list with just an empty
> > member and everything goes smoothly.=20
>=20
> Let's fix the core, it shouldn't crash like that :)

Perfectly fine by me, I'll give this idea a try.

Thanks,
Miqu=C3=A8l
