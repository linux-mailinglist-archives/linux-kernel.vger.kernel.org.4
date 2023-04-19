Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D396E8049
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDSRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjDSRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:24:30 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192365B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681925065; bh=UyddDLaSnHim8LvLfZeMZsuxwKd9NlUs6I+vTPaquA8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=x4QuBhvrOVumU6lfmBATy7YcNq7Tt4ewJHbz9/HPgMIR6VUWSNmzp8NjZKD+QTkD/
         +6G3U0woQCjF0LaMUeejFEfk+8s4aLN18oAOl5tUla9wfOJYvZ2R3pTzjzJArE6rui
         njab+fTPihLz2H19NWoSu5CX4yep5VFHIzeHSeGI=
Received: from [192.168.9.172] (unknown [101.228.138.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3460D6011C;
        Thu, 20 Apr 2023 01:24:25 +0800 (CST)
Message-ID: <48bc7236-638d-9086-daaf-62eacea80dd2@xen0n.name>
Date:   Thu, 20 Apr 2023 01:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
To:     Xi Ruoyao <xry111@xry111.site>, Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230418091348.9239-1-zhangqing@loongson.cn>
 <a7fa32c3af68083855e7690f67824d060d5c6135.camel@xry111.site>
 <899085c1-7a74-8bab-1429-1b6e9e4c2c30@xen0n.name>
In-Reply-To: <899085c1-7a74-8bab-1429-1b6e9e4c2c30@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 19:00, WANG Xuerui wrote:
> On 2023/4/19 18:42, Xi Ruoyao wrote:
>> On Tue, 2023-04-18 at 17:13 +0800, Qing Zhang wrote:
>>> This is done in order to easily calculate the number of breakpoints
>>> in hw_break_get.
>>>
>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>> ---
>>>   arch/loongarch/include/uapi/asm/ptrace.h |  3 ++-
>>>   arch/loongarch/kernel/ptrace.c           | 13 +++++++++----
>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/loongarch/include/uapi/asm/ptrace.h
>>> b/arch/loongarch/include/uapi/asm/ptrace.h
>>> index 2282ae1fd3b6..06e3be52cb04 100644
>>> --- a/arch/loongarch/include/uapi/asm/ptrace.h
>>> +++ b/arch/loongarch/include/uapi/asm/ptrace.h
>>> @@ -57,11 +57,12 @@ struct user_lasx_state {
>
> Drive-by comment to the patch author: there is no "user_lasx_state" 
> yet. Please always state your base commit if not obvious, or you 
> should start from some well-known upstream HEAD (e.g. Linus' rc tags, 
> loongarch-fixes, or loongarch-next).
>
>>>   };
>>>     struct user_watch_state {
>>> -       uint16_t dbg_info;
>>> +       uint64_t dbg_info;
>>
>> Ouch.  This is a breaking change when we consider user code like
>> `printf(PRIu16 "\n", ptr->dbg_info);`.  Is it really necessary?
>
> Ah right. This is UAPI so without *very* concrete and convicing reason 
> why the change is not going to impact any potential users, it's gonna 
> be a presumed NAK. In other words you must demonstrate (1) why it's 
> absolutely necessary to make the change and (2) that it's impossible 
> to impact anyone, before any such changes can even be considered.
Please ignore all of this. The memory layout is actually the same after 
the change due to the padding, I was somehow thinking in big-endian a 
few hours ago. (The commit message didn't help either, I think both 
Ruoyao and me got into the habitual thinking that changes like this are 
most likely just churn without real benefits, after *not* seeing the 
rationale in the commit message which was kinda expected.)
>
>>
>>>          struct {
>>>                  uint64_t    addr;
>>>                  uint64_t    mask;
>>>                  uint32_t    ctrl;
>>> +               uint32_t    pad;
>>>          } dbg_regs[8];
>>>   };
>>>   diff --git a/arch/loongarch/kernel/ptrace.c
>>> b/arch/loongarch/kernel/ptrace.c
>>> index 0c7c41e41cad..9c3bc1bbf2ff 100644
>>> --- a/arch/loongarch/kernel/ptrace.c
>>> +++ b/arch/loongarch/kernel/ptrace.c
>>> @@ -475,10 +475,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned
>>> int note_type,
>>>          return 0;
>>>   }
>>>   -static int ptrace_hbp_get_resource_info(unsigned int note_type, u16
>>> *info)
>>> +static int ptrace_hbp_get_resource_info(unsigned int note_type, u64
>>> *info)
>>>   {
>>>          u8 num;
>>> -       u16 reg = 0;
>>> +       u64 reg = 0;
>>>            switch (note_type) {
>>>          case NT_LOONGARCH_HW_BREAK:
>>> @@ -616,7 +616,7 @@ static int hw_break_get(struct task_struct
>>> *target,
>>>                          const struct user_regset *regset,
>>>                          struct membuf to)
>>>   {
>>> -       u16 info;
>>> +       u64 info;
>>>          u32 ctrl;
>>>          u64 addr, mask;
>>>          int ret, idx = 0;
>>> @@ -646,6 +646,7 @@ static int hw_break_get(struct task_struct
>>> *target,
>>>                  membuf_store(&to, addr);
>>>                  membuf_store(&to, mask);
>>>                  membuf_store(&to, ctrl);
>>> +               membuf_zero(&to, sizeof(u32));
>>>                  idx++;
>>>          }
>>>   @@ -662,7 +663,7 @@ static int hw_break_set(struct task_struct
>>> *target,
>>>          int ret, idx = 0, offset, limit;
>>>          unsigned int note_type = regset->core_note_type;
>>>   -       /* Resource info */
>>> +       /* Resource info and pad */
>>>          offset = offsetof(struct user_watch_state, dbg_regs);
>>>          user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0,
>>> offset);
>>>   @@ -704,6 +705,10 @@ static int hw_break_set(struct task_struct
>>> *target,
>>>                  if (ret)
>>>                          return ret;
>>>                  offset += PTRACE_HBP_CTRL_SZ;
>>> +
>>> +               user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
>>> +                                         offset, offset +
>>> PTRACE_HBP_PAD_SZ);
>>> +               offset += PTRACE_HBP_PAD_SZ;
>>>                  idx++;
>>>          }
>>
>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

