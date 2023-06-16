Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682B7733AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjFPUSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFPUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC92D60;
        Fri, 16 Jun 2023 13:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D95BD63E33;
        Fri, 16 Jun 2023 20:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CCC433C0;
        Fri, 16 Jun 2023 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686946692;
        bh=U5Tl9qs4B0TBI/rIx4ZZgTkRwFm5uyKz4CPReQtXH/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LmBJJScQlLvxsT8+Ta1tCpM4WXI6TR8l8c5jV/lF5ZOrowqAfZjtpNM41tcPHiArX
         +YH5I9st348UgQHncZvkjv1I8uf6/B9VIYKB/ZX5ShONmWppK4Z28CmWLldHUX++Co
         tQHCqBzRDW0rngL+0918l5A/LKDXSOHiSUfIz3m/CZC9iQ5hn0r0gJTm/FmWwj/qLn
         mAG9TY9iKVAQprNcopRBSELs+aKCJHBbKHSrnFdxygoqMhe72Gcymvj1seoYl1ETYg
         kF9uj767lw3HcyBO4F7SRQUsfNpsVMh+rYJU6mMVRBqQdXG9XPM9gyQIez8ST13ZvP
         VGJY2Pv9kdJTA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso13911621fa.3;
        Fri, 16 Jun 2023 13:18:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDzwqXFeWcpAfyNZDYJy/dEE3segkj31VXtM2BI04oZSYci1aCEf
        /ekDI9FrlcgdbzzOuE7aPn1PxICOrGvRVZFOatg=
X-Google-Smtp-Source: ACHHUZ4zX0CYOJSSN4FGWX93J1VUIgZYXEOYsrGR9cSML7AlHx0h0qQhMxp9jkMOVU4u0KdCA43Yux1f/ue71yfnFUk=
X-Received: by 2002:a05:651c:225:b0:2b3:4fb7:8991 with SMTP id
 z5-20020a05651c022500b002b34fb78991mr2815162ljn.43.1686946690319; Fri, 16 Jun
 2023 13:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-11-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-11-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:17:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4C1zm72AkHfuo6Xz4+37AG4BgX_k2fM+xw536QeDQS+w@mail.gmail.com>
Message-ID: <CAPhsuW4C1zm72AkHfuo6Xz4+37AG4BgX_k2fM+xw536QeDQS+w@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] arch: make execmem setup available regardless of CONFIG_MODULES
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> execmem does not depend on modules, on the contrary modules use
> execmem.
>
> To make execmem available when CONFIG_MODULES=3Dn, for instance for
> kprobes, split execmem_params initialization out from
> arch/kernel/module.c and compile it when CONFIG_EXECMEM=3Dy
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
[...]
> +
> +struct execmem_params __init *execmem_arch_params(void)
> +{
> +       u64 module_alloc_end;
> +
> +       kaslr_init();

Aha, this addresses my comment on the earlier patch. Thanks!

Acked-by: Song Liu <song@kernel.org>


> +
> +       module_alloc_end =3D module_alloc_base + MODULES_VSIZE;
> +
> +       execmem_params.modules.text.pgprot =3D PAGE_KERNEL;
> +       execmem_params.modules.text.start =3D module_alloc_base;
> +       execmem_params.modules.text.end =3D module_alloc_end;
> +
> +       execmem_params.jit.text.pgprot =3D PAGE_KERNEL_ROX;
[...]
