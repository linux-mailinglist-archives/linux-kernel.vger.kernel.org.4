Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420972719B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFGW0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjFGW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:26:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012B2722
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3FF64AA0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6618BC4339B;
        Wed,  7 Jun 2023 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686176615;
        bh=7WZB//6TJZux+eIfVM5THT4BLYriCbmT8b7UggsWed4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k10EP806TuBF1JLTa/5s0Eogr6K+35AL8jjrWVMVXwMxFCd4ZgaEnV4O1kDnUbEXc
         MHksuOROiiqDhm/CIifxeX3LZ5qYzA7o+7LQ1aAZVbhtpE4qZv60JlHxXtKtgaGkUY
         tzZmcKEo5l2Eg+EOZ2jAXxNsaPXtE/psAYSHEASPUj99ST7KZobcdGgBukqq+/S1io
         OyV7qVUPYadi5zvv4QZsVmmL7ob/gfP/otq05ftyXG4qWtsp77INJk2V4P1XIYPFnb
         +fTbLOlLBTOni8S9oCEqA2mBrhwxOuWSuv/5a7dft1mgcwadeDO54e8bdGkgH/bLqF
         9rWyrOdFb8lmg==
Date:   Wed, 7 Jun 2023 23:23:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
Message-ID: <20230607-unruly-encore-e00661704b71@spud>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud>
 <tencent_79F42B5A66F98A65266F989EC9C86A69F005@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iroTKYY20BMB+hrX"
Content-Disposition: inline
In-Reply-To: <tencent_79F42B5A66F98A65266F989EC9C86A69F005@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iroTKYY20BMB+hrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 06:17:22AM +0800, Woody Zhang wrote:
> Hi, Conor
>=20
> On Wed, Jun 07, 2023 at 07:17:28PM +0100, Conor Dooley wrote:
> >+CC Alex, you should take a look at this patch.
> >
> >On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> >> It's possible that early_init_fdt_scan_reserved_mem() allocates memory
> >> from memblock for dynamic reserved memory in `/reserved-memory` node.
> >> Any fixed reservation must be done before that to avoid potential
> >> conflicts.
> >>=20
> >> Reserve the DTB in memblock just after early scanning it.
> >
> >The rationale makes sense to me, I am just wondering what compelling
> >reason there is to move it away from the memblock_reserve()s for the
> >initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
> >should be the sufficient minimum & would keep things together.
>=20
> IMO, moving it to parse_dtb() is more reasonable as early scanning and
> reservation are both subject to DTB. It can also lower the risk to
> mess up the sequence in the future. BTW, it's also invoked in
> setup_machine_fdt() in arm64.

I'm fine with the change either way, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Mostly wanted to know whether you'd considered the minimal change.

Cheers,
Conor.

--iroTKYY20BMB+hrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIEDYwAKCRB4tDGHoIJi
0qaSAP9p8WmnDgqGTpmUYr2HQW4T7TMTPFK2n+EWI1gMRejlQQD/b640SeGyJ73C
iIcpx6Qh2bBLuteKWiwmHGemZvXGBAE=
=Xh0P
-----END PGP SIGNATURE-----

--iroTKYY20BMB+hrX--
