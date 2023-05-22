Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A870B94A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEVJo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjEVJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62726F9;
        Mon, 22 May 2023 02:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92C7760C1B;
        Mon, 22 May 2023 09:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1090C433D2;
        Mon, 22 May 2023 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684748656;
        bh=SVoYzzxZuFTGXh87Jk2YnPaJ8G3ijBqVH+39j9Y0BD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j4HjcmHoE11NThX3xZMpEsBFoaasEqREvcKGYj7W5KNBsA1RFh51lpq8O9GhYSrbw
         6axF4z76Hon97BhDohwjxWKX+c1YI1G005Xxglj1YHOE86t5VpxGSEpKPB2L9r4kNL
         L+Sx5Az8cq0xSJD0cVQ/JDERZ00m3L9v3StMsxIpMh++hq4MsUZL0gzyjwindVLWMU
         EnwdkW2L3qFKVWz3jJ/7ODjFPz8wBIsf+e1L5JfXhs/Qcnuo22p1onEESS1oJYMbQE
         x72CqHg+Kfufd3tYMKwh6jYMf4rKQ83PxF2W+t3I6TYohGeZiALMZT231yN363AhOY
         yFkOkhCXKrfFg==
Message-ID: <960e2aac-1769-6037-dd77-58999313fefc@kernel.org>
Date:   Mon, 22 May 2023 18:44:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>,
        yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
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
 <68953040-1622-254b-f6f8-b279eccacfb1@kernel.org>
 <c88dcbc3-d530-3e9e-f674-a2fe64ad5fdc@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c88dcbc3-d530-3e9e-f674-a2fe64ad5fdc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 17:00, Jason Yan wrote:
>> OK, so the issue is that __ata_scsi_find_dev() calls ata_find_dev() with devno
>> == scsidev->id. This leads to devno being 0, 1, 2 and 3 for connected drives
>> sdd, sd1, sdf and sdg, as shown by lsscsi. However, each drive has its own
>> port+link, with the link for each one having  ata_link_max_devices() == 1, so
>> ata_find_dev() works only for the first drive with scsidev->id == 0 and fails
>> for the others. A naive fix would be this:
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 7bb12deab70c..e4d6f17d7ccc 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2718,7 +2718,7 @@ static struct ata_device *__ata_scsi_find_dev(struct
>> ata_port *ap,
>>          if (!sata_pmp_attached(ap)) {
>>                  if (unlikely(scsidev->channel || scsidev->lun))
>>                          return NULL;
>> -               devno = scsidev->id;
>> +               devno = 0;
>>          } else {
>>                  if (unlikely(scsidev->id || scsidev->lun))
>>                          return NULL;
>>
>> And running this on my setup, it works. This makes libsas added ports/devices
>> look like AHCI ones, where all devices have ID 0 for the !pmp case.
>>
>> However, I am not sure this would be OK for all setups...
>>
>> John,
>>
>> Any idea if there is any cases where libsas managed drives would endup not being
>> correctly identified by this change ? As long as a device always has its own
>> port, I do not see any issue. But is there a case where we could have multiple
>> devices on the same port ? Per libata, max is 2, and that is only for the IDE
>> master/slave case. Otherwise, it is always 1.
>>
> 
> AFAIK, libsas does not support multiple devices on the same port. So 
> this change is ok for libsas.

Yes, for libsas it is OK. But as is, it will break master+slave IDE setups... So
the fix needs to be finer than this.

> 
>> Not that looking at the pmp case, I am not confident at all that the
>> identification is correct for libsas. But I do not think that anyone would ever
>> connect a pmp box to a libsas HBA...
>>
> 
> libsas's does not support pmp either, and I do not see any future plans 
> to support pmp.

Good. Dealing with that one is always painful.

> So the above change (needs a ATA_FLAG_SAS_HOST check) looks good to me.

Yes, this flag check is needed to avoid breaking IDE/pata.

> It's better to make libsas behave as other ata drivers so that we can 
> drop the ATA_FLAG_SAS_HOST check. But this need tons of work for libsas.

Yes, getting rid of this special casing with this flag would be really nice. It
should not be needed. I will try to write a proper fix not using it for now, to
facilitate removing the flag later.


-- 
Damien Le Moal
Western Digital Research

