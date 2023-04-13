Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F66E14EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDMTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDMTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:13:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDBC1;
        Thu, 13 Apr 2023 12:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSNkxv9idKsmuYlbY6EWKoDIFHgJ67MIaFdXhfcDzXGlXC+C5DA2Zw0Io+WSVBAT5wLggIJOpvyNGeP1wp4LShYii3j49eW2igjKwM1LaDVMug8Z8makoY4cyVevV4yqmvjTYqLVHVTiJLpMh9/euX9N+zb4gMIPLep8iUQPHHPL6hSijvW7SSdIYrr1t4FlfSAsNkJFTl9vtLmmSkgai5gkDIms1xcwQ4bBnLQ9fmaFv7MJK5pxUNKyMZH7XUTFZmfFXKCSeAudFJcc9sxIWNAy7Oygj7fS87NtOGJah11fsJH4AnGBwmkLC3mxeygUz1oO6ZhqZysqjh9hzOm4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEGv0BWqamv9csQEUo4kJgK+63vlSRS8IZr0xwh5M10=;
 b=kSKqA3Gp0WRX9kc6rKmlL/1+UVfY/RlN3CZxWSb+EyLHQtt7h9j+0o1h0mxq09w0j+LOYPibee2hP6aytmkfJ+kVTPhW0F7AbyDN1QktVRrMQc1Cv9RXThci2qj7+3f7P/jmSmFEA8wMbBq5T4cLEXfxj7c63oN9UleE7/EFQ5bZVwbzmrf+eMc6E/gXlKm9Hir2SB6y/tsbPblAjyMywatujTPECRp6gcorh33v0CCmrHCIeFeqPsY/LQ8TwEyfX9UBkaCI8K5449+PYcs/G68a3yoCU6+ti3xDVy+4RrSkZa1A9R4NRUbOtJxxHGbsByDM64B8giXLbolC1nvnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEGv0BWqamv9csQEUo4kJgK+63vlSRS8IZr0xwh5M10=;
 b=qTiVF8rsYyqr1Tc9dvENAElLnATy6WkSKfwOVCE8EH/61okN+YYQ8Eb76vRIJT1VOLUB13FEaOJ9M3gRxhQw2cQbrJxfR1Ggn5oqgiLPGoTICZINQwJmJea9dYmc6g4M965cHo6PzfSnjC6kun5qRLHixv5xceMG8DY6EweRsjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 19:13:19 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 19:13:19 +0000
Message-ID: <8d2690d8-9418-e2da-8834-6457a60a67cb@amd.com>
Date:   Thu, 13 Apr 2023 14:13:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-2-terry.bowman@amd.com>
 <20230413163050.00006bfb@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230413163050.00006bfb@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:610:e6::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4f10fe-6464-4387-66c2-08db3c532428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jdP8jBvzx46EncJPH27+3lde6QC4r6RDw74TLBi/xBejTsOWRkERcRBwadRXe5Gf59utEFfJ05Rk3jPDPyGGfZ7CLHzKjJXLcISbdadrEkSufjyKLVxZqycbJxR/1bJDZHIAsqBK7reWE5pbmCF8BDRj1XLdw8s9kKKXC7OBLd/xEH5Xs2RsRQW6w8wP9tyoetGGQjB8mQwUJWB/KjaxW9mZnII+4s66vWZc72iUHE+yOjdFbIz72EVm4cK4MsdFgmyUia3hkA0WqT/DQoQ2hEdV13U7CAckZGGoyU4QCOb7iYcS+CPSqa89OrR7pvvm2tgT/bO+UNLEK4hu3OD/mHQvuIm9sNI+FXPvMmDyB15WwBUf1nWnRO2c28n117cTuPF7mN0aZ5QgXxz89eMOwngRdqSh/Lz6a0gJDdg997BDDSmFtdMcnDMKbsH13KRuTAYCqauBRbGuw+nqXva6ot4Wh+zdYAKSGNLU38s+8+pqzORo8LXmjOf0Wa0ihnneTmSMnbkvkN6Dj6wdlEMsiGxTIyU2xuimAC18TZbF3Ib/JM5VPVhzaT5GTlKBPmCHM+QAqygCnF0gKXyNgVwYn8IqaDT8siYaCP7ZRX/KUPINPp8JwQ2F3GLEfNR2YBoLUvGU/Wuh6wBuoQPHHNU5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(66946007)(66476007)(316002)(6916009)(4326008)(2616005)(66556008)(83380400001)(6486002)(478600001)(8676002)(8936002)(41300700001)(38100700002)(6666004)(5660300002)(2906002)(7416002)(26005)(53546011)(31686004)(186003)(6512007)(6506007)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hUeXJERFhDUEFpbjZzUGlFRVphUi8xTE1lR2Rid0I5M0s1eDdvUEEyaWtM?=
 =?utf-8?B?anNJaXlLc25QN1NzWFo0TUxNbVVJODFBTkk5YWJUeW1la1dacDN2K2lPSmFx?=
 =?utf-8?B?c1lMclZ4NHRiN2FBclFiNkFBSEtrL09hNzFhV1czbFhHQnBnVzhxK04vdmhE?=
 =?utf-8?B?dlJ3NTdjNGRjTnFHREt3cmZFNUNRcExLNWRPazVaY0YyaWkzRzlyWU5peHFF?=
 =?utf-8?B?dm15U1B5YjNhdnU0TUhaM0tMc25Ld1lwNysxakFrc1lEeVExT2l2azVGY01Y?=
 =?utf-8?B?d2hZdjdHT3lHcGdvUnlVVkQ2WEIrZDd0eG9hdGVXblR6QmxiMU8wOWpQMDUz?=
 =?utf-8?B?MDd2YkxGQjIvQWUrYlNFeFhDTUxWQWVoOTAydjFPYUtQR0dVZXhraWVKMmhW?=
 =?utf-8?B?TVorWEc4KzNLNjVXekFwT3JnZ3ZrOG9Fa1Y0ZGNEcWRaanFqQy9TWHJSdHZt?=
 =?utf-8?B?U0Y2RS9wM1RkVTZiS0JYNFNGbW9iWVFTSWpWbjF1bGJvTGJQMUlpSVZ3YnBz?=
 =?utf-8?B?cVlGM2xUY0NlQmZ2UHl0bk9YU2lpZVlWZFRMOGlBc21TalBRSVVMOXpuSUdu?=
 =?utf-8?B?Zjd0K1dINWhxM2x5VkpFQzcwUlNzMTF1RFVJbG0xYVI2OHMwSFh6c2wvZUlq?=
 =?utf-8?B?ZFBRUHg4S3NucXVEOURGNFlFejN1Rld1bDRFM3lnNENxNDlRajlUNnoxSzZh?=
 =?utf-8?B?ajRlQ3Roc2l3aEVNUENTamFCOFFxQlRUMnlmUVdseU1GVzdzcVB5aGhMU3ho?=
 =?utf-8?B?WElhWmdIczlURDZNaUpoTzN4KzVNM1FFaVFRaU1QK0sxamRQTjZtNVV0M0VQ?=
 =?utf-8?B?akNxelJFdnhCalFXS2t4OVZCNFFrNmJjb3hrN2w0TzRqenVTYitwOWFkdWNs?=
 =?utf-8?B?T29wTDVEZHlKM0ZSRnpTVVJWd3FrRi9jOFkxSkllSkV2NFZjcXZlVmRCUm0v?=
 =?utf-8?B?QitQUnQ4dHhwYlozVERPYUF1NHFZc0JDY2lESy9BL2hpQTJKQnh4ZDJOYUVT?=
 =?utf-8?B?eHdmS05WSlNuWVR3ckRwSEpWQ3h6TG5PazI5RmJuUFFFMVcvRVhxMUtVSFJu?=
 =?utf-8?B?T1JnS1BhTEFZeDljWXV2TDgwNmY1M1VKOVFpVFQ5TSs0SVU2SXZNZklJeUpt?=
 =?utf-8?B?QzFqODYxS3BGSEp3eG5tZllweEQ1NHZpVW5KRmtZeHRpRGNMRFZVRWhwbEdw?=
 =?utf-8?B?NXVVbEsrdHE3Rk5GeFZYSkFqZ28vVDBndzZIOTh6Z0RsUlJKaEs3RU9NcW1w?=
 =?utf-8?B?UGxBWEkxWGp6NlF6Mm9xeVRPVTJqZ0x5aDNJcEg5QklBZFV4aFdvNzNGdkt6?=
 =?utf-8?B?OGJRMDg4V3daQnc1dldReTFpcXRPS2srbWhKMW1mR0QwL2Eyak1oZ05WUWFV?=
 =?utf-8?B?UkdIbXJ0dlRsTllMWUExSzQ1ZzZaL2RLOWZRRk1tS0JZZ2hoUm0rL2VBWHJr?=
 =?utf-8?B?SVJoUHpRUjdGN250ZWtnblZCY3dvL1ltRldkZFVkS1prL2hJU1ppb1BrYndY?=
 =?utf-8?B?UVFkUzlFcTBBTEZkdTdJM0R0bjdUKzBobHJYUU5RTWgvSVMweVRVSnpHN0dC?=
 =?utf-8?B?NHo1c2dwei9xaTBlS3FYN0s3LytmdXlhZUhtWExTQUZrcDYrZzNFTVN6anZx?=
 =?utf-8?B?aE5WcmVXUEVGUG9CZVYzZTBFYmdVaXZTenRzdFJXNTZLUVU3QjNMTXN5ZmlN?=
 =?utf-8?B?YWQ0OGRRM3VZZmhSWGxKaWlhdktjTEZ5dWVveG5hRGRXTFF5N2oyV2NRUDha?=
 =?utf-8?B?V1l5bE9QQVhWWXdVaXZneGZWNTlQR1NnRkNtVkRvcFNPQk90YWdhdE4xWGkw?=
 =?utf-8?B?TVhJVHRzd3VpdldhL0hwYkFxMUhCb0d6RHFtb2RSSWd6cHhqbFNncWJTbW5i?=
 =?utf-8?B?aEkrU0hKSmFTY0ZvdWh1eHFSWmJjNzJsSENtQk5XMkU0Q25ZR0hVTG9QajJy?=
 =?utf-8?B?aWpiTHJHYVRjWDBvb1VxQ1NxMnlXeXhFRGMxc0EyUStDMmMzS0pObGdmTmhH?=
 =?utf-8?B?dVFSYVRGd1hxSmJMNndaZVdUa1daWXJFYWdsRGFkWWpwbWNYUVJrckh2ZXFV?=
 =?utf-8?B?T2tmN1poYzZObnJkeHBiNXhkL0xobnpxc3dlUVg3T2ZZZUFCTWxVRVIrODBw?=
 =?utf-8?Q?01ylXBiqRJFAoYlueJrxBHuGm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f10fe-6464-4387-66c2-08db3c532428
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:13:19.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSVwOhpb+Zzogtlx9S7rRi3UQqNajku3GTzLTAkPZa1TLeZI7wNUECw+HlBzDCEywcjcHBph98gTEtQb33mC3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for the review. I added comments below.

On 4/13/23 10:30, Jonathan Cameron wrote:
> On Tue, 11 Apr 2023 13:02:57 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Restricted CXL host (RCH) downstream port AER information is not currently
>> logged while in the error state. One problem preventing existing PCIe AER
>> functions from logging errors is the AER registers are not accessible. The
>> CXL driver requires changes to find RCH downstream port AER registers for
>> purpose of error logging.
>>
>> RCH downstream ports are not enumerated during a PCI bus scan and are
>> instead discovered using system firmware, ACPI in this case.[1] The
>> downstream port is implemented as a Root Complex Register Block (RCRB).
>> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
>> root port.[2] The RCRB includes AER extended capability registers used for
>> reporting errors. Note, the RCH's AER Capability is located in the RCRB
>> memory space instead of PCI configuration space, thus its register access
>> is different. Existing kernel PCIe AER functions can not be used to manage
>> the downstream port AER capabilities because the port was not enumerated
>> during PCI scan and the registers are not PCI config accessible.
>>
>> Discover RCH downstream port AER extended capability registers. This
>> requires using MMIO accesses to search for extended AER capability in
>> RCRB register space.
>>
>> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
>> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Hi Terry,
> 
> Sorry I missed first few versions.  Playing catch up.
> 
> A few minor comments only inline.
> 
> 
> 
>> ---
>>  drivers/cxl/core/regs.c | 93 +++++++++++++++++++++++++++++++++++------
>>  drivers/cxl/cxl.h       |  5 +++
>>  drivers/cxl/mem.c       | 39 +++++++++++------
>>  3 files changed, 113 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 1476a0299c9b..bde1fffab09e 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -332,10 +332,36 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>>  
>> +static void __iomem *cxl_map_reg(struct device *dev, struct cxl_register_map *map,
>> +				 char *name)
> 
> dev isn't used.
> 

'dev' was used earlier for logging that is since removed.

>> +{
>> +
> 
> Trivial but no point in blank line here.
> 

I'll remove it.

>> +	if (!request_mem_region(map->resource, map->max_size, name))
>> +		return NULL;
>> +
>> +	map->base = ioremap(map->resource, map->max_size);
>> +	if (!map->base) {
>> +		release_mem_region(map->resource, map->max_size);
>> +		return NULL;
>> +	}
>> +
>> +	return map->base;
> 
> Why return a value you've already stashed in map->base?
> 
This allowed for a clean return check where cxl_map_reg() is called.
This could/should have been a boolean. This will be fixed with the refactoring 
mentioned below.

>> +}
>> +
> 
> This is similar enough to devm_cxl_iomap_block() that I'd kind
> of like them them take the same parameters.  That would mean
> moving the map structure outside of the calls and instead passing
> in the 3 relevant parameters.  Perhaps not worth it.
> 
The intent was to cleanup the cxl_map_reg() callers.  Using a 'struct 
cxl_register_map' carries all the variables required for mapping and reduces 
the number of variables otherwise declared in the callers. But, I understand 
why a common interface is preferred in this case.

Ok. I'll change the parameters and return value to match devm_cxl_iomap_block(). 

>> +static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
>> +{
> 
> dev isn't used here either. Makes little sense to pass it in to either funtion.
> 
>> +	iounmap(map->base);
>> +	release_mem_region(map->resource, map->max_size);
>> +}
>> +
>>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>>  				      resource_size_t rcrb,
>>  				      enum cxl_rcrb which)
>>  {
>> +	struct cxl_register_map map = {
>> +		.resource = rcrb,
>> +		.max_size = SZ_4K
>> +	};
>>  	resource_size_t component_reg_phys;
>>  	void __iomem *addr;
>>  	u32 bar0, bar1;
>> @@ -343,7 +369,10 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>>  	u32 id;
>>  
>>  	if (which == CXL_RCRB_UPSTREAM)
>> -		rcrb += SZ_4K;
>> +		map.resource += SZ_4K;
>> +
>> +	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
>> +		return CXL_RESOURCE_NONE;
>>  
>>  	/*
>>  	 * RCRB's BAR[0..1] point to component block containing CXL
>> @@ -351,21 +380,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>>  	 * the PCI Base spec here, esp. 64 bit extraction and memory
>>  	 * ranges alignment (6.0, 7.5.1.2.1).
>>  	 */
>> -	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
>> -		return CXL_RESOURCE_NONE;
>> -	addr = ioremap(rcrb, SZ_4K);
>> -	if (!addr) {
>> -		dev_err(dev, "Failed to map region %pr\n", addr);
>> -		release_mem_region(rcrb, SZ_4K);
>> -		return CXL_RESOURCE_NONE;
>> -	}
>> -
>> +	addr = map.base;
> 
> I'd have preferred to see this refactor as a precursor patch to the
> 'real changes' that follow.
> 

Ok. I can make the cxl_map_reg() addition and cxl_rcrb_to_component() refactor 
to a separate patch.

>>  	id = readl(addr + PCI_VENDOR_ID);
>>  	cmd = readw(addr + PCI_COMMAND);
>>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
>> -	iounmap(addr);
>> -	release_mem_region(rcrb, SZ_4K);
>> +	cxl_unmap_reg(dev, &map);
>>  
>>  	/*
>>  	 * Sanity check, see CXL 3.0 Figure 9-8 CXL Device that Does Not
>> @@ -396,3 +416,52 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>>  	return component_reg_phys;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> 
> 
> ...
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 044a92d9813e..df64c402e6e6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -270,6 +270,9 @@ enum cxl_rcrb {
>>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>>  				      resource_size_t rcrb,
>>  				      enum cxl_rcrb which);
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>> +u16 cxl_component_to_ras(struct device *dev,
>> +			 resource_size_t component_reg_phys);
>>  
>>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>>  #define CXL_TARGET_STRLEN 20
>> @@ -601,6 +604,8 @@ struct cxl_dport {
>>  	int port_id;
>>  	resource_size_t component_reg_phys;
>>  	resource_size_t rcrb;
>> +	u16 aer_cap;
>> +	u16 ras_cap;
> 
> This structure has kernel-doc that needs to be updated for these new entries.
> 

I'll add.

>>  	bool rch;
>>  	struct cxl_port *port;
>>  };
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 39c4b54f0715..014295ab6bc6 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -45,13 +45,36 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>  	return 0;
>>  }
>>  
>> +static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
>> +			   struct cxl_dport *parent_dport)
>> +{
>> +	struct cxl_memdev *cxlmd  = cxlds->cxlmd;
> 
> extra space before =
>

Ok. Ill remove the extra space.
 
>> +
>> +	if (!parent_dport->rch)
>> +		return;
>> +
>> +	/*
>> +	 * The component registers for an RCD might come from the
>> +	 * host-bridge RCRB if they are not already mapped via the
>> +	 * typical register locator mechanism.
>> +	 */
>> +	if (cxlds->component_reg_phys == CXL_RESOURCE_NONE)
>> +		cxlds->component_reg_phys = cxl_rcrb_to_component(
>> +			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
>> +
>> +	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
>> +						parent_dport->rcrb);
>> +
>> +	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
>> +						     parent_dport->component_reg_phys);
>> +}
>> +
>>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  				 struct cxl_dport *parent_dport)
>>  {
>>  	struct cxl_port *parent_port = parent_dport->port;
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct cxl_port *endpoint, *iter, *down;
>> -	resource_size_t component_reg_phys;
>>  	int rc;
>>  
>>  	/*
>> @@ -66,17 +89,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  		ep->next = down;
>>  	}
>>  
>> -	/*
>> -	 * The component registers for an RCD might come from the
>> -	 * host-bridge RCRB if they are not already mapped via the
>> -	 * typical register locator mechanism.
>> -	 */
>> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
>> -		component_reg_phys = cxl_rcrb_to_component(
>> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
>> -	else
>> -		component_reg_phys = cxlds->component_reg_phys;
>> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
>> +	cxl_setup_rcrb(cxlds, parent_dport);
>> +
>> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
>>  				     parent_dport);
> As above, I'd prefer to see this refactor done in a precursor patch before the new
> stuff is added.  I like reviewing noop patches as I don't have to think much (so
> can do it when I'm supposedly in a meeting ;)
> 
 
Ok. I'll add an earlier patch that introduces cxl_setup_rcrb() and first moves this 
chunk into cxl_setup_rcrb(). The following patch will replace the cxl_setup_rcrb() 
logic with the AER and RAS discovery.

My understanding is the requested refactoring changes then splits this patch into 
the 3 patches listed below (using git log latest first order): 
- Add RCH downstream port AER and RAS register discovery
- Refactor RCD component discovery into separate function
- Refactor RCRB register mapping into separate function

Regards,
Terry

> Jonathan
>>  	if (IS_ERR(endpoint))
>>  		return PTR_ERR(endpoint);
> 
