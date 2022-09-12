Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B75B539F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILFmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiILFmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:42:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326C1B7A0;
        Sun, 11 Sep 2022 22:42:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQwTq1Wf4z4xDK;
        Mon, 12 Sep 2022 15:42:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662961345;
        bh=FUlwZvf0AqBJmNJhvyP/tZHWBYHMhvn55UsXTMROtKA=;
        h=Date:From:To:Cc:Subject:From;
        b=XOFU04HgE6VmS10QCnapoP+sQZHQifv4NkoMsiIR0g1c5gtEtEOWV/6CBHyrw0Yjq
         Ow9pfHEfUcVHjyp5s+lc8iDjxcYS3zp+M8VxmT5yixdx2QgN43iZiHBfYa6dg245Zm
         +LQr8ECnZDTtNgYnGP27q7Nx8wHzL0+1wRINquDyp5rINkHhbC9mfd/Az8Bo1CMtIC
         LEi+dCh2gEZObytpN4ByJTOK5yRiuyOG93gDH9nJDcSrbzVZPuhVU7ewxTuozCnTMZ
         8PmgAXOhZeAFrfbgo+ELH3PzcnfSKf3M4w+5VdxXT16wnic2ATLvu889XZh7RblB+F
         s9qXC1hR02zAA==
Date:   Mon, 12 Sep 2022 15:42:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the coresight tree
Message-ID: <20220912154219.162eb9d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IuiIRRo5jrrAH9ebJeOiukO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IuiIRRo5jrrAH9ebJeOiukO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the coresight tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwtracing/ptt/hisi_ptt.c:13:10: fatal error: linux/dma-iommu.h: No =
such file or directory
   13 | #include <linux/dma-iommu.h>
      |          ^~~~~~~~~~~~~~~~~~~

Caused by commit

  ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSili=
con PCIe Tune and Trace device")

interacting with commit

  f2042ed21da7 ("iommu/dma: Make header private")

from the iommu tree.

Since the public interfaces in dna-iommu.h were moved to iommu.h, I have
applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 12 Sep 2022 15:35:37 +1000
Subject: [PATCH] hwtracing: hihi_ptt: fix up for "iommu/dma: Make header pr=
ivate"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_=
ptt.c
index 666a0f14b6c4..5d5526aa60c4 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/cpuhotplug.h>
 #include <linux/delay.h>
-#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/IuiIRRo5jrrAH9ebJeOiukO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMexrsACgkQAVBC80lX
0GzZvQf+PVGBGB26JJw4JuUv5x9upExpqUgGD4aLhn4JlYfAqk7AGXx5KkmeAx99
bbzjfVX+BtgMqvSgmMayKW1UqDUlA7ALEV25QSiJGI0azxhDvr1McTrRMI+UmXal
MnR3OQCmtB2hai9uqWTIaTj4/31UFFHWT5d4Wu2YpoH2WuiQpkmjsqA0suELyasl
xqt7UU3Z3cirnoyJOH20VSj9JQFOkWlxdWzgAOLhipLs4TNMklM50W7oXOlQgePu
fyF3ywadH5pOvivALcvBqMKXa5ds4fvkhY/DjudLnVdeoclK2BIfA5WWuPDiE9YA
S2K5UX8nzRSvkzsZ9nIR1TGWrhshdA==
=Jhdr
-----END PGP SIGNATURE-----

--Sig_/IuiIRRo5jrrAH9ebJeOiukO--
