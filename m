Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19B6700E13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbjELRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjELRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:46:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A12D4D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683913603; x=1715449603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86HJYjRRJiKQWoUTI8vOF1vrdrXhx7LQj6WA4MqF0B4=;
  b=UaZsxy1CW7LXDCyYGaxa5D0NSb1CO+YF3WMxD6ll32B5FDDbKBzwrfIW
   J18/bnMCk5N2bEGkPmchS2tXh1u5hKP5pKqYWwZW2WtDHzJ0c+kPEhHqG
   GCrE/hsV7aBusjjAl1fyERWzZ3Oi2OKuq6yV/Aw043+JGwTqvkX0xhlBx
   0hvsP65Lehxiv8/rvd974jzGYAJtII7YWCCXxOeTX8BpaZRzLZHjFDCWy
   72KsJ/AWnrKkCptYRmgD1nexCSXZS+PLknnP+Yiz45Mamyko5mnt4KZDI
   MtsqMGjFgk0g4jNXNYzPbUWgOFktnMQK+V//3itNKi6IjrNXFPWzKpX/K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335370501"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335370501"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="769876304"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="769876304"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2023 10:46:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 10:46:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 10:46:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 10:46:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 10:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUyA34JX6ews4PYs7afaM+HnZCI7d0QHh0qbXBSUUpAvBFqbKu12u79q1EHOQnVn1ak/Va5BtoKL5LTjFxBRmhJvUquo/Ty+KjQCHRwt6K2XuqL+poy64CrQUpE1s5ZC1RVDMo5qBXR8VDyjrUI6m7Mz6rPoEep6hXeXqBpasOrL13vmvAHe7RcCYyqYYmfcIul2asHjTjfZOI6QwpNzv202F2DbsINetOavp0uJQtuQFcXnFIM59cgthxQkdREq/kDfhw+K8jvN+qEBjSjcyLIsukQISk0GlRbRrpG7YbDcf3o6HIaHpyv4kZ/AMhO2RDdPEXa8XhN6bJw2cev7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEjIhnwa8L06pokFSGr0/xviDHb3qGFPepuwmh2auQg=;
 b=mIbJXr+S2jUNBrvgIn9rsJrKNQZ44HU8WG43HhkVC2q2WU/1ukP3t5iGAleRGGBL+nz7AYYMuZ6GgenVj8jL9HDfwgJ6Op7j0XsPCub+hg43a1rJ+Ja6Y8HFu8rTucWDPweW1xdeZ02Fkf6X2yID/+5AmoRQgXtDJr3oILU+ui39b1SuIITmPxyUC7WhshuGV9CMwMDkL4yet2kMTGfanIPothpGXaDVX5s49FkZMllxEn/+iNb4NlT0kJo2JRKthZcuk+56wD72ZBG6kwp0W+xb0Wj1JmDzOv/A+K3IUHmXBYtoQKDWPAgp2fMi5xrjhjscCcsbqm/2M+7iwNO3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 17:46:22 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%6]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 17:46:22 +0000
Message-ID: <ec7b8f81-98ea-539c-c1b9-abf103e45b30@intel.com>
Date:   Fri, 12 May 2023 10:46:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fpu: xstate: Keep xfd_state always in-sync with IA32_XFD
 MSR
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Adamos Ttofari <attofari@amazon.de>
CC:     <abusse@amazon.de>, <dwmw@amazon.co.uk>, <hborghor@amazon.de>,
        <sironi@amazon.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
References: <20230511152818.13839-1-attofari@amazon.de> <877cted6pl.ffs@tglx>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <877cted6pl.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: e3123204-f2d8-476b-04e0-08db5310ccb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULaCzdp8uQsADsVA4Okk01wG/O0OLe1SjZnMm2JeG+x9EWiAn/hYlS4j5jud5eEyNZ1xvhMmQHRG8pxZaFdzDtCAP3lkyCub7CUWuDyU8zDLxDgSBDpLQncC/RlvVtXkKh6/T9m2sj2D0TeanEVIPJ7PqIeTdf0w/sMQk0hpK9o5juPIu8MVgrokUXymdk9NPGqvK55zpR/Rinq34OFvS+ZnAtaGrtoL4FC47606tZGGadpAJ5CsDCOpMCIXfyYBE52j/wQ2mIF/Y67hI4UAvdVDk4QTC5VsxULyZDbJ05nYnhxf77RHVlJSRfExJ6znPqpJeAGJ3iKVN36HQPUPd0kZcBh4if8vob6mQXysyoLF71QrXy+iBDCbQMzpvLmQ7zTyJbH0CPvklZl2yy8NGs5tpe8AycY4r4BbgvNLtt5jgaiSVYW9NvmniFbeDHiWhRNdUNJSsLlinjHe+RaxUOCa5pS862KoHWoiG9vlkWLI8QfmYz91aPaA8gMwagNMGFFU2YSFMczvrIVi8eHFxrdggKb3Tk9Rx8Q4zlrEeY+B6lthcr81NAFcTgqbadM9O2kdCtNlTsJYJHSU93LjYnSKB6iqYzyAMg0dZFhCz0bTxlm2O8NGO3vzLuCfGlAt2xz+sTrwDuc/XgTA0uHsqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(110136005)(54906003)(478600001)(83380400001)(66556008)(66946007)(66476007)(2616005)(6666004)(316002)(4326008)(41300700001)(31686004)(2906002)(7416002)(4744005)(8936002)(8676002)(5660300002)(26005)(186003)(6512007)(6506007)(53546011)(6486002)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdQa0xPTTAwWlJTbzU1dmZsUEdCRzlSeFVMUG5oMVRyTmVpWkhuVG5qQnJE?=
 =?utf-8?B?b3ZJSjdld3poUFc4SjM2Yllwc2JUTHhWRnczbVVlNEN5NzdNWXQzalR1SkVs?=
 =?utf-8?B?ajE2ZThidDFETURuV0FiRGZzZHRKNnhUMHROaXlmemNjUjdyZG9rVGgwcm00?=
 =?utf-8?B?cHZJMEprTFE4ME9maUorbzZNQ0tMUWRDSnE2WUZMNldEYzk4VWVlUUJFVGJL?=
 =?utf-8?B?elkyb1daYVBZQkRzS0J5YU1jNmVNYWx4QVhuYW9ESXZ3TGVQNitQTlQ2TGlv?=
 =?utf-8?B?TUU2L2tYNDVvWUxMNXFiNUMvTFdFV2huVFNjOFBzSE5zY1JLM2MvNDBRNS9M?=
 =?utf-8?B?SUJWNW00Tk45N2VjYkRRczJmdFdGMDNuUjh4RHFYdklXcnpvaHRHckhmcGNT?=
 =?utf-8?B?Y1QySHpDelpIWFQ0VURIRFgxNWltK2lvM3ZkME5aMTdwUFJvV29EQWQxeDNR?=
 =?utf-8?B?d2Y5SUt5Q0pxRUZ2VEd5bTFkRlMvdTRhQU9KS1BWMnAwWXlpa1lnQXVmaXhs?=
 =?utf-8?B?RSsrR1JBZHZaaE5PaDdkdTlSNDFRVXA2YjgrTmd6UHR1bDgwVmM3Q01uSlNM?=
 =?utf-8?B?S2l3cXhDTjFnUEpFWEZET1NmNzZXb3dNcnpvNXplK0lCQ3RTd253YW1KTjhr?=
 =?utf-8?B?Wlk2OXR0Ukt3MnRNODduemU2MytyOTVtOS9wQTVlZUxkR1VpMDBtVkZlLytF?=
 =?utf-8?B?KzJXbnEyWjFobFhmYU5QbVllYjN6QlZ3OEJVTVV0UkxJczRGYnFBRUlvZlFE?=
 =?utf-8?B?K2tkMGJwWXFZZjJNR0ZaSEh3NFM2Z2x0K3VxMVhwV1I2UXBJZFIzT3k0Uys1?=
 =?utf-8?B?ajRraTkxdGJtejFLYmZUUEs3UGc2cnZjRUlkZ1M0bTlxUDlGU0ZxOVJrN0sz?=
 =?utf-8?B?MElpRmU0b3d6aTVIVUQ0czF3NVAwTjRXSTViQ01jZnU3YnFnKzNzQmJ1TXZz?=
 =?utf-8?B?dHF4YzhIcXZaTDNON2xYdEIvMHB4dWg0Y01VaDhsTGtGR2pVU1ZMRGR6QTRK?=
 =?utf-8?B?MGhyekx6QTNkdExRMlgxMFJ3clZYb3BJZ3FWWmhZdzRVZHN5YXhOZGJ5SXZX?=
 =?utf-8?B?V0kzbXQ5TjlYOHZCNXErZDMzY0FnSmFCTk9TUzJrY29IRStnditCdHRYbWZ3?=
 =?utf-8?B?Ym9SZW5DdVZKNU4xQ2txZ0VhcU1SYllCZ3I4OFhmL2paUHpCYlMrODhpZGgz?=
 =?utf-8?B?ZU10bE13MHkyOWY3RVBnTDdsaEFHcVlLQ2VtMElCbXBmTVI1VDEvb0plekRP?=
 =?utf-8?B?RE9QRjZIRndWbnk2ZDlwY3J1OXF3QU1yWnYwTHgwV1ZyaG9vWDNmdnlBUDIv?=
 =?utf-8?B?S1N4OVgvZnIrbmVhOHFZUW5xbzduY3JNby8yUUdiQVQram5pNE9tOWJaa2k3?=
 =?utf-8?B?S1E4M0NXU0dOdUNrOFRvaXBjNE1kUHVyODdnZi9PRjhHcEFPK09SU2diL2kr?=
 =?utf-8?B?VjE2YktXZzI4OEdLajVHVDZ2VDRVVkh6a1ZkWE1ka2lINzJUbnd5eDMrVnQr?=
 =?utf-8?B?dUtqVEltUFVUZkUrTDgwOGhRVlJieGRXTkVvN1ZPTXg3TnJiaWxod2VXaExq?=
 =?utf-8?B?WDBocUZETjN4aEpsdlkrbGhaYVU4bEh1MHZ1SG5pUDVFOGxuSGdsTk1XYXdO?=
 =?utf-8?B?WDhZUlJyVmp2RkgvakNUb3pENmF2QUlFWWhMWU5UYWl6REVVRkE5YzMwbWIx?=
 =?utf-8?B?ZHRjVVNGWEozcTJjRGxlNWFhdllkdVAyeTczRGw3b2twdHpnYWVibUtlRkNG?=
 =?utf-8?B?aVdZbVROdWYxMjJCVjFPUnZMcUFiRnZyMkhGTjRIZVd5cmROak03bHlZN2dN?=
 =?utf-8?B?cEJTSFBCYWRVYkI0eHFtVGlRc3hrdm45SVJvMW52MHUrSkZyaEpnbzJ6bHI2?=
 =?utf-8?B?bnlLWlNiRkM1SVo0emFFekRWVkZVWlJzWXIzZVFSQ3psZk40dENlL1RjQ2RI?=
 =?utf-8?B?bTN2U3N0RHNwZStTbFM3VHNvNWkvd1ZhajdUSmVtRkkyOTAwWlVSZTd4WUw5?=
 =?utf-8?B?U1Rxb1grVndOWmxuUUs3czhLRG1XbFFrd1FQbXdEQmdyWGdFOXpJbUtpQ2tT?=
 =?utf-8?B?MFBpWlVyaEhnYjA4OUhBWFRSSm1Sbk5VVjQ0bld2SU4vSnVtZnVnTHkrU3Rj?=
 =?utf-8?B?eHRNMmxhUUVaTlg1V2ZDc1hIWmNJckNSME5lcUZFeElsUXhyYjR4K09VaVlG?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3123204-f2d8-476b-04e0-08db5310ccb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:46:22.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph3tnklrZp6KdmiBVcAL5fNdy0GoHjZL+vL7raJ/ZcbOf+So3q53+4YvD81dnPyjVEiEzTPtSh1w3FRhy5aMBQ+89vAPMjtEDNXsB+b/Nss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 12:11 PM, Thomas Gleixner wrote:
> On Thu, May 11 2023 at 15:28, Adamos Ttofari wrote:
> 
>> @@ -915,7 +921,7 @@ void fpu__resume_cpu(void)
>>   	}
>>   
>>   	if (fpu_state_size_dynamic())
>> -		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
>> +		xfd_update_state(&init_fpstate);

xfd_update_state() here is not a right choice as Thomas pointed out 
multiple times.

> On suspend per CPU xfd_state == current->thread.fpu.fpstate->xfd so it's
> correct to restore the exact state which was active _before_ suspend.
> xfd_state can't be out of sync in that case, no?

Indeed! But, looking around the code, writing 'xfd_state' here appears 
to be consistent and logical I suppose.

Every time writing the MSR in the kernel (except for the init), the 
value is saved in 'xfd_state'. So we don't do it on the sleep path. 
Then, on the wake-up path, perhaps it makes sense to restore the context 
with the saved.

Thanks,
Chang
