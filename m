Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B56B32CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCJAdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJAdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:33:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095016AFF;
        Thu,  9 Mar 2023 16:33:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXn8D2J3Hz4x5Y;
        Fri, 10 Mar 2023 11:33:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678408380;
        bh=oJET0LTOVik+TYVQNyeayyXbuIXlTeWUQHE5QL6qUjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IMqHxDqqsO0wgWRV8/WKFV/6EpthoY8IswahkwHW/aXFMEZu59ZuvjFf255jfFBOC
         bTcY9xLt5Ugv3o3O14IYeS7W1hcZX3K9LWyUc4mtcJ9cT2B3Te9eY1WDSr9An8r7k5
         q/9n4yuHDUQ/6knx/XnxFWEqqAReTHvbEQgpifveuGPvaqYF4zZxfDcBlfcBMMmS5p
         b/3kbP5ryEHsfiINw6DmQ1o0L1GvI/YtF+WanelgSpeSIfJgMa8HFcUQ9Pqs99KZ1J
         4Q63YMzqFwl8Soes8+FimpAzvPUunWanuDi+LF2Pg23yRVmIkOXpuv1jTRZF9vaqaM
         ql5t6ZVA7LFiA==
Date:   Fri, 10 Mar 2023 11:32:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] of: fix htmldocs build warning
Message-ID: <20230310113258.463f836c@canb.auug.org.au>
In-Reply-To: <20230220163638.04e9d0c4@canb.auug.org.au>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9Vh6Ti9wdjv9tp0nCE=qKtG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Vh6Ti9wdjv9tp0nCE=qKtG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Fix this htmldoc build warning:

include/linux/of.h:115: warning: cannot understand function prototype: 'con=
st struct kobj_type of_node_ktype; '

Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creat=
ion functions")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/of.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

This is actually untested, but seems pretty straight forward.

diff --git a/include/linux/of.h b/include/linux/of.h
index 0af611307db2..814d33f3835a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -100,6 +100,9 @@ struct of_reconfig_data {
 	struct property		*old_prop;
 };
=20
+extern const struct kobj_type of_node_ktype;
+extern const struct fwnode_operations of_fwnode_ops;
+
 /**
  * of_node_init - initialize a devicetree node
  * @node: Pointer to device node that has been created by kzalloc()
@@ -111,9 +114,6 @@ struct of_reconfig_data {
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

--Sig_/9Vh6Ti9wdjv9tp0nCE=qKtG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQKersACgkQAVBC80lX
0GwRVAgAkf9jI3+ORKtJgEzRRiJM7xdnVNDePgd1A7N9W3sg/zc2UwihXJea+i4Y
9i/cIccu1JqqICdzz30YNEREBIi7AMUhprO81fiExP8WLroPKDrhkpUtKvfMe/1y
u8tgqjlkzQG4RU0YVF5iz4JfU7jmDhdJLT/GTVJ6hvByCzdAd/DugSg4zOzZALr9
HJABzXkF5ZpeaqnPliSgMSLTK0aD/0RSNYXfKSkOQquycZdwOe5gDqlDc+iACtCP
Uoz+GF6W1gu6jyektIdtzZjuHlCoPyWQ2WYMILnyugVDfIxQmbzwfQafgsi3YfOK
vsz0AxZu0Xh24csuyLlUMOrQvl3Q7Q==
=QgBK
-----END PGP SIGNATURE-----

--Sig_/9Vh6Ti9wdjv9tp0nCE=qKtG--
