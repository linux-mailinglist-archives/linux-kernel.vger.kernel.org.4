Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9947223AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjFEKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjFEKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B5116;
        Mon,  5 Jun 2023 03:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D53614D5;
        Mon,  5 Jun 2023 10:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60829C433D2;
        Mon,  5 Jun 2023 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961454;
        bh=hAyKurn2OOaYTMwG3H4jsrgJYf3qIZ+AJycUSJ3bmZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l8xpfhqSyLuvOKs9VzQFn/gG3GT3Tqvmhur5Ai5En+UWLYVB4bMyoaBGJL/bjForQ
         TVfhhZSZdau4ICVIcQWCoRhsbdh14L073Dj71fE0DNrK5nqju1RYElC1my8cVmyZ/l
         I3Qk59uMcti09j8vl1159n/kV5YhJHy+pf9T5K9zVfugJ2sfe6JZlxBHWm1OKm9wKz
         I1AqvCkkn84Rt4zzNIgfHTWoyUV7h5fx059sOfltbgHPgnfVRhva6l8Kwjy3AOeC2a
         yrwrB607tvpUoLoSKWcki3OT9FyYTTjouzHDBnp0JjLquovaz3Cz2URzFqAqV+CELY
         wTExy5Lt6XaiA==
Date:   Mon, 5 Jun 2023 11:37:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <20230605113727.69e7f309@sal.lan>
In-Reply-To: <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
        <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 5 Jun 2023 11:38:49 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 escreveu:

> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> On 30.05.23 13:12, Thomas Voegtle wrote:
> >=20
> > I have the problem that sometimes my DVB card does not initialize
> > properly booting Linux 6.4-rc4.
> > This is not always, maybe in 3 out of 4 attempts.
> > When this happens somehow you don't see anything special in dmesg, but
> > the card just doesn't work.
> >=20
> > Reverting this helps:
> > commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
> > Author: Hyunwoo Kim <imv4bel@gmail.com>
> > Date:=C2=A0=C2=A0 Thu Nov 17 04:59:22 2022 +0000
> >=20
> > =C2=A0=C2=A0=C2=A0 media: dvb-core: Fix use-after-free on race conditio=
n at dvb_frontend
> >=20
> >=20
> > I have:
> > 03:00.0 Multimedia video controller [0400]: Conexant Systems, Inc.
> > CX23887/8
> > PCIe Broadcast Audio and Video Decoder with 3D Comb [14f1:8880] (rev 04)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Hauppauge compute=
r works Inc. Device [0070:c138]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: cx2388=
5 =20
>=20
> Hmmm, that was posted last Tuesday and received not a single reply. :-/
>=20
> Hyunwoo Kim: could you please look at it, as it's a regression caused by
> a commit of yours (one that would be good to solve before 6.4 is
> finalized!)? And in case you are unable to do so let us know?
>=20
> But FWIW:
>=20
> Mauro: I wonder if this is something you or someone else has to look
> into, as Hyunwoo Kim posted a few times per months to Linux lists, but
> according  to a quick search on lore hasn't posted anything since ~two
> months now. :-/

Yeah, I was slow applying this one, as I was afraid of it to cause
troubles. The DVB frontend state machine is complex, and uses a
semaphore to update its state. There was some past attempts of
addressing some lifetime issues there that we ended needing to revert
or not being applied, as the fix caused more harm than good.

The way DVB tuning works is that it uses a zigzag mechanism to
tune to a frequency. It actually tries to tune at several different
frequencies, like:

	f
	f + delta
	f - delta
	f + 2 * delta
	f - 2 * delta
	...

the DVB core supports 3 different types of zigzag approaches:
	- hardware-based - no need to do any special implementation;
	- software-based - Kernel will try the above tunes in in a
	  zig-zag way;
	- custom-based - the hardware has some helpers to speedup
	  and improve the tuning logic.

If a signal is lost, the device will re-run the zigzag logic.

It is not trivial to test all possible conditions there, and some
boards may have multiple frontend devices for different types of
TV transmission (cable, satellite, air).

As I don't have a DVB signal generator anymore, my tests were limited to=20
devices I have it handy that are compatible with DVB/T.=20

In any case, we need more details about the problem, as CX23887 is just
the media streaming PCIe bridge device. It tells nothing about what
frontend is attached to the bridge.

Regards,
Mauro
