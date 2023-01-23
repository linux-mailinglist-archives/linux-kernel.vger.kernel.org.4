Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D02677E96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjAWPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjAWPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:02:52 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB2022A14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1674486169; x=1706022169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-id:
   content-transfer-encoding;
  bh=GEa2wspqr6J3lyPu8fImvpGGVirL3i14PWRHbuLKCRk=;
  b=jKV76K2EQIzz0sU49/ht+8P5KIMxgXHIaYG7vC4ik14gXQ08olr7exgA
   O2pgZ9vTU4/JGOujVEVSbu97Y8ZT6vNj1EWaDyEh+c/d1TjKb4EXXWNtc
   yADET10F6tmLVVxwLr5Pa8cJoU2t5WF5ecfz/q19YmzheENIpFCCxcfUn
   /TpwZfK6C+ykTywT3bF8iL5FSCAE4xq5zumgZNL/acTJhZF5bVu6+6Vq0
   qQ9Y3wAJ3cdKNiZfCskCXShblAgINI3v9Dozz3A+ZF0RaTf2O4l6GiJAt
   FCjGaLvu1oWy+xItJJg+SWSYsURSJuHtYmcTwcZEfRkfAgPR35oIpfQ3G
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669071600"; 
   d="scan'208";a="28595830"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Jan 2023 16:02:46 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 23 Jan 2023 16:02:47 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 23 Jan 2023 16:02:47 +0100
X-IronPort-AV: E=Sophos;i="5.97,239,1669071600"; 
   d="scan'208";a="28595829"
Received: from vmail01.tq-net.de ([10.150.72.11])
  by mx1.tq-group.com with ESMTP; 23 Jan 2023 16:02:46 +0100
Received: from vmail01.tq-net.de (10.150.72.11) by vmail01.tq-net.de
 (10.150.72.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 23 Jan
 2023 16:02:45 +0100
Received: from vmail01.tq-net.de ([10.150.72.11]) by vmail01.tq-net.de
 ([10.150.72.11]) with mapi id 15.01.2507.016; Mon, 23 Jan 2023 16:02:45 +0100
From:   "Stein, Alexander" <Alexander.Stein@tq-group.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
CC:     "michael@walle.cc" <michael@walle.cc>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Index: AQHYOQodYTda3weuU0+yf380GWE6Ea6t9KqA
Date:   Mon, 23 Jan 2023 15:02:45 +0000
Message-ID: <5642351.DvuYhMxLoT@steina-w>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
 <5550605.DvuYhMxLoT@steina-w>
 <b8d01f36-663a-928a-6dbe-64952b5bd8d0@microchip.com>
In-Reply-To: <b8d01f36-663a-928a-6dbe-64952b5bd8d0@microchip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.72.21]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <442701B35985684F88905FBEBE92D650@tq-group.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,=0A=
=0A=
Am Mittwoch, 16. M=E4rz 2022, 08:47:40 CET schrieb Tudor.Ambarus@microchip.=
com:=0A=
> On 3/16/22 09:39, Alexander Stein wrote:=0A=
> =0A=
> > [You don't often get email from alexander.stein@tq-group.com. Learn why=
=0A=
> > this is important at http://aka.ms/LearnAboutSenderIdentification.]=0A=
 =0A=
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the=0A=
> > content is safe=0A=
 =0A=
> > Hello,=0A=
> =0A=
> =0A=
> hi,=0A=
> =0A=
> =0A=
> > =0A=
> > Am Samstag, 6. November 2021, 08:56:15 CET schrieb Tudor Ambarus:=0A=
> > =0A=
> >> When paring SFDP we may choose to mask out an erase type, passing=0A=
> >> an erase size of zero to spi_nor_set_erase_type().=0A=
> >> Fix shift-out-of-bounds and just clear the erase params when=0A=
> >> passing zero for erase size.=0A=
> >> While here avoid a superfluous dereference and use 'size' directly.=0A=
> >>=0A=
> >>=0A=
> >>=0A=
> >> UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2237:24=0A=
> >> shift exponent 4294967295 is too large for 32-bit type 'int'=0A=
> >>=0A=
> >>=0A=
> >>=0A=
> >> Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SP=
I=0A=
> >> NOR=0A=
 flash memories") Reported-by: Alexander Stein=0A=
> >> <Alexander.Stein@tq-group.com>=0A=
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>=0A=
> >> ---=0A=
> >> =0A=
> >>  drivers/mtd/spi-nor/core.c | 9 +++++++--=0A=
> >>  1 file changed, 7 insertions(+), 2 deletions(-)=0A=
> >>=0A=
> >>=0A=
> >>=0A=
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c=
=0A=
> >> index 3d97c189c332..a1b5d5432f41 100644=0A=
> >> --- a/drivers/mtd/spi-nor/core.c=0A=
> >> +++ b/drivers/mtd/spi-nor/core.c=0A=
> >> @@ -2230,8 +2230,13 @@ void spi_nor_set_erase_type(struct=0A=
> >> spi_nor_erase_type=0A=
 *erase, u32 size, erase->size =3D size;=0A=
> >> =0A=
> >>       erase->opcode =3D opcode;=0A=
> >>       /* JEDEC JESD216B Standard imposes erase sizes to be power of 2.=
=0A=
> >>       */=0A=
> >> =0A=
> >> -     erase->size_shift =3D ffs(erase->size) - 1;=0A=
> >> -     erase->size_mask =3D (1 << erase->size_shift) - 1;=0A=
> >> +     if (size) {=0A=
> >> +             erase->size_shift =3D ffs(size) - 1;=0A=
> >> +             erase->size_mask =3D (1 << erase->size_shift) - 1;=0A=
> >> +     } else {=0A=
> >> +             erase->size_shift =3D 0;=0A=
> >> +             erase->size_mask =3D 0;=0A=
> >> +     }=0A=
> >> =0A=
> >>  }=0A=
> >>=0A=
> >>=0A=
> >>=0A=
> >>  /**=0A=
> > =0A=
> > =0A=
> > What is the status of this patch? It is not applied up until now, no? H=
as=0A=
> > it=0A=
 been superseeded?=0A=
> > =0A=
> =0A=
> =0A=
> I think it's marked with "changes requested". I'm going to send a v2.=0A=
=0A=
Is there a v2 somewhere?=0A=
=0A=
Best regards,=0A=
Alexander=0A=
