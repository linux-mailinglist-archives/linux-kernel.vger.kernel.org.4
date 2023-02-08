Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460568EF62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjBHM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:56:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05EBB4A20B;
        Wed,  8 Feb 2023 04:56:44 -0800 (PST)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6229E203B41F;
        Wed,  8 Feb 2023 04:56:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6229E203B41F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675861004;
        bh=hIyrhydIQJAz1+mLJZ3NXAMgFDv6A+5TbDZt8dN6ZOs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c//rjRFlXiWMZ6M0aRgFTWQVzTmG0m08gqCv6XzF7OREw+jjMjwQX8Zwt+OTKgg98
         Z9cin/nOMvo8fHHfnmZmI2WpPUiNaGpdoxvDeKOpN9+Rqp9RhCXqVQP2ZVYRlOVtm0
         3fYSdhAw0d8v2v73+1ICjCjyU+sGN8AvgC9dIGK4=
Message-ID: <13d4b5cb-247f-817a-5699-9cdcc4c46713@linux.microsoft.com>
Date:   Wed, 8 Feb 2023 13:56:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 7/8] crypto: ccp - Skip DMA coherency check for
 platform psp
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-8-jpiotrowski@linux.microsoft.com>
 <9a6a152e-1c60-6300-88ce-85b835d3d198@amd.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <9a6a152e-1c60-6300-88ce-85b835d3d198@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 21:42, Tom Lendacky wrote:
> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>> The value of device_get_dma_attr() is only relevenat for ARM64 and CCP
>> devices to configure the value of the axcache attribute used to access
>> memory by the coprocessor. None of this applies to the platform psp so
>> skip it.
>>
>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---
>>   drivers/crypto/ccp/sp-platform.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
>> index 281dbf6b150c..b74f16e0e963 100644
>> --- a/drivers/crypto/ccp/sp-platform.c
>> +++ b/drivers/crypto/ccp/sp-platform.c
>> @@ -29,6 +29,7 @@
>>   struct sp_platform {
>>       int coherent;
>>       unsigned int irq_count;
>> +    bool is_platform;
> 
> s/is_platform/is_platform_device/
> 

ok

>>   };
>>     #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>> @@ -190,8 +191,10 @@ static int sp_platform_probe(struct platform_device *pdev)
>>       sp->dev_specific = sp_platform;
>>       sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
>>                        : sp_get_acpi_version(pdev);
>> -    if (!sp->dev_vdata && pdev->id_entry)
>> +    if (!sp->dev_vdata && pdev->id_entry) {
>> +        sp_platform->is_platform = true;
> 
> Move this into the sp_get_plat_version() function.
> 
>>           sp->dev_vdata = sp_get_plat_version(pdev);
> 
> And I probably should have made this comment in the previous patch, but you should probably spell out platform here.
>

ok (i had done that before i got to this comment for consistency)

>> +    }
>>       if (!sp->dev_vdata) {
>>           ret = -ENODEV;
>>           dev_err(dev, "missing driver data\n");
>> @@ -205,7 +208,7 @@ static int sp_platform_probe(struct platform_device *pdev)
>>       }
>>         attr = device_get_dma_attr(dev);
>> -    if (attr == DEV_DMA_NOT_SUPPORTED) {
>> +    if (!sp_platform->is_platform && attr == DEV_DMA_NOT_SUPPORTED) {
> 
> Just a nit but I'd prefer to see this as:
> 
>     if (attr == DEV_DMA_NOT_SUPPORTED && !sp_platform->is_platform) {
> 
> The diff is easier to see that way.

makes sense

> 
> Thanks,
> Tom
> 
>>           dev_err(dev, "DMA is not supported");
>>           goto e_err;
>>       }
