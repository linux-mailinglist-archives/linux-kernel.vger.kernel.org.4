Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C66754D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjATMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:43:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F446A1;
        Fri, 20 Jan 2023 04:43:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so4809361pjl.0;
        Fri, 20 Jan 2023 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfzTroDEuExUjDoe6EoCh4fgs1lrkfGJXoV3oFFtg+U=;
        b=IhlTW2DMKJYR/mXD/i50Cpr+JqNDKGWorBcRZTW1601xQgs8zMuGHSpDOnepCy835K
         Jkvrzh39eQNvoc5z2KYlhAbQO8Iegim5KjYUtbjLZq6grCTlHPTXsu6gRLQAbv607VCc
         ZuYrU9XqPqUGT8si7MjMqa2c77I740bMau7+mWPLltRXFb2HVC7mkLhsjRrnnIMZOlv7
         TXbFkDkX/+/3vBiIdxW76rx4Hzqz0OhprBDhwrsbrwnXYPY4uQVC3pdZDl+mDjSTdiJI
         PTKxwGkPUjvvUYeXW2nyoyJypsN8fOtQLBd0QY7YW/7tEL+4Vlcg4FcPjmnmkWQpDbWB
         diVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfzTroDEuExUjDoe6EoCh4fgs1lrkfGJXoV3oFFtg+U=;
        b=lKChINhJQNNGFMiF/zTxxt38uqdeioSY84UGOzpwBTehJDkN6fpvt56hhGZyQew+kE
         OeafWHShcEQR66+HSQVWlmmGWZ1xmSbgBcVS9CwPyICVbts8TegfYRVuCGplyK0gfWow
         5j7YqYupUdtXAL5BEm09IY80i5jbVLF6X/qRzItuRbFDV3Y/C0h+pUjOlDlp5XlEYJDr
         qZyMPh3yOh8IFi0kTms29L+QMPdik5HkwqVaH8sirGfWJ6spPRDr7tEJww7zwEq9UUI0
         2RZP3FZ462ApWyFGds+qig+qFXunIPIerfemaYCB6KHhr+GRtTpnEAtBOaNC5GYLls+O
         TQhQ==
X-Gm-Message-State: AFqh2krrOaemL4oCHv5elzRJf7LxiGNrZnb4cQhkAG6M8Nfe63Dqkr6Y
        UykFQZ+AqcRRfRYGb68bhu8=
X-Google-Smtp-Source: AMrXdXscXsEL4tqaXQ5Nhn70gH9pFFjdIDb9NaC1WIKIWKyajhhCDlVjj1l2j0aMBn/Wsm19KfbKjw==
X-Received: by 2002:a05:6a20:54aa:b0:b6:99c7:9283 with SMTP id i42-20020a056a2054aa00b000b699c79283mr21106653pzk.12.1674218615494;
        Fri, 20 Jan 2023 04:43:35 -0800 (PST)
Received: from debian.me (subs02-180-214-232-6.three.co.id. [180.214.232.6])
        by smtp.gmail.com with ESMTPSA id t1-20020a63d241000000b004c974bb9a4esm10117666pgi.83.2023.01.20.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:43:34 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id ED291103DF9; Fri, 20 Jan 2023 19:43:30 +0700 (WIB)
Date:   Fri, 20 Jan 2023 19:43:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     sudeep.holla@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Clarify Raw per-channel ABI
 documentation
Message-ID: <Y8qMclu5Tc3dKCS6@debian.me>
References: <20230120122326.1932614-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tFqp+/Q7r8KZ5dAF"
Content-Disposition: inline
In-Reply-To: <20230120122326.1932614-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tFqp+/Q7r8KZ5dAF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Also Cc: linux-doc list]

On Fri, Jan 20, 2023 at 12:23:26PM +0000, Cristian Marussi wrote:
> diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/A=
BI/testing/debugfs-scmi-raw
> index 5468ec08c084..b1c505ed444c 100644
> --- a/Documentation/ABI/testing/debugfs-scmi-raw
> +++ b/Documentation/ABI/testing/debugfs-scmi-raw
> @@ -80,9 +80,13 @@ Description:	SCMI Raw synchronous message injection/sn=
ooping facility; write
>  		Each write to the entry causes one command request to be built
>  		and sent while the replies are read back one message at time
>  		(receiving an EOF at each message boundary).
> +		Channel identifier <m> matches the SCMI protocol number which
> +		has been associated with this transport channel in the DT
> +		description, with Base protocol number 0x10 being the default
> +		channel for this instance.

s/Base/base/

>  		Note that these per-channel entries rooted at <..>/channels
>  		exist only if the transport is configured to have more than
> -		one channel.
> +		one default channel.
>  Users:		Debugging, any userspace test suite
> =20
>  What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_async
> @@ -103,7 +107,11 @@ Description:	SCMI Raw asynchronous message injection=
/snooping facility; write
>  		Each write to the entry causes one command request to be built
>  		and sent while the replies are read back one message at time
>  		(receiving an EOF at each message boundary).
> +		Channel identifier <m> matches the SCMI protocol number which
> +		has been associated with this transport channel in the DT
> +		description, with Base protocol number 0x10 being the default
> +		channel for this instance.

Same here.

>  		Note that these per-channel entries rooted at <..>/channels
>  		exist only if the transport is configured to have more than
> -		one channel.
> +		one default channel.
>  Users:		Debugging, any userspace test suite
=20
Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--tFqp+/Q7r8KZ5dAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8qMcgAKCRD2uYlJVVFO
o/J3AQDrocI8z2YOvnr2lD+y7uAkRhGCdKRDNm0FgOKAHd4zsAEA/eiJeWiy8guK
Tr6z61MAb+ttTNN+z2RMkkHAmvAwEgE=
=Rlz4
-----END PGP SIGNATURE-----

--tFqp+/Q7r8KZ5dAF--
