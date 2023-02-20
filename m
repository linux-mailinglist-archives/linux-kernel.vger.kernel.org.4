Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59C69C716
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBTI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBTI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:58:45 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887767DB8;
        Mon, 20 Feb 2023 00:58:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C198760002;
        Mon, 20 Feb 2023 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676883511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz7ymKkeqvHCDa/6k6ptYf6tiYPwOleZAKDnnk0ryko=;
        b=WRXxB5cRd4mIWFQQx94i4cOSCLm26Fqr86Rg1aViqT3mwAQqKP6f+SZCAeNxPuF6YYgSx6
        YiN0/1c9H/0ueNExaOd+BUSDu7nVPs3K4clkWQuHW0MJa1NS11IN4PXEZBuXUaZYTrly5g
        mB+lxg74Ht14gbpP3k1fOpOvbOPtScmaybhxxTElFl5psZncnCZU0BGUiglsQU5HykqPiP
        92UxNJuC1UlUHh7DDHsRygjfyNMVhPqZhjdrfiA6mIKtIInpB/KVCiTLBumQlgoCKd/dym
        MRtPbQa5dNzpyKn6U+aADxeFF7hqCgLRS7pc1GViYWYuLwN0IEgVYg2hvi0fhw==
Date:   Mon, 20 Feb 2023 09:58:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: Re: [PATCH v1 03/17] thermal: Remove debug or error messages in
 get_temp() ops
Message-ID: <20230220095829.1591a532@xps-13>
In-Reply-To: <20230219143657.241542-4-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
        <20230219143657.241542-4-daniel.lezcano@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel.lezcano@linaro.org wrote on Sun, 19 Feb 2023 15:36:43 +0100:

> Some get_temp() ops implementation are showing an error or a debug
> message if the reading of the sensor fails.
>=20
> The debug message is already displayed from the call site of this
> ops. So we can remove it.
>=20
> On the other side, the error should not be displayed because in
> production that can raise tons of messages.
>=20
> Finally, some drivers are showing a debug message with the
> temperature, this is also accessible through the trace from the core
> code in the temperature_update() function.
>=20
> Another benefit is the dev_* messages are accessing the thermal zone
> device field from the structure, so we encapsulate even more the code
> by preventing these accesses.
>=20
> Remove those messages.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/armada_thermal.c           | 10 ++--------

For Armada:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
