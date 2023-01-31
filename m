Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675168290F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAaJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAaJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:39:57 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3ABAE;
        Tue, 31 Jan 2023 01:39:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VaWI3H1_1675157991;
Received: from 30.240.102.229(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VaWI3H1_1675157991)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 17:39:52 +0800
Message-ID: <c0986327-71b5-0d8e-a126-5f9f632cc6af@linux.alibaba.com>
Date:   Tue, 31 Jan 2023 17:39:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix possible crash in GCM cryption
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230118141928.48136-1-tianjia.zhang@linux.alibaba.com>
 <Y8gIC8Yn/E8Kwtf0@gondor.apana.org.au>
 <c7dbadbf-dade-fb1e-bda3-d23d567c620f@linux.alibaba.com>
 <Y9d8pfRQADxIhLIB@gondor.apana.org.au> <Y9eHXVyiSk0b+ovp@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Y9eHXVyiSk0b+ovp@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 1/30/23 5:01 PM, Herbert Xu wrote:
> On Mon, Jan 30, 2023 at 04:15:33PM +0800, Herbert Xu wrote:
>>
>> Actually I think there is a serious bug here.  If you're doing an
>> empty message, you must not call skcipher_walk_done as that may
>> then free random uninitialised stack memory.
> 
> Hah, I had forgotten that this thread started with your patch
> to fix this exact bug :)
> 
> Could you confirm that you did copy this from ccm?
> 
> It would be nice if you could rewrite your loop in a form similar
> to my patch to ccm.
> 
> Thanks,

These codes are copied from gcm and ccm at the same time. I am not sure
which has more components, but I will rewrite the gcm and ccm encryption
loop of sm4 as soon as possible.

Cheers,
Tianjia
