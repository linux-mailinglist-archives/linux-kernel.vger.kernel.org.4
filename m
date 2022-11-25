Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EA638206
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKYBK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:10:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71042A2;
        Thu, 24 Nov 2022 17:10:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJGyM70Nxz4x1D;
        Fri, 25 Nov 2022 12:10:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669338652;
        bh=BacT35E2JfZsyBJMyx+bXO6kk1xW5TFq1kyIRhiw+Jo=;
        h=Date:From:To:Cc:Subject:From;
        b=a3NtHUhhFZItgRTQmnOt9HplNvPZlx2WpRN3em1VPpzuuc53RYZFhMIDObUsmyKaj
         eRazzgXD5K5ZC1WcMdkcSyGJfH+8Lcj5oeD2jO1lAQhDrhfsdEUD0l8y10y2YzMjH7
         kOx8dT7SkZysrtHzmSjY6SDnqFN8fRQXDEXiQqnAPCKJADpRsuj3oANiXs5nA+sbUo
         8YHm9jic8jpdrgQFHPylzmbNIuBdtHgHwGhjKeYz20SBVW+8vNrydY0heAcc+MLXVp
         YvA7H4wCAsHf2amrTdK2uXyTwxq2PwGVWRWZcgw/4Vzv5O9bakkIkLoiA9g8YRFCKi
         Oh+mO2vSMlfrg==
Date:   Fri, 25 Nov 2022 12:10:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20221125121051.311beecd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iDtB_YEVPjtg4sQ4=W.6Izs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDtB_YEVPjtg4sQ4=W.6Izs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-hotfixes tree, today's linux-next build (arm
allmodconfig) failed like this:

mm/vmscan.c:4090:9: error: implicit declaration of function =E2=80=98pmd_yo=
ung=E2=80=99; did you mean =E2=80=98pte_young=E2=80=99? [-Werror=3Dimplicit=
-function-declaration]

Caused by commit

  3f85e711d5af ("mm: introduce arch_has_hw_nonleaf_pmd_young()")

This error was found by the kernel.ci bot and so is still int today's
tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/iDtB_YEVPjtg4sQ4=W.6Izs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAFhsACgkQAVBC80lX
0GyNKgf/fyVh61nCQ5O8cKikPzo1ug0ZwY2v6Bkkbi0bVwCC6lIynxcSm0UZqhDx
TXgq5sTqd2b1YwRquKMkvWkfvbliRqsFS9nQxMp9XaFYTv3fpZGiEAnPuJntJVin
xu4aPFOyEw5dL4cHUX6yY5DtVKwN8XaeF1ZnOZTE4Sg+L0dBF5ddsgtw2yeW6/u7
B+sHQYVziT8b2BMVMhJ6LA8/W0Sonv89xVLSO7q3Y3iZ6RoNfJ86YYKPy2trj7kv
XgBMCbSQW3Hztk3/Q8Rmh1Uyza1YZApBxrjHler1rTBMHkteHltfReUkH3LrZqrZ
UfqL4APNF9HL3DaFkOWmYLvN5pj+TQ==
=WqRU
-----END PGP SIGNATURE-----

--Sig_/iDtB_YEVPjtg4sQ4=W.6Izs--
