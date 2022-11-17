Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6E62E869
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiKQWaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiKQWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:30:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A0786EC;
        Thu, 17 Nov 2022 14:30:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z20so3194084edc.13;
        Thu, 17 Nov 2022 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8r2hvTqtT2/9Id2JMFqXS6DclD56mD5BlAZLpbsXMA=;
        b=SrWIYFXksoRYwR/VwX5PlP7JcKqHRtzJ26ruhzdHqc/FQHPR7DIsX1hMW0T2sZBegD
         ClhNFvV+n1G+4wmiNVj9qWxHyp4KnhnbN1zkHS5BWTA7SJ8g2gHdku1T8eCMlwOZPeV/
         CgdDovfIcwLGF2UUm8f0ubZO4xn90zfjUqAaAvYhRTWtHq7wyCbmSRqKnSNWEgjvTjFZ
         Kx0EerHaufm5EfQzd/GPgKAGoAfWVneR+Hh/fvWimhZ9c6dmm7g3UatoGV4iu7eP7MAl
         jskyoiIw5tSFk8xPhyPp6iH3C34AYCWRisRYPba+cdKSlYiRf0L+oLeZ00zF/lw4x/fJ
         7z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8r2hvTqtT2/9Id2JMFqXS6DclD56mD5BlAZLpbsXMA=;
        b=f3ts3ImFIJwPjNL+eoJiRG4vcXtn13iMnUSisEFyrWkOfrOjgCIANf3Jlu12avaIcx
         i3j4gyQJvps93ojDVe/p7pMqZZTq8Pxe3dN8YRUgyruSq8YyS6Yq0ispBrWX+LChuqDU
         WEAeZ3a7lFVg9rvsjxr3esHGWQydqvbD1bP7YOblRN+l8LCj98OWRI/XuISj5PQb3HPR
         gHM9UHTbG9d3s5Kwdi0P1ZtLcJXP6id5RgN344/R877amMwcbQqxOgBT0uE4+ew8x7nk
         9wnnAHTn0UmhKxEJm9KpQraIE7uJIsEJ5d50RiZ9h6RUJm3L1HXtF5+ZUavWIL44wEK/
         dozQ==
X-Gm-Message-State: ANoB5pmi1RthO2f73ZvvoK7KH9/b5UGpMgYHhrFTLfU5+loDUdDDZm2b
        c6PQK9KduOcHScqkDBfwfK0=
X-Google-Smtp-Source: AA0mqf4n3Yx5gW3E41jCsTH7nUuHl24wpjEZyB9NHPiJLZ/hcKoMv5hd/0om0xksis03jJa0wwR9xQ==
X-Received: by 2002:a05:6402:2949:b0:468:fb6b:3a79 with SMTP id ed9-20020a056402294900b00468fb6b3a79mr2021996edb.63.1668724208595;
        Thu, 17 Nov 2022 14:30:08 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090627c500b00773f3ccd989sm897501ejc.68.2022.11.17.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:30:08 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:30:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jim Lin <jilin@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/3] xhci: hub: export symbol on xhci_hub_control
Message-ID: <Y3a17s9Usnlu66nH@orome>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-3-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e0I/79YVqY9KszfN"
Content-Disposition: inline
In-Reply-To: <20221111101813.32482-3-jilin@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e0I/79YVqY9KszfN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 06:18:12PM +0800, Jim Lin wrote:
> XHCI host drivers may override the default xhci_hub_control() with
> their own device specific function. To allow these host drivers to
> call the xhci_hub_control() function from within their own
> hub_control() callback and be built as a module, export the symbol
> for xhci_hub_control.
>=20
> Signed-off-by: Jim Lin <jilin@nvidia.com>
>=20
> ---
> v5: new change
> v6: modify commit message
> v7: change commit message
>=20
>  drivers/usb/host/xhci-hub.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--e0I/79YVqY9KszfN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2te4ACgkQ3SOs138+
s6FBeA/+MBMGHOuhJF6x+gJm/Q3OYwe3ZzICOpoHbBwtgxTw1T5jdA5iVtG+JdK3
MUshmERPQrpJbZdhoLV/TZXMk0igCPy/Pn5H5CnS2TJ9HQlVLEHQ4anYm8FQ2MC/
9wXVMaWIOUUwUza19g7AKxVTRAOUy8f8loz3nNgZMV055olxwlVYeAwPtr4dzFQF
5pnWM872/Khtj2kHn7+NpbR0C1BGcllhj41V9SCvTt8GXG4L0y+LMR9EHq+w6jLc
S3YBRmdjDLB1vcG6hmj34PKImaxDa8gtpziXkauN0nV9SrdC1Y13VffTi3sJ/0oX
gvSPPi05yd+gRZAjSgJtLpgcBMsvMr/sopv21yorO+F9qMeavWZG4wY9I5Z8AJVv
Hitt95/3FP/RQA4ifGM2KNfkVPgJf8kVdpaZrOdetcX08KQZWhFjM/EuFHLMfdqA
D8QeOvHBnajw1gYRhTPC04YlOJGGBVQSB6pa5su8QT6CSr/sjj4UKNxWKfqTFs+3
iEA1URn1YSD3IquSbxISKBBdwNqItt5nSAxKViZIhRrWdnCsUBGluyyuatLyG5m9
mlc6XkbqBXwF8kIeNzdUXkTB3kpKBACVhfy5CyFRZIPe1+hO12jI3BF+WH/HjJqx
d60aw0Mqr/TuZHShhYDVX2ZWktDXyEAP6FvMtyNK7v24fnh0oqE=
=cIKx
-----END PGP SIGNATURE-----

--e0I/79YVqY9KszfN--
