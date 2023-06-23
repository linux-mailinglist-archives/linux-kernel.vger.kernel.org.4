Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E573AD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFWAKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:10:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB961BC6;
        Thu, 22 Jun 2023 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687479038; x=1719015038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jlANOL7rcoN/Op1QJrgM8sZHDogCZpvkUcsrsgI/gg=;
  b=g1HsMkuXpkcd93mK5c6f4lAa8mbh3LF2j5d1/166EcuYYlpnMgZVqQN3
   kAJD/Ew/IZPTxSKAEBWJiCTPy3WWeA1S3JqjurWeNRt6Cf+L/SmCxOs2p
   zSh2VnCf04eBlBQnDvAaZUHLcygw6nhNiP65Fsp/VJvPky/7azYqnbuR2
   cPWWZPzFXLd49vtbNhKN/Wfjt+gslM8e2DTITL2YVSeP8MX7GWAJoiYNy
   zAor9NwGf4z70QsyFBJJWsobhXBRju18BeiVpyC/5E0aXXf0OkLlUfFHV
   HyXNUGFRYaOFCjSQFRcAVuFwtQgdxmzVkkuzh8w2zXO+4MhcjxYcnr3LL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350410626"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350410626"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828170679"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="828170679"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2023 17:10:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:10:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:10:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:10:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnrzL7gwpDZ+mf4iHoIxZpU27+uoz9dp1g/qCxoMeQO7qvvOd8G1A+euIobx+V01SDBguYIz6/Tqo1qg+NM8bn1NG1KYoeEJybRt+nSy4M2KVSiHkvMrG3vNHvQu/x/ga+8rOcdnFNKQ1pDF7xoCQTLJpN+86jjDGz1B4Xs0y03TIFz32/icp+oq6LOHkudtJzWUKDyKYcIYRUB17B86scnOK5KE3tCdNnWTuEq5OAOzSeYWEUr6U3zpsOFq3zzE6QvUnaJlURrBuHG6FF8uM07g11W+hWvg10VO90ykqf6i/oIinE2rzPIEnVj/bqkiY/wsTMGIRM6nT/AMUk+fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So6b8zSEoVHry7FGNtthOeeeG0LomNPeMQ+SbETAOqk=;
 b=daOm9GGWhPXCy92diJWjjUXrb2i+EVjaM2Jouo5e+Czjh77D8Gxq2V6VYqkQvdidgfwjEZsLCTd636jH7V8Wv/rKhogc2nrPCJE807fmtVvozMDEeBuFseFpnJUyiJ4Z7L+mBqUYb7k9whvvujoowAvpm9epESODRRy655PtKvgN+faCMSGizdgb40ah87rE2N4Kztz2DCBk4er2Btr2v100553IetX6GcFjEMJMkTgpbW63yKjHO/wcrjNapYW9Dh1dozfHgslNEtqprnZkoq5iK14i5P6LdrbIE86uqKQyWzOC5T13ZWnTUmpDIrBD/qpcpAtC1b6BUq7dOcmZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 00:10:34 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:10:34 +0000
Message-ID: <7f46c837-fe05-bb61-6247-584eed27aad2@intel.com>
Date:   Thu, 22 Jun 2023 17:10:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 20/27] cxl/pci: Add RCH downstream port AER register
 discovery
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-21-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-21-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d836d38-dba1-4e60-70dc-08db737e4384
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNOtZJwXCnemrq7rvLfOQMqEqJa3SUlRABQNMZySjon4FHHGKU2XIi9rTlA33x5QsFummiUXfCFg3pk2yAr7vWHSIK2QVihqjfTaH8qnPbmpO+fpsKA+L5kXgftitqxjBOXOvMixf2esmTB+ji+vV4aWR0lrgGfKU3lIs2QZ2vhbiCSEY4GFQnzg/TliOvCHD3k5bOR4aakHGxfbMs/XJ5+kR175Ipo9O0JPfDwKNmEqJqUiY9JA4MX+z735gmO/QRLzZUXUeIuhC9ty0CE0bS4MsGydfSnHnWhnVHqgIqbqr1nDSRzv2kadavG6F7BKOk3w1IJe3T/DrDvJ7Hj6aOfpR/TYBuIOPQ2G6VIQbaQSMucXR3f/KyAkv93ChOqywwNxDbc0bt70eJLJ7oPWkD29/DyV48H6mCadqL17wxAGpgdMItyjbZvIP62ndc/ZUqOYHEP3xF2iXTcX8wIuIOYm78mYwf+3RRvWo7tWcrD4QmMjRtxwf8M31NU+yo3O/SlKuQH2Rl77Gr+M91U+gIt4W/tHLlwVzQSSc654c1qNnyMmrx4nI8L9yV4mejaACG/VWEkaDOWAk5GZFVLHq4gmdS8YavyOQAJ0OpJLeGDk4eN394lNUSkDgLAx4+vGKYQFiU1zgApxmdryHKh+MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(82960400001)(38100700002)(31696002)(86362001)(316002)(2616005)(66556008)(66476007)(41300700001)(8936002)(8676002)(66946007)(4326008)(31686004)(44832011)(53546011)(5660300002)(6506007)(6486002)(6666004)(478600001)(83380400001)(26005)(6512007)(186003)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRPeFpma2pwb056YklTYUU0VGFiaHdHc2d2amJIVVYyaDQ4bDJEb1dDd3dj?=
 =?utf-8?B?WlNsNXdLRDNBaEszZDc3dmRyeE04bzFHUWlibE5aZVJPanJCV2xhNHZlbnha?=
 =?utf-8?B?TzUyampLTjlYUk5JcWRZUU1NRDhTc1ZMbUhsVzhKa0NZbGFWZjBVU1VPTGlu?=
 =?utf-8?B?MDU1MlpsZVUydTAzNCtyZEhIcFIyNndxaDVRa0tnYmpkUklobERLMWRhVGln?=
 =?utf-8?B?MkFBNkEwUCtiekpUNXprRXozOU1vcG9zcE5naHJyTGVnZlRUL2NQK2EvUlpU?=
 =?utf-8?B?VHlIKzg1Q0VDMnFqc1BjenFpTUFSaitOWkZhU2R6QzdiNDJURTMyWHc0b2Iw?=
 =?utf-8?B?WTg2cXdJSWo3Q3UvSVkvWGZSSDFuK1Z2bkxHNEpVVEZqMFp3NFZwV0g4ZkE1?=
 =?utf-8?B?eTVkWk1TSHBBaHQxb2dCRFVhbUs3UlRrZGw0OUl4cVJKbU03N3ExcWkySUxD?=
 =?utf-8?B?ZkwxOTdHWkxLdVlXVjh1bktQeWpDQ1pIUEZXUGtQemViWmFUT2dKTGx6VkpU?=
 =?utf-8?B?dnVPaWRJM0IxVnFtWFdZNi9RM0t3V0UxcFZOWk1mdG5FclJidTBxZ1hnOWJR?=
 =?utf-8?B?aWpDZ1hPYktvM044ZjFNRjVLSGFpUk1pVHVHcldmU084TFpDS3N4L215TG9V?=
 =?utf-8?B?NFdYSnRhOUJ3UG5uYzJxQlZhaE1KQ0liTHVIS0FnMmxtNjJVOUY5RFI1YkEw?=
 =?utf-8?B?WlorbVltTTFXbXlIL2FibjAxOTN1U1l5Ynh1WHV5VEVzQUZXQVlmMlJmcDVR?=
 =?utf-8?B?Q3B1eG1OcDN2aWhOZ0FxMXV0OS9UNldTd0Jla0xqWkRLU2djeTlDcHNOdmcw?=
 =?utf-8?B?Z1pMcUJuaWdxVEwvcWVtRHl5MjhMNi9PeklxcHUvQy9mOFA5K2dzUjNyME8r?=
 =?utf-8?B?SStzckVHd1dPY3NUajlZS1EvVjZVS0Y3RUtNR1FqM2lRYndZYWhULzhoaHRG?=
 =?utf-8?B?V2dnQzNVVWVwRWtEVDFNejdZWklLYlp3T1IwUlBLZ2taQktpVDlLOHdNZjYy?=
 =?utf-8?B?SGFQVDBGV1lBeEVlV1NkRmRJcmtkQVJqZitXQ0RYU3p1NHNYaTVGbTZRWGh6?=
 =?utf-8?B?ZnZSdXo1dS91eW5qZ1pzdUhqRVhVYUpoNC9rRHpQdEREV1BIbzdZTGFFSTRE?=
 =?utf-8?B?bjZSRDJQUzBzYUdnQk9QeEhFQ24ramQwUWxRUTZaV2lGbDhJaEFFM29zNmtu?=
 =?utf-8?B?N3dPMmFVWlZFSi9TRC9LZHhpMlMza0FOdVg0TkpyK3hrRXdwWHF5Q0R0KzJT?=
 =?utf-8?B?M1VlR0NOQmh6QUZUZWc4bGlIWGpseVp3K3dMTms4V0UrU0w3bzFUbktUd2tV?=
 =?utf-8?B?bXUrS2xWTTlrdytYTGlqT3ZjWFEyd25vZ09pdFBKdU11Nkc5d0M3ZmtBdjMx?=
 =?utf-8?B?S3A5QXdZTGxxQXNYTFRybWZ5aGp5ODZWZjB5eThjakQxbWZORUZSUHhJZnV4?=
 =?utf-8?B?emhHekJBRFFuN1ZRR1hsbmJXZThiMlh3NWQxUGt5d1lFQU85VWF3eldraXFN?=
 =?utf-8?B?N1psNW92UU02RkIxdnZDN1BxTFNZNmdqNXRKTjd2b3Y4OUxvcmgrY2p5dnZk?=
 =?utf-8?B?LzNSNEc1eW0xdkJHUzNXMWVFc1QxNDdVcDk5N3N1cnhzY1ZSSEFnMzk1cTRV?=
 =?utf-8?B?Y2VLWXZqNTRzWDVIVnRjS2lUMkROeXlUNXRpR1hNMmhybW1NWkFibTBkQk1R?=
 =?utf-8?B?TFV5REl2aTVXUlg2S2FIMC9tcHdTcVcwYXVZZ3V2MlRqY3g3MW9pOEJmemdX?=
 =?utf-8?B?TExRbWN3dkVVeUNrbStQT3daT2NpZzRJQy9PSmVaeHJ4UXdhL0R2eG5HUHRq?=
 =?utf-8?B?a2dGbi8vZ2NJZk8yL1dTcWo5ZnZFRGI2S0VqVzdzbXBDM0ljRDREUWZUWTBn?=
 =?utf-8?B?dG1EM3RtWHRHamxlaGxGcC9JVFdTUzlMNW9wNXdYYTNKSWRtYnpsMEw3K3Bp?=
 =?utf-8?B?R2ZkYjlocnJMTlF5THBsMy9iLzEvZDd2NXBjWW0reDR1NFR2YlhVcEVhQ0Fv?=
 =?utf-8?B?QkxIZGFQaGlrOVdXSE13cFV5a1lpSHpnNzRTUUNUZStiS25GeVhybHZURkhh?=
 =?utf-8?B?VkVaT1o2TkhGaTFmd2RQYmdPVXZuWHVpTGIraStaNmg0amlEam9PbmJhUHMz?=
 =?utf-8?Q?Se95Ui4IdI18G+E3n9xOfaiDU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d836d38-dba1-4e60-70dc-08db737e4384
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 00:10:34.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6ATNSBIsrXT3cMiHyCS91fG7Lu2TXSWOUwiOcor5a1ZMyq3iG8i5R1uNIWncZu6UdA4TviMzsKOeXQn7Fe+nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing the error logging
> is the AER and RAS registers are not accessible. The CXL driver requires
> changes to find RCH downstream port AER and RAS registers for purpose of
> error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities and RAS registers because the port was
> not enumerated during PCI scan and the registers are not PCI config
> accessible.
> 
> Discover RCH downstream port AER extended capability registers. Use MMIO
> accesses to search for extended AER capability in RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/core.h |  1 +
>   drivers/cxl/core/port.c |  7 ++++++-
>   drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index b001669a5133..87467c633123 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -72,6 +72,7 @@ struct cxl_rcrb_info;
>   resource_size_t __rcrb_to_component(struct device *dev,
>   				    struct cxl_rcrb_info *ri,
>   				    enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>   
>   extern struct rw_semaphore cxl_dpa_rwsem;
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index cfae8307de90..37ecd756b224 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -678,7 +678,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   	device_set_pm_not_required(dev);
>   	dev->bus = &cxl_bus_type;
>   	dev->type = &cxl_port_type;
> -

As Jonathan pointed out, stray blank line

DJ

>   	return port;
>   
>   err:
> @@ -974,6 +973,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		return ERR_PTR(-ENOMEM);
>   
>   	if (rcrb != CXL_RESOURCE_NONE) {
> +		struct pci_host_bridge *host_bridge;
> +
>   		dport->rcrb.base = rcrb;
>   		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>   							 CXL_RCRB_DOWNSTREAM);
> @@ -982,6 +983,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   			return ERR_PTR(-ENXIO);
>   		}
>   
> +		host_bridge = to_pci_host_bridge(dport_dev);
> +		if (host_bridge->native_cxl_error)
> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +
>   		dport->rch = true;
>   	}
>   
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e68848075bb6..60b7ba7f4030 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -407,6 +407,41 @@ int cxl_setup_regs(struct cxl_register_map *map)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
>   
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u16 offset = 0;
> +	u32 cap_hdr;
> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		release_mem_region(rcrb, SZ_4K);
> +		return 0;
> +	}
> +
> +	cap_hdr = readl(addr + offset);
> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset)
> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}
> +
> +	if (offset)
> +		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return offset;
> +}
> +
>   resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>   				    enum cxl_rcrb which)
>   {
