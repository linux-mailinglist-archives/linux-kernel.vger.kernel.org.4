Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC728F18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjFIEre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFIErb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:47:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD69330ED;
        Thu,  8 Jun 2023 21:47:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BEFAB6;
        Thu,  8 Jun 2023 21:48:14 -0700 (PDT)
Received: from [10.163.44.201] (unknown [10.163.44.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22F53F587;
        Thu,  8 Jun 2023 21:47:23 -0700 (PDT)
Message-ID: <cd1d272b-4794-d0d8-af43-aba4b7484b22@arm.com>
Date:   Fri, 9 Jun 2023 10:17:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
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
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 19:13, Mark Rutland wrote:
>> +/*
>> + * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
>> + * preceding consecutive branch records, that were in a transaction
>> + * (i.e their BRBINFx_EL1.TX set) have been aborted.
>> + *
>> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
>> + * consecutive branch records up to the last record, which were in a
>> + * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
>> + *
>> + * --------------------------------- -------------------
>> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
>> + * --------------------------------- -------------------
>> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
>> + * --------------------------------- -------------------
>> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
>> + * --------------------------------- -------------------
>> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>> + * --------------------------------- -------------------
>> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>> + * --------------------------------- -------------------
>> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
>> + * --------------------------------- -------------------
>> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
>> + * --------------------------------- -------------------
>> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>> + * --------------------------------- -------------------
>> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>> + * --------------------------------- -------------------
>> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
>> + * --------------------------------- -------------------
>> + *
>> + * BRBFCR_EL1.LASTFAILED == 1
>> + *
>> + * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
>> + * branches records near the end of the BRBE buffer.
>> + *
>> + * Architecture does not guarantee a non transaction (TX = 0) branch
>> + * record between two different transactions. So it is possible that
>> + * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
>> + * mark more than required transactions as aborted.
>> + */
> Linux doesn't currently support TME (and IIUC no-one has built it), so can't we
> delete the transaction handling for now? We can add a comment with somehing like:
> 
> /*
>  * TODO: add transaction handling for TME.
>  */
> 
> Assuming no-one has built TME, we might also be able to get an architectural
> fix to disambiguate the boundary between two transactions, and avoid the
> problem described above.
> 
> [...]
> 

OR can leave this unchanged for now. Then update it if and when the relevant
architectural fix comes in. The current TME branch records handling here, is
as per the current architectural specification.
