Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B40610478
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiJ0Vcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiJ0Vcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:32:39 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC66C126
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:32:38 -0700 (PDT)
Date:   Thu, 27 Oct 2022 21:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666906356; x=1667165556;
        bh=y8VadYs6trzDqNdreMr2m0RjqduX0bvbUVP70tUtncI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VI1qHMFNbMDcQLOps0FfTUHG23xrAgQ+o2A3EC8ncdDsmEcxgBOH1o1bZw3swGQTm
         G+2dKqsBPJ/8pGyXJA53PX3Jg2FDzAB+TC+91i6Ob6pHX5lLTg5J07q8IjYLP2dUv2
         xYiMY+OTwVYc0/qS6r0OGtyrY7zn4p9oEglaP+FS7couaVKwvmZVG9WpqscIeqxWnZ
         D61RhQlWmXKmMUsAwVMQVKDDJLL4JASi+GQFYQWMWZvwbPF8l8F6AEvThHZDkIhq+f
         9d0D2AL8uYqn0RdaQq/QrnP/bbw98K9Zp2uBEbYJ0unS/2q1FJVNCv43H36Q8Zpbfg
         6yhXopvIpWAmQ==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Deco LW
Message-ID: <2m7M7XFEGHGOu6Le-GK_9kDuuA3BltmE1I17zDsok382TFmgO2oDamLv7cWcXjYLdzdgwQli7Qe98xoe0tuVc4bg7sRbFG2LFZ6iYn0s3Fk=@protonmail.com>
In-Reply-To: <20221027211021.230325-1-jose.exposito89@gmail.com>
References: <20221027211021.230325-1-jose.exposito89@gmail.com>
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


2022. okt=C3=B3ber 27., cs=C3=BCt=C3=B6rt=C3=B6k 23:10 keltez=C3=A9ssel, Jo=
s=C3=A9 Exp=C3=B3sito =C3=ADrta:

> [...]
> +/**
> + * uclogic_params_ugee_v2_has_battery() - check whether a UGEE v2 device=
 has
> + * battery or not.
> + * @hdev:=09The HID device of the tablet interface.
> + *
> + * Returns:
> + *=09True if the device has battery, false otherwise.
> + */
> +static bool uclogic_params_ugee_v2_has_battery(struct hid_device *hdev)
> +{
> +=09/* The XP-PEN Deco LW vendor, product and version are identical to th=
e
> +=09 * Deco L. The only difference reported by their firmware is the prod=
uct
> +=09 * name. Add a quirk to support battery reporting on the wireless
> +=09 * version.
> +=09 */
> +=09if (hdev->vendor =3D=3D USB_VENDOR_ID_UGEE &&
> +=09    hdev->product =3D=3D USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) {
> +=09=09struct usb_device *udev =3D hid_to_usb_dev(hdev);
> +=09=09const char *lw_name =3D "Deco LW";
> +
> +=09=09if (strncmp(udev->product, lw_name, strlen(lw_name)) =3D=3D 0)

Please use `strstarts()` here instead.


> +=09=09=09return true;
> +=09}
> +
> +=09return false;
> +}
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
