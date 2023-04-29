Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173D6F2546
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjD2Puj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjD2Puh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:50:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21216172E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9MoJ5vqmY7ZcHuzhtIscAaGqFGZsUmtdzPkpDpfV7Ao=; b=sWtNUzYpQCIm3Ejt8i3//NXIoz
        zF2QOtM8Cryg4txZvmCdc8WWLATS5jUuoDolVoXPA3zW5+cTgShV2UCHHXc/Wf9cooMrSvGFOpHel
        YctaLgXVA6IF0KKh6yHP3iOmMMXBMl5j4Jry5lju/s7cHnPptl+TIeZLNmB6MfCTj5b8JTkrDNZWL
        kCMqc3y8Dt9GMGNp7D3k6IMJLHVVsJ/r13QK1f+kN6E2RxaraWgqe9/5JzjgApIJa4jfq+HhXIAg9
        wWywo1J3oeI3om0Xjv+dapwSMfsaABgPKoa4D4RT2faqHgooRtJIUsoAN8518OI/hQlpDNmVksgTA
        BCKeJ4EA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psmqH-00CrnQ-2c;
        Sat, 29 Apr 2023 15:50:33 +0000
Message-ID: <18779686-4e3a-c0a7-0e76-5bf1d151d2e2@infradead.org>
Date:   Sat, 29 Apr 2023 08:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] riscv: fix sifive and thead section mismatches in errata
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Evan Green <evan@rivosinc.com>
References: <20230429043530.20503-1-rdunlap@infradead.org>
 <20230429-exclusion-specimen-f47b03c6d859@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230429-exclusion-specimen-f47b03c6d859@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/23 02:50, Conor Dooley wrote:
> On Fri, Apr 28, 2023 at 09:35:30PM -0700, Randy Dunlap wrote:
>> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
>> CONFIG_MODULES is not set, __init_or_module becomes __init.
>> In the latter case, it causes section mismatch warnings:
>>
>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.text)
>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text)
>>
>> It appears that CONFIG_MODULES not set is not tested very much.
> 
> I dunno if it the testing is *that* rare, because I'm not sure that the
> fixes tags below are correct. I think that it is actually:
> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_features()")
> That was only applied on 20/04.

Yeah, that Fixes: commit looks like the right one.
I'll send a v2.

Thanks.

> 
>> Fixes: a8e910168bba ("riscv: implement module alternatives")
>> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> ---
>>  arch/riscv/errata/sifive/errata.c |    8 +++-----
>>  arch/riscv/errata/thead/errata.c  |    6 +++---
>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>

-- 
~Randy
