Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5B70B95B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjEVJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjEVJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:49:53 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79C7BB4;
        Mon, 22 May 2023 02:49:51 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:34704.564609069
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id C1E0E100210;
        Mon, 22 May 2023 17:49:48 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id 0f677f17687045fdbb6736c1fd24ac9b for kernel@xen0n.name;
        Mon, 22 May 2023 17:49:50 CST
X-Transaction-ID: 0f677f17687045fdbb6736c1fd24ac9b
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <ac2fde55-c770-fbb5-844d-50fb38dd90be@189.cn>
Date:   Mon, 22 May 2023 17:49:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>, Sui Jingfeng <15330273260@189.cn>,
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
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <ed795dc0-823a-f3d8-9e70-1cf33c0de7f0@xen0n.name>
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

On 2023/5/22 17:28, WANG Xuerui wrote:
> On 2023/5/22 17:25, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2023/5/21 20:21, WANG Xuerui wrote:
>>>> + * LS3A4000/LS3A5000/LS3A6000 CPU, they are equipped with on-board 
>>>> video RAM
>>>> + * typically. While LS2K0500/LS2K1000/LS2K2000 are low cost SoCs 
>>>> which share
>>>> + * the system RAM as video RAM, they don't has a dediacated VRAM.
>>>
>>> CPU models are not typically prefixed with "LS", so "Loongson 
>>> 3A4000/3A5000/3A6000".
>>>
>> Here is because when you do programming, variable name should prefix 
>> with letters.
>
> Commit messages, comments, and log messages etc. are natural language, 
> so it's better to treat them differently. No problem to keep code 
> as-is IMO.
>
Then you get two name for a single chip,  take  LS7A1000 as an example.

You name it as Loongson 7A1000 in commit message,  and then you have to 
define another name in the code,  say LS7A1000.

"Loongson 7A1000" is too long,  not as compact as LS7A1000.

This also avoid bind the company name to a specific product, because a 
company can produce many product.

>>> Also the description about the Loongson 2K series is a bit 
>>> irrelevant (we're focusing on VRAM here) so you could simplify the 
>>> sentence a bit. 
>>
>> We could reserve part of system RAM as VRAM for Loongson 2K series SoC.
>>
>> Either reserved with 'of reserve memory' or  reserved by the firmware.
>>
>
> What's an "of reserve memory"? Is it "DeviceTree-reserved"?
>
>> The reserve ram will not accessible by kernel itself it this case, 
>> and can still be managed by ttm.
>
> Of course. Feel free to tweak.
>
