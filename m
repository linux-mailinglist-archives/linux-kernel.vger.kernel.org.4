Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758337054EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjEPRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:25:46 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A7E7A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:25:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C69CB1C0003;
        Tue, 16 May 2023 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684257941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFevxj/rrkp09WHDPC8r1cjBszhyMx/0fchc8f659C8=;
        b=ah0R2drhxSyAsYICQwRvoJcC+ZAwy8OXWfWdXbNqkI7uilswu7AT4Ot1GJ/Ab2D11Owqhl
        ttM8vNs01fx7pam7U/I+/+hqueWpKfsCW+VXTUmx24gVOlYSSVpVElVYKLhXD0YttVol8d
        CkGYLe/Oisveabg+7id3ZwDEqbjsbBWcUs2aGiBsNTqvYZXPuPBvCgwXY/N3GbOqA5YSqX
        jfVWACoboMNH/sDI2sUXzSP5pH6+d1WMq0BlWk4ml4qWy5dq27+IGY+PCe6AbjCHaZZ4oL
        qt8JxscjZICxycfQmByooMkkTZkEfs0IXSkOEda9EaycprL0Bormxjc15jLzBw==
Date:   Tue, 16 May 2023 19:25:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Message-ID: <20230516192538.45b35b6b@xps-13>
In-Reply-To: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris!

Chris.Packham@alliedtelesis.co.nz wrote on Tue, 16 May 2023 04:46:38
+0000:

> Hi Miquel, Thomas,
>=20
> A hardware colleague reported a concern to me about a new design we have=
=20
> using the Marvell CN9130 SoC (which I think was called Armada-8K before=20
> they rebranded).
>=20
> Basically their concern is that the tWC timing they observe is faster=20
> (~18ns) than the documented minimum in the hardware datasheet for the=20
> CN9130 (25ns). Aside from not meeting the datasheet spec we've not=20
> observed any other issue (yet).

I would have expected the controller to support almost any kind of
timings, including SDR EDO mode 5. tWC is 25ns with mode 4, but 20 on
mode 5 (ONFI). So I believe you're running a system with a chip that is
not compatible with the fastest mode. If that is the case, it may
explain why you don't see errors with this chip: it may support
slightly faster timings than it advertises.

Anyway, if your findings are true, it means the current implementation
is slightly out of spec and the timing calculation might require to be
tweaked a little bit to reduce tWC.

> I notice in the marvell_nand.c driver that marvell_nfc_init() sets the=20
> NAND Clock Frequency Select bit (0xF2440700:0) to 1 which runs according=
=20
> to the datasheet the NAND flash at 400MHz . But the calculations in=20
> marvell_nfc_setup_interface() use the value from=20
> clk_get_rate(nfc->core_clk) which is still 250MHz so I'm wondering if=20
> maybe the fact that the NAND flash is being run faster is having an=20
> impact on timings that are calculated around the core_clk frequency.

What if you reset this bit? Do you observe different timings? I hope
you do, otherwise this is a dead-end.

The timings are derived from this clock but I remember seeing different
rates than the ones I expected with no obvious explanation (see the "*
2" in the calculation of period_ns and the comment right below). So
maybe this is due to the 400MHz vs. 250MHz issue you are reporting, or
there is an undocumented pre-scaler in-between (this is my original
guess).

> Do you think that the timings calculations should take the NAND Clock=20
> Frequency Select setting into account?

There is not much about this clock in the manual, so if the clock is
feeding the logic of the controller generating the signals on the bus,
then yes. You can verify this with the test mentioned above.

Could you check the values set to tWP and tWH with and without the bit
and probe the signals in both cases? Maybe the "* 2" in the
period_ns calculation will vanish if we use 400MHz as input clock rather
than clk_get_rate() (or better, expose the bit as a mux-clock and use
it to tell the CCF the right frequency) and you'll get a sharper tWC in
the end, which hopefully should match the spec this time.

Thanks,
Miqu=C3=A8l
