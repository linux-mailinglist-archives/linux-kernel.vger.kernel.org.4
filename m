Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762256175F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKCFEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCFEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:04:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9A12D3E;
        Wed,  2 Nov 2022 22:04:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A354Xm1121633;
        Thu, 3 Nov 2022 00:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667451873;
        bh=iyDAmYDeroflNKLReuHpG9mB0WIknotKzeCIWGGdcQY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qGcWLGYK7q/FIT1Y0vTvTiaVjczA2SoYm/2lEb/OgEWu2VNoFzRAJIZQtDksS70uU
         N56HTCD9kILZEqGUpxQEf5sTeHgs94xHiTIYmRcd55ALk7nNFqKQ9f/HL3MjRX7Eve
         AlzdehCDoy1NQ7VnYKAW/MbRrVjz8+rzGNwZ1E4E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A354XBY054071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 00:04:33 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 00:04:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 00:04:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A354Xuf052085;
        Thu, 3 Nov 2022 00:04:33 -0500
Date:   Thu, 3 Nov 2022 00:04:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: Use devm_bitmap_zalloc when applicable
Message-ID: <20221103050433.pp52c4goatd27gny@client>
References: <1bd77909ff75f62a2228a39db208c4c6d1b3e0e2.1632659746.git.christophe.jaillet@wanadoo.fr>
 <20210927133807.rtkfjkxxlwpdqcnf@scouring>
 <788db74a-f3fd-4685-82b9-3257106c6260@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <788db74a-f3fd-4685-82b9-3257106c6260@wanadoo.fr>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:40-20221031, Christophe JAILLET wrote:
> Le 27/09/2021 à 15:38, Nishanth Menon a écrit :
> > On 14:36-20210926, Christophe JAILLET wrote:
> > > 'xfer_alloc_table' is a bitmap. So use 'devm_bitmap_zalloc()' to simplify
> > > code and improve the semantic of the code.
> > > 
> > > While at it, remove a redundant 'bitmap_zero()' call.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > >   drivers/firmware/ti_sci.c | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > > index 235c7e7869aa..a33eb884102f 100644
> > > --- a/drivers/firmware/ti_sci.c
> > > +++ b/drivers/firmware/ti_sci.c
> > > @@ -3352,13 +3352,11 @@ static int ti_sci_probe(struct platform_device *pdev)
> > >   	if (!minfo->xfer_block)
> > >   		return -ENOMEM;
> > > -	minfo->xfer_alloc_table = devm_kcalloc(dev,
> > > -					       BITS_TO_LONGS(desc->max_msgs),
> > > -					       sizeof(unsigned long),
> > > -					       GFP_KERNEL);
> > > +	minfo->xfer_alloc_table = devm_bitmap_zalloc(dev,
> > > +						     desc->max_msgs,
> > > +						     GFP_KERNEL);
> > >   	if (!minfo->xfer_alloc_table)
> > >   		return -ENOMEM;
> > > -	bitmap_zero(minfo->xfer_alloc_table, desc->max_msgs);
> > >   	/* Pre-initialize the buffer pointer to pre-allocated buffers */
> > >   	for (i = 0, xfer = minfo->xfer_block; i < desc->max_msgs; i++, xfer++) {
> > > -- 
> > > 2.30.2
> > > 
> > 
> > Reviewed-by: Nishanth Menon <nm@ti.com>
> > 
> 
> Hi,
> 
> another similar patch has been merged against 'drivers/firmware/ti_sci.c'
> just a few days ago, so this one could also be applied.
> 
> Let me know if I need to rebase and/or resend it.


Yes please - please rebase and resend.. wow, [1] that is over an year old..
Sorry for letting it slip through the fingers


[1] https://lore.kernel.org/all/1bd77909ff75f62a2228a39db208c4c6d1b3e0e2.1632659746.git.christophe.jaillet@wanadoo.fr/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
