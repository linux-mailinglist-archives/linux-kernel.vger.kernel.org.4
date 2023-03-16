Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42756BD5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCPQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCPQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:39:07 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0392E6FCB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:38:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8BE9A100014;
        Thu, 16 Mar 2023 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678984664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewIxmNxO1q0Y79TJiCF/EjMHu+aGJnFLPnVrlrJufNE=;
        b=pLRMpq2A5vsUsRm6iRGb5Hr1laewxYbjexUr5/dWG6lRvPprfvxXwXImefXdXfBEgeJxhW
        v0bnrTxbyNayOaMft3BV+qGdXKNYbWIq8gvGlu7cmGE05KkfGxJrg9A3Jvt3tlRQBwjgHy
        N60EhZlimNNXNX1PJUCF9lsyWKQ+HstPBgR8CLvIXovyxxKl0QQUKLhHvCFhXk+CyrpJCB
        kBjgjkn5uBoaCohNhGu3mTJm3/UVHqFQxMVPZST8iWHSMK1YxE41+zZ+YX5q7xwXQHK4vi
        wo5a+inQX6bj8tx7OVyAmhlV9tfFAxzXRplKXZElDfKnQn6g6Ao+U4j9jkxnKg==
Date:   Thu, 16 Mar 2023 17:37:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] nvmem: Add macro to register nvmem layout drivers
Message-ID: <20230316173741.4f572068@xps-13>
In-Reply-To: <5d3d01ec1b05ec47c0590d5af14c4f37@milecki.pl>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
        <20230315100018.1660071-2-miquel.raynal@bootlin.com>
        <5d3d01ec1b05ec47c0590d5af14c4f37@milecki.pl>
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

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Thu, 16 Mar 2023 17:28:04 +0100:

> On 2023-03-15 11:00, Miquel Raynal wrote:
> > Provide a module_nvmem_layout_driver() macro at the end of the
> > nvmem-provider.h header to reduce the boilerplate when registering > nv=
mem
> > layout drivers. =20
>=20
> I think you should take care of including <linux/device/driver.h>
> instead of depending on module_nvmem_layout_driver() *callers* to do
> that.

Right, I'll do that.

>=20
> That would help avoiding errors like:
>=20
> In file included from drivers/nvmem/layouts/fixed.c:5:
> ./include/linux/nvmem-provider.h:252:2: warning: data definition has no t=
ype or storage class
>    252 |  module_driver(__layout_driver, nvmem_layout_register, \
>        |  ^~~~~~~~~~~~~
> ./include/linux/nvmem-provider.h:252:2: error: type defaults to 'int' in =
declaration of 'module_driver' [-Werror=3Dimplicit-int]
>    252 |  module_driver(__layout_driver, nvmem_layout_register, \
>        |  ^~~~~~~~~~~~~
>=20
>=20
> > Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/nvmem-provider.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/include/linux/nvmem-provider.h > b/include/linux/nvmem-pro=
vider.h
> > index 0cf9f9490514..a1c668018894 100644
> > --- a/include/linux/nvmem-provider.h
> > +++ b/include/linux/nvmem-provider.h
> > @@ -240,4 +240,9 @@ nvmem_layout_get_match_data(struct nvmem_device > *=
nvmem,
> >  }
> >=20
> >  #endif /* CONFIG_NVMEM */
> > +
> > +#define module_nvmem_layout_driver(__layout_driver)		\
> > +	module_driver(__layout_driver, nvmem_layout_register,	\
> > +		      nvmem_layout_unregister)
> > +
> >  #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */ =20


Thanks,
Miqu=C3=A8l
