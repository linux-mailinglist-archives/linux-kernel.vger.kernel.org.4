Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4434A70BC27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjEVLsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjEVLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C599FAA;
        Mon, 22 May 2023 04:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64162615C1;
        Mon, 22 May 2023 11:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7BBC4339E;
        Mon, 22 May 2023 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756076;
        bh=k67MFS8V9LYxjMTds9Q4HRsZBrBFA2bqwNkkrXZrHr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I+J1Yj3YgOtgoMIyYMf0dCcMQVvwmPReczJBO79s5QDE9J+D9PayliEp3VHtSNeCD
         7MOpGgMKCqwfbYrYjkvYNTINjLUvmQY+/Bi8DhsAQJ2Dng2tc70rSQ4rqgnYO3tlsd
         A+qKrzPgOalPfi01BOLVRh9r5PmRHY0OHYTGQ9tq0hCHIH0+nX25Ht1uIPVWqLIq/6
         t39QtPSctJXNNtI0vas/isCaWzhWg6rDKlj1wh+phwEkKRsVw+zPZD0tNSSe/qkb9h
         1969l7wk6rkRTYA9BdT/Rak8+TQgmvxJ1jTzjqCY4oUK9AO0yqECTQAY50jJqPfOPS
         opplunzuNUtTg==
Message-ID: <2a5f6751-7120-1ea8-1a1e-d401b433a34a@kernel.org>
Date:   Mon, 22 May 2023 20:47:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
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
 <43d5ba4a-efc7-09ae-74dc-81b19f635a19@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <43d5ba4a-efc7-09ae-74dc-81b19f635a19@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 20:28, John Garry wrote:
> On 22/05/2023 09:00, Jason Yan wrote:
>>
>> OK, so the issue is that __ata_scsi_find_dev() calls ata_find_dev() with 
>> devno
>> == scsidev->id. This leads to devno being 0, 1, 2 and 3 for connected 
>> drives
> 
> This numbering comes from sas_rphy_add():
> ...
> if (identify->device_type == SAS_END_DEVICE &&
>      (identify->target_port_protocols &
>       (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA)))
> 	rphy->scsi_target_id = sas_host->next_target_id++;
> 
> ..
> 
> 	scsi_scan_target(&rphy->dev, 0, rphy->scsi_target_id, lun,
> SCSI_SCAN_INITIAL);
> }
> 
> So libata and scsi_transport_sas just use different sdev id numbering 
> schemes for host scan.
> 
>> sdd, sd1, sdf and sdg, as shown by lsscsi. However, each drive has its own
>> port+link, with the link for each one having  ata_link_max_devices() == 
>> 1, so
>> ata_find_dev() works only for the first drive with scsidev->id == 0 and 
>> fails
>> for the others. A naive fix would be this:
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 7bb12deab70c..e4d6f17d7ccc 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2718,7 +2718,7 @@ static struct ata_device *__ata_scsi_find_dev(struct
>> ata_port *ap,
>>           if (!sata_pmp_attached(ap)) {
>>                   if (unlikely(scsidev->channel || scsidev->lun))
>>                           return NULL;
>> -               devno = scsidev->id;
>> +               devno = 0;
> Would this pattern work:
> 
> ata_for_each_dev(ata_dev, link, ALL) {
> 	if (ata_dev->sdev == sdev)
> 		return ata_dev;
> }

That would work too I think, even though a loop is a bit ugly...

> 
> If not, I think it's ok to have devno = 0 assignment under SAS_HOST 
> flag, even though it's far from ideal. Not both of these are not 
> preferred, then, as I mentioned before, some per-port callback to do the 
> conversion.

See the proper patch I posted a few min ago (I cc-ed you). I do not use SAS_HOST
flag :)

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

