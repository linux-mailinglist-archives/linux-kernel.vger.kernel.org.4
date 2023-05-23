Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A670D9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjEWJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjEWJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:55:51 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25587FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:55:43 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:57524.1031125115
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 3F859100213;
        Tue, 23 May 2023 17:55:40 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 277733f944394f969e1abbb9ceeb69a8 for david.laight@aculab.com;
        Tue, 23 May 2023 17:55:42 CST
X-Transaction-ID: 277733f944394f969e1abbb9ceeb69a8
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <ed008264-e72e-7548-d93e-f7f4130ef2c2@189.cn>
Date:   Tue, 23 May 2023 17:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
References: <20230516173026.2990705-1-15330273260@189.cn>
 <f6bd362145124f34a1af800dd330f8e9@AcuMS.aculab.com>
 <b23c41b1-e177-c81d-5327-fce5511cb97d@189.cn> <871qj8ob7z.fsf@intel.com>
 <4c9c0897-5e3a-1469-3d87-ff7723ac160c@189.cn>
 <e5effc4568034489acf2f4d4dad6eba9@AcuMS.aculab.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <e5effc4568034489acf2f4d4dad6eba9@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/23 16:50, David Laight wrote:
> From: 15330273260@189.cn <15330273260@189.cn>
>> Sent: 23 May 2023 05:27
>>
>> On 2023/5/22 19:29, Jani Nikula wrote:
>>> In general, do not use unsigned types in arithmethic to avoid negative
>>> values, because most people will be tripped over by integer promotion
>>> rules, and you'll get negative values anyway.
>>
>> Here I'm not sure about this,
>>
>> but there are plenty unsigned types arithmetic in the kernel.
> The real problem is (attempted) arithmetic on types smaller than int.
> Regardless of whether they are signed or unsigned.

It is about sign extend.

Yes, you may be right. I might create a wrong patch.

But this will not happen in practice, because in general case:

mode->crtc_htotal < 0x8fff;

mode->crtc_vtotal < 0x8fff;

u16 gets promoted to 'signed int' not 'unsigned int'.

Sorry  :/

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
