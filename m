Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795D741D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjF2BOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF2BOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E32694;
        Wed, 28 Jun 2023 18:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2BD612CA;
        Thu, 29 Jun 2023 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC502C433C9;
        Thu, 29 Jun 2023 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688001271;
        bh=OHfV9RkAhi/HBgdNbnfx7GoparhjCrP3HY0+yWmUQgo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tEth8uPntBrqzu+8geRiJPwf3br5LIsCMW/mtLPh+X5bqUakudEIGbXWin9DV77Fj
         JnVZSk8PeVn+M0bpPZEDikBLGOzXJL09uzgPcHkQVZ2ZURW5VF0tGzhCTWOSSGBYd8
         Y+JS83ULr5af10Hqsyp5Yc1aE8Dj9HDZRPtcHYkWEOguo3pHUZcSZ+QJXQUpqK4yHV
         3SGe3EkjMDABAdNGIOl3QTYBTZbR8XDMH5sH6uYYU8LljuoqfX1NegxBkkZQPMyNtt
         j11Q46yPwluXLhpuzluuuP8ZXvG+myMoVjYp/s64jMOtz8BbRN7/61uVUobkVzeHTg
         3fxr33k+n2AOQ==
Message-ID: <0f8160eb-f504-5069-5c78-783bce59b214@kernel.org>
Date:   Thu, 29 Jun 2023 10:14:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
 <ZJzSjFbzzNxppH7p@ovpn-8-18.pek2.redhat.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZJzSjFbzzNxppH7p@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 09:38, Ming Lei wrote:
> On Thu, Jun 29, 2023 at 07:47:47AM +0900, Damien Le Moal wrote:
>> On 6/29/23 04:06, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> This change is in preparation for zoned storage support.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>> ---
>>>  include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
>>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>>> index 4b8558db90e1..471b3b983045 100644
>>> --- a/include/uapi/linux/ublk_cmd.h
>>> +++ b/include/uapi/linux/ublk_cmd.h
>>> @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
>>>  	__u64   reserved2;
>>>  };
>>>  
>>> -#define		UBLK_IO_OP_READ		0
>>> -#define		UBLK_IO_OP_WRITE		1
>>> -#define		UBLK_IO_OP_FLUSH		2
>>> -#define		UBLK_IO_OP_DISCARD	3
>>> -#define		UBLK_IO_OP_WRITE_SAME	4
>>> -#define		UBLK_IO_OP_WRITE_ZEROES	5
>>> +enum ublk_op {
>>> +	UBLK_IO_OP_READ = 0,
>>> +	UBLK_IO_OP_WRITE = 1,
>>> +	UBLK_IO_OP_FLUSH = 2,
>>> +	UBLK_IO_OP_DISCARD = 3,
>>> +	UBLK_IO_OP_WRITE_SAME = 4,
>>> +	UBLK_IO_OP_WRITE_ZEROES = 5,
>>> +	UBLK_IO_OP_ZONE_OPEN = 10,
>>> +	UBLK_IO_OP_ZONE_CLOSE = 11,
>>> +	UBLK_IO_OP_ZONE_FINISH = 12,
>>> +	UBLK_IO_OP_ZONE_APPEND = 13,
>>> +	UBLK_IO_OP_ZONE_RESET = 15,
>>> +	__UBLK_IO_OP_DRV_IN_START = 32,
>>> +	__UBLK_IO_OP_DRV_IN_END = 96,
>>> +	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
>>> +	__UBLK_IO_OP_DRV_OUT_END = 160,
>>> +};
>>
>> This patch does not do what the title says. You are also introducing the zone
>> operations, and the very obscure __UBLK_IO_OP_DRV_XXX operations without an
>> explanation. Also, why the "__" prefix for these ? I do not see the point...
> 
> It should be to reserve space for ublk passthrough OP.

A comment about that would be nice.

> 
>> Given that this is a uapi, a comment to explain the less obvious commands would
>> be nice.
>>
>> So I think the change to an enum for the existing ops can be done either in
>> patch 2 or as a separate patch and the introduction of the zone operations done
>> in patch 3 or as a separate patch.
> 
> Also it might break userspace by changing to enum from macro for existed
> definition, cause userspace may check something by '#ifdef UBLK_IO_OP_*',
> so probably it is better to keep these OPs as enum, or at least keep
> existed definition as macro.

Then let's keep defining things with #define instead of an enum.

> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

