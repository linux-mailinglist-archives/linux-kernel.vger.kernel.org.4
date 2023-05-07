Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3766F991B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjEGPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEGPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298B7EF5;
        Sun,  7 May 2023 08:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B935560E09;
        Sun,  7 May 2023 15:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C08C433EF;
        Sun,  7 May 2023 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683471784;
        bh=tyMJVdXEq4oCoHCPYlSJKEY5GmMz0MTWHInscNM+1lk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H6dE5fi1rymlSBMXaQgjrnyB6XL8gL1nhUcKsuTdU+L738FJFQwmr0jep1lWcJ9ce
         LV8XZLoxoyfZ+WwCbWZem7y7gk4vX9QNSE1dwN1SU96xEpHS8vtOb0nCOEAo5mczHx
         l4P9rKuo6xMl2PmsmZSj8Mv00zwGGEpOjteA7Yg5WHVSGZyBlvkWUfVm72417pnhV5
         opArf7LoWpdQ2N30BQEufwt7A3e10Rn5DmqHa/u9winMRQNGw/98rINJZtB5JSSHfp
         wtsfqUH/BZWFKxaPkbQZeypjX2R+KbhOHMgv8VielJaU3qkVUJaRZy2Fdjj2jf/7/9
         9mjUni4tRpVXQ==
Message-ID: <087b77f8-3ff2-87ce-d197-e238b8ad9047@kernel.org>
Date:   Mon, 8 May 2023 00:02:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
 <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
 <cae0ac63-f391-08c0-c646-23037485c189@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cae0ac63-f391-08c0-c646-23037485c189@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/05 18:51, John Garry wrote:
> On 05/05/2023 10:14, yangxingui wrote:
>>> hmmm... is it really acceptable that libata is referencing libsas? I 
>>> didn't think that it would be. libsas uses libata, not the other way 
>>> around.
>> Yeah, I didn't expect that either. Is there any other way? If so, is 
>> patch v1 OK?
> 
> I still think that we can do better than v1.
> 
>>>
>>>>>   #include <linux/libata.h>
>>>>>   #include <linux/hdreg.h>
>>>>>   #include <linux/uaccess.h>
>>>>> @@ -2745,10 +2746,17 @@ static struct ata_device 
>>>>> *__ata_scsi_find_dev(struct ata_port *ap,
>>>>>    *    Associated ATA device, or %NULL if not found.
>>>>>    */
>>>>>   struct ata_device *
>>>>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device 
>>>>> *scsidev)
>>>> Why drop the const ?
>>>>
>>>>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>>>>   {
>>>>> -    struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>>>>> +    struct ata_device *dev;
>>>>> +
>>>>> +    if (ap->flags & ATA_FLAG_SAS_HOST) {
>>>
>>> And this is SAS host. Not necessarily libsas (even though with ipr 
>>> libata usage gone, it would be the only user).
>> Add a new flag only for libsas?
> 
> No, because of previous reason.
> 
> Please remind me - at what point do we error within ata_scsi_find_dev() 
> and return NULL for a libsas host?
> 
> Note: it would be good to include that commit message for future reference.
> 
> Maybe we could add a method to ata_port_operations to do this lookup. I 
> assume that is abusing ata_port_operations purpose, since it's mostly 
> for HW methods.
> 
> Or do we actually use sdev->hostdata for libata or libsas? If not, maybe 
> we could store the struct ata_device pointer there.
> 
> I'm just thinking out loud now...

Agree. Ideally, libasas should not be any different than a for a drive used with
ahci/sata/pata adapters. After all, all of them are scsi devices as well. So we
need to understand why this happens only with libsas and correct the device
setup there.

-- 
Damien Le Moal
Western Digital Research

