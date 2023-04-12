Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265AB6DF3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDLLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDLLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:44:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FAA40F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:43:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9D03B5FD61;
        Wed, 12 Apr 2023 14:43:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681299813;
        bh=0thXj7LpCNhaF+hkJiRsRop/FhKHj2sfDcU1g5bpUNg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=W8mOdJkKfI1zcOXHvmMGmqWaefeCM7ua//z0q853eqxsDKZwR8Li6IpQXxJWNpuna
         T5iVf8OSRxpzjKpLqpwjmRv86KEmXF5QD252zhc8bgxGn2fxZTx/lQa07u70bFppfY
         2kVAItJnyriwe4Xx0mN4TOsQ78xVVBAUZfoOvqPKUM/kZ/JgeecRGkWMjoC45b4E0k
         cCHwr1X6iD7OFgYnhX4W1umvpoL2Rr/fXUv/JdRu75GCr7a3ZLpvkeXgPNaJPhlfZE
         yOGQApyGzQUTm+TUvM+I5wSMsHThD67AsjzZEE1xSQN0fu6Ro3mcIpXI205lespRu9
         EHvW4mI4Aic3g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 14:43:32 +0300 (MSK)
Date:   Wed, 12 Apr 2023 14:43:26 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>
CC:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Message-ID: <20230412114326.fn3nm5r3rzlnqgg7@CAB-WSD-L081021>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <4baac18b-c223-d346-503c-f5f9ae49320d@amlogic.com>
 <fe03919a-3468-b79e-5971-1f7671684ee9@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe03919a-3468-b79e-5971-1f7671684ee9@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/12 04:12:00 #21090163
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liang,

On Wed, Apr 12, 2023 at 07:36:30PM +0800, Liang Yang wrote:
> Hi,
> 
> On 2023/4/12 18:51, Liang Yang wrote:
> > > > > > > diff --git a/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > b/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > index f84a10238e4d..f2f2472cb511 100644
> > > > > > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > @@ -858,9 +858,12 @@ static int
> > > > > > > meson_nfc_read_page_sub(struct nand_chip *nand,
> > > > > > >   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
> > > > > > >                      int oob_required, int page)
> > > > > > >   {
> > > > > > > +    struct mtd_info *mtd = nand_to_mtd(nand);
> > > > > > >       u8 *oob_buf = nand->oob_poi;
> > > > > > >       int ret;
> > > > > > > +    memset(oob_buf, 0, mtd->oobsize);
> > > > > > 
> > > > > > I'm surprised raw reads do not read the entire OOB?
> > > > > 
> > > > > Yes! Seems in case of raw access (what i see in this driver)
> > > > > number of OOB bytes read
> > > > > still depends on ECC parameters: for each portion of data
> > > > > covered with ECC code we can
> > > > > read it's ECC code and "user bytes" from OOB - it is what i
> > > > > see by dumping DMA buffer by
> > > > > printk(). For example I'm working with 2K NAND pages, each
> > > > > page has 2 x 1K ECC blocks.
> > > > > For each ECC block I have 16 OOB bytes which I can access by
> > > > > read/write. Each 16 bytes
> > > > > contains 2 bytes of user's data and 14 bytes ECC codes. So
> > > > > when I read page in raw mode
> > > > > controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB
> > > > > is reported as 64 bytes.
> > > > 
> > > > In all modes, when you read OOB, you should get the full OOB. The fact
> > > > that ECC correction is enabled or disabled does not matter. If the NAND
> > > > features OOB sections of 64 bytes, you should get the 64 bytes.
> > > > 
> > > > What happens sometimes, is that some of the bytes are not protected
> > > > against bitflips, but the policy is to return the full buffer.
> > > 
> > > Ok, so to clarify case for this NAND controller:
> > > 1) In both ECC and raw modes i need to return the same raw OOB data
> > > (e.g. user bytes
> > >     + ECC codes)?
> > > 2) If I have access to only 32 bytes of OOB (in case above), I must
> > > report that size
> > >     of OOB is only 32 bytes during initialization?
> > > 
> > > Thanks, Arseniy
> > 
> > Yes. it should return all the OOB data. i make a mistake on raw read and
> > there is wrong code in meson_nfc_read_page_raw().
> >      meson_nfc_get_data_oob(nand, buf, oob_buf);
> > changed to:
> >      if (oob_required)
> >          memcpy(oob_buf, buf + mtd->writesize, mtd->oobsize)
> 
> Sorry, please ignore this. the previous code is right.
> 
> the controller changes the layout of one page; the physical layout is 2048
> main data + 64 oob data. after writing into NAND page, it is stored
> like this: 1024 main data + 2 user bytes + 14 ECC parity bytes + 1024 main
> data + 2 user bytes + 14 ECC parity bytes. so that is right we only get 4
> user bytes and 28 ECC parity bytes, total 32 bytes. that is the behavior of
> the controller that transferring one ECC page(1KB) brings back only 2 user
> bytes.
> 
> because layout is changed by controller, so go back to the function.
> meson_nfc_get_data_oob(nand, buf, oob_buf) try to get the right user and ecc
> parity bytes from the right pos. after that, the other oob bytes is not
> reading from NAND flash.

I have always been under the impression that NAND OOB layout falls under the
responsibility of the flash driver. Is this specific to the Amlogic NAND,
and does it map the flash layout to the internal controller layout?
For example, different OOB layouts exist between Macronix and ESMT.

Apologies for any confusion, and thank you in advance for any help in
clarifying this matter.

-- 
Thank you,
Dmitry
