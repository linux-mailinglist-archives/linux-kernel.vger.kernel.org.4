Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC2729A30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjFIMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFIMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:42:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3AF210A;
        Fri,  9 Jun 2023 05:42:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B61AB6;
        Fri,  9 Jun 2023 05:43:24 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D34D3F6C4;
        Fri,  9 Jun 2023 05:42:37 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:42:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Message-ID: <ZIMeOt6XdhjPdXHC@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
 <cd1d272b-4794-d0d8-af43-aba4b7484b22@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1d272b-4794-d0d8-af43-aba4b7484b22@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:17:19AM +0530, Anshuman Khandual wrote:
> On 6/5/23 19:13, Mark Rutland wrote:
> >> +/*
> >> + * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
> >> + * preceding consecutive branch records, that were in a transaction
> >> + * (i.e their BRBINFx_EL1.TX set) have been aborted.
> >> + *
> >> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
> >> + * consecutive branch records up to the last record, which were in a
> >> + * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
> >> + *
> >> + * --------------------------------- -------------------
> >> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> >> + * --------------------------------- -------------------
> >> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> >> + * --------------------------------- -------------------
> >> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> >> + * --------------------------------- -------------------
> >> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
> >> + * --------------------------------- -------------------
> >> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> >> + * --------------------------------- -------------------
> >> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + *
> >> + * BRBFCR_EL1.LASTFAILED == 1
> >> + *
> >> + * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
> >> + * branches records near the end of the BRBE buffer.
> >> + *
> >> + * Architecture does not guarantee a non transaction (TX = 0) branch
> >> + * record between two different transactions. So it is possible that
> >> + * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
> >> + * mark more than required transactions as aborted.
> >> + */
> > Linux doesn't currently support TME (and IIUC no-one has built it), so can't we
> > delete the transaction handling for now? We can add a comment with somehing like:
> > 
> > /*
> >  * TODO: add transaction handling for TME.
> >  */
> > 
> > Assuming no-one has built TME, we might also be able to get an architectural
> > fix to disambiguate the boundary between two transactions, and avoid the
> > problem described above.
> > 
> > [...]
> > 
> 
> OR can leave this unchanged for now. Then update it if and when the relevant
> architectural fix comes in. The current TME branch records handling here, is
> as per the current architectural specification.

My rationale for deleting it is that it cannot be used and cannot be tested,
since the kernel doesn't support TME, and there are no TME implementations out
there. If and when we support TME in the kernel, this is very likely to have
bit-rotted.

I'd be happy to link to the current version, e.g.

/*
 * TODO: add transaction handling for FEAT_TME. See:
 *
 * https://lore.kernel.org/linux-arm-kernel/20230531040428.501523-7-anshuman.khandual@arm.com/
 */

I do appreciate that time and effort has gone into writing this, but IMO it's
more distracting than helpful at present, and deleting it makes this easier to
review and maintain.

Thanks,
Mark.
