Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D119714A74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjE2Nfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjE2Nfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:35:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10578E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:35:50 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVGdC5ZzszqTQX;
        Mon, 29 May 2023 21:31:11 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 21:35:48 +0800
Message-ID: <e852e15b-88f3-ae15-2ffd-ee2e5ffa9bdf@hisilicon.com>
Date:   Mon, 29 May 2023 21:35:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [Question about gic vmovp cmd] Consider adding VINVALL after
 VMOVP
To:     Marc Zyngier <maz@kernel.org>
References: <ba387464-59d5-0639-1d05-84bb7e764231@hisilicon.com>
 <87v8gfo9rg.wl-maz@kernel.org>
 <7f07c54fb0a4448fbccce0f97cb5e512@hisilicon.com>
 <ec4cba70-ba6f-2de6-29e8-945b0f52ed88@hisilicon.com>
 <86leh9di4l.wl-maz@kernel.org>
 <f1f7296dc4fa429d97f7a48c8c4552ae@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>
From:   wangwudi <wangwudi@hisilicon.com>
In-Reply-To: <f1f7296dc4fa429d97f7a48c8c4552ae@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/29 21:24, wangwudi 写道:
> 
> 
> -----邮件原件-----
> 发件人: Marc Zyngier [mailto:maz@kernel.org] 
> 发送时间: 2023年5月27日 21:22
> 收件人: wangwudi <wangwudi@hisilicon.com>
> 抄送: linux-kernel@vger.kernel.org
> 主题: Re: [Question about gic vmovp cmd] Consider adding VINVALL after VMOVP
> 
> On Sat, 27 May 2023 10:51:50 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
>>
>>
>>
>> 在 2023/5/27 16:56, wangwudi 写道:
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Marc Zyngier [mailto:maz@kernel.org]
>>> 发送时间: 2023年5月26日 15:03
>>> 收件人: wangwudi <wangwudi@hisilicon.com>
>>> 抄送: linux-kernel@vger.kernel.org
>>> 主题: Re: [Question about gic vmovp cmd] Consider adding VINVALL after 
>>> VMOVP
>>>
>>> On Fri, 26 May 2023 07:04:34 +0100,
>>> wangwudi <wangwudi@hisilicon.com> wrote:
>>>>
>>>> Hi Marc,
>>>>
>>>> During vpe migration, VMOVP needs to be executed.
>>>> If the vpe is migrated for the first time, especially before it is 
>>>> scheduled for the first time, there may be some unusual hanppens 
>>>> over kexec.
>>>
>>> What may happen?
>>
>> Actually, I'm not sure.
> 
> Then what is that all for?
> 
>>
>>>
>>>> We might consider adding a VINVALL cmd after VMOVP to increase 
>>>> robustness.
>>>
>>> What are you trying to guarantee by adding this? From a performance 
>>> perspective, this is terrible as you're forcing the ITS to drop its 
>>> caches and reload everything, making the interrupt latency far worse 
>>> than what it should be on each and every vcpu migration.
>>
>> Agree, this reduces performance.
>>
>>>
>>> We already issue a VINVALL when a VPE is mapped. Why would you need 
>>> anything else?
>>>
>>
>> It is just for robustness, like the VINALL when a VPE is mapped.
> 
> The VINVALL at the point a VPE is mapped serves a purpose: to invalidate the caches from a previous instance of a VPE with the same VPEID. It's not for "robustness" but for *correctness*.
> 
>>
>>>>
>>>> @@ -1327,6 +1327,7 @@ static void its_send_vmovp(struct its_vpe 
>>>> *vpe)
>>>>
>>>>                 desc.its_vmovp_cmd.col = &its->collections[col_id];
>>>>                 its_send_single_vcommand(its, its_build_vmovp_cmd, 
>>>> &desc);
>>>> +               its_send_vinvall(its, vpe);
>>>>         }
>>>>
>>>> Do you think it's all right?
>>>
>>> I think this is pretty bad. If your HW requires this, then we can 
>>> add it as a workaround for your particular platform, but in general, 
>>> this is not needed.
>>
>> Got it, you are right :-).
> 
> May I suggest that in the future, you post patches that actually serve a real purpose and avoid wasting people's time? Your company employs a bunch of good people, some of which are pretty knowledgeable when it comes to the GIC. Please consult with them before posting such thing.
> 

Okay, thank you for your patience.

> Thanks,
> 
> 	M.
> 
> --
> Without deviation from the norm, progress is not possible.
