Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156075F5CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJEWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJEWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:42:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF184E65
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665009756; x=1696545756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ye+uJQBPHDM9vZs8/S/YO83O6sbzCLI89NCuhi8PVy0=;
  b=K9zb+BRDW7RVwKPFX7SLf6VV2DKC1IgRDFD/DPvTg3FBCxhIJy0UKAFR
   6H5y9aNM8A67oENAa1bEbK+wRnY2pTsImdE10/ELUOpGaYfHSPuQkUCqP
   j0U+/F20dQM3Hb08eWO1ZyuRQXUnbhRYtcBFmwdCCdUhjAxSZMVg5801s
   L0xqVnubWmIelzZhqf9ssi8ZHA4SNaB+zGNVqa2dTUEqHQHdIrzx+qCJ+
   STg94KBd40P8QHK2YnYBYNJpfebIBDq292zTNoRa9dGI01si/LBU44r/i
   vHyUW0G2eW2ds39QSNR5ENNa+JXH6ixpf/JCCNq/rHefk2J5IDpESYuB3
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="325184299"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 06:42:35 +0800
IronPort-SDR: Z2MZW0VT9ro+oGwwVU4G8vdWL34ZxyvAdNj0Ivgf35jXjeKkqAc2kBK+JM3fMbf+b/4zTRrJJ7
 pa/r6anBYy/wLQoZ3UNT/+2d95MWyznyyRruZi1RwNkgOD6V9v7QywZORk42dHI7GLhqAz1FnB
 uhQCQcRNfsTS2KnLuAtjVfWhMH42tKga0mcIcu/E2UeadBeN1YKmcHIUYYyDtmc8ljiefvUBL9
 kjkOe8d6YdZRfDVKaU7451+FEfsu7gd01q/I50Vd5GwqsWc2+Wbbcb0MtsNcCDqx4yTCH1Y2dQ
 Xa1Grrs6UMTwsilfVtGFQUUk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 14:56:47 -0700
IronPort-SDR: p/X49+wkvZo37mGW2DPTcZ92vBYYHP5n6zmmlsn1VnuN8vnUFdwqefqYczNo4AcqIKnhkSg/gh
 DWZ8OLBe3Mqi/3Mhw3Lai/AKciOQKGU00sXoFanIGvxJlgRwG0UKVfDXj2kt+OC+im092riIly
 JxV6G/5EJx20a62nkvxWSPxuED2LG066un0b9l91FjMO9kbFno90AHWRmsKRW0QbTO0pQxkEg3
 7nNkEC4shgGda7zq2qORtVaS/egxMQwpaownWDof5BPfrkB+mAlCKFOooTaFVlVnHA2+Fsh9nP
 SSQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 15:42:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjV2M21l4z1RvTr
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:42:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665009754; x=1667601755; bh=Ye+uJQBPHDM9vZs8/S/YO83O6sbzCLI89NC
        uhi8PVy0=; b=jWQE/xJ1HLeNMnc2londrG5iQCi+dAUm3xodwP6t4nFXoMWtzV2
        36Nyc0JHxvdIl41SnQ0EFsO9sj6c30ikFQAH6lrwt765s2/jqZUuX8usMTtK56jm
        CW1IjKLsdwvDNpGkQiSd5ah1X/EUmzTMan9Bb/G2zV8LkTBJOiLqIV8wsSTCJ0ZD
        gesOV2VV15KAHBE2XPjoKGIViIJ9KunYBYMq30L0BIt9mTZAn10NcE42+qREGxzC
        arWK4rrNjn0dhdHaQ/iVpXEFCZP9NKR+brvZnwHmv6ZGmM9Qg5t4C9laR16uYuQq
        0K0P5R268n2CMIacRFPbnmaDSpg12mbfuBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OpKJ6Lv40e63 for <linux-kernel@vger.kernel.org>;
        Wed,  5 Oct 2022 15:42:34 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjV2J3vw3z1RvLy;
        Wed,  5 Oct 2022 15:42:32 -0700 (PDT)
Message-ID: <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 07:42:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     John Garry <john.garry@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yz4BLTPkXqyjW4a4@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 07:11, Niklas Cassel wrote:
> On Thu, Oct 06, 2022 at 06:36:05AM +0900, Damien Le Moal wrote:
>> On 10/6/22 06:28, Niklas Cassel wrote:
>>> On Wed, Oct 05, 2022 at 09:53:52AM +0100, John Garry wrote:
>>>> On 04/10/2022 15:04, John Garry wrote:
>>>>
>>>> Hi Niklas,
>>>>
>>>> Could you try a change like this on top:
>>>>
>>>> void sas_ata_device_link_abort(struct domain_device *device, bool
>>>> force_reset)
>>>> {
>>>> 	struct ata_port *ap = device->sata_dev.ap;
>>>> 	struct ata_link *link = &ap->link;
>>>>
>>>> +	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY;
>>>> +	device->sata_dev.fis[3] = 0x04;
>>>>
>>>> 	link->eh_info.err_mask |= AC_ERR_DEV;
>>>> 	if (force_reset)
>>>> 		link->eh_info.action |= ATA_EH_RESET;
>>>> 	ata_link_abort(link);
>>>> }
>>>> EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
>>>>
>>>> I tried it myself and it looked to work ok, except I have a problem with my
>>>> arm64 system in that the read log ext times-out and all TF show "device
>>>> error", like:
>>>
>>> Do you know why it fails to read the log?
>>> Can you read the NCQ Command Error log using ATA16 passthrough commands?
>>>
>>> sudo sg_sat_read_gplog -d --log=0x10 /dev/sdc
>>>
>>> The first byte is the last NCQ tag (in hex) that failed.
>>
>> libata issues read log as a non-ncq command under EH. So the NCQ error log
>> will not help.
> 
> Hello Damien,
> 
> John explained that he got a timeout from EH when reading the log:
> [  350.281581] ata1: failed to read log page 10h (errno=-5)
> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
> 
> ata_eh_read_log_10h() uses ata_read_log_page(), which will first try to read
> the log using READ LOG DMA EXT. If that fails, it will retry using READ LOG EXT.
> 
> Therefore, to see if this is a driver specific bug, I suggested to try to read
> the NCQ Command Error log using ATA16 passthrough commands:
> 
> $ sudo sg_sat_read_gplog -d --log=0x10 /dev/sdc
> will read the log using READ LOG DMA EXT.
> 
> $ sudo sg_sat_read_gplog --log=0x10 /dev/sdc
> will read the log using READ LOG EXT.
> 
> Neither of these two suggested commands are NCQ commands.
> (Neither command is encapsulated in a RECEIVE FPDMA QUEUED,
> so I'm not sure what you mean.)
> 
> 
> Garry, I now see that:
> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
> Your port is frozen.
> 
> ata_read_log_page() calls ata_exec_internal() which calls ata_exec_internal_sg(),
> which will simply return an error without sending down the command to the drive,
> if the port is frozen.
> 
> Not sure why your port is frozen, mine is obviously not.
> 
> ata_do_link_abort() calls ata_eh_set_pending() without activating fast drain:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-eh.c?h=v6.0#n989
> 
> So I'm not sure why your port is frozen.
> (The fast drain timer does freeze the port, but it shouldn't be enabled.)
> It might be worthwhile to see who freezes the port in your case.

Might come from the command timeout. John has had many problems with the
pm80xx HBA in his Arm machine from a while back. Likely not a driver issue
but a hw one... No-one seems to be able to recreate the same problem.

We need to try the HBA on our Arm board to see what happens.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

