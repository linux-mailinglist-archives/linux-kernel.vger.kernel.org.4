Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6D6DECD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDLHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:45:43 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA71705
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:45:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1ED3A100014;
        Wed, 12 Apr 2023 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681285540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFYr9F865jNKlij7bhqU6NcO52rv9OFiF5JjtJfQn8M=;
        b=P7q6H8wpRwdAM4/cqiQP+t3EFYZp9l3cPj7yJQLf+pkXNirWvSdgFTLSKgyIMIHgbQeL3I
        0CAXJh6o1Pf7fqUPVhrMIytVo5cPRzdA1BsUF+e++P85Nok14z0NBBbHxuH/fhsUAHPnFE
        WpOCqjXyW9NhVb1u4PDx12Ksg6xB+p0FjebBJSmmtYcMgqixX8pdRWNWP38w9To795NTZr
        xIiAojQzpYQotrV5b2uSSZzPlUlrTHD1pvUJN9gkTItUpayJ0yx4W/aMX3SSGX6fLRGkSS
        TiyDJDr3EMq9keOL2tmMJXR9jInTZ5yJMhERnz56cbF1HXtwGd1Qa6F365BV/A==
Date:   Wed, 12 Apr 2023 09:45:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-amlogic@lists.infradead.org>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] refactoring and fix for Meson NAND
Message-ID: <20230412094533.10d4a2a9@xps-13>
In-Reply-To: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:54 +0300:

> Hello,
>=20
> this patchset adds one fix and several refactoring patches. First patch
> is the most important - it fixes unstable behaviour of Meson driver, for
> example random ECC errors during reads. I've tested this with mount/
> unmount/read/write cases for JFFS2 and nanddump/nandwrite utlities on
> AXG family (A113X SoC). Source of this update is old vendor's driver.
>=20
> Other patches are refactoring and extra checks, not critical for this
> driver's reliability.

Thanks for the series, minor comments inside, if you respin before the
end of the week I'll take this for the next merge window.

>=20
> Arseniy Krasnov (5):
>   mtd: rawnand: meson: fix NAND access for read/write
>   mtd: rawnand: meson: replace GENMASK() macro with define
>   mtd: rawnand: meson: check buffer length
>   mtd: rawnand: meson: clear OOB buffer before read
>   mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
>=20
>  drivers/mtd/nand/raw/meson_nand.c | 147 ++++++++++++++++++++++++++----
>  1 file changed, 127 insertions(+), 20 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
