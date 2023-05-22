Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB63870B5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjEVHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEVHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C61FEF;
        Mon, 22 May 2023 00:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A1361197;
        Mon, 22 May 2023 07:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A79C433EF;
        Mon, 22 May 2023 07:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684738938;
        bh=c4gWqr9ur4of/a8IC06iYHE7k0Seduk+Q9U0csTEnpE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CDrbZwdhAf88j9UkLMmkDgcaPt//jDinfRmwjncBfzJMJ+kHL005fLuLGd6rBqEkw
         kbHokEnu3u1GdDnkLzmDhpxEd/TVL3hiWSoZzjrS/I45qGySLF0xMJEXWLiMYDxrZs
         ERkJ0gDAK3RtCEjYOzHK1Qr9XEtkC8g5vpHR0AX9RnMFhx3dCdl6z3AcarqMXhY6TX
         9cq2x0c7WHJqJkr5t5CDZhZkvroPfJAL5cbVFtUuZ2jqqj6YBPSeiIj2N+Z1TAUOOH
         59kCOrU/jIp+mXj6nAZK8AlY8M3426500PEb52Xbiaym0QCFV5DmDe2NmjXLyVYX9H
         jZ/b4mthmEejw==
Message-ID: <68953040-1622-254b-f6f8-b279eccacfb1@kernel.org>
Date:   Mon, 22 May 2023 16:02:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
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
 <a5c2e157-aaf7-1300-3fbb-1300ac216cee@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a5c2e157-aaf7-1300-3fbb-1300ac216cee@kernel.org>
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

On 5/22/23 10:35, Damien Le Moal wrote:
> On 5/8/23 10:11, yangxingui wrote:
>>
>>
>> On 2023/5/7 22:51, Damien Le Moal wrote:
>>> On 2023/05/05 18:06, yangxingui wrote:
>>>>
>>>>
>>>> On 2023/5/5 16:17, Damien Le Moal wrote:
>>>>> On 2023/05/05 11:57, Xingui Yang wrote:
>>>>>> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
>>>>>> the ata_device structure of a scsi device. However, when the ata device is
>>>>>> managed by libsas, ata_scsi_find_dev() returns NULL, turning
>>>>>> ata_get_identity() into a nop and always returns -ENOMSG.
>>>>>
>>>>> What do you do to hit the issue ? A while back for me it was the queue depth
>>>>> setting causing problems. As Garry mentioned, this led to patch 141f3d6256e5
>>>>> ("ata: libata-sata: Fix device queue depth control").
>>>> Attempt to return the correct value at ata_scsi_find_dev() instead of
>>>> NULL, when the ata device is managed by libsas?
>>>
>>> That I understand. My question is *what* user operation/command triggers this ?
>>> Because on my test setup, under normal use, I do not see this issue (beside what
>>> was already corrected with the queue depth control). Is the issue showing up
>>> when using passthrough commands only ?
>> Yeah, we found that command "hdparm -i /dev/sdc" always return faild for 
>> SATA HDD disk. as follows:
>> [root@localhost ~]# hdparm -i /dev/sdc
>>
>> /dev/sdc:
>>   HDIO_GET_IDENTITY failed: Invalid argument
> 
> I cannot recreate this issue exactly like this. Here is my setup with a pm80xx
> driver (Adaptec HBA):
> 
> [7:0:0:0]    disk    ATA      WDC  WUH721818AL W232  /dev/sdd   /dev/sg5
> [7:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdi   /dev/sg6
> [7:0:2:0]    disk    ATA      WDC  WUH722222AL Wf86  /dev/sdf   /dev/sg7
> [7:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sdg   /dev/sg8
> 
> Using the first drive, I get:
> 
> sudo hdparm -i /dev/sdd
> 
> /dev/sdd:
> 
>  Model=WDC  WUH721818ALN604, FwRev=PCGNW232, SerialNo=3KG10LBK
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=56
>  BuffType=DualPortCache, BuffSize=unknown, MaxMultSect=2, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=4394582016
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>  Drive conforms to: unknown:  ATA/ATAPI-2,3,4,5,6,7
> 
>  * signifies the current active mode
> 
> So all good. However, for the following drives, I get:
> 
> sudo hdparm -i /dev/sdi
> 
> /dev/sdi:
>  HDIO_GET_IDENTITY failed: No message of desired type
> 
> (same for sdf and sdg).
> 
> Will dig into this.

OK, so the issue is that __ata_scsi_find_dev() calls ata_find_dev() with devno
== scsidev->id. This leads to devno being 0, 1, 2 and 3 for connected drives
sdd, sd1, sdf and sdg, as shown by lsscsi. However, each drive has its own
port+link, with the link for each one having  ata_link_max_devices() == 1, so
ata_find_dev() works only for the first drive with scsidev->id == 0 and fails
for the others. A naive fix would be this:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..e4d6f17d7ccc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2718,7 +2718,7 @@ static struct ata_device *__ata_scsi_find_dev(struct
ata_port *ap,
        if (!sata_pmp_attached(ap)) {
                if (unlikely(scsidev->channel || scsidev->lun))
                        return NULL;
-               devno = scsidev->id;
+               devno = 0;
        } else {
                if (unlikely(scsidev->id || scsidev->lun))
                        return NULL;

And running this on my setup, it works. This makes libsas added ports/devices
look like AHCI ones, where all devices have ID 0 for the !pmp case.

However, I am not sure this would be OK for all setups...

John,

Any idea if there is any cases where libsas managed drives would endup not being
correctly identified by this change ? As long as a device always has its own
port, I do not see any issue. But is there a case where we could have multiple
devices on the same port ? Per libata, max is 2, and that is only for the IDE
master/slave case. Otherwise, it is always 1.

Not that looking at the pmp case, I am not confident at all that the
identification is correct for libsas. But I do not think that anyone would ever
connect a pmp box to a libsas HBA...

-- 
Damien Le Moal
Western Digital Research

