Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79084637E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKXRUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:20:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA9442FD;
        Thu, 24 Nov 2022 09:20:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C272CB8289C;
        Thu, 24 Nov 2022 17:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAC8C433D6;
        Thu, 24 Nov 2022 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669310442;
        bh=JB9qZrrqFpGk0H4HPOvs80vQdLVw7i9EscGuUefH0pw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Te3QID+ipAkEEoYZvSJdkNSnHQLGbt/iXdSeIexqtPiAqge3n6lTbM2ez8F36oWo9
         DAUB8gGiDWzKTPCw0LKE+8IdQtJyYPR6F4WuWze3SACJkk0tzk86X5ZsDiauQpwqD4
         kbVAnWlfJUU1+YXSkluKcG2D/8z+wjQFa/jh0RRk28slpFQxcvIGPkl9Hu8pTVbnmy
         lUUyeN4W5MdWVUjGFCqsbj7nRB3JgOQNheBDhTtitp0a/jGv4gVkpLwtlfFc4Nkgci
         siyIVR5zSFU//GHaxH4ABmzrZZAQ24Z4jhfbypnJ6L23LyTmmLVlYaT6okfkTh2/AW
         R7wakXTCE3pWw==
Message-ID: <c9ae9644-5cd0-29c2-a25c-bb497dfcb1c8@kernel.org>
Date:   Thu, 24 Nov 2022 17:20:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
References: <YqYz+xDsXr/tNaNu@Sun> <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer> <Y39AXYPFzSiBngwI@wendy>
 <Y39Lwp4rQc3Qkl0i@vermeer> <Y39blUaC/jHiOYCk@wendy>
 <Y3+mBAV8oxphjHcJ@vermeer>
Content-Language: en-US
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <Y3+mBAV8oxphjHcJ@vermeer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 17:12, Samuel Ortiz wrote:
> [You don't often get email from sameo@rivosinc.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Nov 24, 2022 at 11:55:01AM +0000, Conor Dooley wrote:
>> On Thu, Nov 24, 2022 at 11:47:30AM +0100, Samuel Ortiz wrote:
>>
>>> Patch #1 is definitely needed regardless of which interface we pick for
>>> exposing the ISA strings to userspace.
>>
>> I took another look at #1, and I feel more confused about what
>> constitutes canonical order than I did before! If you know better than
>> I, and you probably do since you're interested in these 6 month old
>> patches, some insight would be appreciated!
> 
> Assuming we don't go with hwcap, I dont think the order of the
> riscv_isa_ext_id enum matters that much?

The chief put it in canonical order so that's good enough for me!

> 
> iiuc we're building the cpuinfo string from the riscv_isa_ext_data
> array, and I think the current code is incorrect:
> 
> static struct riscv_isa_ext_data isa_ext_arr[] = {
>     __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>     __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>     __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>     __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>     __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>     __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> };
> 
> zicbom and zihintpause should come before supervisor level extensions.
> I'm going to send a patch for that.

idk, Palmer explicitly re-ordered this:
https://lore.kernel.org/linux-riscv/20220920204518.10988-1-palmer@rivosinc.com/

By my reading of the isa manual, what Palmer did is correct as
those are not "Additional Standard Extensions". /shrug

> 
> And the Zb/Zk ones should come after the Zi ones, and before the
> supervisor level ones (The I category comes before the B or the K one).

This I agree with though.

