Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A165CE63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjADIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjADIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:34:31 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA11A066
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:34:30 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nn2q72YyDzJpwR;
        Wed,  4 Jan 2023 16:30:27 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:34:26 +0800
Message-ID: <c5bdf7af-112e-e92c-7df0-8bc8a652bcd8@huawei.com>
Date:   Wed, 4 Jan 2023 16:34:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/9] riscv/kprobe: Prepare the skeleton to implement
 RISCV OPTPROBES feature
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-2-chenguokai17@mails.ucas.ac.cn>
 <87wn64vmoq.fsf@all.your.base.are.belong.to.us>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <87wn64vmoq.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/3 2:03, Björn Töpel 写道:
> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
> 
>> From: Liao Chang <liaochang1@huawei.com>
>>
>> Prepare skeleton to implement optimized kprobe on RISCV, it is consist
>> of Makfile, Kconfig and some architecture specific files: kprobe.h and
>> opt.c opt.c include some macro, type definition and functions required
>> by kprobe framework, opt_trampoline.S provide a piece of assembly code
>> template used to construct the detour buffer as the target of long jump
>> instruction(s) for each optimzed kprobe.
> 
> This is pretty much just reiterating what diff-stat says. Please try to
> explain why a certain change is done, instead of what. What is already
> in the patch.

Thanks for your suggestion, i will explain further in next revision.

> 
>> Since the jump range of PC-relative instruction JAL is +/-2M, that is
>> too small to reach the detour buffer, hence the foudamental idea to
>> address OPTPROBES on RISCV is replace 'EBREAK' with 'AUIPC/JALR'. which
>> means it needs to clobber one more instruction beside the kprobe
>> instruction, furthermore, RISCV supports hybird RVI and RVC in single
>> kernel binary, so in theory a pair of 'AUIPC/JALR' is about to clobber
>> 10 bytes(3 RVC and 1 RVI, 2 bytes is padding for alignment) at worst
>> case. The second hardsome problem is looking for one integer register as
>> the destination of 'AUIPC/JALR' without any side-effect.
> 
> There are a number of spelling errors, please use a spellchecker and if
> you reference a file (e.g. Makefile), make sure it is correctly spelled
> out.
> 
> The comments above applies to all the commit messages of this series.

Thanks for reviewing, i will correct these spelling errors.

> 
> 
> Björn

-- 
BR,
Liao, Chang
