Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BA70B40A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjEVERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:17:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC45CE;
        Sun, 21 May 2023 21:17:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPkft3zztz4x4B;
        Mon, 22 May 2023 14:16:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684729020;
        bh=AVLVOohCWlNWsFlZp/IjXPMalhLXANn4M3eXvq7tzo4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pgufz1uRbk/l6Rkj1iL6mZYqH3IRjcKojpyTlmnAqC5gBLrUBoE9FFstCMUjKSjQa
         uv9vN+rApxtjlJ8i1zW14wzuxXSWmzFWQpJmE+6E5yQ16RHo80JIMVZFCkzEud3Rsd
         crFSqYweTi2+OSAyQrKmkoPy6AY1LlMn3p4HCzfgB27T+V6UTyE7OgP+ZngP7e0K/g
         xrERP69ypwM37e6nnw4lM8nQO1q9vvBO0V6MtmIgeKMJxW1qB5hv4V1bHGEHIl5WZr
         GLi3ASKQsCuuTsN3XYaBrB9DgTnDKaHMkGPu9JFhl45o+kil82t9uN8FJoBA2XwUIK
         n8c477C2qGY9A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 3/4] powerpc/purgatory: Remove PGO flags
In-Reply-To: <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
Date:   Mon, 22 May 2023 14:16:54 +1000
Message-ID: <87h6s59f0p.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Ribalda <ribalda@chromium.org> writes:
> If profile-guided optimization is enabled, the purgatory ends up with
> multiple .text sections.
> This is not supported by kexec and crashes the system.
>
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/powerpc/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
