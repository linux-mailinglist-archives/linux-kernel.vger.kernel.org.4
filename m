Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51DD5F5155
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJEJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJEJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:06:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B37644D;
        Wed,  5 Oct 2022 02:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55C3AB81D49;
        Wed,  5 Oct 2022 09:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B7C433D6;
        Wed,  5 Oct 2022 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664960765;
        bh=hJ2FlaFirUuI4hX9j6QpETml7t5ItP4nxc9UwAYJ8tw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=CDAltb2OxH7o/HxYn2/oU7A5p6W5RcL0WkwL63fIQQByoKvBmfYhibYXlngZXOhDS
         zFaUAUTu/PdVH3LgtRwifdsSM4Jm669AIkgSpwsZslVD8gjOr33yqu8HmqJlZviKjl
         liiP+HotD1eCP5Hg9XN/zeLg1LLrLFxF/ynm2LR6wA+iHOV4B5l7OXH1MW5OfjJRWT
         uwuUr9v+IVBG7AJ0Ec+uYWOTCfYpPfuIs1rBUN92sAS8u4u+gYRtnGGp6eL9PLeeOs
         TYfICQAqPQ91szksq37nGOa//hRb9NfHaFZoeB57vTyjGWb79TZVkrkNYajdPLsjpW
         uE8licpGT03VQ==
Date:   Wed, 05 Oct 2022 09:58:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v2_2/2=5D_soc=3A_renesas=3A_A?= =?US-ASCII?Q?dd_L2_cache_management_for_RZ/Five_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <YzxwoELNBctbhjJb@spud> <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
Message-ID: <F0B6C609-6C39-4080-8F07-7FEFFAFEA993@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 October 2022 09:44:56 IST, "Lad, Prabhakar" <prabhakar=2Ecsengg@gmail=
=2Ecom> wrote:
>Hi Conor,
>
>Thank you for the review=2E
>
>On Tue, Oct 4, 2022 at 6:43 PM Conor Dooley <conor@kernel=2Eorg> wrote:

>> > +static void cpu_dcache_wb_range(unsigned long start,
>> > +                             unsigned long end,
>> > +                             int line_size)
>> > +{
>> > +     bool ucctl_ok =3D false;
>> > +     unsigned long pa;
>> > +     int mhartid =3D 0;
>> > +#ifdef CONFIG_SMP
>> > +     mhartid =3D smp_processor_id();
>> > +#endif
>>
>> Won't this produce complaints from your if you compile with CONFIG_SMP
>> set?
>>
>No I dont see a build issue with SMP enabled, do you see any reason
>why it should fail?

Not fail but complain about the unused variable=2E

