Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78A5B67DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiIMGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiIMGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:24:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 226C010A3;
        Mon, 12 Sep 2022 23:24:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16300106F;
        Mon, 12 Sep 2022 23:24:22 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7A853F73B;
        Mon, 12 Sep 2022 23:24:39 -0700 (PDT)
Message-ID: <95599654-a302-dd64-e1c8-4d9a723aed85@arm.com>
Date:   Tue, 13 Sep 2022 11:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/7] arm64/perf: Add register definitions for BRBE
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-2-anshuman.khandual@arm.com>
 <Yx8Cgzr7lQdMLX+P@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yx8Cgzr7lQdMLX+P@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/22 15:27, Mark Brown wrote:
> On Thu, Sep 08, 2022 at 10:40:40AM +0530, Anshuman Khandual wrote:
> 
>> ---
>>  arch/arm64/include/asm/sysreg.h | 222 ++++++++++++++++++++++++++++++++
>>  1 file changed, 222 insertions(+)
> 
> Rather than manually encoding register definitions in sysreg.h
> can we add them to arch/arm64/tools/sysreg so that all the
> #defines and so on are generated instead?

SYS_[BRBINF<N>|BRBSRC<N>|BRBTGT<N>]_EL1 registers are encoded as per three
distinct formulas where <CRm> and <op2> are derived from corresponding <N>
Just wondering if those could be accommodated in arch/arm64/tools/sysreg ?

System register description via arch/arm64/tools/sysreg seems bit cryptic.
BTW, do we expect all existing sysreg definitions to move there ? Because
still there are many registers and their fields present in sysreg.h

Besides, there is also some benefit in being able to grep system registers
and their fields, across headers and implementations simultaneously.
