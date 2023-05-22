Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4F70BB94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjEVLSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjEVLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:18:04 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36DE4270B;
        Mon, 22 May 2023 04:11:53 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:43282.1768237263
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 19A0A100249;
        Mon, 22 May 2023 19:11:49 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 7e6dec763f794de7a956c82faf1763ee for kernel@xen0n.name;
        Mon, 22 May 2023 19:11:51 CST
X-Transaction-ID: 7e6dec763f794de7a956c82faf1763ee
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <6ff9a210-9d31-d0b0-f282-7640e95aac5e@189.cn>
Date:   Mon, 22 May 2023 19:11:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
References: <20230520105718.325819-1-15330273260@189.cn>
 <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
 <e7f911cc-6588-bc0f-8e1e-759260f5187a@189.cn>
 <ed795dc0-823a-f3d8-9e70-1cf33c0de7f0@xen0n.name>
 <ac2fde55-c770-fbb5-844d-50fb38dd90be@189.cn>
 <331e7baa-a83b-b0c9-37f7-0e8e39187df4@xen0n.name>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <331e7baa-a83b-b0c9-37f7-0e8e39187df4@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/22 18:05, WANG Xuerui wrote:
> On 2023/5/22 17:49, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2023/5/22 17:28, WANG Xuerui wrote:
>>> On 2023/5/22 17:25, Sui Jingfeng wrote:
>>>> Hi,
>>>>
>>>> On 2023/5/21 20:21, WANG Xuerui wrote:
>>>>>> + * LS3A4000/LS3A5000/LS3A6000 CPU, they are equipped with 
>>>>>> on-board video RAM
>>>>>> + * typically. While LS2K0500/LS2K1000/LS2K2000 are low cost SoCs 
>>>>>> which share
>>>>>> + * the system RAM as video RAM, they don't has a dediacated VRAM.
>>>>>
>>>>> CPU models are not typically prefixed with "LS", so "Loongson 
>>>>> 3A4000/3A5000/3A6000".
>>>>>
>>>> Here is because when you do programming, variable name should 
>>>> prefix with letters.
>>>
>>> Commit messages, comments, and log messages etc. are natural 
>>> language, so it's better to treat them differently. No problem to 
>>> keep code as-is IMO.
>>>
>> Then you get two name for a single chip,  take  LS7A1000 as an example.
>>
>> You name it as Loongson 7A1000 in commit message,  and then you have 
>> to define another name in the code,  say LS7A1000.
>>
>> "Loongson 7A1000" is too long,  not as compact as LS7A1000.
>>
>> This also avoid bind the company name to a specific product, because 
>> a company can produce many product.
>
> Nah, the existing convention is "LS7Xxxxx" for bridges


But I see there are document[1] which named LS7A1000 bridge chip as 
Loongson 7A1000 Bridge,

See [1] for reference, who is wrong in this case?


[1] 
https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanual-EN

