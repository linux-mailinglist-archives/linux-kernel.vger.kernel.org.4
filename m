Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709E164AD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLMCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLMCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:13:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02562D6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:13:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m4so14086773pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dytxSctGH3/JU5+VUvCXKRl3djDPMXaOjikH1n5CrMU=;
        b=CBf3R1fmXIZ45yTb+WHxJdiyNOFL2h5rhe7iuVz+maaKt1rkPLuLZ1Vg6SAm23HMHG
         vQ6uXPH/ty7wkcdAYuV/Lh/0nTI9cyJfrD99XFzYtkzgINZ5bTa5LBeoIBAsqfn4QDC3
         6SVFH94xQAmltYML5ctohPuMu25umC/aZZCO6gUijQK+8crcDBG5bvbVDVdxF3bugd0O
         rtoRLMRfttq4YtD01i5HrnVdRJstwarVuJG/T6s79sxcBeqvrkLe9Nt+5avTs3+UOplZ
         FkjJ/F9aFkiOlaZ3Av0iqu9jA/E5UOfBI4ocgDHSNbxKS74BDaooa/RlqBvBkybckhx2
         eXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dytxSctGH3/JU5+VUvCXKRl3djDPMXaOjikH1n5CrMU=;
        b=uG5WACr3H6lqdUeT9KCee6e6UQeQkiHO7fJVhYcUvMZkhW0PN848EcTBZJqksb1gLa
         Jmm1C4Of/0uFUeO1QHI4QX2lLsKzb4/gj0L6wKNY4W2oybou8QD3cbu9YcANFwO2NxZz
         uqYIt3Tz2p5wZ0tD0jtMN40GjR8DhnDo8aYEKB0TVelWxfLvt0QpcpcRzSvgCWRGcjGa
         4Xgexsoi3QovvtfvPD/D4AnsQdX62yRPCvJ451UDV1F1RZnfo1e1Bb6VTHBwnmthVIIf
         FOzk11fZc/wz+fE4MjzbPZcI7nGh1glbVq2n0g31vV35z2MlbQF4WwXpc8ynP73YVrd5
         yNMQ==
X-Gm-Message-State: ANoB5pk8V6cupzA1cKLifQBoN0xkOk/+fRnn/6Gc5h+NqLD0HRWHvdvy
        rvw//UuBv5mmKXtXGWp+GpoYZ6iAtuDstE2V
X-Google-Smtp-Source: AA0mqf5lyAQrJvHm7xnE6hLi9O52SD019Oq6Ie+uJ0eyRDJIM2Xscc/SexS//WPdt/sgq2p4vlI/tg==
X-Received: by 2002:a17:902:7b96:b0:189:858f:b5c0 with SMTP id w22-20020a1709027b9600b00189858fb5c0mr90604pll.0.1670897608745;
        Mon, 12 Dec 2022 18:13:28 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b00176b63535adsm7060787pln.260.2022.12.12.18.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 18:13:28 -0800 (PST)
Date:   Tue, 13 Dec 2022 02:13:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH 11/14] KVM: selftests: Disable
 "gnu-variable-sized-type-not-at-end" warning
Message-ID: <Y5ffxebJ/eRzEXh+@google.com>
References: <20221213001653.3852042-1-seanjc@google.com>
 <20221213001653.3852042-12-seanjc@google.com>
 <CAKwvOdnRQQb9YbH=MgDymBmmjYgajc8tkyjbJVxjpA5zDZpNTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnRQQb9YbH=MgDymBmmjYgajc8tkyjbJVxjpA5zDZpNTQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022, Nick Desaulniers wrote:
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index 2487db21b177..9cff99a1cb2e 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -196,6 +196,7 @@ else
> >  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
> >  endif
> >  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> > +       -Wno-gnu-variable-sized-type-not-at-end \
> 
> This is a clang-specific warning. This will need to be wrapped in a
> cc-option check.

Not that I'm against guarding this code, but I don't think cc-option() will do
anything in this case.

AFAICT, gcc stopped treating unknown "-Wno" flags as unconditional errors starting
with gcc-4.4, and the kernel's min supported version is 5.1.  gcc-4.4 through
gcc-9.5 all print a mild warning if there's a different error, but otherwise
silently ignore the uknown "-Wno".

  cc1: warning: unrecognized command line option '-Wno-gnu-variable-sized-type-not-at-end'

gcc-10.1 is even friendlier and notes that the unknown flag may have been related
to the error.

  cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end'
  may have been intended to silence earlier diagnostics

Because cc-option() doesn't have errors in its probing code, it will return "true"
on gcc for literally any "-Wno-*" input that gcc deems syntacially valid, e.g.
gcc barfs on

  depends on $(cc-option,-Wno-)
  depends on $(cc-option,-Wno)

but happily succeeds with

  depends on $(cc-option,-Wno-lol-gcc)

Various man pages suggest -Wunknown-warnings is a thing, but no gcc version
supported by godbolt recognizes it.

So unless I'm missing something, trying to detect lack of support will be non-trivial,
and the worst case scenario is that users of older gcc version will see a potentially
confusing warning when the build fails.
