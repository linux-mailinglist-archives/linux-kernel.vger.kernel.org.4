Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8F6982C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBORzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBORzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:55:42 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D621C596;
        Wed, 15 Feb 2023 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676483740; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9zdu4+WzlQk2Yn0NLUar52TJiHYx7OI4m2mwDlD37A=;
        b=JMBQAfbXiG4Q1ckxmQGkoJ5Qwry3u3ogtBJM8X512hbfmaZCfCZ4sDxBNfVsDB5syFV+pm
        tjFmjiR797MynbmQEVfdgwScDfdodEOukLjh3EpuVJGjyBkOX3DTQ4wJnySisW7VwU42jq
        VUOhiapOShTvFvc3XBvuA+JLYmDKfCs=
Message-ID: <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
Subject: Re: [RFC 0/3] Make WLAN and Bluetooth basically work for CI20
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Date:   Wed, 15 Feb 2023 17:55:36 +0000
In-Reply-To: <cover.1676482318.git.hns@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 18:31 +0100, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> RFC V1 2023-02-15 18:31:58:
> With the applied patch
>=20
> rtc: jz4740: Register clock provider for the CLK32K pin
>=20
> by Paul Cercueil <paul@crapouillou.net> it is now possible to make
> the
> CI20 WiFi and Bluetooth setup do something reasonable.
>=20
> This series adds #clock-cells to the jz4780 and fixes the device tree
> for
> the CI20. It contains two ugly workarounds since BL_WAKE and WL_WAKE
> can not
> be controlled as shutdown-gpios or device-wakeup-gpios by the
> drivers.
> We also update the power setup and sequencing and add a clock chain
> for
> the 32 kHz clock.
> Finally, we enable some required CONFIGs for the CI20.

I do have my own patchset that I wanted to send in time for 6.3-rc1,
but the RTC patchset was merged very late so I was waiting for -rc1 to
be out before sending it to Thomas.

I think my DT changes are better as I have no workarounds. I need to
clean up the commits (and have proper commit messages) but you can find
my current work there:
https://github.com/OpenDingux/linux/commits/for-upstream-ci20

Cheers,
-Paul

>=20
> Tested on CI20 with v6.2-rc6.
>=20
> H. Nikolaus Schaller (3):
> =C2=A0 MIPS: DTS: jz4780: add #clock-cells to rtc_dev
> =C2=A0 MIPS: DTS: CI20: fixes for WiFi/Bluetooth
> =C2=A0 MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth
>=20
> =C2=A0arch/mips/boot/dts/ingenic/ci20.dts=C2=A0=C2=A0=C2=A0 | 77 ++++++++=
++++++++++++++--
> --
> =C2=A0arch/mips/boot/dts/ingenic/jz4780.dtsi |=C2=A0 2 +
> =C2=A0arch/mips/configs/ci20_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 18 +++++-
> =C2=A03 files changed, 84 insertions(+), 13 deletions(-)
>=20

