Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E705F7174
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiJFW5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:57:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B6BEAC4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665097035; x=1696633035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LwClfZbzR0TpVsgrkzGgItOdvQ+OZDNgNqpEqYtDLV8=;
  b=YVDJzYstEihHt0L6kNm6VaVOsGthx3nvJ54jBs+zEQ6XZK+e+bhx6YIv
   mmEbCCP9/W1UlMotEJKc9gE0uUkE5oXBbZCH9M/3/BUTDofMUHSV2nnbd
   P/V9hCJUgBK2FqAq7RlszoPx65iZ6kfdrJHpZDkEI3IO+fNxeMF52aLPg
   ZxbzlWUyS/Xa/WugcHKMloqbK3C/QYWR7wPbYTqbTtJQxndIkiT2zW5/M
   MrgV26RAlSxe5dq11eboFgcpnTGK6x1LswuXThZ7h2H1au9h3GQPbjowZ
   lcvVBeqHLDzrviVfetL7hcaDac/h4N7lEystFf2t2G1/d/0bBNEQeIeov
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="218363292"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 06:57:14 +0800
IronPort-SDR: PBSciygjBjaHXzw/4fYuNCI2mbU3MKdQ99xn8Sk2sbLF9IahtnFRWL6L7HFNbY1CMcVwWfz7Yr
 Drzc0Ac/HeObqKo8B3ahUaSZnz2BOMgbzkdcINqiB6/rh+VZC6RY6AlONvb5DhmuyyZEIyVmXO
 oY/OAezdYQ04UHm2XExcM3HYV/bhTiiFlWXTTumOL60wqHSqgUoc28gKB2iSOtXEKrdGOyfVzK
 hdr9MEaIVTwe0xxsk2K82M2vzidaBm9O1u0z7JQJaJzwt5Vn64d79lmADUkRY0oww70CUqQShs
 en7n4bjqoKdQSIB1l+TOfe7j
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 15:17:00 -0700
IronPort-SDR: M1DMp4nXUCoxZzTVIH3QpM2ht7/o1QBbD1oGHnGiVFg3hnl+Ch2Xn5TWx4WmwlpZhy3G4fdqR8
 OcGpGuxFflPKQ6RN/2G+bRuQCDS4WJDl1aN1J8LCx7/VT62Kto4bSTPZzabWhl2ZrlHlyp3DA7
 sNxzm+m9cG0ajH9VSv7lGictz/8/AyIG0Hm0C0yqkjvEyNVH2g229SV5D1+5OgRO7XvzgKsaf2
 KaKk/pJcK9PM0zds1sHNjN/C/3MCLg6tdjqCL7tYF84Svw+ozwsyO5l9XFe0ipP/UbkeyYHI9Z
 raI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 15:57:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk6Jp2RKnz1RwvL
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:57:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665097032; x=1667689033; bh=LwClfZbzR0TpVsgrkzGgItOdvQ+OZDNgNqp
        EqYtDLV8=; b=BMN+KLY/bouLeLU9bZB//3GL75vLKBxICZqZAfD10O7T9ktk2TW
        EuO5a1i43L0ZZ3XcNtWfQCN3kjkYAiTP3b5ytwHjTg9GIjRgipLRO11QgPgiGErS
        DGAmriYpGQNhFXWaFEWJc2TXpx6h9wILLqqdwlpt8xsWIoQiu4p4z1GcD0M3cSNB
        l6iupwmPl2S8h6IIJq+pv1MUzWySdS9S/Y+4LN7+7FWR4fdV19QfCbTUxupmVVC6
        ZUPxdmBSYqlgkoTRGeQkHxxczdPLozfHZHWpDpy3RRKOkns99uytpsxIYP19IZOI
        e4/NrT+zQZ5mxJttp5SgiBP1YnvFYIcwKvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3DVugNQIg9yt for <linux-kernel@vger.kernel.org>;
        Thu,  6 Oct 2022 15:57:12 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk6Jk6k7qz1RvLy;
        Thu,  6 Oct 2022 15:57:10 -0700 (PDT)
Message-ID: <932dd4a0-e713-c5da-ebf5-1566a3d4a327@opensource.wdc.com>
Date:   Fri, 7 Oct 2022 07:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        John Garry <john.garry@huawei.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
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
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yz7qD+gpmI1bdw16@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 23:45, Niklas Cassel wrote:
> On Thu, Oct 06, 2022 at 09:33:23AM +0100, John Garry wrote:
>> On 05/10/2022 23:42, Damien Le Moal wrote:
>>>> Hello Damien,
>>>>
>>>> John explained that he got a timeout from EH when reading the log:
>>>> [  350.281581] ata1: failed to read log page 10h (errno=-5)
>>>> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
>>>>
>>>> ata_eh_read_log_10h() uses ata_read_log_page(), which will first try to read
>>>> the log using READ LOG DMA EXT. If that fails, it will retry using READ LOG EXT.
>>>>
>>>> Therefore, to see if this is a driver specific bug, I suggested to try to read
>>>> the NCQ Command Error log using ATA16 passthrough commands:
>>>>
>>>> $ sudo sg_sat_read_gplog -d --log=0x10 /dev/sdc
>>>> will read the log using READ LOG DMA EXT.
>>>>
>>>> $ sudo sg_sat_read_gplog --log=0x10 /dev/sdc
>>>> will read the log using READ LOG EXT.
>>
>> Note that I can't get a distro to boot on this system from the HDD for the
>> same timeout problem (so no tools easily available).
>>
>>>>
>>>> Neither of these two suggested commands are NCQ commands.
>>>> (Neither command is encapsulated in a RECEIVE FPDMA QUEUED,
>>>> so I'm not sure what you mean.)
>>>>
>>>>
>>>> Garry, I now see that:
>>>> [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action 0x6 frozen
>>>> Your port is frozen.
>>>>
>>>> ata_read_log_page() calls ata_exec_internal() which calls ata_exec_internal_sg(),
>>>> which will simply return an error without sending down the command to the drive,
>>>> if the port is frozen.
>>>>
>>>> Not sure why your port is frozen, mine is obviously not.
>>
>> I think that it gets frozen when the internal command for read log ext times
>> out. More below about that timeout.
> 
> ata_read_log_page() will first try to read using READ LOG DMA EXT.
> If that fails it will retry with READ LOG EXT.
> 
> Your log has this:
> [  350.257870] ata1.00: qc timeout (cmd 0x47)
> 
> So it is definitely ATA_CMD_READ_LOG_DMA_EXT that times out.
> 
> On timeout, ata_exec_internal_sg() will freeze the port:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c?h=v6.0#n1577
> 
> When ata_read_log_page() retries with the port frozen,
> READ LOG EXT will obviously fail (since the port is frozen).
> 
> Not sure why READ LOG DMA EXT would timeout for you...
> Perhaps your drive does not implement this command,
> and incorrectly reports supporting this command via
> ata_id_has_read_log_dma_ext().
> 
> Perhaps you could try boot your kernel with libata.force=nodmalog
> on the kernel command line, so that ata_read_log_page() will use
> READ LOG EXT on the first try.
> 
> 
> Damien, it seems that there is no use in retrying if the port
> is frozen/we got a timeout, so perhaps:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e74ab6c0f1a0..1aa628332c8e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>         if (err_mask) {
>                 if (dma) {
>                         dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
> -                       goto retry;
> +                       if (err_mask != AC_ERR_TIMEOUT)
> +                               goto retry;
>                 }
> 
> or:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e74ab6c0f1a0..2fa03b7573ac 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>         if (err_mask) {
>                 if (dma) {
>                         dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
> -                       goto retry;
> +                       if (!(dev->link->ap->pflags & ATA_PFLAG_FROZEN))
> +                               goto retry;

Yes, something like this is needed. Though I would prefer having a little
ata_port_frozen() helper for the condition.

>                 }
> 
> would be in order, so that we actually print the real error, instead of a bogus
> AC_ERR_SYSTEM (returned by ata_exec_internal_sg()) when the port is frozen.

yep.

>>
>>>>
>>>> ata_do_link_abort() calls ata_eh_set_pending() without activating fast drain:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-eh.c?h=v6.0#n989
>>>>
>>>> So I'm not sure why your port is frozen.
>>>> (The fast drain timer does freeze the port, but it shouldn't be enabled.)
>>>> It might be worthwhile to see who freezes the port in your case.
>>> Might come from the command timeout. John has had many problems with the
>>> pm80xx HBA in his Arm machine from a while back. Likely not a driver issue
>>> but a hw one... No-one seems to be able to recreate the same problem.
>>>
>>> We need to try the HBA on our Arm board to see what happens.
>>>
>>
>> Yeah, it just looks to be the longstanding issue of using this card on my
>> arm64 machine - that is that I get IO timeouts quite regularly. I should
>> have mentioned that yesterday. This just seems to be a driver issue.
> 
> Out of curiosity, which arm64 SoC is this?
> 
> While it is very unlikely that this is your problem, but I've encountered
> an issue on an ARM board before, where the PCIe controller was incorrectly
> configured in device tree, causing the controller to miss interrrupts,
> which presented itself to the user as timeouts in the WiFi driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97131f85c08e024df49480ed499aae8fb754067f
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

