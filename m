Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C46C9D46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjC0IME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjC0IMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:12:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BAD46A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:12:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C6281C0015;
        Mon, 27 Mar 2023 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679904719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhvzASfzINt429FFDENdwaX1DAN8o/J7JPa/K12PqeE=;
        b=KtBVpLqLxvlJs8VA5ludhzfGeipr1FWpr3sHAGZ3b3nWk8iyPaq8kzNPhZGhJmjiod+8LB
        rvro547hpD376hvjvWR5ia9QivFHApEOtdEN/7R6yW+iNlxTv/8NIHzCb4XFbPRI+udoJz
        0KCOyrK19k/RKZ7RyyFC7yWknSlFCg6rjdMu4UX4tOFUpfPF6e8ZgRFKvUk6f3iBk5yKfA
        D28+bEjlL3UkXOEF9j4pPpHoID2r+79ciMCxRHNYoUlGqH4gQCttfI9kjplPGiQTReJKGQ
        56COzZAup502YD32YBhgNaW1Qk9QtcgwZqZBilBN0x2L6G21Nn9RXGdENtlR0g==
Date:   Mon, 27 Mar 2023 10:11:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: do not support EDO mode
Message-ID: <20230327101156.0ec2816a@xps-13>
In-Reply-To: <fcb600af-88dc-55a7-917e-4cf4673c2973@foss.st.com>
References: <20230324160918.826452-1-christophe.kerello@foss.st.com>
        <20230324172528.4d3ccd4b@xps-13>
        <f4c32aa5-e5b1-6465-7708-ef0281baf0af@foss.st.com>
        <fcb600af-88dc-55a7-917e-4cf4673c2973@foss.st.com>
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

Hi Christophe,

christophe.kerello@foss.st.com wrote on Mon, 27 Mar 2023 10:02:13 +0200:

> Hello Miquel,
>=20
> On 3/24/23 17:34, Christophe Kerello wrote:
> > Hello Miquel,
> >=20
> > On 3/24/23 17:25, Miquel Raynal wrote: =20
> >> Hi Christophe,
> >>
> >> christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 17:09:18 +010=
0:
> >> =20
> >>> FMC2 controller does not support EDO mode (timings mode 4 and 5).
> >>>
> >>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >>> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND >=
>> flash controller driver")
> >>> ---
> >>> =C2=A0 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
> >>> =C2=A0 1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c >>> b/drivers/mtd=
/nand/raw/stm32_fmc2_nand.c
> >>> index 5d627048c420..3abb63d00a0b 100644
> >>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> >>> @@ -1531,6 +1531,9 @@ static int >>> stm32_fmc2_nfc_setup_interface(s=
truct nand_chip *chip, int chipnr,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(sdrt))
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(sdrt);
> >>> +=C2=A0=C2=A0=C2=A0 if (sdrt->tRC_min < 30000) =20
> >>
> >> When introducing NV-DDR support we as well added a timings.mode field,
> >> perhaps you could use it? =20
> >=20
> > Yes, I can use it. It will be done in V2.
> >=20
> > Regards,
> > Christophe Kerello.
> >  =20
>=20
> I had a look at Kernel LTS, and timings.mode was introduced on Kernel LTS=
 5.10. As this patch has also to be applied on Kernel LTS 5.4, my proposal =
is to send a new patch set. The first patch will be the current patch (fix =
for all Kernel LTS) and the second patch will use timings.mode instead of c=
hecking tRC_min timings for next Kernel delivery. Is this proposal acceptab=
le?

Works for me!

Thanks,
Miqu=C3=A8l
