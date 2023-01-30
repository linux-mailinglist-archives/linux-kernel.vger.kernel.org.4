Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D268037D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjA3BVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3BVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:21:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD0125B4;
        Sun, 29 Jan 2023 17:20:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4r3S4Nxsz4x1h;
        Mon, 30 Jan 2023 12:20:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675041653;
        bh=Mo9cLCon1qChV1ovQ96SPfDPFc2MVpnp4JX+fy0Rg+4=;
        h=Date:From:To:Cc:Subject:From;
        b=dqBw1TDEPgf1t6oc1ceM3wl3JYXrgwrOmTnxKfkdEUCZPJSb55ATwdsAb2jlaDFMU
         /tUGe8XkdkXHwyrhx5SXpgTZ1YhjDCsS5rk5K2t7AasRIMigt1/UjnQwB5WuhHpJIk
         RPsdrNSSHl18fz1/yBvzO8BMaDHPxIoBPw67J8GiBywWF3hUiKBiUd0U0H8KJOMauS
         e0t29BbUwWA8IfEsoTWK4Q2nd4LBhyqQ64ajtpeC19xlrlp8ai693WAeCUQJA8HV1k
         02qvoP85AWXSQVx0ETHntnjb7Ak7kBqDutnfiPkLTBmEKhaqj18l8vTsKtqK0MWDfE
         ZYtOawbCJiGfA==
Date:   Mon, 30 Jan 2023 12:20:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20230130122051.534df03e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oZ6/VeSi9o45OZtcVD/duRF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oZ6/VeSi9o45OZtcVD/duRF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'a=
mdgpu_dm_atomic_check':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9706:41: error:=
 redeclaration of 'mgr' with no linkage
 9706 |         struct drm_dp_mst_topology_mgr *mgr;
      |                                         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9697:41: note: =
previous declaration of 'mgr' with type 'struct drm_dp_mst_topology_mgr *'
 9697 |         struct drm_dp_mst_topology_mgr *mgr;
      |                                         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9707:43: error:=
 redeclaration of 'mst_state' with no linkage
 9707 |         struct drm_dp_mst_topology_state *mst_state;
      |                                           ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9698:43: note: =
previous declaration of 'mst_state' with type 'struct drm_dp_mst_topology_s=
tate *'
 9698 |         struct drm_dp_mst_topology_state *mst_state;
      |                                           ^~~~~~~~~

Caused by commit

  c689e1e362ea ("drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot co=
unt assignments")

interacting with commits

  1119e1f9636b ("drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot co=
unt assignments")
  f439a959dcfb ("amdgpu: fix build on non-DCN platforms.")

from Linus' tree.

Please can you guys think about your bug fixing process?

I have applied the following merge fix for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Jan 2023 12:12:21 +1100
Subject: [PATCH] amdgpu: fix up for "drm/amdgpu/display/mst: Fix mst_state-=
>pbn_div and slot count assignments"

This appears as a commit in Linus tree and again in the amdgpu tree,
but there is a following fix commit in Linus' tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8965071f595b..e1d63826927a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9694,8 +9694,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *=
dev,
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct drm_dp_mst_topology_mgr *mgr;
-	struct drm_dp_mst_topology_state *mst_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	enum dc_status status;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/oZ6/VeSi9o45OZtcVD/duRF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXG3MACgkQAVBC80lX
0GwNgQf/YzDeiGMqMoVAloE8+I2BN73pE9UqNHH4cEw6pXfOmkhXRx+qWSUPduOP
zJekPIEtedEb9da/i5TbvCEUJ5VMvkzfXkFvItDeaJsKZLguX6t/ZDCke5oTCR+P
bb+PoSkFPF9Fsvgcw/RVo6KlvuzL7ncA3vEmaFIak7DYgGJSfT0rzLsfKL4hPG3a
tmRdMnKtmt/7eIHT8nDP5Fy2RFakzO9cxMxuG2pG72eX9c7lhMLBFY8JSCTjvgP7
EvnthNttwwE4iejdvybSQO4XBQ2HD3TXuZp6dq/HcS+h88sWY2bqwDkFIzLm4Wcz
Ep5yIaGc7DozKVWYwsw/rE2oKV/z2g==
=TFFb
-----END PGP SIGNATURE-----

--Sig_/oZ6/VeSi9o45OZtcVD/duRF--
