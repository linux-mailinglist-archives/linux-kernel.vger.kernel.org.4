Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39F710E61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbjEYOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjEYOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:32:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09D9101;
        Thu, 25 May 2023 07:32:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:17:6c0::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AEDD2660571B;
        Thu, 25 May 2023 15:32:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685025145;
        bh=bKbvtkUjIXfSUWM6dkyu+X6aQMMPjIEiQFqcy9qp028=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JfIV8qpz5SLjVJ59PNVTZZJKHSNSvUS5Qug+7PWKXWK3wTXxSIJY5c4PC7gRBwS9j
         i/CM0SrFbAzLeHEJAdyE0mwU5YD5or8yLv3+YsQ/ef8SfwKU7YmB40bwlIjdgb0ACb
         /YMKtddMmPscABm5Yifra7az7Qqsy7Cr1by9umc4ww5dzAa9Fhfw1I5S3FMA2YBTHL
         3UFEqPcdqYwEUEFbkTdK+vHRJHLyb3ZYTwFORVXMPI7izlYGcnMjiV+aOf943gGK2S
         qrPNPUIS2cWepzogDg3nbzsRP33PIcXVMiEzuzATfX18D762xmZxepZRw9a0x/GtNp
         M2oV4aNp56RIA==
Message-ID: <bec8c0b0decc16b3533fadec8ad0f6d5c2f37d98.camel@collabora.com>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Date:   Thu, 25 May 2023 10:32:15 -0400
In-Reply-To: <20230523145430.GB9943@pengutronix.de>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
         <4995215.LvFx2qVVIh@bagend>
         <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
         <12724349.O9o76ZdvQC@bagend>
         <5d871928-dcd5-3f27-e975-d1639525dad0@leemhuis.info>
         <20230523145430.GB9943@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micheal,

Le mardi 23 mai 2023 =C3=A0 16:54 +0200, Michael Tretter a =C3=A9crit=C2=A0=
:
> On Tue, 23 May 2023 12:50:42 +0200, Linux regression tracking (Thorsten L=
eemhuis) wrote:
> > CCing the Regression list and a bunch of other people that were CCed in
> > threads that look related:
>=20
> Thanks!
>=20
> >=20
> > On 23.05.23 00:38, Diederik de Haas wrote:
> > > On Monday, 22 May 2023 18:17:39 CEST Benjamin Gaignard wrote:
> > > > Le 20/05/2023 =C3=A0 00:34, Diederik de Haas a =C3=A9crit :
> > > > > On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
> > > [...]
> > > > > When I booted into my 6.4-rc1 (but also rc2) kernel on my
> > > > > Pine64 Quartz64 Model A, I noticed a crash which seems the same a=
s
> > > > > above, but I didn't have such a crash with my 6.3 kernel.
> > > > > Searching for 'hantro' led me to this commit as the most likely c=
ulprit
> > > > > but when I build a new 6.4-rcX kernel with this commit reverted,
> > > > > I still had this crash.
> > > > > Do you have suggestions which commit would then be the likely cul=
prit?
> > > >=20
> > > > This patch fix the crash at boot time, revert it doesn't seem to be=
 the
> > > > solution. Maybe this proposal from Marek can help you ?
> > > >=20
> > > > https://patchwork.kernel.org/project/linux-media/patch/202304211047=
59.2236463-1-m.szyprowski@samsung.com/
> > >=20
> > > That helped :) After applying that patch I no longer have the crash.
> > > Thanks!
> >=20
> > That regression fix is now a month old, but not yet merged afaics --
> > guess due to Nicolas comment that wasn't addressed yet and likely
> > requires a updated patch.
>=20
> I agree with Nicolas comment on that patch and it needs to be updated.
>=20
> >=20
> > Michael afaics a week ago posted a patch that to my *very limited
> > understanding of things* (I hope I don't confuse matters here!) seems t=
o
> > address the same problem, but slightly differently:
> > https://lore.kernel.org/all/20230516091209.3098262-1-m.tretter@pengutro=
nix.de/
>=20
> Correct, my patch addresses the same problem.

Sorry, just got really busy and missed the second fix. From a hot fix stand
point, your patch seems a lot safer. It does not go as far, and probably do=
es
not make the driver better, but considering we had such a slow response we =
need
to do something about it.

Ezequiel, will you be fine with the approach ?

>=20
> >=20
> > No reply yet.
> >=20
> > That's all a bit unfortunate, as it's not how regression fixes should b=
e
> > dealt with -- and caused multiple people headaches that could have been
> > avoided. :-/
> >=20
> > But well, things happen. But it leads to the question:
> >=20
> > How can we finally address the issue quickly now to ensure is doesn't
> > cause headaches for even more people?
> >=20
> > Marek, Michael, could you work on a patch together that we then get
> > somewhat fast-tracked to Linus to avoid him getting even more unhappy
> > about the state of things[1]?
>=20
> Marek, if you have an updated patch, I will happily test and review it.
> Otherwise, please take a look at my patch.
>=20
> Michael
>=20

