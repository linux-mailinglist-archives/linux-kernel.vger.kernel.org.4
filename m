Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84ED70B2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjEVBfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVBfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B87CE;
        Sun, 21 May 2023 18:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6835460ED1;
        Mon, 22 May 2023 01:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDBFC433EF;
        Mon, 22 May 2023 01:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684719351;
        bh=ggLlr2Ko4vx6Mzuv9d5AUMB2oUgek0q2hCXn2xVIWsQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oVeeWhftPAhRqeJINMtRFce6KWGY0ZEwfDtaAEpWkhYqbT+mDA6CYdh9OUu9rE47U
         r1cFds91kM2+irS4BGjrxqQl7BbolJXzZqkgvP093m2G3zYeOrtHLSkrGUwwT0EjgJ
         N7Aquqpj6IemygGwTd4FsmvzdBbo6X5Ey/IzKgr+33FeHq7mJWS6daMCzmely0aBNd
         Hq3R0yeJ0R/ga5LLWx+IZml7swXymZVQiRJwYlzZnz7g0/QeKP6m/me4iGPL1fTZzG
         h7go2AYr2V3WeJSCw+4QEwpkU0Pfu6Bq3YHdnKHPcaCkLK3f38T4mVMXBGuMtFi9GN
         xv/EdOMxhoHIA==
Message-ID: <a5c2e157-aaf7-1300-3fbb-1300ac216cee@kernel.org>
Date:   Mon, 22 May 2023 10:35:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <02d36ee9-cdad-454d-d822-95442d7bd67b@huawei.com>
 <f4ba7a92-1f00-c254-d196-7d21fe14dee2@kernel.org>
 <938d6b5b-0271-977d-f046-5fd70d29b3ca@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <938d6b5b-0271-977d-f046-5fd70d29b3ca@huawei.com>
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

On 5/8/23 10:11, yangxingui wrote:
> 
> 
> On 2023/5/7 22:51, Damien Le Moal wrote:
>> On 2023/05/05 18:06, yangxingui wrote:
>>>
>>>
>>> On 2023/5/5 16:17, Damien Le Moal wrote:
>>>> On 2023/05/05 11:57, Xingui Yang wrote:
>>>>> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
>>>>> the ata_device structure of a scsi device. However, when the ata device is
>>>>> managed by libsas, ata_scsi_find_dev() returns NULL, turning
>>>>> ata_get_identity() into a nop and always returns -ENOMSG.
>>>>
>>>> What do you do to hit the issue ? A while back for me it was the queue depth
>>>> setting causing problems. As Garry mentioned, this led to patch 141f3d6256e5
>>>> ("ata: libata-sata: Fix device queue depth control").
>>> Attempt to return the correct value at ata_scsi_find_dev() instead of
>>> NULL, when the ata device is managed by libsas?
>>
>> That I understand. My question is *what* user operation/command triggers this ?
>> Because on my test setup, under normal use, I do not see this issue (beside what
>> was already corrected with the queue depth control). Is the issue showing up
>> when using passthrough commands only ?
> Yeah, we found that command "hdparm -i /dev/sdc" always return faild for 
> SATA HDD disk. as follows:
> [root@localhost ~]# hdparm -i /dev/sdc
> 
> /dev/sdc:
>   HDIO_GET_IDENTITY failed: Invalid argument

I cannot recreate this issue exactly like this. Here is my setup with a pm80xx
driver (Adaptec HBA):

[7:0:0:0]    disk    ATA      WDC  WUH721818AL W232  /dev/sdd   /dev/sg5
[7:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdi   /dev/sg6
[7:0:2:0]    disk    ATA      WDC  WUH722222AL Wf86  /dev/sdf   /dev/sg7
[7:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sdg   /dev/sg8

Using the first drive, I get:

sudo hdparm -i /dev/sdd

/dev/sdd:

 Model=WDC  WUH721818ALN604, FwRev=PCGNW232, SerialNo=3KG10LBK
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=56
 BuffType=DualPortCache, BuffSize=unknown, MaxMultSect=2, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=4394582016
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-2,3,4,5,6,7

 * signifies the current active mode

So all good. However, for the following drives, I get:

sudo hdparm -i /dev/sdi

/dev/sdi:
 HDIO_GET_IDENTITY failed: No message of desired type

(same for sdf and sdg).

Will dig into this.

-- 
Damien Le Moal
Western Digital Research

