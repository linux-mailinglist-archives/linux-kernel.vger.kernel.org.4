Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63060D1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiJYQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiJYQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:42:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69C8C448;
        Tue, 25 Oct 2022 09:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5UmN2DeE916JBwLHdif5oP65ZAViU6uPjwKOEQZ7POU7IVPA3K0eoitUiSIKGu2ldXqex3isi0Bs/w3Mtsz70F1DEAaFT6dVTGi39sEgD1Yh71ORVBbaC9twDpXBYXdnW3sj9YGAQg2vRQ8F+u0/yMlXCW9M4OZCd2ecHLZLpDh5R3dSlWQQfA55+I1cG9/AMthjttI59lbkE5HCDJJO8M+75Xl63a5lHWIm/UuW3NoEeE6aXBdjS2pflyE8GNN8if39aaDVgq0lIHTvGher2tICn762ohFCYN/nMgF8ZmkmINfCa7re9U/9dz+eVAv5kD0h9MTWYfzrgYlZVEc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJRJ4f8Ll9zjr4khEmc6hltlf+2Pmot+euQS8yo/Azk=;
 b=gM8Q8WF4rGV0/LK+pSbZZ8J3559CTlwjr25t74euB/68G25GdmcUCOGwuw/n2pUp8nYsAWI1iqEJ8PKJN2Un/9r8qZLzIw6xjtXOM1LiMF3jNB5wNCaIXeI0EnxcvpaMSvCDKCnUSCrwBYgcsXaROc2UvX8ATjfQ9jOehVXLBKht1IO/6HvDerRjtAO9iMw1S6CdX9Qoex81MsraFAwS1iwH7G7A/Ge+EPg85bfs9xHl0PklxBC+E0y9sAwLE2QbOgO/E2wPshIxHd9sFYMsGH7zKV2/yqYY5fLQCfA2ocZWsYt++soq2Jyh4DvvCR/E499UjqOQ2hE023SOryi6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJRJ4f8Ll9zjr4khEmc6hltlf+2Pmot+euQS8yo/Azk=;
 b=EhmRe/9U9saDDtu1Q8R5TMn2BwqCiZ2UNIxO6nEcGb+D217rnfCYUikaWe4GRDNa2wJzvfyDLIWv39g+297k7SFkJSR+f1L5Yk02BcuSrOtlYVCqGAcp0cVNX3T4ElQEz/ttoYYqg4HPInXX1RsQHYUx/1LWMUNZqDqGFUCN1ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Tue, 25 Oct 2022 16:42:36 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275%6]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 16:42:36 +0000
Message-ID: <a65a2259-9835-bb12-5856-8e695b194191@amd.com>
Date:   Tue, 25 Oct 2022 11:42:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's
 PCIe AER capability
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-3-terry.bowman@amd.com>
 <6354648d9b004_141929463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6354648d9b004_141929463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:610:11b::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 655bd795-3385-4e8d-5fce-08dab6a7ec26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3s09zJlL4zZlZPneGFc3QjHLN7siu+FA49QrKQzzyXgg2n/SOByvPGZZjIMjauRKnkLGIOnG0RYPloraHHM7pi0GCUGJNwdLb6Rlhm7C3VFcLrvdnXdH/NNaMYMGp3Cv+tGcxbl+oCf7/0ErWEUG4vPhgRaxtFin2T5maE/OTQbJYSDACOP0XFlZUrhQLpfcdq7m15iiE4lHvcuA8gEh5os3VNiWT00QFxTxWbEENR+phBgeRegcdU9/kLZqPmRyuuZIwqPp2xtfk0aZ7RWZuZ7ElcFvFJ4N4kqKgOjNYVIEnTSO48plwox/2Fb7p0iH2mqvc0w6zIF/kgzPlS10pZYfNIWZKVI+zAv6u8ygUhgsYdg45XWHCINbRe2XBKCZTU4iDgbRbKeBflbKjO8Z0Iq0dsAnmr/Y/uW+16KYBOTvehe9Lpr+kBrkMelWy06Cv6JWVhaC0NclcFTQK99r7OJZ65PxMJx1wcSwUjRzjMUbta8spNgKOl+GGjJXD838f5TAXmZKQfHP/VjP9IQ5juW23Zz63JWL452sv/fZ4VArGkd294Q2+Csd2GKMB6HD7znDgJ0Rl2JqayCsdYxe5fD9hL9JzgR9xJ8liXHc1NdD3d6F8/d9et17nQIOQBtxwcCpVYOm9WSMG6Ndoi2yc/QAiAF92YyHhsFGODZXpWsuzFdRMv8W9G5EAFuc14lwGXnOG54xdKuhjW7SM9ZFH/9AKB7y5pO7jrMy+zTTr2dlXatADOYlgDSgHyCeWRgom9JnJfk0Flj1gC5ywcEvo68Q2V9yf/gS0xDJXVrJeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(2616005)(316002)(41300700001)(36756003)(30864003)(8936002)(6512007)(2906002)(26005)(186003)(7416002)(66946007)(66556008)(66476007)(31696002)(5660300002)(4326008)(6506007)(86362001)(8676002)(53546011)(6486002)(31686004)(478600001)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRxQ2dEbXNOVHlwdTJvMWdRUlNFZFJkU1ZGQ3hwb0g0OE9kY1d3N0g5K2xx?=
 =?utf-8?B?b0NmSUR0Y0VnYllpbXBDVEJpakY2akM4SmdINFdIQXZqbVJCZ3FTZ3NXT2Rn?=
 =?utf-8?B?Q0FRQ3FwaWp4Q1NLV0o2clo4N3JPY2czTTJsZ0hZTWJHdzNSc3dWYzZmYXJi?=
 =?utf-8?B?elRhZkx1c2RnaWNFbnliaDhxZWZOQUVySE80bElIcE1oMHZyYnc3Umk3dm50?=
 =?utf-8?B?czhlc2hUTngyVXNmVGhaMUJVRTNkL1cwMDJad25SZkZTU09BTkV6TTJBOUtN?=
 =?utf-8?B?dE0rajNtUHdoRHdRallnWnBBdXFNWFZnclhTNmh1bHBlQ016U1NFSmx2YTZv?=
 =?utf-8?B?SG5VUjhVT3AzdUNXZkJoOTQrRUllRmJid1NxcWFTMUszSzhDMUR1L1VESXo4?=
 =?utf-8?B?eG94dmFzQktxcnh5TWF4RGxtbW5TdWJFSFdod0F1MTBUcXRLM2l2YkdWZUE2?=
 =?utf-8?B?YVFubXF4VHNVbGk5RHdkVGFhem5jVTV0cU1YUGRNYk43bWFGMFlneFBkN1dR?=
 =?utf-8?B?Zzc3MFB5d0t5djlUS0lQeFNaZzRPTTF0OFdYcTBYZXg2YTE0aURDcEJGSUI1?=
 =?utf-8?B?UnFINlhUd3dFZlB4cGEvWjVCYjl3MHZMdmRrMC9xNHBFL2VsQzNjNkw3SmRH?=
 =?utf-8?B?MWNrVnlzQzMvRThsSjJ4MU4yb25MSFl5Ym9QVnhOdGNNZXlVenQ2aUlVRjFw?=
 =?utf-8?B?MXNtRytzaXVKdEFsa3c2WnZaenplYzFnUXRBUTFwZGpoME52K0ZjQktTRXhx?=
 =?utf-8?B?QzF3YUsvcHdrSmhBNXUybzhoRW5yMVhEeGpHRmtjNGRUKzJvUG0yaVZKMnZj?=
 =?utf-8?B?SUFEbGhNQkx4ZllkdHhYcFl4QVR1Z3ZZWEt5alljMXY0SXhVQXpLeXRQOEN6?=
 =?utf-8?B?UnNtSkZjU3EzMWxEbERmcnFJSmdzcDFvWDF5Y1o3d1VMZGxuaEhaS1Y3b0Zk?=
 =?utf-8?B?cWMrKytWQldObXZoQzljQmxBNXNUU2NjcEVCNmk3dEliM1pYc2lNaWJTOTk5?=
 =?utf-8?B?bGNvM0xKanVpWE1BK3BRZldZSExDK0xTa3JFUk8rSkNWVjFUZU8xWHNkZDYz?=
 =?utf-8?B?TUNqUUhKRmJvVVJ5UWUvdm9wdTBtQWZzT01SSXFjR2JlaitWalNIaXpRcjNJ?=
 =?utf-8?B?dHVYOVJ2WXZwcnBlTi9qMS9OUWRwVXh0Q2JmMk1MUkhLbGpodzRraW1Dbzdm?=
 =?utf-8?B?ai8wS295MHp2VVF6RGoycWpDREhiUjM0VnlBdTNJSVg3UTZocEc5M3RRNXY1?=
 =?utf-8?B?VGMrQWY0by9xYXJneEViZFFuUm9aaWdZL1JaM3psTWdwaDJPOVpFVll3OGsr?=
 =?utf-8?B?d2t4YTIvYlFZM1crQnVkN1kxWVI2TEZjSGp2UzNBZzl1bHAvbWNkV2s4c2hO?=
 =?utf-8?B?OWVURnB3N1JuNVlqMzhMZCtONE5HOVJ6SXk2MTlHQkhuM1diZ3dnamo3RTBz?=
 =?utf-8?B?aEJ4Tlh6TXdCUTlXMEs4eWEvV2c3NnNOVFJGNjFUbnFaNkU5dTE2d3N6YlNU?=
 =?utf-8?B?cVJIcVZxZzNNdGlJMGczRzZxZUYyTWdaNFNwcmFwYlgrQklUcEIzMWN0QUNI?=
 =?utf-8?B?VUtIOGlGTzViQklZWC9ueXhmOWhXNWx1bVNEenowQktnemJwM1hGNDdra3hF?=
 =?utf-8?B?TjVUdllTTTR5by8wTmF4WWMwSUNLUmgvcWNjSjF0N3RwNjdXNGtKTkJNTFlX?=
 =?utf-8?B?KzZGWjNUQjhoaFp0RGlaTVBOTWFzeW1HMm40c2FyTU1ZVG1zaGZGVUhhZ2c4?=
 =?utf-8?B?NUJlRDNtVFM1dy8yYzk4Y1FZb0ZwM2JXeDdKTWJuVmRKY1hLN3l4Ly9PaDdD?=
 =?utf-8?B?VlVFVkc4YzJlZFhrclRQZFZNV3huQ3FYVElLRGRLUUdHaC9EdWk0SnMzSEhV?=
 =?utf-8?B?LytKN0lXY3VBRDhuL2VjNWtqbER5V2I0VzVFelh6cG4zNG9wQ25SZ0M3UFBF?=
 =?utf-8?B?R25VM3gyeHM1dmpQUTlFR1FCV1RKYzZXUmVCUndkeGVYak1JTHpHZ0hNdGJT?=
 =?utf-8?B?VlBaazhBakRqM1ZYcWVvdWREN0NDZFhOVUFZdUpjNjNEZXo0b010QVpENFpB?=
 =?utf-8?B?ZHlJT3FiRzdmeUlyaEhKVmdSVTc0V3BVanVFRVEyTjRjZXloUGRORzRuZVlX?=
 =?utf-8?Q?q6eXWGYwGjYcr2JwyAEpXmzhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655bd795-3385-4e8d-5fce-08dab6a7ec26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:42:36.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJtcSuf2dza9V4WxmVM1aXtMHSAefT+NGf8a4cVTNyLKSW1MyRsyJgDJRtcy0HYkgG3dnjF4cKqx5MiHR+ZuOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/22 16:45, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL downport PCIe AER information needs to be logged during error handling.
>> The RCD downport/upport does not have a BDF and is not PCI enumerable. As a
>> result the CXL PCIe driver is not aware of the AER in 'PCI Express'
>> capability located in the RCRB downport/upport. Logic must be introduced to
>> use the downport/upport AER information.
> 
> Nice, I am happy to see this work get started.
> 
>>
>> Update the CXL driver to find the downport's PCIe AER capability and cache
>> a pointer for using later. First, find the RCRB to provide the
>> downport/upport memory region. The downport/upport are mapped as MMIO not
>> PCI config space. Use readl/writel/readq/writeq as required by the CXL spec
>> to find and operate on the AER registers.[1]
>>
>> Also, add function to detect if the device is a CXL1.1 RCD device.
>>
>> [1] CXL3.0, 8.2 'Memory Mapped Registers'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/acpi.c      |  56 ++++++++++++++
>>  drivers/cxl/core/regs.c |   1 +
>>  drivers/cxl/cxl.h       |   9 +++
>>  drivers/cxl/cxlmem.h    |   2 +
>>  drivers/cxl/mem.c       |   2 +
>>  drivers/cxl/pci.c       | 158 ++++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 228 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index bf251a27e460..5d543c789e8d 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -232,6 +232,7 @@ struct cxl_chbs_context {
>>  	struct device *dev;
>>  	unsigned long long uid;
>>  	struct acpi_cedt_chbs chbs;
>> +	resource_size_t chbcr;
>>  };
>>  
>>  static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
>> @@ -417,6 +418,61 @@ static void remove_cxl_resources(void *data)
>>  	}
>>  }
>>  
>> +static const struct acpi_device_id cxl_host_ids[] = {
>> +	{ "ACPI0016", 0 },
>> +	{ "PNP0A08", 0 },
>> +	{ },
>> +};
>> +
>> +static int __cxl_get_rcrb(union acpi_subtable_headers *header, void *arg,
>> +			  const unsigned long end)
>> +{
>> +	struct cxl_chbs_context *ctx = arg;
>> +	struct acpi_cedt_chbs *chbs;
>> +
>> +	if (ctx->chbcr)
>> +		return 0;
>> +
>> +	chbs = (struct acpi_cedt_chbs *)header;
>> +
>> +	if (ctx->uid != chbs->uid)
>> +		return 0;
>> +
>> +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
>> +		return 0;
>> +
>> +	if (chbs->length != SZ_8K)
>> +		return 0;
>> +
>> +	ctx->chbcr = chbs->base;
>> +
>> +	return 0;
>> +}
> 
> This seems redundant with component register enumeration that was
> already added in Robert's patches.
> 

Noted. Plese see my next response below.

>> +
>> +resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd)
>> +{
>> +	struct pci_host_bridge *host = NULL;
>> +	struct cxl_chbs_context ctx = {0};
>> +	struct cxl_dport *dport;
>> +	struct cxl_port *port;
>> +
>> +	port = cxl_mem_find_port(cxlmd, NULL);
>> +	if (!port)
>> +		return 0;
>> +
>> +	dport = port->parent_dport;
>> +	ctx.uid = dport ? dport->port_id : 0;
>> +	if (!dport)
>> +		return 0;
>> +
>> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, __cxl_get_rcrb, &ctx);
>> +
>> +	dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)ctx.chbcr);
>> +
>> +	return ctx.chbcr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_rcrb, CXL);
> 
> While CXL to date has been tied ACPI platforms there is no requirement
> that CXL be ACPI based. Given that other coherent bus specifications
> that were deployed on PowerPC have now joined the CXL consortium there
> is an increasing chance of CXL appearing on an Open Firmware based
> platforms. Even if that does not come to pass, the discipline of clear
> separation between platform code and PCI/CXL mechanisms leads to cleaner
> code organization.
> 
> All that to say, no, cxl_acpi cannot export functions for other cxl
> modules to depend upon. Instead it needs to publish these details in the
> CXL objects that it registers.
> 

Ok. Ill rework such that ACPI functions are not exported. Adding  the recommended 
caching 'rcrb_phys' will help recfactoring out the exported function. I'll
cache the RCRB to 'rcrb_phys' during enumeration instead of calling a helper 
function for every query.

> In this case my expectation is that cxl_acpi registers a dport decorated
> with the extra RCH information. Something like:
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..b42f4759743b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -499,12 +499,19 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
>   * @port: reference to cxl_port that contains this downstream port
> + * @is_rch: enable RCH vs VH enumeration (see CXL 3.0 9.11.8)
>   */
>  struct cxl_dport {
>         struct device *dport;
>         int port_id;
>         resource_size_t component_reg_phys;
>         struct cxl_port *port;
> +       bool is_rch;
> +};
> +
> +struct cxl_rch_dport {
> +       struct cxl_dport dport;
> +       resource_size_t rcrb_phys;
>  };
>  

The same is needed for uport as well, correct ?

>  /**
> 
> Then, when cxl_mem notices that the memdev is being produced by an
> RCIEP, it can skip devm_cxl_enumerate_ports() and jump straight to
> cxl_mem_find_port(). That will return this dport with the rcrb base
> where cxl_mem can arrange the AER handling. Likely we will need some
> notification mechanism to route Root Complex AER events to cxl_acpi,
> cxl_pci, and/or cxl_mem to optionally add the CXL RAS data to the log.
> 
Isn't the notification mechanism through the AER interrupt processing? 
I will have more related comments in patch 3/5.

>> +
>>  /**
>>   * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
>>   * @cxl_res: A standalone resource tree where each CXL window is a sibling
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index ec178e69b18f..0d4f633e5c01 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -184,6 +184,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  
>>  	return ret_val;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>>  
>>  int cxl_map_component_regs(struct pci_dev *pdev,
>>  			   struct cxl_component_regs *regs,
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index ac8998b627b5..7d507ab80a78 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -204,6 +204,14 @@ struct cxl_register_map {
>>  	};
>>  };
>>  
>> +struct cxl_memdev;
>> +int cxl_pci_probe_dport(struct cxl_memdev *cxlmd);
>> +
>> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd);
>> +
>> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>> +				   resource_size_t length);
>> +
>>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>  			      struct cxl_component_reg_map *map);
>>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> @@ -549,6 +557,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>>  	return port->uport == port->dev.parent;
>>  }
>>  
>> +resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd);
>>  bool is_cxl_port(struct device *dev);
>>  struct cxl_port *to_cxl_port(struct device *dev);
>>  struct pci_bus;
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 88e3a8e54b6a..079db2e15acc 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -242,6 +242,8 @@ struct cxl_dev_state {
>>  	u64 next_volatile_bytes;
>>  	u64 next_persistent_bytes;
>>  
>> +	struct cxl_register_map aer_map;
>> +
>>  	resource_size_t component_reg_phys;
>>  	u64 serial;
>>  
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 64ccf053d32c..d1e663be43c2 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -74,6 +74,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> +	cxl_pci_aer_init(cxlmd);
>> +
>>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>  	if (!parent_port) {
>>  		dev_err(dev, "CXL port topology not found\n");
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index faeb5d9d7a7a..2287b5225862 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -35,6 +35,15 @@
>>  	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>>  	 CXLDEV_MBOX_CTRL_DOORBELL)
>>  
>> +/* PCI 5.0 - 7.8.4 Advanced Error Reporting Extended Capability */
>> +#define PCI_AER_CAP_SIZE 0x48
>> +
>> +/* CXL 3.0 - 8.2.1.3.3, Offset to DVSEC Port Status */
>> +#define CXL_DVSEC_PORT_STATUS_OFF 0xE
>> +
>> +/* CXL 3.0 - 8.2.1.3.3 */
>> +#define CXL_DVSEC_VH_SUPPORT 0x20
>> +
>>  /* CXL 2.0 - 8.2.8.4 */
>>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>>  
>> @@ -428,6 +437,155 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>>  	}
>>  }
>>  
>> +static resource_size_t cxl_get_dport_ext_cap(struct cxl_memdev *cxlmd, u32 cap_id)
>> +{
>> +	resource_size_t rcrb, offset;
>> +	void *rcrb_mapped;
>> +	u32 cap_hdr;
>> +
>> +	rcrb = cxl_get_rcrb(cxlmd);
>> +	if (!rcrb)
>> +		return 0;
>> +
>> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
>> +	if (!rcrb_mapped)
>> +		return 0;
>> +
>> +	offset = PCI_CFG_SPACE_SIZE;
>> +	cap_hdr = readl(rcrb_mapped + offset);
>> +
>> +	while (PCI_EXT_CAP_ID(cap_hdr)) {
>> +		if (PCI_EXT_CAP_ID(cap_hdr) == cap_id)
>> +			break;
>> +
>> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
>> +		if (offset == 0)
>> +			break;
>> +
>> +		cap_hdr = readl(rcrb_mapped + offset);
>> +	}
>> +	iounmap((void *)rcrb_mapped);
> 
> The memdev owns the upstream port RAS capability, why is it mapping the
> downstream port ras capability?
> 

You're right, this needs to be changed to read the upport's extended 
capabilities. 

>> +
>> +	if (PCI_EXT_CAP_ID(cap_hdr) != cap_id)
>> +		return 0;
>> +
>> +	pr_debug("Found capability %X @ %llX (%X)\n",
>> +		 cap_id, rcrb + offset, cap_hdr);
>> +
>> +	return rcrb + offset;
>> +}
>> +
>> +bool is_rcd(struct cxl_memdev *cxlmd)
>> +{
>> +	struct pci_dev *pdev;
>> +	resource_size_t dvsec;
>> +	void *dvsec_mapped;
>> +	u32 dvsec_data;
>> +
>> +	if (!dev_is_pci(cxlmd->cxlds->dev))
>> +		return false;
> 
> Just use cxlmd->dev.parent, no need to route through cxlds for this.
> 

Ok

>> +
>> +	pdev = to_pci_dev(cxlmd->cxlds->dev);
>> +
>> +	/*
>> +	 * 'CXL devices operating in this mode always set the Device/Port
>> +	 * Type field in the PCI Express Capabilities register to RCiEP.'
>> +	 * - CXL3.0 9.11.1 'RCD Mode'
>> +	 */
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
>> +		return false;
>> +
>> +	/*
>> +	 * Check if VH is enabled
>> +	 * - CXL3.0 8.2.1.3.1 'DVSEC Flex Bus Port Capability'
>> +	 */
>> +	dvsec = cxl_get_dport_ext_cap(cxlmd, PCI_EXT_CAP_ID_DVSEC);
>> +	if (!dvsec)
>> +		return false;
>> +
>> +	dvsec_mapped = ioremap(dvsec, SZ_4K);
> 
> No ioremap error handling?
> 

I'll add.

>> +	dvsec_data = readl(dvsec_mapped + CXL_DVSEC_PORT_STATUS_OFF);
>> +	iounmap(dvsec_mapped);
>> +	if (dvsec_data & CXL_DVSEC_VH_SUPPORT)
>> +		return false;
> 
> There's no such thing as a root-complex-integrated endpoint in CXL VH
> mode, right? Is this not redundant?
> 

Youre correct.

'CXL Root Ports may be directly connected to a CXL device that is not an eRCD, or a CXL
Switch. These Root Ports spawn a CXL Virtual Hierarchy (VH). Enumeration within a
CXL VH is described below. These CXL devices appear as a standard PCIe Endpoints with a Type 0 Header.'
-cxl3.0 9.12.2 'CXL Virtual Hierarchy'

I will remove the DVSEC check.

>> +
>> +	return true;
>> +}
>> +
>> +#define PCI_CAP_ID(header)	(header & 0x000000ff)
>> +#define PCI_CAP_NEXT(header)	((header >> 8) & 0xff)
>> +
>> +static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
>> +{
>> +	resource_size_t offset, rcrb;
>> +	void *rcrb_mapped;
>> +	u32 cap_hdr;
>> +
>> +	rcrb = cxl_get_rcrb(cxlmd);
>> +	if (!rcrb)
>> +		return 0;
>> +
>> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
>> +	if (!rcrb_mapped)
>> +		return 0;
>> +
>> +	offset = readl(rcrb_mapped + PCI_CAPABILITY_LIST);
>> +	cap_hdr = readl(rcrb_mapped + offset);
>> +
>> +	while (PCI_CAP_ID(cap_hdr)) {
>> +		if (PCI_CAP_ID(cap_hdr) == cap_id)
>> +			break;
>> +
>> +		offset = PCI_CAP_NEXT(cap_hdr);
>> +		if (offset == 0)
>> +			break;
>> +
>> +		cap_hdr = readl(rcrb_mapped + offset);
>> +	}
>> +	iounmap((void *)rcrb_mapped);
> 
> All of this mapping and unmapping of the RCRB needs to be centralized in
> one place and owned by one driver for the downstream portion and one
> driver for the upstream portion. That *feels* like cxl_acpi for the
> downstream side and cxl_port for the upstream side (when it drives the
> endpoint port registered by cxl_mem). It should also be protected by
> request_region() to make sure multiple agents are not stepping on each
> other's toes.
> 

Ok. I'll look into this and make the change.

Thank you for this review.

Regards,
Terry Bowman

>> +
>> +	if (PCI_CAP_ID(cap_hdr) != cap_id)
>> +		return 0;
>> +
>> +	pr_debug("Found capability %X @ %llX (%X)\n",
>> +		 cap_id, rcrb + offset, cap_hdr);
>> +
>> +	return rcrb + offset;
>> +}
>> +
>> +static int cxl_setup_dport_aer(struct cxl_memdev *cxlmd, resource_size_t cap_base)
>> +{
>> +	struct cxl_register_map *map = &cxlmd->cxlds->aer_map;
>> +	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
>> +
>> +	if (!cap_base)
>> +		return  -ENODEV;
>> +
>> +	map->base = devm_cxl_iomap_block(&pdev->dev, cap_base,
>> +					 PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1);
>> +	if (!map->base)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
>> +{
>> +	resource_size_t cap_base;
>> +
>> +	/* CXL2.0 is enumerable and will use AER attached to `struct pci_dev` */
>> +	if (!is_rcd(cxlmd))
>> +		return;
>> +
>> +	/*
>> +	 * Read base address of the PCI express cap. Cache the cap's
>> +	 * PCI_EXP_DEVCTL and PCI_EXP_DEVSTA for AER control and status.
>> +	 */
>> +	cap_base = cxl_get_dport_cap(cxlmd, PCI_CAP_ID_EXP);
>> +	cxl_setup_dport_aer(cxlmd, cap_base);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
>> +
>>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	struct cxl_register_map map;
>> -- 
>> 2.34.1
>>
> 
> 
