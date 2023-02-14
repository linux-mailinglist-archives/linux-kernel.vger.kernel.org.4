Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B335E695605
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBNBkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBNBkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:40:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404DE3B1;
        Mon, 13 Feb 2023 17:40:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG3mf6vMBz4x5V;
        Tue, 14 Feb 2023 12:40:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676338803;
        bh=OfyHpT+A6CV+NkQlUE/To3mG25zK15jaeJ4A/ws9JQM=;
        h=Date:From:To:Cc:Subject:From;
        b=hLrQua0UQnPNx/aViwSSgzWX7Z1aSE1U88Pd8hngjQnODJzvQebQcIftMPOMOqb+m
         Mt/kJ9Y5v/jINzHhOhdHXNKtOg7tyZh9EGCIVCxBofIFf1qeGL0gu0eBs1yvBvpNYs
         BS6NOIuZtTOI7xUynBt0G7HjyTO3BttuTPClQaP6RthVp28J0ye1dbiZc6C1Qm15un
         kAmogpoI8x0jgG4RyCQn/R4BVK/4r5dPuIsMuhUQPXB8bwVLZBtICHhpL4j7IUPRWl
         QZxQqfkDP6TeNy8v0VqbuzaLHDQUzgY7xDEocx63OVcKhs0PlqhKEPth47F1L46YVs
         lygkq5XBj46vw==
Date:   Tue, 14 Feb 2023 12:40:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <20230214124001.5f5341b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/92tJ3po7NRsP.0hx=Z5gJ+g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/92tJ3po7NRsP.0hx=Z5gJ+g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  85d81e15862a ("arm64: defconfig: Enable DisplayPort on SC8280XP laptops")

from the qcom tree and commit:

  1f6d59f7f82d ("arm64: defconfig: Enable UCSI support")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 989183c76ae0,7eb5b6df594e..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -936,8 -922,8 +936,9 @@@ CONFIG_USB_SERIAL=3D
  CONFIG_USB_SERIAL_CP210X=3Dm
  CONFIG_USB_SERIAL_FTDI_SIO=3Dm
  CONFIG_USB_SERIAL_OPTION=3Dm
 +CONFIG_USB_QCOM_EUD=3Dm
  CONFIG_USB_HSIC_USB3503=3Dy
+ CONFIG_USB_ONBOARD_HUB=3Dm
  CONFIG_NOP_USB_XCEIV=3Dy
  CONFIG_USB_GADGET=3Dy
  CONFIG_USB_RENESAS_USBHS_UDC=3Dm
@@@ -960,7 -946,8 +961,9 @@@ CONFIG_TYPEC_TCPCI=3D
  CONFIG_TYPEC_FUSB302=3Dm
  CONFIG_TYPEC_TPS6598X=3Dm
  CONFIG_TYPEC_HD3SS3220=3Dm
 +CONFIG_TYPEC_MUX_GPIO_SBU=3Dm
+ CONFIG_TYPEC_UCSI=3Dm
+ CONFIG_UCSI_CCG=3Dm
  CONFIG_MMC=3Dy
  CONFIG_MMC_BLOCK_MINORS=3D32
  CONFIG_MMC_ARMMMCI=3Dy

--Sig_/92tJ3po7NRsP.0hx=Z5gJ+g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPq5nEACgkQAVBC80lX
0GyC+QgAki/yIrxOTEo9Fin9lOlhfjYxvMT+ld+vGwTdUbDE8sVe6thEBlavxSyW
WnJnFUdYGZIoEZM/t6vQu8QiBNIx4CDbvQ92EdlimoxnQc2stLIwm22+A6mTOAfe
8Z2KMMfIiaRyLY1kfppB1CvZr5/nvSShXOnl/pvkeryZTqcoI6DW+kIbtE/18+wi
ZzB+DEkHBhD987FYe6lYE/D/g7zMueHQ9rda8YRMEKnzMHKnFQ/2SrkrEu+0MlQr
j76YHyMka9zkcq+9pWUoO1iPVF695peCKMPx2cJA6yMtaYk2lMPqPDEs8IUJ0Uke
nQcYl3YSi6g1VvwFIoPpaBsU1gksFA==
=xETc
-----END PGP SIGNATURE-----

--Sig_/92tJ3po7NRsP.0hx=Z5gJ+g--
