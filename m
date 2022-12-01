Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04F63E827
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLADFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLADFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:05:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23A900ED;
        Wed, 30 Nov 2022 19:05:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c15so602767pfb.13;
        Wed, 30 Nov 2022 19:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KK8O7jlMOI6W0R9voFxwxKYumGIiD46HV1X85X98DQI=;
        b=QUQP0wQHCAxNQFkYjTDu0PpMbOiP/ZuN3mBY8CvUoKnNQV5DqrztBnpcM+iQTXc5X1
         yG1yfxtnGXI244yiTRPuYjhRUtl5kpK0U8HOn2rCCqMV8fHpC/iywOX4UsADifmAtWMu
         h5du9ebjS5A5yb0hZio4RtnBJ4iujaH4bwK9g09pY8oKdubxyHQwYndDrcyDOUnkDxjJ
         t7iCEOm/fs2jR7iYN6zdv1rqVIRVDy3BowZRtVkS3386bIn5V7LQUKlNhmeMPRF710xk
         YLQdmtL9rcV1aPle1BQN1X7wOHApL9PzW8Dh+b2sW50Uxam6OjJKWmrzThAW2ci8DuDJ
         ghYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK8O7jlMOI6W0R9voFxwxKYumGIiD46HV1X85X98DQI=;
        b=0xOZNa485VkjFZ9c9v5VxagPE24JjeB6QdoMkgMzqbmCDotnpjRVSU9IvvznAlPUfw
         QRH2sSaXZa+1Fd6vN5yW/Sg9HGEqowIGJc3HwnwGAuBjTMpL6rYuGwo9buPyeJdEQhsP
         61LtrZqfLklNcRYdXf5KjDM9BLsWDYYd459XfMc3q5QzRq0E43V2UScfnIRsfR1osAg8
         sNEbm/PH48Fwc9yWMYY1L1taNt4sWif+5AB8dtyvxdPIaEMt2eLuoHzjs/yFHTQ8szWd
         JlxB22lnYuVIhq4Wt8SQpfeydc+CqoXPFY9jed5UPpYDQ/HKWZEvhYyPVs0dO0tuGb/i
         yyHA==
X-Gm-Message-State: ANoB5pkl4quYgjI11Y+vASlgbAnhrroS49MhpEKGEQj+2FDyZJ+wxe+Y
        pHAiDm/D9QlPAI7DWzcCmtE=
X-Google-Smtp-Source: AA0mqf5THWhiH7h71LhvkUzAxi/n2hYMpnESjjEKjTq9xoQUeY6v85Xjn2OS8C7UmdyoEdxcEMhehQ==
X-Received: by 2002:a63:5719:0:b0:476:ea7d:3ff6 with SMTP id l25-20020a635719000000b00476ea7d3ff6mr41097766pgb.73.1669863939326;
        Wed, 30 Nov 2022 19:05:39 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a674100b002191a64b5d5sm3781625pjm.18.2022.11.30.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 19:05:38 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AC58B1042F6; Thu,  1 Dec 2022 10:05:33 +0700 (WIB)
Date:   Thu, 1 Dec 2022 10:05:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu, corbet@lwn.net,
        guoren@kernel.org, heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Documentation: riscv: add a section about ISA
 string ordering in /proc/cpuinfo
Message-ID: <Y4gZ/KZz9rdYj/0r@debian.me>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-4-conor@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gGADNEIMdohg5oZc"
Content-Disposition: inline
In-Reply-To: <20221130234125.2722364-4-conor@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gGADNEIMdohg5oZc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 11:41:26PM +0000, Conor Dooley wrote:
> +#. Single-letter extensions come first, in "canonical order", so
> +   "IMAFDQLCBKJTPVH".

"..., that is ... ."

> +#. The first letter following the 'Z' conventionally indicates the most
> +   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> +   If multiple 'Z' extensions are named, they should be ordered first by
> +   category, then alphabetically within a category.
> +

Did you mean "most closely related alphabetical extension category in
canonical order"?

> +An example string following the order is:
> +   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> +
=20
IMO literal code block should be better fit for the example above,
rather than definition list:

---- >8 ----
diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
index bc3c8ced644bcf..8005add855dc43 100644
--- a/Documentation/riscv/uabi.rst
+++ b/Documentation/riscv/uabi.rst
@@ -43,6 +43,7 @@ ordering, so for our purposes the following rules apply:
 #. Non-standard extensions (starts with 'X') will be listed after all
    standard extensions.
=20
-An example string following the order is:
+An example string following the order is::
+
    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gGADNEIMdohg5oZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4gZ8QAKCRD2uYlJVVFO
o8LXAQDg6voodFPTVXIYpNCPvF2HkaiCwmKqQbyxHuyY8letmwD9Efrm/nRjGJBW
Pgs+RY15Td/CNE2QL19Q3dU8AzkiwAE=
=aqlR
-----END PGP SIGNATURE-----

--gGADNEIMdohg5oZc--
