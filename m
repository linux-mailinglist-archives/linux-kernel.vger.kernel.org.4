Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16176CC172
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjC1NxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjC1NxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:53:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614089EF1;
        Tue, 28 Mar 2023 06:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+B3b+DCV8QHRWfBZDgcoLxy9ltSlWi+4OeXvO7BscPi4Vi5bTyX1WsZhvV3pb2WD5GCPSE24Ax01fiTodyR0BVCUJPDJXM0LBNMFQWwVyEFMRKek81Zwx+H8fJF4abMiyGPTQzDeaHuAaWkkkTr8tsHgwpabIoC5zuMcX9ijhlTnoePqmq8KHhsl1mZgwFEford1FD3zzr3OamJVM5wNKlT3KP8UqWN9rJafbgZ3irOHrjk8R+W4VGqp9MldwR1n36BXc8SzM3utpIvNONy6T311o//j5R6qmWzA2+mY6JPVNmyQmnV4B/LZrcSCsUDqEbWfgA8gY/osaYkcl9Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm4ac5k33gKia7VJOkNeYKpe1FpCPgBzC9ZtLbvhhOA=;
 b=NrRBu2ywzkSKxFaistIqdT9rkoAdQKjv1hw6kkd1C4G59E6Dfja7wl5vzk30McXzC//MawAqbZgmkAb8ZzL7iHhhfvGjoZZ0qPYiiwNlGt5IaSIGr2JeSqhxBr1PyQqwmZFz+QDNVUf0D5fejSSxI8MnWqRR40k4QuKPp/zUeMkXZUzbBoLuk+A+gI+IMP+xPF96vuVTHSBzfp2l72pVwk2EGdX3k0XM1U3GRn61RhJtOxHLlu9/LNcaB/bCdIZA5ivi3+NGDZdGhlzBW0HeKsinf/R/YXjB+A4j4bXsGEUCj+X5QkmfL1hsosECdxo5yZwzNIz4kVRTWlXbOqgowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm4ac5k33gKia7VJOkNeYKpe1FpCPgBzC9ZtLbvhhOA=;
 b=a+fgo3ks6GVye0qfIg0v6wfwMJJB/WVRYKEiT5o1zSIDxji/b06iGU5T9m/wFh1PUF9NJjcLKAPgHkx+/prAru96PzwZXI6cfdhIFksJ5MK56+TmLEke1D3hEnIvGMCe1/vwQzZFa4aSq768bWW93/mpJswDqjfi5qfRCdnKGLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.28; Tue, 28 Mar 2023 13:53:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%5]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 13:53:04 +0000
Message-ID: <100233eb-0b9b-358f-a66c-a0cc53af7df2@amd.com>
Date:   Tue, 28 Mar 2023 08:53:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-6-terry.bowman@amd.com>
 <175c0dcf-5170-0e9a-792c-2fc1cccd52fe@intel.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <175c0dcf-5170-0e9a-792c-2fc1cccd52fe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 894d2056-efd6-4678-1c5b-08db2f93c0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPomp7f2BMX+UEA48rKhQ3Yf1XL/smSq0tny7D5Uv/NVla7x8/RIXiwWlh4a/uDu2nJbpT1JGQq/8sSzHBJOkLRcXy0yHMKP3jE02iG/xO/IY6aEnp7ObuLJMZsE0P/M5UL2HV7EvrqkDzXHaRr2I+qw0axrMa7CVOyJzPljvFfHXbR2CrN7Z6/myGgqui5Mtm3rNXTcEdrkO9ihwjCWnckZMaeP6U85K6HHldY1qKPZDAvfn+dol7Py/0irbBzIMWgLY6gjsy0Y1faXT1LDD80okxJYhwKY88wN+XRMaXCgctqTpOJw8gvl9Y1R/OfJp/gN/qMACW7f+35XrSQG8rfchTx+JUS+uuzKbtrXwRPkVvUZSjEflA8gEEU/rbPAWwjvPRfUb20+Utj9FvusIUkH9W+t9Z1igJwrdw/Zhfn9BunY6zcvsHDHOTI7aElhUankLdO8KFObdVwrklEdXZcfscLZU3Y8yYRWYsRgtwUBP1pSjUKylmWUz0iPLLqmZLQrNsY82HFYVIE2cr3sAfH8eluuRaRC/gaFV1CoPjzo/elS2MccDLtDhi8OPA5Vm+cqxSyeFwM4dPgn6NWdeJOTMCQBEY77wixUjhONni9UBke479ZBJevRaVUzNs/OrdA9gGZZxsuurdeIPxudYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(4326008)(66946007)(8676002)(66476007)(41300700001)(66556008)(36756003)(5660300002)(2906002)(186003)(83380400001)(30864003)(31696002)(86362001)(38100700002)(2616005)(7416002)(8936002)(6666004)(478600001)(6486002)(6636002)(966005)(31686004)(53546011)(6506007)(6512007)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Fpa0RHVzVDQUNrbjg1MDIxajZoZ1AyV2xiczVBOXphYTZicWhDOWlGcTRz?=
 =?utf-8?B?WXpzL0wwSmxSR0ZqMlR1Q3BwRVpmRHRkT0RMRTRraHNjdU9SUFlBbXIyeVQv?=
 =?utf-8?B?SENha0RDT0g2WkZUQ1dkekE2Nlh1Um50dk91bUY5b2RkMEw3ZldUSml5UHFk?=
 =?utf-8?B?M1NUU1Z3TkdWZEwvOURHL25VaSs2YUlubUdNRW5nN29YTGozT2UwdVNWVDNF?=
 =?utf-8?B?cUVYc1ZWVXAzbC9GbW9GSndLV1dHbnZNUGFmaDlqa09CNTJqbVM3dmZ5ZlpH?=
 =?utf-8?B?V2lDeERKUjJJRmYwMitmT01tMkQ5MEFOUG9Ma2pwbUE0clBXdC9hU1Vuc2lP?=
 =?utf-8?B?aU1Qby8rMlEvYkVIRGpWUWhGbG45SmZvcGV1Tno0a1BiQlBDaVdrNGNxaVJW?=
 =?utf-8?B?Uno2ZzRHeFdKU2Jza2xXY3RkSmU3eDQ2TkFuTnJYaWlXaTlEMnAxZkEwUXJB?=
 =?utf-8?B?V25ZTEpNdnlMd0I5SjdlbGJ5RFk0djI0L0tvNFB5NlltWWFwdk4weUVBeFdF?=
 =?utf-8?B?bDNudXFCMDlGcDZlSm1BQWE4WWdxemdHUzFxVlhJK3JOdmxTbkZYNDlpSTZm?=
 =?utf-8?B?Nllad1FmQ3RNTFJ5ZmlCVVA4Ty9NSm5SemRjZStyaDFLVHFnd0Z0dC9MZnBZ?=
 =?utf-8?B?RGNOU0Q1QmswSXdjMk9RWERFZ0E2WkFKK2VjNGZ6dEptWStFSjArMkdSWXlP?=
 =?utf-8?B?endOdHhON0NobTdKYjlxQ1VBK01mWEdCZDZsOUdTc3EyNkdBNWNISmNUWG1M?=
 =?utf-8?B?RkRMaEh2ZXByR2ZJVytwd2t3dEl6SjAzanJsTk1UejUyNzJlSVR1VHRpOG14?=
 =?utf-8?B?UzZIejNaY05WdWdGeXVxM2hXaVZ2OVRYVlBCVzJsMDNMN1dPQ0E1aXJGQ1Ev?=
 =?utf-8?B?aE8xK3pkb3o5RVI4SEQ1VmRaTUt0Zk9jQ213eExzNlo4V0tneFVxZnNTZEhJ?=
 =?utf-8?B?VHBlaDZ5alo4akVDRDRzSDdHZ2poSXluRFdNRVIrb29JVzE2R0Z1WkJ5RWtV?=
 =?utf-8?B?blhKZzZXZ0g3VTBmMHk1Y3JxTFpKcTFqM1MxTER5YStpb25jcCt1c05FemxL?=
 =?utf-8?B?QklBQ05wOWJYdnU5MGlxRUpGR1dPNTV3MW9pUUowUGpVMDUxVlYxNnVtZjZY?=
 =?utf-8?B?bXZ6OUVuZjhzeklvbHZTL3lqcWlHVXRKMFhDYVhUN1g2UHZhRXBhak4rSTJo?=
 =?utf-8?B?Ti9NZkdJTEhHN1VTZVNMTW50WkduOFBnejEwa3I0d2lJdXRJR2FISDhBTDJY?=
 =?utf-8?B?N21GRzMwdzJudTdmVWZBR1EySGRPWFdCblFoM202WWNpREthRytsTE5Cd2Q3?=
 =?utf-8?B?S0dVc2dudkVKOFNaTjROVWJIQi9PdEVQYm4yUVdmUFN1bFBGMTBVK1NnWFNZ?=
 =?utf-8?B?alBqVzNvWVNtRXJWWVN5YmlnWGtrQlo3eWZ5SE1BTTJTY240b3Z5N0x3Tk5o?=
 =?utf-8?B?TEpnRE1xNktQd3JWSXFYcGs5SG5LamJKQVp3V1A3K3lLRXRyblhuYm0vdkQy?=
 =?utf-8?B?anRocmJrNVZnQjZiMUxEcjlxNmpTZS9ZSnpPcldHWHZRVUF6MGtZRVc3akE4?=
 =?utf-8?B?dmxRV0xGUEhVZktCYzRZanNsVzVEcVg1S3lpaGZudmxDYm5yaXlqZi8rSTUy?=
 =?utf-8?B?R212SzByR0Z6NXpzMG11YmtuRlRRZkU2TWN4Yk9VS0ZmMXBhbFlXSzljRjJC?=
 =?utf-8?B?ZDRHRUFiNU45NW9DaDVRRjZqZXV1b1Z6clNyU1hZN29YVWtublBrNFM1cHp3?=
 =?utf-8?B?cExnWEpNajFmK0ZRbitYTkIwOGdhbmNYeGF0QlBsTUhia1lYdnlSQ3R1VnlL?=
 =?utf-8?B?dDlmR0hkQlMxRU5saEROSndNMGZUTzdtdlhPQmswNnU3NEd5QTFsVWhtM2Y2?=
 =?utf-8?B?aUhzTGVibEc0K1ZJNUdMSnpMbnNjOXljZlNHcDRtVk9YbUJNSzd2N2lyM3d2?=
 =?utf-8?B?bkwwbnhrcWNuT3AxSk1ZQzRUYnRaem5NdzRSTnIyVDNtVGx5NnNnZmt4Q2d6?=
 =?utf-8?B?SkFMS0ZqS09TbDltRWxXaU44cUJLOEUrbVVHUVB5T2RtYW45SmZRSVdXaEhr?=
 =?utf-8?B?RDlhUlA3VC9UVEtRYkpnWmhWZzdCQk1UWUlFMGRqVkpaak1EOUQxZGxpMUgx?=
 =?utf-8?Q?TwrVgswrCdJn99HkyY0T9ZMIa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894d2056-efd6-4678-1c5b-08db2f93c0c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:53:04.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOicE/8KOyRut7t93akgLnpR42aDxG6TakgwJ8SgJbMDdpqXbu2ycpDU3B0q8DLM2SGy2iP1ITpMDo9qAQeDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dave,


On 3/27/23 18:21, Dave Jiang wrote:
> 
> 
> On 3/23/23 2:38 PM, Terry Bowman wrote:
>> RCH downstream port error logging is missing in the current CXL driver. The
>> missing AER and RAS error logging is needed for communicating driver error
>> details to userspace. Update the driver to include PCIe AER and CXL RAS
>> error logging.
>>
>> Add RCH downstream port error handling into the existing RCiEP handler.
>> The downstream port error handler is added to the RCiEP error handler
>> because the downstream port is implemented in a RCRB, is not PCI
>> enumerable, and as a result is not directly accessible to the PCI AER
>> root port driver. The AER root port driver calls the RCiEP handler for
>> handling RCD errors and RCH downstream port protocol errors.
>>
>> Update the cxl_mem driver to map the RCH RAS and AER register discovered
>> earlier. The RAS and AER registers will be used in the RCH error handlers.
>>
>> Disable RCH downstream port's root port cmd interrupts. Enable RCEC AER
>> CIE/UIE reporting because they are disabled by default.[1]
>>
>> Update existing RCiEP correctable and uncorrectable handlers to also call
>> the RCH handler. The RCH handler will read the downstream port AER
>> registers, check for error severity, and if an error exists will log
>> using an existing kernel AER trace routine. The RCH handler will also
>> reuse the existing RAS logging routine to log downstream port RAS
>> errors if they exist.
>>
>> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 126 +++++++++++++++++++++++++++++++++----
>>   drivers/cxl/core/regs.c |   1 +
>>   drivers/cxl/cxl.h       |  13 ++++
>>   drivers/cxl/mem.c       | 134 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 262 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 7328a2552411..6e36471969ba 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>> +#include <linux/aer.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -605,32 +606,88 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   -void cxl_cor_error_detected(struct pci_dev *pdev)
>> +/* Get AER severity. Return false if there is no error. */
>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> +                     int *severity)
>> +{
>> +    if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> +        if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> +            *severity = AER_FATAL;
>> +        else
>> +            *severity = AER_NONFATAL;
>> +        return true;
>> +    }
>> +
>> +    if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> +        *severity = AER_CORRECTABLE;
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * Copy the AER capability registers to a buffer. This is necessary
>> + * because RCRB AER capability is MMIO mapped. Clear the status
>> + * after copying.
>> + *
>> + * @aer_base: base address of AER capability block in RCRB
>> + * @aer_regs: destination for copying AER capability
>> + */
>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> +                 struct aer_capability_regs *aer_regs)
>> +{
>> +    int read_cnt = PCI_AER_CAPABILITY_LENGTH / sizeof(u32);
>> +    u32 *aer_regs_buf = (u32 *)aer_regs;
>> +    int n;
>> +
>> +    if (!aer_base)
>> +        return false;
>> +
>> +    for (n = 0; n < read_cnt; n++)
>> +        aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> +
>> +    writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> +    writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> +
>> +    return true;
>> +}
>> +
>> +static void __cxl_log_correctable_ras(struct cxl_dev_state *cxlds,
>> +                      void __iomem *ras_base)
>>   {
>> -    struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>       void __iomem *addr;
>>       u32 status;
>>   -    if (!cxlds->regs.ras)
>> +    if (!ras_base)
>>           return;
>>   -    addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>> +    addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>       status = readl(addr);
>>       if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>           writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>           trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>>       }
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
>> +
>> +static void cxl_log_correctable_ras_endpoint(struct cxl_dev_state *cxlds)
>> +{
>> +    return __cxl_log_correctable_ras(cxlds, cxlds->regs.ras);
>> +}
>> +
>> +static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds)
>> +{
>> +    return __cxl_log_correctable_ras(cxlds, cxlds->regs.dport_ras);
>> +}
>>     /* CXL spec rev3.0 8.2.4.16.1 */
>> -static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
>> +static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   {
>>       void __iomem *addr;
>>       u32 *log_addr;
>>       int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
>>   -    addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
>> +    addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>>       log_addr = log;
>>         for (i = 0; i < log_u32_size; i++) {
>> @@ -644,17 +701,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
>>    * Log the state of the RAS status registers and prepare them to log the
>>    * next error status. Return 1 if reset needed.
>>    */
>> -static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>> +static bool __cxl_report_and_clear(struct cxl_dev_state *cxlds,
>> +                  void __iomem *ras_base)
>>   {
>>       u32 hl[CXL_HEADERLOG_SIZE_U32];
>>       void __iomem *addr;
>>       u32 status;
>>       u32 fe;
>>   -    if (!cxlds->regs.ras)
>> +    if (!ras_base)
>>           return false;
>>   -    addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>> +    addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>       status = readl(addr);
>>       if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>>           return false;
>> @@ -662,7 +720,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>       /* If multiple errors, log header points to first error from ctrl reg */
>>       if (hweight32(status) > 1) {
>>           void __iomem *rcc_addr =
>> -            cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
>> +            ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
>>             fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>>                      readl(rcc_addr)));
>> @@ -670,13 +728,54 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>           fe = status;
>>       }
>>   -    header_log_copy(cxlds, hl);
>> +    header_log_copy(ras_base, hl);
>>       trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
>>       writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>         return true;
>>   }
>>   +static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>> +{
>> +    return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
>> +}
>> +
>> +static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds)
>> +{
>> +    return __cxl_report_and_clear(cxlds, cxlds->regs.dport_ras);
>> +}
>> +
>> +static void cxl_rch_log_error(struct cxl_dev_state *cxlds)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +    struct aer_capability_regs aer_regs;
>> +    int severity;
>> +
>> +    if (!cxl_rch_get_aer_info(cxlds->regs.aer, &aer_regs))
>> +        return;
>> +
>> +    if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> +        return;
>> +
>> +    cper_print_aer(pdev, severity, &aer_regs);
>> +
>> +    if (severity == AER_CORRECTABLE)
>> +        cxl_log_correctable_ras_dport(cxlds);
>> +    else
>> +        cxl_report_and_clear_dport(cxlds);
>> +}
>> +
>> +void cxl_cor_error_detected(struct pci_dev *pdev)
>> +{
>> +    struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +
>> +    if (cxlds->rcd)
>> +        cxl_rch_log_error(cxlds);
>> +
>> +    cxl_log_correctable_ras_endpoint(cxlds);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
>> +
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>                       pci_channel_state_t state)
>>   {
>> @@ -685,6 +784,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>       struct device *dev = &cxlmd->dev;
>>       bool ue;
>>   +    if (cxlds->rcd)
>> +        cxl_rch_log_error(cxlds);
>> +
>>       /*
>>        * A frozen channel indicates an impending reset which is fatal to
>>        * CXL.mem operation, and will likely crash the system. On the off
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 108a349d8101..7130f35891da 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>         return ret_val;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>>     int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>>                  struct cxl_register_map *map, unsigned long map_mask)
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9fd7df48ce99..7036e34354bc 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -66,6 +66,8 @@
>>   #define CXL_DECODER_MIN_GRANULARITY 256
>>   #define CXL_DECODER_MAX_ENCODED_IG 6
>>   +#define PCI_AER_CAPABILITY_LENGTH 56
>> +
>>   static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>   {
>>       int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>> @@ -209,6 +211,15 @@ struct cxl_regs {
>>       struct_group_tagged(cxl_device_regs, device_regs,
>>           void __iomem *status, *mbox, *memdev;
>>       );
>> +
>> +    /*
>> +     * Pointer to RCH cxl_dport AER. (only for RCH/RCD mode)
>> +     * @dport_aer: CXL 2.0 12.2.11 RCH Downstream Port-detected Errors
>> +     */
>> +    struct_group_tagged(cxl_rch_regs, rch_regs,
>> +        void __iomem *aer;
>> +        void __iomem *dport_ras;
>> +    );
>>   };
>>     struct cxl_reg_map {
>> @@ -249,6 +260,8 @@ struct cxl_register_map {
>>       };
>>   };
>>   +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>> +                   resource_size_t length);
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>                     struct cxl_component_reg_map *map);
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 12e8e8ebaac0..e217c44ed749 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/device.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/aer.h>
>>     #include "cxlmem.h"
>>   #include "cxlpci.h"
>> @@ -45,6 +46,132 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>       return 0;
>>   }
>>   +static int rcec_enable_aer_ints(struct pci_dev *pdev)
>> +{
>> +    struct pci_dev *rcec = pdev->rcec;
>> +    int aer, rc;
>> +    u32 mask;
>> +
>> +    if (!rcec)
>> +        return -ENODEV;
>> +
>> +    /*
>> +     * Internal errors are masked by default, unmask RCEC's here
>> +     * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
>> +     * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
>> +     */
>> +    aer = rcec->aer_cap;
>> +    rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
>> +    if (rc)
>> +        return rc;
>> +    mask &= ~PCI_ERR_UNC_INTN;
>> +    rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
>> +    if (rc)
>> +        return rc;
>> +    mask &= ~PCI_ERR_COR_INTERNAL;
>> +    rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
>> +
>> +    return rc;
>> +}
>> +
>> +static void disable_aer(void *_pdev)
>> +{
>> +    struct pci_dev *pdev = (struct pci_dev *)_pdev;
>> +
>> +    pci_disable_pcie_error_reporting(pdev);
>> +
>> +    /*
>> +     * Keep the RCEC's internal AER enabled. There
>> +     * could be other RCiEPs using this RCEC.
>> +     */
>> +}
>> +
>> +static void rch_disable_root_ints(void __iomem *aer_base)
>> +{
>> +    u32 aer_cmd_mask, aer_cmd;
>> +
>> +    /*
>> +     * Disable RCH root port command interrupts.
>> +     * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> +     */
>> +    aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +            PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +            PCI_ERR_ROOT_CMD_FATAL_EN);
>> +    aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +    aer_cmd &= ~aer_cmd_mask;
>> +    writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> +}
>> +
>> +static int cxl_ras_setup_interrupts(struct cxl_dev_state *cxlds)
>> +{
>> +    struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +    int rc;
>> +
>> +    if (cxlds->rcd) {
>> +        rch_disable_root_ints(cxlds->regs.aer);
>> +
>> +        rc = rcec_enable_aer_ints(pdev);
>> +        if (rc)
>> +            return rc;
>> +    }
>> +
>> +    rc = pci_enable_pcie_error_reporting(pdev);
> 
> Hi Terry, not sure if you saw this thread [1], but with the new changes upstream [2] to the PCIe subsystem, Bjorn says we no longer need to call pci_enable_pcie_error_report() by the driver.
> 
> [1]: https://lore.kernel.org/linux-cxl/c2e244bd-a94b-8de2-e43c-7ff8a756cbc7@intel.com/T/#mef401fb0580ebb4c4bc2a164f87e12b60cf76693
> [2]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> 
> DJ
> 

Ok. I'll remove the call to pci_enable_pcie_error_reporting(). This 
will help simplify since it allows removing disable_aer() and call 
to devm_add_action_or_reset() as well.

Regards,
Terry
