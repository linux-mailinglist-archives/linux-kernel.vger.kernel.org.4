Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E412683AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaXqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjAaXqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:46:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76C4FCC0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675208788; x=1706744788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/2/tPt2lOPGt+BK5mB0mLm3FeAsziHvCuFj9uXyq6js=;
  b=QRAgLE0r56dZnZYMnIr8/u679CwyUu98aucRZR8eTl1HKFJCZyLWSDta
   Se/M1ZPbrviL64z6QvJiWWXjOtP2wu2a5JlGmETEHg1kLvp87cHT3sJu2
   id2nmbB8E5NcKgVtArtd+TBdD1uKnnmzm0BGee5G3g86OvssptqNDra2o
   17K6qVdHmyJF5ETHu0FoZWw/54TBsPEEEDpC2csjrtfavzZ8WVJA7O00z
   MzR6mAmGJACiba+a6Hck82WX56VO0ixXla/bheIJq+ko/ab+bhdeMc4pu
   TH990E6ajvX8bVBu2FChc67RltvZJKpFc7silllBaWlkVTLjtIOthVYTb
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669046400"; 
   d="scan'208";a="222011967"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2023 07:45:47 +0800
IronPort-SDR: xawAdefHAW4EOUsoci011izY4NK95B9nDQ6l7AbVWh5vQCr0B0e8m1PHh9DXUw+xUhAy0VizPR
 GjEUS9oeOeZ/8EnX6PEkUJEYD85UP1kCg9/fJPUUkdOwiOMlbZdVL3NDvSinFyHb7UK05ssvx+
 4QK38V2WfTJgApNAiGtKxoArApqs70y5mw8souYJTk2B6obvuPbxPFHUlFUnUvU//ZeQwxPnSH
 7LXOewOlUPPM5Mfg+QJdOILaOG+9LKjKF+NGKE1bN5gU2e/HHSGycl+r0+uM5wGyoVzrmFAz+s
 4ac=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:03:12 -0800
IronPort-SDR: hYX6ILSbjbdXZxPA5OGKQsFwy+duiN2oND7ylrJu1PXb0gpqkNSVCUqAxETg+YT2iPuoGJlBkN
 iCcJ0m6iBpqbQcIDQLtYiaHqiqXR1UvY90FQobx+jhdq5zFTX7BhXUioyB3/dtarEHODTh1YJf
 800ODWMLhy2bGbq1QcRNNJmca6ZJL4u7zu0JdQiuqHS0AoV+55gtObQC3hdMorl6IW+y/V5VTg
 us/QvBkhRwfelqrcTIQgftkmEmjLXeyfjD3/EWaPkODUxR01F55hlHHe7FVqOme7CMdEPuqo11
 Emc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:45:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P61rq4Zqdz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:45:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675208746; x=1677800747; bh=/2/tPt2lOPGt+BK5mB0mLm3FeAsziHvCuFj
        9uXyq6js=; b=SjFPtlBDUTKaavmkZsHhXDgF2saakxFPzPOfEvKPZhIwiGYkY4d
        tAxvGT744W3GRyosiUpyWOrNiDvegl+iVr6In4cIc3ukb5KiM+ZfLEb1sRX5sHk8
        UfW6vbYh7lN8YqbMQwRviZ30b51E4Fa8sSZm+XfLrG3TkgQCzLn8fspPITRL1Tjt
        703GixhO8GNDUaLqLhQaPngPSyr7o/V3c5wZ2V0SXZJjoFj/h8NpVUXl8s5m3y3V
        3me1sBujNgv+UFjG40Um85SD04RTPnEFbsudJjXdi9039Zt69ogGpyYLgCGoHN6x
        MEdWEfngSyKf8VfUczz4wpncbRGToUtPenA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G6PKSpyieDON for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jan 2023 15:45:46 -0800 (PST)
Received: from [10.89.81.171] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.171])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P61rn6BcPz1RvLy;
        Tue, 31 Jan 2023 15:45:45 -0800 (PST)
Message-ID: <ec536f74-00d7-1f25-e903-278809e33ed9@opensource.wdc.com>
Date:   Wed, 1 Feb 2023 08:45:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libata: clean up some inconsistent indenting
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
 <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
 <d5a59ca8-1b17-9cf2-80d0-3e267e558fd5@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5a59ca8-1b17-9cf2-80d0-3e267e558fd5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/31 21:33, Sergey Shtylyov wrote:
> On 1/31/23 2:26 PM, Damien Le Moal wrote:
> [...]
>>> No functional modification involved.
>>>
>>> drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>> ---
>>>  drivers/ata/pata_serverworks.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
>>> index c0bc4af0d196..c6bd9e95d4e8 100644
>>> --- a/drivers/ata/pata_serverworks.c
>>> +++ b/drivers/ata/pata_serverworks.c
>>> @@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
>>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
>>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
>>>  
>>> -		 /* If the returned btr is the newer revision then
>>> -		    select the right info block */
>>> -		 if (rc == 3)
>>> -		 	ppi[0] = &info[3];
>>> +		/* If the returned btr is the newer revision then select the right info block */
>>
>> Very long line. Please make that a proper multi-line comment.
> 
>    Perhaps the material of a separate patch?

Since this patch touches this comment, the fix should be correct from the start.
I do not see the point of having a different patch fixing a patch that was ideal
to start with...

> 
>> And the patch title should be:
>>
>> ata: pata_serverworks: clean up indentation
> 
>    Yes!
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

