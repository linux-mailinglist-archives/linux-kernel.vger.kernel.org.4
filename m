Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28B733EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbjFQGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944E1BF2;
        Fri, 16 Jun 2023 23:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A1A6090A;
        Sat, 17 Jun 2023 06:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C22C433C0;
        Sat, 17 Jun 2023 06:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686984783;
        bh=s5IbUS/R9FUeza7Uno3Hll+WeqZYFms0rCFRllsd4i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0jdChYvxLTPBx1BOB1xElON4yTO54jJpqqtDjBH7kzjTk7h8ut1Zvwg88nJSwHD5
         dR46BC1yX4kfsB9fmhzM3g5FAiBBJ7EopEe68OhToY9ZvFD0H28XYCChSftyR0QUBZ
         RDI9hk6abzU7ADT2Mp8RObMy225YcvgqAzj8bWooQ/IUkq2S0z3QH97xrM4q9eh/eL
         W9Ix4DLih/xlZ3Zq9c6AydZXL5tY2UznK8+LjAqeaAIVsE4aQyWtPv0n7kE5DQG+KX
         YYFIH+XCs7DhkCWkawXBSwV8RH6HWXBuasnHhsf1ZYp1zsYvUdnbybweDJ02yKksNs
         +4CfHcBEs1MPg==
Date:   Sat, 17 Jun 2023 09:52:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
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
        Song Liu <song@kernel.org>,
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
Subject: Re: [PATCH v2 12/12] kprobes: remove dependcy on CONFIG_MODULES
Message-ID: <20230617065216.GS52412@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-13-rppt@kernel.org>
 <87r0qbmy14.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0qbmy14.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:44:55PM +0200, Björn Töpel wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > kprobes depended on CONFIG_MODULES because it has to allocate memory for
> > code.
> 
> I think you can remove the MODULES dependency from BPF_JIT as well:

Yeah, I think so. Thanks!
 
> --8<--
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index 2dfe1079f772..fa4587027f8b 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -41,7 +41,6 @@ config BPF_JIT
>         bool "Enable BPF Just In Time compiler"
>         depends on BPF
>         depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
> -       depends on MODULES
>         help
>           BPF programs are normally handled by a BPF interpreter. This option
>           allows the kernel to generate native code when a program is loaded
> --8<--
> 
> 
> Björn

-- 
Sincerely yours,
Mike.
