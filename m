Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5E74A88B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGGBmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0321BC2;
        Thu,  6 Jul 2023 18:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5FD61505;
        Fri,  7 Jul 2023 01:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF3C433C8;
        Fri,  7 Jul 2023 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688694166;
        bh=WayhVO+z9gwrgedQ+iZ70/g851bm++tZxVxrPg6wbsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=THtkbrlQRP9FydPtyp4+5t5q6NVjoMy7qvt6Ojxzl9gEP5/xU36xy2Wn3DirQiWUU
         u+4o/cZeKXk56OulHWUUyL46pU7qJEl25cMMfxVclYQ/SXFagJLTpZzMS6z+g4YDeF
         k2xid1HPr3tK3CmIfL1lDqPEyPhY8HQoW1ZCWn/Tbjp5tVBaNpeIg/PxuXtWIKIEdP
         58X1tpt/p19ynTfAmcXAyo21qS0tnqL4GnIHfT6ljyeGhPL6t5z2s9L5rm7F0aLw9H
         9tygE6d4jyH9dG2+MLpogISMybjA2eH49cHWUBuVJcLz+XNnNZy4WvUYQc8uZpZkRH
         mPUBbiNLwyvJg==
Message-ID: <8d731372-3fb7-7b76-5e6d-befd8096c922@kernel.org>
Date:   Fri, 7 Jul 2023 10:42:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
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

On 7/7/23 09:59, Ming Lei wrote:
> On Fri, Jul 07, 2023 at 08:50:01AM +0900, Damien Le Moal wrote:
>> On 7/6/23 22:09, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> Ublk zoned storage support relies on DRV_IN handling for zone report.
>>> Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.
>>>
>>> Also add parenthesis to existing opcodes for better macro hygiene.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>> ---
>>>  include/uapi/linux/ublk_cmd.h | 18 ++++++++++++++----
>>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>>> index 4b8558db90e1..2ebb8d5d827a 100644
>>> --- a/include/uapi/linux/ublk_cmd.h
>>> +++ b/include/uapi/linux/ublk_cmd.h
>>> @@ -229,12 +229,22 @@ struct ublksrv_ctrl_dev_info {
>>>  	__u64   reserved2;
>>>  };
>>>  
>>> -#define		UBLK_IO_OP_READ		0
>>> +#define		UBLK_IO_OP_READ			0
>>>  #define		UBLK_IO_OP_WRITE		1
>>>  #define		UBLK_IO_OP_FLUSH		2
>>> -#define		UBLK_IO_OP_DISCARD	3
>>> -#define		UBLK_IO_OP_WRITE_SAME	4
>>> -#define		UBLK_IO_OP_WRITE_ZEROES	5
>>> +#define		UBLK_IO_OP_DISCARD		3
>>> +#define		UBLK_IO_OP_WRITE_SAME		4
>>> +#define		UBLK_IO_OP_WRITE_ZEROES		5
>>> +/*
>>> + * Passthrough (driver private) operation codes range between
>>
>> This is unclear... Here, what does "driver" refer to ? If it is the ublk
>> kernel driver, than these commands should not be defined in the uapi
>> header file, they should be defined in drivers/block/ublk.h. However, if
>> these are for the user space driver, like all the other operations, then
> 
> Like normal IO, these passthrough requests needs userspace to handle too,
> usually they just belong to specific ublk target, such as report zones.,
> so here it is part of UAPI.
> 
> But yes, we should document it clearly, maybe something below?
> 
> 	Ublk passthrough operation code ranges, and each passthrough
> 	operation provides generic interface between ublk kernel driver
> 	and ublk userspace, and this interface is usually used for handling
> 	generic block layer request, such as command of zoned report zones.
> 	Passthrough operation is only needed iff ublk kernel driver has to
> 	be involved for handling this operation.

Yes, that is better.

> 
>> let's clearly state so. But then, I still not understand why these need
>> a different naming pattern using the "__UBLK" prefix...
> 
> I think __UBLK just meant we don't suggest userspace to use it directly,
> since the added macros are just for making ranges for DRV_IN and DRV_OUT,
> so we can check command direction easily be using this start/end info in
> both sides.

Personally, I would still prefer to not add this "__" prefix as these
are operations that the ublk user driver will have to deal with, like
the other ones. So I do not see the point of that prefix. But no strong
feeling about that :)

> 
> 
> Thanks, 
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

