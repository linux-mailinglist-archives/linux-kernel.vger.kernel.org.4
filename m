Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78E6CB5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC1E4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjC1E4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:56:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1622139
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:56:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541888850d4so108976987b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679979364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6fqdp6bviKxq26fqY3VfiJLpmiTmRcnKqOZtEa3+g=;
        b=aJFlcJFELP8JBDEDASWH7ieMNnljbM3fElwd04/UnqjsXirVOda+tuNB+2BMkzP5tk
         eG84LtG+5ShuDv0zeNMKdGiuzGV7v3DSok0NBTdICR6Z0i/ycqjXxq1pTGo7C9AOvmvx
         /jS45/VH4wxtMoZDrtKgZQ6SDvwp4kSBVjYuRYHJvcU5lHd/tLOqM1r2BAyHekzVEf5H
         qsfCTHjQIJvzIma3MnSMn7ejPPapbuwcdR0ntPQwCHhwrpJyeo5Ni5sMy8lU+rBxPRXp
         HiXm5szRsB0p/amy5WeyY4y61NGUvQ26aElrUas6JNaGvpaOZCacFJSPhJazxy8h3zdd
         kqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679979364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr6fqdp6bviKxq26fqY3VfiJLpmiTmRcnKqOZtEa3+g=;
        b=5GMfF1aKOVekfeY4C5bnNSYGeFPMsDL8hde5+zK3X4qs9KGPveCJAzGfxOTivjBhzC
         4Waq/+eLmZiWSunUmu22orTJZS34MyAGI3DsP4E3ZHU7q0oRikTRZZjFGStyJU8fFz+e
         OS3IcZAoqHeFoCBIPlvSi6jGYja3g8CtmTG5s0vGfjFbEI1dsVaNmINGJxYJFYOt/mwW
         0m08xxzCx81l1JR9JL6IHst9PuQCXQbpmIi6WNEG2Z/Huw4Sddtiq0YPlWWL12Id0uxm
         4+J8icdsEvJDMG5pVvwKRnT4gCkBlKwAF97sPZqvX2NIbHyJ6B6TBzqqL4oAppIOdF/t
         cALA==
X-Gm-Message-State: AAQBX9drYJuT5vorZaQWZMM1AKa+CbyNs//Xz4kh2cm/ELj6MENkvKQ8
        7kTtB7Gp4C2bYUTH5+Rx4IOvGFk79zQ=
X-Google-Smtp-Source: AKy350bgTvEy1V+jKmxIU1m1QAH50jLRQ4YKe3K/rTiSc4qy+OmPKYq0+VrvT8ZBG6BCqM/R5L8S6SpAfDI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e054:0:b0:b6b:d3f3:45af with SMTP id
 x81-20020a25e054000000b00b6bd3f345afmr9145968ybg.1.1679979364091; Mon, 27 Mar
 2023 21:56:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 21:56:02 -0700
In-Reply-To: <20230324205249.3700408-2-paulmck@kernel.org>
Mime-Version: 1.0
References: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop> <20230324205249.3700408-2-paulmck@kernel.org>
Message-ID: <ZCJzYktdNRZmQjhl@google.com>
Subject: Re: [PATCH rcu v3 2/4] kvm: Remove "select SRCU"
From:   Sean Christopherson <seanjc@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements from the various KVM Kconfig files.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <kvm@vger.kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org> (arm64)
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Anup Patel <anup@brainfault.org> (riscv)
> Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---

As amusing at it would be to see KVM as the lone holdout,

Acked-by: Sean Christopherson <seanjc@google.com> (x86)


Paul, feel free to take this through your tree if you think that would be the
fastest way to purge the config.  Holler if you want to route it through KVM, I'll
either throw it kvm-x86/generic, or rewatch Beetlejuice and try to summon Paolo
that way. ;-)
