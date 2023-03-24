Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156566C8251
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCXQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:25:33 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72DC170
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:25:32 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E9A0624000B;
        Fri, 24 Mar 2023 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679675131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLzWeLxSuEsnoumPpXxnCEwUl43WWezW7vONFSan/CU=;
        b=MrA2p34aD+1+1n6ZmzwtodiD1bIwrXlGZBz9KJaD1qOBCd1d1xkbl0kVYrWvRK9mVQCpta
        zyh7TfW7RdjXZKiWiAdLx8v+IK6xId+N0lj5hTypSvsjc22EIiTTG2SU3BPODUGSGTty9b
        VXJLnAn7KDPf/Emr3zr9PyRm+7M/YGMBU0VQkl6uikJOuESb13jVZQOaHWBkHg5Sf7yc3v
        YnJRzamlfX/aSt8+Huv7/vRwDrWsphlvmIm36yx29XKNbWn6oX4MQxSHPOEarqgDVmG6kY
        G/GPKZEUFLXoyVbwzKGHyZSxbz3dBdUcw9Wp3II+fKCFBpclrvFldgJcAxLxQg==
Date:   Fri, 24 Mar 2023 17:25:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: do not support EDO mode
Message-ID: <20230324172528.4d3ccd4b@xps-13>
In-Reply-To: <20230324160918.826452-1-christophe.kerello@foss.st.com>
References: <20230324160918.826452-1-christophe.kerello@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 17:09:18 +0100:

> FMC2 controller does not support EDO mode (timings mode 4 and 5).
>=20
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash=
 controller driver")
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/ra=
w/stm32_fmc2_nand.c
> index 5d627048c420..3abb63d00a0b 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1531,6 +1531,9 @@ static int stm32_fmc2_nfc_setup_interface(struct na=
nd_chip *chip, int chipnr,
>  	if (IS_ERR(sdrt))
>  		return PTR_ERR(sdrt);
> =20
> +	if (sdrt->tRC_min < 30000)

When introducing NV-DDR support we as well added a timings.mode field,
perhaps you could use it?

> +		return -EOPNOTSUPP;
> +
>  	if (chipnr =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
>  		return 0;
> =20


Thanks,
Miqu=C3=A8l
