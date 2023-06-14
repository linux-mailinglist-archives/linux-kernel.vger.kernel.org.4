Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8571611F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjE3NJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjE3NI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:08:57 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA592;
        Tue, 30 May 2023 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=X5ARCyzotT4QKjaVW0IeWuI4w9SRg4SsaoEHspvM/io=; b=Gi376FN2FvE4Udx+8/r3wCTWPi
        /xHfqEFjwuLHHWzcZ3bvWOx9tNmdW85P87xjtrM8kWK7elK8hM3ibmvo2VPNHR5QNGH9SH05nJes4
        z/5GmYzfggOVYVXItfXS2n5Vh8h1VNXKNBN/u5w2M2gyxq/WzzqzEUy3Dau3z/DjMXhM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:41434 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3z5Z-0005zt-Ko; Tue, 30 May 2023 09:08:38 -0400
Date:   Tue, 30 May 2023 09:08:36 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230530090836.27b8d080d6b6c022b303ac9e@hugovil.com>
In-Reply-To: <c15a90d6-b3c1-e432-9216-c4c1e2c44ce6@camlingroup.com>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <c15a90d6-b3c1-e432-9216-c4c1e2c44ce6@camlingroup.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 11:30:07 +0200
Lech Perczak <lech.perczak@camlingroup.com> wrote:

> W dniu 29.05.2023 o=A016:07, Hugo Villeneuve pisze:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Hello,
> > this patch series mainly fixes a GPIO regression and improve RS485 flag=
s and
> > properties detection from DT.
> >
> > It now also includes various small fixes and improvements that were pre=
viously
> > sent as separate patches, but that made testing everything difficult.
> >
> > Patch 1 fixes an issue when debugging IOcontrol register. After testing=
 the GPIO
> > regression patches (patches 6 and 7, tests done by Lech Perczak), it ap=
pers that
> > this patch is also necessary for having the correct IOcontrol register =
values.
> >
> > Patch 2 introduces a delay after a reset operation to respect datasheet
> > timing recommandations.
> >
> > Patch 3 fixes an issue with init of first port during probing.
> >
> > Patch 4 fixes a bug with the output value when first setting the GPIO d=
irection.
> >
> > Patch 5 is a refactor of GPIO registration code.
> >
> > Patches 6 and 7 fix a GPIO regression by (re)allowing to choose GPIO fu=
nction
> > for GPIO pins shared with modem status lines.
> >
> > Patch 8 allows to read common rs485 device-tree flags and properties.
> >
> > Patch 9 improves comments about chip variants.
> >
> > I have tested the changes on a custom board with two SC16IS752 DUART us=
ing a
> > Variscite IMX8MN NANO SOM.
> >
> > Thank you.
> >
> > Link: [v1] https://lkml.org/lkml/2023/5/17/967 <https://lkml.org/lkml/2=
023/5/17/967>
> > [v1] https://lkml.org/lkml/2023/5/17/777 <https://lkml.org/lkml/2023/5/=
17/777>
> > [v1] https://lkml.org/lkml/2023/5/17/780 <https://lkml.org/lkml/2023/5/=
17/780>
> > [v1] https://lkml.org/lkml/2023/5/17/785 <https://lkml.org/lkml/2023/5/=
17/785>
> > [v1] https://lkml.org/lkml/2023/5/17/1311 <https://lkml.org/lkml/2023/5=
/17/1311>
> > [v2] https://lkml.org/lkml/2023/5/18/516 <https://lkml.org/lkml/2023/5/=
18/516>
> > [v3] https://lkml.org/lkml/2023/5/25/7 <https://lkml.org/lkml/2023/5/25=
/7>
> >
> > Changes for V3:
> > - Integrated all patches into single serie to facilitate debugging and =
tests.
> > - Reduce number of exported GPIOs depending on new property
> > nxp,modem-control-line-ports
> > - Added additional example in DT bindings
> >
> > Changes for V4:
> > - Increase reset post delay to relax scheduler.
> > - Put comments patches at the end.
> > - Remove Fixes tag for patch "mark IOCONTROL register as volatile".
> > - Improve commit messages after reviews.
> > - Fix coding style issues after reviews.
> > - Change GPIO registration to always register the maximum number of GPI=
Os
> > supported by the chip, but maks-out GPIOs declared as modem control lin=
es.
> > - Add patch to refactor GPIO registration.
> > - Remove patch "serial: sc16is7xx: fix syntax error in comments".
> > - Remove patch "add dump registers function"
> >
> > Hugo Villeneuve (9):
> > serial: sc16is7xx: mark IOCONTROL register as volatile
> > serial: sc16is7xx: add post reset delay
> > serial: sc16is7xx: fix broken port 0 uart init
> > serial: sc16is7xx: fix bug when first setting GPIO direction
> > serial: sc16is7xx: refactor GPIO controller registration
> > dt-bindings: sc16is7xx: Add property to change GPIO function
> > serial: sc16is7xx: fix regression with GPIO configuration
> > serial: sc16is7xx: add call to get rs485 DT flags and properties
> > serial: sc16is7xx: improve comments about variants
> >
> > .../bindings/serial/nxp,sc16is7xx.txt | 46 ++++++
> > drivers/tty/serial/sc16is7xx.c | 150 +++++++++++++-----
> > 2 files changed, 156 insertions(+), 40 deletions(-)
> >
> >
> > base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942
>=20
> It would be a lot of sending, to do that for every patch separately, so f=
or whole series:
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
>=20
> And where applicable - for code patches:
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
>=20
> I tested whole series at the same time.
> I did my tests on an i.MX6 board with SC16IS760 over SPI, which differs a=
 tiny bit from SC16IS752,
> and everything works as it should.
> Thank you for fixing this!

Hi Lech,
thank for your feedback.

You mentioned before that without the patch "mark IOCONTROL register as vol=
atile", things were not working properly for you. Could you retest by remov=
ing this patch and see if things are still working?

Thank you, Hugo.
