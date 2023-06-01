Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200B719F26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjFAOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjFAOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:06:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D08184;
        Thu,  1 Jun 2023 07:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2JDlfg2VMa5C5RUqaVPZWgDyPo6HD9Y1UwC71SxfeUzxRPt6e9gAbvG+jhMAhNMsCs+2heryJeSFDVwqMvFlbqYEL4AR/hQOPJCrrjm2OkzuHgE+6hHekrlWaPNoyCWaF5bX175Ke8n9ndmXJHBlC86I7dkK99traghATlQT8RVtDeZ4XcNolCQ501bowLhhOfoKszfGr9mlC9jYNUAQoaJNXXwIfuW0caOIK+3bYpUXySjJk6XiYkYt3eyTf9+SB/ah/FFNkaBdxW+Zgbk/51BmIyxjfoUfUv4gVZSRxmoMs27XuYv+rYwJ45ULAoin+N+p4ARifHU6VlamD3M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKElwktVqcAp48tKQ9ldzmXTD5TTWoRttsc3MBIoqMo=;
 b=m0JGJ3KBHxrWADdOb313L/jqnA/QjL2VKmUYW9EVut2gW4m9q+DylNWPVJGPsNYpMNFA3cIivdmK2ihiMPGgTg1pd7yYHPVGnh5erWGhvicM74cAOaebLSV8j0vLBT1j6Jr0LihJZemnETfgpIawsOyRJLuFmpuLmmpFAV+him5toxAwqWbuHEKQGKWINmWDS4Hk2nzfBs3/z2/iCZLW/oGyh3As53OfQcrOwsEscG9M+k6Vr0024BN90P/4bjYZzg3w2oUDzMJAHbrQcfWU/H15PdGGwA/KDu1NpaLTqhoah9Re6gVx7DzjXG3Mk9S4G0dalqGgRqGUPZdEjiphAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKElwktVqcAp48tKQ9ldzmXTD5TTWoRttsc3MBIoqMo=;
 b=UZ9wXdjFyfv0gEAAkYhfdva8+zgwZbceq2znUwY1sUrOrqNROV5BNSCKsEOpDkJn6MHmDiWDMHjetbcvnqTFkmCgJDGRRh6AHbGG5F7aX1gb7IxDoeOgZH8pXe84Kwc6K6O1WGVIc6d9FTVm0h3Ox2TxyG4kYpMb1v7dccm/1e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Thu, 1 Jun 2023 14:06:26 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b51:9dfa:457d:b9eb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b51:9dfa:457d:b9eb%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:06:26 +0000
Message-ID: <11c99f76-2473-bf71-c2d5-f697b1b0e412@amd.com>
Date:   Thu, 1 Jun 2023 09:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 20/23] cxl/pci: Prepare for logging RCH downstream port
 protocol errors
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-21-terry.bowman@amd.com>
 <20230601144942.000075f5@Huawei.com>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230601144942.000075f5@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:408:e4::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: fd823a8c-c3b9-4dcf-df52-08db62a963cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjnL/n/WXjbx+um174oudO1Juk+KI70QRGvAzpHQy6CS//tuCwAs3MiaiL7d+BlZN6Ut/xsPrIs0A1T/LYV4G+x2l/1VmsNzoR7tJ4K22lWhmAANWPlFduLj+wBY3+O1Uz/EZYglrSMlgFNUbHocmBpUCldodL1mcuEp6AqPrPb6JPyf/Kx+DnWHXwMh8xPoNQY/kB7MMqCMpZqgRCg+zm6WhBewkxAJGq85xil6UHBfyO+wCK/l2kYXUc2VW5XlFko0+akaNy1HlpZz2bei1cTB2mWfpDEmz/55K/GgmEpQTCUu9qMMdwM36kh4PD9p3Wf9YD/e8EcdBdeb4LbLGB8PYQcJvkG0J5qW5xPG1xBaJkzbkGeiChOE6bVM91TF7lTanRDLVaJv9NS0/2J7/hdfxJtxdRzkWSJ6asEgKRn4TdB3BNjC6yYb54tfvAXbJRuntGT7V7AUL7cP54MOOp/E2iuxSoYWjL6VGnuSo7juiFi8S7/xUPuUWrIopTLCbCE+rjQU693k/oFTwu+0poidsOZeemkXQwA7Uey1gpPooCWC0FwEDTTK91obx2FMWuBJXJddKTnrbOp6ItJwi7jZKldKQJi8kYiuETGUfeLlzup4mEPZUXb5C38HPy4JGnYKV5pu3DlnuOvNRL1gPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(31686004)(83380400001)(4326008)(41300700001)(38100700002)(316002)(8676002)(6666004)(53546011)(66476007)(6506007)(6512007)(36756003)(66946007)(6486002)(6916009)(66556008)(86362001)(2906002)(8936002)(31696002)(7416002)(5660300002)(478600001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9OV0swMDJVYXdoRGxkUTUrUXNzbDU2WXcya25NbGVTMmhpMTh3V1Rzb2p3?=
 =?utf-8?B?VEloY3FRWmRidVBmZWRWKzEyNWVpc205YVpLZW1JdEQ5NERqSmNVdld5WTdZ?=
 =?utf-8?B?cjBVbkc0TmY5dUFzakhKQ1FYUWpVVTI2Qk5YZWUrWDJBSk50QXZSYnR0ODBI?=
 =?utf-8?B?clVOYW9Yanlmbk8zTnZFMmRrbFdVaFh1R01uQVk5L1EwRzZuakp1WWp2QUlv?=
 =?utf-8?B?bnRBOFVZeTJ6eEF4YzRWaGV6aU9GT21BMmlpUnZiTEJ0N2hNNFdQUEZQUGRv?=
 =?utf-8?B?QnNDRzMweTc3VXFYK21mMWsvaFBWUU5BT0VzVy9TRDZ0NXpIV2dwQlI5TEZH?=
 =?utf-8?B?aFlFbzJBOC9QQVppMFc1NHdqNDNqOFlYV3NsN3kycWJhLy8rTE03QVJFd2RW?=
 =?utf-8?B?SlF2TXdpM3dnSmxITmJwVXp6YXorOG9PbmRtWGM4NGRHRWsvNGtUZXlxWFFk?=
 =?utf-8?B?L2dFQzVFOUhwRW9rRTl1aDVLYjhMaFdoMHJDempSbXZweTNybXh5RUsrU0No?=
 =?utf-8?B?Y3Q5MldXKzRoQWpuSTJWcU1xK3F5MXBqSy8xYzROSDBMTUl6ODNFcWtZTW9D?=
 =?utf-8?B?V0pEYnNSYm9OaVFmTlBhVko2cFVkaEFHWFFOb0dyTVFOT2ZXc2lkRUVYb2xq?=
 =?utf-8?B?dDNPTnVOZGl2RmM1SGNUZ0FEZ2dpa2c4TklQWEVVaFZnQXRadkwySlp1STQ5?=
 =?utf-8?B?QlZFZDBlT0hnWU96Q2RkQ1FFbzVnS1Frb2RXTXYzaXRiU0dLSDdmR2ZqZlE0?=
 =?utf-8?B?YXMrbjVqTHhTSCtsSFB3Z0g1cGtkL0lMMnNTWmU0bkhZTitBdkQxVVM5N2pH?=
 =?utf-8?B?Ry9YQUFiZmUzbXZDR01lN3FzV2pQZlJVMWxxWDQ2a2h2T1F1NUlsVlVaWVNy?=
 =?utf-8?B?ZUVYY01BRXFPQXY0b3VyTlhVb0RaNWl4VEdTeUJ0L0lIeDIwNXMxbWkvS3c1?=
 =?utf-8?B?ZHVzYi9jOG5pU2UyYkdTd1V1c2NkczhvQjdJOWQ4bDVNcy9taEZONTZhcXNV?=
 =?utf-8?B?Wk5wUFNjTXpneUl5MjFsekpXYmQ0Y1Z3T0dPTnEyRlNxTUNKMG9jVVVzS3o1?=
 =?utf-8?B?czJTbVhQcUZuSUdxU1NKQ1k1Y1A0RER6VC9lYjhjeEFFQ1gvb3ZEZDNiV3p6?=
 =?utf-8?B?bUgyZnNPcVdJOGlJcTZob24xWXQ4OHhqVzdyOVBuY1VmZjhCUEJCL0pPQVRI?=
 =?utf-8?B?cUQ0cERJMllxYWMxY3F3OXdFYzN3eUZTTDZ2TFZhb1krbTFVKzMzRWhEQWxF?=
 =?utf-8?B?cW1YM0VUaFQ1c2cza0hJQm5qazdTeDBkcE9IZ1VYMkd4c2FXcGVRTTNpb2dn?=
 =?utf-8?B?ZldTd2FBMXN4YVJPaEpMZm5yZFJ2dU5qTWo5cTgxNjZnRVQ4bkNjdkV2VlI4?=
 =?utf-8?B?aXhRejhJTUt2RUdETzRQT3pSSVRJODFubWpPbWI5RlZNTXd6QWUrR2VXSW9N?=
 =?utf-8?B?ZCtwMjVmMmNLYTM1QnU5dGc5VzlPZnV6MnNVNmZseGJ3NCsySVhDbWVSR0pt?=
 =?utf-8?B?SDhXWEtrbUwwUDRlellwbjJoeE9sand1M0FQMVZrdFNlRExXUTRlWmlKZXFi?=
 =?utf-8?B?bVRCcDJsM3pka1p3K1lvd0RoejQ4b2cvKzBaS0Z0TWdHa1NiVnBUK0JadWNM?=
 =?utf-8?B?Z0VReHVZaEE2bXpvRGx3NkdhM2o2NkdkM1YxY08xUFo2QzhtMm84K0QvNDJt?=
 =?utf-8?B?WFNiamhQUEt4SncrWXBtRjI5cEVzRzFpS3I1Y28yZSszSGRBTGlIcW42WVVW?=
 =?utf-8?B?RUt1dCtZeTR3anVhM25yTlF6NGIzMXloL01CMkRsb2xIeWgrYStzQ0NySlJT?=
 =?utf-8?B?Z1Nkc0NnRzlQbkQwcHRwcUg5MlE0MmRBWm5KL1FQMkpNYXdqTjFNZnNhUGJK?=
 =?utf-8?B?K29BcUw4allSdG9kU1dyeHdSV1htSEIvSmo3bVVza2g5SHpaSk0yRHh0NjMy?=
 =?utf-8?B?S25GQVZ5VGpEQnV3RVJQUzA2MVY4M3M5NEVOK2ZmUlk1RFdaaU1vd0hHYjJq?=
 =?utf-8?B?a0RBcXliRnJzSjdJZEpEcnA0YTBOejVySU9RYzBZQmE2dldVakpxREZjcXdh?=
 =?utf-8?B?bm5GYzlvQ2Z1aTE5UjY3S0p4VGNSekYvNjhldjI1ell0bldwRTdhaDJ5M3p2?=
 =?utf-8?B?N25WUFB0U3dUYXR2UFhtcUlpL0FEanN3Rmk0V0VmR1NJWjhWMlZwbG5Oek9E?=
 =?utf-8?Q?FX66S2nQ6AqbX69QzyCEn8sfLtp8i7mHRmxd9S4qzqDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd823a8c-c3b9-4dcf-df52-08db62a963cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:06:26.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9rGq1qIz30Hxtz9cUiJuq0bq4o8pydF8F4U+/V+8eEQkQGeyXInhSjC9khHlhkMQr5vxy7+YHfg0qMMwnR+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, thanks for reviewing.

On 6/1/23 08:49, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:22:11 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> The title is very vague.  Can it be more specific to what
> is in this patch?  The description makes it seem like a bunch of
> unconnected things, but in reality they all chain together
> to get the registers and disable the interrupt.
> 

How about I split this into 2 patches (along lines of register mapping
and root port interrupt disable) and title as:
cxl/pci: Map RCH downstream registers for AER protocol error logging
cxl/pci: Disable root port interrupts in RCH mode

>> The restricted CXL host (RCH) error handler will log protocol errors
>> using AER and RAS status registers. The AER and RAS registers need
>> to be virtually memory mapped before enabling interrupts. Update
>> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
>>
>> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
>> the RCH downstream port's mapped registers.
>>
>> The RCH contains root command AER registers that should not be
>> enabled.[1] Disable these to prevent root port interrupt generation.
> 
>>
>> [1] CXL3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> I just noticed this formatting of CXL3.0
> It's CXL 3.0 or CXL rev 3.0 in most existing references in the tree so
> good to keep to one of those instead of introducing another form
> 

Ok, I will change.

>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/port.c | 64 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/regs.c |  1 +
>>  drivers/cxl/cxl.h       | 11 +++++++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d147f08780d0..80c643254b86 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/slab.h>
>>  #include <linux/idr.h>
>> +#include <linux/aer.h>
>>  #include <cxlmem.h>
>>  #include <cxlpci.h>
>>  #include <cxl.h>
>> @@ -940,6 +941,63 @@ static void cxl_dport_unlink(void *data)
>>  	sysfs_remove_link(&port->dev.kobj, link_name);
>>  }
>>  
>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> +{
>> +	void __iomem *aer_base = dport->regs.dport_aer;
>> +	u32 aer_cmd_mask, aer_cmd;
>> +
>> +	if (!dport->rch || !aer_base)
>> +		return;
>> +
>> +	/*
>> +	 * Disable RCH root port command interrupts.
>> +	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> 
> Space after CXL?
> 
Ok.

Regards,
Terry

>> +	 *
>> +	 * This sequnce may not be necessary. CXL spec states disabling
>> +	 * the root cmd register's interrupts is required. But, PCI spec
>> +	 * shows these are disabled by default on reset.
>> +	 */
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>> +}
>> +
>> +static int cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> +{
>> +	struct cxl_rcrb_info *ri = &dport->rcrb;
>> +	resource_size_t aer_phys;
>> +	void __iomem *dport_aer;
>> +
>> +	if (!dport->rch || !ri->aer_cap)
>> +		return -ENODEV;
>> +
>> +	aer_phys = ri->aer_cap + ri->base;
>> +	dport_aer = devm_cxl_iomap_block(dport->dev, aer_phys,
>> +					 sizeof(struct aer_capability_regs));
>> +	if (!dport_aer)
>> +		return -ENOMEM;
>> +
>> +	dport->regs.dport_aer = dport_aer;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_dport_map_regs(struct cxl_dport *dport)
>> +{
>> +	struct cxl_register_map *map = &dport->comp_map;
>> +
>> +	if (!map->component_map.ras.valid)
>> +		dev_dbg(map->dev, "RAS registers not found\n");
>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(dport->dev, "Failed to map RAS capability.\n");
>> +
>> +	return cxl_dport_map_rch_aer(dport);
>> +}
>> +
>>  static struct cxl_dport *
>>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		     int port_id, resource_size_t component_reg_phys,
>> @@ -994,6 +1052,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc && rc != -ENODEV)
>>  		return ERR_PTR(rc);
>>  
>> +	rc = cxl_dport_map_regs(dport);
>> +	if (rc && rc != -ENODEV)
>> +		return ERR_PTR(rc);
>> +
>> +	cxl_disable_rch_root_ints(dport);
>> +
>>  	cond_cxl_root_lock(port);
>>  	rc = add_dport(port, dport);
>>  	cond_cxl_root_unlock(port);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 045abc11add8..b34f9e04cae4 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  
>>  	return ret_val;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>>  
>>  int cxl_map_component_regs(struct cxl_register_map *map,
>>  			   struct cxl_component_regs *regs,
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 6134644b51f8..0e0bcbefefaf 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -209,6 +209,13 @@ struct cxl_regs {
>>  	struct_group_tagged(cxl_device_regs, device_regs,
>>  		void __iomem *status, *mbox, *memdev;
>>  	);
>> +	/*
>> +	 * RCH downstream port specific RAS register
>> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
>> +	 */
>> +	struct_group_tagged(cxl_rch_regs, rch_regs,
>> +		void __iomem *dport_aer;
>> +	);
>>  };
>>  
>>  struct cxl_reg_map {
>> @@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>  			      struct cxl_component_reg_map *map);
>>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>  			   struct cxl_device_reg_map *map);
>> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>> +				   resource_size_t length);
>>  int cxl_map_component_regs(struct cxl_register_map *map,
>>  			   struct cxl_component_regs *regs,
>>  			   unsigned long map_mask);
>> @@ -603,6 +612,7 @@ struct cxl_rcrb_info {
>>   * @port_id: unique hardware identifier for dport in decoder target list
>>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>>   * @rcrb: Data about the Root Complex Register Block layout
>> + * @regs: Dport parsed register blocks
>>   */
>>  struct cxl_dport {
>>  	struct device *dev;
>> @@ -611,6 +621,7 @@ struct cxl_dport {
>>  	int port_id;
>>  	bool rch;
>>  	struct cxl_rcrb_info rcrb;
>> +	struct cxl_regs regs;
>>  };
>>  
>>  /**
> 
