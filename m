Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD366309B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjAITle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAITlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:41:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8FA3590C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:41:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so13868035pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXHhCPy8ZQg2kZJwvqXpjSYTYD7YcSlvEHGYc8WsC5s=;
        b=F/2FVC8vpPYa5u8cXJThONpvdM66nq1lZgihwTK9QyYGJwXy9DKEZYer4xiYyBkxUG
         Kpt4EX+G/9lvqIW/MDV2Flsns3HZmNaGhwP+nt3Mk56nu0YTVyMFf/BFwQjD96yQMQXi
         QhHRBBOMru9MR/Zpud1xpe5gpbV0DFY8cJZoRGMWUsFAEeQxvXP5ZLAkMb0mw2/s4p9l
         O8YpNIcZsRxVgpx8NvLeH14p+XwVnBM2lEH3TYbhXLGWHa6ASaeKWo/EYcDvkDCkWYgS
         3sf+XJnA5os9CEjFgJZ3ptFrS0ZHBcgIX3ukSkvrWVJ+O96WAyAvcKQjwJqvLVhSjbqj
         wtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXHhCPy8ZQg2kZJwvqXpjSYTYD7YcSlvEHGYc8WsC5s=;
        b=P0AxNF6CZCp8OnncW0SXhG7DhJmFjyAWPxAEzqhEBFJ5W4FgNR2bh1nlNKM37W7TIP
         fWhjXJEpB03JX3rA6mCGVYgd5vtkYVTvhIn6raJrf/BrzvyTElAUr42tjMXthlr0r436
         r6ROLRLS7HV77k8404wVBiIrVITfTiBJRumVRlnILTQPYSexvZEbFIqLnaR8AUt5tGx5
         WCTmvquqNSpzE2TzAzMkC07148/iSsJkTIJln8TO3DAN/zRiG7z35+IWQAGTsSPH6JRT
         vW1xCn6ILkl43Zir//rmgV3cIss4TgseYSswqq9UReWt8KGz313hL2KEDiNBF4YJD0cG
         UuFg==
X-Gm-Message-State: AFqh2kqPsxI1iIpcyt5aQavqZRd/9LawQHL0YtafT9BdBoEKxcdaW6EN
        GWqffmybmh01o+6LbYX9UE6Q1w==
X-Google-Smtp-Source: AMrXdXuV6nfJaH1DdV9J83X/nSRL//0QnVJ6UYPgpfyOy57UPJF79GIsVR5FH1qZmcHr88n5UuR7RA==
X-Received: by 2002:a17:90a:c4f:b0:219:c2f2:f83c with SMTP id u15-20020a17090a0c4f00b00219c2f2f83cmr725507pje.2.1673293262257;
        Mon, 09 Jan 2023 11:41:02 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id 31-20020a63195f000000b00478dad38eacsm5563018pgz.38.2023.01.09.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:41:01 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:40:54 -0800
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
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 02/10] platform_chrome: cros_ec: Add Type-C VDM defines
Message-ID: <Y7xtxo3V050rvMTe@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CpmHd8ttyUe4GQ8r"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-3-pmalani@chromium.org>
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


--CpmHd8ttyUe4GQ8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:05AM +0000, Prashant Malani wrote:
> Add the EC header changes need to support USB Type-C VDM (Vendor Defined
> Messages) communication between the system and USB PD-enabled
> peripherals.
>=20
> The headers are already present in the EC code base, from which they've
> been ported [1].
>=20
> [1] https://source.chromium.org/chromium/chromiumos/platform/ec/+/main:in=
clude/ec_commands.h
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  .../linux/platform_data/cros_ec_commands.h    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index 7c94bf5c8f05..6665e7da6ee2 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -1300,6 +1300,18 @@ enum ec_feature_code {
>  	 * mux.
>  	 */
>  	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK =3D 43,
> +	/*
> +	 * The EC supports entering and residing in S4.
> +	 */
> +	EC_FEATURE_S4_RESIDENCY =3D 44,
> +	/*
> +	 * The EC supports the AP directing mux sets for the board.
> +	 */
> +	EC_FEATURE_TYPEC_AP_MUX_SET =3D 45,
> +	/*
> +	 * The EC supports the AP composing VDMs for us to send.
> +	 */
> +	EC_FEATURE_TYPEC_AP_VDM_SEND =3D 46,
>  };
> =20
>  #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
> @@ -5724,6 +5736,8 @@ enum typec_control_command {
>  	TYPEC_CONTROL_COMMAND_ENTER_MODE,
>  	TYPEC_CONTROL_COMMAND_TBT_UFP_REPLY,
>  	TYPEC_CONTROL_COMMAND_USB_MUX_SET,
> +	TYPEC_CONTROL_COMMAND_BIST_SHARE_MODE,
> +	TYPEC_CONTROL_COMMAND_SEND_VDM_REQ,
>  };
> =20
>  /* Replies the AP may specify to the TBT EnterMode command as a UFP */
> @@ -5737,6 +5751,17 @@ struct typec_usb_mux_set {
>  	uint8_t mux_flags;	/* USB_PD_MUX_*-encoded USB mux state to set */
>  } __ec_align1;
> =20
> +#define VDO_MAX_SIZE 7
> +
> +struct typec_vdm_req {
> +	/* VDM data, including VDM header */
> +	uint32_t vdm_data[VDO_MAX_SIZE];
> +	/* Number of 32-bit fields filled in */
> +	uint8_t vdm_data_objects;
> +	/* Partner to address - see enum typec_partner_type */
> +	uint8_t partner_type;
> +} __ec_align1;
> +
>  struct ec_params_typec_control {
>  	uint8_t port;
>  	uint8_t command;	/* enum typec_control_command */
> @@ -5752,6 +5777,8 @@ struct ec_params_typec_control {
>  		uint8_t mode_to_enter;      /* enum typec_mode */
>  		uint8_t tbt_ufp_reply;      /* enum typec_tbt_ufp_reply */
>  		struct typec_usb_mux_set mux_params;
> +		/* Used for VMD_REQ */
> +		struct typec_vdm_req vdm_req_params;
>  		uint8_t placeholder[128];
>  	};
>  } __ec_align1;
> @@ -5833,6 +5860,8 @@ enum tcpc_cc_polarity {
>  #define PD_STATUS_EVENT_DISCONNECTED		BIT(3)
>  #define PD_STATUS_EVENT_MUX_0_SET_DONE		BIT(4)
>  #define PD_STATUS_EVENT_MUX_1_SET_DONE		BIT(5)
> +#define PD_STATUS_EVENT_VDM_REQ_REPLY		BIT(6)
> +#define PD_STATUS_EVENT_VDM_REQ_FAILED		BIT(7)
> =20
>  struct ec_params_typec_status {
>  	uint8_t port;
> @@ -5876,6 +5905,28 @@ struct ec_response_typec_status {
>  	uint32_t sink_cap_pdos[7];	/* Max 7 PDOs can be present */
>  } __ec_align1;
> =20
> +/*
> + * Gather the response to the most recent VDM REQ from the AP
> + */
> +#define EC_CMD_TYPEC_VDM_RESPONSE 0x013C
> +
> +struct ec_params_typec_vdm_response {
> +	uint8_t port;
> +} __ec_align1;
> +
> +struct ec_response_typec_vdm_response {
> +	/* Number of 32-bit fields filled in */
> +	uint8_t vdm_data_objects;
> +	/* Partner to address - see enum typec_partner_type */
> +	uint8_t partner_type;
> +	/* Reserved */
> +	uint16_t reserved;
> +	/* VDM data, including VDM header */
> +	uint32_t vdm_response[VDO_MAX_SIZE];
> +} __ec_align1;
> +
> +#undef VDO_MAX_SIZE
> +
>  /***********************************************************************=
******/
>  /* The command range 0x200-0x2FF is reserved for Rotor. */
> =20
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

--CpmHd8ttyUe4GQ8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xtxgAKCRBzbaomhzOw
wldCAQC78NC9IQIYLqOZQXd8fQCOa4OPJd8rszj0QRhB0GcO9wEAqRmaao9paHIy
Jytje0kN/NhKZZJUHYTrTEiAFWNo2w4=
=MhSQ
-----END PGP SIGNATURE-----

--CpmHd8ttyUe4GQ8r--
