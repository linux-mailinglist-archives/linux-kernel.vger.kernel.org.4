Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A76FB0BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEHNAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjEHNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:00:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361F394A4;
        Mon,  8 May 2023 06:00:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bd87539c2so7122212a12.0;
        Mon, 08 May 2023 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683550836; x=1686142836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+QjjUsqPsRzGGA/4usgRP155s5O6ap9iO72HiNoLsU=;
        b=n1SjO1FgoC5mu9I6JHanqYgGMBXZaGY3Fi9v5Jqi/Mg/AheBVd337VSTDCPgnax99K
         nUCyvJY1vYQagkjY94DzLMCDU4ZDnOA5SCBrRdoc9YF8BBWIOULyQ7SBmtHp3QmlePps
         Pk/hFqd5Y6hi73jCHcNuJfylU1p1JkavUmTSqK62zZ4sGsSY+/hDsmRTYu4LQK0BQJOG
         O2rVY+QRxzKAdErkNtVPgZmFO0j0FRhXPAuxO+FtfYGmXl+gZV4951k2qr524KijvUc5
         tZyM3yJN8YTllpoV438LeBHzIRV4uTjiKGXCAMrC+Vebh/xTLXr3wOFQlSMRRrHZW1EG
         r6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550836; x=1686142836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+QjjUsqPsRzGGA/4usgRP155s5O6ap9iO72HiNoLsU=;
        b=ie7gVaE7v0h/nu022V0NF7ezno1dDrylM873b22rWcS3Q72OWK88O5fVJOb1vRU4ma
         O7vC02UpY3N9rzYUo51V0D8wZZe8Y97/K82NAKHkWxTpy1T6YI++tiEMrucQGcdJTgx1
         Ep9aRzfQ1CQjhWkneQejzWeYYfSqqZNW9bstktX5ISGoqaVT/lLTC0ceBic1J3L4iBFv
         8AnQFcxEhRbQZOjF+FwQGjowSgDHx1bxo3H78oGMdWaiFwcuwDai3FXexIp1tPR54NRm
         SWzDrdyLoE3Nekgclugno0Z9nAiYb6kCCZHt8PbTDVVvxhpcXYHrFvzkVXttDf04M0zb
         A/Pg==
X-Gm-Message-State: AC+VfDzX/FA8nQd/sFoBS73hinevgj2H/kkzOqV0XrytEjEm9EXIvYfG
        ClTZaEKdPD/6f4pzJgfGCZ8=
X-Google-Smtp-Source: ACHHUZ76jV5bGibIwaI1JJ4+4/ch3ab8j/FtzhL7zYdGULD1+QnF9WTIN+NmIMZ1wnmNySeCLyaZ1Q==
X-Received: by 2002:aa7:da95:0:b0:50b:d553:3822 with SMTP id q21-20020aa7da95000000b0050bd5533822mr6720950eds.7.1683550836297;
        Mon, 08 May 2023 06:00:36 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b0050d9bd4d557sm1610140edt.47.2023.05.08.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:00:35 -0700 (PDT)
Date:   Mon, 8 May 2023 15:00:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Message-ID: <ZFjycrcgRyYnmHm2@orome>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-2-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4F8XSA1RY80B7563"
Content-Disposition: inline
In-Reply-To: <20230508122048.99953-2-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4F8XSA1RY80B7563
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 03:20:46PM +0300, Peter De Schrijver wrote:
> Add the compatible string for the HSP block found on the Tegra264 SoC.
>=20
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
>  1 file changed, 1 insertion(+)

Might be a good idea to say in the commit message that this isn't
backwards compatible with Tegra194/Tegra234, hence no fallback
compatible string. That's already in the commit message for the driver,
so either way is fine with me:

Acked-by: Thierry Reding <treding@nvidia.com>

--4F8XSA1RY80B7563
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRY8nIACgkQ3SOs138+
s6FhLxAAtVSMVas/p4dUEysgZFobEgWmE8m1ZpXtA7wXfxFSTI7vPqpTpZTmYlm6
z10wKif/vtp11TE8M5fjUaNPmNBvkUJSUtzWHVASlh1Uo4IdCcK6jAg+T/BhgEy2
eoKgQNWt13KQVvElWjjnIK1X/+NZJKAdDgQe1QENN1bZqpRsBTMU9aXax9GrBSfq
7wm6MMrPAnmi4viYV2GCeO6Oz0OC3GPa7L8gf4doR8IiYiwPG0RnisI7Qayorul0
cTSCp4V5bStEKI/u830QFSdYZY8qExLS6voh22OcHsrM2qgU0RY9apH+iKjGE3K2
/4i39v5t1PG6rYUKzw4KAuiOCzPkqH4+WdqG+DB7Hyq+rX+VZPob9NsEK+sZ5HVF
86SvPhcuTBc/IdS1hldRzl7mdQwB2VGBrfh4i3LG3Yo1mR5FlsnDgCy1gAcndLFG
pS+hU+8ERHQRnr66+WXvjRSL2shrgj/1sQfS0mO7aqfPPnVopWpYZngIMIx3qGh7
MwIKhtLGRLghqD6/p0ohUHhpYT2InDg0smVk2mJGFYG8f7/pDzmyDBdDGaXCbal+
Gq9flM5cHphl8u/P7B4FIQrCYyJjp/Xoa6fafy+LnxCnsOvDkifnBBYmc/8A4Zwc
GPKRH2KNZl3sFvTj6OIGbBsaYHdrGhBO9LfhzY7vMQVs8SXAP+s=
=OBUe
-----END PGP SIGNATURE-----

--4F8XSA1RY80B7563--
