Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70CE7260A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjFGNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjFGNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:09:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09111BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:09:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso74023405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1686143379; x=1688735379;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnMyzOk/vTKWlLvg7he0gtZ2J/frXqKetJaHL/fDdnk=;
        b=H0VOkUH6kFiFRhSSWjrvom6LWeHzTSED2VI5HUYUNPRl3GSZCeNaJGycMsblRsW78r
         RCy/urUE8RI81gri6nKuhQbc2gyg0bRJw2L/nWKhTY2BPLy013V8ASmnM4OCXT820UvI
         GwS8ukXlG6X0KJVAspARMB9ZXjMaeyLGMcwZ2Nujzr6+15iEKVFm8Gkqm3heOCVnUUKH
         BCuAg9gqUaFD9/Lqx2LYByNp3gHt7ny6xszNq5/tlAd89XEUZoBA5n+etUkiM7fbgeMi
         vCXF63ONggfFfyH+DsMT3SjAOQnTfLMHGT+ohduYU/hYCT9GOjep8iUrpFNxp6F2fFWW
         To3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143379; x=1688735379;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnMyzOk/vTKWlLvg7he0gtZ2J/frXqKetJaHL/fDdnk=;
        b=Bimfws1dr+trsyMejNboSXpmJRWA9sVN7+qYxiBy17TxTQyYh4lept+u5ZkSMVraCS
         RqnIHea0jaxIJQt4a0mZ1QekpLJHpLDmW+1wt4EHy4MUzuYkeLGNXyqvdHYLMb6mBFvG
         UEh5q6RyHN4MFYeNuNNVU/BXBs61BlF0QlxqWfNOLp9eUJvfdq3wQsspkZa1IE9UUHd9
         G+677naVYbiLRFJLaFoRk8Uy3Sy9t/B8gvYHlmJvsnB4IOWlBTV5iTJOqDdWB5jtI//7
         0MQzYC73X2y0aLYvwUFC83zHdB5MuxwUXd8WGgR8r1GJELRHC6kYYUZhkYS1GY0xbUgE
         i51A==
X-Gm-Message-State: AC+VfDz9DE5VuJqSkw1Qugwri6sN9UZIz/hkNTuaM8sEqDPsM+N9YCzi
        4rrpv54vjc1ENvYF42ztZrgrZg==
X-Google-Smtp-Source: ACHHUZ5Kxfe6zUKRliJXHJzL98zZQOfit49/YUSl3Eqmnm+9qVN4eSDGNJ3xfiznZgTmdSxzHwclbA==
X-Received: by 2002:a7b:c457:0:b0:3f6:f2b2:15c9 with SMTP id l23-20020a7bc457000000b003f6f2b215c9mr5057736wmi.37.1686143379440;
        Wed, 07 Jun 2023 06:09:39 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030644bdefd8sm15284117wrn.52.2023.06.07.06.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:09:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH -fixes] riscv: Check the virtual alignment before choosing
 a map size
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230607125851.63370-1-alexghiti@rivosinc.com>
Date:   Wed, 7 Jun 2023 14:09:28 +0100
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8ECB3E5-8DDA-443A-AD00-D337708DBE4C@jrtc27.com>
References: <20230607125851.63370-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2023, at 13:58, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>=20
> We used to only check the alignment of the physical address to decide
> which mapping would fit for a certain region of the linear mapping, =
but
> it is not enough since the virtual address must also be aligned, so =
check
> that too.
>=20
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear =
mapping")
> Reported-by: Song Shuai <songshuaishuai@tinylab.org>
> Link: =
https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.co=
m/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> arch/riscv/mm/init.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index d42ea31c7de0..5143eef4c074 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -660,18 +660,19 @@ void __init create_pgd_mapping(pgd_t *pgdp,
> create_pgd_next_mapping(nextp, va, pa, sz, prot);
> }
>=20
> -static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t =
size)
> +static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,

Why on earth is this returning uintptr_t? It=E2=80=99s a size not a =
pointer.

Jess

> +      phys_addr_t size)
> {
> - if (!(base & (PGDIR_SIZE - 1)) && size >=3D PGDIR_SIZE)
> + if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >=3D =
PGDIR_SIZE)
> return PGDIR_SIZE;
>=20
> - if (!(base & (P4D_SIZE - 1)) && size >=3D P4D_SIZE)
> + if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=3D =
P4D_SIZE)
> return P4D_SIZE;
>=20
> - if (!(base & (PUD_SIZE - 1)) && size >=3D PUD_SIZE)
> + if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >=3D =
PUD_SIZE)
> return PUD_SIZE;
>=20
> - if (!(base & (PMD_SIZE - 1)) && size >=3D PMD_SIZE)
> + if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >=3D =
PMD_SIZE)
> return PMD_SIZE;
>=20
> return PAGE_SIZE;
> @@ -1177,7 +1178,7 @@ static void __init =
create_linear_mapping_range(phys_addr_t start,
> for (pa =3D start; pa < end; pa +=3D map_size) {
> va =3D (uintptr_t)__va(pa);
> map_size =3D fixed_map_size ? fixed_map_size :
> -    best_map_size(pa, end - pa);
> +    best_map_size(pa, va, end - pa);
>=20
> create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
>   pgprot_from_va(va));
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

