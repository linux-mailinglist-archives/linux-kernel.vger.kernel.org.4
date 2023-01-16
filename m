Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F066B595
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAPCYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAPCYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:24:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99F6A74;
        Sun, 15 Jan 2023 18:24:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwG745gyjz4xN6;
        Mon, 16 Jan 2023 13:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673835856;
        bh=L6mPNJJiyd9RSshC893NuQ9D87jjJHrPyneYqEQYjLo=;
        h=Date:From:To:Cc:Subject:From;
        b=Q0ObWaXJISPExYXhTO48bOScDW1iRvBLQ/EHxpkCOI9QIEdXuZbNif+BvTSOqqeZZ
         rApLDMlVeZEy9V14o0wqZFZh3fz5RP78M6tCNejjaJkZqgnuxRIXM5UxWWdQ6kZZon
         pCKcqjATJLeMdNvFtk4het/GJ9hrFusOLOUxvwriKT1abeg8gEXvYCYaY0OQEs9IBy
         PNc8nHWNzfgcu6bfPnWTFNWyTdFio+bUT3eCHirs1Z1hsn3zBlDtfOJIy+HvZ31CpC
         fFblxIHxKy9EGXZ90Lt2vx6cXGAHnLYBsgDAzwSLy/bxPfPkS5v5AlSgku1jZh1IcV
         QD5jwxioZZWTw==
Date:   Mon, 16 Jan 2023 13:24:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20230116132415.793bb720@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v=Zc0u4igO0yeAmdQEFQe9n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v=Zc0u4igO0yeAmdQEFQe9n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/scsi/cxlflash/superpipe.c: In function 'read_cap16':
drivers/scsi/cxlflash/superpipe.c:364:65: error: incompatible type for argu=
ment 8 of 'scsi_execute_cmd'
  364 |                                   CMD_BUFSIZE, to, CMD_RETRIES, exe=
c_args);
      |                                                                 ^~~=
~~~~~~
      |                                                                 |
      |                                                                 str=
uct scsi_exec_args
In file included from include/scsi/scsi_cmnd.h:12,
                 from drivers/scsi/cxlflash/superpipe.c:20:
include/scsi/scsi_device.h:471:51: note: expected 'const struct scsi_exec_a=
rgs *' but argument is of type 'struct scsi_exec_args'
  471 |                      const struct scsi_exec_args *args);
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

Caused by commit

  606375f1a869 ("scsi: cxlflash: Convert to scsi_execute_cmd()")

I have used the scsi-mkp tree from next-20230113 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/v=Zc0u4igO0yeAmdQEFQe9n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEtU8ACgkQAVBC80lX
0Gwf+Af9FTWSS2K0pGh9rhL3Hu9vpi7TiHWWEu1m5Ni2+asnbalBGMH6+uk+e3mQ
Y8iTyWu5PUUovtLBVyfZW9cuCzsCmvfE8Oy7l4QSqizMu61m3JE5BM9CEy89gYor
WLDlfRbnv4k29i9XsJJCD7AlmoeahaPM7RNCkX7xvAbK2yey9w8QKGaZLe6UCIyU
UKyclC1bqk88OUvXdZHym6BKBagmcAou/CytWk7uExDWkTjA2QccxluBWnyGbA2Z
AYJZm2KX+EQsSQtyZjRxDe0XGdRPSb1PaKXZ/AHG4+PwK0mHe+wOBoMmZTefqvAx
kts4WB5v/a0zr/ojj5gydhsAsqwpkQ==
=vRck
-----END PGP SIGNATURE-----

--Sig_/v=Zc0u4igO0yeAmdQEFQe9n--
