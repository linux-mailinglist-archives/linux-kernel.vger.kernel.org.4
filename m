Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C3720373
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjFBNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjFBNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:32:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB9E72;
        Fri,  2 Jun 2023 06:32:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b05e96dabbso12122355ad.2;
        Fri, 02 Jun 2023 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685712729; x=1688304729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLcyyQh2yLRZuI0xq1Spx++5r4QAu7H4WRjm1jN0YiM=;
        b=MVb3eFphqnGFuZnrZa0fkJUiXKJj6PA6qXPXeVimS6DpQ4AxPt/zIIOaLriKK4YM0s
         OD5TKvqpdHYN3x0/QPosAXtzCAYO/IE9X3t1Maw3pngCYU6/YtF43NYVhpaM5BqMhMv4
         S2uj6aE89Q1SllxfQB6OIsUB7rgbHTxAD7lbwdu3ByjWg/6hlW7AvjFJcDKVIZLUfnPK
         H/F9ARWZoV3GO5l9OEIH73Apr9UeXgkqMyy5TEzNJBMiJA23Lzp8RC2vsdStRVoyuQmt
         VJ/ATsgU8O3UsjCjDRGBbbnEbgKDL1MHMaSDrkjAnbG5W7EMJQ2Id+enPSwzyi5jI7XV
         m72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712729; x=1688304729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLcyyQh2yLRZuI0xq1Spx++5r4QAu7H4WRjm1jN0YiM=;
        b=W/aXkTQZ/0XA7QU7WkADqNP1ty8u3P72YgAiPRZISlus+tA59d4pKk5SOcCsWlJWVK
         cYS8hY1X8mzTU79CzqiEB9plNHc/58n3F4spBkk9IMtaWmRr4r5lxRvQ0eVRAF48HuOz
         sycw1Cop7a02QqFlUe63fINidYeREZjgKuiX4Kos4AskIQTRcJBmFxpbtCEM/Xkzf6Ni
         yceuq1ERhqrPz58DWXIaq0ZRfklhFVkOTAmTTgyvHI6S3EHYS88xMgxkmUN/fyK5X6tF
         aR2AoB8KXbxSTo+7aeFMN8OfoeSUZDIptFFSwm6G1rg38utYBtvh1JIpDY6K2I0PLLbu
         /s+w==
X-Gm-Message-State: AC+VfDwYwi9aO1bdycsYRxq7ZHYKfBecqPpsqgS7UVk1tKSzUMp6UnqG
        A6XDHpo5fvR5I0E68+1Dt9Q=
X-Google-Smtp-Source: ACHHUZ5J63g6NUi0y4MlVavRTrgcGPUU1MafIBD3RB7CH7ggN40W6Ah2+s359IQfSJwPB+m8eYrFiw==
X-Received: by 2002:a17:902:ec81:b0:1ae:4562:14f1 with SMTP id x1-20020a170902ec8100b001ae456214f1mr18105plg.9.1685712729246;
        Fri, 02 Jun 2023 06:32:09 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001aaecc15d66sm1316041plg.289.2023.06.02.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:32:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AE936106A6F; Fri,  2 Jun 2023 20:32:05 +0700 (WIB)
Date:   Fri, 2 Jun 2023 20:32:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/todo: Add atomic modesetting references
Message-ID: <ZHnvVYM7K4jvP8QK@debian.me>
References: <cover.1685696114.git.geert+renesas@glider.be>
 <7cea42cd09540657875a210cd16421125497d690.1685696114.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DPoP2WNc/X86Xlln"
Content-Disposition: inline
In-Reply-To: <7cea42cd09540657875a210cd16421125497d690.1685696114.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DPoP2WNc/X86Xlln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 11:11:34AM +0200, Geert Uytterhoeven wrote:
> -There is a conversion guide for atomic and all you need is a GPU for a
> +There is a conversion guide for atomic[1] and all you need is a GPU for a
>  non-converted driver (again virtual HW drivers for KVM are still all
> -suitable).
> +suitable).  The "Atomic mode setting design overview" series [2][3] at
> +LWN.net can also be helpful.
> =20
>  As part of this drivers also need to convert to universal plane (which m=
eans
>  exposing primary & cursor as proper plane objects). But that's much easi=
er to
>  do by directly using the new atomic helper driver callbacks.
> =20
> +  - [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-dri=
vers.html
> +  - [2] https://lwn.net/Articles/653071/
> +  - [3] https://lwn.net/Articles/653466/
> +

Looks like footnotes better serve these links above:

---- >8 ----
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 51eb67f5268c5e..6ea92f48a2e21c 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -49,18 +49,18 @@ converted over. Modern compositors like Wayland or Surf=
aceflinger on Android
 really want an atomic modeset interface, so this is all about the bright
 future.
=20
-There is a conversion guide for atomic[1] and all you need is a GPU for a
+There is a conversion guide for atomic [1]_ and all you need is a GPU for a
 non-converted driver (again virtual HW drivers for KVM are still all
-suitable).  The "Atomic mode setting design overview" series [2][3] at
+suitable).  The "Atomic mode setting design overview" series [2]_ [3]_ at
 LWN.net can also be helpful.
=20
 As part of this drivers also need to convert to universal plane (which mea=
ns
 exposing primary & cursor as proper plane objects). But that's much easier=
 to
 do by directly using the new atomic helper driver callbacks.
=20
-  - [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drive=
rs.html
-  - [2] https://lwn.net/Articles/653071/
-  - [3] https://lwn.net/Articles/653466/
+  .. [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-driv=
ers.html
+  .. [2] https://lwn.net/Articles/653071/
+  .. [3] https://lwn.net/Articles/653466/
=20
 Contact: Daniel Vetter, respective driver maintainers
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DPoP2WNc/X86Xlln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHnvUAAKCRD2uYlJVVFO
o2R9AQDL0rXdsAZ2q75Un/nud8+9skYIJP+8pCerpXMSUJgTAwD1EbjcCcLx7iqs
1xk3nWj97FZCR273c6lRVz3Cm5VIDg==
=gt6j
-----END PGP SIGNATURE-----

--DPoP2WNc/X86Xlln--
