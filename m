Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4B73383A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjFPSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791482119;
        Fri, 16 Jun 2023 11:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141D7623F0;
        Fri, 16 Jun 2023 18:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A86C433C9;
        Fri, 16 Jun 2023 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686940606;
        bh=JGylOLwsDlnOC/7zFFXP8rSDvCyOTlCYNV6rWd4f8mw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SeXeGZ/w86KmlurMiVm4UIF69ZGzlkmxJdFe2QmV6PX8IW+hDhUbuFBav3t/B8pWZ
         vEzDIgk/zKEW5stVwEtyb8WYKsD74Cn5N7O03rsyRz3LX2xGotPEbMmsM7IV3g9Dxd
         h5Uh6GrvB3LrnxzUUDOGdAi+YQl7sfLX58PmPPi1I/7ju04tDqO1xvj3P1oQrQvlEn
         mq1rf5Tcp0oheWCmaw6RaW+tUKVhYkG7a6qCHK2MLKMhdZ/TjBbzmfPfgUfEdkhdA/
         QK30NJOharxczGBPm79t0v2LgrZqJ5TBlW/fXRzSrlgo6PvG8f6QCwr2oWnE+7+dKS
         y4wFdRFTvaw9Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f84d70bf96so1327926e87.0;
        Fri, 16 Jun 2023 11:36:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDzfimA42RcpSaF9PTQlk2nNIJUxkYTv66oTFHA3L8Ny/CEgE78U
        bF83XCPAbg+H9PPaws+Kf354lKxf0BwZ8HemavA=
X-Google-Smtp-Source: ACHHUZ7VgWfSxd734IfkdiKrgB+GJm0nBxE0sk2dQ8TAn5f7aSo4Y23dXvE8MnzKke3G84UjJ1bhxQV9PGC+v71U+NE=
X-Received: by 2002:a19:7913:0:b0:4f3:aa81:2a6e with SMTP id
 u19-20020a197913000000b004f3aa812a6emr797084lfc.19.1686940604495; Fri, 16 Jun
 2023 11:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-4-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-4-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 11:36:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6tDvY5G-qGMq3ymth3ip27=zAij8_UhJ-qP6Ct1U1-ZA@mail.gmail.com>
Message-ID: <CAPhsuW6tDvY5G-qGMq3ymth3ip27=zAij8_UhJ-qP6Ct1U1-ZA@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:51=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Several architectures override module_alloc() only to define address
> range for code allocations different than VMALLOC address space.
>
> Provide a generic implementation in execmem that uses the parameters
> for address space ranges, required alignment and page protections
> provided by architectures.
>
> The architecures must fill execmem_params structure and implement
> execmem_arch_params() that returns a pointer to that structure. This
> way the execmem initialization won't be called from every architecure,
> but rather from a central place, namely initialization of the core
> memory management.
>
> The execmem provides execmem_text_alloc() API that wraps
> __vmalloc_node_range() with the parameters defined by the architecures.
> If an architeture does not implement execmem_arch_params(),
> execmem_text_alloc() will fall back to module_alloc().
>
> The name execmem_text_alloc() emphasizes that the allocated memory is
> for executable code, the allocations of the associated data, like data
> sections of a module will use execmem_data_alloc() interface that will
> be added later.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Song Liu <song@kernel.org>
