Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366496F3884
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjEATzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjEATzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615F213E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:55:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso7611276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=nOGV79JHEufvcYn2AKhdk79/ViXSWov22Cy33zWA1Gtst+eCDvoVa3OWWz5HNIcCII
         UZejZi5Uegh9PTt5hwbCSATYVQ0siN0O+UgoBQWNisA50H9K9bZk9Wrc9Z0OQeeEfA/+
         +yThvmo2Fno7BKwBTkUAF3LbTzoNv7/LwN0wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=R2Z+DtvHMKtnUdPkKCzTKLj0OBGbcQwbIucYLsbNmz0QtmwWjqFLUdeS0GzowavMRG
         mxNTWcI8pNl9XYsPfhu9+6qh83McHbJ0CrLCnHl/2XCm6iYaaffUI7Chb/CZbrp1hwSb
         AlE3Ee34WD4ijRtqmTNRcIGo8KVl/47yoJ3/tBN/4Z0i2Hi48xzHaCs0/Yhonj6lOA/3
         Y04Aulw9sca9y5lWlJVG5sHioXBZA1hCYvuoEdJ3EdlV9nEW4Ws0E1a49Lda1aHlk4K2
         MjZLSVXkGWYIKp70xQhqnacBek37+TQ+HLoUGOq1fAKU1LGMnG+WoUlPmw1QzKYuWl9R
         aH/g==
X-Gm-Message-State: AC+VfDzutQ82KDzo69fFVamamcDXyKUFjA5ZFViW7FMoqT311Tra+TJ1
        l0nSyv6ylL+M5ZSf3uJ9kYv3ySFc0igjxFCpfxNaqQ==
X-Google-Smtp-Source: ACHHUZ7oUZsOQSZppJIytj6FitMTaO7GzGNU5vsSJ8Qyb8rNLNre50XcWq7ncu/zQuOHZFGVnRpH1w==
X-Received: by 2002:a25:25cf:0:b0:b9e:66f0:be9d with SMTP id l198-20020a2525cf000000b00b9e66f0be9dmr7169ybl.61.1682970917263;
        Mon, 01 May 2023 12:55:17 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id g140-20020a0ddd92000000b00545a081849esm1987612ywe.46.2023.05.01.12.55.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 12:55:17 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b996127ec71so4552866276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:55:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:a28a:b0:e6:f7e8:1e4d with SMTP id
 a10-20020a056a20a28a00b000e6f7e81e4dmr13625249pzl.33.1682970895325; Mon, 01
 May 2023 12:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <20230501-cottage-overjoyed-1aeb9d72d309@spud>
In-Reply-To: <20230501-cottage-overjoyed-1aeb9d72d309@spud>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 21:54:43 +0200
X-Gmail-Original-Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Conor Dooley <conor@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor

On Mon, 1 May 2023 at 19:41, Conor Dooley <conor@kernel.org> wrote:
>
> Hey Ricardo,
>
> On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > This is not supported by kexec and crashes the system.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  arch/riscv/purgatory/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index 5730797a6b40..cf3a44121a90 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> >  CFLAGS_string.o := -D__DISABLE_EXPORTS
> >  CFLAGS_ctype.o := -D__DISABLE_EXPORTS
> >
> > +# When profile optimization is enabled, llvm emits two different overlapping
> > +# text sections, which is not supported by kexec. Remove profile optimization
> > +# flags.
> > +KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
>
> With the caveat of not being au fait with the workings of either PGO or
> of purgatory, how come you modify KBUILD_CFLAGS here rather than the
> purgatory specific PURGATORY_CFLAGS that are used later in the file?

Definitely, not a Makefile expert here, but when I tried this:

@@ -35,6 +40,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
-fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS := $(filter-out -fprofile-sample-use=%
-fprofile-use=%,$(KBUILD_CFLAGS))

It did not work.

Fixes: bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimization")

does this approach, so this is what I tried and worked.

Thanks!
>
> Cheers,
> Conor.
>
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> >  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Ricardo Ribalda
