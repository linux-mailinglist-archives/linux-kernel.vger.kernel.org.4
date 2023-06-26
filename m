Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5473E6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFZRt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjFZRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942EB26B3;
        Mon, 26 Jun 2023 10:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3025360F18;
        Mon, 26 Jun 2023 17:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86401C43397;
        Mon, 26 Jun 2023 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687801731;
        bh=fFWuzhLLiGkinhaWeToFLkDX/dcx5OWER83aW8VgRow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qn7TSH5fBy879Kn45s8a/YCOEx1oTS+0VCd/Q+kNmCB7uRTTg7TK3CW2K5FgKL5SO
         RoBVKuhnNkjoWxoU5K2xmCMLOL3TePePVRvun87gj3KrTnQpXgAMXLWOX/L2U+vGMb
         wy6CqBDWmWhCmphC6Q8EiBNziTaMXriaczMp6DJiN1Ej/WUjTzJ6N+lvXogj4eiJcj
         PJKRTqLP+Zecd+1KGIrC38/JsFePpZ84jlJVtuUPeUpe+0KdJssjei1KlWQsAb8xqI
         wX+VWs0F7zWSqHLgR+NZLp09+VOq+k1qPrGR83NuByW+4SQgicdeCKOv73ZNgnYywR
         IXCdgqJe6fP2Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so5765332e87.0;
        Mon, 26 Jun 2023 10:48:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDwHOCXBDBdGd9b4lMdSKT8qVBasv78TzKVknxYGcI7OVT7Ygd8R
        4MKUxER8LP9Ic52vOMgwJgoERu5KyoiNGxxH/7k=
X-Google-Smtp-Source: ACHHUZ6w6e1OYy7QM9S+YTdK71Dx4cd9s642AcRaJSfPZb8UXF8n/hvi2zuHhdV8C7DcTgUpaxVtcUwpuH0YchvBFOg=
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id
 a29-20020a195f5d000000b004f85e62b94bmr8655403lfj.9.1687801729333; Mon, 26 Jun
 2023 10:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com> <20230618080027.GA52412@kernel.org>
 <a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com> <20230625161417.GK52412@kernel.org>
 <ZJmFFmexl_1GUhIL@FVFF77S0Q05N>
In-Reply-To: <ZJmFFmexl_1GUhIL@FVFF77S0Q05N>
From:   Song Liu <song@kernel.org>
Date:   Mon, 26 Jun 2023 10:48:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
Message-ID: <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Mon, Jun 26, 2023 at 5:31=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
[...]
> >
> > So the idea was that jit_text_alloc() will have a cache of large pages
> > mapped ROX, will allocate memory from those caches and there will be
> > jit_update() that uses text poking for writing to that memory.
> >
> > Upon allocation of a large page to increase the cache, that large page =
will
> > be "invalidated" by filling it with breakpoint instructions (e.g int3 o=
n
> > x86)
>
> Does that work on x86?
>
> That is in no way gauranteed for other architectures; on arm64 you need
> explicit cache maintenance (with I-cache maintenance at the VA to be exec=
uted
> from) followed by context-synchronization-events (e.g. via ISB instructio=
ns, or
> IPIs).

I guess we need:
1) Invalidate unused part of the huge ROX pages;
2) Do not put two jit users (including module text, bpf, etc.) in the
same cache line;
3) Explicit cache maintenance;
4) context-synchronization-events.

Would these (or a subset of them) be sufficient to protect us from torn rea=
d?

Thanks,
Song
