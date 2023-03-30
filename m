Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB16D0260
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjC3LBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjC3LA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:00:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05E8691
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680174058; x=1711710058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4lDbixJMPcd5wP9wYZ11Y/OsJSzsmhAS1PKVDV6/1dg=;
  b=ATimJNTBfaCkQ5uJDGKjKBLuodXPOoq3RxUwCegMelHEJgxAvUwUwNPg
   Ge5KSEfKbFYWRF0cf/xb24Z0+LJkaiAZjBU3J6fe6idkyMSmhlEOJSMuI
   Kwl6JRmlD/DX9PjGDFmrxmT/jmXqt6MZiQjd6KAowM7iKW/nwl83xVGoB
   m7R5rsLuVQqf2TvyENRkKaZ7jl/0rGsKwCgdlwJAszwo3tJE8JpET2NIN
   A/hJF/bp5LSzh7CcwWfvvhqo0GNQCuT4FisITkqEtD1vSaHq/7zRTW9eI
   nJVdnEoqmfEmn7pZcYqZksoOTsZjIT48tTU1kMSa46qUgCWYtXcuzulGT
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="226873571"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 19:00:58 +0800
IronPort-SDR: wSEEvWKjltsQoA4+qesVaucTOQBL8PH1E9tHcTY4QNuPSO7gRUZI+BcDm5JGcBawkUhK+9kAOl
 FMPJW2hjlN7VhVo0rPzuA7SZvVHnGKm165xlCYkH9zfbu4Ri3rWgNDRvfZn6Lbq1QwQW1rWek8
 GMTzmNF+UiLtkT88fdtLb+K35dwCGDzR0wamdNo1+1F5k5Jw/NbBpsdfVoZgWC/rj8MFRjKxjx
 N14v8sDRTgb19en3nGE//GFKhvf/amOgeYd3XxzezTEJ8ntgAK313Amixbr5TARWxZwjHrwY0W
 fyU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:17:06 -0700
IronPort-SDR: a+EdcWho6Mkh1CPUP+0refOTY70iBvf/Z7MNMtWYQTDDQAhECAv8ydb7yqyiY2mgklXY+L8Xdf
 RYoo9j2E7O8yngCFQIVBXtNHQwCIS3mYr8qejWCJj2z3Phu/J/oN1LQu6gewo6oLKDNUjrNYLN
 eyDKqA4cPcDKMrqu/oE7rL31sgOaWhU+s3D2TcwnMfipIDKCJbjl21LqOshM6tdBpFtJ9G6CVx
 MwRfH04FFPZ31PNnksY6IHk9F8m9/boQRDy6UxDG6va8n0WcdbEdIoONHyX4J7P4IKRibojA5r
 rQg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 04:00:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnL7Z242dz1RtVt
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:00:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680174057; x=1682766058; bh=4lDbixJMPcd5wP9wYZ11Y/OsJSzsmhAS1PK
        VDV6/1dg=; b=Tf9YmTi6cSEPYhNBcVj29Y6QaK8WCeH3ODUk5xdxDZcFBBt9WbU
        W5pkvplm+C9y1YR5ajmopLRQUFIvarb0X1YYk8DLPZCztt5Vsiejz8kPt3fK6aS6
        MpfoPpsJLNACxfXlZp9eQcGs9JzjxFFimpOjJRFyM+GLEi4F3WZcZt8SnA7rmqFD
        ImBy/QhjZmBzfTaIbRxGK07vzHN12cpL53FK6M+5tWo9Sxz/vJxQgS7vDd7IFN7O
        ZhwCT7laeDEY143I6X1PhGmLKgp71nIBlK78UQvr55NMackD0GX/liCbCPMnMp+4
        S7thKGZbBdq1oR8gts3nv9o0z8U5U6OiRhg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WvXWLmPLeNDu for <linux-kernel@vger.kernel.org>;
        Thu, 30 Mar 2023 04:00:57 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnL7X2KcYz1RtVn;
        Thu, 30 Mar 2023 04:00:56 -0700 (PDT)
Message-ID: <97a2129c-b1d8-de74-014a-07e89ae95b30@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 20:00:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: return -ENOMEM when kzalloc failed
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20230330023834.97455-1-jiapeng.chong@linux.alibaba.com>
 <73695d8e-a779-3c9c-5a46-b5a23381dff2@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <73695d8e-a779-3c9c-5a46-b5a23381dff2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 16:59, Chaitanya Kulkarni wrote:
> On 3/29/23 19:38, Jiapeng Chong wrote:
>> The driver is using -1 instead of the -ENOMEM defined macro to specify
>> that a buffer allocation failed.
>>
>> drivers/target/iscsi/iscsi_target.c:691 iscsi_target_init_module() warn: returning -1 instead of -ENOMEM is sloppy.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4644
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>   drivers/target/iscsi/iscsi_target.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
>> index 834cce50f9b0..d3a40c3caaf5 100644
>> --- a/drivers/target/iscsi/iscsi_target.c
>> +++ b/drivers/target/iscsi/iscsi_target.c
>> @@ -688,7 +688,7 @@ static int __init iscsi_target_init_module(void)
>>   	pr_debug("iSCSI-Target "ISCSIT_VERSION"\n");
>>   	iscsit_global = kzalloc(sizeof(*iscsit_global), GFP_KERNEL);
>>   	if (!iscsit_global)
>> -		return -1;
>> +		return -ENOMEM;
>>   
>>   	spin_lock_init(&iscsit_global->ts_bitmap_lock);
>>   	mutex_init(&auth_id_lock);
> 
> you can also just use goto out, it has return -ENOMEM, no biggy..
> Also, it will be useful to print the error message here as we
> are making this change..

Printing an error message for allocation failures is frowned upon. Checkpatch
will complain.

-- 
Damien Le Moal
Western Digital Research

