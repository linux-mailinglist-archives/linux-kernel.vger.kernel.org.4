Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7C6C9AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC0FCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:02:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F113A8C;
        Sun, 26 Mar 2023 22:02:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlLKP1vrlz4xDk;
        Mon, 27 Mar 2023 16:02:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679893354;
        bh=gxoGW8cn7vBlEWmFx0Ppf1kiasx+hNOehOeHL3jepAs=;
        h=Date:From:To:Cc:Subject:From;
        b=rIATjPQUN3CzO9oHem+hSL7cnUe1ixq5PasAl9+BE4X54ULrwZa4Uei0HIokcaTV1
         gPOEMRwccz+v3mVLBMHyfkDwccGQ3pAJwy1FH+Z6FLMBLXRFUZBep787JkuLgGHwzS
         C7QfO32Os60ViRhofQNRiR2PX4L3qx1DXLOL7/3/AFHvHkvibt9g/94JCCTM6Y0zoR
         AtBwKFSpPsEhhlKuKnYcdPz8TelXlls5RXzBxzp7I//1+TB96FfDoAi10r0/X2jWT6
         a2vKIqtYkOI5Aao/1oeoVewNNs9lgsiTHssc3Sf4N3qDItoJzKTnWgdBFOtXB577fC
         0IbRBxn18FKag==
Date:   Mon, 27 Mar 2023 16:02:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20230327160232.6119b93f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E/2j.JLfKbNNGp5Ql=8YJbc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E/2j.JLfKbNNGp5Ql=8YJbc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (s390 allmodconfig)
failed like this:

drivers/usb/host/xhci-pci.c:91:13: error: 'xhci_msix_sync_irqs' defined but=
 not used [-Werror=3Dunused-function]

(reported here: http://kisskb.ellerman.id.au/kisskb/buildresult/14902506/)

Caused by commit

  9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")

The function is only called if CONFIG_PM is set, but defined
unconditionally.

--=20
Cheers,
Stephen Rothwell

--Sig_/E/2j.JLfKbNNGp5Ql=8YJbc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQhI2gACgkQAVBC80lX
0Gwa1Qf8DBNK6PMVd9sPAn0aIWVA4jHwLeVsWEalo4SufKwWY2zzhi7QLopSyKt4
X/mjweEYuw4XMfxeW2tK2KdWucXv5ja9C3BQlXVGsTlcrVlJdrbH2pMZRWHCwuUE
uvzX9Sg20d1opl49NuT8fupKC6/mz/GCMZlmMyIg6nJbvaMp9emykOJeZpjdg74k
fk+ZHwtaGvR4b2G9Qstf3lD2tDPcoyAyUzjXranqHXKQK7oDT7wDO4LZ8gclErK7
kpvPTSLnwpA6AGVaoU6LiXU4uid+hVOFsUSgjCh/xmhDYUD3NbqxCcvHGR0eO8nX
095NdUOxeHUcQviISmWYVRYL/NE/jw==
=vdz+
-----END PGP SIGNATURE-----

--Sig_/E/2j.JLfKbNNGp5Ql=8YJbc--
