Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1225E72CDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjFLSUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjFLSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:19:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3693;
        Mon, 12 Jun 2023 11:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYXzHKcIAHXUEy+fOnVasLXW8SJgYf+FRJGPg0UfLZKnX/tS+rfoiDs6N3lenMcm2SJB6w1+vTRee4O9WTxVRLvnEndrHVXi2DEMKRL1ZWYG32kPJNIEjMVQv+L3dhKbIPLQRaiVqDb7GFb6WSbVpRfHhLTa0Dclv3ZeTVxhymAT2ASve3I+ohqV4ruhixm+gpoCGpYOhlUODz2itga5cEfr1YaF14LY2gkNu9OiOAVpvcK0DrgtJFxOOvHikVdl3Ehs02WCgKSFbq9YEcFCPQStizx6ycHcavgqruLcSzPOfggvvYdgQFD42umKHmeBmke4MC8poqHSaIYv8nqixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io6BVASbVPhhueiRD+dpF1Nq5Xv8HHABCzBRwGi/8OE=;
 b=gO5gEAozl0XzJyUpfAZVZWDTkyeXWnMcjrpq4DReYfa8YX5H/A5SDlrzGonwCG4uJkd55Pyab4XOt4qtqJLeztdzSIhpyNUdVAppSKVO/CMjhGTkz/f1VVFYuSQWUlQDbOVPU1ko5O76ScPqiOOawfng5uCHkft98hwezwvJEdnMmA42/ZOMgu2UHX8y9bTnaQf+xaueokxySWou8C7D6RissjdojHEMT0ooxHT7rwTuhVoYYUKhtOAfiuRuYzMw6+qVJ3F9VT7o81wpPSBRjBT3xxHD4b4vhqXqt95rnblti/5Ljd9ECUF57eYAKyxcSjF7ifodeegD3EN2hfb6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io6BVASbVPhhueiRD+dpF1Nq5Xv8HHABCzBRwGi/8OE=;
 b=sxMi7FgCTH2atB74fPwaryswRhNvfn3a/YjbjY9y5KRzRrydhP4YaItj3L0aWp71S8vgN8yWeRSn2CvZ67/zOYLTjUGETGAfiC/ShIkbIOirDxxWyR0HjfI/L2Ld/jyUpTiDQ9pUCrxlOTXwvuQnWJ5MhgREt3phy4s3X1CFKtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 18:19:48 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 18:19:48 +0000
Message-ID: <95639b45-1166-de98-5fdf-5f8eeab2d123@amd.com>
Date:   Mon, 12 Jun 2023 13:19:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 22/26] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-23-terry.bowman@amd.com>
 <6483ecb5a4526_e067a29490@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6483ecb5a4526_e067a29490@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0112.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: a24cf293-0cc6-4e64-1766-08db6b719b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5DMaiz/wbVmaV1o/s8jaSoP0gv5uCNMVj9aX7M+25ZJNRXWjwJc3jjNdZ7kclgtj5ULmNdHj73LOh8b0CQhP6O4en0dVgOIQMfVdN8Ipziwv2fYc9vCZXfv3HyRcjCjgp+mC6pj3Fg2uVYE2ZfK4Z4/vcJ4ycsMcGpsb76D2Im00MYtIkFVGLNV32BYBUL5Evi3gYFLhobSJLicQOZfijVaE2cmJxwkBCxjhX35Z/rI9GrGGlD03pOTBtQhNdZ4KeAUSnK8481W6r1JyU0NBFIJlfayFJD6ViDxw3d7qfX5kzOPt34ETmDrNzM8nDbl81tNlGA14c4yaPY0edS7IMALgAXNWTBBsfXlLOkxbP8djpOi8r8lMEyQH7OLF8VU6JMduDGVDjizxYXCgj0zu22kXmRO+SWPfXBTuQj1XfarWGLxHLjQ++1EwakbUPqGWv0PXlvDX+lHjnF7A30CDw3cBV8QAjcX8Z/adl68azttajOIcsZg6YFLvcPRK0FaOkkuVgo0Qmqk52ij9LNE8pnOIXc/Y2U0Ok2soaoVvz9EMhC+Gc7D+oz+YE012SBMmh+DPsY4YGSaortTEr84zr++Cn9kI6hnHxy/xMZ//i2aAZQOtO9SpzLYEctheeUrg7xlhJ5a+m3X3s7C97nRJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(86362001)(31696002)(7416002)(6486002)(316002)(8676002)(41300700001)(83380400001)(5660300002)(26005)(6512007)(38100700002)(53546011)(6506007)(8936002)(66476007)(36756003)(66556008)(4326008)(66946007)(478600001)(186003)(31686004)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGQxZkZXQk8xMlQ2cHNuSXR0QktqUlNLdGpXZEFGTFk0R1F1Y2tERUxWbVly?=
 =?utf-8?B?Q043d052OVgvTVdqeklaMHp5bFowbFpySkNZNndrWllXNDJVTU9Fc2FsR2lw?=
 =?utf-8?B?d01ZTHhwWU5SZm5zL01IVWxQNUJNTWlscHl5WjkrYVpiT0NYN1QrMUM3NkZw?=
 =?utf-8?B?STRmWEQ0YWFMdXZmN2M5ZFBvUk9RUjlBRXdOK0RzS3dEcE80LzU2bzhzaGc5?=
 =?utf-8?B?ZnZRclFXdm9ndnBmeDFCRkJocnAvTGZxdlhnMzlnb0xpS1F5TyswenVNa0NE?=
 =?utf-8?B?dXN3Z2VZMXl2Q011R1dmalczVlZIeGd5OEdBUHVpVjUySFJCRitUWnF0NjRz?=
 =?utf-8?B?WHdmVStFMWpmMnJzdXhJbTVFV1FYWUVzOGlDNzJoYVY5S25UN2ZXV3dWaER3?=
 =?utf-8?B?YWh3dEtMRThISHlGZXpwQ21aTlpha1ZNcDdKR0I0SDh3RUhyaHIwYmc1MmZu?=
 =?utf-8?B?Qk5RNkNDYUUyRlZNZ3g3UHF5dlNBZ0lseEg5eVJWUEk3aGpFS3hpQStFMG5r?=
 =?utf-8?B?ODBmTDNsUDF3dzYxWUhSWmM3aUY5cDZXVFZiYWR0eDhlcmlUQ1N3bmFNQ1Q3?=
 =?utf-8?B?czZiNFdnMEh4eVpHcXVuUmk4aFdIZmNHWnNaZ21PZHA5OFpNRWQ0dWxUV25n?=
 =?utf-8?B?VGVSR21CMmY3bmo0Nm5PcDVPS1Noc3NJRlUwa0RhZXdHcWFzUDdKYjZLbkVa?=
 =?utf-8?B?b0NHOGgyYWZHSkVuOStuT2tPMzFidWxIeUtVUml0YkNrVXBGS200ZCtIVlRH?=
 =?utf-8?B?L3ZkOS9vOWlYdmtvV0lVSjBEUnhmWGFPV1J4ZzJPYU50cGFleVhTcTBsMjd2?=
 =?utf-8?B?Y3Q4YVRMOXVibk1EM0RQSXRISjAxWkN6U2J2SFVadFUvMmcvRmduQjFVNG9C?=
 =?utf-8?B?Y21VUjB5bm40aElGVEphMitidDg3NXBQK0VQZUoxN3g3OXM4Z2xWM3hJeURk?=
 =?utf-8?B?WUxmUTVPZHpuNFJhRTlqdFZNa1NCOUZBSWhmMVZJSnIyVTlXK1FpL01MQ0M4?=
 =?utf-8?B?NkZya3ZMSitsY1dwTW1qM3YwUUVrdkIzYmp3NGthU3Rid3FCS0JBVEswVWFJ?=
 =?utf-8?B?enF3WXd3TDBWYmNtYzNDVzlKQTNMR2RYMnlja2U5M3VwQ2h3dUFoQ09ZZ3hJ?=
 =?utf-8?B?VGswWjBXY1Q2ZEYzdkRRTVh1NHBVZXFyaWJEaU4zUkRzVUpsd3ZsY3psSEUy?=
 =?utf-8?B?L2c0MHE1enJjV1NXeUpzWHZiQkVwT3NXRE5ZRnREb1c3OTNGa3dobUI3Y3E3?=
 =?utf-8?B?VW1RamZMRExzcW5wRXByWFJwYVZzalJkVlVHRWZzYXN5azhzWGRBS3pCdDVM?=
 =?utf-8?B?RVg2WUFHWENKNWNTMmlLVjlheDRnZ3h5UXlCbW1PU3ppSzNNTllRWHBjbitu?=
 =?utf-8?B?T09HcStVclNrbDhiS2FxdjkyTFoyclRnamhHUXh5WnYwS2lyMHVFZTdsQmJE?=
 =?utf-8?B?TUp5dlB4NG13NE51aFFITFlIa0VWZENjOFBKckp5NmFxeGpldFNWMVdva01W?=
 =?utf-8?B?OVB2UWZIWHJJSmlFNHI1UjBmdE1EMjVkVTA4NWVVTmt4QjhKV252d2tUbjFy?=
 =?utf-8?B?REFzV2dHb05taHZrYWw2clV1dFN6UEhocG9tOVh2a1dHajVJUFZZRG10YU9S?=
 =?utf-8?B?UjJHNG9wdTM2b2pkVkJBeXJWaUtIeVIrNllqeXR3VE9wR2UzNVFuY3hYOC9x?=
 =?utf-8?B?c1cwUmFBSFV5RnVya2ZwbkhSSFlHTW1HcnhXRGRva2ZyKzlSUXBYRWRuU1Nq?=
 =?utf-8?B?OU13RkhYTUFjTVJpKzlKV1g4YWIxWWZpSzdOb2Z0RUxhMFdPN2VkY29abFZ4?=
 =?utf-8?B?c0d3cFBlSDRyM3ovQk5yVGZwV2UxcFdjSlFPbWV6WHA0dm1rVUpKMmlvWWRY?=
 =?utf-8?B?RitaSkRYU2lWZllxQThIY2g2bFUwUjZpUXZhS1hjam82bVNGUXp0alF1OHFs?=
 =?utf-8?B?bHZNM0YvTTNlMXN4MHNhSlZEc2FmbGs5SVFsME9hU24za0VtNS9QVVc5S1hO?=
 =?utf-8?B?bGtHOWhoaGQyek51YTBUemFreUZDSm1hOVpjSzZuVzhhYUZ4NlhYNlBtcnJN?=
 =?utf-8?B?OVViZGFpM1dIcEhlTzhGT1lFZXJSMHp0OHB2ZTNvWGhiZThzL0lBemhCVjVG?=
 =?utf-8?Q?07Oz2bqyV3t8zWHcwvm7l8ikI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24cf293-0cc6-4e64-1766-08db6b719b5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:19:48.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9VKTTq2jDRrKt4MF4Lo+jAzB+Dz+9XJwm90LuvwmuWG9ew+vq1f9reLPTs5gLmO83ZbVJgMfYLq2f7htA5mZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

I'll make the updates you recommended below.

Regards,
Terry

On 6/9/23 22:23, Dan Williams wrote:
> Terry Bowman wrote:
>> The restricted CXL host (RCH) error handler will log protocol errors
>> using AER and RAS status registers. The AER and RAS registers need
>> to be virtually memory mapped before enabling interrupts. Update
>> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
>>
>> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
>> the RCH downstream port's mapped registers.
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/regs.c |  1 +
>>  drivers/cxl/cxl.h       | 11 +++++++++++
>>  3 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 3111f754c740..bc5d0ee9da54 100644
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
>> @@ -947,6 +948,39 @@ static void cxl_dport_unlink(void *data)
>>  	sysfs_remove_link(&port->dev.kobj, link_name);
>>  }
>>  
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
> 
> @dport->dev is not suitable to be the @host argument to
> devm_cxl_iomap_block(). It needs to match the lifetime of the @dport
> allocation which means @host needs to be set to @port->dev.
> 
> 
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
>> @@ -1000,6 +1034,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc && rc != -ENODEV)
>>  		return ERR_PTR(rc);
>>  
>> +	rc = cxl_dport_map_regs(dport);
>> +	if (rc && rc != -ENODEV)
>> +		return ERR_PTR(rc);
> 
> I'll repeat the previous comment about replacing:
> 
> 	if (rc && rc != -ENODEV)
> 
> ...with an optional initialization at alloc time.
> 
>> +
>>  	cond_cxl_root_lock(port);
>>  	rc = add_dport(port, dport);
>>  	cond_cxl_root_unlock(port);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index dd6c3c898cff..26fb4f395365 100644
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
>> -- 
>> 2.34.1
>>
> 
> 
