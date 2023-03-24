Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4FA6C837B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCXRlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCXRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:41:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133A17142;
        Fri, 24 Mar 2023 10:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFEDYn3l1sSiQ9lL1cCGyK2Hf8OUyJukoS9tJLvIvMgZubSiWRdgPP8J6M5BzhXj05CXf83RjjyE+8ajrJy8T3FkDwfF+UEedZHKXGakH8pGXLYZurVZC3xlaHxl0QvZKHVpxkkdeZNsX9HeRP06et4kCpmg9ulPDyiLxw0jmRWZrS0i3aHqsc58wA7YoS0lKJ6DLlNEkYOGQG75reyHo4xkg413LIumT0FMLPdaSXIKnHM7igGpWb1htOHFAC813yWRKPbNlsiDacTJGZ7UjeJbKcYsvIIFN4kp0QO1kxf/Nqna4GlR5hWTK8xWiekDKX2BnZT+v4qXuMJy2cIGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQhpyV3URBLWe+xngP1NU8QdUR/DbxTOwJYO9tHq2XQ=;
 b=Alfg7bU/+hnNQIv5vN42W5XmHG1o6PixE8vfzx8qn96qP0t+siw7MGyWNS5ebTcsfas7DKzqn9a+NYoVgApJ+ZtALWrY0FSpPqnP2Qw24kEQpH3gLc1umvx0Mmv6GR9O7jZsNhTxqG8ZyMzLhV+zbJwQauWpQNpMOIhLnHQ9kaErIXHLdDZa4l5pa2vNj/676VDNqG7ZrjvgaVkDXqCtwSaOQ0kGpPtpOIruufUXW754R4w/JSm/5LfeqGCTz887wnmObcpJP0kT7sFYFdaM3TnpeFEqwWAoKyv7ZZPXxNBwzT0Wtj05wmxfZM8ahtYgOcf0ZuzmJNw/Ul92gWDgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQhpyV3URBLWe+xngP1NU8QdUR/DbxTOwJYO9tHq2XQ=;
 b=GdJ6cGiEBeSTldMJkRWNQvF8Bf5U48JYS0KEcKqSWrF37RusG6JBLLaEddJOAZ0lO/k5ef2F0k+D3A3O2ZakcY0y6bMrIIBHfJMVOIIgX/WZUK/vO3v7Lk+EN4A2q4IpH1aJtcfyBYZaZM0MjcWOsW3T3EKT1chj8qdOfGzcrw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:41:10 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 17:41:09 +0000
Message-ID: <ce57b2ce-dcf1-1b32-3ebe-aeca66ff0f7a@amd.com>
Date:   Fri, 24 Mar 2023 12:41:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
References: <20230323213808.398039-6-terry.bowman@amd.com>
 <202303241458.BV292BDH-lkp@intel.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <202303241458.BV292BDH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9016d21a-ff28-4bd8-193a-08db2c8ef436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMs1RuQXg9fOjgowHON04YFrwPmrvAY06ySYJ/TjEecZWm/UFMcWF/TszxUmPMobs48wx2nc1CV1p8u7IHnA3QF465XR3HlKBMFiaJ1IpIi5QM/9EIsOStUpa8dFw/uaHXI1JGZKJcOorYgV7GDjAWkoh4qyIL8bi1cudBzXiQqL1/MOf7oWLknSpWiJ8E/+eZ26wP+HGWX3FS8E0iit/PiPOi7+SQtfICpFpkhE+R1uQe8oSfSf2rlWUL28pAxaM4ju0yf4xn1gCXnk5S1S6UZH8y7WBSlaWngqbFPKwWrEU2NSB/LRbBRq1IfLNeWB35bF2Nn9Iwh5QjBNnJqje9wTrydiee1Ty05tbV42aGOZulv3vNAI2rQ9qmqWFcLJNuHG7BrY18HinvCsXMQRAAPbbWBMPuylC7q6CNywmXvY2qzSNy0+3VIiX4WnK4kvD1x8dC1+kQhVNjkb4rDgfV8HuPWOVTpYKnE6NivAnHpip9SOl7sfJBA0w4CInQ4KYFBgn9MqT6gymHslgrv1cu5e7qNL5YH/3VjMesNYmdXt7SLbe8TPyjo4vdzId1Ltr5k+MArfyD/19qKfHma3oDxGhKMZz4jrGbcYrJnCRxuEIMJ2feFzJVL5Jv53W8pb2e21ZvhcaUJwWQnRApery8CQGsT36SLKAWGeQBdAPv1xJ5pomM4fUOjVjnUxCDGtWQe3UrpSYomCxCf/VGgMELTzYd6gM+lu0v9sLm9T8h5oUxXj0XhD8DayaIyLUOxgY1KoTpuqKcGDPID3XeNnEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(6512007)(186003)(31686004)(83380400001)(86362001)(38100700002)(4326008)(7416002)(2616005)(8676002)(66556008)(66476007)(41300700001)(8936002)(66946007)(5660300002)(921005)(36756003)(6636002)(6506007)(6666004)(53546011)(31696002)(316002)(6486002)(966005)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlCNXdjWTlJRUk5cE10bnl0YzIzUVJzeXFvN09CemtLVFl3ZXBUL2l5STdl?=
 =?utf-8?B?WTh6dHZsNUwvc1hLOG5Ea0JDZFBjbkpmVUZKaFdWMURBTGxaVlpKa2srSmd3?=
 =?utf-8?B?UG90WGZ6TUlqbnNzN3U0U0RoUnN6VUsyMFpPelVGbUh5Z21UWXdVUERyVHUx?=
 =?utf-8?B?N3hSQlF4RHhoWTF1WnNQNGQ1QklDeVZhK3pna01KSGJwdkNtbGhXaUx3cWpC?=
 =?utf-8?B?RE1neHgyNm02cVVNR2s1TmVvM3c0NEtTRWIybElKYjB5aHYrTVVkMmdtcGFP?=
 =?utf-8?B?ZFBJd09tQ0htU25leXNiTXRwMzRhWFlsYVNUM2ZZTmM1RUo3RHl5QmFQN1Fx?=
 =?utf-8?B?Wko0d3NteTJSczlya2FJVTduYW1TZnNldXVpWDRlc1N6QzZ3dFFzazJMb2ht?=
 =?utf-8?B?RWtsOGhKWUczaDJpSFo3NzRKVnEwUlFIdE15elNLMk1PTDB1cjJ5aWlEaUNK?=
 =?utf-8?B?cnU0N24wSWtPVlJLaktuQkhRYUUzemRscHRuK3hMbjJFY0Q0ZnFqMHVGU21R?=
 =?utf-8?B?U3NGeWdUc0pMV21iMzFZZHM2R0E5ZjZQeC9heHVueXFVeGlIOHdlbSsxL3dV?=
 =?utf-8?B?YXB2V0thakdBVjBuNFBRaVFNZ2hjalloRWRsK3ZuZ0JnOW1lVkh4bmZFdGdu?=
 =?utf-8?B?dHJvdThJZmVIcDdMcEdHWW9DRWRLRlE3QzFTblQzdFEzVWlPU3pldDJFV1RR?=
 =?utf-8?B?S0dERmdKMVVVWkkyc0FRWEtsbjUxbjN3TEVacXNWck5ISHliSnpIcUFKUlB4?=
 =?utf-8?B?cDVQdllmMGdDZ2dzZHJuaUt6NnRoK295bHpuNkV6RU00Y1hEZVgvNGMwd2M1?=
 =?utf-8?B?cWhYT3RST2hmWFNJcE1DZENFcVlHMVV0azhOakhYNEpoQnc0Z0ZTK0M5SFVF?=
 =?utf-8?B?ZmpXOU5TQWZ3T01QVUFXQ3JBSkRGSlg1UnVob3N4NGlrRjkzNGRHUkR5bE9v?=
 =?utf-8?B?NXlvOW1DYVlrYnBvVHVYQngwUU1WV24vdWs1WC9vMjAzeWhPN0EyL2NHR2Zn?=
 =?utf-8?B?VHBWRjdWT3ljT3dtYjYwRWVlRC9XNFJwRG1FSHV1RXhNcmFNSXJRY283Z3ph?=
 =?utf-8?B?U0MyMG82cm1FRHdzRThUWnUzYkgzbXYxN0pNcHdlbCs3MGVRaHJ2TzJtYjZi?=
 =?utf-8?B?cXpIZGRZK3hjL0V6NzRBZDVraHRLWDdmc0NoVGNvVzBoSnJzMVo0YVZsdE5V?=
 =?utf-8?B?UFljOUpEWkgwQlFxZHE0MFVMR2VqQm5Jb2x5R0xma0N5Nmd4aTdJd0VSL0Rn?=
 =?utf-8?B?RWM4WjVUTjBpQVVodVFGUGdzYUxNaUdPRzVnMzNyNXFxNUJQSGErbFpyU1RB?=
 =?utf-8?B?UEJKNFBFYitHTUJDcmtxM2hxWUM1ZGgwSWlPYUJYR2toUTQxV0VzOGxIRGRY?=
 =?utf-8?B?YzJpd2xEeTdBZ0FhWEp0bGpwY2hlUlRldDJNSHNzWVEyRHlGSU5FUzdXNG9O?=
 =?utf-8?B?a1VKOXRlMWJack10cDQzSFQrMFB5SGFONSt3aUJsck8wZTJQTDFKZ21UVFZm?=
 =?utf-8?B?VEMzVW9FWUlqdHNMWjZzK0JHV01CTFg2aDByWXJoT2NzVEh5VElEYW5HN0Ir?=
 =?utf-8?B?ZERHWGZ6QnREMEZxUTYzc3lkTmZsV1R5eWZDL3VvNXNhNTBCaklUMkN0Wklo?=
 =?utf-8?B?dUs5U2Z2djNKRXMyZStEUWVTWjhNcUpHMm9sNkcyZHlMZlRyaU5QV3UyaHZu?=
 =?utf-8?B?M0Q5eGMrNitwN3pvWWsreU9tNXRaSW5PbGhuS0t0aElUYSszVndPZ01BR1Jz?=
 =?utf-8?B?eEVCNXhTdzYrWFBlME1FakJTQkZwdE1qZ3NPSnR2eEl5UnVDTitySjJYUURB?=
 =?utf-8?B?UDhRMmUxNHRFaDUzRkY4Qno3Yzg0RzYyT3VaZjYzK3pjMTY2N21uMEJQRDZk?=
 =?utf-8?B?SU10WkdoU2tnSk9lYlJ3R3dkV3EySTRqY3FySytBbExLNDJQaDZudU41enZH?=
 =?utf-8?B?KytueGtsREtxZlhCYUtZZVdzWklXelIyRXgzM0VMZGhXeVoxeWdSNFB4aTZL?=
 =?utf-8?B?ZFdyWEU3RWs3SEhqRkNwTk8wZnlrVTFWOXZjRmEwOXQvN1Z1b3JLckNPSzJl?=
 =?utf-8?B?UUxSSHNFVW54V00vWjhNYXVkNXUzeWlIejR1ZmU4VnBqdGplZkg1K0lGV0F3?=
 =?utf-8?B?VFJIa3pEVHNKYU8rc3VUZHZTVExjWS9vYzlHb296d0lWTkU5Y3huN0ZJLzRI?=
 =?utf-8?Q?LBPrfCtmRJno741fVvkDE9b4d4D4jv38hbv+7ehcioeQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9016d21a-ff28-4bd8-193a-08db2c8ef436
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:41:09.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW/dTKfShAwPl/hMXYQeskN41tXGY+wlVt/fDdATO+a7kq8jaxl0jT2ulEontUX7PTYKbmQS6ioOYVZpEQbgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added a comment below.

On 3/24/23 01:30, kernel test robot wrote:
> Hi Terry,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus efi/next cxl/next linus/master v6.3-rc3 next-20230323]
> [cannot apply to cxl/pending]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20230323213808.398039-6-terry.bowman%40amd.com
> patch subject: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230324/202303241458.BV292BDH-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230324-054044
>         git checkout c40ca148e9cff1a1c32cd4c5c9b252bf0cf201b6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 olddefconfig
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303241458.BV292BDH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cxl/mem.c: In function 'rcec_enable_aer_ints':
>>> drivers/cxl/mem.c:51:36: error: 'struct pci_dev' has no member named 'rcec'
>       51 |         struct pci_dev *rcec = pdev->rcec;
>          |                                    ^~
>>> drivers/cxl/mem.c:63:21: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
>       63 |         aer = rcec->aer_cap;
>          |                     ^~~~~~~
>          |                     ats_cap
> 
> 
> vim +51 drivers/cxl/mem.c
> 
>     48	
>     49	static int rcec_enable_aer_ints(struct pci_dev *pdev)
>     50	{
>   > 51		struct pci_dev *rcec = pdev->rcec;
>     52		int aer, rc;
>     53		u32 mask;
>     54	
>     55		if (!rcec)
>     56			return -ENODEV;
>     57	
>     58		/*
>     59		 * Internal errors are masked by default, unmask RCEC's here
>     60		 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
>     61		 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
>     62		 */
>   > 63		aer = rcec->aer_cap;
>     64		rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
>     65		if (rc)
>     66			return rc;
>     67		mask &= ~PCI_ERR_UNC_INTN;
>     68		rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
>     69		if (rc)
>     70			return rc;
>     71	
>     72		rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
>     73		if (rc)
>     74			return rc;
>     75		mask &= ~PCI_ERR_COR_INTERNAL;
>     76		rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
>     77	
>     78		return rc;
>     79	}
>     80	
> 

I will add #ifdef checks for CONFIG_PCIEPORTBUS and CONFIG_PCIEAER
around the related code.

Regards,
Terry
