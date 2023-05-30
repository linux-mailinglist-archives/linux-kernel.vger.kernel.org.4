Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2174A716A28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjE3Q4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjE3Q4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:56:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F7098
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:56:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5340957a1f1so2608336a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685465796; x=1688057796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUIF7qczhJfL0tzqN+Wk4Y8s0fyjf+/encaeJ8i8zo8=;
        b=RbEfFAAf2kcBOjvt74s5UVZKgWrUGFDUy+sd7fobbo+fCQD0px8ov63e8OeZXSJ8fh
         HG4hHegtTrDVP700YjLnXteCxE6guE54Vbd8zH/t2rCli4QSiy5tmFSofJYIZgEMn1zj
         Qsp4LrQqCDZwVqc25d9x6Ot8kXQSMfXIZ9gqaurkMyf4wf+UYa4w1aAbMwazKXlrtuiS
         Kk616ydOwBRsdeEiUal2WEabr5ltpvlk9LlkPPxhELMLDRXHyhZJZ3Til0KRYe81otj+
         tS/p/kiytx6/XARdF4p/h7eKZckIQCkqvbC4w6UMN19z2FxazUFpiFD2Hr1ZsYeU6F4t
         XCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465796; x=1688057796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUIF7qczhJfL0tzqN+Wk4Y8s0fyjf+/encaeJ8i8zo8=;
        b=ejBr37nho4eRmfAtEYEP4qw4ZQaDH0QWV3DQf4IQyfA4ssbBuZcsZeTB5vyt4s+9qN
         tzMxIZjq/ry5j3DjzuUnVLAV58Eabi116k+u85EGrpiQRjTfYUMZYIwccguvA6ON5IB5
         N4jOnHzMO90njc9U1JHJy30ROnWrahzJ7HAkAY+uj0x9Ze3MkzbF9N2fOaBKrS0nTbWb
         zNkKyFMpM2jgf3kFMH1OQasyyhegg/TSsJabLC97oYgU9iVKBbdUQS82FrMz6d+RXr7g
         TIqvb7hGPgrpQwN8zYyCEHqrkAkHe+yoLSp3jCUi3FNdLyIjuSzzD++cTL588Lc7dQT4
         OjmA==
X-Gm-Message-State: AC+VfDzVRMVTTUui7KqKqjwd26qVeRIspm9xL6E/wuhB4ZtYdZmktnzm
        8o3imV89Q4jd7GojOV0yAmfsZDHmSjc=
X-Google-Smtp-Source: ACHHUZ6elIb9Xawt5kHr4iARsASD1eAmXyJrU7yMOnucjGsQDVEv6w8ENbA+wCa+rqHlmqnxd6WixqOcZs8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:512:0:b0:52c:9e55:61ee with SMTP id
 18-20020a630512000000b0052c9e5561eemr545525pgf.3.1685465795799; Tue, 30 May
 2023 09:56:35 -0700 (PDT)
Date:   Tue, 30 May 2023 09:56:34 -0700
In-Reply-To: <87wn0pizbl.ffs@tglx>
Mime-Version: 1.0
References: <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx> <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
 <87wn0pizbl.ffs@tglx>
Message-ID: <ZHYqwsCURnrFdsVm@google.com>
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 15:29, Kirill A. Shutemov wrote:
> > On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
> >> The decision to allow parallel bringup of secondary CPUs checks
> >> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
> >> parallel bootup because accessing the local APIC is intercepted and raises
> >> a #VC or #VE, which cannot be handled at that point.
> >> 
> >> The check works correctly, but only for AMD encrypted guests. TDX does not
> >> set that flag.
> >> 
> >> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
> >> definitely works for both AMD and Intel.
> >
> > It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
> > report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
> > we want it.
> 
> Right. Did not think about that.
> 
> But the same way is CC_ATTR_GUEST_MEM_ENCRYPT overbroad for AMD. Only
> SEV-ES traps RDMSR if I'm understandig that maze correctly.

Ya, regular SEV doesn't encrypt register state.
