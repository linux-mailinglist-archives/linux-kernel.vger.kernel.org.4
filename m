Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88470B7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjEVIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjEVIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:33:33 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5FBA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:33:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B0981C000A;
        Mon, 22 May 2023 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684744409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/bPlbQWSxPOpbiZwEhUe5DhihOAH0/pWLbUpPckCNI=;
        b=kgQBXulqrKzn6cyxRNQkH9bmcUcg17TDtzj+1UeH5L5mFqtH9cTZkVBa/2N+FlOhsTNTYV
        xRo68LWBJtdN3m7+M8mC/d7mvV0ZlaSIic+LWn4v8JCNoHH4WsVPr4cfT+RcBGy1Cf8Q2T
        tS5tg2NuYixUVuzz3LsTKaDr3M0o3SIq1x1sOktxz0GPs6nJuYzXvkLHbHvcPTNDUJJi4C
        0D5R5Hlwc9NXa55+cctlD8rx9tWQkO3aHpIdmZoltmfcbi3j1STWalB5Dm0JbU58B62gX0
        UM84TRGnk2/YXit6TXACtZV3rbYvQ21WPKmIIxBEbrq7mWJe0zNXRxjbf/L2HA==
Date:   Mon, 22 May 2023 10:33:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: add NACK check after start byte sent
Message-ID: <20230522103327.16e95d02@xps-13>
In-Reply-To: <20230517033030.3068085-3-xiaoning.wang@nxp.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
        <20230517033030.3068085-3-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

xiaoning.wang@nxp.com wrote on Wed, 17 May 2023 11:30:30 +0800:

> Add NACK check after start byte is sent.
> It is possible to detect early that a device is not on the bus
> and avoid invalid transmissions thereafter.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Nice addition.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/i3c/master/svc-i3c-master.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 4edf33ed207d..0d63b732ef0c 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -92,6 +92,7 @@
>  #define SVC_I3C_MINTCLR      0x094
>  #define SVC_I3C_MINTMASKED   0x098
>  #define SVC_I3C_MERRWARN     0x09C
> +#define   SVC_I3C_MERRWARN_NACK BIT(2)
>  #define SVC_I3C_MDMACTRL     0x0A0
>  #define SVC_I3C_MDATACTRL    0x0AC
>  #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
> @@ -1014,6 +1015,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_mast=
er *master,
>  	if (ret)
>  		goto emit_stop;
> =20
> +	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
> +		ret =3D -ENXIO;
> +		goto emit_stop;
> +	}
> +
>  	if (rnw)
>  		ret =3D svc_i3c_master_read(master, in, xfer_len);
>  	else


Thanks,
Miqu=C3=A8l
