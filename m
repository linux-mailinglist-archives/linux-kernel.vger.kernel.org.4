Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9746680A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjA3KPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjA3KPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:15:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF45252
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675073698; x=1706609698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwEKN/1p4eWTFuG/cB1MKqkiGvRps+1/UwCIq8nALKY=;
  b=bpUYYE9YOAAUc2q8eZmzP8Ryw49VYkre+3dtJHbEGvcwKVxGPJQ+GKvO
   6KwHG+nx0uikN+lP/x1sx5BZt0EurLeeg3o7wuTQ1szDxPNknrppND8oL
   XEv2GaVPrts3x7LeL7GkRbdsx8dxOes+O158I5obFwaGBqrRs14JfabUo
   A9mYTHsnN3pveAEhg6Vl/ENe5LxI+UxBSgv/C0GylV+fwUpWaaLqlHxTa
   AVhd2sfQyndvAXJH7FUC76D822uGCvVHGADQX67va3l6PYyT5jxIyhfMu
   9z+GNPu3scO4El9z73lwIeRybG+zRci4gai0N+6/1VCaFWoyCaW+LRiyb
   A==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="asc'?scan'208";a="194421175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 03:14:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 03:14:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 30 Jan 2023 03:14:49 -0700
Date:   Mon, 30 Jan 2023 10:14:25 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jinyu Tang <tjytimi@163.com>
CC:     <palmer@rivosinc.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <yuzhao@google.com>,
        <ajones@ventanamicro.com>, <guoren@kernel.org>,
        <tongtiangen@huawei.com>, <anup@brainfault.org>,
        <akpm@linux-foundation.org>, <falcon@tinylab.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
Message-ID: <Y9eYgSnTmI168933@wendy>
References: <20230129064956.143664-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="anvknZz1ArHLm8XG"
Content-Disposition: inline
In-Reply-To: <20230129064956.143664-1-tjytimi@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--anvknZz1ArHLm8XG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 02:49:56PM +0800, Jinyu Tang wrote:
> The arch_has_hw_pte_young() is false for riscv by default. If it's
> false, page table walk is almost skipped for MGLRU reclaim. And it
> will also cause useless step in __wp_page_copy_user().
>=20
> RISC-V Privileged Book says that riscv have two schemes to manage A
> and D bit.
>=20
> So add a config for selecting, the default is true. For simple
> implementation riscv CPU which just generate page fault, unselect it.
>=20
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..17c82885549c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>  	default 0x80000000 if 64BIT && !MMU
>  	default 0xff60000000000000 if 64BIT
> =20
> +config ARCH_HAS_HARDWARE_PTE_YOUNG
> +	bool "Hardware Set PTE Access Bit"
> +	default y
> +	help
> +	  Select if hardware set A bit when PTE is accessed. The default is
> +	  'Y', because most RISC-V CPU hardware can manage A and D bit.
> +	  But RISC-V may have simple implementation that do not support
> +	  hardware set A bit but only generate page fault, for that case just
> +	  unselect it.

Hmm, I am not really sure if this is the right way to go. Should we
really be defaulting this option to enabled if there are going to be
implementations that do not support it?

Thanks,
Conor.


--anvknZz1ArHLm8XG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9eYcgAKCRB4tDGHoIJi
0v50AP9BruHvX+Vp+nv8nNnUUgTJCFqXa+miF0OX6/LB2A5BlAEAtWmDrHHF+wUL
CZA1/N+0ovdarfkIEMX76O7HnBKe1QE=
=RCMS
-----END PGP SIGNATURE-----

--anvknZz1ArHLm8XG--
