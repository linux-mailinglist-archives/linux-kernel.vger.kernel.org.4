Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFE7438A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjF3Js6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjF3Jsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:48:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328FF130;
        Fri, 30 Jun 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688118520; x=1719654520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7CevQunT9DE9BYXpAIEP5GsubMapL3XeiZ38z69ppWo=;
  b=djZgTxjuAksAxL3f3RXeSNbey3wlcY3qzHHWez5v80LltsbGnnIplJ/Y
   8DC22oEJxVgdKPWG6NMYkM5ogKXSkkmG0ai055iMKXZCD193MMTHy1BGn
   uA8XXugoVmp8FrVaNTPT6mtOKA/7JGpcmSf9gfdI8HCOLlMUhL1Kl+PGY
   O4/zNUzrlq+240l8SMzw9LeVXUwZlt0zfQsSsbwrFupyZMYlzvbD+BxAx
   lI36Fg0cBuRkl/nx4XdrqO7biyZ7Qp9gGvYwYOOObK+Z8uDnSq6siA7PO
   zm/n4qPT1FiWus7cDyxDm6NUOLiQaHNuwJsXRxBwsxor0L0ILlAvVRVue
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428401327"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="428401327"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841803302"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841803302"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 02:48:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:48:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:48:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:48:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVXVYVxsRT1OAevuPRADC3m/vEyyQB+lMVBTiXh8Vd3rth0Vtjt5zOerx7I2EvOxfiuapNrf9Kob07bOqydfTfBq1SBq5WqtieAHxZ1BmGEd3ytx59vAbiBeNg81oFW/Wah445gweDWJp+d9sG1c2lsMCBuxj7VJAQG85q/wsEAypuTTayno8C1ffuM+R/oeX0Bf8KcBThoSoWLHfMe3QDxPPrb1evMcUrsth1QuP/jQyUKGTFWc3PVzoE/ksyy8JhTr4j3Q9TrUBiUDsPZ8NUB5Qkpkhxfa89UrbhgNeHxptlLlxvPDZz2RGpKQg5d4G9JT1iUI2CLnSOM6UR4Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgkURLkNB9/UZS3xSuzz8gs3CoprDhbztHkJRfaMy/E=;
 b=FqFAvlT1KkEgBYD9cXMj08l52ibhP7fGn4RIsk5OyrdE8biOh1VN4sGZcyE0XPxasr38d3WBEgLGp8aHmo4lctwk0QQvzKRJ/Jr4FaY5Us5FEtS5Pau63df1nkNyd/4HE2UKvzOtnHHsaP35XRD+VShvxlMLeER4cwtQf7arKCBl8VRWhTL8mXNyqzzTWlnxtPoUQzZSX4kF+rADPpTXRaaXrTAPJw5gsQXU1TNViPcAml/8QWH7cZVuUDwpU5k+g3NAr4hEUgGvfuI8KTXLb7JRLcFNRrcjnb3aA6hqF0r4neOA7IJMzKRcrw8unFhPzEpuZ8G7YaNokViv0UevcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 09:48:34 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:48:34 +0000
Message-ID: <aad9608b-34fa-1405-1fc4-5eb8d7d1647f@intel.com>
Date:   Fri, 30 Jun 2023 11:48:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 07/10] acpi/nfit: Move acpi_nfit_notify() before
 acpi_nfit_add()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-8-michal.wilczynski@intel.com>
 <CAJZ5v0jjwk+jVsULD8nyguc7p00Sn3Hyxq7=PLNzpj-Fz6H6sg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0jjwk+jVsULD8nyguc7p00Sn3Hyxq7=PLNzpj-Fz6H6sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 63295cc1-4e0c-4347-b77f-08db794f2b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Apgb+Yvmohdx0cVfkkD1PiG1CkBu0uME1+v05oG9ZxoW6EaN3pFPEQk63R8oON6yE8pIJG3YI55ndRre9Dl8AN0+EW8qCsyTngDfLraWpTikBf0A5qQucKp07vVm2RfQU0a94H/zvaOnICJ5ecMsOGvMpu8Deq+OCydSCALQYaeLv3SEHzPtSDWJ3FEcaKQ2xURY3dFoD9DbtzUWmP0qO+QGKOKAcHezry46FFUNwbfAW/50lV4Ut/njpkAZel79OGUB/rX1R/OBCRNr41/wTBS1tTncRWwmHPzUFdBoVPQMNO1FoBLtw4quL5WMpLFSOnHvpFzzJtsQEGzQUWkranCAe+HzaNoxhXdsfOvzKxygwCb8/Gyh3nF4ECnm6RK3MFQ9QOk7CA79ZB1F9+J2CtnllOHHAnH4W+IcV38JN1Ojau8EslhiZ43JXnzjL3iAtmIEyorVkoqY/pHU4L6U6G5JOHQLzgufBGqD3lP/gQcdH8ue6qlZV24ekQlwCTOTcIu6kNdBkiTPgsZ9VOeSut0M73gsXLNP1ewHRf7TrlkPEj7nnUyFpuQDXtaOPhPEUJ95G5LlcrgfMr9K2eCTtbp7jeg0X9wfF8mxnwFVFcIJMG2j7OWjqgbGZo+vMhcckOj+J+/4UiqR5UTzxfThAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(26005)(4326008)(66476007)(66556008)(8936002)(6506007)(36756003)(966005)(2616005)(478600001)(2906002)(6666004)(83380400001)(186003)(6486002)(53546011)(66946007)(31696002)(38100700002)(82960400001)(5660300002)(86362001)(6916009)(8676002)(41300700001)(316002)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pOaVZJWGZoUitURXZaQ0YvUjk0aXdmQlVEU2hHVG82U05VT1JLY0pVMG5D?=
 =?utf-8?B?RzNnRG9aZ2JFRDBDWlFTWUR4OWdaK1MyR1NFM0RCZGdLUDY1eDFtSEphSzZT?=
 =?utf-8?B?LytOQXJwOUd1Z0lYYlB1SjBaRSsyb2Z4WEc3Vzl0dW9IWnNmYlpTc1lTUnlF?=
 =?utf-8?B?b0ZEaXZoRW9ZV3k3VGk3c1JEdUplLzlyMHBMOTU2WTlnMlo5OEZwV1FsMTM0?=
 =?utf-8?B?ZWFaSU9RWllRdGc0a0RIek4xTTc4NW9nZ0hWTDVaSThHZkZKWERMMFZzejRz?=
 =?utf-8?B?Nmptd0xlQTU4aVdVd3hDeVZhcmRROTBreHFiUTQ4Z1QyZllYWHRCNW1MOGV6?=
 =?utf-8?B?d2F2N3NWWit4L1poRE5tc1JEbCtvL0xybHR2RHplZnpoOEFWdFhmRDhoYjcw?=
 =?utf-8?B?Q0dXTXMvbFpoRGNnSnEwODAraXVUVTJuaUVDSUR4d1VIeGZ1TTVoYXhrdVJo?=
 =?utf-8?B?VVJFOEZUZTJ1ZlB2VjNPenBvSlJDRmthZ1JjZ1dPZFJtcUUrSEVMMmZDdnEr?=
 =?utf-8?B?UmlDYkxTcjhMTlhGK3UyQmNLOGdlcUNXd1lBZzBESFp4bHQ4TExpMDdGZ2Qx?=
 =?utf-8?B?WkZZWE1sbGpjNDAyN09WVlBMZVBuZWpYZkptd01iRkdNWjBmbEVCbENUVWtY?=
 =?utf-8?B?Rk1WYUdRS2xFVUdyYlkzWE1EYnJVei9xOW45L3hRT0RXOTlnRjVkZWhhVllp?=
 =?utf-8?B?WWdEVDNwSjkyQzdMQmxOMk1CV0FxbmpOSEFRc3o5SzVXR09CaHloTjFya0x6?=
 =?utf-8?B?dzE1VWZNNERPMUpwS3VyU054WTRVdjlQOHdxY3BRRHpXbklodm96QnM5VG5u?=
 =?utf-8?B?Y1dYWXI5Ynp1WHBDUG5Eb3I1ZUxKSlQ4L045OWF0UzN4cmJYcjRhdTdqNEd4?=
 =?utf-8?B?d3VlcjFNSVBSbS9yOUVOK2ZEdllTK3V2ODhMNDA2UGdkQk9ONEUzQ2JzMVFs?=
 =?utf-8?B?YzZ4MUZkKzRSY1ZHMXdpcFlUeEU4L3FzWjVCREt4Rm1MMURHSGxobm9VRVlT?=
 =?utf-8?B?WjFRdFlDVFMzVE9WaXlDUllLeVhwTWhNWElDWVFjNDd6UWpkV21mK0J1YWlJ?=
 =?utf-8?B?MHBZV0FVdjNROVFEQm81eHpCWDBVemRoREpDcSs3YkNUODgwQ2FMSzEzUURH?=
 =?utf-8?B?ZXd0VnIvOHd6U0FWaVRNVkkyRjY1dWVLL3oxM0ZES3pIUDU3U1g3bFlVQ1FQ?=
 =?utf-8?B?aHpLVGZPMWFBN3hhRVFHV1Q1YTNzQjZYRkU5ZXFOdlpITHkxeUhhWkFzbEVi?=
 =?utf-8?B?aGdEb0I3NDIwZk9XNHVXVkx6aEdjZERvQVF3RTRWdVlxRnJZa3JCSzVsMzJZ?=
 =?utf-8?B?eDErRTRSYjdMcVR4R2lTejR1elZsQ2ZtYUYrVDdrbUpaYkI0b011ZitlVjEx?=
 =?utf-8?B?NlRBdEdCeUtCSXBvSkI0aTV0UVR1VkxpTlVJckRZeWhNQi9rZWhnZVhvNXVy?=
 =?utf-8?B?NDZBOHd1NDlqUk4wYnZMV0t0am5vQTUzYlRpSmNHVzF3RmV4blBBa3pza3hG?=
 =?utf-8?B?OTZ0WncybVQ5RW1DbUg4dTN6MldaVjl0d05sQWk3YjI3ZlhTODBLVERESTRH?=
 =?utf-8?B?NlRhR1ErWkN4YW1JNlhRTXVDUEpxMXhNRGNUdDM3dzNVMFhkaVBWcmF6TjR3?=
 =?utf-8?B?NHlhYVVyZk9nQTNaUWhTMlI2Mm5YVUUxNEpQcEtRMW90dG1DOVk3Zzc2ekZW?=
 =?utf-8?B?dit3Q0FkU0FsWk5JVTJXNzQxVVo2eE43Z3RNQWxxampnYW05cVBlS1ByUmwy?=
 =?utf-8?B?SHM4Y1R6VER4TVFwNVA1Z0p6Z1JJckRyYWhlZGxGamVUYVQrL2dSNUNEdEMr?=
 =?utf-8?B?RWdnMkpJRU50ZWxvVm1iMW9BT0xOSklIYW0xZFRXVkhnQlM4cFJoaGVuQ0dO?=
 =?utf-8?B?NzlwbVA1dFYwNW5nM25IcWR2M0ZyaDN4WGhvRVNjR2pwSnZVL2V4VWEwNDFW?=
 =?utf-8?B?aGFsajlvald1d1FWRzQ3UmhyckFyZTRqWno4SGYxUzBzRFJPSmtCV3RlbW0v?=
 =?utf-8?B?alltYmM2Y0F1RXp2UlJjR0hrSlMyekpkK0c4bkg2VTE1RjgxSjZQbnpKZTlo?=
 =?utf-8?B?UU1oc3k3cU1BRktuT3pna1pBSnBlN3dCNW9hYXNSaGJWVWFNVWlrMXlrZzhN?=
 =?utf-8?B?OXJ1MDBmMnVHN0tXeVNFT2prY2JqMFNBUDBsekwzNjNtNVZyUFBWT0lxMG5P?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63295cc1-4e0c-4347-b77f-08db794f2b57
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:48:34.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0oJ9fgsibQqJLBey8KttO8W1VTSNxSpI7RTpoLc5oISY+tFRbwneRfe/mv7wfhnLPwWGWWhPIgbgnG7ofGM0vtUJ1Ms1VsB6Xsi9Isx5Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 6:06 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> To use new style of installing event handlers acpi_nfit_notify() needs
>> to be known inside acpi_nfit_add(). Move acpi_nfit_notify() upwards in
>> the file, so it can be used inside acpi_nfit_add().
>>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/nfit/core.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 07204d482968..aff79cbc2190 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -3312,6 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>>
>> +static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>> +{
>> +       device_lock(&adev->dev);
>> +       __acpi_nfit_notify(&adev->dev, adev->handle, event);
>> +       device_unlock(&adev->dev);
>> +}
>> +
>>  static int acpi_nfit_add(struct acpi_device *adev)
>>  {
>>         struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>> @@ -3446,13 +3453,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
>>  }
>>  EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>>
>> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>> -{
>> -       device_lock(&adev->dev);
>> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
>> -       device_unlock(&adev->dev);
>> -}
>> -
>>  static const struct acpi_device_id acpi_nfit_ids[] = {
>>         { "ACPI0012", 0 },
>>         { "", 0 },
>> --
> Please fold this patch into the next one.  By itself, it is an
> artificial change IMV.

I agree with you, but I got told specifically to do that.
https://lore.kernel.org/linux-acpi/e0f67199-9feb-432c-f0cb-7bdbdaf9ff63@linux.intel.com/


