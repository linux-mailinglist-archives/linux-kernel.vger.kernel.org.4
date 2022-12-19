Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612B2650C76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiLSNJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLSNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:09:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44356DEE5;
        Mon, 19 Dec 2022 05:09:50 -0800 (PST)
Received: from [IPv6:2a00:23c6:c311:3401:6183:47ed:9cb1:4403] (unknown [IPv6:2a00:23c6:c311:3401:6183:47ed:9cb1:4403])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8498C660037C;
        Mon, 19 Dec 2022 13:09:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671455388;
        bh=HRoe6kfKVGOsoljsZxVcbwkCMDPY4SvEeAIPwkfdc2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jhgOjrmM7H4p2CvfvdNxzXzTljxKQhRoatMJB/VisD2tyJheBg/JJKNtNvaArD2p9
         pQen7+qBvdDrGQI6tiUE/fK45pdAUkl3jkE6x7zmquWp4nUDRMGc63s9zCnNMPXTfg
         A0uxQaFwCXnEcfS1T3z4vNtKbLQEFLwrRJ8t3J4R5wOA3l68CT1efqeCQrA3kkrJMC
         jPDoEIW94OrhAc1EFlRPyaHQAqKwQRcsiKA3qmgsk8QO0VD+9DtB7mErCQMnYPCQTm
         djRkJ7BsspwG8229F2IiGUfpeDzfgBnIgED4Bnwh6XMvXAGbSQvfwZ7yVMrDS/Xlfj
         2JE9+Y6ULWi2w==
Message-ID: <ea5e2fbf58b118ef37876aa168448c6d3010ab96.camel@collabora.com>
Subject: Re: [PATCH 0/3] Improve K3-am625-sk support (USB, MMC)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
Cc:     Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Dec 2022 13:09:46 +0000
In-Reply-To: <20221216143624.23708-1-sjoerd@collabora.com>
References: <20221216143624.23708-1-sjoerd@collabora.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-16 at 15:36 +0100, Sjoerd Simons wrote:
>=20
> This series picks up a few patches from the TI BSP tree that
> unfortunately didn't make it upstream thusfar.
>=20
> The first patch improve SD card compatibility (allowing U1 class
> cards
> to be used), the remaining ones add USB support.
>=20
> The type-c connector isn't entirely modelled with these changes as
> it goes through a TPS6598 PD controller. Unfortunately the dtb
> bindings
> for that currently require an irq line, which is not connected on E1
> and
> E2 version boards. The patchese to support this setup unfortunately
> didn't land
> yet[0].. As such the last patch ignored the PD controller and simply
> configures usb0 as periphal only rather then mode switch capable,
> which
> at least gives some basic usability of that USB port.
>=20
> 0:
> https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/=
T/
>=20
>=20

Series tested with known problematic SD Card and checking for detection
of inserted USB device.

Tested-by: Martyn Welch <martyn.welch@collabora.com>


> Aswath Govindraju (2):
> =C2=A0 arm64: dts: ti: k3-am62-main: Add support for USB
> =C2=A0 arm64: dts: ti: k3-am625-sk: Add support for USB
>=20
> Nitin Yadav (1):
> =C2=A0 arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select
>=20
> =C2=A0arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 90 ++++++++++++++++++---=
-
> --
> =C2=A0arch/arm64/boot/dts/ti/k3-am625-sk.dts=C2=A0=C2=A0 | 22 ++++++
> =C2=A02 files changed, 90 insertions(+), 22 deletions(-)
>=20

