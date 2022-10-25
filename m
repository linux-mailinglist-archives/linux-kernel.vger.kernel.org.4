Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E660D191
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiJYQXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJYQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:23:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB2192DA9;
        Tue, 25 Oct 2022 09:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOxmDBpIexwyTmb0X7tPew3HSOYEB84/f92H45pLZSQsI7hgGrECZG+XhHE9mRfFdKJkQ6P5dDyzO4vAfIa4v2eZC3q8klhHlF7FmrvqdCnPy+9MERsPqeQedduAIKUgIGV1NmonNJE4VrCqCAqqGvp1xc6UczI5+2eWR4kulNAi+SoIP6BJWGP8s2gNoRHaSM/VcRbsOzmH60A48J4AQE6009FBFkOJuVV4ZQm28o4vw46TgkhiWJ8uv516tDhOJDhNudlX3G8X9d8pFJefeNIclTj1kqhlLejRqcP2U5KyUByaAyrgJTFNSGtyCsw7YboOI7jwoVMOYdKHiUvocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsvFXtTv5qdXmi77tnMNm9KPhg8IrQcVXC4WsTFloLY=;
 b=k4JnQTgl4dgzr6z3cPxA4lOm6iEkZ+VyKUCeKa/NAHq76dUYJ98GeYGjh1uQJdn73VGz+aTm7BsZ+8wA9IzjrysLwKVit8REuIXpnMx52POkHg5ejSODZ8Lo30sjifXBkOjoI1e8u/tl20870/94R6m823MkMNWQqqYu842Ade2lr+s4XZDffk8JoAWF1BIzQyf745se1wwM3ddZjm6EusqiWNz0JOc3mIaR99G1/SLeRBgbYMFcrvVLjSUusF96xAST5uHFuOKGCNDdTEUfn+U5GPCFnZvGzys4SrcFn0jzOg0QWdXJsypwN7ZHmawjL0B3wJRPdjdq4GrfLZ3TQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsvFXtTv5qdXmi77tnMNm9KPhg8IrQcVXC4WsTFloLY=;
 b=HWN32j4jVkxXSjyOWwkw6Uvo+HlGrY/bKiAY7w9xQmwvhK7IkdVkTHS+Ycp39E+PayT81FZF89PqoqpleYTgeW1FYuIqrDZxlmTeV8N3Fh1d9AfC1LjbRTCZ7ZVrWD2ucaQ5NJ/VhKSBp++qZJ+mKhzmIE/ckrdZ7dv6Jq1USZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Tue, 25 Oct 2022 16:23:25 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275%6]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 16:23:25 +0000
Message-ID: <ee923e4d-c2c7-a9a5-5b83-64138d052ce1@amd.com>
Date:   Tue, 25 Oct 2022 11:23:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com,
        linux-acpi@vger.kernel.org
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-2-terry.bowman@amd.com>
 <63531fad96dcd_6be129496@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <63531fad96dcd_6be129496@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: a93d1754-160a-4fe8-90b4-08dab6a53dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vb/tu44FnCSdv3QfjFOQHvtY7/cwe1mlnrS0FmTC6AdIRrv2868ea27qWAH5+Ud581HPfuZClhnckk72C2YUTmn9tXSSpZus3KAJLHupeKRAZYn6AqzzHWsJaMpLTKvSA0YXZ9dRNhvlRtl3ZAsc0wbcLgiUPLH1c50BFBUORSXXY38VxO1NeJw0JSGpS+mINhmtYujAg//A/X11rGR+y8+WytO+MAxDwZcpG9+xTXeWCg5zwcHjJ6X/2vKVWmHHkLSjFIK5wPfAc7BgiDcYskpcA8ttsRI8sFDx2WZfBJ71qFV1uzA2AcVl+fhOh9NWLKNNihCDa8sVH0GU+keqNZ//qbdKUeSzO16bp8q/eNxoGYRRa1Ona8hdfc+if6nJJMxVOxnE1ooSC6jXXJb8Ud5GoK0/2ihhJJ5YpCyaOm154EPILcmLzoJ3V9hdyjSPAK//pxBnhULKN2qkv3KFPHQ4zpEz3tb5lBGM99kiAgV2/GuxHZ0S1/IYo9+xVnzTU+V7s4pMOreedyhF6WpSJ3a+hZhGrL9/owO7oyn7ifXhIq53SGbv+oAMhTLarTUm3+jPxpnpHHcNMFz+M6CRHz/OS9FpHs4YN2JnrwZFox/HMsv8sw2oW5sJ5VK8EWvc6BFh6zYurflzVeUnGQNFEM6LrQwdINWC7nevamFGqfz33A0HJk2cw9+GwrS3uthxqCstLPx3UZ32fI5KHrMqvr/DJ7gMTmYbc+htsRRasMtOQFhkgXwLAxv4rm+P12dnP45LSRI9dNyrJ8KW/CevVxAQFUY91FtKasD1THw9cfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(38100700002)(86362001)(31696002)(478600001)(6486002)(8936002)(7416002)(5660300002)(2906002)(6666004)(4326008)(316002)(8676002)(66476007)(66556008)(41300700001)(83380400001)(66946007)(26005)(6512007)(6506007)(186003)(2616005)(53546011)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlNcXlITGxrWUJlSkRpZWRmREl0alM5aGV3NERkTHFtZWVmdGhnRXVxWmgx?=
 =?utf-8?B?WmQ1QlBNM1R2UEE0Y2R5bDR3cWM3VXVudHZ5aHdJYXV1RDBSNXVrZ0tCcjg1?=
 =?utf-8?B?c04vRGloVCtNY1VJek1VYnlzeE4rMXFFdUNEMUFkTStXbGRqWEExWEFHaklz?=
 =?utf-8?B?dW1tekxaRXF0dXlOa05xMFVGcERoTDY2R2JERVdBamZoeDljK2xyQjdBMkdO?=
 =?utf-8?B?SW1oZHlNZVJqVXRGVWlweHZ1V0pWTXZrczBsYzJ1ZElZY1dvb1M1aHNsNnhO?=
 =?utf-8?B?UUlsS1NWNDJRL3VBZ0l4ZzhZUDVUelpKZHJjVmYxUjZraTgzZ0VaamRKeFlY?=
 =?utf-8?B?MzUwL3RVV0RLVy80d2tOclc1YS9YWmUxcUxYN1hUWFplRzNFajk3dTF5SGhF?=
 =?utf-8?B?RDRwUFFFU0UzUmVuZE9kQXE2MkFoU0NLb0pmK3pXWFhKTWIwdTF0cG90aTlM?=
 =?utf-8?B?NXlHMGJHK0tHZU1kVXd6emtkS1VqNzNFN1hRcWxoWmFlSFQ3YVhvYmh0Zk1p?=
 =?utf-8?B?L2JOVXFFMGpwc2wzTEExZlBSMktvZXNCWjAwK3VHSTN1R2krUTZEem9EYUVu?=
 =?utf-8?B?ZWpXSmo2LzRjTWN5bW1MTTdxZ0hPc2FRcFZrNk5GTGVvNDFEYkVWS2N2WXRW?=
 =?utf-8?B?N0U3K0xlaHpSdy96YkZGWjRMdkxnZTk5K0g1Y05aUFdmVTlVbzNiWGRURVpJ?=
 =?utf-8?B?V1ZUQVF1V3VzbThqVDZMNDhrTkM4anpFYmJjU1YrMk50ajBPNzZkZG1DT3lB?=
 =?utf-8?B?bG5jMXM1ZEMwUTlBQzZROTlDbFFQZFoxTE1Ba0o5MjA1bW5hVWZyUUtuTElk?=
 =?utf-8?B?WHd6L3pOdHpxQzhYMHJJOWlNUjduc1pXTm5YMHVBZVM4L1JxNnNGQnFHVTRz?=
 =?utf-8?B?WjJ0b0xhWkR1YUtGVll6N3Y1ZCt5Mnc1dHVXeGdCdlVwdTFXcGJvaWRKeW4w?=
 =?utf-8?B?VFhqRTBxelkwcFVZWjVSQnhJS0xmL2VEUDY4Q3hhNmNrRm9xZVp1ZUxhc0x6?=
 =?utf-8?B?NGMyQkpUUlJoSSsybFAzcU5makRnYW5lZVJDbHRiZXVBSGJkVitkaHhoTXdn?=
 =?utf-8?B?bUlkNXhPNzBjQm9uZm5NNE8vOHp1Ri9VWGtqM1c0S05Wc0Y4QmhlcmZjWkV3?=
 =?utf-8?B?YUdRQ0VyeEx2VDhNdUdEYlpTL1gxZDVrSDFJc2dobzdkM1hjelo1TzJGQXdQ?=
 =?utf-8?B?bUpBT3Nyd2tIc2pReUl0eTMzcjdleHhnaXRzRW1ualBxL3dJV0Ira2FlanVn?=
 =?utf-8?B?UjZNTnUwM0Zic05GOE5KMVlmRG0vcTAvNURweVdtbmFld3hMSnkrckxmTENX?=
 =?utf-8?B?TURIbnF0VjVDUk1FTlF5WGRpMDUrZ3lpbVIxY1VzUUxNY1RBdEdRcHQvajNw?=
 =?utf-8?B?dDdxQ05GV2tUQUMxT3psNnVSell5RW1jN0J1TmZlT3lvdndmdlpieTlxdmJl?=
 =?utf-8?B?WVFuOXdYcVhhNmZqQTRtUTZxUUN2QzYvTEFlSUY2MUpkSUI2Q05mVTNaQ0JZ?=
 =?utf-8?B?N0hLYW9yc0QrU0tWK2lXOEFoYXVBeVA3SlVURDdMMElKcTNtbXpxVkdDRXMx?=
 =?utf-8?B?eGtmcE9lSk9sU1BxSityc05vOHVxeDlSRG5uOHZubEd0bGNnektwS09wZi9p?=
 =?utf-8?B?UGQ0NXBzaHZlWGVRZjFTVVpVNUd6MFViamQ3eTJZUFNPaWlsREFGRElTRDIw?=
 =?utf-8?B?OHZCRW5FMzZzZGY2L210ejEwVFh5Qk5lUnBQVzY1Mmh6TmthWXdDeG1VdFVO?=
 =?utf-8?B?aVU4SUtIYnZyMGpLZFNZYWF2ZmZvN0Z1eWZFMkphNjRJM3JtU040NlR3MjJr?=
 =?utf-8?B?czYwZHdycmI5Q2FRcG80RjdpWWh2dmluVXY3bTVIQlV0bmdpRlFuSXMrNjBo?=
 =?utf-8?B?Qy9DeVBIRHVNbWM0Z1c4TVhQME1DZzNhNGh0aVE2MmhWRjR0NGIzaUU3ZWJ6?=
 =?utf-8?B?aTBvZ1BNWVlicXd1WlgwK21BNWJhNkVGZG9Jc1R5a1pVWVJZWTg0b1RYVHlI?=
 =?utf-8?B?Nk1Cb2hubVVMUGZUV1NkdWM0NUtYMVZaQWFMazh6REo4Z09JRlh2L2lhWnRt?=
 =?utf-8?B?TnBzTU9PaUsvdURLcDR0U3hrYmRNNnludjUzYlovdGluQmx6eFEwdWpYakkw?=
 =?utf-8?Q?zBnJoVCNhFy++azocJ1k3fYoP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d1754-160a-4fe8-90b4-08dab6a53dd4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:23:25.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTsDwQr/ouwd7yhzN3pkAbcRmj+xElyRTEKGlA++QpbQoiVTyv8Z7BR/ohNgM8O3pUUMwxNRZPSdEx5EFb8T4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 17:39, Dan Williams wrote:
> Terry Bowman wrote:
>> ACPI includes a CXL _OSC support method to communicate the available
>> CXL support to FW. The CXL support _OSC includes a field to indicate
>> CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
>> to RCD and RCH Port registers.[1] FW can potentially change it's operation
>> depending on the _OSC support setting reported by the OS.
>>
>> The ACPI driver does not currently set the ACPI _OSC support to indicate
>> CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.
>>
>> [1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/acpi/pci_root.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c8385ef54c37..094a59b216ae 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
> 
> Be sure to copy linux-acpi@vger.kernel.org on patches that touch
> drivers/acpi/
> 

Ok, I will.

Regards,
Terry

>> @@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
>>  	u32 support;
>>  
>>  	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
>> +	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
>>  	if (pci_aer_available())
>>  		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> 
> This looks good to me though.
