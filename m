Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEA6A6568
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCACV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCACV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:21:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A6DB445
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F76611B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000CFC4339B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677637316;
        bh=KymsAAZhTXhaULv7piniQQoD5iMV1Bl5HKPh08O2spg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AHe3rlsmB5yHU7dV5GW8YekfdY+SO97C0WIKIBwkhDO9QpJ6TLLLXoYbzZqP5LfXl
         M/z9mO1XGIRd5a2NFlSdI9L7VTu7PhcOna7anXC/4hkqfHL5mxUd+jwAyx8Myc48SQ
         x3lOvdSgUfpR8TvVN6M641KWE8fw9NJs1dn2mFY3CzbppcWbZYreCyy+Z+C26betPJ
         9he+4UUqNhU94ChC5ucbKzXdWNIS9sFxzProTxhB5N3xncdHbWt4zWoZoKl9yftUXI
         1JISqHMH3Lrb7FDjbTsZShbAPuREUfGErFetQ3JDQZHvvhL9YqHEc3cSyCj/4FjbvB
         I9HSz98H1gorg==
Received: by mail-ed1-f44.google.com with SMTP id da10so48176329edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:21:55 -0800 (PST)
X-Gm-Message-State: AO0yUKViMOk2KT9hF0yY4Y6INPV8J4OJqh76bC2OEFR1GKrC0czQrCPG
        mb787n69GLm9ifE3SVSIDm7idlkYtpR/5Nuzwrc=
X-Google-Smtp-Source: AK7set+8Ojeh58hPB0HzS94VXKaeYHAwQIW/3HmewYHJro4+F02U2eYtE8TMWJArKu8qe7mttDVpspY1DxOjYZxtH+o=
X-Received: by 2002:a17:906:5594:b0:877:7480:c568 with SMTP id
 y20-20020a170906559400b008777480c568mr2424754ejp.8.1677637314205; Tue, 28 Feb
 2023 18:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20230228215435.3366914-1-heiko@sntech.de>
In-Reply-To: <20230228215435.3366914-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Mar 2023 10:21:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSG23qMp6UuF_zrHY-QvVCR4BNm2vA088BJTe3rF0vUkg@mail.gmail.com>
Message-ID: <CAJF2gTSG23qMp6UuF_zrHY-QvVCR4BNm2vA088BJTe3rF0vUkg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] RISC-V: T-Head vector handling
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        samuel@sholland.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:54=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wro=
te:
>
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> As is widely known the T-Head C9xx cores used for example in the
> Allwinner D1 implement an older non-ratified variant of the vector spec.
>
> While userspace will probably have a lot more problems implementing
> support for both, on the kernel side the needed changes are actually
> somewhat small'ish and can be handled via alternatives somewhat nicely.
>
> With this patchset I could run the same userspace program (picked from
> some riscv-vector-test repository) that does some vector additions on
> both qemu and a d1-nezha board. On both platforms it ran sucessfully and
> even produced the same results.
Great! Thx.

>
>
> As can be seen in the todo list, there are 2 places where the changed
> SR_VS location still needs to be handled in the next revision
> (assembly + ALTERNATIVES + constants + probably stringify resulted in
>  some grey hair so far already)
>
>
> ToDo:
> - follow along with the base vector patchset
> - handle SR_VS access in _save_context and _secondary_start_sbi
>
>
> Heiko Stuebner (2):
>   RISC-V: define the elements of the VCSR vector CSR
>   RISC-V: add T-Head vector errata handling
>
>  arch/riscv/Kconfig.erratas           |  13 +++
>  arch/riscv/errata/thead/errata.c     |  32 ++++++
>  arch/riscv/include/asm/csr.h         |  31 +++++-
>  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
>  5 files changed, 261 insertions(+), 16 deletions(-)
>
> --
> 2.39.0
>


--=20
Best Regards
 Guo Ren
