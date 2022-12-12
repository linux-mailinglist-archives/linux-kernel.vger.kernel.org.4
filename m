Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E764AA47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiLLWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiLLWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:31:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A61AF24;
        Mon, 12 Dec 2022 14:30:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWGYW4rFNz4xN1;
        Tue, 13 Dec 2022 09:30:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670884256;
        bh=wol/ZquUNqtT5PILJNikpvyQiO2elLsIVTw0EVhiXFU=;
        h=Date:From:To:Cc:Subject:From;
        b=NJbZrKXH7Ug6Si6TrZWG9GZUB9Dn0bFOR9CpfMlD2KVR51974BbpfmiMYkz/oWxgD
         NKLc0ztwU8+WyxVWVMwTYCWHNJ4w8WJzlHCgaA+ujieQ2+/tzLACw0qBgeLH95qdpH
         +NcPizDbuUYnV57O6Lf610kFDP9HxBCAace5xZtPW2ofBNfzBCUg9afuEucnjgB1GB
         j4qFqQgOrjyaexC9YPSCuRFb0u7ClfnIIpiva87MCbLCPV2GI7FSR4eH2Hp9bPqY2U
         qzL3KNGu7NSf5LUXkgKi0UN17BrGpF70v1maU23wjxTZVMqH/AGQYXNfg1w3hHXlBW
         lwMNyhQWrMHwA==
Date:   Tue, 13 Dec 2022 09:30:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20221213093054.5211da74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hTrzt8noqpeQkk73HvdJVDq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hTrzt8noqpeQkk73HvdJVDq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-hotfixes tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/ksm.c: In function 'ksm_might_need_to_copy':
mm/ksm.c:2605:21: error: implicit declaration of function 'copy_mc_user_hig=
hpage'; did you mean 'copy_user_highpage'? [-Werror=3Dimplicit-function-dec=
laration]
 2605 |                 if (copy_mc_user_highpage(new_page, page, address, =
vma)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~
      |                     copy_user_highpage

Caused by commit

  b7edf4b1cdb1 ("mm: hwpoison: support recovery from ksm_might_need_to_copy=
()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hTrzt8noqpeQkk73HvdJVDq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXq54ACgkQAVBC80lX
0GwTRgf+NcfRNGZ/W9oWEtHBVM9dsvDd8ecNLaMVgoxMGLqRyIl+oq3fRCUNkhTh
40oeVj3N76sOGzvytqPN01vVcJxrWzRkFfpBc5m/yC73YITp+hxmZ/mdPj/nGkvF
1dRD3/erJZMYOSJ7WhNDATZ/jNSIsYhjxxIT7gvvz2D50XtpH1I6GbqCV7rHHPdJ
9jqS/UU7Dd4ily77uG/uRgcKphh1CBeSlzfvojpDWL62piTDzWYr8qfehGvRU5yg
gBG11dcqaO8UwXmEDxiwi8eqsZK12rQjO9LMczEU9/pQJdQzrWaDoBYP49geH1So
pEziYEHRflWDdNBevmZ/ABuGfhH5yA==
=Wcyq
-----END PGP SIGNATURE-----

--Sig_/hTrzt8noqpeQkk73HvdJVDq--
