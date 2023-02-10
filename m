Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57469165B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBJBs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBJBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:48:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9933123C64;
        Thu,  9 Feb 2023 17:48:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCc835KY2z4xwt;
        Fri, 10 Feb 2023 12:48:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675993700;
        bh=+Ki0OhxYJ1DRe4QMDfUR0T5RtynvggvF3I75+9sYZf4=;
        h=Date:From:To:Cc:Subject:From;
        b=pd/+oLXWZfa113LqznDlfpBM5JaXIPnvQVndt9xrcggQYz2gAsOdYMDYF9rtfl15u
         +GqnlgtE3JtIXA5lhDApyF6IKBIZWxe/EOmY1BAmH/ktPlAFQ9Tb5tu7ESzLAsNZIe
         FHLRm0nfXGKxRmCkZtEMgJdDlGVWvxg2xXlwqtU37CqnJJvZgDALcI/kUenICvJfqu
         oGRg7CvKKllcNqwFXDBBnm/AgeJpToLfHo4xHQmjfEmFJcGbtLr/YwzojzYCgz1w9F
         pVIdZCkn4jO8kitKNR9CTKVro9v3p86gl6+LdlAfoXIMAhq7GP8tBNND/rLY1n8pZB
         yYTJlwZRjhIAw==
Date:   Fri, 10 Feb 2023 12:48:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: linux-next: manual merge of the driver-core tree with the rcu tree
Message-ID: <20230210124818.2caaa77f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ei2wm62Rb8ZnOOQxshVt5sn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ei2wm62Rb8ZnOOQxshVt5sn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/base/core.c

between commit:

  dc7c31b07ade ("drivers/base: Remove CONFIG_SRCU")

from the rcu tree and commit:

  3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consum=
er links")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/base/core.c
index bb36aca8d1b7,2712a1a1e959..000000000000
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@@ -181,6 -202,52 +202,51 @@@ void fw_devlink_purge_absent_suppliers(
  }
  EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
 =20
+ /**
+  * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode=
_handle
+  * @from: move consumers away from this fwnode
+  * @to: move consumers to this fwnode
+  *
+  * Move all consumer links from @from fwnode to @to fwnode.
+  */
+ static void __fwnode_links_move_consumers(struct fwnode_handle *from,
+ 					  struct fwnode_handle *to)
+ {
+ 	struct fwnode_link *link, *tmp;
+=20
+ 	list_for_each_entry_safe(link, tmp, &from->consumers, s_hook) {
+ 		__fwnode_link_add(link->consumer, to, link->flags);
+ 		__fwnode_link_del(link);
+ 	}
+ }
+=20
+ /**
+  * __fw_devlink_pickup_dangling_consumers - Pick up dangling consumers
+  * @fwnode: fwnode from which to pick up dangling consumers
+  * @new_sup: fwnode of new supplier
+  *
+  * If the @fwnode has a corresponding struct device and the device suppor=
ts
+  * probing (that is, added to a bus), then we want to let fw_devlink crea=
te
+  * MANAGED device links to this device, so leave @fwnode and its descenda=
nt's
+  * fwnode links alone.
+  *
+  * Otherwise, move its consumers to the new supplier @new_sup.
+  */
+ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *=
fwnode,
+ 						   struct fwnode_handle *new_sup)
+ {
+ 	struct fwnode_handle *child;
+=20
+ 	if (fwnode->dev && fwnode->dev->bus)
+ 		return;
+=20
+ 	fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
+ 	__fwnode_links_move_consumers(fwnode, new_sup);
+=20
+ 	fwnode_for_each_available_child_node(fwnode, child)
+ 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
+ }
+=20
 -#ifdef CONFIG_SRCU
  static DEFINE_MUTEX(device_links_lock);
  DEFINE_STATIC_SRCU(device_links_srcu);
 =20

--Sig_/ei2wm62Rb8ZnOOQxshVt5sn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPlomIACgkQAVBC80lX
0Gw1/Af+LUQV4k2sY/6v/aA/NfcIdoWP7c7RkYRlzP2MdYhO1eYrjE6sUknRJJdm
mioQWxQHTzAu0I4SFdkC4NqG9RlMIZ8+hrW/T4OuY4+Wz1EO37t21FxfACqT2bL7
c3TjitA7gHByE6SVZ9xVv6ZGLOQs45sqJ1LAqFxsGfp2q9GMPbiig1eY/4EXdhzp
doI/X5vrcZGeJQqufB3mmyVAlZMZiMkml7YFFN+vaveDtA7rz8EoChfezscvryAs
hUo+P/7rdX93c6+LiqqNreO8MvPUZtOz9pRAQHDgsP7Xom+/h/WTP/T6zNYCu1Gr
sj/u7GYPi7A7zM9vqFs46Nam1dlF1Q==
=kEl2
-----END PGP SIGNATURE-----

--Sig_/ei2wm62Rb8ZnOOQxshVt5sn--
