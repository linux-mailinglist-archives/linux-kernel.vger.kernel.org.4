Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD266F3FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjEBI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:56:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCA19A1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:56:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 653221BF20A;
        Tue,  2 May 2023 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683017777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYMO2eRjKJezt7V6DtgSnO4VtgFucVPh4V4lmWI6gKI=;
        b=l01eOZ26NmPcL2Amymi1uox97esn8qtSh0AcDVTZvO16UozsG8VrK2od/aGJDxdugkwWL4
        IlxFBy2iAO8n4cNkBIOwGk8pLsyUb2IDe8houx/nErqxMxAnB/mWPQxXSRQOFitWIBrRT2
        MOtmMVljKWs0VvWwJclcYgEWr0qt6wzobeCTkrmL6jDgUTPKhAm8DcmSHN6VPmLBcJ3mrD
        SSVuhhaRWJZlgP5ppWR3VkhmV/UsxDcdzC30kvcQtOJGvt5ogqQCh31aCnPA6GYqGXRMrZ
        uQyF7kEeIbxk6sMzExSE4sNFOjZxkAZ8i4NBC0423kLuuyDLPqgbVuMPuaWHvQ==
Date:   Tue, 2 May 2023 10:56:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <haver@vnet.ibm.com>,
        <s.hauer@pengutronix.de>, <yhao016@ucr.edu>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ubi: Refuse attaching if mtd's erasesize is 0
Message-ID: <20230502105614.7e849263@xps-13>
In-Reply-To: <20230423111041.684297-1-chengzhihao1@huawei.com>
References: <20230423111041.684297-1-chengzhihao1@huawei.com>
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

Hello,

chengzhihao1@huawei.com wrote on Sun, 23 Apr 2023 19:10:41 +0800:

> There exists mtd devices with zero erasesize, which will trigger a
> divide-by-zero exception while attaching ubi device.
> Fix it by refusing attaching if mtd's erasesize is 0.
>=20
> Fixes: 801c135ce73d ("UBI: Unsorted Block Images")

IMHO, this should be backported to keep the vulnerable area as
small as possible, so:

Cc: stable@vger.kernel.org

> Reported-by: Yu Hao <yhao016@ucr.edu>
> Link: https://lore.kernel.org/lkml/977347543.226888.1682011999468.JavaMai=
l.zimbra@nod.at/T/
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/mtd/ubi/build.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 6a2d1ef8d43c..69e92c31ace0 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -896,6 +896,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi=
_num,
>  		return -EINVAL;
>  	}
> =20
> +	/* UBI cannot work on flashes with zero erasesize. */
> +	if (!mtd->erasesize) {
> +		pr_err("ubi: refuse attaching mtd%d - zero erasesize flash is not supp=
orted\n",
> +			mtd->index);
> +		return -EINVAL;
> +	}
> +
>  	if (ubi_num =3D=3D UBI_DEV_NUM_AUTO) {
>  		/* Search for an empty slot in the @ubi_devices array */
>  		for (ubi_num =3D 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)


Thanks,
Miqu=C3=A8l
