Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960456CD94F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC2MYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjC2MYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:24:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9041FDB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680092659; x=1711628659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2dcvqV87tiaXbc2Uo11d6o/I39/nMjI+zlAAi+6Vbgk=;
  b=FInUpywGyCiBZ6lwRYU4XU5nYC1tlOTMbua079aS+TrqsJQpeTgsh66b
   Dfy+f95QPCSCIrm+lQNLb8pCo1FV1ChqP4TK8gPc5XP/yd6hharfeAsDi
   HMjfwS66jpiH/NkyJctfUnUIMCCUdZMPiwmyZy7pPlPAlxz3nKM+GUAI+
   XbF4el7WN3vy9zMnjRa5ifT/2Um27T933/Flbq1vALOI5wu9PcipGVFO7
   0dGu+AQOdMzO0v9NIQgx3drTA942A1r/NOz6co1rORmsC2NDqGy6rE/Kh
   Tv54hPksKwo+cqkK/jNFa8QXQ/FiqiBNCsvgqrWJZcZcLVWmsg+XCDvDR
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="231763314"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 20:24:19 +0800
IronPort-SDR: nHF0vERJcNn095vMdQeaMZ1UyAnytNlUdIj7IU/0sqp4xPrsdlvAizYrjpd2VW+0pD+BiJyy81
 wGCPzGXU/PtRdc12DeICoY1TWGkY7ymWp00ZBEfvHlObKFBrbZecAwb/wr32LuGbWUwHXh0R+6
 lZyoxpFtPt6J4h0oKMr87Tkf3tY7LBoSGQme5edxQl9M2FZdMkkMDnqRdlhjyo7io0QHP9UJkS
 3VUQkM5WQS872s8XVlFf7T1jLzw9hc2c/DMGAM0VoFCoQx7NjxK5DFt5kaELZk2LyOPg7m+eLW
 pPA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 04:40:28 -0700
IronPort-SDR: 6aq29CGTefEAPaMBNfglIGMxtuPZFqnCwNLWi5Q6hqwTG/U7AXA++IR0GrCqeBgrbRImqXxlkz
 u0AjFNgA5bjd2i8XDsMmi+GwAm6E21Yw2U9/MyjNKnUoG3MibtdjLwsYkC7j6aMhY01LiQYHCj
 Q6XPe6oRriLkWnJrZLlfoIdr6b7WTMTjNBrYUHbcNPV2ynZ6lkn2QrunBFJx9G7LdnJ1Kuc/SO
 Tkw2aZicwCeQPxBCauUlq/6E1jJxBjyhikkh2abV/gHOaBU2lX0kYC0QZauwcCxQMes3PHc21W
 dWQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 05:24:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmm2B5R06z1RtW1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:24:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680092657; x=1682684658; bh=2dcvqV87tiaXbc2Uo11d6o/I39/nMjI+zlA
        Ai+6Vbgk=; b=aYJDL/Wv2IOTx8UdzJQy6vhK6Cwx6WbFawjWCYauh4DMUjt8PUN
        9x0lBBLgBT/IjyJZGV1IULqpb87tc8FlfO62FSSzocE5VAR0WX6HRUoEfOG+mAEG
        rS94t5CfBpzIdV/6jIaxzIRNmFgSzvpryU3Z3Hgv220Wql3f6LJqko6ekzg49x+7
        qeUNMP4r4fsY+rjt2ddmQ5DpVwco7it1Uwnyd0bFSBOYjcGo49ZkFsBrbmu/9pYw
        AfMs3umVUAn9mMkkU82WMd1B4ReuDbvk0vLFAQHC/dPMQD3ZYGm0zN4Yjco6S7g1
        yw6PpaghAYhqlgVGMdPjU7T3BSfmuLdDP4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 14movKifG6Bt for <linux-kernel@vger.kernel.org>;
        Wed, 29 Mar 2023 05:24:17 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmm253ydnz1RtVm;
        Wed, 29 Mar 2023 05:24:13 -0700 (PDT)
Message-ID: <03c647ff-3c4f-a810-12c4-06a9dc62c90e@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 21:24:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
 <20230327084103.21601-2-anuj20.g@samsung.com>
 <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
 <20230329104142.GA11932@green5>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230329104142.GA11932@green5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 19:41, Nitesh Shetty wrote:
>>> +What:		/sys/block/<disk>/queue/copy_max_bytes
>>> +Date:		November 2022
>>> +Contact:	linux-block@vger.kernel.org
>>> +Description:
>>> +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
>>> +		device, 'copy_max_bytes' setting is the software limit.
>>> +		Setting this value lower will make Linux issue smaller size
>>> +		copies from block layer.
>>
>> 		This is the maximum number of bytes that the block
>>                 layer will allow for a copy request. Must be smaller than
>>                 or equal to the maximum size allowed by the hardware indicated
> 
> Looks good.  Will update in next version. We took reference from discard. 
> 
>> 		by copy_max_bytes_hw. Write 0 to use the default kernel
>> 		settings.
>>
> 
> Nack, writing 0 will not set it to default value. (default value is
> copy_max_bytes = copy_max_bytes_hw)

It is trivial to make it work that way, which would match how max_sectors_kb
works. Write 0 to return copy_max_bytes being equal to the default
copy_max_bytes_hw.

The other possibility that is also interesting is "write 0 to disable copy
offload and use emulation". This one may actually be more useful.

> 
>>> +
>>> +
>>> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
>>> +Date:		November 2022
>>> +Contact:	linux-block@vger.kernel.org
>>> +Description:
>>> +		[RO] Devices that support offloading copy functionality may have
>>> +		internal limits on the number of bytes that can be offloaded
>>> +		in a single operation. The `copy_max_bytes_hw`
>>> +		parameter is set by the device driver to the maximum number of
>>> +		bytes that can be copied in a single operation. Copy
>>> +		requests issued to the device must not exceed this limit.
>>> +		A value of 0 means that the device does not
>>> +		support copy offload.
>>
>> 		[RO] This is the maximum number of kilobytes supported in a
>>                 single data copy offload operation. A value of 0 means that the
>> 		device does not support copy offload.
>>
> 
> Nack, value is in bytes. Same as discard.

Typo. I meant Bytes. Your text is too long an too convoluted, so unclear.

-- 
Damien Le Moal
Western Digital Research

