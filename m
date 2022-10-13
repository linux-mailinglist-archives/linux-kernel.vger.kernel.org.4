Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D65FD4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:39:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979EE13B8C5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665643173; x=1697179173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uJc158K4W2hw0iQaOQBYQKdiLHOecWko3rbMNtw2AOw=;
  b=UWl6/Y2yktK8EZJqBtdGNnSqlLH4GfLKDIVgmZtWf6iIxb1UpjodzNQH
   t6Z2L28I4jcPPxFWixyiUr4yxWneb2VslMqouj7OAk95JyJUWs3IkqdLj
   kO0cdCRTZmUWfjAkPtJnn3RaLCAmL3KeX4q1MkvYm0Dnl/ohyDQeUvniX
   0THDKGngMvGPKegiZLa9taZN2hqqHwzf1agZK83pSfLnEDOcjEKeawb9t
   PA6gKvAHOjprX2UvjqWedbg/IF9uTeYWAd5KCL/+tuaiDGHqazuw/PM6J
   0FfzQ63hm0y2OxzAtBIGLSrFaG+DQcY44Dbzti5s01Q1058Zc/u4BDBox
   g==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="325775771"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 14:39:29 +0800
IronPort-SDR: NgewGMfHhbsv13FFAJHWDPDWip2nxp2fKY9nJVc+tT1I43uKHAstDhl/8yjztg0nN0rIK0O4T6
 CxqPorCqEgg/7EuSD0FFzMesqC0koTWJt4bKnT7jl8zBPF10MGSG9Dy7T5utG1rqOlY9HCCBDA
 EDWUWbY/i3Sc2To9ET3fcYRKXSUyJBUx68DIueP0Rgu1PiEQK7fWpoyQyb6VxjodLpOQ0CXMqz
 HYVOzUBNk3BC2ZwxNlyO426vQHlrC5ZUoFXa+cPWieEkFQpgR+w7AYY3OIv2FP8HFZVXoAJ8Df
 NvmfXQecPl1fUzBNzUb5KMMx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 22:59:07 -0700
IronPort-SDR: 61AT1Avz4hGS11WI609/K1gFEHAbashIAMArQ2f45rFNMlsk59jzAmcdZshbma6KxCZHx2kDX1
 pCY83cHaN3a+jC+H6wojmWhmlPxL7waR3SLGQLaQbAZm8SIhg1dheF8CNPWkpseunfLLeEH7bW
 x3R0KQwq2vOuhH8OBEnem7A8COgyXLt/RgBJw6x8CgMUe+sDp7j41tY/lyACkHpj8wUdOgU+KJ
 iHcMbF/zZgvTtuFScnW5ALMYb+bekQFOKZZzX3R7dDT2cZ7tjKt4c0ehEfYWteO4bIX4iGwqzu
 /yQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 23:39:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mp0HP2dDWz1RvTr
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:39:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665643168; x=1668235169; bh=uJc158K4W2hw0iQaOQBYQKdiLHOecWko3rb
        MNtw2AOw=; b=sueWSG7Lb5KZPShDSCKfksbSVRS2Y2SBGgaKdgijZtHO/yBYkYz
        neBkS+I97VThBwRGgo1wDPJ3jG5RuWPO/JH+pHn7YE9q8gviBgXY+GupX9k7OG+7
        rTb1DQyiLAJbGZihRP0vzQjw9OCFh9WDvFoykeE7MxQkhcRv1TszzpSAIw8hOwBa
        tpZqNwU6M3gPSWK+rdxNWqvfk+p1pOv5Wq5dHl9z041h7oELV/yjF/tGyEgbPeYJ
        xVnXlXPHuEsme6t9VqWcaWp5p3gvuvqjk0UZhWspYaIE8bTAnot18ZkyfXpqq3Pa
        BzbJ17sacaSYl9pG0PfxAPbzJpTRFPllu1w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wf1UOaQoHqLo for <linux-kernel@vger.kernel.org>;
        Wed, 12 Oct 2022 23:39:28 -0700 (PDT)
Received: from [10.89.85.169] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.169])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mp0HM5BCnz1RvTp;
        Wed, 12 Oct 2022 23:39:27 -0700 (PDT)
Message-ID: <45f33e3e-c1a7-7183-bf04-83649af8ac04@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 15:39:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, Li kunyu <kunyu@nfschina.com>
Cc:     jejb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com
References: <0e67aa4d-f66e-f392-5950-31b1c90c287b@opensource.wdc.com>
 <20221013044927.278854-1-kunyu@nfschina.com>
 <badf255f-df60-fbc7-0f61-c69b99ebbaa6@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <badf255f-df60-fbc7-0f61-c69b99ebbaa6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 15:26, Jason Yan wrote:
> 
> On 2022/10/13 12:49, Li kunyu wrote:
>>
>> This is defined in the 4.19 kernel:
>>
>> #define sd_printk(prefix, sdsk, fmt, a...)                              \
>>          (sdsk)->disk ?                                                  \
>>                sdev_prefix_printk(prefix, (sdsk)->device,                \
>>                                   (sdsk)->disk->disk_name, fmt, ##a) :   \
>>                sdev_printk(prefix, (sdsk)->device, fmt, ##a)
>>
>> #define sd_first_printk(prefix, sdsk, fmt, a...)                        \
>>          do {                                                            \
>>                  if ((sdkp)->first_scan)                                 \
>>                          sd_printk(prefix, sdsk, fmt, ##a);              \
>>          } while (0)
>>
>>
>>
>> Most of the sdsk used in the macro definition has only one sdkp.
>>
>>
>> This is defined in the v6.0-rc7 kernel:
>>
>> #define sd_printk(prefix, sdsk, fmt, a...)                              \
>>          (sdsk)->disk ?                                                  \
>>                sdev_prefix_printk(prefix, (sdsk)->device,                \
>>                                   (sdsk)->disk->disk_name, fmt, ##a) :   \
>>                sdev_printk(prefix, (sdsk)->device, fmt, ##a)
>>
>> #define sd_first_printk(prefix, sdsk, fmt, a...)                        \
>>          do {                                                            \
>>                  if ((sdsk)->first_scan)                                 \
>>                          sd_printk(prefix, sdsk, fmt, ##a);              \
>>          } while (0)
>>
>> Use sdsk in macro definition.
>>
>>
>> I did report an error when compiling sd. o in the 4.19 kernel. It was modified to say that no more errors were reported in sdsk. Can I continue the 6.0-rc7 writing method here.
>>
> 
> You should backport the mainline patch to 4.19, not create a new one.

Yes, but since the mainline patch has a typo, better fix it and backport the fix
too with a "Fixes" tag.

My point about the proposed patch was to make the reverse change to fix the
macro: use sdkp instead of sdsk since the former is used everywhere and clear.
But sure, since this is not causing any issue, no strong need to fix the macro.
It is really ugly as-is though :)

> 
> commit df46cac3f71c57e0b23f6865651629aaa54f8ca9
> Author: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
> Date:   Tue Feb 5 11:10:48 2019 +0100
> 
>      scsi: sd: Fix typo in sd_first_printk()
> 
>      Commit b2bff6ceb61a9 ("[SCSI] sd: Quiesce mode sense error messages")
>      added the macro sd_first_printk(). The macro takes "sdsk" as argument
>      but dereferences "sdkp". This hasn't caused any real issues since all
>      callers of sd_first_printk() have an sdkp. But fix the typo.
> 
>      [mkp: Turned this into a real patch and tweaked commit description]
> 
>      Signed-off-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
>      Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 1080c85d97f8..5796ace76225 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -132,7 +132,7 @@ static inline struct scsi_disk *scsi_disk(struct 
> gendisk *disk)
> 
>   #define sd_first_printk(prefix, sdsk, fmt, a...)                       \
>          do {                                                            \
> -               if ((sdkp)->first_scan)                                 \
> +               if ((sdsk)->first_scan)                                 \
>                          sd_printk(prefix, sdsk, fmt, ##a);              \
>          } while (0)
> 
> 
> 
>>
>> .
>>

-- 
Damien Le Moal
Western Digital Research

