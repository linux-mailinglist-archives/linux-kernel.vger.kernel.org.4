Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01237335DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbjFPQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbjFPQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:20:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2251295E;
        Fri, 16 Jun 2023 09:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbb61FyMC6cOBTk1JKoth4Hv0mWP6eF3x0xQDf80ys3Y/NMl8CV9Cvxmzlp6YF+j12SKfqT+nXWSTmWeLEKtrvmveD3LiK7tnBZ6ZqUk7+rSG6NF5xZKcdr17jJb77O4zDU6NfD7KDtumEJ6FBJQbhTAlZUyeJJvNFbOq1DvcBhZYZ0aObl5bpMnGZT2zqRBuduVuMKcaaQsgNtFoM4r2ufvndp52V6F9tkINima/4rHb7g95oMP7Gh27pKmnG3kRB2Y0GlpA21DKNv8KY1GuHSOJ6uLQCWH0op20yzAJRDoMzAec+g6zmiyLnPiA9wgFcpEBOMbjGy0Oc1P32kacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPmoRYfQZ+9yrck3C+bKsuB7gy5MnWs2PI7WjkWWC9A=;
 b=U8oJ6ewWtVlU+l1cUXTW5wTnZppP2U+/1OEftsEt9/hliA6+9Dnc3NCopD6nwU+jb8PYGQkMAf3W0U5F/RyIb1dc7jA1xIL4HFXrdvOdjjRpA15BAIWgl+VJfC7MrrSH/Fw0XNeo7dEcAJT/YUJT72kub1fKVMI5OBNJUdNhx1GotHxJ0Al0uQtFzvwRh/m5SVd6M51HUNfqRu+L63GLhYmWks3VaXk/rbXbE8qR9+ARtaVLCp2KSMdKcOUw8MZzf+jj9zk9T0x0O8dMDiwCcLRDaAHj5hzoiFsWL5fFPHSzhQsuHHXe+KasBoUY3MoQ0DMoxarHvU7dridQF1XMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPmoRYfQZ+9yrck3C+bKsuB7gy5MnWs2PI7WjkWWC9A=;
 b=G44XWC1jUDmszTtoXjhFUA7RwsL4eX4ut10xIs9OuolwQf5wMCDfhhuda4uOp0keDKUAOQnJWLpZMaYaHD35kV2RwlOXmVU/8suwax0XSgMqFzNgoHTO96R3C7Fn5oP4YY6rZNnHzxqHzx6+UTTfB0WO859+YmMfTVWLFi5P8XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 16 Jun 2023 16:17:25 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 16:17:25 +0000
Message-ID: <6d229237-58f3-655c-5e7b-912cdc64ec94@amd.com>
Date:   Fri, 16 Jun 2023 11:17:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/26] cxl/pci: Add RCH downstream port error logging
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-25-terry.bowman@amd.com>
 <648790561f7ea_1433ac294ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <648790561f7ea_1433ac294ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a0abf4-2847-4512-1389-08db6e852bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8DaXK+53m1gf8eH/hsS2DHNqdvjf7jcVaSfqJCKvAo8O6zSwiKvbA4eP8Fure0Z6o1zlnlNwNZX4FRcIVwbLqICcIBWNOP0cw1WRa2EjS79o18ECwB/BydchzBm/ND0rMpe5L3+0TlNChKO7sFG7EpNN4BwX/KIeVPFZYW5jIyz8NbOYFHsttwIOQ0Pwz0wCoXK8KdZLK/DJxl9xyJg3sLhHJ4RemRxN3goCczCTMILgvORG+jmGJ7Nn9rnPBddvcqHW77h4tJibhV0BNbvu91pYNAE/Shaqbqr/CrjaF7BxIA0dlqMTRVAXOfVyK+EcEpVWoeCki35BDjXzbsO5YU/Ghln2q01UBUMXSAvQcvYiCApO6etpASty71N+BIVfDK1nWv5I0f5wT9RFQrcqbN2AZnNZl9wwhWyu7TSLz1yHgJ8wRCroyoPw094Ymgj09wO3GGqTYyvpILJmowjI6SOjorBk+riugtRLPptH29akix0S7nUJYaW+lj+YdwhoZ8LxdJM1PYbqPDN0cLCXp20u9TlrBASCa6bHr/lfrkhiWrESVAB/CwmjiN26iyREfjhHBM9IFmR4zq7vQ4LvSrFp2rVGRGQGd9OW11zJSuDjGeEwZ3sHawSEqMQv4jFX1eFU/BJAXGcdp1lFiuSLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(86362001)(31696002)(2906002)(36756003)(7416002)(31686004)(4326008)(66946007)(41300700001)(83380400001)(6506007)(53546011)(6666004)(186003)(6486002)(26005)(6512007)(478600001)(38100700002)(66476007)(316002)(66556008)(5660300002)(2616005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhCS3hOWG5XS2Nqc0svVlRtNktJcnd3bGNYRjN4SVdDWSs2aXJzaVpiV0k3?=
 =?utf-8?B?YjkzbTVvQWZzWVdlbitGdStyTDNpcmRzY05GeEtuUGM0bDZLMW1NK1llNk5Q?=
 =?utf-8?B?RExlRTN4RDRnblNGTmxDRGhpalFYK0RodXoweVp2N3Nkcy9sRml6clE5dGFt?=
 =?utf-8?B?MGRZUUdhOXN3RThxeUpWSU1GUS96TXFXbVREZW5YTWd4RFlUNno3eXdqTEZB?=
 =?utf-8?B?OG1TZFJsNnZ5dklrU3hRK1lpaGM0VDJGbHk5R1JWWDc1dGJjNEpUNGNIWnJG?=
 =?utf-8?B?OHNIZzRyTzlXZWRFSUpCRWp5dlBxaEV1Y29RUldBaFlwVmRwY1I0MlNlUU1R?=
 =?utf-8?B?R1JZSVhHYmpWTmtmNENYWEIyblN2aU4xeGtYVXRpZ0NLQ0JlZDBPNjVEdjBN?=
 =?utf-8?B?LzhySE1RcnJaVmhrUkZrbGJyYTFtRUJKRVZoRjdubTV6UWdMUXEyV2VlRFBz?=
 =?utf-8?B?Nit4a05kTmo1VFliYnZocUNYYnlDaWRMaGZxN0FiS3pyQ0R6S2NFVy8rSlov?=
 =?utf-8?B?ZDdkTGRUV3hweHd6bU9CQ09tV1pVWHlocHZ5RW5tUVNoWW01NmJVWDhlNmFz?=
 =?utf-8?B?dVhuajJKeUxuQitCSHNldy9VcHB5ek85S0R0djN1MjVhaHVqVjVIOFh3MHpm?=
 =?utf-8?B?d2w0SmowR1RSeHZNTkgxREsvVEFUMjVxcUE1VFZWditHZnpGajFlRUxDNWdY?=
 =?utf-8?B?ejZKQjJ3TFQrTkRwYUlyMUJHQU5oWDR5WVhIbGZGRFVock5NQ21zcDU1MU54?=
 =?utf-8?B?OG9LRWx1VDkxOFg3YjEvOFdlRlRQQU5EZCtWSnA1K2JOMlVCbHBTWWNVamho?=
 =?utf-8?B?OVltYUREY2NIQVRmWllnMEpGNmhkVXNrVXhDRUdWOE56aUc0NnVOS2Y4ZDVL?=
 =?utf-8?B?OXN6cHVHUDUzdW5nNDZMdDg1RkpIMzdKU3UwejAyRTh3bm9rV1BJUzBtb1Nm?=
 =?utf-8?B?QVAxcUFoRFpPSHVTRmc1NzBXWWxIekl4NVptb2FHbXdxdUw0MEFGVTJoRjhH?=
 =?utf-8?B?RStybG43RTZIWUtuRUYyS0pKcHZHMjZncUcwTXdUVk9Va01zQjlXMGFhSzkr?=
 =?utf-8?B?dm9jUGc4ZmJoNTVVOU54Nk9HWndvRG9CL3hsUmFIRVdCanpROWgxQW8vd0xn?=
 =?utf-8?B?b2JFZUlvZWc1WWlsb2I3THJPdXhJOEZzN0lNUUdLeWFKd29wNGI2Tk9LTkxU?=
 =?utf-8?B?YXNraTVXczBQM0NnQkhNMmFiSjNwOUlxbnRjOGVER3AzamIxclFsL2lyVFF3?=
 =?utf-8?B?NHdtSm5EcUJXRU1RbUtpS2FVdTk5V2FUeGRDSlhqVlRkb0liVXFubUNtUmor?=
 =?utf-8?B?b2puYm53V2NYRkVPV3ZzZmg1TG9wa1BQajd6dngxOWd5dlRWS2ZHZUppcisy?=
 =?utf-8?B?ZHJ4ZWJ6RlZHS3VuOTZHUXZiRVE3WjllckNiWmJoVFV6MmxRRytBQWRCSVM4?=
 =?utf-8?B?WXp0VEhyN05hcFBrZjNGWjlIK2Q5emNxSUV0Q3RNZGhtdXVuYldNTDdyZTBZ?=
 =?utf-8?B?bGNaQjB1MlBSdUl0SXprb1d5ZW5zRUNHNTE3ZUtXektLY1dXRlE4TlZHYkpY?=
 =?utf-8?B?ZnlQN1Z3QmlpVUROSFJRdElhcmlaelJnZ2l6YmNqNU1TQ05DeGc1RzJZbWVD?=
 =?utf-8?B?Q2VmL0pRSlJtWkJ0eTNieGFOUEc2ZFF1c3BEOG5YRmVyZDRrTDNZVHlZcVlD?=
 =?utf-8?B?Y1ZOejBPWlU3SkM2V1JBV3JzTitOdDE4SktCdFRYMXNMZkc0bUMvbm5pRmR2?=
 =?utf-8?B?a015c0UyaVh3K2pIcS9USXRoMUV6L0lrcDFzNFVvMDRHNTRwbEkvT2pMaTBo?=
 =?utf-8?B?bzdYOVN3N2I3QVFtN2Q1RXRNNXlMSDNEUHYzVlVPTkZZSEhzQ0F1TnFRUlFP?=
 =?utf-8?B?RDJ2czB5elpaOVV0Q1QwZVpWNVp2bDh4YVRxQ0RSRFpLT0RSbVdlelFWU1dD?=
 =?utf-8?B?MXE2WVBGS20zUHgzczFZaHFDVUFTLzV2YVR1NVJRSzVBNTAzS1B4KzhwWlJF?=
 =?utf-8?B?am1ualhxRy9mSnpwczNwSE1BN0QzbVFWdUFreEVoMGZ0ck5WWTRweCtxdlVF?=
 =?utf-8?B?TmdGQ0N6OU9Ib3l0b3p5QnRnVkI4SDBZUUp6SllrSUJVZUpkV2k1dzJaUHNW?=
 =?utf-8?Q?rkUi2QnqqxsEa8NqfVqpxQfqv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a0abf4-2847-4512-1389-08db6e852bcf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:17:24.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sno/f171OmgSc6nrT9dNi6Z//WvnyEGrLURld+uFsRQq2QiORbnKwIrRMxq8Y8G+Xy9LTGX45Gt2NajG9Peakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I added responses below.

On 6/12/23 16:38, Dan Williams wrote:
> Terry Bowman wrote:
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
>> Update existing RCiEP correctable and uncorrectable handlers to also call
>> the RCH handler. The RCH handler will read the RCH AER registers, check for
>> error severity, and if an error exists will log using an existing kernel
>> AER trace routine. The RCH handler will also log downstream port RAS errors
>> if they exist.
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/cxl/core/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index def6ee5ab4f5..97886aacc64a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>> +#include <linux/aer.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>> @@ -747,10 +748,105 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>  	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
>>  }
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
> 
> A general reaction to the "ifdef in a .c file" style recommendation.
> Maybe this section could move to a drivers/cxl/core/aer.c file, and be
> optionally compiled by config in the Makefile? I.e. similar to:
> 
> cxl_core-$(CONFIG_TRACING) += trace.o
> cxl_core-$(CONFIG_CXL_REGION) += region.o
> 
> ...it is borderline just big enough, but I'll leave it up to you.
> 


I'll take a look at this. We have most of the patchset requests implplemented
and will give me time to look at this.

>> +
>> +static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds,
>> +					  struct cxl_dport *dport)
>> +{
>> +	return __cxl_log_correctable_ras(cxlds, dport->regs.ras);
>> +}
>> +
>> +static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds,
>> +				       struct cxl_dport *dport)
>> +{
>> +	return __cxl_report_and_clear(cxlds, dport->regs.ras);
>> +}
>> +
>> +/*
>> + * Copy the AER capability registers using 32 bit read accesses.
>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> + * status after copying.
>> + *
>> + * @aer_base: base address of AER capability block in RCRB
>> + * @aer_regs: destination for copying AER capability
>> + */
>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> +				 struct aer_capability_regs *aer_regs)
>> +{
>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>> +	int n;
>> +
>> +	if (!aer_base)
>> +		return false;
>> +
>> +	/* Use readl() to guarantee 32-bit accesses */
>> +	for (n = 0; n < read_cnt; n++)
>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> +
>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> +
>> +	return true;
>> +}
>> +
>> +/* Get AER severity. Return false if there is no error. */
>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> +				     int *severity)
>> +{
>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> +			*severity = AER_FATAL;
>> +		else
>> +			*severity = AER_NONFATAL;
>> +		return true;
>> +	}
>> +
>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> +		*severity = AER_CORRECTABLE;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct aer_capability_regs aer_regs;
>> +	struct cxl_dport *dport;
>> +	int severity;
>> +
>> +	if (!cxlds->rcd)
>> +		return;
> 
> Small quibble, but I think this check belongs in the caller.
> 

Ok.

>> +
>> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
>> +		return;
> 
> The reference for the @port return from cxl_pci_find_port() is leaked
> here.
> 
> How can dport->rch be false while cxlds->rcd is true? Is that check
> required?
> 

I will remove the rch check.

>> +
>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>> +		return;
>> +
>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> +		return;
>> +
>> +	pci_print_aer(pdev, severity, &aer_regs);
>> +
>> +	if (severity == AER_CORRECTABLE)
>> +		cxl_log_correctable_ras_dport(cxlds, dport);
>> +	else
>> +		cxl_report_and_clear_dport(cxlds, dport);
> 
> This is the code that made me go back and have heartburn about the
> naming choices. I.e. would a casual reader assume that correctable
> errors are not cleared, and that reporting is different than logging?
>

Yes, the names are ready for reworking. I have updated the functions to use 
consistent naming in the v6 patchset.
 
>> +}
>> +
>> +#else
>> +static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds) { }
>> +#endif
>> +
>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>  
>> +	cxl_handle_rch_dport_errors(cxlds);
>> +
>>  	cxl_log_correctable_ras_endpoint(cxlds);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
>> @@ -763,6 +859,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  	struct device *dev = &cxlmd->dev;
>>  	bool ue;
>>  
>> +	cxl_handle_rch_dport_errors(cxlds);
> 
> Per above comment on "cxlds->rcd" conditional, it is mildly surprising
> that even the VH path calls this helper.

The 'if (cxlds->rcd)' will be moved here per your above request. Strictly speaking, 
this is still in the VH path but an improvement. This is really an endpoint path 
for RCH(RCD) and VH endpoints.

An alternative solution we considered was using a separate RCH dport error handler but 
that requires further AER port driver plumbing rework (for only CXL) or changing 
the assigned error handlers depending on RCH-VH mode at runtime. I spent time 
implementing and testing these options and we found it added significant complexity 
for a limited use case.

Regards,
Terry

