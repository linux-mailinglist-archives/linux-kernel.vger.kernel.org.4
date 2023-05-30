Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF690715482
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjE3EcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjE3EcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:32:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162BE4;
        Mon, 29 May 2023 21:32:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVfcy0Q97z4x46;
        Tue, 30 May 2023 14:32:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685421138;
        bh=U8n9Hde3DsbVeXiazBuQ1xk7QSZyvg9RTkdEpTMUxzc=;
        h=Date:From:To:Cc:Subject:From;
        b=KhxG2/lu2ZYmaTaJApux+GzhYtZ4KdSpq/UwExYHeG43xweeYGftLEhUfKJjMKkJp
         T+gC8iydc+wqBmxtlb/ikNIAtD7FWtlR5zVXwkUmRbCLWbb+Hvk4GO2GujXPzqfn7i
         RL8gZaO/VrcJ6eeGj1mkHPaW2beTuU9xXfJq+uVsRuvT7kGWNSVqGWbfU2DfHbFKGl
         0/LQDsGWXBT5ks75B5tbRPG67YKzDaWxHxWphSlbbsQOFfDW6cjAH3uoimts6+YStB
         b4a7wKbuoqzVUYMWve9JXyv0ILM3wfeCLJajqFTaMO3oRebXYKE3Jq1SIWfQKRJLt/
         fSzLnLskVs+gQ==
Date:   Tue, 30 May 2023 14:32:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: linux-next: manual merge of the efi tree with the efi-fixes tree
Message-ID: <20230530143217.49ae8cbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zta=SjlqHVMyuVoNmM/m3i1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zta=SjlqHVMyuVoNmM/m3i1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  include/linux/efi.h

between commit:

  fd936fd8ac10 ("efi: fix missing prototype warnings")

from the efi-fixes tree and commit:

  5b6e3aa08c62 ("efi: expose efivar generic ops register function")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/efi.h
index 571d1a6e1b74,657f7e203374..000000000000
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@@ -1338,6 -1350,7 +1350,9 @@@ bool efi_config_table_is_usable(const e
  	return xen_efi_config_table_is_usable(guid, table);
  }
 =20
 +umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr,=
 int n);
 +
+ void efivars_generic_ops_register(void);
+ void efivars_generic_ops_unregister(void);
+=20
  #endif /* _LINUX_EFI_H */

--Sig_/Zta=SjlqHVMyuVoNmM/m3i1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1fFEACgkQAVBC80lX
0GxI0Af9FM1vbjoQ0dm4uairsYi5SbcHlOV8+L0sybP1V9Iq6tlyGnrm/xdBpQtq
g4CDShQZo/+TOr+VKRSwkQiq8LeoBbctUiciE/tYHSjKCQVFz2iTIYYCQrnPo5XX
zOHuyLDWOUEISua+DXI/xqHV6TdiMni0yuTZdpBdgyc+4cDo8ineKssRhEeYs7zY
pl8hHZgYI9MtROhTHls7u+zhDTkJtfyq+PR6eXqgUf6wAvq+BgcrkY+PJyNT2xKl
4YlaGGEHKVT4uLcDza9aISVicaL4hcICKzCaavKAGZujMYDTfp9KAIxRtm+0ydrG
lX9jiNaAsKMV37LAjop/icoRar7I3w==
=65db
-----END PGP SIGNATURE-----

--Sig_/Zta=SjlqHVMyuVoNmM/m3i1--
