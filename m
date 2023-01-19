Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9C673A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjASN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjASN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:26:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9847CCFE;
        Thu, 19 Jan 2023 05:26:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id az20so5694428ejc.1;
        Thu, 19 Jan 2023 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiP5ZFmcx2OTxwniI4xGJcUy27bYGjwuacvtD3uvzoo=;
        b=mt9IcV/vMTGGvHWq9P6UGhzbi0Mug9GHKVdHYBWvQsDk+26hcosJSBqyKNEblO2BZL
         zLJdTQSY2udGSIz1ETomuv46u8Wi4PtJCYsQ4Xj9/z2kXAB0Rfd4oLrTLqOH0BENXlsi
         rZC0Mod5xd0nzzB0MhISdww+I6Jw7Z/xAwUi25nxMpj7QUMmo+IDRmenUo6hgdbQU85u
         9+yPsIttPEq36HKynSYz2MS9cSd8hVYEP7y8xZmh5s5hmYtQGJm9LnlWczt0oJymoKwg
         byHhhl8JQiDvNgTXSH1AzpCmrXWfEOHtm5Zcy329hWMXEgPRwFUMeOPp+Uk5cGYdCosR
         5mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiP5ZFmcx2OTxwniI4xGJcUy27bYGjwuacvtD3uvzoo=;
        b=Gy7pLypn/C4jOUTlZSMViEfYfS87Bv585LmDOK3d3sMBGAvVRfnDJCQh5yG8ZzR5l2
         JQT4lD/mc0vbsl04jgiou+Tjka8dTnR71sAJeV9RpXx2fJFaDvxc5XvUYXfqeyjWKlgt
         1cMnfFWRn0rdR7g4VgXgHM1Pr6fas543IL/P7TQtyNkAF7hAhNEbJy4lJ00gqBsyG8yU
         RdkfrHErPjgcPDwkJtkoONbvPI+CHS59Iggq3WLvn1NPPebFbyWvHC2MQLmGJcuCmtC+
         RZWihYXlLdKgWDxehyN5LuYRTSbEMC3ZjET9LX++gTtlRYwfVUUtIIFGMptw6RPqz6Xz
         aiUw==
X-Gm-Message-State: AFqh2kreFPWMQP9ruBUXUXUOKYgRWGw3bgI/lTmCUUPEPKFevWTsLxR4
        yDnQUhowpXtvE29tNJvrs9c=
X-Google-Smtp-Source: AMrXdXtWIZ4JxXIpsDXzap7PvNCNEPYbqxn1J29DN1suGYMZTmmgem5E50DYhH552q9vQ4fSlII+Tw==
X-Received: by 2002:a17:907:d10:b0:86e:df17:df94 with SMTP id gn16-20020a1709070d1000b0086edf17df94mr15311091ejc.14.1674134811629;
        Thu, 19 Jan 2023 05:26:51 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b00855d6ed60desm12395156ejt.192.2023.01.19.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:26:51 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:26:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the phy-next tree
Message-ID: <Y8lFGQj7w2kJG9t0@orome>
References: <20230119153623.339d6739@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Is4uXp/M2mAHcRsX"
Content-Disposition: inline
In-Reply-To: <20230119153623.339d6739@canb.auug.org.au>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Is4uXp/M2mAHcRsX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 03:36:23PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in the tegra tree as a different commit
> (but the same patch):
>=20
>   fb1ff01307ee ("dt-bindings: phy: tegra-xusb: Convert to json-schema")
>=20
> this is commit
>=20
>   56052eee689a ("dt-bindings: phy: tegra-xusb: Convert to json-schema")

I'll drop this from the Tegra tree.

Thierry

--Is4uXp/M2mAHcRsX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPJRRkACgkQ3SOs138+
s6HUcBAAnYwWjsyhqIuoawzyIuu9nHAn5GwrawxqkymarDv0kqmvX7lQy8+ZU1Mn
uchXadz7P2W37G8sRgMxKLfdZkWBAS7rcwcuoomoYf/HqBijlqVYBNXN5TLApWxc
CxwZeTdjQqCJRQn+Jk3V1KDw6PkhTzqqL/OkfERHu9I+8isCUaINQ1nmv/N7raUi
UJ+/khikqly62sCN4iYq33DkOKKo/fYT55+Y6HZBG+dgmWLG4ukQcI3dLl6yiJlE
7u5rBLDHGztW9PZbs/8No8+PgG2SYEBpQDGlvzVtY/y319/CU97wKUeGQLzs4f+8
E7oSkkMX9mZ3GWDQFhF10vKuyrCYESORQ5F2MAo2iP06pb859xUybLIvVzYDckSB
40E+pCDjP4sBDYnuHhGB1iRLCxClAwbJTr1FmyML5X1wPNq4MCEIEttyoEIyDWLo
S5+yAQAppXYeRa6WG36HgTd+dAl5sS5YoCVXVbyNmmf8iZXE1fEem7gEJLkG9CTc
7wJfQokhtDN6ht7djeV00YqVPL8QeYIlTFqYYvBv8RPez/aCLky5gSCcMYDAjvNO
NcrC1Ud/T5Aho9/kHLVpXOAjKhy0xSHJA15SDNMxPczeXTSFzQXvOe8824Y13aT4
58ldmhELcDzHQdnLR464UD75ta//CW1vTb24r8aEzvfCKyu+BDw=
=8+CZ
-----END PGP SIGNATURE-----

--Is4uXp/M2mAHcRsX--
