Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10429728A69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjFHVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFHVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:50:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89D30CB;
        Thu,  8 Jun 2023 14:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLGqfWgYn6U0hrXzEq4Km4HyidFPrg4qyccIbvE2mywz544WxZ/ptqFqFuakYP62+0/Mb+Ncy0lKR8rXCfn5bstnJJfIAklDoVnRipM6IwGcgy/FWpmrYdrmVfUigxPSu7wUWnZMYHNB68hFcbFI/qGdtYkQZ7oqeiTY2C69vFo5/Xh+a1c+e1Gq2vdfEMndpb6ok304OGpPWgWJhCPmVad1/pD2pjKhTjnbQN46/hvG5ku2cDGo7Fd9a2SKNHuR0tnA87bsiyc4XHI/spu1Ij66ssj3GSWkDuHXjzKwLz1M2myo/FyvxppxaCyRdLG7Av0NRUjd/FeZL24NKm15hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD19xqZiVEkl2pxWrP2+n7g5KL9GpTy48klg5Hj8Deg=;
 b=dyidnCxhdFZ8y18XZiWDiqHvEl2jxk2PEP//GptDwZx1v2uZUhUaln5poN37Tp0446jYjpZsZQ0vKOmDKXn9k2CqeykyBSfnj8YUwVgfeKo+BJemmrq7p2Ab1622xBIrsNY27siEmzYf9sRZNLVP7OCgw/UzsqCb5YhItBnNCmE6dw1wKTuyhiMX4aP3qEzy1TCJy6p344SEQAL1kaUxedi1YOustnX06z6q6Xs1cxnU/p/vUnXLGJglxoIo2vDpOMMKCW51b5Z16PuecTXJfCAGzZ57WBTqzJIUv/qvwFJMxB9StX29WCHgpF1rFksLD1q8JtAwzQnfDu0UiQv7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD19xqZiVEkl2pxWrP2+n7g5KL9GpTy48klg5Hj8Deg=;
 b=p2v8e0cHTcpPQR8cxBAQuq7GTjKQW8pE21yd0w4ueXCa2Y+DkMHLhT+Fva3eGBAdSoaHMh0D8v+N2hl+PRnQf/wMeqL4dejfTH6oodbMYZOLhfB2MyCjv5ZiOnhZTnT/mjB9RR5uuctbdzgEV5iKrzi649AU6mM0T9StNKDAjNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 21:50:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 21:50:46 +0000
Message-ID: <440970b7-2220-97de-e0ea-ab639024db98@amd.com>
Date:   Thu, 8 Jun 2023 16:50:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 07/26] cxl/acpi: Moving add_host_bridge_uport() around
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-8-terry.bowman@amd.com>
 <648233e5ea44e_1433ac29493@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <648233e5ea44e_1433ac29493@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0965.namprd03.prod.outlook.com
 (2603:10b6:408:109::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: a634119c-1e23-4c6c-b3a7-08db686a6a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZsSJV9PFDEMl+DrH2+wMUwvfmd0LjXlT4ItG+bF09w54B1cb4/3TCQk3XMYsw43jX1ll5qP/6ry9mirFDGeykOWkujIiiNlxqFe9Do8uuD6BD8JNvdTYDlpLUbKWL7TA77YZkWjdgZOIc4b5OszPXBhUd1rdkxHaiKW1Su1t38NdbQ48zjgoxSt4wPKKF8WgAggcmH7XbGzcsO+sJOw4X8OV7bCwyOGcl//KNT1Y/a9Q4m4+312zXVjWXZR4spTVy9kuF5E8hH2N4ZAYkNhHDCFcB7SVN+aP0mF6avYA9rV8AOt7tqDO2j2qzg1Bc3B8DxVUTrNaIWP7+ayi+nE2bPeCRMqAbuEoZFeyM8hmV77qFIBDmMFMGMcOs3XViX8iNJltKcdtIotQWl3wI5zj7k0oeSJVBD7XjeM6wxDdX1nLWQehoE4Dog5gLMEM4izGQbeuMSNBjM4yTAESxHXTAQrCgsfw0Sptb/FU8gBXkAZoAfE4oo5CyS7x7V1YaxObd1nLWt7NbP0PsWO8aFg1+DrNIpILhmGyD3KiKfCKg6sEaz8LJpKuW/B5iZuHV8F5FNs3cgs++dPrf+DAuJcrgfqo4VlIu/ezxtAuPvwsWA4+4K1hvhiPsdW9skRfWRiytNNKu11JWSek0Onht7l+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(31686004)(6512007)(186003)(41300700001)(5660300002)(6506007)(53546011)(36756003)(7416002)(4326008)(66476007)(66556008)(6666004)(66946007)(83380400001)(8936002)(8676002)(2616005)(478600001)(2906002)(86362001)(4744005)(31696002)(6486002)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZ3UDFKYVhlVktPM3Q2WnRGaHNNM0dCM1hUdG1rQks5Z01IQThBMDZFUFh0?=
 =?utf-8?B?UlNIR05VbUR1QzhYYTVKZzNNaWxkYjdzSTJ2cGlkY29DUTRPNTZHMm9HR3Zl?=
 =?utf-8?B?cStxN3REVmZ0M2xkUCtER3Vpb3RaWnlLWGF1TlZxTnJTTkFONGNqaVFVeVZu?=
 =?utf-8?B?cTJ3Y2N0bDFqSGJEbzJic0pWM3E1dEFFYmd5V2hpYXFBaUg4UkN1eFF5c1Fp?=
 =?utf-8?B?d1lSUis3WjY1ZVFpeUdGN2JyemxHTTdkKzVBV1JsdWY1V3RxMVVYSURiYSt6?=
 =?utf-8?B?TzgzT1c2QmdMR1lOVzFQMW9ycWJ6WEhlU1FiZEsyZFpSL0hOd0QwUU1oQWVi?=
 =?utf-8?B?a1lieHJOcU5ra3RTWnE1M1djdVRmMCt5bEd0bVUyaGxzN0tTQkRmdDRKSWdM?=
 =?utf-8?B?KzZrdzY4Zm0vSzFxQ2U0MnV1d3Roa3QrYktOdHlPTktHMDFLZWROUTU3V29W?=
 =?utf-8?B?d0hJRmVGOXdQVGszL3hRaEhZUVlsSXVuZUtKWk95ZFo0Zi9FYlBNTlBlc2hR?=
 =?utf-8?B?K2VWQ1V6bC9rbGJLcEo5TjQ3VDFPZ0ZuSzdSV3gvK0VkelI0VTFTemdrVHNj?=
 =?utf-8?B?b09abWRNc3NDMWtycE8vSVluN2VVZm54c3dsT21YYVJzeC93SHZGNWFEQTda?=
 =?utf-8?B?dS9qNGxucVhTVEJ3Rng1Z3oydklxM3ZYdVBTRXFvbm1SZHJ4LzR3M3R3b1J1?=
 =?utf-8?B?T21jRDA5Q1dSRE1UL1UvaURZSzRqOHNqdXllUFBwU3ZsczlMaGZ3SXY1c3E0?=
 =?utf-8?B?MCtER0VrRlZDcjhoczhFaStPb09wU3RDcDFwYkVlVVFMemlFbmViQ1V3ZjY5?=
 =?utf-8?B?S1p1aGVObysyZDJsOENZb0F4U2NSbEFPeWQ0Vk5MTXhiaGowWGZhQ2NoSjJx?=
 =?utf-8?B?QStmQW5XdTI0cjBVcmhSZmZqakkzWTE4ZCtWYWxNM25wazNONGtZeDE3RlJF?=
 =?utf-8?B?Qjk3OVdaanRJdGt4azJNd251MURoeFZ0OTF3U09YYnZ1UUVMTXFjR0lnelB5?=
 =?utf-8?B?dzMzQXhBY2gwakVQNTFiVVVxTlp5TnpGR1VtNi82OHpPRWpTZk51bWxBR3du?=
 =?utf-8?B?Q3FUZTA4M3ZPRCtMWllsWEZUQ2hEdWFPSXRCMnJKdWJEb2Z5WlBWUEp3eWVw?=
 =?utf-8?B?M0NsdEU2RnY3dWZDcEkrZC9RZExxUnZ1b0NpOEJ3a0p0QmwzbUFsNGwrZ1E1?=
 =?utf-8?B?UmdrTmdpM1pBdnNBMmIyOERUUnpaeUtsWDZvTlhsRUROZU9GdldzVFlCcmI3?=
 =?utf-8?B?WktTSE1PbjMyWUxXQUtrVXRjU29aZUVvMWRhUmwvYTl0RWgwY1VEb05EWlNt?=
 =?utf-8?B?RHBpSzN5V1JmMUFpOER0Um5xWHdLL1M5Z0ZtRnUxRS93c0YzQnlpdklRM2xB?=
 =?utf-8?B?SmoxNU40Q001WXN1N3duUGdYK2djU2JUcU5JS3hVczIxMHF5eEJXWFJ1WmlZ?=
 =?utf-8?B?dWUvMnVrVndtQWRlMVZYa1lFWHVUM0t3Wk5YaHBHc0cwVU1oeFdRRk5PZUkv?=
 =?utf-8?B?Q0xNaVZCNkJONTFsVFpyZGFQN2hvbUlORUVERFl4aXFVV0hQOTM1WVhEZlJq?=
 =?utf-8?B?SkpkUDFyN0NNT24yYzZPMSsvS2FkVlpCekVzUjdHcngxVmdRaXptNmtnNE9P?=
 =?utf-8?B?alNjdWpuZ2hyaVJuV3J0M3RVRCs2TFhrUGE1MW04V0RBSDNyUFNmM0trbDZU?=
 =?utf-8?B?RGVXSnlLOHhrZWc5czh1YUcyMXNWajY5VjhIRlJzZS8zSU5oR0pWbnRDVEVB?=
 =?utf-8?B?bTlxNnFzTFZ0aWlGK29yakhYbzRQbDB3MEtIRzJCZWRlcDRqUy80M1hSSUNz?=
 =?utf-8?B?SldTb3U3c0dKY1Y5Nmt3a00yZUw5bC9OVEcvc0tUWXUrVUs4UUtkRXFzOWRj?=
 =?utf-8?B?T2pybGlqVS9jUFk5K2xiVHkwZy8xQmJVOHMrSzRhbXZ5WTBZajdZQ1BCaXVv?=
 =?utf-8?B?S3hiZWZxdXFIc2ZEWThqMnBaNW1BdU13NVRmdzRCM2Y4a0FXNHVHZXdjZEtX?=
 =?utf-8?B?bkYxNWNFSnlWSEc1TWZxZEcvSVpXSHdnOXJCdXIrZnVvUnhydW1IOC9IbVM1?=
 =?utf-8?B?d1lXTmFhRmtNWmdBSDZjLzJoV2Ivb0lBUWdDamZrd25sanQvUExXdFFudkxh?=
 =?utf-8?B?TjJUVWFsdDNRZkl2M09GWk92dVFKVmt3RFlBZ2I5b212V0IxSXQwc0RrRS9U?=
 =?utf-8?Q?/6gF6+neVxoChfrFwGLtrzwoQRHMpcka5OxKLmsG+8Lh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a634119c-1e23-4c6c-b3a7-08db686a6a77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:50:46.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeUU8yuuajHKSHqqH9UYawtIXl2rrEX2sWq3mDnoiXD6UpF8B0eqdpq3y3xGKAi/VLVUNnEcce1SQzadYBcOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan. I'll update.

Regards,
Terry

On 6/8/23 15:02, Dan Williams wrote:
> Minor quibble with the gerund phrase and this not being clear about what
> it is doing. Just say:
> 
> "cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()"
> 
> Terry Bowman wrote:
>> From: Robert Richter <rrichter@amd.com>
>>
>> Just moving code to reorder functions to later share cxl_get_chbs()
>> with add_host_bridge_uport().
>>
>> This makes changes in the next patch visible. No other changes at all.
> 
> Other than subject line, looks good.
