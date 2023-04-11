Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60CC6DD2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDKGVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDKGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:21:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEE9F4;
        Mon, 10 Apr 2023 23:21:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwbLy1r4Zz4x5c;
        Tue, 11 Apr 2023 16:20:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681194058;
        bh=9AyIDcvwF06NZkDRxI78Vb2HviPeCFBBdTDpIiWgwWs=;
        h=Date:From:To:Cc:Subject:From;
        b=KY6mICek87F9pgDoO6GuixnhMDSTo8fOD3SsZOY+ODIivhyPBSgFjwwWTLZN1bdEi
         f/D4Y9ySmfa+M7iri9asfDcdY2w1hj9KlSdl8AOef/p/+6voYJPrr3rVF3zNlzFjxJ
         rUnS/6NQatTSkfyls6nGw8mRtIc/+pm1J11g4tjeaJOgQsAgUDd+e3lrL4EqJ9VW5J
         kNOCqBG5Rtq0vvjOSZRnCHX8twGcw9Ca6zGeSdamcHw5tklLchEquSP8hnPj4UfMav
         JFJ7XXpOchQvJoH1kH6LeiAyF7yZPLkzeD0ICAt87f9Gkt4h3fd8FcszIYD3e+b7QX
         PyVWSquqJbBRg==
Date:   Tue, 11 Apr 2023 16:20:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failures after merge of the devicetree tree
Message-ID: <20230411162053.0adfd01a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dmNPemH+cOjP4xKh/n83ZYQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dmNPemH+cOjP4xKh/n83ZYQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (i386
defconfig) failed like this:

In file included from kernel/irq/irqdomain.c:15:
include/linux/of_address.h:111:12: error: 'of_property_read_reg' defined bu=
t not used [-Werror=3Dunused-function]
  111 | static int of_property_read_reg(struct device_node *np, int idx, u6=
4 *addr, u64 *size)
      |            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/base/property.c:14:
include/linux/of_address.h:111:12: error: 'of_property_read_reg' defined bu=
t not used [-Werror=3Dunused-function]
  111 | static int of_property_read_reg(struct device_node *np, int idx, u6=
4 *addr, u64 *size)
      |            ^~~~~~~~~~~~~~~~~~~~
In file included from lib/devres.c:7:
include/linux/of_address.h:111:12: error: 'of_property_read_reg' defined bu=
t not used [-Werror=3Dunused-function]
  111 | static int of_property_read_reg(struct device_node *np, int idx, u6=
4 *addr, u64 *size)
      |            ^~~~~~~~~~~~~~~~~~~~

Introduced by commit

  87b764b15f9a ("of/address: Add of_property_read_reg() helper")

I applied the following fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 11 Apr 2023 16:09:19 +1000
Subject: [PATCH] of/address: fixup for "Add of_property_read_reg() helper"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/of_address.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 95cb6c5c2d67..26a19daf0d09 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -108,7 +108,7 @@ static inline const __be32 *__of_get_address(struct dev=
ice_node *dev, int index,
 	return NULL;
 }
=20
-static int of_property_read_reg(struct device_node *np, int idx, u64 *addr=
, u64 *size)
+static inline int of_property_read_reg(struct device_node *np, int idx, u6=
4 *addr, u64 *size)
 {
 	return -ENOSYS;
 }
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/dmNPemH+cOjP4xKh/n83ZYQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0/EUACgkQAVBC80lX
0GybJggAiEAinVij6F/6AVWzx//+W26hrT7KX0MRslda8JSw851GtzXwt+CQYUyw
txIY3w5J5IOolDPURkjFKb+yvBnDB+dygNr3YnHo17IrPnkdRz/Dp9VttFAHS9CQ
iUc2r/LuIGdFyotzc/ircgzhraxvTF1iAGHIWxcGryuwsP9y27AOiX7rYRWBevKT
WDNphWP4nUNgJvtSwWVJapPDEXqErsS866o8wdU8BBHvsMQ3ZVn/soS2AFh0RBQw
hJVECgwotnkCl4VmqkTzXcQnKot+prZt6fSJBh89xLJdt71oNoy9zNtigt3gpSFH
loFs9eX1hBxU+vrhdUFoIKHqi0P9NA==
=BXqK
-----END PGP SIGNATURE-----

--Sig_/dmNPemH+cOjP4xKh/n83ZYQ--
