Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4716B3D77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCJLQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCJLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:16:12 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D23109774;
        Fri, 10 Mar 2023 03:16:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AB1D440007;
        Fri, 10 Mar 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678446965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4AC2Juxbrl9PMsHA6NRp4MswfzYrZ/3Kd2MMsK5Z8g=;
        b=Li+EJ+jiTkKeHvvrc7ZV5FJhpfYTRNsDe6KnkM/uX9w3HLw/0glGkAC6XBowZGnXaTdT63
        9OIsczQdgZ01UOCrca0kq6rJFjU+MdBaL/f/jEC1mpmvM9uZU0dAiIxhc+16BD5XuIjk3z
        IQMH/GaqtwFMtRS8C59EAedBUu0pmDtnlRbgrEXA/NCUvqmqh/MEKplcfvXJroCLsLPJWK
        EyX6XtPuFzCPDixD1vBx+MPs45EXnxq3/S+8nuOnFUSTFSVetIcEof0qTFEJT4t3Y+nduj
        juj30cyKy0CYzgonm9+1qPXQayzEqkZggeqTLoGwVRX5OmQ7VZ4zd7b++NFarA==
Date:   Fri, 10 Mar 2023 12:16:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 17/20] nvmem: layouts: sl28vpd: Add new layout driver
Message-ID: <20230310121602.109c58e7@xps-13>
In-Reply-To: <54e7ee75-6035-c2e9-fb8b-fe96adbb571a@linaro.org>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
        <20230308153200.682248-18-miquel.raynal@bootlin.com>
        <54e7ee75-6035-c2e9-fb8b-fe96adbb571a@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 11:03:45 +0000:

> On 08/03/2023 15:31, Miquel Raynal wrote:
> > +
> > +static int __init sl28vpd_init(void)
> > +{
> > +	return nvmem_layout_register(&sl28vpd_layout);
> > +}
> > +
> > +static void __exit sl28vpd_exit(void)
> > +{
> > +	nvmem_layout_unregister(&sl28vpd_layout);
> > +}
> > +
> > +module_init(sl28vpd_init);
> > +module_exit(sl28vpd_exit); =20
> Looking at this pattern in two drivers, we could come up with some helper=
 macro like.
>=20
> #define module_nvmem_layout_driver(__layout_driver) \
>          module_driver(__layout_driver, nvmem_layout_register, \
>                          nvmem_layout_unregister)

Nice idea! I will make a patch; is it okay do it on top?

Thanks,
Miqu=C3=A8l
