Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86E6C7E81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCXNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:12:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFC95;
        Fri, 24 Mar 2023 06:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2cOnPV+HaKVahRZDCo9mzRBVK+PRF7uktzqSsuS+cm40B+IuW5sLNhyKI8fy6JSsEB/BcyibNqOcXb4sSdTlI2KAISs9O4rXpfb9kb2d7NKH/7a20B2KgSCXfjBINRO9TJ3OAoBKdTql8sfJE65DV7PRLfpD0C7LCTeoeD+fLQOZuA5/+Nnq1afzO/SUs1V4MLjtqzo5BrIo/fXnpJmzY2nfZyNl3iznKCz+MXRkmxUqOIwMLzyb7TiNpAJ5mCdblJfd2LyQXJD+W0n+7jqY2AuHz4N5D996G02DDLC0Tj/TT0Eis/rsXF0Tooxb2pnj39XYCM/YhyGOL+4NF7piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1yIuICGNQiRIr4VlWoz5kt4GEDfTPMGKrv42GQIETo=;
 b=B4DLmlxKxBEVLnVTRESFZpTNpuAWGNFrdpdiMB8ZvSAcV8iJQCm8O/3Mcauu4SHVLitgRgRxcjA8tUtY1OQk0gw2x1ioOyOVXLxJx4ciywJ9sgOD0Hm3+7oWd0wY+o5gLFZU3v/iMm5y+jFNufQQLq1WiwAr92c3+Nmrl411D+oBSg6TcXm0OrobIoQbb9M0OKj1I+W/7I17p8Bo5tgVUg2JsYVXU0Yex4fIQDt6dFaY8yDABpLu2rEY08OBJL0oS9r8pBTRkgncrc02AyaL6zaUX1R9rAYjKyHMUwZG6TCvcJFWYFKRZX/a9cAwLCBnj75MeLuGfihL5ElhjTI38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1yIuICGNQiRIr4VlWoz5kt4GEDfTPMGKrv42GQIETo=;
 b=SFr9S3lwO/2ANtxCuxH+sFnJqY1XuxyxnZ08EzDBSNVlOCTiV4dqa24YFW+o5Xc/W5lbD9v2Q18rZlEsUhgDKyC99+uRXWKxlbzAYY7uF0vHcu1ZdePQR8tOBupOdxT/9JZA8pLyHdeL6eVwcifN3cCQiFqdmIJqA59vRYn41fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:12:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:12:05 +0000
Message-ID: <8e593a61-8a0e-8e13-603b-ced514b7533e@amd.com>
Date:   Fri, 24 Mar 2023 08:12:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/5] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
To:     kernel test robot <lkp@intel.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
        rrichter@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
References: <20230323213808.398039-2-terry.bowman@amd.com>
 <202303241632.HTxJ0yfj-lkp@intel.com>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <202303241632.HTxJ0yfj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0349.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8abc6-af06-43c8-47f1-08db2c695d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUxYf/KXVOBdcJ5s6/fkyrXr60NbPJuRVOdb5+MK2e8v/XxJQO0JFpqXeqbU6Rmkbo68UonaPo0QqrPmJ4i9vhL+qOnYud7xWrstBnJkkiSMFSgzAxAICp3K/lBecj0R9/z02/RkNccqd6AiD0tHKOI1H8hS79AUGqKNPo5SATXS4IB4M6FlWzN8LV65qsVqRWpEMroX2w41LFZrcGMNv4DNUJ+4lRkgakhGoAU/cqmbrbLwNNUfNos9rub6ji2A7Y3w8rnrAc61tnc8Y8OoQrUAccUvtFsBrsZhgNgeZLJmvnAUaB7AUUuNoqGenC0LBtQAKjr01vkhLPE79Dk6rr2vqVQmAnIPmfDOfLM23uC8+BHF7OOe5ftTXxwHczkfzQjk3gtiZsfxWAmj2kC3fL8EfuPHcx+ltIgb6ZLmtRd7iwvmLmA1dBC0hqu5DF7Y2sb9eRCFTEJ3GZqJBY1tgZ81SmyttDT4zh8+P30DmI4i2G3fvVlraQasKxQu+dGLbrWnNIfUqX5dUxiN5tcnlmZ8KFNxrrtxLxvpobwXm2mGtXkDQ6pR0pa5h1aN2tHKBwuYZSga4aNLoCcpRnWgS5EDyVQ1YEintlKOkOl5eS8TCnCR3QxPnlCdPp9vY5tKbtPNwklPYbZgO6sb780d+jwyjav5Vd+FTNTlotn1VzT+IF0AwozzsEbmDJY7tuVo3t7ZGJN61Qcu5q2lapIidmcK/764z7WHWff5S/4jY4M0qu/1WwGjWzaTgEnmurX1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199018)(6506007)(6512007)(53546011)(186003)(6666004)(36756003)(921005)(31696002)(86362001)(38100700002)(2616005)(83380400001)(5660300002)(8676002)(7416002)(8936002)(66946007)(4326008)(66556008)(66476007)(4744005)(6636002)(41300700001)(31686004)(316002)(478600001)(2906002)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdaeXNjaVlYNUtJKzBRVWNBeEx6T2IxSkhralRPZ29JNVNqbENxVXRzSVpG?=
 =?utf-8?B?N1pKM0Z5WUphejdPeUJMZmMwQ0ZFS0Rta0dscVo1aDZucDJVOFZVRXBIaUVu?=
 =?utf-8?B?VnFyRjFVdldsU1NTZHlBUVFRWityZnVML0NiY09VYVdDcjA0bU45aysyZFBw?=
 =?utf-8?B?a0FUSVhvYjNtbjNtUDJoVm5TVlR0VW1PK0hTMHNBTDBBYkFPMDNaWlljekVa?=
 =?utf-8?B?TG9UVi9ZYkwzM2diUkpPVnBVZVorS09XeG5PQUd2djcwcU5qWnNMYWJLa2wx?=
 =?utf-8?B?bWRqdmF1cklyMEFBOWZHdTNFUFcrSFkzRnByQ0lGc0hycmx1elMyUklPZHRk?=
 =?utf-8?B?SXBtTGZlV1k2ME40MXRxOHNhbW5MbzRlOFozOTBaQ2hWeG9Tdmw5K0E2L2lu?=
 =?utf-8?B?QnJYMjFNTEZTaEZrMTlGRytKUXNZdlZ2SXAzeFB6cU8rUThHcUprdlo1Qkdl?=
 =?utf-8?B?NnpXNG8zNjhMdExaaWcwbnZObGIyblhXN0JmTGJ6QU1Hc3h4dmxTZ1NOYmlp?=
 =?utf-8?B?alRzOFZuNU9PcC83NmhLWmUxUUZjdDE4cHI5bldUUnFqU2tmYjNuY21ZSWlL?=
 =?utf-8?B?ZDRjM2tYZVpvNDRYcFZrNDVqVFdtSGxWbFJHVHhydnVqa2ZGQzU3bFdFS2Ev?=
 =?utf-8?B?ZXdXb0hRSlNMeFgrWFkvdkk0RUY4OEs1R3k0RFkrZW9PNWU3SDJiNzBDS0dR?=
 =?utf-8?B?YXJUZXU0Ly93b0duV3lIbVU4Ni85WVkxeVZXZ1JmMUE2STFtZUt3RU9CTjdw?=
 =?utf-8?B?NHhsV00rR2tCTk4yQ01vT0hlbXlRYVRib1RtcCt4RGxxZFFNSjNka2VuMmZa?=
 =?utf-8?B?M0duQU5mcWZoTWFnR3JiWWpQYXdadE5oOFpMSGFIMnhsZGxpMWdMUXVtKzlm?=
 =?utf-8?B?V3ZrTFdHRWtobjEwZWlyOFVvejhuRUdBNlRlTmZ4Mi9zT0JhUHpJajR3bUo0?=
 =?utf-8?B?QVRIZDhyR0ZNOXNpdTc3ZWJqT1BnWjVUK1JHTHpHYmFnb2F2U0Y5cmtoTEpF?=
 =?utf-8?B?Zzg2WERkakpDOWp2Tk1Ta0JiTURQWmRDanNmVE5IT2FpYW9RL0ZzSDY1WFd1?=
 =?utf-8?B?cUN3QVNNWmlnZDZFVVhKUERkUzFjZVdDS1FYTzlsdmhUMEFWQTBLY2N1KzIy?=
 =?utf-8?B?SGs0b3A1VitHMlh4SG9HMmx1M0sxS0xHYTM2dzQ1azkwaTRBSEs2cWt2WUo2?=
 =?utf-8?B?Vlk2RVlGZE5FVWYzTWF4VEdSR0w0QzdUVVpoaXBHTVVxTmtjQXdxQWU3Rk5z?=
 =?utf-8?B?Qm83QU5QTEUrUDIvU3pHNXFiQzQyaTl3MURSelAzVkNPakdZVDB2RTAzc0JK?=
 =?utf-8?B?QzQ2VzVPcHlJbXZ3dXJudWhWM0VvQlV4NU9JSzlzVzBVQ3lHMHZ5ZUdyRTN4?=
 =?utf-8?B?c0RIQUhGbStwOEJUNmNpays4N0VJeWh2N1RXRW1Fdi9LNlVoY1ZzTEdaRFFG?=
 =?utf-8?B?MnVNN0JsTUFMNENiZVFtSEcxeiszcEFxMlFmR3RRRHBGVHVWVGsrWDhPdkV3?=
 =?utf-8?B?KzMxL05STUM2aGhWeUNKZ0p4NmVBd1gwbTVqeGxyTFQ4NndiVWNNaDk2czRT?=
 =?utf-8?B?NzlHaUlZd05FNTFjSkdxRkNTK2xhdE1EeFdndzhWUHEyNzBKUWg0dkZUWmwr?=
 =?utf-8?B?cyt4S1R6dmhZZU15bFVSYTFQQ0lXUm9uZVpPOXE2NWZ6ckJNU2hMWTJockly?=
 =?utf-8?B?S2owNC9ERUdrYXZVaTFBdUl3eEtiVGxSa3dvUDI2V2ZUV2tmdDhTQWtYMWNm?=
 =?utf-8?B?dk80eUtPa25XNHNXWU92RXZXeEFHd3lMNnd6T0ZiSTF0WWh1aTBaL0VnRlZk?=
 =?utf-8?B?bDZiaDdoZXBKeHh1c0RGb0hIb0YySm5nMTRiNHkxVkZybEFFaWdXNW1MOVNp?=
 =?utf-8?B?eGdkR3ZINlVzdGdmY1VUY01Lc0I1cmZJTG14R3NXc29BbVFGVlZIczVYTTc4?=
 =?utf-8?B?K25XMURadUZHd2J1cDUxUkVrK3BjcFJ5TjV0cDg4S2hQWGtMdzZmZVc5T1Zv?=
 =?utf-8?B?VkhWdzl0RDVrZTQwTGFkeEFMTCs0azFGMk5VZkxkWDl5RC96VjdZQVJZQ1ZM?=
 =?utf-8?B?K2I2bWtaZmlJMklqc1pZWmM2YjFVbkRiblpoQnBxSElzVVdBNmN5djU4RURD?=
 =?utf-8?B?bjRVWUxsVmJOZkpIY0RiSnJqZktUUTF4QUQ3cDFGMG5QYlhPNjF1TXJjTU1z?=
 =?utf-8?Q?VrkCVhjPjG2VJz+krNZHdKEAw+jrfnQW2961XstkeAvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8abc6-af06-43c8-47f1-08db2c695d7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:12:05.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRJZArAfIy2Du0EXAHXxEui8pLA4I43bvfeNoETiHK9ToxV+Gg4NcrlZl4gHip/0A7uDJGDL4YDLlHrGPRjeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/23 03:53, kernel test robot wrote:

> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303241632.HTxJ0yfj-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/cxl/core/regs.c:340:24: sparse: sparse: Using plain integer as NULL pointer
>    drivers/cxl/core/regs.c:345:24: sparse: sparse: Using plain integer as NULL pointer
> 
> vim +340 drivers/cxl/core/regs.c
> 
>    338	
>    339		if (!request_mem_region(map->resource, map->max_size, name))
>  > 340			return 0;
>    341	
>    342		map->base = ioremap(map->resource, map->max_size);
>    343		if (!map->base) {
>    344			release_mem_region(map->resource, map->max_size);
>    345			return 0;
>    346		}
>    347	
>    348		return map->base;
>    349	}
>    350	
> 

Yes, I will change the 0 return value to use NULL instead.

Regards,
Terry
