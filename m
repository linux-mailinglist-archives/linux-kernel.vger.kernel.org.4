Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79A7273E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjFHA5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 20:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjFHA5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 20:57:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F247E46;
        Wed,  7 Jun 2023 17:57:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qc5Qh5npHz4x2c;
        Thu,  8 Jun 2023 10:57:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686185838;
        bh=xe7ysLQzAS2QF51u4lAR78h8WexS4TYt40aAzSqK7yw=;
        h=Date:From:To:Cc:Subject:From;
        b=Fm3Dqj1YYSWEQoh6CGsgRIWEeIhwrH8AhxglUQxh400NIed1o6hS87297eq3nJ/CO
         0MKQwdB8KFf4Ef2xBgwCzcAdUY2ACqf1b3eEhxCfVyVZMzSojrc9u66HzleCRvpHuy
         NRrSMDpEITngmuTwBioavDk6hEORZMwP9GvSclWVYuQAycaXA457wilS4tbZtxX0kj
         8NvuPgSgvGtYHX9w1Fpt4LKkRFvleyzR4JplPw7CQTW2dlFiWHRad5orw+igossVXk
         yna8JC6SHhnbQ1iATTsed8mAVthEAFGfZqYazIDyOYGCv8s9VN8IzNk7m3Yu/O/KDS
         F1UwTzPFL3UuQ==
Date:   Thu, 8 Jun 2023 10:57:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5?= =?UTF-8?B?xYRza2k=?= 
        <kw@linux.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Pastore <mike@oobak.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: linux-next: manual merge of the sound tree with the pci tree
Message-ID: <20230608105714.39ee3c3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OwbXucjJHA.O9VuskHyjnaC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OwbXucjJHA.O9VuskHyjnaC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound tree got a conflict in:

  include/linux/pci_ids.h

between commit:

  0ac448e0d29d ("PCI: Delay after FLR of Solidigm P44 Pro NVMe")

from the pci tree and commit:

  28bd137a3c8e ("ALSA: hda: Add Loongson LS7A HD-Audio support")

from the sound tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/pci_ids.h
index 0f9cdc6195a1,c0c4ca8e2851..000000000000
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@@ -158,8 -158,9 +158,11 @@@
 =20
  #define PCI_VENDOR_ID_LOONGSON		0x0014
 =20
+ #define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
+ #define PCI_DEVICE_ID_LOONGSON_HDMI     0x7a37
+=20
 +#define PCI_VENDOR_ID_SOLIDIGM		0x025e
 +
  #define PCI_VENDOR_ID_TTTECH		0x0357
  #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 =20

--Sig_/OwbXucjJHA.O9VuskHyjnaC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSBJ2oACgkQAVBC80lX
0GyFuQf/VelzPzlvp3VoGLMEUltXyT5Tn91kbcCnsvz75yzgIforqb8gMKzRM6HB
4Rp/SGzfIIvj75tUFcbE9iydTjnh8SzHBzPI3Y3kXJqQ6uwaP3XvtvUaUtWuIQyW
qSodvACFhxtoOLiTctubg1bUCFVeh8gepSHY2zkn65Wjm1XNTW2IxU0wkFaQW821
uelGoTPEXmvtJ4MzXIFeNbVd/wropOmY1gPV5IpanwV2FRQp5yeY344V9EWOipV0
37rIvOG6Yh2j/mlQyKYRjxxLPY7Vun5zz7RMBRTKtmFSdtrXNu1F0XqwqG9eiN1R
pvqNLnFNyjb3uh8Rieg2wfty7NV9Hw==
=PoKS
-----END PGP SIGNATURE-----

--Sig_/OwbXucjJHA.O9VuskHyjnaC--
