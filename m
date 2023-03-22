Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22026C4695
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCVJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:36:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8A5C9C7;
        Wed, 22 Mar 2023 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1679477152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnyeTjIgdueY7mjaENj/U4VyZ8m5JbQk88eP7+Y+NYk=;
        b=XEBl/Oy+30xBpk7zkIKXfBH3r4Zsd8JBd5MdDsEVQYxh2vKgxB8R2ndtqH2nlcQgqN4GQF
        Bi8jtOEwXG/+cGXZpLiK+VcMgibiJqllPJIdJ003fjFCNHzxzawEWPh2gUGBxNOtYmD9nZ
        AzrbSKfSj6knaFwpPsSW6miXEqX/xHE=
Message-ID: <6aa6d80cb587c98dba5c04b47cd78f93bb3bafec.camel@crapouillou.net>
Subject: Re: [PATCH] mmc: jz4740: Use dev_err_probe()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        ye.xingchen@zte.com.cn, ulf.hansson@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Mar 2023 10:25:50 +0100
In-Reply-To: <d91d6e3c-da8c-0601-0cd7-45bfe7c4ad50@gmail.com>
References: <202303221707010277273@zte.com.cn>
         <d91d6e3c-da8c-0601-0cd7-45bfe7c4ad50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 mars 2023 =C3=A0 12:18 +0300, Sergei Shtylyov a =C3=A9crit=
=C2=A0:
> On 3/22/23 12:07 PM, ye.xingchen@zte.com.cn=C2=A0wrote:
>=20
> > From: Ye Xingchen <ye.xingchen@zte.com.cn>
> >=20
> > Replace the open-code with dev_err_probe() to simplify the code.
> >=20
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> > =C2=A0drivers/mmc/host/jz4740_mmc.c | 5 +----
> > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/jz4740_mmc.c
> > b/drivers/mmc/host/jz4740_mmc.c
> > index 698450afa7bb..a6ad03b24add 100644
> > --- a/drivers/mmc/host/jz4740_mmc.c
> > +++ b/drivers/mmc/host/jz4740_mmc.c
> > @@ -232,10 +232,7 @@ static int
> > jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!IS_ERR(host->dma_t=
x))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (PTR_ERR(host->dma_tx) !=
=3D -ENODEV) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "Failed to get dma tx-rx channel\n");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(host->dma_tx);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(dev, PT=
R_ERR(host->dma_tx), "Failed to
> > get dma tx-rx channel\n");
>=20
> =C2=A0=C2=A0 I'm afraid this makes the following code unreachable...

Also, this is not a probe(), so I don't see a point of using
dev_err_probe() here.

Cheers,
-Paul

>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host->dma_tx =3D dma_re=
quest_chan(mmc_dev(host->mmc), "tx");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(host->dma_tx=
)) {
>=20
> MBR, Sergey

