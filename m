Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FF689DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjBCPRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjBCPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:16:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEE2597D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/XkJiKlEWWoxLdEEsPBWBw4sqM/MAfZZl4oCuwfXEPc=; b=MSuXBYtjj9seQyEcKOTiaBkUhD
        E5BVRMGjurMC6MMx0SdyUM0gAc7giXPCZBimXAd8ZvN4N78FcUvpPkoWce0giYUMK2KpOsltR1NRD
        6Cs3tiCRXrRQyPP4WZFkJ4YFPaqzkDub8jJxeTmgFGwPsth6BBy6gP/ITl+B/EsYA8nyyIgcN7sZi
        GWM24ZtHh0qRXPFpmx72qloPrwrMTUm/eoc3PoJorfjnweblawAFKYf/Evxf3MEDF1CXbKPX9KXtK
        xqkK8twfis9nEdoekWlX0SmLGQ8TartZGKoiNqw7rPNcksA4INFnQuG6MBC995n3rVjhqwCMvdPUp
        YT2n8Sow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxjT-00EOqj-IH; Fri, 03 Feb 2023 15:12:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09EB3300129;
        Fri,  3 Feb 2023 16:12:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1BD72C14E62F; Fri,  3 Feb 2023 16:12:06 +0100 (CET)
Date:   Fri, 3 Feb 2023 16:12:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86/alternative: Support relocations in alternatives
Message-ID: <Y90kRtZA0d8nsRRj@hirez.programming.kicks-ass.net>
References: <Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net>
 <Y90IaYHDbCN9P0OX@zn.tnic>
 <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90ilxBFMAQZ/dRg@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:04:55PM +0100, Peter Zijlstra wrote:

> > > +		switch (insn.opcode.bytes[0]) {
> > > +		case 0x0f:
> > > +			if (insn.opcode.bytes[1] < 0x80 ||
> > > +			    insn.opcode.bytes[1] > 0x8f)
> > > +				break;
> > > +
> > > +			fallthrough;	/* Jcc.d32 */
> > > +		case 0x70 ... 0x7f:	/* Jcc.d8 */
> > > +		case JMP8_INSN_OPCODE:
> > > +		case JMP32_INSN_OPCODE:
> > > +		case CALL_INSN_OPCODE:
> > > +			u8 *target = src + i + insn.length + insn.immediate.value;
> > > +			if (target < src || target > src + src_len) {
> > > +				apply_reloc(insn.immediate.nbytes,
> > > +					    instr + i + insn_offset_immediate(&insn),
> > > +					    src - dest);
> > > +			}
> > 
> > Uff, it took me a while to parse this. So this can be simpler. The basic
> > math is:
> > 
> > 	new_offset = next_rip - target_address;
> > 
> > where
> > 	next_rip = instr + insn.length;
> > 
> > and I admit that my function was a bit clumsy but I think yours can be
> > made simpler while keeping it cleaner.
> 
> I'm not sure what you're saying here... so let me walk through the whole
> thing (specifically the immediate case, since that's what you quote). So
> what we need is:
> 
> 	src_imm = target - src_next_ip			(1)
> 
> what we want is:
> 
> 	dst_imm = target - dst_next_ip			(2)
> 
> so what we do is rework (1) as an expression for target like:
> 
> 	target = src_imm + src_next_ip			(1a)
> 
> and substitute in (2) to get:
> 
> 	dst_imm = (src_imm + src_next_ip) - dst_next_ip	(3)
> 
> Now, since the instruction stream is 'identical' at src and dest
> we can state that:
> 
> 	src_next_ip = src + ip_offset
> 	dst_next_ip = dst + ip_offset			(4)
> 
> Substitute (4) in (3) and observe ip_offset being cancelled out to
> obtain:
> 
> 	dst_imm = src_imm + (src + ip_offset) - (dst + ip_offset)
> 	        = src_imm + src - dst + ip_offset - ip_offset
> 	        = src_imm + src - dst			(5)
> 
> The very thing I did.
> 
> IOW, we can correct the displacement without caring about which actual
> instruction in the stream we're correcting since the relative offset is
> given by 'src - dst'. IOW, we don't give a crap about insn.length in
> this case ;-)

Specifically, in the above case ip_offset would be given by:

	ip_offset = i + insn.length

where i is the offset in the buffer to the current instruction and
insn.length is well, the length of the current instruction ;-)
