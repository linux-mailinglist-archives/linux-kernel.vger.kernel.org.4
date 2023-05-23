Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17870D6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjEWIOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjEWINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:13:38 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3968E1709
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:12:17 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:50830.1110848198
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 2E6421002CE;
        Tue, 23 May 2023 16:12:14 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id 44015d2c06d047de9aca08dcafbd25d6 for 15330273260@189.cn;
        Tue, 23 May 2023 16:12:16 CST
X-Transaction-ID: 44015d2c06d047de9aca08dcafbd25d6
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <5d7f9d1a-10c5-5b55-c7d8-24183f5a09ee@189.cn>
Date:   Tue, 23 May 2023 16:12:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
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
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <4c9c0897-5e3a-1469-3d87-ff7723ac160c@189.cn>
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

On 2023/5/23 12:26, Sui Jingfeng wrote:
> Hi,
>
> On 2023/5/22 19:29, Jani Nikula wrote:
>> In general, do not use unsigned types in arithmethic to avoid negative
>> values, because most people will be tripped over by integer promotion
>> rules, and you'll get negative values anyway.
>
>
> Here I'm sure about this,
>
Here, I'm NOT sure about this


> but there are plenty unsigned types arithmetic in the kernel.
>
> take kmalloc_array() function as an example in 
> /tools/virto/linux/kernel.h
>
>
> static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
> {
>     return kmalloc(n * s, gfp);
> }
>
>
> NOTE that *size_t* is an unsigned integral data type.
