Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232E70B81D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjEVIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjEVIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:54:29 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21623F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:54:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 876461BF208;
        Mon, 22 May 2023 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684745665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHK3C0C9AUOwNQWyX63XZc6cyaepXro+wC3B3TZT6F4=;
        b=L00HJpwUIjO81e/BD8sM711lE8ChvdDMcLZWW92fiqHumqUXk8mVf49Ou+6E0w4b7IJB1V
        pUrNt5OoWXakElRQBB7M2M6QP2r1DOf+lo16Mzmb7PmKIxSod1ndf9UEyhFuBvSpFy3pCr
        MJWRus7S1D0y+77b1ELNfT3XUOZaIjjpsAcRC2nyWNFdcNPGurn7i0TxgYS3UDRkvVToFL
        mACvZuhBq65WyOMHr8XVkpoFmkkGIYAap6KcEPhmjTxR6Js5Vr0qiSHRrrgVYbj72siPym
        JRPJ5njwX75w+cjm5yCKajNbAV0SotCoBQNHVnkuO8BGbEt+HqpuCgmPPlkaLA==
Date:   Mon, 22 May 2023 10:54:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Message-ID: <20230522105424.6e86b135@xps-13>
In-Reply-To: <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
        <20230516192538.45b35b6b@xps-13>
        <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
        <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
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

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Sun, 21 May 2023 22:53:35
+0000:

> On 17/05/23 14:22, Chris Packham wrote:
> >
> > On 17/05/23 05:25, Miquel Raynal wrote: =20
> >> Hi Chris!
> >>
> >> Chris.Packham@alliedtelesis.co.nz wrote on Tue, 16 May 2023 04:46:38
> >> +0000:
> >> =20
> >>> Hi Miquel, Thomas,
> >>>
> >>> A hardware colleague reported a concern to me about a new design we=20
> >>> have
> >>> using the Marvell CN9130 SoC (which I think was called Armada-8K befo=
re
> >>> they rebranded).
> >>>
> >>> Basically their concern is that the tWC timing they observe is faster
> >>> (~18ns) than the documented minimum in the hardware datasheet for the
> >>> CN9130 (25ns). Aside from not meeting the datasheet spec we've not
> >>> observed any other issue (yet). =20
> >> I would have expected the controller to support almost any kind of
> >> timings, including SDR EDO mode 5. tWC is 25ns with mode 4, but 20 on
> >> mode 5 (ONFI). So I believe you're running a system with a chip that is
> >> not compatible with the fastest mode. If that is the case, it may
> >> explain why you don't see errors with this chip: it may support
> >> slightly faster timings than it advertises.
> >>
> >> Anyway, if your findings are true, it means the current implementation
> >> is slightly out of spec and the timing calculation might require to be
> >> tweaked a little bit to reduce tWC.
> >> =20
> >>> I notice in the marvell_nand.c driver that marvell_nfc_init() sets the
> >>> NAND Clock Frequency Select bit (0xF2440700:0) to 1 which runs=20
> >>> according
> >>> to the datasheet the NAND flash at 400MHz . But the calculations in
> >>> marvell_nfc_setup_interface() use the value from
> >>> clk_get_rate(nfc->core_clk) which is still 250MHz so I'm wondering if
> >>> maybe the fact that the NAND flash is being run faster is having an
> >>> impact on timings that are calculated around the core_clk frequency. =
=20
> >> What if you reset this bit? Do you observe different timings? I hope
> >> you do, otherwise this is a dead-end. =20
> > Yes if we clear the bit the timings go from ~18ns to about 30ns. =20
> >> The timings are derived from this clock but I remember seeing different
> >> rates than the ones I expected with no obvious explanation (see the "*
> >> 2" in the calculation of period_ns and the comment right below). So
> >> maybe this is due to the 400MHz vs. 250MHz issue you are reporting, or
> >> there is an undocumented pre-scaler in-between (this is my original
> >> guess). =20
> >
> > I wondered if the * 2 was because of this or because of the comment=20
> > that the ECC_CLK is 2*NF_CLK. That probably also means that a number=20
> > of SoCs are running with an extra *2 that don't need to be (e.g.=20
> > Armada-385). =20
> Interestingly cp110-system-controller.c is aware of the 400MHz option=20
> but that's only effective if it's been set prior to the kernel booting.=20
> I'm not really familiar with clk drivers but I assume it must be=20
> possible to make it look up the frequency dynamically instead of using a=
=20
> single fixed value.

We are accessing the bit directly in the NAND controller driver,
perhaps there should be some ops exposed and used in order to pick one
or the other of the two clock sources.

Thanks,
Miqu=C3=A8l
