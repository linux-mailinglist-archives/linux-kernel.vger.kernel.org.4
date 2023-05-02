Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062FC6F3D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjEBGTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjEBGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:18:54 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39149CE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EYUXOUeUGGLVvjMNATgDMVEHqCZFsJM3ccXEumlhEew=;
        b=07Od6kEqhf/hGBPLE8ZkY0f4/APzPyeaiqVIKXpoHkM4FrhNwKJCg6Dh2nTlLnQkkSMbB3MMmCO
        E+N5KCsmQAB2x6+b86L5XK3Cz635bVbcAPXcdbaFQrOtlRWPwo3DiSj7HLFb1uyMV5cmB9pOtUYHs
        SvL3Ywoxss4yqrvlBE6ceYjhBVXTU9ZhASnTspT757eEjDDBTWDJEFew4orPjrXdaComHLDss3Rma
        7pC7XXt8Fa3sqyQUqLMwI+MNtLyrHoygipwbZaeksRg4QLOKFse9/C9XlA/64Apl6j6BnW7akq6bI
        l2dkeA3lCWNGCjv2YCyi5yEKZe8TmxOpjScQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1ptjKn-000Jxa-7j; Tue, 02 May 2023 08:17:57 +0200
Received: from [185.17.218.86] (helo=smtpclient.apple)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1ptjKn-000VUA-1G; Tue, 02 May 2023 08:17:57 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 2/2] mfd: stpmic1: add pmic poweroff via sys-off handler
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
In-Reply-To: <20230428112847.2146348-2-sean@geanix.com>
Date:   Tue, 2 May 2023 08:17:46 +0200
Cc:     p.paillet@st.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A97160A-DEC6-414A-BA4F-D6E9D587E2E8@geanix.com>
References: <20230428112847.2146348-1-sean@geanix.com>
 <20230428112847.2146348-2-sean@geanix.com>
To:     Lee Jones <lee@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26893/Mon May  1 09:22:05 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28 Apr 2023, at 13.28, Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> Use devm_register_sys_off_handler() that allows to register multiple
> power-off handlers.
>=20
> This can be enabled by adding "st,pmic-poweroff" to device-tree.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Oh, I forgot the device-tree documentation.
Will add that after review=E2=80=A6

/Sean

> drivers/mfd/stpmic1.c | 34 ++++++++++++++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> index 4c9b18d9dec8..c628141eb03c 100644
> --- a/drivers/mfd/stpmic1.c
> +++ b/drivers/mfd/stpmic1.c
> @@ -7,6 +7,7 @@
> #include <linux/mfd/core.h>
> #include <linux/mfd/stpmic1.h>
> #include <linux/module.h>
> +#include <linux/reboot.h>
> #include <linux/of.h>
> #include <linux/of_irq.h>
> #include <linux/of_platform.h>
> @@ -117,6 +118,33 @@ static const struct regmap_irq_chip =
stpmic1_regmap_irq_chip =3D {
> .num_irqs =3D ARRAY_SIZE(stpmic1_irqs),
> };
>=20
> +static int stpmic1_power_off(struct sys_off_data *data)
> +{
> + struct stpmic1 *ddata =3D data->cb_data;
> +
> + regmap_update_bits(ddata->regmap, MAIN_CR,
> +   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
> +
> + return NOTIFY_DONE;
> +}
> +
> +static int stpmic1_power_off_prepare_init(struct stpmic1 *ddata)
> +{
> + int ret;
> +
> + ret =3D devm_register_sys_off_handler(ddata->dev,
> +    SYS_OFF_MODE_POWER_OFF,
> +    SYS_OFF_PRIO_DEFAULT,
> +    stpmic1_power_off,
> +    ddata);
> + if (ret) {
> + dev_err(ddata->dev, "failed to register sys-off handler: %d\n", =
ret);
> + return ret;
> + }
> +
> + return 0;
> +}
> +
> static int stpmic1_probe(struct i2c_client *i2c)
> {
> struct stpmic1 *ddata;
> @@ -159,6 +187,12 @@ static int stpmic1_probe(struct i2c_client *i2c)
> return ret;
> }
>=20
> + if (of_property_read_bool(i2c->dev.of_node,  "st,pmic-poweroff")) {
> + ret =3D stpmic1_power_off_prepare_init(ddata);
> + if (ret)
> + return ret;
> + }
> +
> return devm_of_platform_populate(dev);
> }
>=20
> --=20
> 2.40.0
>=20


