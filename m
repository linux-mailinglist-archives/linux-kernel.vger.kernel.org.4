Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97667DE26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjA0HCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjA0HCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:02:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415452C66E;
        Thu, 26 Jan 2023 23:02:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P37n01MyWz4xG5;
        Fri, 27 Jan 2023 18:02:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674802949;
        bh=6gH4IKc6HNhdES0qvz8VWm4LlOaKSyUY97nT3yO26mo=;
        h=Date:From:To:Cc:Subject:From;
        b=A9EYW7ixH/XzqjKYVL2GgAGLnKLu1i/XMahrLFZG7LsTnr/XpygZJfnoubil4KJ0D
         bkqhtLSHaRLGM8pW/J7n5w9FgYbv5Io8bqsxB92fYp4FxbOj6qaElDijc6E26oX4cm
         j9SgPVGViPXcs3gRBMEY++/0Ts64WRKBO1btGashN4aP/e2d+V7IhjGQc7Gu4deytj
         tIgv7q71UxaDDHM9zhUv2d+qk9Gy5oarvqreJqrWd0uqGjDFC7CXhD2gzZ3cNEOaGM
         CIcPihISGQw+7ODfSQNZmNpQ/Opsub5iHIoZxcYpZltDu5tJDOoS/q6lnms9dI2B2p
         L5B0DhVvalS2Q==
Date:   Fri, 27 Jan 2023 18:02:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rpmsg tree
Message-ID: <20230127180226.783baf07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/frRvHQhF_rDoSX2W0qag6Z6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/frRvHQhF_rDoSX2W0qag6Z6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rpmsg tree, today's linux-next build (arm64 defconfig)
failed like this:

drivers/remoteproc/qcom_q6v5_adsp.c: In function 'adsp_map_carveout':
drivers/remoteproc/qcom_q6v5_adsp.c:369:15: error: too few arguments to fun=
ction 'iommu_map'
  369 |         ret =3D iommu_map(rproc->domain, iova, adsp->mem_phys,
      |               ^~~~~~~~~
In file included from drivers/remoteproc/qcom_q6v5_adsp.c:12:
include/linux/iommu.h:473:12: note: declared here
  473 | extern int iommu_map(struct iommu_domain *domain, unsigned long iov=
a,
      |            ^~~~~~~~~

Caused by commit

  f22eedff28af ("remoteproc: qcom: Add support for memory sandbox")

interacting with commit

  1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")

from the iommu tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jan 2023 17:58:15 +1100
Subject: [PATCH] remoteproc: fix for "iommu: Add a gfp parameter to iommu_m=
ap()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_=
q6v5_adsp.c
index 2dc850f48f00..08d8dad22ca7 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -367,7 +367,8 @@ static int adsp_map_carveout(struct rproc *rproc)
 	iova =3D  adsp->mem_phys | (sid << 32);
=20
 	ret =3D iommu_map(rproc->domain, iova, adsp->mem_phys,
-			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
+			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE,
+			GFP_KERNEL);
 	if (ret) {
 		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
 		return ret;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/frRvHQhF_rDoSX2W0qag6Z6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTdwIACgkQAVBC80lX
0GxutQf+NFHMFY+sQAz4PhnGTSJk7raZfueLnfuLMFw2OBJvrm2DUENqPHzjY7gA
gHJEE2Wv8towOukOlbfaTsl6K4CjCQeOjHDLwzaT/XiXhGCT9kPpB3D1SeK3B9WA
tJ8J1mPrbpXJX49w1qqSH5eut1N9ofYBM6VkZ6er0ljvxORbX6gNGcfmKFtKgig7
+gqR2Gx7OUQDhMxuujdlH+DtI6+8EDfORCtEaOHL/FUVzGJyM6BMQKNMybicUw2p
3kjWAlOkXMWxEP231qNO84NtsTBuTTMRd2JA++bw9caOyZj1Qek+oHZo5pN0E0Vg
Mfn6Dze6VmphPcLp4zGwJUYBoBnthw==
=Sy/m
-----END PGP SIGNATURE-----

--Sig_/frRvHQhF_rDoSX2W0qag6Z6--
