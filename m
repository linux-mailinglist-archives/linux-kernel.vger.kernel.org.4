Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2217224CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjFELl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFELlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:41:25 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734629C;
        Mon,  5 Jun 2023 04:41:24 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QZWsF3WQBz9sqj;
        Mon,  5 Jun 2023 13:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685965281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7z/UoffUh1YYEy028D6jPchnsvqTeKCwT3Ef8OGYOM=;
        b=DRB3tloLf6ynRPZH2ivFGP2IpNHHWfCZtzG3piH8zTBeCGxvSJaTtZOf3zImsXo1hQpndm
        i9GSi/cFs4wKW91ao/5i03z6w2ps1YC04MvjF/2CZDxLHJfjaOPqR+yAaiiCpBbKQw1PGD
        /+dhOeLHOayY0Ve69W8SeCkZ8QRgSkno8Cb2YrYWJaDOxPr7g/dFV+pLK4Moa0OJX1BnUQ
        iTWvsGPFbjVTg6X19RamKwJlshnhA1mrwxkmUngrPsZr0kojmKNvyDNg7lXc8uPCkh8SPi
        euy2vDk88fM6qqKA5vMjpjvl2LTXui1dMoqGlEVFCqaY5Uot7RzpvbsCP2MEEQ==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev> <4831731.31r3eYUQgx@jernej-laptop>
 <bhjq4yxo7fvddq3kvvvbgefhyaygb5bwkzhsjp3adc5kp7ohtx@iclghpep3zkw>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM
 clocks
In-reply-to: <bhjq4yxo7fvddq3kvvvbgefhyaygb5bwkzhsjp3adc5kp7ohtx@iclghpep3zkw>
Date:   Mon, 05 Jun 2023 13:41:17 +0200
Message-ID: <877csi9lwi.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4QZWsF3WQBz9sqj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,
hi Maxime,

On 2023-06-02 at 09:34:03 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Thu, Jun 01, 2023 at 09:41:30PM +0200, Jernej =C5=A0krabec wrote:
>> Dne =C4=8Detrtek, 01. junij 2023 ob 07:16:45 CEST je Frank Oltmanns napi=
sal(a):
>> > Re: Why speed up factor calculation?
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > I'm not aware that the current implementation of calculating n, k, and=
 m
>> > poses a bottleneck in any situation. Again, while going through the
>> > code, I wondered why not save a few CPU cycles by precalculating the
>> > meaningful combinations. In my opinion, it does not have any side
>> > effects, so we might as well do it. (There is of course the side effect
>> > of using a higher rate, but this is unrelated to precalculation as I
>> > could as well employ a rate comparison that only allows lower rates, or
>> > only optionally higher rates.)
>> >
>> > > Clocks in general are very regression-prone, so I'd rather be a bit
>> > > conservative there, and "if it ain't broke, don't fix it".
>> >
>> > Sure, I get that.
>> >
>> > As I stated in my cover letter:
>> > "The motivation for these proposed changes lies in the current behavior
>> > of rate selection for NKM clocks, which doesn't observe the
>> > CLK_SET_RATE_PARENT flag. I.e. it does not select a different rate for
>> > the parent clock to find the optimal rate."
>> >
>> > I thought that this required this optimization to be implemented, but =
by
>> > now, I'm no longer sure. I'll probably continue investigating different
>> > paths for CLK_SET_RATE_PARENT for NKM clocks and follow up with new
>> > findings.
>>
>> Let's leave out any optimizations that are not apparently needed. Most c=
lock
>> rates are set only once at boot and others, like video clocks, not that =
often,
>> so a suboptimal code speed doesn't hurt currently.
>
> I'm not even sure we can make that assumption for video clocks. We might
> for a panel, but for a more "dynamic" output like HDMI all bets are off
> and depending on the monitor, the user settings and the userspace stack
> we can definitely expect the video clock to change quite frequently.

Thank you both for your valuable feedback!

The goal I head in mind was adjusting pll-video0's clock when setting
DCLK on Allwinner A64. And you're both right, I got sidetracked by
premature optimizations.

As I wrote elsewhere in this thread, I will submit a patchset for the
original goal and we can discuss potential needs for optimization there.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
