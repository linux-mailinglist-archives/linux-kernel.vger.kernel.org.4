Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE55F63B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJFJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiJFJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:32:12 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6D9AFAE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:32:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A2A80C000F;
        Thu,  6 Oct 2022 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665048729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjHVL/38CXAeYxrAeQ9axWybfLmZxCn1wRHKQgSsmsk=;
        b=nByDzAF7vFUEJOyiTSNV4fyHY8MRgDpGnmYUwpsKCMxpcQza7EuAE7OSZ5qTskkdl6gwJC
        Ku5ljEg1RbOHaPIZUuiKd2FMYe29TBXh1WEH9cgmRTQ8i8HjPGIjSPk+tZXXcYiwCuptWF
        Vk/ndBRgAVJBbKIfOd2wzeXtOYL6dNi/WeOMPtSgcw+NdIC9ZOhwDcVkJazCH9835dFOgx
        ffCycH+eGS76IlI12KAuPkZqNDm8Wga5Vjqhd5KsDerBY1C04hWW9BUfhc6vgyRKY4YCh7
        XlCvG4Vb2WS/ZaAOhjaDixnsxl/pv5zUq0tEL+8pik/YkqmeLIRuQEXUQ2fBeQ==
Date:   Thu, 6 Oct 2022 11:32:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] spi-nand: add Winbond W25N02KV flash support, fix
 Winbond flashes identifications
Message-ID: <20221006113207.7b81d45b@xps-13>
In-Reply-To: <d55465ac-fe0b-130c-31ae-0ce62af3eb5f@kontron.de>
References: <20221006033256.111664-1-mikhail.kshevetskiy@iopsys.eu>
        <d55465ac-fe0b-130c-31ae-0ce62af3eb5f@kontron.de>
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

Hi Frieder,

frieder.schrempf@kontron.de wrote on Thu, 6 Oct 2022 11:26:45 +0200:

> Am 06.10.22 um 05:32 schrieb mikhail.kshevetskiy@iopsys.eu:
> >=20
> > From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >=20
> > Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
> > but current driver uses only first 2 bytes of it for devices
> > idenfification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
> > is identified as W25N01GV (id_bytes: EF, AA, 21).
> >=20
> > Fix this and add W25N02KV flash support.
> >=20
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> =20
>=20
> Thanks for the patch. We have a similar change in our downstream kernel,
> that I failed to push upstream so far. But your version looks even better.
>=20
> Can you change the subject prefix to "mtd: spinand: winbond:", please?
>=20
> And I also would like to ask you to split this into two patches. The
> first one to add the third byte in the ids of the existing devices and
> the second one to add support for the new device.

Agreed on both comments, thanks Frieder!

> With these two changes you can add:
>=20
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Cheers,
Miqu=C3=A8l
