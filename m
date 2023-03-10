Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA56B3B91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCJKAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCJKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:00:52 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522710974F;
        Fri, 10 Mar 2023 02:00:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B75311C0017;
        Fri, 10 Mar 2023 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678442449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRouiKsqA5C1X72SusQ6yGbsnQyjDfJ10YAa3MZALxg=;
        b=RtrMrwRZ8FVz2ppXlnTfXLEAreiZZkzbEUyYVVyw9POiXSoYC6qj5k0ApzPkJbzE/R39Ue
        0xpQWpfUMfEi6cTnnHZMEQyakZ6nzNcE12lL2lTN5Rbrl93hXf3y/zRfnDDfiO5dLg8z4t
        cQ3ac7QYDxNi8FPHeSl1u3/MKP0VXnRYIIImxlxOsTBFNIMsxQ25TOYvaD5Ok5xqdUdNxf
        6MNbVU/p1uC8e6l0BpOmk+YHA95RO5lpP82WsOYB8XK2VrUWKClYrEgpcIM7UlJemnaDKf
        dZyZY3/b3MDH8MmoISr6G5v8BFkTWo1Tt30tZZ8ViGFhMO+HlXzYVt0NBsPhjA==
Date:   Fri, 10 Mar 2023 11:00:45 +0100
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
        devicetree@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 09/21] nvmem: core: return -ENOENT if nvmem cell is
 not found
Message-ID: <20230310110045.22387796@xps-13>
In-Reply-To: <6244680f-44db-0706-eada-dffdb05f116a@linaro.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
        <20230307165359.225361-10-miquel.raynal@bootlin.com>
        <6244680f-44db-0706-eada-dffdb05f116a@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 09:57:54 +0000:

> On 07/03/2023 16:53, Miquel Raynal wrote:
> > From: Michael Walle <michael@walle.cc>
> >=20
> > Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
> > the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
> > found. Particularly, if of_property_match_string() returned -EINVAL,
> > that return code was passed as the index to of_parse_phandle(), which
> > then detected it as invalid and returned NULL. That led to an return
> > code of -ENOENT.
> >=20
> > With the new code, the negative index will lead to an -EINVAL of
> > of_parse_phandle_with_optional_args() which pass straight to the
> > caller and break those who expect an -ENOENT.
> >=20
> > Fix it by always returning -ENOENT.
> >=20
> > Fixes: efff2655ab0f ("nvmem: core: add an index parameter to the cell")
> > Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > --- =20
>=20
> Already applied.

Yes, sorry, Michael spotted it as well, I wasn't based on the right
branch. v3 is udpated on this regard.

Thanks,
Miqu=C3=A8l
