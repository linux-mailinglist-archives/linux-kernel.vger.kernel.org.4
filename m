Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D829E6F9916
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEGO71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1951991;
        Sun,  7 May 2023 07:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A3A61045;
        Sun,  7 May 2023 14:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEB2C433EF;
        Sun,  7 May 2023 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683471563;
        bh=NeAOdMPVtUbV6szYveAYO+EqW1OkvAu1L9rmW8uT9u4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M/TzFL/qt16WRTKQlMCUu/IZS+drjx9iCT6VhRbscxJFkaeuM6eW+QDFcvTNLWQgy
         ICl+fxmZgxA6MLLx48O06/HKNR/qODbpvQ1L/CtwdvaaiMsCKh/vhdpOp9q0ooRfFM
         w/gAEw6bdUDX+zcMZgJ1A9usOSW41y79w9eWOedoZIuah7toVDO10cOV8MoV3E2b6a
         4LwOuSh++NIHJ42Sb3qmX7gpnq9SaSC2hHOZMO0DZiWj5BxQqY+aoV8TlI9/cbbxoe
         j2VATwA0Ikt0X4pBm0J5PDya/XMOZBwVq5Iso2ur1AMhZtKKD2MeDgZgstkKcjyZfT
         qXdRcQPmbjqXA==
Message-ID: <50bd90dc-d66a-ba7a-4b05-b2455d97e1ee@kernel.org>
Date:   Sun, 7 May 2023 23:59:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     yangxingui <yangxingui@huawei.com>,
        John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <b13c9445-39c5-f207-d5d0-d6c86eee54ae@oracle.com>
 <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1b703656-e966-63f8-19dd-33e4e9914676@huawei.com>
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

On 2023/05/05 18:14, yangxingui wrote:
> 
> 
> On 2023/5/5 16:25, John Garry wrote:
>> On 05/05/2023 09:17, Damien Le Moal wrote:
>>>> --- a/drivers/ata/libata-scsi.c
>>>> +++ b/drivers/ata/libata-scsi.c
>>>> @@ -26,6 +26,7 @@
>>>>   #include <scsi/scsi_device.h>
>>>>   #include <scsi/scsi_tcq.h>
>>>>   #include <scsi/scsi_transport.h>
>>>> +#include <scsi/libsas.h>
>>
>> hmmm... is it really acceptable that libata is referencing libsas? I 
>> didn't think that it would be. libsas uses libata, not the other way 
>> around.
> Yeah, I didn't expect that either. Is there any other way? If so, is 
> patch v1 OK?
>>
>>>>   #include <linux/libata.h>
>>>>   #include <linux/hdreg.h>
>>>>   #include <linux/uaccess.h>
>>>> @@ -2745,10 +2746,17 @@ static struct ata_device 
>>>> *__ata_scsi_find_dev(struct ata_port *ap,
>>>>    *    Associated ATA device, or %NULL if not found.
>>>>    */
>>>>   struct ata_device *
>>>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device 
>>>> *scsidev)
>>> Why drop the const ?
>>>
>>>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>>>   {
>>>> -    struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>>>> +    struct ata_device *dev;
>>>> +
>>>> +    if (ap->flags & ATA_FLAG_SAS_HOST) {
>>
>> And this is SAS host. Not necessarily libsas (even though with ipr 
>> libata usage gone, it would be the only user).
> Add a new flag only for libsas?

ATA_FLAG_SAS_HOST is now only used by libsas. So we should rename this flag to
ATA_FLAG_LIBSAS_HOST to be clear about it. And looking at how the flag is used
(in only 2 places), I wonder if we could get rid of it entirely...

With the ipr driver gone, there is a lot of cleanup in libata that can be done,
especially around EH code. Will be working on that.

> 
> Thanks,
> Xingui
> .
>>
>>>> +        struct domain_device *ddev = sdev_to_domain_dev(scsidev);
>>>> +
>>>> +        return sas_to_ata_dev(ddev);
>>> Do you really need the ddev variable ? Also, this really should be a 
>>> libsas
>>> helper. I beleive this pattern is repeated in several places in 
>>> libsas, so that
>>> would nicely clean things up.
>>>
>> Thanks,
>> John
>> .

-- 
Damien Le Moal
Western Digital Research

