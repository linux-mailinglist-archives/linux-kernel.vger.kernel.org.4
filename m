Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428A6E68C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjDRP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDRP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:59:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9D61730;
        Tue, 18 Apr 2023 08:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI0PLuPbZkVsIS45AZGc/bRQhHBN0NdTB4sTKv+Y+QtbuAKXv2AKOzjyqJC9K/uutb1u4ICNE4pplF415RzFhwJuMd8i5h3OpHL5EscJwa/sX/xjvla0uMioLNdEi+G/555Wwi94rm8NtO+x6dW34RqGp0tuDNCqiM3QxQHQqIJNZnxlyJV74mxJ5J/xKe7dECiZY5t/ChriWxROUqJ5WOvsvkHWuYuHsliZtqIwiGpEZ1aZYjj6z/ME5Q/rSd/FP0HWF6pWBcjZNO/W7lXhNGTve7bpB9Hn5m4B6iAtu2yHGoAWJq0KlsdH+LwpiR9CCgT/LLx67NmjoNZBARah1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH5jnHW552gDO21NULMG0hjLY877dpJywj8piuPnMms=;
 b=Q9UPvn9GWdhKMEZi2EZPEOqP8P53itJYD++tpPC/8VoclP98+sjn6prUMzzWf1MYmX9MuCWl3hfVRPinG91HjY8/CGF1bAxvekNZSPvRrv5EAgxKMavY9JoLFHQePRqNSFd9xnlMekX9VYpcoAQPAIiGIBwWfaPq3UOBkOwzL/9T/7qZZ/L18wrgCzgBXlppF/nlcACNhQAZhoEL+KKZnpC83a0kmQFM1xM2dZOzA85/pQvCO/93JOqKTlDmtn5n4wPaiYZbPhajEXWi/ptRcHlr+xy3kizQT0s8SBUsjNVVvcWlMztIP/B5hhDgduMkWWUxv5e+FmnTAtf6npR8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH5jnHW552gDO21NULMG0hjLY877dpJywj8piuPnMms=;
 b=GBhI0xf62uD+rtKwvw7iXqNwFlciDmyTP4d5lNOKmYJDNt8gQuF+5YnkfK4wFbBFYC0eeVWlqvMbn3kXnHv2N0N0zNLMbGK/GDJb7Juk1b0WeepH+icvHy/feK56evlcPUBA9lY1/zlXgQLKRypScJowwOxEMJAjvjF+GIHFTUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 15:59:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 15:59:05 +0000
Message-ID: <00b20c4c-ca10-069c-bd32-4fed0520978c@amd.com>
Date:   Tue, 18 Apr 2023 10:59:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-2-terry.bowman@amd.com>
 <643dcf9eed443_1b66294b5@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <643dcf9eed443_1b66294b5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0447.namprd03.prod.outlook.com
 (2603:10b6:610:10e::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a477fd-0005-41af-0616-08db4025d60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbleeWbIcmTqV5jwvyYF8aG94rKij0yn6XHd+u2VSxdJCq18OGVXX+afynbV0x9iM6CNzK2AH01kVinac8F7tmb9ggsb8x2QEexvKv+1MvsTHPrqjJdv2ft8ugnLl58M+ijPc0MetdmQcOz8Ytts/sJ+2rlfRg17psiV5uMtefDIlHA4Qez88yJQfDE0/thNagKvJg+LbXaidO0/SQWYfeMIyKihh/eCj2lbX7H8hVoblxKSp9VeoNwgxsCgWqmrqRQpR3IdPMsmAG/1iJoYpTY6n2oMcHNz4HOK1en49EGixFg2XzXVM6dLefF8JEsmLMPlGRPopvAxu4ZSHL4owhLBbJGElHrlEWvVJilFMpzNohbgOHEYWyVg80f3lWXKt7pZTkye+cDEsWx2C1A6iWgvk38Wqxy0sp/Z6C3FD52aZpwxtcedNL4R9vplMmT9walsUDMs+TC40WOBxjxIO92PSNzjEzu9KnBbxV15QZkSCAf0Hd9on/78jYBy98iZRsHKYynkUQ7wOCsUjTodBcWwgaYJgtd2aD+mOsz8FD78UbnUaqXl98TCRpl1kfBu13k1qzLTwHaG1AaloWdro0am71Kxp2eHWP+PRuWaJLaD3yi1UFupZZiw425wEKfC5K9I38Wtt8FIkeeyCRSoLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(83380400001)(6506007)(6512007)(26005)(53546011)(31686004)(478600001)(2616005)(6666004)(6486002)(66476007)(66946007)(66556008)(4326008)(316002)(86362001)(186003)(36756003)(41300700001)(7416002)(8936002)(8676002)(5660300002)(30864003)(2906002)(31696002)(66899021)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjYxU3gxd3BoWGRHTGZNd3JPM0dMU3RDVlhtaDZpd3Nuc3JnWlBSdmZUUnA3?=
 =?utf-8?B?TjVQWE1JKzFKMDNIWmZTV3RGaGx6VHBsQ2ZNUUxYQStGVUh2dks3NjZkYmhT?=
 =?utf-8?B?Qm4xR1ZpOWNFT1grZXoyRXhBOWc1akF5ZkNxUGR2dFJkZTMwRUJDanh0ZW1h?=
 =?utf-8?B?UXdzZjZFbEdCSEdzUHc1S01xZ1EydFE1RVk5NTlBRTcyRXNHTm1HUXNNdjBX?=
 =?utf-8?B?czZaaWsyeG5CQldaTGVqQWNSVkNQYk5FbU9xc2xVVVk0RHhScm10WGJGN25B?=
 =?utf-8?B?YllOUDE0M21pYkpVNUhXL25aenVyZ2NySS9vNVVidmxnclIwcG44QmpwMnZK?=
 =?utf-8?B?M0lFb3E2eHBrUmhKL3hJb1BFYlZvaEU3T1JhalhienRKb1FlaGhkTGZBaEVs?=
 =?utf-8?B?VjhsTlVJZE9JNWt3dStTVWFRVDBuRkZZblpvZWwySGxTeEhPSlg0bWlSbE9i?=
 =?utf-8?B?aWZXZkxseEpGS2NFenVqUXVZM3dNbGUxN2NjZ1JUd1o1RjBwYzF6Qy9HWW1H?=
 =?utf-8?B?VWkveitVMHY0Rmh1WDF6VEpwNEMyQ2szclRDdE95bnVaWmwzTTl0eUZIc01j?=
 =?utf-8?B?RkVTTUNHbkgySTJQcFhhVkxwNml4djk2R1BvTTJPUTJNU3R4dWlTVXd4ZWJt?=
 =?utf-8?B?ZUFUejZtaDNWKytwVzZmTThCRE1UcWlqYXF1ZnFUdmdUVUFOVkY3TEtSTWo5?=
 =?utf-8?B?ZEZVZWJrd21rSHBJYlR5cklqeW1rVFRZeXJvZTRlZnhpWktob3k5enZ1TEZM?=
 =?utf-8?B?SGI0ZUR4NTM2S0FxZ3JFZkJoaTR6YStkOFcwcnczUXNIRzhXZitkQ1U0SldG?=
 =?utf-8?B?c3FHMDRubGNCdnVkWWhqVTUzUjQxVGJFRERWNDBwRkMybEVyNjhTQVdHOFQw?=
 =?utf-8?B?V0ZHVzZnUU95UnFoaStsVXJCQzJwM1d6QW5UREFjbmc3UmRzM0EvWFFUMCsw?=
 =?utf-8?B?QXBqb0tETDY0T0RhenltdVZWdGVHeDhxb29QS3Zlbmk0d0JRZ0VJdFRJbFcx?=
 =?utf-8?B?SWN4Mjl1VWd1R0VlS2ZSM2xNOEgvbENJbkYwQVRxU2gzM3U2VUVMbjNZWHQ0?=
 =?utf-8?B?SS9iak1ySXArY1FsVnBYMGROVFFwakUvZzFPejl2WHAzSG51TE9YaG1zUFlr?=
 =?utf-8?B?MWdZb1VrYjR0OWJzbGRiM3AxMnNtclJGTnZIVklxU0tWcEFZcmRQMEhKSzhi?=
 =?utf-8?B?bnRUQTdqQWhGWms5VWUxaWZ2cFJEU0ppc1pZVm9RVE9OUFh3c3dMekw2YWg5?=
 =?utf-8?B?ZmRHNmUrbVo2NGJ2OHhPMmNtaGp1TnlGT0dIVlRyKzRVZE9NN1RMWVdXMGVy?=
 =?utf-8?B?WEgyQjc3a3JZQ21xclluYkVkOUR5cG84OU9KNTBiaG5GaVU1d3NUYjg3NXZw?=
 =?utf-8?B?ODJsQWxxeW4wcjB3SzhqNFp6ekk0L2s2MzBUVjZBTmQ4MjhyQTZqcXhrMC82?=
 =?utf-8?B?RVZZeXdkNE9vZXZqYWJOQlZ1amJXenhndkdHTGxVTWtGc29GaWo1YjVJRzlL?=
 =?utf-8?B?ZUMxT2pFMnFRL3J2eEpjaUJIalltTFV1WW9JK2dpTThQbzRaUFB2NjRJVTF5?=
 =?utf-8?B?ZXIyaUJObDdsYytLME94RmtKSTBpTlU1Y1ZCWUVYYVQyY0c0U1Z6YmVTeDV2?=
 =?utf-8?B?TWJkcFJxcDZoSGlqVmpGR3B1aWU4UEg0MUZiZExZK2txeE10RjgvRnZaY0J3?=
 =?utf-8?B?ZU1nRStrRFloQ01iemZ6U0hmNnp1RDhReFhjZjRNTmoxNUNiU2g1Mi9UR3Ni?=
 =?utf-8?B?ZFdGWXJXTklPckljQ3FwYkJleVJyMWpab2FRY2RWMDFTdVc4akpMamdTbGhm?=
 =?utf-8?B?aWVJZ3FueThjVUJ2eVpmYUZCaVRSNUh0WWFmcFlGLzlWc2o5K1V6dk4zT1Mx?=
 =?utf-8?B?aGpXaVBhM0JuYVRYZVJOVkhBNTVSUWJSMFliUTBkUEl1LzJHbEZlWTRoMXBk?=
 =?utf-8?B?VUZZb2s4NDdIbW1CWlg4Mm9kczdLWHpEMFZGemt1Qm9QQXoyK29CQWJBNFNN?=
 =?utf-8?B?ZWx6Rm91Q3BaSG5aRVpWQVVQSGpQdjdMTksxUGoyTy8rb0t5ZVNjbzFkY3dw?=
 =?utf-8?B?YUVOd3NsRHkvTk4zZEVXTmdrZ3JQaFFONjVYem1lbTRIT2pzdTg3MVNFRmhZ?=
 =?utf-8?Q?dbqEiC7J3pa+uh3ttj28ywfUr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a477fd-0005-41af-0616-08db4025d60a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 15:59:05.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+zbslek2Q0lnwMMN+Ae/HD+F1knxICuJ5Y1ofpmuVc4YBMb+k8PYo2QqArYzqmzOgHmh5HK5qUQtRVlIFu0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the review comments. I added responses inline below.

On 4/17/23 18:00, Dan Williams wrote:
> Terry Bowman wrote:
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
>> +{
>> +
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
>> +}
>> +
>> +static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
>> +{
>> +	iounmap(map->base);
>> +	release_mem_region(map->resource, map->max_size);
>> +}
> 
> Not clear why these new functions are needed vs cxl_map_regblock() /
> cxl_unmap_regblock(), and this refactoring looks unrelated to the
> claimed changes in the patch changelog.
> 
> ...oh, I think I see why you went this way, a potential counter-proposal
> below.
> 
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
>> +
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>> +{
>> +	struct cxl_register_map map = {
>> +		.resource = rcrb,
>> +		.max_size = SZ_4K,
>> +	};
>> +	u32 cap_hdr;
>> +	u16 offset = 0;
>> +
>> +	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
>> +		return 0;
>> +
>> +	cap_hdr = readl(map.base + offset);
>> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
>> +
>> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
>> +		if (!offset) {
>> +			cxl_unmap_reg(dev, &map);
>> +			return 0;
>> +		}
>> +		cap_hdr = readl(map.base + offset);
>> +	}
>> +
>> +	dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
>> +	cxl_unmap_reg(dev, &map);
>> +
>> +	return offset;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, CXL);
> 
>> +
>> +u16 cxl_component_to_ras(struct device *dev, resource_size_t component_reg_phys)
>> +{
>> +	struct cxl_register_map map = {
>> +		.resource = component_reg_phys,
>> +		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
>> +	};
>> +
>> +	if (!cxl_map_reg(dev, &map, "component"))
>> +		return 0;
>> +
>> +	cxl_probe_component_regs(dev, map.base, &map.component_map);
>> +	cxl_unmap_reg(dev, &map);
>> +	if (!map.component_map.ras.valid)
>> +		return 0;
>> +
>> +	return map.component_map.ras.offset;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_component_to_ras, CXL);
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
> 
> Hmm, how about just retrieve this as part of cxl_rcrb_to_component()
> (renamed to cxl_probe_rcrb()), and make an rch dport its own distinct
> object? Otherwise it feels odd to be retrieving downstream port
> properties this late at upstream port component register detection time.
> It also feels awkward to keep adding more RCH dport specific details to
> the common 'struct cxl_dport'. So, I'm thinking something like the
> following (compiled and cxl_test regression passed):
> 

Thanks. I applied to this patchset's base and will include in our next 
revision.

> -- >8 --
> From 18fbc72f98655d10301c7a35f614b6152f46c44b Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Mon, 17 Apr 2023 15:45:50 -0700
> Subject: [PATCH] cxl/rch: Prepare for caching the MMIO mapped PCIe AER
>  capability
> 
> Prepare cxl_probe_rcrb() for retrieving more than just the component
> register block. The RCH AER handling code wants to get back to the AER
> capability that happens to be MMIO mapped rather then configuration
> cycles.
> 
> Move rcrb specific dport data, like the RCRB base and the AER capability
> offset, into its own data structure ('struct cxl_rcrb_info') for
> cxl_probe_rcrb() to fill.  Introduce 'struct cxl_rch_dport' to wrap a
> 'struct cxl_dport' with a 'struct cxl_rcrb_info' attribute.
> 
> This centralizes all RCRB scanning in one routine.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c            | 16 ++++++++--------
>  drivers/cxl/core/port.c       | 33 +++++++++++++++++++++------------
>  drivers/cxl/core/regs.c       | 12 ++++++++----
>  drivers/cxl/cxl.h             | 21 +++++++++++++++------
>  drivers/cxl/mem.c             | 15 ++++++++++-----
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 10 ++++++----
>  tools/testing/cxl/test/mock.c | 12 ++++++------
>  tools/testing/cxl/test/mock.h |  7 ++++---
>  9 files changed, 79 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 4e66483f1fd3..2647eb04fcdb 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -375,7 +375,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
> -	resource_size_t rcrb;
> +	struct cxl_rcrb_info rcrb;
>  	resource_size_t chbcr;
>  	u32 cxl_version;
>  };
> @@ -395,7 +395,7 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  
>  	ctx->cxl_version = chbs->cxl_version;
> -	ctx->rcrb = CXL_RESOURCE_NONE;
> +	ctx->rcrb.base = CXL_RESOURCE_NONE;
>  	ctx->chbcr = CXL_RESOURCE_NONE;
>  
>  	if (!chbs->base)
> @@ -409,9 +409,8 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  	if (chbs->length != CXL_RCRB_SIZE)
>  		return 0;
>  
> -	ctx->rcrb = chbs->base;
> -	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
> -					   CXL_RCRB_DOWNSTREAM);
> +	ctx->chbcr = cxl_probe_rcrb(ctx->dev, chbs->base, &ctx->rcrb,
> +				    CXL_RCRB_DOWNSTREAM);
>  
>  	return 0;
>  }
> @@ -451,8 +450,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	if (ctx.rcrb != CXL_RESOURCE_NONE)
> -		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
> +	if (ctx.rcrb.base != CXL_RESOURCE_NONE)
> +		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid,
> +			&ctx.rcrb.base);
>  
>  	if (ctx.chbcr == CXL_RESOURCE_NONE) {
>  		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
> @@ -466,7 +466,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	bridge = pci_root->bus->bridge;
>  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
>  		dport = devm_cxl_add_rch_dport(root_port, bridge, uid,
> -					       ctx.chbcr, ctx.rcrb);
> +					       ctx.chbcr, &ctx.rcrb);
>  	else
>  		dport = devm_cxl_add_dport(root_port, bridge, uid,
>  					   ctx.chbcr);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4003f445320c..d194f48259ff 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -920,7 +920,7 @@ static void cxl_dport_unlink(void *data)
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> -		     resource_size_t rcrb)
> +		     struct cxl_rcrb_info *ri)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
> @@ -942,17 +942,26 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	    CXL_TARGET_STRLEN)
>  		return ERR_PTR(-EINVAL);
>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> -		return ERR_PTR(-ENOMEM);
> +	if (ri && ri->base != CXL_RESOURCE_NONE) {
> +		struct cxl_rch_dport *rdport;
> +
> +		rdport = devm_kzalloc(host, sizeof(*rdport), GFP_KERNEL);
> +		if (!rdport)
> +			return ERR_PTR(-ENOMEM);
> +
> +		rdport->rcrb.base = ri->base;
> +		dport = &rdport->dport;
> +		dport->rch = true;
> +	} else {
> +		dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> +		if (!dport)
> +			return ERR_PTR(-ENOMEM);
> +	}
>  
>  	dport->dport = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
> -	if (rcrb != CXL_RESOURCE_NONE)
> -		dport->rch = true;
> -	dport->rcrb = rcrb;
>  
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
> @@ -994,7 +1003,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	struct cxl_dport *dport;
>  
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, CXL_RESOURCE_NONE);
> +				     component_reg_phys, NULL);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> @@ -1013,24 +1022,24 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
>   * @component_reg_phys: optional location of CXL component registers
> - * @rcrb: mandatory location of a Root Complex Register Block
> + * @ri: mandatory data about the Root Complex Register Block layout
>   *
>   * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>   */
>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t component_reg_phys,
> -					 resource_size_t rcrb)
> +					 struct cxl_rcrb_info *ri)
>  {
>  	struct cxl_dport *dport;
>  
> -	if (rcrb == CXL_RESOURCE_NONE) {
> +	if (!ri || ri->base == CXL_RESOURCE_NONE) {
>  		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, rcrb);
> +				     component_reg_phys, ri);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 52d1dbeda527..b1c0db898a50 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which)
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
>  {
>  	resource_size_t component_reg_phys;
>  	void __iomem *addr;
> @@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> +	else
> +		ri->base = rcrb;
>  
>  	/*
>  	 * RCRB's BAR[0..1] point to component block containing CXL
> @@ -364,6 +365,9 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +
> +	/* TODO: retrieve rcrb->aer_cap here */
> +

Ack 

>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> @@ -395,4 +399,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	return component_reg_phys;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1503ccec9a84..b0807f54e9fd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -267,9 +267,9 @@ enum cxl_rcrb {
>  	CXL_RCRB_DOWNSTREAM,
>  	CXL_RCRB_UPSTREAM,
>  };
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which);
> +struct cxl_rcrb_info;
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -589,12 +589,12 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  	return xa_load(&port->dports, (unsigned long)dport_dev);
>  }
>  
> +
>  /**
>   * struct cxl_dport - CXL downstream port
>   * @dport: PCI bridge or firmware device representing the downstream link
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
> - * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
>   */
> @@ -602,11 +602,20 @@ struct cxl_dport {
>  	struct device *dport;
>  	int port_id;
>  	resource_size_t component_reg_phys;
> -	resource_size_t rcrb;
>  	bool rch;
>  	struct cxl_port *port;
>  };
>  
> +struct cxl_rcrb_info {
> +	resource_size_t base;
> +	u16 aer_cap;
> +};
> +
> +struct cxl_rch_dport {
> +	struct cxl_dport dport;
> +	struct cxl_rcrb_info rcrb;
> +};
> +
>  /**
>   * struct cxl_ep - track an endpoint's interest in a port
>   * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> @@ -674,7 +683,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t component_reg_phys,
> -					 resource_size_t rcrb);
> +					 struct cxl_rcrb_info *ri);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 097d86dd2a8e..7da6135e0b17 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -71,10 +71,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	 * host-bridge RCRB if they are not already mapped via the
>  	 * typical register locator mechanism.
>  	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys = cxl_rcrb_to_component(
> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> -	else
> +	if (parent_dport->rch &&
> +	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
> +		struct cxl_rch_dport *rdport =
> +			container_of(parent_dport, typeof(*rdport), dport);
> +
> +		component_reg_phys =
> +			cxl_probe_rcrb(&cxlmd->dev, rdport->rcrb.base,
> +				       &rdport->rcrb, CXL_RCRB_UPSTREAM);
> +	} else
>  		component_reg_phys = cxlds->component_reg_phys;
>  	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
>  				     parent_dport);
> @@ -92,7 +97,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	}
>  
>  	return 0;
> -}
> +	}
>  
>  static int cxl_mem_probe(struct device *dev)
>  {
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index fba7bec96acd..bef1bc3bd912 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -11,7 +11,7 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
> -ldflags-y += --wrap=cxl_rcrb_to_component
> +ldflags-y += --wrap=cxl_probe_rcrb
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 385cdeeab22c..805c79491485 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -983,12 +983,14 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>  	return 0;
>  }
>  
> -resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
> -					   resource_size_t rcrb,
> -					   enum cxl_rcrb which)
> +resource_size_t mock_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +				    struct cxl_rcrb_info *ri, enum cxl_rcrb which)
>  {
>  	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
>  
> +	if (which == CXL_RCRB_DOWNSTREAM)
> +		ri->base = rcrb;
> +
>  	return (resource_size_t) which + 1;
>  }
>  
> @@ -1000,7 +1002,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.is_mock_dev = is_mock_dev,
>  	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
>  	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
> -	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
> +	.cxl_probe_rcrb = mock_cxl_probe_rcrb,
>  	.acpi_pci_find_root = mock_acpi_pci_find_root,
>  	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
>  	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index c4e53f22e421..148bd4f184f5 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -244,9 +244,9 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
>  
> -resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
> -					     resource_size_t rcrb,
> -					     enum cxl_rcrb which)
> +resource_size_t __wrap_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +				      struct cxl_rcrb_info *ri,
> +				      enum cxl_rcrb which)
>  {
>  	int index;
>  	resource_size_t component_reg_phys;
> @@ -254,14 +254,14 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
>  
>  	if (ops && ops->is_mock_port(dev))
>  		component_reg_phys =
> -			ops->cxl_rcrb_to_component(dev, rcrb, which);
> +			ops->cxl_probe_rcrb(dev, rcrb, ri, which);
>  	else
> -		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
> +		component_reg_phys = cxl_probe_rcrb(dev, rcrb, ri, which);
>  	put_cxl_mock_ops(index);
>  
>  	return component_reg_phys;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_probe_rcrb, CXL);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(ACPI);
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index bef8817b01f2..7ef21356d052 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -15,9 +15,10 @@ struct cxl_mock_ops {
>  					     acpi_string pathname,
>  					     struct acpi_object_list *arguments,
>  					     unsigned long long *data);
> -	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
> -						 resource_size_t rcrb,
> -						 enum cxl_rcrb which);
> +	resource_size_t (*cxl_probe_rcrb)(struct device *dev,
> +					  resource_size_t rcrb,
> +					  struct cxl_rcrb_info *ri,
> +					  enum cxl_rcrb which);
>  	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
>  	bool (*is_mock_bus)(struct pci_bus *bus);
>  	bool (*is_mock_port)(struct device *dev);



My email client chopped off the following:

-- 
2.39.2
-- >8 --


> +
> +	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
> +						     parent_dport->component_reg_phys);

[Dan] Since this is component register offset based can it not be shared with
the VH case? I have been expecting that RCH RAS capability and VH RAS
capability scanning would need to be unified in the cxl_port driver.

[Terry] The same probe function is called indirectly: 
cxl_component_to_ras()
cxl_probe_component_regs()   <<==

The VH has:
cxl_setup_regs() (cxl/pci.c)
cxl_probe_regs() (cxl/pci.c)
cxl_probe_component_regs() (cxl/core/regs.c) <<==

Would you like to see the RCH RAS discovery reuse cxl_probe_regs() or (parts of) 
cxl_setup_regs() as well? I ask because cxl_probe_regs() and cxl_setup_regs() 
are static in cxl/pci.c. Of course they can be moved out to cxl/core/regs.c to avoid 
an unwanted dependancy from exported pci.c symbol. This would be a significant 
change just for the RCH case.

You mentioned earlier it is late to add downstream port properties in mem device
initialization. Where would you prefer the downstream RAS is discovered and mapped? 
I understand it needs to reuse as much existing code as possible but where to call from?
The optins I see are here in mem.c or in __devm_cxl_add_dport() but neither are ideal.





