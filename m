Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA86C43C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCVHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:00:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F452929;
        Wed, 22 Mar 2023 00:00:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhK9t0r4Gz4xD8;
        Wed, 22 Mar 2023 18:00:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679468434;
        bh=9wIDFC5mj5dFd7HVU1rFGWEJ11xMt9XUE4oryouyBlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b0Phw1Tr5SVQW5lhEZ/poUDb6TR8DhWWu9Q0FAe4LMpjEzSbTaPFg2YcWytBRohnD
         2h7fmLYVt1ssDeVYQsJ2G32F9yrX8s18NUD9bucMZ0c84z/3VQWLutNya7dNgJJfFu
         Iw1fGpPzyXlmDP3rhLYRrR6IBDLv56LRg6YkQk/6gezW/GisXdHz69EBKjOWlXJDV7
         onxE2vGzYRP9b++BhxZj9ycRQBEP8kNCglrehPOFnIJVIXb+MfKis16w8kfVKBu+ju
         gRjOU90FCU9MtJczZmwj8HzIJw8Bv4tt210xxa1o8by6N3S/3yejqMzGQ0lIgyHOaz
         NgybUyyHgMYPA==
Date:   Wed, 22 Mar 2023 18:00:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] of: fix htmldocs build warnings
Message-ID: <20230322180032.1badd132@canb.auug.org.au>
In-Reply-To: <20230310113258.463f836c@canb.auug.org.au>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
        <20230310113258.463f836c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EfiTauXl2ffdxpomwQKq3At";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EfiTauXl2ffdxpomwQKq3At
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fix these htmldoc build warnings:

include/linux/of.h:115: warning: cannot understand function prototype: 'con=
st struct kobj_type of_node_ktype; '
include/linux/of.h:118: warning: Excess function parameter 'phandle_name' d=
escription in 'of_node_init'

Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creat=
ion functions")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/of.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Replaces "[PATCH] of: fix htmldocs build warning" and additionally
fixes the new warning about phandle that Randy reported.

diff --git a/include/linux/of.h b/include/linux/of.h
index 9b7a99499ef3..d55dab9ad728 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -100,10 +100,12 @@ struct of_reconfig_data {
 	struct property		*old_prop;
 };
=20
+extern const struct kobj_type of_node_ktype;
+extern const struct fwnode_operations of_fwnode_ops;
+
 /**
  * of_node_init - initialize a devicetree node
  * @node: Pointer to device node that has been created by kzalloc()
- * @phandle_name: Name of property holding a phandle value
  *
  * On return the device_node refcount is set to one.  Use of_node_put()
  * on @node when done to free the memory allocated for it.  If the node
@@ -111,9 +113,6 @@ struct of_reconfig_data {
  * whether to free the memory will be done by node->release(), which is
  * of_node_release().
  */
-/* initialize a node */
-extern const struct kobj_type of_node_ktype;
-extern const struct fwnode_operations of_fwnode_ops;
 static inline void of_node_init(struct device_node *node)
 {
 #if defined(CONFIG_OF_KOBJ)
--=20
2.39.2

--Sig_/EfiTauXl2ffdxpomwQKq3At
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQap5EACgkQAVBC80lX
0Gx+1gf+IZNls0/oAcXJ+Ahb8GALYHJrUBkIL20c2/6r7a6ihlwuGxHPRKtPkCYm
g4dLdpPZjQdD14f2PjtBaDvulRPdWHycjKEo1K5EUKlzyYIX1Qk/5KZKN+pNASWF
40DbSTFPTY7UIlAi78ch42NBodT+UIdakZLGRwjBVg+rFCqLC1ILOIoYYYjTHfQQ
MiG5i/qCnM2LLshyCtFjOrpzW3PwKB+ZSKxKas/eJ/obbRSnotOn0vZfoiin1Jtn
h24YIbaAUhNrtgbUMVenVs+4F7X01Xg7uzvwZ5o3c+kmfBlq5KeVs2uPM8NkrfvH
nJznyZiv0f1Ac0FCiTCVZh5afQlbPw==
=ieaD
-----END PGP SIGNATURE-----

--Sig_/EfiTauXl2ffdxpomwQKq3At--
