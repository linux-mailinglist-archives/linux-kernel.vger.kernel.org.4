Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E56CC79B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjC1QNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjC1QNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:13:13 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA659E3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:13:10 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
        s=key1; t=1680019986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8ARlzbTl5QqSbajziRCI8Zk38P8YAgbzoAWx4qoaCY=;
        b=zjeGv2B/164RL1wKpUtQEzqBejTvSN3GFtp9J3zdACwe9gXcNw8emp2c1ESj9+QIMElMgI
        VFGOp5hLiRmXwUbFFZ1cxlxIL1kSAHtVRD5VMzyD00qUDoD9ETrh9mNvKNNagZVKN4OqYr
        un+ks7TOLlmZQ2Fzllt+/ZtABwncUbMcPV4fQOZB7+dEDRIUR84Zwd7lSj1LfcfjaoEJqd
        7U5iciAOIpLQ+vzmA4FYvbHHEttWin7T19WzFbBCl3o1FMmlBpxmMhJqmn1YgNmq7ZtrE1
        /8cBpunpPXFrs/b+xlVz/hBsDB2qn/Nv3rHdD/2AEuTe/yZDz7CzWdm+M05tmQ==
Date:   Tue, 28 Mar 2023 16:13:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   alyssa@rosenzweig.io
Message-ID: <550d7f7b3cc176784d6bd5a636e7b3d9@rosenzweig.io>
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and
 stop using the subsystem
To:     "Hector Martin" <marcan@marcan.st>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Janne Grunau" <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves the firmware crashes related to queue overflow that I hit. =
Thank you for fixing this, Hector!=0A=0ASeries is=0A=0A    Acked-by: Alys=
sa Rosenzweig <alyssa@rosenzweig.io>=0A=0A[I'd give a stronger tag but I'=
m way out of my depths here for review. ++ on the ideas though.]=0A=0AMar=
ch 28, 2023 9:14 AM, "Hector Martin" <marcan@marcan.st> wrote:=0A=0A> Onc=
e upon a time, Apple machines had some mailbox hardware, and we had=0A> t=
o write a driver for it. And since it was a mailbox, it felt natural to=
=0A> use the Linux mailbox subsystem.=0A> =0A> More than a year later, it=
 has become evident that was not the right=0A> decision.=0A> =0A> Linux d=
river class subsystems generally exist for a few purposes:=0A> 1. To allo=
w mixing and matching generic producers and consumers.=0A> 2. To implemen=
t common code that is likely to be shared across drivers,=0A> and do so c=
orrectly so correct code only has to be written once.=0A> 3. To force dri=
vers into a "correct" design, such that driver authors=0A> avoid common p=
itfalls.=0A> =0A> The mailbox subsystem does not do any of the above for =
us:=0A> 1. Mailbox hardware is not generic; "mailbox" is a vague idea, no=
t a=0A> standard for communication. Almost all mailbox consumers are tied=
 to=0A> one or a few producers. There is practically no mixing and matchi=
ng=0A> possible. We have one (1) consumer subsystem (RTKit) talking to on=
e=0A> (1) mailbox driver (apple-mailbox). We might have a second consumer=
=0A> in the future (SEP), but there will still be no useful=0A> combinatr=
onics with other drivers.=0A> 2. The mailbox subsystem implements a bunch=
 of common code for queuing,=0A> but we don't need that because our hardw=
are has hardware queues. It=0A> also implements a bunch of common code fo=
r supporting multiple=0A> channels, but we don't need that because our ha=
rdware only has one=0A> channel (it has "endpoints" but those are just ta=
gs that are part of=0A> the message). On top of this, the mailbox subsyst=
em makes design=0A> decisions unsuitable for our use case. Its queuing im=
plementation=0A> has a fixed queue size and fails sends when full instead=
 of pushing=0A> back by blocking, which is completely unsuitable for high=
-traffic=0A> mailboxes with hard reliability requirements, such as ours. =
We've=0A> also run into multiple issues around using mailbox in an atomic=
=0A> context (required for SMC reboot/shutdown requests).=0A> 3. Mailbox =
doesn't really do much for us as far as driver design.=0A> If anything, i=
t has been forcing us to add extra workarounds for the=0A> impedance mism=
atches between the subsystem core and the hardware.=0A> Other drivers alr=
eady are inconsistent in how they use the mailbox=0A> core, because the d=
ocumentation is unclear on various details.=0A> =0A> The interface for ma=
ilboxes is very simple - basically just a send() and=0A> a receive callba=
ck. This series quite literally just rips out the=0A> middleman, and conn=
ects both sides together directly. There just isn't=0A> anything useful t=
he mailbox common code is doing for us - it's just a=0A> pile of complexi=
ty in the middle that adds bugs, impedance mismatches,=0A> overhead, and =
offers no extra features we can use.=0A> =0A> This series offers:=0A> =0A=
> - A modest reduction in overall code size (-27 net lines excluding #1).=
=0A> - Fixes a pile of bugs related to using the mailbox subsystem and it=
s=0A> quirks and limitations (race conditions when messages are already i=
n=0A> the queue on startup, atomic issues, the list goes on).=0A> - Adds =
runtime-PM support.=0A> - Adds support for the FIFOs in the mailbox hardw=
are, improving=0A> performance.=0A> - Simplifies code by removing extrane=
ous memory allocations (the=0A> mailbox subsystem requires consumers to p=
ass pointers to messages,=0A> instead of inlining them, even though messa=
ges are usually only one or=0A> two registers in size) and the requisite =
cleanup/freeing in the=0A> completion path.=0A> =0A> In addition, it pave=
s the way for future Apple-specific mailbox=0A> optimizations, such as ad=
ding the ability to de-duplicate message sends=0A> if the same message is=
 already known to be in the FIFO (which can be=0A> done by keeping a roll=
ing history of recently sent messages). This is=0A> useful for doorbell-s=
tyle messages, which are redundant to send more=0A> than once if not yet =
processed.=0A> =0A> Apple Silicon platforms use these mailboxes pervasive=
ly, including as=0A> part of the GPU submission hot path. On top of that,=
 bad interactions=0A> with firmware coprocessors can cause immediate lock=
ups or crashes with=0A> no recovery possible but a reboot. Our requiremen=
ts for reliability and=0A> performance are probably much higher than the =
average mailbox user, and=0A> we'd much rather not have a bunch of common=
 code getting in the way of=0A> performance profiling and future optimiza=
tion. It doesn't make much=0A> sense for the mailbox subsystem either, si=
nce solving these issues would=0A> require major refactoring that is unli=
kely to provide significant=0A> benefit to most other users.=0A> =0A> So =
let's just call usage of the mailbox subsystem a failed experiment,=0A> a=
nd move the driver into soc/apple, where we can control the API and can=
=0A> add whatever peculiarities we need for our mailboxes. Farewell, mail=
box.=0A> =0A> There are no changes to the DT bindings. This driver has be=
en shipping=0A> in Asahi stable kernel packages for a week, with no regre=
ssions=0A> reported by any users.=0A> =0A> As an additional non-kernel-re=
lated benefit, this introduces a direct=0A> module dependency between con=
sumers and the mailbox producer. This, in=0A> turn, is in the critical pa=
th for the NVMe driver on these platforms.=0A> Prior to this series, we h=
ad to have custom initramfs hooks to add=0A> apple-mailbox to distro init=
ramfses, and accidentally removing these=0A> hooks would result in a comp=
letely unbootable system (there is no way=0A> for standard initramfs mach=
inery to detect soft consumer/producer=0A> relationships like this, they =
usually just go looking for block device=0A> modules and their direct dep=
endencies). We still need the initramfs=0A> hooks for other things, but w=
ith this change, completely removing all=0A> Apple-related initramfs hook=
s will at least result in a *bootable*=0A> system so you can fix the prob=
lem. This has already bit several users,=0A> and it also means many more =
distros have a chance of working out of the=0A> box (enough to let you in=
stall extra stuff) on these platforms, instead=0A> of having a hard requi=
rement that *every single distro* fix up their=0A> initramfs generation i=
n order to even boot/install on these platforms at=0A> all.=0A> =0A> Jass=
i: Ideally I'd like to get an ack on this and merge it all through=0A> as=
ahi-soc, so we don't have to play things patch-by-patch across=0A> multip=
le merge cycles to avoid potentially broken intermediate states.=0A> =0A>=
 Signed-off-by: Hector Martin <marcan@marcan.st>=0A> ---=0A> Hector Marti=
n (5):=0A> soc: apple: rtkit: Get rid of apple_rtkit_send_message_wait=0A=
> soc: apple: mailbox: Add ASC/M3 mailbox driver=0A> soc: apple: rtkit: P=
ort to the internal mailbox driver=0A> mailbox: apple: Delete driver=0A> =
soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX=0A> =0A> MAINT=
AINERS | 2 -=0A> drivers/mailbox/Kconfig | 12 -=0A> drivers/mailbox/Makef=
ile | 2 -=0A> drivers/mailbox/apple-mailbox.c | 441 ---------------------=
----------------=0A> drivers/soc/apple/Kconfig | 15 +-=0A> drivers/soc/ap=
ple/Makefile | 3 +=0A> drivers/soc/apple/mailbox.c | 434 ++++++++++++++++=
++++++++++++++++++++=0A> drivers/soc/apple/mailbox.h | 48 ++++=0A> driver=
s/soc/apple/rtkit-internal.h | 8 +-=0A> drivers/soc/apple/rtkit.c | 133 +=
++--------=0A> include/linux/apple-mailbox.h | 19 --=0A> include/linux/so=
c/apple/rtkit.h | 18 --=0A> 12 files changed, 529 insertions(+), 606 dele=
tions(-)=0A> ---=0A> base-commit: bdfe6de2695c5bccc663a5a7d530f81925d8bc1=
0=0A> change-id: 20230328-soc-mailbox-3cb6bb2b0b2d=0A> =0A> Best regards,=
=0A> -- =0A> Hector Martin <marcan@marcan.st>
