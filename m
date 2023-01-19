Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A838672E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASB3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjASB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:28:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DB6843B;
        Wed, 18 Jan 2023 17:23:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny4dz3BLpz4x1D;
        Thu, 19 Jan 2023 12:23:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674091432;
        bh=ML4kAbp8gDGzHkL67TSuZfNbjMRm8HROHF4LGBWuSls=;
        h=Date:From:To:Cc:Subject:From;
        b=Tt8TSidQSz80oc51K9zNp61EVW4Km0BGazflCstNHZVwnxnkq03+3BpcaDR/ylrXb
         +mIVaOGp0OqWglzSHz2kOPF9wAWcSutpDPKWmOTtD+al3k+MOT5jeZ9UtNroUu+HQS
         xamPtXGyk6Ob5gvRdSHeXqGlaKzQ/9orU7m4NRS9CdCBNILItOvQB9yROUw/nBBxK5
         ngTLoZVFQPN70wi15ishK1+HmxrLKCl3lXhR2zFoRkIXiwfHT1T5lpORjbBxQjw2l9
         ZNvfbkyzurIe/TiAbd+0d3NPvO+IcixV4vWwfC+4/IKDdtHckXfDEEaaEOdfwKFFLd
         TrW8VqAlinJhA==
Date:   Thu, 19 Jan 2023 12:23:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: linux-next: manual merge of the drm-msm-lumag tree with Linus',
 drm-msm trees
Message-ID: <20230119122350.2a767def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.qAJraL6fPjt3bbmveE/4eC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.qAJraL6fPjt3bbmveE/4eC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm-lumag tree got a conflict in:

  drivers/gpu/drm/msm/msm_drv.c

between commits:

  d73b1d02de08 ("drm/msm: Hangcheck progress detection")
  8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")

from Linus', drm-msm trees and commit:

  643b7d0869cc ("drm/msm: Add missing check and destroy for alloc_ordered_w=
orkqueue")

from the drm-msm-lumag tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/msm/msm_drv.c
index 0509e90d05e3,b052327181b2..000000000000
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@@ -420,7 -418,11 +420,9 @@@ static int msm_drm_init(struct device *
  	priv->dev =3D ddev;
 =20
  	priv->wq =3D alloc_ordered_workqueue("msm", 0);
+ 	if (!priv->wq)
+ 		return -ENOMEM;
 =20
 -	priv->hangcheck_period =3D DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
 -
  	INIT_LIST_HEAD(&priv->objects);
  	mutex_init(&priv->obj_lock);
 =20

--Sig_/.qAJraL6fPjt3bbmveE/4eC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIm6YACgkQAVBC80lX
0GxUYQgAiqgCQIuwStfxlHvSuFPnte6+7b+YMlKHgPHRWZ+w13n9m1oYOv+5kVcj
tSMEgZi1hWupGY/X1dw9ddNMRrZNygmN3aaU71xBel6CnqhFadOU5sti/oLZIJL9
Ku5P0brPdL9fT7OK1EtsifoZLoHKqikqyxn0vf8OIbIFsZVXiY5H8SwdfRyfxYNT
68VqxH+GQ6eblAbs8aNulHXR+z0RMjzxKnoCf181UpvSGXlVQ98ztqfGW3LfEbXs
d7sTAUw7tFQE/c1OKpkPcWgdurDq2xX0AUYk4l0eRXXZDcQXkBxaQjtkfWtAheyK
naf5j3PFhy2AVxeDukUeNOUUNozygg==
=hHIY
-----END PGP SIGNATURE-----

--Sig_/.qAJraL6fPjt3bbmveE/4eC--
