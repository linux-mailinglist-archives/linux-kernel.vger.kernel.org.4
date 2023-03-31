Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E16D13FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCaAZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCaAZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:25:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80065AD;
        Thu, 30 Mar 2023 17:25:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pngzy3pQGz4xDp;
        Fri, 31 Mar 2023 11:25:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680222335;
        bh=+t4WWqtAkunj96V49dW5QfSiOsouFv3Q+ac0K9FwnvY=;
        h=Date:From:To:Cc:Subject:From;
        b=A797uNXg/xIRHsFPfsSHx2yr95ZKhIqi/laAdWlxkBLRboXJwG0hVIWp64+1xa1Qn
         DT3gPsAMmPOkJlW23Ot6qBynv0D5nwL4PDQjAl0Om1h4dR7ydbhGEgT2iGb+SgfWd5
         LQVpKbRHV9kyxSjDDsdBFKyiB0fQeIE9f/KKIR/q0FK9oJBHXOSS7mpFJ6GgSh/V4l
         SwEJ6qGU9jC64vG3IZdjZW0JleBwuBN2lvr8JT38yZup7lWxS1LfnjGtuSpvaxthcJ
         DnKbu2W2Je7wnvO3kLyT20jNHa/j1pCBLTB14NOu/NmaML4aKNMOvny/exMFsqz+rk
         I7jxTOBsacURQ==
Date:   Fri, 31 Mar 2023 11:25:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: linux-next: manual merge of the drm-msm-lumag tree with the drm-msm
 tree
Message-ID: <20230331112532.4727ce04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7GkwabCTX85/Yx+ekRuG7qR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7GkwabCTX85/Yx+ekRuG7qR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm-lumag tree got a conflict in:

  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c

between commit:

  52ff0d3073d2 ("drm/msm/atomic: Switch to vblank_start helper")

from the drm-msm tree and commit:

  f4d83f101233 ("drm/msm/dpu: Remove empty prepare_commit() function")

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

diff --cc drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 6cd7be500dfe,6944c1315085..000000000000
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@@ -411,26 -429,20 +429,6 @@@ static void dpu_kms_disable_commit(stru
  	pm_runtime_put_sync(&dpu_kms->pdev->dev);
  }
 =20
- static void dpu_kms_prepare_commit(struct msm_kms *kms,
- 		struct drm_atomic_state *state)
 -static ktime_t dpu_kms_vsync_time(struct msm_kms *kms, struct drm_crtc *c=
rtc)
--{
- 	struct drm_crtc *crtc;
- 	struct drm_crtc_state *crtc_state;
--	struct drm_encoder *encoder;
- 	int i;
--
- 	if (!kms)
- 		return;
 -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)=
 {
 -		ktime_t vsync_time;
--
- 	/* Call prepare_commit for all affected encoders */
- 	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
- 		drm_for_each_encoder_mask(encoder, crtc->dev,
- 					  crtc_state->encoder_mask) {
- 			dpu_encoder_prepare_commit(encoder);
- 		}
 -		if (dpu_encoder_vsync_time(encoder, &vsync_time) =3D=3D 0)
 -			return vsync_time;
--	}
 -
 -	return ktime_get();
--}
--
  static void dpu_kms_flush_commit(struct msm_kms *kms, unsigned crtc_mask)
  {
  	struct dpu_kms *dpu_kms =3D to_dpu_kms(kms);
@@@ -939,7 -951,7 +937,6 @@@ static const struct msm_kms_funcs kms_f
  	.irq             =3D dpu_core_irq,
  	.enable_commit   =3D dpu_kms_enable_commit,
  	.disable_commit  =3D dpu_kms_disable_commit,
- 	.prepare_commit  =3D dpu_kms_prepare_commit,
 -	.vsync_time      =3D dpu_kms_vsync_time,
  	.flush_commit    =3D dpu_kms_flush_commit,
  	.wait_flush      =3D dpu_kms_wait_flush,
  	.complete_commit =3D dpu_kms_complete_commit,

--Sig_/7GkwabCTX85/Yx+ekRuG7qR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmKHwACgkQAVBC80lX
0GwYNwf8DVepMnLRksEfgiZNbTM01tRyNWz/GtFxFK1mFD8YDzeF2Dxss8x56uPF
WrDOnhaJCiP45NCtIF8au3k9vD8yJY1AvBrIWoJV5ieCmCw5TjrZS1UJKm7EoTMB
dLi8V6O0YtTdLp+Sr/MQjsjuF9shN8ZtvFTb+61Evr8XvKJaZeORKVoQdyDOJqdw
su6iLdMNrkXH+um9epMRqp6aaxFOfi2vtPrSgbATVd2256qLGVLZi76U/FTcRq03
uKpitWII3iAmKDS7V24yJDRcIAy6njtfg9ZWOIYchnOfEenNsbYXmZ1Zq4JHBRv1
Kr8ZCKsQfxsADpD5Wl7RWhEweLBWLg==
=Xei1
-----END PGP SIGNATURE-----

--Sig_/7GkwabCTX85/Yx+ekRuG7qR--
