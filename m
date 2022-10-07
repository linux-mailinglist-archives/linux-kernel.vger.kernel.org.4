Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158695F7DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJGTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJGTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:24:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC7895E6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PbGi9qswumamHM20nhxfQsLsToNlE1XdvdzMw825Asw=; b=n1HjNK6j+ySYzF0jmf7hO08NC6
        OZUkag0tS3c3NjWrqvAJKTbVw1SCFuEtdDXbwtTrFQgK0BDvpJ0STHMrTVcr8tB5b3ovRBYS2EAmf
        6ZEXdP+sATJnNdJ/iy3gRHgaG8KiRglDjRjXzasN8IUjqGHMKKDxpVPd94alBPAQwl0DsuhUZQ7V6
        fZo2Tpsrh99lOipo4ImRJk/Y/p7RN+o1RPLuP6pLkSHVWwzeXCBsWUXA1xcVGNxKrh/fk62aaNFJc
        bH7RlPi8CGLhInNP4Uhd2mDDpWzQgiO9QaOF6loDfbege6tm5tqx4DMbzEbX3bNHj4aw7ec7prxdq
        mHV78J6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogsxG-00284U-CC; Fri, 07 Oct 2022 19:24:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AD92300205;
        Fri,  7 Oct 2022 21:24:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 645C92C0F480E; Fri,  7 Oct 2022 21:24:13 +0200 (CEST)
Date:   Fri, 7 Oct 2022 21:24:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 06:01:06PM +0000, Li, Xin3 wrote:
> > > +	alternative_io("1: call asm_load_gs_index\n"
> > > +		       ".pushsection \".fixup\",\"ax\"\n"
> > > +		       "2:	xorl %k[sel], %k[sel]\n"
> > > +		       "	jmp 1b\n"
> > > +		       ".popsection\n"
> > > +		       _ASM_EXTABLE(1b, 2b),
> > > +		       _ASM_BYTES(0x3e) LKGS_DI,
> > > +		       X86_FEATURE_LKGS,
> > > +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> > > +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
> > >  }
> > 
> > I'm very sure none of this was tested... the .fixup section hasn't existed for
> > almost a year now.
> 
> Weird, did you ever check a kernel dump?

$ readelf -WS defconfig-build/vmlinux | grep fixup
[ 5] .pci_fixup        PROGBITS        ffffffff826a5350 18a5350 003570 00   A  0   0 16
[ 6] .rela.pci_fixup   RELA            0000000000000000 360c388 005028 18   I 60   5  8

In fact, when I add one I get:

ld: warning: orphan section `.fixup' from `arch/x86/kernel/traps.o' being placed in section `.fixup'
