Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2FB72C8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbjFLOmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjFLOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:42:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AAD9E;
        Mon, 12 Jun 2023 07:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ3LJkMT8wFlR6C+m0mo6g2OsO+VtE4awHsJc23AF3cQgYy+BuSapHs5d6g0mqar4MUikWoTce7VAYLcJs4yhdhnJQcW4fqZ+Xa/3GVxN/iYvkJ5VH/HE/DJ74cJiZ0NXoVyu54fD1hj8EVo+7iaXG2kBIW4JlyU7LJVoIkYhz5PDCeeRcfwQuOUHzfIZN+F6GlA2zA8psHPtJYFxS7NNsiHPtntRGAHbM6WihCtfWo6lly1LUGkVK1WRYCwwi3stgSwClR/ZXxXpQxDZDtpW/O0ffM+wU7xosJlI9dg75NiErGMNKGygTMYKNocOE3UVBhx4Rf6dXWYQ5/NO5LUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RXzSGx9ZGWZVr7sLBR9whMNVX8Kj2bIeOL+cO549h0=;
 b=ikcsMWGNoM+g5ph56tLqdchsbRCJKy+TGwnB2HzPs+cf74kfCn/l0Dq15zk7WrhXITBHgUwQ7qRVJBsiBWnJZGlCZkP7ZUeUpBOrbJ84LtDmSoUfD5ExKEIQnGyZpLYZrpjdmohzT/5LGDGS6WQPbJPzhSTfoA1ImlCGO5rG7dhrgJwjtBxjX0lBx36T52LCU+OB8GyEANmMXxZW5RiWX2nlXHd9173QMLn34fI4QUJI3MFjlIm7ZeqhUXntBYPZD7jTNgEu9d2q1SkHYuyEB8XHOSrTkxNYrbKZ+bx6f9LmQVRZ2tIare7RFzYrwWEqnnPAMntCi5+zP55eJnMVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RXzSGx9ZGWZVr7sLBR9whMNVX8Kj2bIeOL+cO549h0=;
 b=v1dNQ6t8uV2l48G1HvD+/jQWJypZNyrxQGVwakX3lgB672mAltBuQ+1Yx2gWj3eX+GoFB7sBIurTIPWXyfXPwUvWGjtQivW7lmZPet8mCd4kRwxeGC1l5nOP4GSIyWk6XjGlnOkzlEBScyFroipafM1IYBV5TPd9CL2OvcaBbVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Mon, 12 Jun 2023 14:41:49 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 14:41:49 +0000
Message-ID: <a83b46e2-62db-65bc-204a-7f67c6ee556e@amd.com>
Date:   Mon, 12 Jun 2023 09:41:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 19/26] cxl/pci: Add RCH downstream port AER register
 discovery
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-20-terry.bowman@amd.com>
 <6483e9801c0ae_e067a29432@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6483e9801c0ae_e067a29432@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:8:191::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 759eab8a-73fb-4539-48e3-08db6b53279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G1RQijC0/SmT7BUHQcCK074WcPDtDxu2Y+Xl+K0ulDNaFj1/mXsQCjJ8MgJF8Nk4wFQVwAmqJkHt8PDKk0R9egnC/KAOWlPRUu9cP80oqt+0mMfj8rjxkiZhtIpYHbycmovRAYq+02nn7nR3zLPg0v2pmMaSCguRwD44O/lBd2pKJdl2f6SiuR4OQ57SuiGVsqyeuPOFnfbBAHOxEvkRuk/l0TVz6Eg0fcWGEzPoedO0G/hqSmmZGWut36YMrSZNDEGd8AXtj+iQJ1QLjppYG9+Dq1pHkdFZ3ioz4Dwu/AYRLQzEE12LrtwJDj92qJMZ8E/HDyevoHR9ihl9U+/BQQGtnq8vKyn2E3+4zXIGfLWPcnj49hmGFm1IuWNqbx3FPAvHaBgLQc+7QoVIrfPOszWQGVGIAoYCVo8ta58ylvbrjpmG0Q+pZMoIBnxaxB83dt19cEwbbCAC4XwL6AU0Bc1bcdwns9KbCJU5znt56FlOiBRq0ERhXgKGdoVuNzZ1rCl2CPWCPwGniUeibJLTg+0F52fPzpV6wjgeFYiN1SaeauNajmmovR4lUxqLZDboAwGSp4dJHgBcVHQpyRvbJobAXbk/PS/Xd/NsCqJL9qM57KB4A08gkMOLYTdyzG8qonjaY8MHjpOTxYYs+M1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(6512007)(53546011)(6506007)(26005)(186003)(2906002)(5660300002)(8676002)(7416002)(8936002)(316002)(41300700001)(31686004)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFzNDdhVnc5Q1pvTnV0ZFV4Z2dKbUVVU3V3NkRvdVBVWUdiL1BJbTFlK1Zk?=
 =?utf-8?B?UDNlSklXTE9iUUdLRXVKanhzNmZKSDVkcjVZcHlzaWxFUzBIM1g4OEZ6RGF1?=
 =?utf-8?B?WnV1VXlOT0NtK0xKVWpQS3VJWkxXUUxzNUkyUVYyNHA5WXB3SFc0OGZSRHhG?=
 =?utf-8?B?aDRPZTdKZ1hLd2FYWlpwRm1iMEJEK01hT2ZCWVhib01BejJlSHJxc3RnTkNC?=
 =?utf-8?B?d0NuQ0s0ejBjZlBtTGxrWVFKZUtPcDJyUnFtUVV5OGRkb3hXY0tDUkNPYUJ5?=
 =?utf-8?B?Z0VqeXpjdUQwbmtMaFFlL09kVUtpc2QrWTZGZHdHOGNjWGhodVo3S01FYUIx?=
 =?utf-8?B?cnJPM0JxMmdGb2hPSUVjajRVZk1SNGVqalhlYWJ5bHRBTXV4TGV5ZFJmallQ?=
 =?utf-8?B?NVhKQkhlck12V3lTcEQvb05OMTlMYmVyWFkyanFUdysvWmxmTmg1VkJVK3Nk?=
 =?utf-8?B?Um1ZYXgwS3h1ZVBsY1pwVjZ0eHZrUytUVmM5azFGaVlTWnlNMkllNW5uV1Fj?=
 =?utf-8?B?V3FmUms2c1llYkhKQlpBT3lIS1ltYnFzbVJlWU1yekZJVDU0WkFwZ1UvQUNm?=
 =?utf-8?B?UE5zMmt1N0NMdUxuY3B2ZUdORmNnZ3Z1KytabEhtRFNEVTdEc05FQXBiRjFC?=
 =?utf-8?B?TGJ1WVFvQmYvZ2tHNm93dkM2aEVCbEhqY3p4QzR1M3V1TWFvVnRTVjZvazFn?=
 =?utf-8?B?ekp6bHpXTlpGM1ZUaklEZTZtZGlzclp3MVRkTlBoU014b1cyY3BGVkdhVXlS?=
 =?utf-8?B?NkRuOXZDQis0aVhUWjEwQ1gvUExwbk94YVZSbzRGODNzYkFyWXNwZmgySzhn?=
 =?utf-8?B?ZW83aDJPQVZpalU1dHE2M0pBZEQxV1JRYWtIcGZwYUpDTDZqbDd6cmhmWUZK?=
 =?utf-8?B?R21FOWF1YjU3RnpaM1N6UHV2MVNCV2tKSjNGVVlkMU14U2xNdTYzOHBWL3BM?=
 =?utf-8?B?YlhUelpJVE8vekZ1SWlkUnEvV01iZFVLY1lpbTBDeHIzZk9UT3psV01icEh6?=
 =?utf-8?B?SFFaZ1YvcVFKdVp6UERtNzVYVFNhSlc3MUVFazVpaDFOQXA1aHJNK1lnNGRQ?=
 =?utf-8?B?MDhoZFNucUpyVk1peWFzUHZFdjVBWXBhYTU1Q24xNDROV1dEWjNlanlaY2Rn?=
 =?utf-8?B?Z01wdXBLZEVFVE1sNGtBSDA2SEdvQ0VqTWtsWVFVVG5abVpuWWlhY0F2eTZQ?=
 =?utf-8?B?emdNQjBWNWlRU2V5VnRJbzN0UVQ2L211enlDcnBYajV5UE54b3RKUTJMNi9N?=
 =?utf-8?B?UGs3Qjh1VG5rVTgybnlGc0V5eHN5SXcvdnAxN1FjazVTeFp0TE54VW1oaEI1?=
 =?utf-8?B?YUd0Ukt4bXZIa0d1TEtGWUFFOUEvM3VSditKWG55dDQ4MGFjQ1k4N0g4SWpK?=
 =?utf-8?B?aUNsa1hPKzFHODJZOWV4TCtoYnBSUGZkTzEwM3BINWNqUjVaOEl5cE1wWml1?=
 =?utf-8?B?SndjdzNId2ZpcnZaQ2Rndm9nWmhWekgydm5qOEx5RWN6Y0FNRDZuU0xXYzdw?=
 =?utf-8?B?VE9wd3lWNllWVUFjZGdXTmdJaFROSTBteVBKTVBlWTNQTlgrTTd4MXl0c1Y4?=
 =?utf-8?B?V0w1MDNFWkV2UU5xdDVMWlJjN3lRWG0zWFFMeng5WEpZYm1oNE50L0R6UFZX?=
 =?utf-8?B?dllPUm5vdXJzdmFJNnFMRHpsK2NWR3lEaC9kQWNWMnoxQkRVNkYwbjJrVTRu?=
 =?utf-8?B?M0k0VFhIVUVaS2dLQ3FacU1NYnlrdG9YK01adVhhaUhuekl2QU1sUGhZZkVS?=
 =?utf-8?B?Nm5xQnpvNWZTRTcxckFBemdmRjgwd1JBSEFmMUk4RXJNVUtQVXRWWll6SUd0?=
 =?utf-8?B?TE1aMFJjcThnaGpITlA0cHYvZXZGNjVPRjB3bVlMOEo3UVNadHFsaHJKS2RK?=
 =?utf-8?B?cDdkaUh5ck5DVzQxMjJEc3o0b3lVNWUvcWcrTEtUb0x2NWlVaVhRR1R0QUN1?=
 =?utf-8?B?V1NZbDFuM2pMa1Z0ZytVL2VuaTltQ3NveWVtN1ZlNGUrdGFKVjNvcmlKWUV5?=
 =?utf-8?B?OENvK3o2MXRwRkpwcmpnZDlaOGJ3cVVDcHZyUFNSdUl2TkpSS0E1TVFVVmJT?=
 =?utf-8?B?Z09lWjJvdGdwc2FHYVZFUGtnOUtlZHZUYmpOSXNROEpCeXgxa084cmNCdWZT?=
 =?utf-8?Q?F9YNqQ0OWVoWbTqgLN988bwxO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759eab8a-73fb-4539-48e3-08db6b53279e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:41:49.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mb0DtU9RPd+cyKVC6lJ+qi0/w9AwqPDichUUuwgQWPePlVgSmMU7AaUUt7QBxuWqj4CrjH4pOXUICrGNBhVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I added a response inline below.

On 6/9/23 22:09, Dan Williams wrote:
> Terry Bowman wrote:
>> Restricted CXL host (RCH) downstream port AER information is not currently
>> logged while in the error state. One problem preventing the error logging
>> is the AER and RAS registers are not accessible. The CXL driver requires
>> changes to find RCH downstream port AER and RAS registers for purpose of
>> error logging.
>>
>> RCH downstream ports are not enumerated during a PCI bus scan and are
>> instead discovered using system firmware, ACPI in this case.[1] The
>> downstream port is implemented as a Root Complex Register Block (RCRB).
>> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
>> root port.[2] The RCRB includes AER extended capability registers used for
>> reporting errors. Note, the RCH's AER Capability is located in the RCRB
>> memory space instead of PCI configuration space, thus its register access
>> is different. Existing kernel PCIe AER functions can not be used to manage
>> the downstream port AER capabilities and RAS registers because the port was
>> not enumerated during PCI scan and the registers are not PCI config
>> accessible.
>>
>> Discover RCH downstream port AER extended capability registers. Use MMIO
>> accesses to search for extended AER capability in RCRB register space.
>>
>> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
>> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/cxl/core/regs.c | 51 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index ba2b1763042c..dd6c3c898cff 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -408,6 +408,54 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
>>  
>> +static void __iomem *cxl_map_reg(struct device *dev, resource_size_t addr,
>> +				resource_size_t length)
>> +{
>> +	struct resource *res;
>> +
>> +	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
>> +		return NULL;
>> +
>> +	res = request_mem_region(addr, length, dev_name(dev));
>> +	if (!res)
>> +		return NULL;
>> +
>> +	return ioremap(addr, length);
>> +}
>> +
>> +static void cxl_unmap_reg(void __iomem *base, resource_size_t addr,
>> +			 resource_size_t length)
>> +{
>> +	iounmap(base);
>> +	release_mem_region(addr, length);
>> +}
> 
> Why redo the {request,release}_mem_region() and ioremap() vs handling
> this inside of the existing mapping of the RCRB in this function?

The intention was to follow the same pattern as existing {request,release} 
functions but doesn't make much sense with only one user in this case. I'll 
fold the {request,release} logic into cxl_rcrb_to_aer().

Regards,
Terry
