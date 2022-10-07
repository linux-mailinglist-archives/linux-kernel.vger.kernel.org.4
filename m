Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000A5F7EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJGUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:23:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0109AA377
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aks1dZGTodUV2dfvpsgaj5WVgEEHrocb8tLpo0QMpGA=; b=gRb0SFmPivD0ONoUqsL8KSHIyc
        ISxshrhY9/7nGao4vqf7Xs/FXf1CKAs9SnCJotfED1XsJ5mYQ0SxtLNOZQkd+QBCj3Evk7G7FzLZh
        br5mCIDPonR7en/3Y6oqt07ebHaDl1DZ8cIQ+JBjjxaS87BPU0jG5MqttPocy7dmkK9XIfZypQJY1
        wYHoTrjuv8wwUlOEwPpuDKtF4tsg9sk5SaDKO1VmB7VNUB1TF9m1jJFL+n3fVWbazxT9TT78CSXYi
        X6IKcUOu5RSknld9udiTY3fgv0PdJQVXvI1LuNg/yFfEtjskfnJyHPIfi5191bLSpdhcE4DYJI9bA
        I786gGVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogtsq-002ApD-0D; Fri, 07 Oct 2022 20:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59CCD300137;
        Fri,  7 Oct 2022 22:23:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4187B2C12B12D; Fri,  7 Oct 2022 22:23:43 +0200 (CEST)
Date:   Fri, 7 Oct 2022 22:23:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
 <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:03:12PM -0700, H. Peter Anvin wrote:
> On October 7, 2022 12:24:13 PM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Fri, Oct 07, 2022 at 06:01:06PM +0000, Li, Xin3 wrote:
> >> > > +	alternative_io("1: call asm_load_gs_index\n"
> >> > > +		       ".pushsection \".fixup\",\"ax\"\n"
> >> > > +		       "2:	xorl %k[sel], %k[sel]\n"
> >> > > +		       "	jmp 1b\n"
> >> > > +		       ".popsection\n"
> >> > > +		       _ASM_EXTABLE(1b, 2b),
> >> > > +		       _ASM_BYTES(0x3e) LKGS_DI,
> >> > > +		       X86_FEATURE_LKGS,
> >> > > +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> >> > > +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
> >> > >  }
> >> > 
> >> > I'm very sure none of this was tested... the .fixup section hasn't existed for
> >> > almost a year now.
> >> 
> >> Weird, did you ever check a kernel dump?
> >
> >$ readelf -WS defconfig-build/vmlinux | grep fixup
> >[ 5] .pci_fixup        PROGBITS        ffffffff826a5350 18a5350 003570 00   A  0   0 16
> >[ 6] .rela.pci_fixup   RELA            0000000000000000 360c388 005028 18   I 60   5  8
> >
> >In fact, when I add one I get:
> >
> >ld: warning: orphan section `.fixup' from `arch/x86/kernel/traps.o' being placed in section `.fixup'
> 
> Perhaps the two of you need to compare confugurations?

Whatever for? I know the robots report this warning because there was
one from the KVM cross-merge when the .fixup removal went in. It got
reported and fixed and that was the last of it.

Anyway; try:

  $ git grep "\.fixup" arch/x86/

there isn't a single usage.

Andrew Cooper suggested upgrading the orphan section warning to a hard
link error, orphan sections are bad regardless.

