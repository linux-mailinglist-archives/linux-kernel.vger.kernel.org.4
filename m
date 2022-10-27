Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A66101ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiJ0Tnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiJ0Tni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:43:38 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680580BD8;
        Thu, 27 Oct 2022 12:43:37 -0700 (PDT)
Date:   Thu, 27 Oct 2022 19:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666899814; x=1667159014;
        bh=ecgD3ocjBEk+64IIiypXst5XSaocPXz3+0qtVTaMWVI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cMLCdIjgewQmJOSr9cpH7ECdKF4NZgyINOCz1RjriHSVAx+XP9spIUfAdYfmsBJBM
         /vBC5lxVAeeKro4izPbktEgGmat9nEoSBbzD8kXpG2RWINpK8kx2DTQkku1DPPapYc
         GnQ6PDkNO8TUO0aKPDbDWgU8V1c5uiS88Yduwk7aNInKS7JysqyXo35XsjXcPKKX1s
         GdzXZ8XrSHZKKv0I5FYOd+/acVfhcW94XNV4DCfIgdQMcsLR77RNujCT/eaTELMbfi
         mEdfObfstqCzwie8K3UNMxHobTBlMGzjDYwQkXXRZ9G6BIquAFpI2BUsmJuADmxS8A
         0AImlSC+vTHTA==
To:     =?utf-8?Q?Eray_Or=C3=A7unus?= <erayorcunus@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, ike.pan@canonical.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Subject: Re: [PATCH 5/6] platform/x86: ideapad-laptop: Expose camera_power only if supported
Message-ID: <NVuCQsVF6HONw3-eRplxrMgWlvEu6AwKlrXqouYOw1FSFucZ9oprZoUeXzBCsrdzFStLjWP4DSl9wOXTe1pS19MZovS9fDmmtVuRD_prCvQ=@protonmail.com>
In-Reply-To: <20221026190106.28441-6-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com> <20221026190106.28441-6-erayorcunus@gmail.com>
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


2022. okt=C3=B3ber 26., szerda 21:01 keltez=C3=A9ssel, Eray Or=C3=A7unus =
=C3=ADrta:

> IdeaPads dropped support for VPCCMD_W_CAMERA somewhere between 2014-2016,
> none of the IdeaPads produced after that I tested supports it. Fortunatel=
y
> I found a way to check it; if the DSDT has camera device(s) defined, it
> shouldn't have working VPCCMD_W_CAMERA, thus camera_power shouldn't be
> exposed to sysfs. To accomplish this, walk the ACPI namespace in
> ideapad_check_features and check the devices starting with "CAM".
> Tested on 520-15IKB and Legion Y520, which successfully didn't expose
> the camera_power attribute.
>=20
> Link: https://www.spinics.net/lists/platform-driver-x86/msg26147.html
> Signed-off-by: Eray Or=C3=A7unus <erayorcunus@gmail.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 53 ++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index f3d4f2beda07..65eea2e65bbe 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -149,6 +149,7 @@ struct ideapad_private {
>  =09=09bool fn_lock              : 1;
>  =09=09bool hw_rfkill_switch     : 1;
>  =09=09bool kbd_bl               : 1;
> +=09=09bool cam_ctrl_via_ec      : 1;
>  =09=09bool touchpad_ctrl_via_ec : 1;
>  =09=09bool usb_charging         : 1;
>  =09} features;
> @@ -163,6 +164,26 @@ static bool no_bt_rfkill;
>  module_param(no_bt_rfkill, bool, 0444);
>  MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
>=20
> +static char *cam_device_prefix =3D "CAM";
> +
> +static acpi_status acpi_find_device_callback(acpi_handle handle, u32 lev=
el,
> +=09=09=09=09=09     void *context, void **return_value)
> +{
> +=09char buffer[8];
> +=09struct acpi_buffer ret_buf;
> +
> +=09ret_buf.length =3D sizeof(buffer);
> +=09ret_buf.pointer =3D buffer;
> +
> +=09if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &ret_buf)))
> +=09=09if (strncmp(ret_buf.pointer, context, strlen(context)) =3D=3D 0) {

Please use `strstarts()` here. Is there any reason why you decided not to
simply "inline" the "CAM" string here (or even in the function call)?


> +=09=09=09*return_value =3D handle;
> +=09=09=09return AE_CTRL_TERMINATE;
> +=09=09}
> +
> +=09return AE_OK;
> +}
> +
>  /*
>   * ACPI Helpers
>   */
> @@ -675,7 +696,7 @@ static umode_t ideapad_is_visible(struct kobject *kob=
j,
>  =09bool supported =3D true;
>=20
>  =09if (attr =3D=3D &dev_attr_camera_power.attr)
> -=09=09supported =3D test_bit(CFG_CAP_CAM_BIT, &priv->cfg);
> +=09=09supported =3D priv->features.cam_ctrl_via_ec;
>  =09else if (attr =3D=3D &dev_attr_conservation_mode.attr)
>  =09=09supported =3D priv->features.conservation_mode;
>  =09else if (attr =3D=3D &dev_attr_fan_mode.attr)
> @@ -1523,10 +1544,40 @@ static const struct dmi_system_id hw_rfkill_list[=
] =3D {
>  static void ideapad_check_features(struct ideapad_private *priv)
>  {
>  =09acpi_handle handle =3D priv->adev->handle;
> +=09acpi_handle pci_handle;
> +=09acpi_handle temp_handle =3D NULL;
>  =09unsigned long val;
> +=09acpi_status status;

It is a small thing, but I believe it is best to define these variables
in the block of that `if` since they are not used outside of it.


>=20
>  =09priv->features.hw_rfkill_switch =3D dmi_check_system(hw_rfkill_list);
>=20
> +=09/*
> +=09 * Some IdeaPads have camera switch via EC (mostly older ones),
> +=09 * some don't. Fortunately we know that if DSDT contains device
> +=09 * object for the camera, camera isn't switchable via EC.
> +=09 * So, let's walk the namespace and try to find CAM* object.
> +=09 * If we can't find it, set cam_ctrl_via_ec to true.
> +=09 */
> +
> +=09priv->features.cam_ctrl_via_ec =3D false;
> +
> +=09if (test_bit(CFG_CAP_CAM_BIT, &priv->cfg)) {
> +=09=09status =3D acpi_get_handle(handle, "^^^", &pci_handle);
> +=09=09if (ACPI_SUCCESS(status)) {
> +=09=09=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, pci_handle,
> +=09=09=09=09=09=09     ACPI_UINT32_MAX,
> +=09=09=09=09=09=09     acpi_find_device_callback,
> +=09=09=09=09=09=09     NULL, cam_device_prefix,
> +=09=09=09=09=09=09     &temp_handle);
> +
> +=09=09=09if (ACPI_SUCCESS(status) && temp_handle =3D=3D NULL)
> +=09=09=09=09priv->features.cam_ctrl_via_ec =3D true;
> +
> +=09=09} else
> +=09=09=09dev_warn(&priv->platform_device->dev,
> +=09=09=09=09"Could not find PCI* node in the namespace\n");
> +=09}
> +
>  =09/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch =
*/
>  =09priv->features.touchpad_ctrl_via_ec =3D !acpi_dev_present("ELAN0634",=
 NULL, -1);
>=20
> --
> 2.34.1
>=20


Regards,
Barnab=C3=A1s P=C5=91cze
