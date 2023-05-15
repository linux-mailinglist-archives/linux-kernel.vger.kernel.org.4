Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8D704164
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjEOXZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbjEOXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:25:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1483CF;
        Mon, 15 May 2023 16:25:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKwTX1zt1z4x3x;
        Tue, 16 May 2023 09:25:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684193136;
        bh=GsCgR2m5huJ/f+99VjxaWrIbcwGYO6YMagHmkWPW2AU=;
        h=Date:From:To:Cc:Subject:From;
        b=iaQo7OHskclZixZb4veZaEEXZi5x5wB/IIOXCqmvQHK2Opwem6cFkpOi18aZKiaG4
         uKPxp1FBI18XS/kRMJ9oRHYbSMyjQUmBFX3QEgGy/FETlfUI29s7VQGIisq9hbuCYF
         eRK6MaZiss4IUidgwSQ+0c+6J5EGhNSeQ6BP3Iav7bErT+pR+Lemg0JsTNAGZVm8yZ
         T3nC7DCdYDCQyzVbDkYC4emfgRdllWmwhtXMF5vyLnim0TFDSNrjyde5nCrp6Porg4
         oCOaqtYyxIkmjhmyQwAEqHopZxZDN+TKTkahzv0CCHSKhf3yq9U2XgtuFUFA8qZVZK
         BulTgwlZsmyyg==
Date:   Tue, 16 May 2023 09:25:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230516092533.68c99314@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Vw6skYlIUOGlA4mL8FWXz5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Vw6skYlIUOGlA4mL8FWXz5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

mm/memory.c: In function '__access_remote_vm':
mm/memory.c:5608:29: warning: unused variable 'ret' [-Wunused-variable]
 5608 |                         int ret =3D 0;
      |                             ^~~

Introduced by commit

  eca1a00155df ("mm/gup: remove vmas parameter from get_user_pages_remote()=
")

"ret" is only used if CONFIG_HAVE_IOREMAP_PROT is set.

--=20
Cheers,
Stephen Rothwell

--Sig_//Vw6skYlIUOGlA4mL8FWXz5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRiv20ACgkQAVBC80lX
0Gw+Igf+PFUyrhxePZN0bRRAGlfxf4XcryJNi1hlt6NdP9ZsA1G4Cd6aQ8ZSmec+
nHJJ32g0QWOP5V/4t5bFV1CzI6XgnprHRwoVVpPbj0zc3J9xOu84Bpv1HW5cWW6g
nkvY79tkCMin7PWKIV6hTMCw/PgOd/aBxWgcEnADXAeE0VBsIb6D6sz+mFcz2RCU
TmdRlzeP25pldyhYvyYvATvDRKVUAbpDcbl4GiLOEMl6BVW/DjhoHgVpMXlERrCm
6ia/zA3tWCkNDH/vJLVOV76oFv8yzprmB/EuiN/FrlBLRSaxuEFYSmEnfoe5Ts/o
Mj/NkHZbxjXwR752zeK4HwDTptFOCw==
=3NBm
-----END PGP SIGNATURE-----

--Sig_//Vw6skYlIUOGlA4mL8FWXz5--
