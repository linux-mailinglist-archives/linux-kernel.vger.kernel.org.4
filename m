Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36D95B9AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIOMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:30:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6E52DCE;
        Thu, 15 Sep 2022 05:30:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso13686154wmr.3;
        Thu, 15 Sep 2022 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=c+Ixagfdqqfi9wNyp/go1IY1VNhsc9BwApfAZYB8y+I=;
        b=a3qy5KM52SHzBpO8QWXXmAg8KbFRBDajnpP6lPCH5KCeQrUfjmnp3iwzv4h9eapnB9
         d6iy9VTfxLbAhFUWBqzS6nVBZOn2rbiVcF26Rna5546dJLp73XHY7Oz7S9XsBZswg2JG
         KTyravUUhz1wPa8i8P4CUcLDGSC7MvotdYUnQwJri3WjmumXSQm5Rc6JYxwMyZ6S9+rd
         LrJNgC48RCLU2smuV6XLM3YACYI0ULiGNha+/NmGD2IbGTRf8ljlejmhHseBZxoWh1qV
         VSzu9V9TxPfTQUWYXWfktrlRzcbangO98rrywJN51kvJytWiOejCW+eBBPtabSEnmxxL
         dlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c+Ixagfdqqfi9wNyp/go1IY1VNhsc9BwApfAZYB8y+I=;
        b=dgJfc/hxGKVbnlKxrnZcJmTo+KDcTjOVK/JFi+QlOnDTIeY10Dr6yV1kri52U2nzrX
         qAmytraNor4kT00Lv4ytEqCFXb4tWb3zbGoKmr3H4qWzytlw0OeYoR9S9/KtgvxFYkCI
         NoLAQTjznLEOMf9ocGc+MRrD7Mr8La5YbCuF7VTF+yZP4LHFcwuHbYKlssrs6yxPL9yj
         8y3mpYGHnwIYeSf5PJGpFk+IZpu5Q28jQNNdroyEexUy/Ys5KYmL4eOgmiYtqLq30mGT
         w4VMx2pqXrbGUOi052Oid0QLHenTKQzUUNSmV4zaHLUsqzG3PAOIXy5sDTqsJUq7Qlq1
         X5JA==
X-Gm-Message-State: ACgBeo0alr8UQEcnpZNB5RNYHmm1SQ3glyPNo5D3Gd2JJP+Drwwmmxs+
        HeuaqpJ5CkP6YiR46XlGtW8=
X-Google-Smtp-Source: AA6agR5ynfZI5mse/u4KZUzS26/Osxt7zqxNXljRtp4wLS14zPizEyLgNeVDmvm5SpFmI/vlYOLaiw==
X-Received: by 2002:a05:600c:594:b0:3b4:7637:9444 with SMTP id o20-20020a05600c059400b003b476379444mr6707704wmd.52.1663245044964;
        Thu, 15 Sep 2022 05:30:44 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b003b47ff3807fsm2738613wme.5.2022.09.15.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:30:43 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:30:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        treding@nvidia.com, jonathanh@nvidia.com, spujar@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Enable HDA node for AGX Orin
Message-ID: <YyMa8aN5vS6jIF45@orome>
References: <20220901043305.26634-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7CfBdTTZ6H+m+y/A"
Content-Disposition: inline
In-Reply-To: <20220901043305.26634-1-mkumard@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7CfBdTTZ6H+m+y/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 10:03:05AM +0530, Mohan Kumar wrote:
> Enable HDA node for AGX Orin platform.
>=20
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--7CfBdTTZ6H+m+y/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjGvEACgkQ3SOs138+
s6ESuhAAsF6Ndt6GgdhgHLdA/U18ihSuLGLrHM264Dg6eEyUo5LewHRSlfQo1ZgJ
21M4SeklzkTKirz7r3IJJo8JZN3u4PfejQ5fzDF2OuYOiMTXcVmnKc42A2ur9yn5
6tx92YKnVXF39plDE86VO3Rxtkfnm9Ej7lWP7P3Cdnz3DlOoz5jo431gWlPsA618
TdpxBXj544RNJl/gwbB/9YVVlpsYNb4xHM9KOaXPBpvbwCu0Ioap+BtBJUaMTyoS
O6zevTL7yLQgap5BgBQb9pX60TzXpofpzlkpNY1iTtcaxWbHLsCufx26Luor8A6/
V0zStLjyyjd1UwK/pLvwBm67HIx33qUWQCCETq9ySonAGDKvLUDh3Z4mC2+0RYkG
7gBmOZY/9FoO3KM7oCsXf5VDOlogUUYlvIc4P2gfrPct+PUJpAScWvjtODD+9Opx
p2hfzXHh1WAWXH87/B7RRkDGhyNBF6dpbkRa2AXV+a6VC7H8RdfWc7Jh6S9Kggyy
/OTV06pwjKaPIOkNPNbPE4hc/uTTdw44BzZCBBjNtrYfC0syZwmjxhTokDXfOd6h
zKyOm3ol5dwSLMqOEpUoXtxFKxA/Tl+YdxsXBAGjKvRjlQpbQ22VVj5YJ3f0OYS0
4WfQdLMp4q8nGo/JHJZzqiU72Tbhmt/eWPr2+AE6pDTwM2JesPM=
=T1Oo
-----END PGP SIGNATURE-----

--7CfBdTTZ6H+m+y/A--
