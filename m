Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1666B465
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 23:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAOWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 17:53:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2211E9C3;
        Sun, 15 Jan 2023 14:53:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nw9Rp60VLz4xHV;
        Mon, 16 Jan 2023 09:53:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673823207;
        bh=1BZ7OSJ6czVjmXuE61pC0EjxTqxSDvYVEQrzKHpEOX4=;
        h=Date:From:To:Cc:Subject:From;
        b=Dh37mnrKvtEdYxRWfP+MUTI0gVr0IphnFvjYmouUEY365RiSOY6Q3bV+0V5m69+ux
         at0/FK984AMPbHGlk2KaPOpGs7qtGUzKE3Uh4HFmrX21W5BpTvDyr/adNR7pS4W36J
         Wd0mToAxV41I7jcdYYCV4o72VNdQuyAgGWgx+iU9c0duA/nr2kiYBTDUp0OnEysceP
         j96P2BIlPDg1pfdWV0mbOJInHFvqm4bCIWvkgVFEbwDjAqFFpDTmjTpA5RBs/aG490
         yuQGmt81G4vCrPyYSTrkIVsNHoMXYVEoD43tu1xLImtLOmGcwtUjwzqUg55qLwrBzL
         QYSEu5c6cuRcg==
Date:   Mon, 16 Jan 2023 09:53:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20230116095325.01f715ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t=n05yctqsAx/D.BHcayqvQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t=n05yctqsAx/D.BHcayqvQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/pci/switch/switchtec.c: In function 'switchtec_dev_read':
drivers/pci/switch/switchtec.c:623:1: error: label 'out' defined but not us=
ed [-Werror=3Dunused-label]
  623 | out:
      | ^~~

Caused by commit

  fbc855bce49e ("PCI: switchtec: Return -EFAULT for copy_to_user() errors")

I have used the pci tree from next-20230113 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/t=n05yctqsAx/D.BHcayqvQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEg+UACgkQAVBC80lX
0Gz14Af9HlGhTewYkXkM5d0qmjtnXU7gdjgtwvZBc229QPDKaISvQ8ZduGg89H6E
a3ywisEL9oQ/7vIocaAAqvj+jm9CN4b1a7dcHD7JvbjPU4112q0CYxTi8Z0ABzE3
ymZtR76uBeliagwdG7ostfEvghOPgGRjncAczftvEMvmHxmg6CqlNukAMVC9PSl3
6eEChATviclASjpK1f5McU/AH/bt1doli9LTw8Qm5C7zFZSz/5ayj312QScVXuIz
TMbwuCS3Ibb0INiEMbGJtimFHdNGaNhRnJxGAlSVMMDRApv8AKROja6oCX9dp4cM
WmZyE9ttfXA4+hJFDyqO7WGul+uopQ==
=iwgu
-----END PGP SIGNATURE-----

--Sig_/t=n05yctqsAx/D.BHcayqvQ--
