Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB360E83C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiJZTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiJZTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:03:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AC12E0CF;
        Wed, 26 Oct 2022 12:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRxS/aXj6TayVkIjl7KyEtr6U1NG/Q8sULgO2JuVC2yCP3v8jd9pKfE5y1R7Y/+lhznodzn6Ds1u5t/01gbNRt/XcuUjCpOc0CjWScqC5uEQsE8Dy2QJ6j9o6BrW+UmU8z72YqrhRbL8irqAeOdns/dxfjo1gh8dGgjhQvlVaX53/Ggwv5TlP5+p6LAVswqTDF/kAoE0CGT1aiIHmIK22Zo3GKImJxwsOEGTgn8PklL51qOiAdhN7S26lg2VMx/3GllArVuhC6nNncodWsIuKscckBAqUFBZweUzZx4wtpkwt39P6o2srcwvhc40MMXu620QT1iRF0T1FrwS6xAEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhVaxRkVk5NwkRBl/PSJL/Xojalux+SJE8ahF19numk=;
 b=i0pp+vnJqsZjVbqmQyn4wKDiEPaicDhPjdLpF7e91cd1NCgipBpJPrN/t9wKQ/I8XjzK1s5/X15i89HuypOwyHxoqU/6CIVsBZ3fqfakB4iE7FbgELWOMM9k5E4FKwCcI+iAHnIHy0DNl9x2vhUUoGvmKxfnQDCUYMuyxkM7f/YFTiRZuDXrY1JvS+npHUKdgw9dt6g6lDvVjPSa7Gpa/WVHj2XQAXsx/ERWg89M99hj/1yE5oc6MljGK5dYO3PDYqvlqeUg6C4R5fbJ5tpoZ/6UQNAM+b2CB9sHhNffN0tE+vPpCApa7HP6vRmwjAzBY1nbdSTO8zQ/Uxv5xY0ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhVaxRkVk5NwkRBl/PSJL/Xojalux+SJE8ahF19numk=;
 b=OHFLeHSqMuvzKXqHxjEyDO3AvuSRlZ6qXhjGtLxzBN1ytugs9djq3v8k5MB32ZXFwPNJ7CXuz6OOywX4W9fvMeRzRluxNuDVAxxu809qThxEYxmiLnIzOtm8PlL3xk57RNcijocShXh33S0058AVYh/VzF7UV9CthIZGT1TWJpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Wed, 26 Oct
 2022 19:01:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5a59:ed0d:be82:e15a]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5a59:ed0d:be82:e15a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:01:40 +0000
Message-ID: <6d35dceb-a414-7d3b-722c-5507d27b7ce4@amd.com>
Date:   Wed, 26 Oct 2022 14:01:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
 <6354725122f2c_141929457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6354725122f2c_141929457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:610:50::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6605fc35-8ebc-408a-a1a3-08dab78483d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygUmKQak1zjNp5ZgEIDGlhWi/oFiXxFgGAnZwAbigIvUxR8Im0nJu3QsDNhrpkMgtl7GkWzg8xiFiy33XK6AZyo5o8qlJnQWK8GnYwZk2f1IoZI1gESMuZAz9S2oK5lNGCwvBzmcSQJhj0z4iqbvKB2oFK86Hm3Uow/+NUyuQ6249kWfYUTn3cSuKjRrr14LLIWvgc1xfcNqyzV9XoQVkH9a9yQ/+mpdxzzo/KOFxvzuJO0dgc46YsdfzI2+izDBQwp5ykGaaCnyiKAb24DyNXqJOTgQ/AM16WlbcwiRYPoew5CkMbV6h6pVoP5KOEVO+51XujwRE4yhWoMAC2t0gdtVBeG3xv2ROpk43gaRloJTd9EFErIAuNRZ1CvqDYYDo9w1GRHlkGn/EpFzXQl5KeruTB5dM+t5JC2G8HI5UC8Sj8lQ4DhFYfqjaZTbQQWN2ZDdooyDRet3l9i1J6au5p8stpbXEyw+VFcI2PGf4pgRvc1KJ2v49sKksfhaS70+zXGwwu9yYdmDt1rsvXfd7ssUzm4BIDY+r25Xk7CgS8pQDRPb2zgTTqAfhipmKJ0zhedcRhUZALzm4S0okWn/gb9VByAQmn6uNvPlnYdKMuYDg+QWpsKaMYswXLFmR5Uy22csJwx6RCA4MBxO2csacGPCm3TNWkZcRmxtDFHU771C3br35hNZjYGiCEEN7yFxtzZvOnu4SGRA+HuzC5m8hez7DoyuHv4uE05ZP8468IO2ZEN2Zd/+iP5lZEMYV6PAOrvtWoFx3nPg2sVwY5i8KLlGONPIwGVWFNLmaDLsAcMD4tqSiZ2emZ+EGT5u+csN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(31686004)(6486002)(316002)(6512007)(53546011)(8676002)(5660300002)(26005)(36756003)(66556008)(86362001)(8936002)(66946007)(4326008)(66476007)(41300700001)(31696002)(2906002)(45080400002)(478600001)(83380400001)(966005)(6506007)(38100700002)(7416002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlvRlNoczZ1SFpPRzlOU3g2SDlqR2FEdndhZ29XWnd2OWhEWjFmUXhoMFVU?=
 =?utf-8?B?MjIwZUh1UEExeWR1aS9CcXZKQmxwb2xFOVNmME9DRW1BRnFpdG82cmtvNkVD?=
 =?utf-8?B?M1VaWkFpRzhwWlZHUzF3ZUtuSlY4UjU4WjVQczNNZ2xXYjMrT3ZJZVNsL1Bk?=
 =?utf-8?B?bW5hanErSHEzY0dPYzhzekVwWm03dDNUYS9RUmIxdnVINEtYMWJVQTVFNDBo?=
 =?utf-8?B?U1A5Z0hTNk9wZFE5VFZZRmxyc0k0WUdyR3Z6QklnMkZOekk4NlpIRCt2Tnc1?=
 =?utf-8?B?V1RmZTJQai9PTnNYei9TZFd1VzRpVW9xcUlHWUJMZiszdVgySDMzYVZTajBL?=
 =?utf-8?B?aW96emVlRjZuTERuKytyMGcwWmZYeitBdGlLd2FZM1pMN3k4WGZDSHNvcW96?=
 =?utf-8?B?ZWVXSjdrQUFIV3RQaXZ1WStndVhmdkVBVm9PU2pGQTkzNmVmdjN0VWtuNmwr?=
 =?utf-8?B?bDRUbFh2b3hseDMzellTb21QRzdKSFRKZVp3TFgzTHBpRDBJU3V1Vkt2QzBI?=
 =?utf-8?B?QmVFb0s1cEdTOHcybEc3SFNOQnljVVpWM09WV21wVVFaelVEQ1ljdkZOUC9r?=
 =?utf-8?B?S3J2QTgvNTdyeENVUVpMZDZCWkFkNzdlN0czNmdVVEcxcXc0YWFTS0krSXpQ?=
 =?utf-8?B?eVIwY2NLTVY1Q1RzSW1WaHNnMjhTTjBDSlByMnFteVhRcHFwZ09zL1d4WGtp?=
 =?utf-8?B?KzR1L3NxZ1I3cXFpUXpBU1orZjdGYlZXbGFuNTJabWx6SGxkaEc2L0FBRVRi?=
 =?utf-8?B?ZWhldE1lOGdOOEl3QWNwRkF0M2xSclF3aGNwV2RiQjRvSXpVS3NMeWRDcjJQ?=
 =?utf-8?B?cXdzaVdlZkttSnhpcWdQNUZ3SE5KTml5NVRVU3pRMTdiT0I3TE5wK3FDRVFy?=
 =?utf-8?B?cWZsWDJTbm1TRmhwZ3JoR1FReHZvWEYxRjVIajJ2UTRHY0FreVpCR3EyNTdJ?=
 =?utf-8?B?dmpuUld5bHV6eExWQXdhWjFSVTlNNk5mTGd4c2pqbGcxUWFDZ3R1S0NZQXFU?=
 =?utf-8?B?SjY2cWJFS0lBVGZlUG4zeEg1dThNZEhmS1h5Qnp4QS9ydWRGVWhJSnl2K0sr?=
 =?utf-8?B?NDBrN0pvdlJVSnlXNG80Z3BYcUVnclFZblVIR3BCUlI5c3NwZE5jQlUwcDlo?=
 =?utf-8?B?MFk0aE9LMEUrWXdnbVNyRU1MTzhBa0tuNnFVMTlicGdkOXp1WTM0eWtoU0Vt?=
 =?utf-8?B?bmplRHplYWpBYnp1c3ZGSnV5ZE9SK2N0WEtjL2xLZUxYYTl6WEV0OUptYUdW?=
 =?utf-8?B?U1A0UVV1QVh3OTlXWlpwL1NTQWRzdW12MER2MXFKd3c4aUptL1pIWTdocEwv?=
 =?utf-8?B?Y2toNjI2eUlOUTBvcHc2ZmlJMmduQm1jckRXMlZ5ZEpzYUpZOWZVckJsVCtZ?=
 =?utf-8?B?dGNmYVBmM1VxNEZIQ0VrVEE4L0h1Q2NoRTRBMzFMd0dub00yR2o4QWI2Z1B6?=
 =?utf-8?B?cVVKTnRma1k2RkFpTFlyYjdGZ3pYUmJQRUpUaDFUUUI3R0k1cHZtWlpGVEJX?=
 =?utf-8?B?ajBOMUtQRUJCcGNDaGdtMnB6NFlHV1R4aEZGUmt5MkR2Nk01MDcxOFVJU05P?=
 =?utf-8?B?UXl0NWk5Wm5KaUdHRC9ucGgyRWV0Zk9uQTI4cTJURWxOc3JWKzNldmNlOXEr?=
 =?utf-8?B?eGgyTkFHbjlJREEwY2VYWnY1bHJiZWJLbkRjTkMrNnp0V1daSnVZRHZ2QVJr?=
 =?utf-8?B?Z3BvZDZMRFh2MlBLNmVuV0tyY1RpT1RoTUtTbm1yajEwYmFxS2h0c1hTdm1V?=
 =?utf-8?B?d0lleE5UYW9ORXpYeHUwa1ZtTkFsOWVjTGtaSC83UTF0N1VzWTZSeDJWcDBl?=
 =?utf-8?B?S2JpTnNLVVA1cFd4cjdIejhXNHc2dHZWY3BsMnpFVEFxaTVzK2hOdGdKZG92?=
 =?utf-8?B?ckJ3d1VxM3ljRGJNRHN1NysrMkIyS3lVZEMxMCt0Y0VpcXBERHpUcll6WW1M?=
 =?utf-8?B?cWo0djB6Q1lwQzlxbXJrUE04YzBnRVJveVNScVhVSVVMdmpnQVoxakQwcFJY?=
 =?utf-8?B?cjZIdS9hRGlWZy9ldGNLdW9KR3lma1VtS1Q4bCtlNTBKM0VudFdHZlBBeFcz?=
 =?utf-8?B?amJRSUFzUUFLb2QyZjRNdW9JY0szL3QrNVhYTzBBaGdFQis4YmoybDYzS096?=
 =?utf-8?Q?6MVC4jX3RD3S/KhJ1VP44YKYv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605fc35-8ebc-408a-a1a3-08dab78483d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:01:40.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpzqBqsoPZ0jZEZKltRB0A22J9d4rR07/GlN47EEV/4lcrNLgvchkOl6q48M+3VV/K2GH1Zp3e84LdY8ky/c8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/22 17:44, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL RAS information resides in a RAS capability structure located in
>> CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
>> specific error information that can be helpful in debugging. This
>> information is not currently logged but needs to be logged during PCIe AER
>> error handling.
>>
>> Update the CXL driver to find and cache a pointer to the CXL RAS
>> capability. The RAS registers resides in the downport's component register
>> block. Note:RAS registers are not in the upport. The component registers
>> can be found by first using the RCRB to goto the downport. Next, the
>> downport's 64-bit BAR[0] will point to the component register block.
>>
>> [1] CXL3.0 Spec, '8.2.5 CXL.cache and CXL.mem Registers'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/cxl.h    |  4 +++
>>  drivers/cxl/cxlmem.h |  1 +
>>  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 7d507ab80a78..69b50131ad86 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -36,6 +36,10 @@
>>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>  
>> +/* CXL 3.0 8.2.4.2 CXL RAS Capability Header */
>> +#define CXL_CM_CAP_ID_RAS 0x2
>> +#define CXL_CM_CAP_SIZE_RAS 0x5C
>> +
>>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 079db2e15acc..515273e224ea 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -243,6 +243,7 @@ struct cxl_dev_state {
>>  	u64 next_persistent_bytes;
>>  
>>  	struct cxl_register_map aer_map;
>> +	struct cxl_register_map ras_map;
>>  
>>  	resource_size_t component_reg_phys;
>>  	u64 serial;
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 2287b5225862..7f717fb47a36 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -586,6 +586,78 @@ void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
>>  
>> +static resource_size_t cxl_get_dport_ras_base(struct cxl_memdev *cxlmd)
>> +{
>> +	resource_size_t component_reg_phys, offset = 0;
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	void *cap_hdr_addr, *comp_reg_mapped;
>> +	u32 cap_hdr, ras_cap_hdr;
>> +	int cap_ndx;
>> +
>> +	comp_reg_mapped = ioremap(cxlds->component_reg_phys +
>> +				  CXL_CM_OFFSET, CXL_COMPONENT_REG_BLOCK_SIZE);
>> +	if (!comp_reg_mapped)
>> +		return 0;
>> +
>> +	cap_hdr_addr = comp_reg_mapped;
>> +	cap_hdr = readl(cap_hdr_addr);
>> +	for (cap_ndx = 0;
>> +	     cap_ndx < FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
>> +	     cap_ndx++) {
>> +		ras_cap_hdr = readl(cap_hdr_addr + cap_ndx*sizeof(u32));
>> +
>> +		if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) == CXL_CM_CAP_ID_RAS) {
>> +			pr_debug("RAS cap header = %X @ %pa, cap_ndx = %d\n",
>> +				 ras_cap_hdr, cap_hdr_addr, cap_ndx);
>> +			break;
>> +		}
>> +	}
>> +
>> +	offset = CXL_CM_OFFSET + PCI_EXT_CAP_NEXT(ras_cap_hdr);
>> +
>> +	iounmap(comp_reg_mapped);
>> +
>> +	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) != CXL_CM_CAP_ID_RAS)
>> +		return 0;
>> +
>> +	pr_debug("Found RAS capability @ %llX (%X)\n",
>> +		 component_reg_phys + offset, *((u32 *)(comp_reg_mapped + offset)));
>> +
>> +	return component_reg_phys + offset;
> 
> For the RAS capability in the cxl_pci device this patch needs to be
> reconciled with this effort:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-cxl%2F166336972295.3803215.1047199449525031921.stgit%40djiang5-desk3.ch.intel.com%2F&amp;data=05%7C01%7Cterry.bowman%40amd.com%7C33092f731a854d7a9a5b08dab47f1075%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638020755070581692%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=84oOACCwh4XtndFKOUV%2FltpJjFnp4lsFQgw75UMphHQ%3D&amp;reserved=0
> 
> I think we will want RCD and VH RAS capability reporting to happen in
> the same place, and that can not be cxl_pci because cxl_pci has no way
> to find the RAS registers on its own. It needs the help from cxl_mem to
> do the upstream cxl_port associtation first.
> 
> Given CXL switches will have their own RAS capabilities to report it
> feels like the cxl_port driver is where all of this should be
> centralized.
> 
> 

I'm working on merging the patchsets now.

I'm merging the following:
  Dave Jiang's onto 6.1.0-rc1+, provides RAS mapping.
  Roberts series ontop of Dave's, provides RCD discovery.
  And this patchset ontop of Robert's, provides AER and RAS logging

Regards,
Terry

>> +}
>> +
>> +static int cxl_setup_dport_ras(struct cxl_memdev *cxlmd, resource_size_t resource)
>> +{
>> +	struct cxl_register_map *map = &cxlmd->cxlds->ras_map;
>> +	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
>> +
>> +	if (!resource) {
>> +		pr_err("%s():%d: RAS resource ptr is NULL\n", __func__, __LINE__);
>> +		return  -EINVAL;
>> +	}
>> +
>> +	map->base = devm_cxl_iomap_block(&pdev->dev, resource, CXL_CM_CAP_SIZE_RAS);
>> +	if (!map->base)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_pci_ras_init(struct cxl_memdev *cxlmd)
>> +{
>> +	resource_size_t cap;
>> +
>> +	/*
>> +	 * TODO - CXL2.0 will need change to support PCI config space.
>> +	 */
>> +	if (!is_rcd(cxlmd))
>> +		return;
>> +
>> +	cap = cxl_get_dport_ras_base(cxlmd);
>> +	cxl_setup_dport_ras(cxlmd, cap);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_ras_init, CXL);
>> +
>>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	struct cxl_register_map map;
>> -- 
>> 2.34.1
>>
> 
> 
