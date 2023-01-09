Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED16630BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjAITtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjAITsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:48:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C81CC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:47:24 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so8855076pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPLUft72cqNctpI7VzJ9f94MH4+lWwZXFCwfiW2cmQ0=;
        b=YCf7R1hhy1YV4w8JeZp/GEMhEJCeGuB5HrFdUA3bhybMavMKlb2aKTjv0MsrRrnmRJ
         8bkpQfA28dY8pvYmI3+R/mwGQ5hCITagIQ0U/olJ7d2jI9/vUErnt6HY5jCXxRb1CT4j
         HrHkWQY7k7xCKtvWkKAynKTU8yy7ba6XhdIJhUV12ILhdW4kNwIZFsMZXJpkP5CdPn9W
         XNtSNKK5aiLfldtKyDRFsxCDXpcFDbhfKacWQIlNGZHqRNHIN2+jdZsMImwMXuGwOFqa
         IGY4te6DT32v+ylzqVJdwb0D28E/Onb/nyLqgiqIs03+iaaowXUQ32Se1J5q0nMekmpX
         lzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPLUft72cqNctpI7VzJ9f94MH4+lWwZXFCwfiW2cmQ0=;
        b=UN+UDV+suowcG3it/wSzXBYGwERUqmovDzuV/wuMnDZkPfRozhyUNldZTrJV5+7kVI
         Oq+oGhJ70EQzIPdSqr28lSAJ1lIaadeHeKorePqcW3CMayIFe3QU1aJ5mIPtHtqNQifz
         oTvF5eeGDmng9HXPkQLvFs/MZU96T3BgKQWD0I89MrdB9Ll9cbvLnobxTJ8XPgm0vVEm
         rYRI8eewKCwM8mr+z1x3QFv9XL943y2LwQ39gbPQjdv9K7hwachOUeMPfowMDNTjVvpQ
         fBAUiSzSsHv5K78pgj52IT+c0iPk5Ter5Wc6cph3BQeZwxwvZ70jPjDA4JIRATUUN/YL
         0GEw==
X-Gm-Message-State: AFqh2kpi3EfDR3VCH6F1S9CEJu6RM+ld8hLTlgC+GMqX+vYeMEvjNy+5
        cLpEydnmoW0Uh7h3R/NU5Jg43g==
X-Google-Smtp-Source: AMrXdXuAhcI+RqTq8yc1AC+46IMoFnnLMbesJlaj/gOYfwsVmpgsd+j4xRZqPMW1ubVmFJ/lIpHHZA==
X-Received: by 2002:a17:902:f292:b0:191:1543:6b2f with SMTP id k18-20020a170902f29200b0019115436b2fmr625258plc.3.1673293643764;
        Mon, 09 Jan 2023 11:47:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001743ba85d39sm6518481plb.110.2023.01.09.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:47:22 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:47:16 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 06/10] platform/chrome: cros_ec_typec: Move structs to
 header
Message-ID: <Y7xvRKax2wls5+IL@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RlgEVx4D9Vwoeqxg"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-7-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RlgEVx4D9Vwoeqxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:09AM +0000, Prashant Malani wrote:
> Move ChromeOS Type-C structs into their own header, so they can be
> referenced by other files which can be added to the same module.
>=20
> No functional changes introduced by this patch.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  MAINTAINERS                             |  2 +-
>  drivers/platform/chrome/cros_ec_typec.c | 78 +----------------------
>  drivers/platform/chrome/cros_ec_typec.h | 85 +++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 77 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61eb221415b..8219b646ab50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4998,7 +4998,7 @@ CHROMEOS EC USB TYPE-C DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
>  L:	chrome-platform@lists.linux.dev
>  S:	Maintained
> -F:	drivers/platform/chrome/cros_ec_typec.c
> +F:	drivers/platform/chrome/cros_ec_typec.*
>  F:	drivers/platform/chrome/cros_typec_switch.c
> =20
>  CHROMEOS EC USB PD NOTIFY DRIVER
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 665fa76e2416..a4eff590ca56 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -7,96 +7,22 @@
>   */
> =20
>  #include <linux/acpi.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> -#include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
> -#include <linux/usb/pd.h>
>  #include <linux/usb/pd_vdo.h>
> -#include <linux/usb/typec.h>
> -#include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
> -#include <linux/usb/typec_mux.h>
> -#include <linux/usb/typec_retimer.h>
>  #include <linux/usb/typec_tbt.h>
> -#include <linux/usb/role.h>
> +
> +#include "cros_ec_typec.h"
> =20
>  #define DRV_NAME "cros-ec-typec"
> =20
>  #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(D=
P_PIN_ASSIGN_D)) | \
>  				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
> =20
> -/* Supported alt modes. */
> -enum {
> -	CROS_EC_ALTMODE_DP =3D 0,
> -	CROS_EC_ALTMODE_TBT,
> -	CROS_EC_ALTMODE_MAX,
> -};
> -
> -/* Container for altmode pointer nodes. */
> -struct cros_typec_altmode_node {
> -	struct typec_altmode *amode;
> -	struct list_head list;
> -};
> -
> -/* Per port data. */
> -struct cros_typec_port {
> -	struct typec_port *port;
> -	int port_num;
> -	/* Initial capabilities for the port. */
> -	struct typec_capability caps;
> -	struct typec_partner *partner;
> -	struct typec_cable *cable;
> -	/* SOP' plug. */
> -	struct typec_plug *plug;
> -	/* Port partner PD identity info. */
> -	struct usb_pd_identity p_identity;
> -	/* Port cable PD identity info. */
> -	struct usb_pd_identity c_identity;
> -	struct typec_switch *ori_sw;
> -	struct typec_mux *mux;
> -	struct typec_retimer *retimer;
> -	struct usb_role_switch *role_sw;
> -
> -	/* Variables keeping track of switch state. */
> -	struct typec_mux_state state;
> -	uint8_t mux_flags;
> -	uint8_t role;
> -
> -	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
> -
> -	/* Flag indicating that PD partner discovery data parsing is completed.=
 */
> -	bool sop_disc_done;
> -	bool sop_prime_disc_done;
> -	struct ec_response_typec_discovery *disc_data;
> -	struct list_head partner_mode_list;
> -	struct list_head plug_mode_list;
> -
> -	/* PDO-related structs */
> -	struct usb_power_delivery *partner_pd;
> -	struct usb_power_delivery_capabilities *partner_src_caps;
> -	struct usb_power_delivery_capabilities *partner_sink_caps;
> -
> -	struct cros_typec_data *typec_data;
> -};
> -
> -/* Platform-specific data for the Chrome OS EC Type C controller. */
> -struct cros_typec_data {
> -	struct device *dev;
> -	struct cros_ec_device *ec;
> -	int num_ports;
> -	unsigned int pd_ctrl_ver;
> -	/* Array of ports, indexed by port number. */
> -	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
> -	struct notifier_block nb;
> -	struct work_struct port_work;
> -	bool typec_cmd_supported;
> -	bool needs_mux_ack;
> -};
> -
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
>  				       struct fwnode_handle *fwnode,
>  				       struct device *dev)
> diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/c=
hrome/cros_ec_typec.h
> new file mode 100644
> index 000000000000..deda180a646f
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_typec.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __CROS_EC_TYPEC__
> +#define __CROS_EC_TYPEC__
> +
> +#include <linux/list.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/usb/pd.h>
> +#include <linux/usb/role.h>
> +#include <linux/usb/typec.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_retimer.h>
> +#include <linux/workqueue.h>
> +
> +/* Supported alt modes. */
> +enum {
> +	CROS_EC_ALTMODE_DP =3D 0,
> +	CROS_EC_ALTMODE_TBT,
> +	CROS_EC_ALTMODE_MAX,
> +};
> +
> +/* Container for altmode pointer nodes. */
> +struct cros_typec_altmode_node {
> +	struct typec_altmode *amode;
> +	struct list_head list;
> +};
> +
> +/* Platform-specific data for the Chrome OS EC Type C controller. */
> +struct cros_typec_data {
> +	struct device *dev;
> +	struct cros_ec_device *ec;
> +	int num_ports;
> +	unsigned int pd_ctrl_ver;
> +	/* Array of ports, indexed by port number. */
> +	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
> +	struct notifier_block nb;
> +	struct work_struct port_work;
> +	bool typec_cmd_supported;
> +	bool needs_mux_ack;
> +};
> +
> +/* Per port data. */
> +struct cros_typec_port {
> +	struct typec_port *port;
> +	int port_num;
> +	/* Initial capabilities for the port. */
> +	struct typec_capability caps;
> +	struct typec_partner *partner;
> +	struct typec_cable *cable;
> +	/* SOP' plug. */
> +	struct typec_plug *plug;
> +	/* Port partner PD identity info. */
> +	struct usb_pd_identity p_identity;
> +	/* Port cable PD identity info. */
> +	struct usb_pd_identity c_identity;
> +	struct typec_switch *ori_sw;
> +	struct typec_mux *mux;
> +	struct typec_retimer *retimer;
> +	struct usb_role_switch *role_sw;
> +
> +	/* Variables keeping track of switch state. */
> +	struct typec_mux_state state;
> +	uint8_t mux_flags;
> +	uint8_t role;
> +
> +	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
> +
> +	/* Flag indicating that PD partner discovery data parsing is completed.=
 */
> +	bool sop_disc_done;
> +	bool sop_prime_disc_done;
> +	struct ec_response_typec_discovery *disc_data;
> +	struct list_head partner_mode_list;
> +	struct list_head plug_mode_list;
> +
> +	/* PDO-related structs */
> +	struct usb_power_delivery *partner_pd;
> +	struct usb_power_delivery_capabilities *partner_src_caps;
> +	struct usb_power_delivery_capabilities *partner_sink_caps;
> +
> +	struct cros_typec_data *typec_data;
> +};
> +
> +#endif /*  __CROS_EC_TYPEC__ */
> --=20
> 2.39.0.314.g84b9a713c41-goog
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--RlgEVx4D9Vwoeqxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xvRAAKCRBzbaomhzOw
wryMAP9deLuk6+xkakePpENAX9AafmPeJy/BhV2hlDlGrutB0wEAzZQxxc7c/ony
UGpJFbnNmrkej8hY4Q2YymldYuu5fwI=
=pzjN
-----END PGP SIGNATURE-----

--RlgEVx4D9Vwoeqxg--
