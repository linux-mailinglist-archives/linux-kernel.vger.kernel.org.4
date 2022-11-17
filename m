Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94762DDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiKQOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbiKQOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:11:46 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121462065
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:11:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 86561240011;
        Thu, 17 Nov 2022 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668694303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtRPY6fq+dX8t6QertspUgnv+Cd2tXarfsv8zbhiSUs=;
        b=gLmkBBS0oCR4V6BFWEAgSbigFARFS6bgljJArdTAvQIz4JQyLvR5HMfsyss1iXTu4ed5xe
        KVmXeTlKi3iQpPm7dyytYdivSdzASlAyMx4TutDSNTzjkbyf1V3Qge96/kKp0tVQP9J5PG
        Jr71vdxnvcYtXJ58Lrsq8xrHyGp6ZeQyzhBxw3nMl6wtfC2KAsi/QsiQhfphbhltYeU4jK
        4ES6YOXG13Ui1ojsCMfeP3iwI4NCUsH9wj+ARt+yNPWLkZqdj20nE7ogQia+RLmjAn/2LB
        PiCN5NbI9WAkogbiKckVYgvkDHY6w5QQTkptraCmnR3+wi1BNuUmUftLaXbByg==
Date:   Thu, 17 Nov 2022 15:11:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] mtd: lpddr: Added literal suffix
Message-ID: <20221117151141.20cfc362@xps-13>
In-Reply-To: <20221117123625.117161-1-arefev@swemel.ru>
References: <20221117123625.117161-1-arefev@swemel.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

arefev@swemel.ru wrote on Thu, 17 Nov 2022 15:36:25 +0300:

> The value of an arithmetic expression
> 1 << lpddr->qinfo->DevSizeShift is subject to overflow
> due to a failure to cast operands to a larger data
> type before perfoming arithmetic
>=20
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/mtd/lpddr/lpddr_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmd=
s.c
> index ee063baed136..360b2af8340b 100644
> --- a/drivers/mtd/lpddr/lpddr_cmds.c
> +++ b/drivers/mtd/lpddr/lpddr_cmds.c
> @@ -61,7 +61,7 @@ struct mtd_info *lpddr_cmdset(struct map_info *map)
>  		mtd->_point =3D lpddr_point;
>  		mtd->_unpoint =3D lpddr_unpoint;
>  	}
> -	mtd->size =3D 1 << lpddr->qinfo->DevSizeShift;
> +	mtd->size =3D 1UL << lpddr->qinfo->DevSizeShift;

Are you sure it should not be 1ULL instead? otherwise I don't see how
the overflow can happen?

>  	mtd->erasesize =3D 1 << lpddr->qinfo->UniformBlockSizeShift;
>  	mtd->writesize =3D 1 << lpddr->qinfo->BufSizeShift;
> =20


Thanks,
Miqu=C3=A8l
