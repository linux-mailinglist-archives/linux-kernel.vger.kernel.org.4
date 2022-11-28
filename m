Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4963AEAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiK1RQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiK1RQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:16:34 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69402714E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:16:33 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASH8ZEA017796;
        Mon, 28 Nov 2022 11:16:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=Ysp7yEEEjrbxgizhPJQk9yEA9z+SruXVanPKB7nfQkU=;
 b=AyPM2bg2NU4yi+yllpSCZBQmKiRYlxPUxpwA862FCQmZdrmGKDBUwCiCMsgn8nO4I/Bq
 b5WwjxGihUc49BA7Nt2XIlzyEYxvghZW0oe04EtXZEkqgx5zZvQ0maZsaYwzPlQFBlzf
 jNumLBEmnpCZ+k7zK6qTb5DZqiWwJ1+WSMtEcZT42SSEV8CNCUvJFJpCwldRTLEvwSBE
 YmU1se6Qr0k/bSc9exPIPtVtDpNWY0fjNZTeVG6Y65apPW+hEVoGPbGhT14bWgrScgCd
 gSwtn41wHAKprZCy0h43zJJeqUUJ6Bk0QRH0n1LliE7jlxO3mbGXw1xb7zxOCRUX8x1X Vg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m3g3vj5xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 11:16:23 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 28 Nov
 2022 11:16:22 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Mon, 28 Nov 2022 11:16:22 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 310E4B10;
        Mon, 28 Nov 2022 17:16:22 +0000 (UTC)
Date:   Mon, 28 Nov 2022 17:16:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: cs42l51: Correct PGA Volume minimum value
Message-ID: <20221128171622.GI105268@ediswmail.ad.cirrus.com>
References: <20221125163748.1288942-1-ckeepax@opensource.cirrus.com>
 <20221125163748.1288942-2-ckeepax@opensource.cirrus.com>
 <CABDcavbtBBU7ySPK32104nZB5RHf2=LFuOOYOF-Ze1EDoM+etw@mail.gmail.com>
 <20221128094829.GH105268@ediswmail.ad.cirrus.com>
 <CABDcavZy0xki9BRr350aV3Mv1NGe3hDTSGi2NY30T3brTmnzQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABDcavZy0xki9BRr350aV3Mv1NGe3hDTSGi2NY30T3brTmnzQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: F2vVJmKKW5sReidFJwwMvDN2TOJ8WIa6
X-Proofpoint-ORIG-GUID: F2vVJmKKW5sReidFJwwMvDN2TOJ8WIa6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:14:43PM +0100, Guillermo Rodriguez Garcia wrote:
> El lun, 28 nov 2022 a las 10:48, Charles Keepax
> (<ckeepax@opensource.cirrus.com>) escribió:
> > On Sat, Nov 26, 2022 at 12:15:10PM +0100, Guillermo Rodriguez Garcia wrote:
> > > El vie, 25 nov 2022 a las 17:37, Charles Keepax
> > > (<ckeepax@opensource.cirrus.com>) escribió:
> > > >
> > > > The table in the datasheet actually shows the volume values in the wrong
> > > > order, with the two -3dB values being reversed. This appears to have
> > > > caused the lower of the two values to be used in the driver when the
> > > > higher should have been, correct this mixup.
> > > >
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > > @@ -143,7 +143,7 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
> > > >                         0, 0xA0, 96, adc_att_tlv),
> > > >         SOC_DOUBLE_R_SX_TLV("PGA Volume",
> > > >                         CS42L51_ALC_PGA_CTL, CS42L51_ALC_PGB_CTL,
> > > > -                       0, 0x19, 30, pga_tlv),
> > > > +                       0, 0x1A, 30, pga_tlv),
> > >
> > > The original patch where this control was added [1] already used 0x1A,
> > > however this was later changed to 0x19 in [2]. Your patch now reverts
> > > that change. Does this mean [2] was incorrect? If that is the case,
> > > shouldn't the commit message for this patch mention that it fixes [2]
> > > ?
> > >
> > >  [1]: https://lore.kernel.org/all/20200918134317.22574-1-guille.rodriguez@gmail.com/
> > >  [2]: https://lore.kernel.org/all/20220602162119.3393857-7-ckeepax@opensource.cirrus.com/
> > >
> >
> > Hmm... good digging, I didn't realise it was me who broke that.
> > Apologies in that chain I went around and checked a bunch of SX
> > controls to make sure they matched the datasheets, but it seems
> > I got a bit confused by the weird ordering of the values in the
> > datasheet. Since you have hardware would you be able to check,
> > before we merge this revert? A simple check that writing 0 to the
> > control sets the register value to 0x1A and writing 30 sets the
> > register to 0x18 would suffice.
> 
> Just checked. The values are correct after applying the patch:
> 
> $ amixer cset name='PGA Volume' '0','0'
> $ i2cget -y -f  2 0x4A 0x0A
> 0x1a
> $ i2cget -y -f  2 0x4A 0x0B
> 0x1a
> $ amixer cset name='PGA Volume' '30','30'
> $ i2cget -y -f  2 0x4A 0x0A
> 0x18
> $ i2cget -y -f  2 0x4A 0x0B
> 0x18

Excellent thank you so much for your help on this. I will send a
new version of the patch with the fixes tag applied.

Thanks,
Charles
