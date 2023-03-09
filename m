Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E46B22D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCIL0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjCILZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:25:42 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDB5CC03;
        Thu,  9 Mar 2023 03:23:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4641D10000E;
        Thu,  9 Mar 2023 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678361007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFB/XzUgcCAZanhIP6AKbNu6CZh3ZVa2Xw1P9FE3XKU=;
        b=i74aRkvD0oj/7IcNRKWPBzJhbEnD9BxREtMgeu2+Ic1ouSWkVmpx89UD2aEE+Ch2cUWsUV
        yShn53mLBgk/zBu6/96vEQd51E/9hV4ukYDp3M99J8B+LUb1vtVxlyCnuW13tJoG+R39SG
        Vl9S7zfHu4yoGfCur9XqUEzWYv42Mm2/CM+N6bWu+J0Wi4e8M9JxC5lO6vI3ex2fYf4tCk
        YNieGatb2k1UY5KBFLvhwSd9JLfUExt27K8zwVG2IOeDFnWL622H9SQpR4OUO6XXSSwyho
        omft0YbNKbPbqZbVxFE3WBn7hqpU2YzDhXYOHKZ0GNL9FOhrOQYXgz/vTIgVxg==
Date:   Thu, 9 Mar 2023 12:23:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
Message-ID: <20230309122324.4b012a58@xps-13>
In-Reply-To: <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
References: <20230222172245.6313-1-zajec5@gmail.com>
        <20230222172245.6313-3-zajec5@gmail.com>
        <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
        <20230309113211.6321ce3d@xps-13>
        <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:53:07 +0000:

> On 09/03/2023 10:32, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:24 +0000:
> >  =20
> >> On 22/02/2023 17:22, Rafa=C5=82 Mi=C5=82ecki wrote: =20
> >>> @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct nvmem_d=
evice *nvmem,
> >>>    	if (!nvmem)
> >>>    		return -EINVAL; =20
> >>>    > +	/* Cells with read_post_process hook may realloc buffer we can=
't allow here */ =20
> >>> +	if (info->read_post_process)
> >>> +		return -EINVAL; =20
> >> This should probably go in 1/4 patch. Other than that series looks goo=
d to me. =20
> >=20
> > FYI patch 1/4 is also carried by the nvmem-layouts series, so it's
> > probably best to keep these 2 patches separated to simplify the merging=
. =20
> that is intermediate thing, but Ideally this change belongs to 1/4 patch,=
 so once I apply these patches then we can always rebase layout series on t=
op of nvmem-next

Well, I still don't see the need for this patch because we have no use
for it *after* the introduction of layouts. Yes in some cases changing
the size of a cell might maybe be needed, but right now the use case is
to provide a MAC address, we know beforehand the size of the cell, so
there is no need, currently, for this hack.

Whatever. If you want it, just merge it. But *please*, I would like
to see these layouts in, so what's the plan?

Thanks,
Miqu=C3=A8l
