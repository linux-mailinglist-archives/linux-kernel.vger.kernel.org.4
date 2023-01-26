Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8B67D715
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAZVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjAZVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:00:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AB4ABE2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:00:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so3056651plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1VrlYk4ybpwtqtLutbYjllW7SLxzj4A88S/3GMWXz0=;
        b=KyX4GHM239zpw0SLa6ilOemKM4AL8PggjPZAiUmVHmBb6Nqm7v2XL1lIx20APvFvXA
         WNr0FSBrZIP8fczsUfkSAazN7nhdeHHDBSsvN7uf2yV4lf13N2bfyg1a4maKF7En6ott
         qt/edecGRpeoHJlrwHexnkNYQgCqvnvjXH00UYHPW9JFJojdJ6kN0elv3idgd9mkCFPe
         cqsxnchaE3u27JBX/RBTMt4rPqMAc/L1roAj3JYMjQnKKX/OPlG46ugjBCibj2SBAcFM
         G9QIHmyxbyMSeTUplU5uLSXpbnwUX73XlcA5ATs4mhJPZ/DXykeMKObKIc4tOTlqSq/9
         p96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1VrlYk4ybpwtqtLutbYjllW7SLxzj4A88S/3GMWXz0=;
        b=7z8SzWs8E1nCMpENUVXYuqr4JUZnzDhd25my4y/SwpQuNy1xVHQB2yo5C09CR11lgW
         imIZHx4kwxUmLRoLIbNoaRAa+eeqLTBWmScjsY1FRF8YaEc/Bf7DHqMjePQ57a0wBHHR
         HxosuMOkwFiruDUmNEmBTUWfWVDQz963mSL3ZSBRKp6XPSqxIi01gEQQApfxEhvPiJR/
         r0GpVCqbSbT/eakAq4QvigGsGcAeyP0gmqFMiH3Ovoz2nfYWGs4/ESWLKa7Q9Ef4zCkB
         cuOjLd9gYpH2KVOqLY5MIaJJbwUSNE9z5pHF44nmOni3AJyEA/Ju2v460kE7pDbcojuV
         +GtA==
X-Gm-Message-State: AO0yUKW7cJrOcq1/1E6/5e1kPyIQJ+fVgJJWrfuyy1rcCjMm6fltSaQD
        EYZsk9wDRcczX8oPB4wf7nYrcg==
X-Google-Smtp-Source: AK7set/5KdZbA6hPjRJxJIk6pPmPLbIG/PEZE74cY8csx7Ody/+pmRZuhtGUWixg3VDUMHHJ8swa8A==
X-Received: by 2002:a17:90a:4b88:b0:219:f970:5119 with SMTP id i8-20020a17090a4b8800b00219f9705119mr1022118pjh.1.1674766852256;
        Thu, 26 Jan 2023 13:00:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:cb5e:1d39:8f45:c450])
        by smtp.gmail.com with ESMTPSA id nm16-20020a17090b19d000b0022c0622cc16sm3783971pjb.54.2023.01.26.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:00:51 -0800 (PST)
Date:   Thu, 26 Jan 2023 13:00:45 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec: Add VDM attention headers
Message-ID: <Y9Lp/T5RezpCQ5Zx@google.com>
References: <20230126205620.3714994-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Hc6okv4I9ucYZvU"
Content-Disposition: inline
In-Reply-To: <20230126205620.3714994-1-pmalani@chromium.org>
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


--+Hc6okv4I9ucYZvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Thu, Jan 26, 2023 at 08:55:45PM +0000, Prashant Malani wrote:
> Incorporate updates to the EC headers to support the retrieval of VDM
> Attention messages from port partners. These headers are already present
> in the ChromeOS EC codebase. [1]
>=20
> [1] https://source.chromium.org/chromium/chromiumos/platform/ec/+/main:in=
clude/ec_commands.h
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  include/linux/platform_data/cros_ec_commands.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index b9c4a3964247..ec327638c6eb 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5862,6 +5862,7 @@ enum tcpc_cc_polarity {
>  #define PD_STATUS_EVENT_MUX_1_SET_DONE		BIT(5)
>  #define PD_STATUS_EVENT_VDM_REQ_REPLY		BIT(6)
>  #define PD_STATUS_EVENT_VDM_REQ_FAILED		BIT(7)
> +#define PD_STATUS_EVENT_VDM_ATTENTION			BIT(8)
> =20
>  struct ec_params_typec_status {
>  	uint8_t port;
> @@ -5906,7 +5907,8 @@ struct ec_response_typec_status {
>  } __ec_align1;
> =20
>  /*
> - * Gather the response to the most recent VDM REQ from the AP
> + * Gather the response to the most recent VDM REQ from the AP, as well
> + * as popping the oldest VDM:Attention from the DPM queue
>   */
>  #define EC_CMD_TYPEC_VDM_RESPONSE 0x013C
> =20
> @@ -5919,10 +5921,18 @@ struct ec_response_typec_vdm_response {
>  	uint8_t vdm_data_objects;
>  	/* Partner to address - see enum typec_partner_type */
>  	uint8_t partner_type;
> -	/* Reserved */
> -	uint16_t reserved;
> +	/* enum ec_status describing VDM response */
> +	uint16_t vdm_response_err;
>  	/* VDM data, including VDM header */
>  	uint32_t vdm_response[VDO_MAX_SIZE];
> +	/* Number of 32-bit Attention fields filled in */
> +	uint8_t vdm_attention_objects;
> +	/* Number of remaining messages to consume */
> +	uint8_t vdm_attention_left;
> +	/* Reserved */
> +	uint16_t reserved1;
> +	/* VDM:Attention contents */
> +	uint32_t vdm_attention[2];
>  } __ec_align1;
> =20
>  #undef VDO_MAX_SIZE
> --=20
> 2.39.1.456.gfc5497dd1b-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--+Hc6okv4I9ucYZvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY9Lp/QAKCRBzbaomhzOw
wkAbAQCX71yLAbLh1OxBZwN3ogdzQ1kJauzB/zib0YK6R3LZZQD9EIRAl7YEcjAo
h+vhn3rZ1HljmiVxXvePEHEJwQWnFQo=
=ulQ7
-----END PGP SIGNATURE-----

--+Hc6okv4I9ucYZvU--
