Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A13609860
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJXC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXC57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:57:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A3B6DFA6;
        Sun, 23 Oct 2022 19:57:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mwfrf2cgZz4xGS;
        Mon, 24 Oct 2022 13:57:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666580275;
        bh=enAY+8KWGaCBQae7F4+ufwn034dy5m1upXLo9GLxOdM=;
        h=Date:From:To:Cc:Subject:From;
        b=DAG+LYN9a3Y6Hnqo+j9zitccP73vtwJpYWbuUE5pjqufb8WGgmrY4HbwxXBK2mZZB
         GRD7MSBuTmJbB2bpJlErMR9OtEksr/cst3YBU3LUsWZ0OFcXrUxiay85SE7tLXaPWR
         c78vkbCIzw3HU0Hy+4CJG94YyR6IvWl32pV+gAqh42gNgDHkfI8WTUyefiq6cY1oGy
         MmJVXfxq6G+83Dtbz+6KBSePumrNC8jucyGvWM6A9pbQ4lllDX565PPfFCjDZa3vcm
         lqMNKRCS13f6qSRknTIuQTd+RUyC4Ap5gVmKFY+w7USSVBjCVVwjC+WGw10ee00MwD
         zjPAtiJA0HtpA==
Date:   Mon, 24 Oct 2022 13:57:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the char-misc.current
 tree
Message-ID: <20221024135752.2b83af97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pUzBhSdoEQohSEoKVBODPYp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pUzBhSdoEQohSEoKVBODPYp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc.current tree, today's linux-next build
(arm64 defconfig) produced these warnings:

drivers/hwtracing/coresight/coresight-cti-core.c: In functio
n 'cti_enable_hw':
drivers/hwtracing/coresight/coresight-cti-core.c:93:24: warning: unused var=
iable 'dev' [-Wunused-variable]
   93 |         struct device *dev =3D &drvdata->csdev->dev;
      |                        ^~~
drivers/hwtracing/coresight/coresight-cti-core.c: In function 'cti_disable_=
hw':
drivers/hwtracing/coresight/coresight-cti-core.c:154:24: warning: unused va=
riable 'dev' [-Wunused-variable]
  154 |         struct device *dev =3D &drvdata->csdev->dev;
      |                        ^~~

Introduced by commit

  665c157e0204 ("coresight: cti: Fix hang in cti_disable_hw()")

--=20
Cheers,
Stephen Rothwell

--Sig_/pUzBhSdoEQohSEoKVBODPYp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNV/zAACgkQAVBC80lX
0GztDAgAi4ubL4NYVtVa8UafcZZuJEWhJv5icmaejcKZ5a5hRXv+iCQ0jVBPgprL
L7SE3dkeNVJXCY5YBfX/D1EsC0QMWEFmUYSJFTlmviweQr2pO/Je8cOMNe4T8MnH
+2U4ia8v9jlchTf7wsuBVwB3eJp2lv6X2VYsyCNYMAb0YzTglK7PqCB5i62A7Mnk
xpvVT1BP8FQgi/JBXSBZFHnnVDVjcks+RD6tbcajWinXjbkfBdnk5qtmL8oNoWkM
OWAFhQhcH0X2ZOjcGJNqXNeLgm1AXSrJMfQt4CpNSrkUd2z0pds382uAVC4sfQv4
UotumpZu5NHnn5rBQYoklDibs17S2w==
=8LVo
-----END PGP SIGNATURE-----

--Sig_/pUzBhSdoEQohSEoKVBODPYp--
