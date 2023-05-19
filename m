Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80088708CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjESAGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:06:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF010C9;
        Thu, 18 May 2023 17:06:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMnDy1WNgz4x47;
        Fri, 19 May 2023 10:06:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684454771;
        bh=JiBDtPCRXHkVessovV0aGuRxTIbh8SExP1OLz/sR2t8=;
        h=Date:From:To:Cc:Subject:From;
        b=g7SJnREGs0jH3Y2xQht0mVwYhy1SdYn138OaUVyTFqC3kPr71GOHczVplEtWpS4dx
         p5Iht+O6Ifq+g3c/fCpI0rr+HC0JcOU5O1xCPuLjmr89sJtp9wRt9iqpu9ebWfJbUi
         CdZEShDvp1p9PqU09dJnwA34fIdRWFimCaGVkEfpg4YebK8jipLYsuW9HM/klISN/Q
         /TvXe8aMLhwXJeDrDvQS17EoEEm8dtexUiR4talTngM6ULmRQJgwclSYUewjpamusv
         fobt8xTfKu+c8iok6VmnOO4VZZRpKlnZSGAL8wlGeSPwfhZkCany0Oqa8VG9Jy4kLD
         vxnlZTDvgBdeg==
Date:   Fri, 19 May 2023 10:06:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20230519100608.7e836126@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c262WyEoSEonV2KE3p0wkvu";
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

--Sig_/c262WyEoSEonV2KE3p0wkvu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c: In function 'amdgpu_ctx_init':
drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:348:26: error: 'fpriv' undeclared (=
first use in this function)
  348 |         ctx->ctx_mgr =3D &(fpriv->ctx_mgr);
      |                          ^~~~~

Caused by commit

  2458393a4e98 ("drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure")

I have used the amdgpu tree from next-20230518 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/c262WyEoSEonV2KE3p0wkvu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRmvXAACgkQAVBC80lX
0GzFYwf7ByLWzDf6IlJ6fQB7OaBwE2EBv08ctssID0CcIgUjrREIr3LWTAJYzOcv
T0FAH5+yl/3C9kdC1kujLk9cVDLLYdTsNxFBdLDu/vqdbuj60sQbSumcsvvWK7zg
pNsKIOIc/CbtIicJ5guLrz49sqKQIdjp+CWv/4AlBzKUEHq2C7J9PY4cNVVOa8Iz
BAfVEGftfrYsAxmtnUCLqgCdILOVnqaFfF16iXXwsiVXyuNi75yZCozlbGHryD8B
k0xkcOWWwaHpqG+8vs7a0RI+GLBzEPia0BUOrUwiiPWeGVK4VRI7b03kEinR+eFs
15PbN2rS3kPOa0UK2HatttUarmW+Pw==
=uY02
-----END PGP SIGNATURE-----

--Sig_/c262WyEoSEonV2KE3p0wkvu--
