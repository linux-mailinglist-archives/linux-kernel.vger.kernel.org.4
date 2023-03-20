Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D126C0F95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCTKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCTKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:47:03 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F0CC3F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:44:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5543C5FD0F;
        Mon, 20 Mar 2023 13:43:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679308996;
        bh=iyUXeu3+jkqtK4aQs+x6vXU9UqkcLHAPrhpZ7EOKuCQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=eV7CpVjqOf2rynWDJ0YHKRjUdBwvUla8SDE2+t0+b0Nb6HZrnn66w7hv8oOa1+Ced
         j6snk9n5lHC0dC2+MCOg7P350vllYHTamMfgeQybKlI1jmXJOXFsKfsebii5dYlZLW
         pUZ50EleSJyANUJDSvRzlWRqlsrnqcpCMynPdoU7wZWd4fo+TRIirsyrcibsZ9vILh
         fpFvwNNWL630XPKjwFBg4M6+KNDdWi12/nNpG61n397oLDauw/bB5WuVEPkRRh//hx
         qOWFRlV7GNoB8cQS3mzfQVweLzSxa2BWdzDG9Av+1SQp/YOCpwcdp/mowh+xpQKryd
         ensde3VAvEWzA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 20 Mar 2023 13:43:15 +0300 (MSK)
Date:   Mon, 20 Mar 2023 13:43:14 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling
 ECC bit
Message-ID: <20230320104314.i2stk665xbrleb53@CAB-WSD-L081021>
References: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
 <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
 <20230313121808.27170d1b@xps-13>
 <dc46c06f-6b36-3c1c-bf96-2ef37e29dfdb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc46c06f-6b36-3c1c-bf96-2ef37e29dfdb@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/20 04:57:00 #20976224
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys!

Was it applied to some nand 'prepare-for-merge' release branch?

On Mon, Mar 13, 2023 at 12:23:12PM +0100, Neil Armstrong wrote:
> On 13/03/2023 12:18, Miquel Raynal wrote:
> > Hi Arseniy,
> > 
> > avkrasnov@sberdevices.ru wrote on Mon, 13 Mar 2023 10:36:11 +0300:
> > 
> > > Hello,
> > > 
> > > we reproduced this problem on one of our boards. It triggers very rare
> > > when 'usleep_range()' is present, but when sleeping is removed - it fires
> > > always. I suppose problem is with caching, as 'info_buf' memory is mapped by
> > > 'dma_map_single()'.
> > 
> > The fix looks really legitimate, indeed I get that the usleep_range()
> > might make it work most of the time but not always. Having this bit in
> > a DMA buf area is a bit strange. Well, the fix LGTM anyway.
> 
> Yep it looks legitimate!
> 
> LGTM
> 
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> > 
> > > 
> > > Thanks, Arseniy
> > > 
> > > On 13.03.2023 10:32, Arseniy Krasnov wrote:
> > > > 'info_buf' memory is cached and driver polls ECC bit in it. This bit
> > > > is set by the NAND controller. If 'usleep_range()' returns before device
> > > > sets this bit, 'info_buf' will be cached and driver won't see update of
> > > > this bit and will loop forever.
> > > > 
> > > > Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > ---
> > > >   drivers/mtd/nand/raw/meson_nand.c | 8 +++++++-
> > > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > > > index 5ee01231ac4c..2c05c08a0eaf 100644
> > > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > > @@ -176,6 +176,7 @@ struct meson_nfc {
> > > >   	dma_addr_t daddr;
> > > >   	dma_addr_t iaddr;
> > > > +	u32 info_bytes;
> > > >   	unsigned long assigned_cs;
> > > >   };
> > > > @@ -503,6 +504,7 @@ static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
> > > >   					 nfc->daddr, datalen, dir);
> > > >   			return ret;
> > > >   		}
> > > > +		nfc->info_bytes = infolen;
> > > >   		cmd = GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
> > > >   		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> > > > @@ -520,8 +522,10 @@ static void meson_nfc_dma_buffer_release(struct nand_chip *nand,
> > > >   	struct meson_nfc *nfc = nand_get_controller_data(nand);
> > > >   	dma_unmap_single(nfc->dev, nfc->daddr, datalen, dir);
> > > > -	if (infolen)
> > > > +	if (infolen) {
> > > >   		dma_unmap_single(nfc->dev, nfc->iaddr, infolen, dir);
> > > > +		nfc->info_bytes = 0;
> > > > +	}
> > > >   }
> > > >   static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
> > > > @@ -710,6 +714,8 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
> > > >   		usleep_range(10, 15);
> > > >   		/* info is updated by nfc dma engine*/
> > > >   		smp_rmb();
> > > > +		dma_sync_single_for_cpu(nfc->dev, nfc->iaddr, nfc->info_bytes,
> > > > +					DMA_FROM_DEVICE);
> > > >   		ret = *info & ECC_COMPLETE;
> > > >   	} while (!ret);
> > > >   }
> > 
> > 
> > Thanks,
> > Miquèl
> 

-- 
Thank you,
Dmitry
