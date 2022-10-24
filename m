Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8760BFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJYApB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJYAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:44:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D704A32A84;
        Mon, 24 Oct 2022 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666653435; x=1698189435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwc1EIBw+fUVtrzuGrNYZgAYWIWlE3dwr1MS1anqiac=;
  b=j8rmyhcBGm8NMXSaFshKU8ihj27bjNeL4FHKOwIFe4yKbjzcXa5SD1Ug
   4u36lyac3ZYt2Z1Aj/NE+gA6L6IZ+ML330WQAg++opG0U94d63BzIH9rp
   e/t7Yi+vQbkQSB8xlS2CKJIkneKFqBvIJ4q6PJ16rtRE2m35NPw2D++TY
   H2LbOgtIFxoK49UiV76mip9/NFUvc+RMFKfi6frGHU6qx0k2M6wEJSi9W
   63fIaQ2wWUwnGmP8y34uO9er6qoTSxTCxW/Z/NB3aNjKnoE8Obbz45qMM
   e8gb0O+efmyt+o+l0HBoxN5F3gqn/2E7Y05yF31en9unZCMSD+46otuBj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309230591"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="309230591"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720649849"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="720649849"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 16:17:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:17:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:17:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 16:17:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 16:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa9E7PqbaY/N4Zm+eEuhhYadaDqxL5gfkYoqaH0R2U4b/jbNRgx5a/3oGJ+OvXGBVglh5Qnl0ySMj/2w2Iy7qa6FX01kw3H8XeOu4wprVlwMXn1O2elusGCwEX/QLj2ZAebq1/9ElaQbdXEgtDojB9FKzPNup+W+J6rsvrgnEgVyEWbVUJmxDGbMVx5l3e1vNz5VHQVPLTdvZItQEg0rcCjSarRaeQ1gYmttTmDolu4nsprX7h+wqurXrPSjg7niAks/M0obGVclKash4QdQAp9qwYaJnoFP0HVggf9AkU6Br91arJx+F9vSO1/fxFVn1C4OwaP7qnA0WYRwTT1IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5yMS/tJjphfgyA29AsJAcUCz0ux34eFM4/zQaCwqg0=;
 b=etwYnrCjDaSWQJNPNdL+KQtlVHQ20qdXWDn3V4nuC2D3C4S+JlgHYGzXTwEN1eBNnyrXDUW6kuHL32E0H1cc414fomrwWu/oAjEsglBm5CjZE+lblzE3VpJiB/HH6nhyXkKnggVy5qLpapOOpqvnISAuo2hM08iskYSgTcfeCG77BAMzRUjFs4D+AD1rJB7ZqGGQUUGlzT0QDZ0403qWKIJeT1lZ2y2mg/xo6f/x/aJf9zgeNOU7DLT7o8oNyh0dh77FzDE3Fg2pF+frAjc3z7vsJxkPVpGUyHCcXrk9nTW1twHdAeUIY6EIhAed2MWkROdKYnta58AAeUoIbFOM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BL1PR11MB5541.namprd11.prod.outlook.com (2603:10b6:208:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 23:17:04 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091%7]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 23:17:04 +0000
Message-ID: <c4351aaf-d04c-6b13-6dbb-d75509b5ad4f@intel.com>
Date:   Mon, 24 Oct 2022 16:17:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 02/14] platform/x86/intel/ifs: Propagate load failure
 error code
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-3-jithu.joseph@intel.com>
 <4028a1c7-ed84-37a8-1d94-178b5aa201a9@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <4028a1c7-ed84-37a8-1d94-178b5aa201a9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|BL1PR11MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b88ee4-4792-4c93-d89d-08dab615dcdd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBDJ8fc4WKc3YiYMjQx4QWU388+7IGlqRO3vJRIQFPgvw6/Hjxb8Y5gutdnvA0HpBstJr0c/ZUFISBTEgoXB3htnaRBHB6tBuN+RFsnLkRLnEk8asVwOn0wYrCM8MUwm9q74G6CGS+QsZ6zuiUW1xwmElIwmnukkyFu7BLPQSaNgeSZhPnaCvSHBPIxiFTQeZKjNJ3pCuEcVTW8K19zCuzwiCtOMghNMRVlnOLEBFAT9/wmf+5rMlQUBtOSws6b6XR2sYS+omno5fXlT4C8eE4t18e10EluAwj/yPof+SxlqV6JBxpPcEf2vEzOa5sY31kgYeJglcNiPPK1ji58vyjKI+DkEiUCr+2T73BpI+htcHcnv4cMPelEe9VtK7QA0/hzhqvyw144f4ftRvj0uHdqZRQkKwwIx6M8I8Vd/K3ta4GlVLqTjCO/SlfaBVFWUiNPBQ4WcAuDp1c6T9eL1BsCjmJnuXqtVAurN/kXxotmHz0unkX4WVUbFTqC2lXedVFBbc7of+JoAsbkw6rfRbRxMBry7NQLVGuwrS7tAkA7DeoNSpQCdJjGG8LpUhBnA7WuPfCp4RwbwqPdnhyX1vuQ4TvM2FCFUsZhS9NtjabC44yNs5mZzEVB/1QjNNGbC8ItT8Qe4sGdLEaTHfeOb0N7XxmTFAkbas4alaQB4bFr5eN9PM+AOqCMtFByq29iRacQdoQjnB717DDOoFAQVMD1KebgKJSGWyEcxJnsNJpEUDGQ8sjK5+JsJYwHEQkTGNlDEfr9bWEKHBmsrKvRpZxuWqaSGnSNiMRk1XB3vF5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(26005)(6486002)(478600001)(86362001)(83380400001)(2906002)(6512007)(31696002)(31686004)(6506007)(6666004)(316002)(66556008)(6862004)(4326008)(8936002)(37006003)(41300700001)(6636002)(7416002)(36756003)(53546011)(8676002)(2616005)(186003)(82960400001)(66946007)(66476007)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Npb0IwUjNUc3A2Y1BTa280ZjliN1pTdnczb3lSVGE4cFI1TUNnWXJZckN5?=
 =?utf-8?B?eUx2bS9IaGw3c0ozcHlqZExZMkJJUG5QMlgyMU5JTWRDM0pDVy9uMmlsT0Y4?=
 =?utf-8?B?NWVvc2dsemFhcHFsdzNndWVvSFlhb0phMFpaVDhHTjNaSVdEUVBLeVFRS3VM?=
 =?utf-8?B?Vkdua2NmeVNOSnVqd3dOYkxaUUhNbDJheUxxT2p3UkNpcGR2Q2xzWXZ1cWpT?=
 =?utf-8?B?K2FQSW16emlnOG5OeG42bXNnS2U1eitlb2QwRzlZTWFCaktTTm9XcG9SNjJy?=
 =?utf-8?B?K3VKZ0FyemxpbFh0MTZaODFZUnJLSXNiUHRUSVBFanNyM2FzNXRPeHRmSlBZ?=
 =?utf-8?B?SUtoR1kzSFNaRDk5ak5UQ09nQTNydWN6cHdJbVNLdkYyS1FZZHlJOFFRc202?=
 =?utf-8?B?VFlubkp2MW94Z3ZkREI3NkFFdHM2VUxoWjFIWG1nNEdDSW1MNGlnQUlaT2F5?=
 =?utf-8?B?K3FuYnJMTlhYMzRDRHN3SHU4dVZkUjhVUG5KcldINE1kYjF0NU4vNllEYWY5?=
 =?utf-8?B?TnQ5bVQra29sbk5IckdRMit1Mkc2NDVJK2xTeWgxU0ZMUmk4c3RhcVE5ajli?=
 =?utf-8?B?N3JjSHZCTFZ5R2Vha2lQeXNrT0dEVVJJK2Zsd3ZLM3VqVXJWZjZ2Nkd2ZCtR?=
 =?utf-8?B?VXpYNXdRZXBpbXpRbENlSHpNWWZwaGs0VDdWWGhOMFJDb0U4MTAxUGpWdWh6?=
 =?utf-8?B?elM1eFVlY3JuNEVJdDhjM0twYXhPSDdYbU5WOU5lanYramkrRTlFdE04UlhV?=
 =?utf-8?B?VUtiZ3VtUUFMNGpCc0U2bGRGUzQ3Mjl3M2R0eURuR2d5dHJ3WlRIREFqQzJT?=
 =?utf-8?B?WUFQRG41NVpUMmlDcE9rQzI5MXFhRTV5TXpJK0s0Rk1qK2kzWlJMT1dFL2d2?=
 =?utf-8?B?RXRwMTZOZjd1THpVUVZNbk1hNVQvbms5RnNTN09nREdhajdPV25rVHFaSm0w?=
 =?utf-8?B?OUpJUFFjbEdVMVRENU9xbnUycHNQTGlXSnZVRXhqYTlhSDh0NDVXdGRralQr?=
 =?utf-8?B?eUZUMzhKZFRNVm9NTmYxdTVjQlRzQkZvdnpZQVVPeUVXb2dtWnZRcUJPaTlq?=
 =?utf-8?B?b1BDT0FWMmVwRXc5ZnVJWG4yeWZUbThhSUxxSGFNY3BybXpia0lWQjZ4WDhW?=
 =?utf-8?B?V1Q1SW90UWZQWURib0IreVBuRzEvYjVyd3VGZ0tXZnFUY1MrMDVjZWN0NWEr?=
 =?utf-8?B?d3IyMUxGdlA0SlF2ZnJEZVRhMGx4MmRYUEhDR0xtUWtNK1NqV2lOYmhodVpl?=
 =?utf-8?B?Ti9VT0lOVWlLK0F0T3UzQ2tNaFlCZTR1c1RXdVlnNTBIK3hDRDdBU2JVbm9Q?=
 =?utf-8?B?QzVyZTM1MHpPMkE3MEtxMnB0QWczOUVqNWo4eHFDY25JaGxFcVg1SDdEaity?=
 =?utf-8?B?bktzeDFjL09OQVFDaURpQ2tLS29CRnV5Q2lUMEtqUVRMSi91aGxjNFMvS2V4?=
 =?utf-8?B?bHdDdzhITGIvc0JUdld2aXNPOEZkS25HSXlVRk1BeS9MaUpEVVE5aktDUGJL?=
 =?utf-8?B?dHh6bUFIaHphZ2dRQ2NEYUhCQVlLdmk0WW1KRHJrOGx2d0phbGE1ZVFiRmtE?=
 =?utf-8?B?R21IaVIrMG9MWUZlbnFWVTRGOWY4RmcyL2QzL1c2MS9QenFnUWZyM3F0RXI2?=
 =?utf-8?B?c0ZQTTRja1p6YzRjWWZTZ2FUUlovZWxLYTdKSm5LWDhMeTFka0ZDNEdrQXZN?=
 =?utf-8?B?R0RMVHo0WWdTdVFFWVo5UTQrUE1mU0diN1lVT1JUdVFoZHZzaTJMU1hqaVpK?=
 =?utf-8?B?N2lGRFlCOFJNMGc5L1gvM3g1emIrU2RBdzZIbGNSWkNyZi94bHBTdG0vbDA1?=
 =?utf-8?B?OThFNXFwTXJ6c2VCVnR1WklDa1VhSzloNDVRajdmNUtyZ2pETFRhU0JOcEFa?=
 =?utf-8?B?dmpVRUh6RGdna0xiN2s5SFNmY0J5Q3hzTmNCTVBaa3gycng0MWxNa1VTcnRW?=
 =?utf-8?B?L0xualB3Q3hGTnUzQTZEbFJnZEs1V1h4OW9sR0E1ekhuMzc0bW9LNUNmcWdv?=
 =?utf-8?B?eGgwTFZ2TjFWTnd1MjVsa09sMm9zbUQzWVVqZzVwb1Q4NndmaWZoMUFnUW4w?=
 =?utf-8?B?TWxsQTE0Y29FdzFzSVZpd1JCbTV1RU4zNEljWldaVWJmOFBiNGVBU295Tmhz?=
 =?utf-8?B?Ty80NWRHU3VOVGlBL3J2b2F6eVNHUVFMMTR3bm12WXNBR2xrVkhJZFFoOVRZ?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b88ee4-4792-4c93-d89d-08dab615dcdd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 23:17:04.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP/AG9A2TWTcbGMuFIZmIfBCq3jbPkWnIBIQXu617oKFp6merWtaxF/yR56cuQwd0XzFIiDt+2PfvuTTo6agTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 3:52 PM, Sohil Mehta wrote:
> Hi Jithu,
> 
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
>> Existing implementation was returning fixed error code to user space
>> regardless of the load failure encountered.
>>
> 
> The tense is a bit confusing here. Also, 'Existing implementation' is typically implied and unnecessary. Would something like this be better?
> 
> The reload operation returns a fixed error code to user space regardless of the load failure encountered.

Thanks Sohil for the review, will reword as you suggest above

> 
> Modify..
> 
>> Modify this to propagate the actual error code to user space.
>>
> 
> ...
> 
>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>> index d056617ddc85..ebaa1d6a2b18 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -234,7 +234,7 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
>>    * Load ifs image. Before loading ifs module, the ifs image must be located
>>    * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
>>    */
>> -void ifs_load_firmware(struct device *dev)
>> +int ifs_load_firmware(struct device *dev)
>>   {
>>       struct ifs_data *ifsd = ifs_get_data(dev);
>>       const struct firmware *fw;
>> @@ -263,4 +263,6 @@ void ifs_load_firmware(struct device *dev)
>>       release_firmware(fw);
>>   done:
>>       ifsd->loaded = (ret == 0);
>> +
>> +    return ret;
>>   }

This change is still needed by the new code, more below

>> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
>> index 37d8380d6fa8..4af4e1bea98d 100644
>> --- a/drivers/platform/x86/intel/ifs/sysfs.c
>> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
>> @@ -94,9 +94,8 @@ static ssize_t reload_store(struct device *dev,
>>                   struct device_attribute *attr,
>>                   const char *buf, size_t count)
>>   {
>> -    struct ifs_data *ifsd = ifs_get_data(dev);
>>       bool res;
>> -
>> +    int rc;
>>   
> 
> Does rc refer to return code? The other IFS functions like above use the commonly used 'ret' variable. Any specific reason for the inconsistency?
> 
> Also, patch 11 completely removes the reload_store() function. Should we avoid a separate patch to fix something that is going to be removed soon? Would re-ordering the patches help in that regard?

You are right that reload is removed subsequently, only the ifs_load_firmware() part above is needed for the new code . Will move the above to a new patch between current patches 11 and 12 (and drop this patch)



Jithu
