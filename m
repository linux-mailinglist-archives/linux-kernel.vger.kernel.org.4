Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32477652BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiLUEAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:00:01 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93F1022
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671595201; x=1703131201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x75bHZHEUWl0iFLgcRBohFMshs2LLAhyBh4URz+y8R4=;
  b=PfbAekJYQLUNTAJphL4H41bcT4sd+YfJf3gNK3Ax0z2wwrYnPdIR8Z5K
   zmcgykr1fORPenJicw4STSHvZOPNFfRonb4n4G6LMH7avnUy2sSw+VySl
   PIawxoDlzDUSDU+IqOZanth0NFDCLzbclbYx1MRNmTPyE/2vw0wRMG3h7
   TuaOjfW92SGCkVwUdzDFIgrGPVf1gYIY0G/cb6ExlYN5DHgYfBU20dHZi
   JanUa5SMES1lNCSzCE5TMPkM4rusKqTrsK9HIK1qy5PZTxQP9S67TxFDw
   UEz4Q1mbJzYW4glBD4onpDUHahPsEvQY3dj7NF9ibiSQ0sxTJ5AHIAFP0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,261,1665417600"; 
   d="scan'208";a="323485731"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 11:59:59 +0800
IronPort-SDR: nd4YVgZoFTdhUHMqpYZYWMmYZbv8TngCTTCd82N/krPNOw7LyG8062fsjfApNsg1FCf5/LOYJ1
 Pj5S0N2HKSBSKIHEd7ru6zCp7kcz8w1/ggiOAbveYpmyv1xijY/WBEGeSib7HhYn/jtYpipkvt
 jOGhTQeGxVFKiutcwRcrO+4nP9+RgYPfi2oml6XHxvemvE894Lg36SpSGNqE0C8xUrtjH4UUov
 Kae1U2j8Y9Ky0Bw8tUsq67sdEs4gP4teEfIY3bUzSOGtoE6w48YAloPkK2GQGch6TcMMfkZTAS
 DP4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 19:12:29 -0800
IronPort-SDR: DpAxVR7YgOd0a+g4nskdLq6HhySRFrt956Uwr67Oy0bzbsJSyeNeOK/WMht2tiD+MZXUbj7c52
 9M5vV1GzRq68r+Q8axCEhYel170thatCkGpEgjBLMKeSX9weV+5aN9o4azUWgIGNl3TT/yrBuJ
 JaTFxpDMVFwUyc9gZ1PayLrPivWWNNvVXqSiVr5gfStCWrs3s6QBpUf7UsYrfYeAWUU0NUL9Yo
 TJ9qhocNeKD7vxoUhZMv9I804qdCSJM0E9CFT7ebULdbDZiMuz2usBvciU/TlBj4U6/hT/eaUS
 9mY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 20:00:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcKTV6j4pz1RvTr
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:59:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671595198; x=1674187199; bh=x75bHZHEUWl0iFLgcRBohFMshs2LLAhyBh4
        URz+y8R4=; b=YqEG4pXF67jFgCcjnnQY+ofO2YuodPsFRbU/FHv2JKCYYo7hFJ3
        6VizM97Uo/0VyfsQC/LNlQ81TY4tz4cC+LEYEqMUVszTFDIT9fhdaNDVLvUo6fxm
        LQqe00Zt4vbepzD1OLuzA0s7s3UZ7NWWPgKfrpwDmYTXuDwCmRoMRgyaxEPv0P1w
        /f4HzLTXkjT3lPvzQDhbdwZ4Wu5I39foxN2TqBb18gvgUcmsH1y1Lmkmo6AoPevI
        6W2aINeq9AVlIffZwbwOAa1BBA4WLOxRbueGJeDX5xJU6Uw+jjnmKKSd05iSUHh6
        lSGXatI0FVULa7b/ITQsmg3Nc86Li2PCZog==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 61mVd8B_tZUO for <linux-kernel@vger.kernel.org>;
        Tue, 20 Dec 2022 19:59:58 -0800 (PST)
Received: from [10.89.80.120] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcKTS3G3Lz1RvLy;
        Tue, 20 Dec 2022 19:59:56 -0800 (PST)
Message-ID: <4ff0ca00-31f5-2867-ff59-cecb5d6d1048@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 12:59:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, niklas.cassel@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
 <c8387766-2ca0-51f3-e332-71492b13e5c1@opensource.wdc.com>
 <7347d117-6e0b-dd18-90a8-25685f757689@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7347d117-6e0b-dd18-90a8-25685f757689@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 11:42, Jason Yan wrote:
> On 2022/12/21 8:36, Damien Le Moal wrote:
>> On 2022/12/20 23:59, John Garry wrote:
>>> On 20/12/2022 12:53, Xingui Yang wrote:
>>>> Grab the host lock in sas_ata_device_link_abort() before calling
>>>
>>> This is should be the ata port lock, right? I know that the ata comments
>>> say differently.
>>>
>>>> ata_link_abort(), as the comment in ata_link_abort() mentions.
>>>>
>>>
>>> Can you please add a fixes tag?
>>>
>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>
>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>>
>>>> ---
>>>>    drivers/scsi/libsas/sas_ata.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>>>> index f7439bf9cdc6..4f2017b21e6d 100644
>>>> --- a/drivers/scsi/libsas/sas_ata.c
>>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>>> @@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>>>    {
>>>>    	struct ata_port *ap = device->sata_dev.ap;
>>>>    	struct ata_link *link = &ap->link;
>>>> +	unsigned long flags;
>>>>    
>>>> +	spin_lock_irqsave(ap->lock, flags);
>>>>    	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>>>>    	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>>>>    
>>>> @@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>>>    	if (force_reset)
>>>>    		link->eh_info.action |= ATA_EH_RESET;
>>>>    	ata_link_abort(link);
>>
>> Really need to add lockdep annotations in libata to avoid/catch such bugs...
>> Will work on that.
> 
> Actually in libata there are many places calling ata_link_abort() not 
> holding port lock. And some places are holding the real host 
> lock(ata_host->lock) while calling ata_link_abort(). So if you add the 
> lockdep annotations, there may be too many warnings. If these are real 
> issues, we should fix them first.

libata-EH does most of its work without the port lock held because by the time
we get EH started, we are guaranteed to be idle with no commands in flight. That
is why the calls you mention look like "bugs" but are not.

lockdep annotation will be a little tricky, but not too hard to do either.

> 
> Thanks,
> Jason

-- 
Damien Le Moal
Western Digital Research

