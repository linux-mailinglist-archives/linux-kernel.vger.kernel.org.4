Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD1610BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJ1IHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJ1IHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:07:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6244315A317
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666944454; x=1698480454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BhLvfHx2bYTYF8JSCc4dtFpE9sunuk39pQhitXjwVlM=;
  b=OiOUMm5bsNjM8tN5Tp9JnIJn2n51xM+O/X/2dZTCzmTl7CGViJwkRioq
   aryRMVnmfVqemuSvz2khzKlo0D5HIrEWK9O+JYkk2zveYHyBx3Hyv+Td5
   HazHpJuK5oxUbpI/5Y6aOCz8ZSqwzojJR797L2ieKljz82FqyHDGvIroN
   db4jNs36Dlo4X0HtPXIqVY/66kU++m/+QUM3ZIGUrHPhxMSOg6XxHmw56
   gsRd2uTfWXQKxsagN/UnC8V8MJWNg/AbSf5VQhzrpqhnFTGygLgvIcrnD
   VkHEg8uHzwWLeC7QS0nl7BR+i5JKbymVISfu9JjtWzA2GMQQvddBEp5UU
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="220104560"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 16:07:32 +0800
IronPort-SDR: 7t7nCOeTPhnjQtCUYCTBUj7a5aB0Wlq/+3cHYjyJUmnasf4aa1PNn9xv58ZmqNFie7YSuD/otU
 LBCckygnFovDHPcDc7qlpHwTrWhjEAlodj2vnXnEQLmtZR5sVqi0Mry9403wNynG+BistNm3Wh
 lE7vSLMr69PGzNVqTwQfMLWw/aFtXRUtuUabqAZ0GJVtCElL4kJxWiktGLt6WU06X7NoP5JZH8
 AWNtkqh0R2tW7XRp/1QYgjKD5k6psC/dU6UXRq6umKrJRXs7XSYfFAqQqmF9Wk6z60iZJtlHLs
 xYkZ8CSthj9dZ80uc5iLytRd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 00:26:52 -0700
IronPort-SDR: t6C81hq3BKeE3Dtw7va0CaNIDbYX07tQoLvbDY8e0i8XgbPdMqAVOi+dUT1atf8ty1c1IvxKsN
 pFwPzTgxlFzIPw9wI6krkBlT/ZZIfWOUIbSJvdaH5tLMso8ts2+zGxQF6vrDpzXMI+tYnjmEew
 wPETpPwM9aXNEi0Nne36uZaPkckpqg8/0yPtQIXY/ATwYppbEsUsbaoiGTGpjeipYW8b/z4XVy
 iPr7duBrStI12ILWoMyCixpvyOw7fDbe5kVyy2NJWAdhg807LItJ88oEoeJbCShUs/xgAvZczp
 cdI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 01:07:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzFX40GTxz1RvTr
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:07:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666944451; x=1669536452; bh=BhLvfHx2bYTYF8JSCc4dtFpE9sunuk39pQh
        itXjwVlM=; b=coyK/aupG/TjEIqiWEXp2isBULImhRurCNf47lD1tKaVuFKmxnG
        /R5k0QBmzVORgY/TDQObZdJfNLlYm801DKpoVAVtmkERyiJLc0kjlIXE6DvtJ+v9
        CTFd/GzL77bOIxjoQBHadIe9TgLSnS9aUVNapEJLqa4N1rOg/7tSjJcKUNSyHvx6
        j0uDK5UNaPgUteUidGv/klIBGmQXzDxvXgleYNjJ7jQ9UGuXglsePBWmQyHn4gxP
        kWH1eEW7IlL/hI4Hc61EhTi+zYXgBVcBk7ZMn42AVP6YPcO4Z+hH1bTFuAezrMOk
        8xfmlcmbEQEMS6SvVZYlcDR53tmvNIWW4Bw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hM8QDgnN1L8K for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 01:07:31 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzFX00SKwz1RvLy;
        Fri, 28 Oct 2022 01:07:27 -0700 (PDT)
Message-ID: <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 17:07:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 17:01, John Garry wrote:
> On 27/10/2022 23:25, Damien Le Moal wrote:
>>> So we have this overall flow:
>>>
>>> ata_exec_internal_sg():
>>>    -> alloc request
>>>    -> blk_execute_rq_nowait()
>>>        ... -> scsi_queue_rq()
>>> 		-> sht->reserved_queuecommd()
>>> 			-> ata_internal_queuecommand()
>>>
>>> And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() ->
>>> ata_scsi_queue_internal() -> ata_qc_issue().
>>>
>>> Hope it makes sense.
>> OK. Got it.
>> However, ata_exec_internal_sg() being used only from EH context with the
>> queue quiesced, will blk_execute_rq_nowait() work ? Is there an exception
>> for internal reserved tags ?
>>
> 
> Well, yeah. So if some error happens and EH kicks in, then full queue 
> depth of requests may be allocated. I have seen this for NCQ error. So 
> this is why I make in very first patch change allow us to allocate 
> reserved request from sdev request queue even when budget is fully 
> allocated.
> 
> Please also note that for AHCI, I make reserved depth =1, while for SAS 
> controllers it is greater. This means that in theory we could alloc > 1x 
> reserved command for SATA disk, but I don't think it matters.

Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that the
user can only use 31 tags ? or is it 32+1 reserved ? which we can do since
when using the reserved request, we will not use a hw tag (all reserved
requests will be non-ncq).

The 32 + 1 scheme will work. But for CDL command completion handling, we
will need a NCQ command to do a read log, to avoid forcing a queue drain.
For that to reliably work, we'll need a 31+1+1 setup...

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

