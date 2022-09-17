Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B35BB9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIQRMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 13:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 13:12:02 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF332E9D4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:11:58 -0700 (PDT)
Date:   Sat, 17 Sep 2022 17:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663434716; x=1663693916;
        bh=UwnMF0OLzyixe7J9iCpdVnUKQFdiBm9JY1tCAOzgt88=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=kZ7sn4k2mjc5fKaGF+v95lS8w8nSWeVzBAJcyY+3bJ9CoILfuPmm/u4QYFdTbNwj7
         vdZ5zq28Zo4awXImNMUoYAXitmAxHTeYPYXfr3OY1x44qTzJrHuK+MKh+FH3II4q3g
         OPpCajaczOxsY76bSHf7Slvw9KnoniaBJ0pTx9TnsITfWOO5QLtKgkCcYiXrdXljRB
         ELpaB9huWb+hnxD6V3nwLX61X0r7C97XzZh9cigfiReY080jVaolXsuIp2tfgBhmQS
         P34gd3wOgcpw0EyMWz/UL/sBRy4CPICp/VtoUW/2V+5KtDaHH/h1fOsOUmvDTyDKWD
         /58GdIXQRDk5w==
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        corentin.chary@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] asus-wmi: Expand support of GPU fan to read RPM and label
Message-ID: <qf0UI0B6IRDrhWfipl2Yv_LaJN2NsaEhHx8oqzQIvLu0DwDM5xUsVep8so-SE1QyqH1CaXjQXIF7COGUkoCXyI9aoL0u8QLGTZwWGJRPB0w=@protonmail.com>
In-Reply-To: <20220916004623.10992-1-luke@ljones.dev>
References: <20220916004623.10992-1-luke@ljones.dev>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. szeptember 16., p=C3=A9ntek 2:46 keltez=C3=A9ssel, Luke D. Jones =
=C3=ADrta:

> The previously added patch to add support for pwm change for TUF laptops
> also is usuable for more than TUF. The same method `0x00110014` is
> used to read the fan RPM.
>=20
> Add two extra attributes for reading fan2 plus fan2 label.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 36 +++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index ae46af731de9..7fe6ce25da0a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -72,6 +72,7 @@ module_param(fnlock_default, bool, 0444);
> [...]
> +static ssize_t fan2_input_show(struct device *dev,
> +=09=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09=09char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09int value;
> +=09int ret;
> +
> +=09ret =3D asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_FAN_CTRL, &val=
ue);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09value &=3D 0xffff;
> +
> +=09return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);

Can `value` can be negative here? I am not sure because of the `value &=3D =
0xffff` part.
And maybe it would be better to return -ENODATA or something similar instea=
d of printing "-1".


> +}
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
