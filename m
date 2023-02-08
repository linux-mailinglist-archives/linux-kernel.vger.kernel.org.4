Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61268EF53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBHMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjBHMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:49:00 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5B045231;
        Wed,  8 Feb 2023 04:48:59 -0800 (PST)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id E722F203B41F;
        Wed,  8 Feb 2023 04:48:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E722F203B41F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675860538;
        bh=m2UZGw4LRKpUDCphB6szCpitw1pKqr+oXASlc/ublls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CGxTortYHRozdT30JGTZN1OnuEDzAyHrqS2D9fFKj9uw9JNM70mFK+j+u7JoET473
         IUlS6U1CoJtBFUh3fSVETk244tYRcmaXnmF9OxsTuP9ui8ObKjfW3G6bPOgnlSXkke
         Mi3tQ6LxN450G+njdhdU2ac3xHiFEjZ0f2BfXSD4=
Message-ID: <354a02a2-7335-4600-ee38-b9a57f5381ec@linux.microsoft.com>
Date:   Wed, 8 Feb 2023 13:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 5/8] crypto: cpp - Bind to psp platform device on x86
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-6-jpiotrowski@linux.microsoft.com>
 <272a68e1-ca89-ff30-81e3-79dfcf211615@amd.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <272a68e1-ca89-ff30-81e3-79dfcf211615@amd.com>
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

On 31/01/2023 20:51, Tom Lendacky wrote:
> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>> The PSP in Hyper-V VMs is exposed through the ASP ACPI table and is
>> represented as a platform_device. Allow the ccp driver to bind to it by
>> adding an id_table and initing the platform_driver also on x86. At this
>> point probe is called for the psp device but init fails due to missing
>> driver data.
>>
>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---
>>   drivers/crypto/ccp/sp-dev.c      | 8 ++++++--
>>   drivers/crypto/ccp/sp-platform.c | 7 +++++++
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
>> index 7eb3e4668286..52b8d957d0f6 100644
>> --- a/drivers/crypto/ccp/sp-dev.c
>> +++ b/drivers/crypto/ccp/sp-dev.c
>> @@ -258,7 +258,11 @@ static int __init sp_mod_init(void)
>>       ret = sp_pci_init();
>>       if (ret)
>>           return ret;
>> -
> Please keep the blank line here.>

ok
 
>> +    ret = sp_platform_init();
>> +    if (ret) {
>> +        sp_pci_exit();
>> +        return ret;
>> +    }
> 
> Add a blank line here.
>

ok

>>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>       psp_pci_init();
>>   #endif
>> @@ -286,7 +290,7 @@ static void __exit sp_mod_exit(void)
>>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>       psp_pci_exit();
>>   #endif
>> -
> 
> Please keep the blank line here.
>

ok

>> +    sp_platform_exit(); >       sp_pci_exit();
>>   #endif
>>   diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
>> index 7d79a8744f9a..ea8926e87981 100644
>> --- a/drivers/crypto/ccp/sp-platform.c
>> +++ b/drivers/crypto/ccp/sp-platform.c
>> @@ -56,6 +56,12 @@ static const struct of_device_id sp_of_match[] = {
>>   MODULE_DEVICE_TABLE(of, sp_of_match);
>>   #endif
>>   +static const struct platform_device_id sp_plat_match[] = {
> 
> s/plat/platform/
> 

ok

> Thanks,
> Tom
> 
>> +    { "psp" },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(platform, sp_plat_match);
>> +
>>   static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
>>   {
>>   #ifdef CONFIG_OF
>> @@ -212,6 +218,7 @@ static int sp_platform_resume(struct platform_device *pdev)
>>   #endif
>>     static struct platform_driver sp_platform_driver = {
>> +    .id_table = sp_plat_match,
>>       .driver = {
>>           .name = "ccp",
>>   #ifdef CONFIG_ACPI
