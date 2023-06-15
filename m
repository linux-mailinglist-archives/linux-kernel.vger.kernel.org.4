Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD5731026
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbjFOHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbjFOHGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:06:30 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 00:06:16 PDT
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368992940
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812405; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z35I2ILvsAtMs15ceNif3qPbMYlr9+pGP81/YwLBPz8zQAx94Al2rX4l3/Uyh0QzNk
    bun7FoUp8ze8VZXrTgld1hQemvSJCK2D2MV/+gnDTXf8u3HtyvVFgX8oF4PaNh1TSeVL
    P8wF/kT8dpTxM2nuGHMDRNhWjuljiYCHwuegX0TIdeBRl0XFBa22g7WVzcspVBNVDx1a
    3UsaTq03l8Jk0rjl0PgvhSis/IiWUQfUOdiHfVYkqAdVNJG13LxEMQD79e3PsZ5eLb24
    BRS274G2FGuELmWOPcbj1fVCHbDzdoXTLOZzSIv62+4Bc6UW19yab9+FcvlosI7DREFc
    b9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812405;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=PR8fPbKAkvCQXQuKhuTQR1jC8AjzI+6SrbHUYHsdhaE=;
    b=N3ZE09vECa+E+wvfMbvRqCFFu5VYO+BrHy/3u/FjmD9klS/EHOz8rGA/OYE55Dk3eW
    29uMtUncNNgfkwqRnr+HxIQEuLEQGTm5Qc460+pqMtYB3rS32OCOurO1vaGl+kMxEBwQ
    aW5CQu0aznTx6rBAlLhdZDnHu4U9AiN9rEj9TG1ar+H9mlwIFZDC0vf8wxOZvRLwU+HG
    4znnaHW2K6zMJ+uufZtuYsauKlrIXqosh4Y1tGOfxuGpAgHDGgFVplguGrE0gyEqvhYh
    9+NWMa3yPOEfILysel8fgcFE2ogtX3CGw1zPWim13rN9vnZR710hjpSXjtbvF2Iz2UyB
    BsEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812405;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=PR8fPbKAkvCQXQuKhuTQR1jC8AjzI+6SrbHUYHsdhaE=;
    b=sd1dxISYgWPvhsPy/qC2wIsJpMDNWuOMJwmw+UWt1PmAsr+lI4fK/fc5rkh+qxQUZ9
    HpqxesUnlc4U8unaKBnPwTrgMW72KIlnWVi4Au5Wjsm4XiKuPZ3B97WzKeSwfrZ4ENx5
    47TNRs9FVcn5y9Zc+TRP3kp6fjEEmkC/3AuWWrY1BIGT4LODuz5q5RBM6kF9O/VXxFlt
    FRZVMsMOSvsYFxeF+eIaNF04ab4KmE7MojQQ9POsOHbijIs8kCJvPItU6D72TVyyulpw
    SVP8EM7QCu+siyOcBMmYWi1P3xU54U7ezmoE3vYBExvP+lITKgqDm+Yxmbg7Ig9CIx3f
    7qMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812405;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=PR8fPbKAkvCQXQuKhuTQR1jC8AjzI+6SrbHUYHsdhaE=;
    b=/NADSkDnAPDpJLU4WbmP/wScrDis4D8+PjYUB+aP1VNUIzIVtzD7yqeiP1E+5n8mss
    splNcmbLHmb+g5FGd7Ag==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F705233
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:00:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
Date:   Thu, 15 Jun 2023 09:00:04 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <93490647-A0F1-41A0-8B3E-41A0C915B372@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
I was in holidays and could not review this series earlier.


> Am 04.06.2023 um 16:56 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Here's a set of patches to add support for the WiFi / Bluetooth chip =
on
> the CI20.
>=20
> WiFi works pretty well, provided it is used with the latest firmware
> provided by linux-firmware. Bluetooth does not work very well here, as
> I cannot get my wireless keyboard to pair; but it does detect it, and =
it
> does see they key presses when I type the pairing code.
>=20
> I only tested with a somewhat recent (~2022) Buildroot-based =
userspace.
> I enabled WEXT compatibility because the CI20 is typically used with a
> very old userspace, but I did not try to use it with old tools like
> ifconfig/iwconfig.

^^^ great since not everyone is using memory hungry latest user-space =
and
ifconfig/iwconfig is also available on some other OS so users like me
can share scripts.


But I had quite some issues with this series.

1. I could not boot my CI20 V2a board after applying the full series to =
v6.4-rc6
2. bisecting failed because vcc_33v is used in a patch preceding its =
definition
   leading to DTC compile abort
3. after fixing I could bisect that "MIPS: DTS: CI20: Fix ACT8600 =
regulator node names"
   is the first bad commit - although I don't see immediately why

So this series seems to be severely broken and I could not even come to
a test of WiFi and/or Bluetooth which the series claims to support.

Comments to some individual patches follow.

Best regards and looking forward to a v2 for testing,
Nikolaus


>=20
> Cheers,
> -Paul
>=20
> Paul Cercueil (9):
>  MIPS: DTS: CI20: Fix regulators
>  MIPS: DTS: CI20: Fix ACT8600 regulator node names
>  MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators

^^^ should IMHO be a separate series since it is not directly related to =
WiFi / Bluetooth

>  MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators
>  MIPS: DTS: CI20: Misc. cleanups

^^^ these two do not compile
The Misc. cleanups do not belong to this topic.

>  MIPS: DTS: CI20: Parent MSCMUX clock to MPLL

^^^ this is only loosely related to Wifi / Bluetooth

>  MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
>  MIPS: configs: CI20: Regenerate defconfig
>  MIPS: configs: CI20: Enable WiFi / Bluetooth
>=20
> arch/mips/boot/dts/ingenic/ci20.dts | 148 +++++++++++++++++++---------
> arch/mips/configs/ci20_defconfig    |  47 ++++++---
> 2 files changed, 133 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.39.2
>=20

