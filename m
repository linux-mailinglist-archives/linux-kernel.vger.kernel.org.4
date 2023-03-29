Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A297F6CEE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjC2P4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjC2Pzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:55:41 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB36EB7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:54:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A3161BF204;
        Wed, 29 Mar 2023 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680105264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ik6VA5/O4bfb2QZv+TNi9tynbKEN1V0x7QzIUnGobU=;
        b=lmXC+h5NEhVsiPxedwwsWTs9Z+Ajr48MtUDE7kXzzL7GwgKLVy89oRKiaJiKlwH0YEJkqA
        3wZt0Jqp7r+lRFuWqHci4vbxZ6ZSiz2aPfH62Rgwk8092f2Id7PbiUfLAoXgyrVzSruNOK
        iJCUqpSLzopMjWFPckrsFjNUJjqV7CopKetKiewnl7FaqyRceu6jZrNI0Db3da7SLznSbt
        w4qsNVug2xyIsgqpzI5vXE9fWIvp2lDMQu048xgfui50HHBb7WqzkWj7yEmE21Q7g4OBKZ
        bhl6dbT6+xv2x2WWViroGnrIoeGNT9kguBfov8F8yPCFrvnzxcsF8SpHZnSB0w==
Date:   Wed, 29 Mar 2023 17:54:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Nicolas Schichan <nschichan@freebox.fr>,
        <george.kennedy@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
Subject: Re: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
Message-ID: <20230329175421.3bd4906e@xps-13>
In-Reply-To: <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com>
        <20230324161923.1456371-1-nschichan@freebox.fr>
        <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

chengzhihao1@huawei.com wrote on Sat, 25 Mar 2023 09:02:40 +0800:

> Hi,
> >  =20
> >> Following process will make ubi attaching failed since commit
> >> 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size"):
> >>
> >> ID=3D"0xec,0xa1,0x00,0x15" # 128M 128KB 2KB
> >> modprobe nandsim id_bytes=3D$ID
> >> flash_eraseall /dev/mtd0
> >> modprobe ubi mtd=3D"0,2048"  # set vid_hdr offset as 2048 (one page)
> >> (dmesg):
> >>    ubi0 error: ubi_attach_mtd_dev [ubi]: VID header offset 2048 too la=
rge.
> >>    UBI error: cannot attach mtd0
> >>    UBI error: cannot initialize UBI, error -22
> >>
> >> Rework original solution, the key point is making sure
> >> 'vid_hdr_shift + UBI_VID_HDR_SIZE < ubi->vid_hdr_alsize',
> >> so we should check vid_hdr_shift rather not vid_hdr_offset.
> >> Then, ubi still support (sub)page aligined VID header offset.

					aligned

> >>
> >> Fixes: 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size")

This commit has been backported to stable, so it is important this fix
also gets there quickly:

Cc: stable@vger.kernel.org

> >> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> >> ---
> >>   v2->v3: Use printing format '%zu' for UBI_VID_HDR_SIZE.
> >>   drivers/mtd/ubi/build.c | 21 +++++++++++++++------
> >>   1 file changed, 15 insertions(+), 6 deletions(-) =20
> >=20
> > [...]
> >=20
> > Hello,
> >=20
> > Having had the problem, and found this patch as a fix, feel free to
> > add my:
> >  =20
>=20
> Thanks for testing.
>=20
> > Tested-by: Nicolas Schichan <nschichan@freebox.fr>

Same here.

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com> # v5.10, v4.19

Thanks,
Miqu=C3=A8l
