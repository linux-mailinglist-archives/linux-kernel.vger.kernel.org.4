Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A96D5124
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjDCTSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:18:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49341FCB;
        Mon,  3 Apr 2023 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680549487; x=1712085487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5Xn+y/SuHRK/WOYG/X6Gt8dlcpua3DvBSdhlkd9rms=;
  b=Jr90yUgnLpHuAf2fCpmCnxIkkp76JtbLRNAPWZ3tmGveGWaM68iEVvo3
   TyhsZq9eCQH2j2iI2w8iyfPm3OYDDkyIHduZPa2KiedQELoxo9o0mlUyo
   LBR9MKe84GcJIbYyxQPP68s039O2jIlR+Uh88Jg8DTICaItZIOm6r6/sI
   vOrEm0nxF2kru1hExKdXMxqJi7DctFCW6vsNwG3tYp6QHyLQudYUcxrQJ
   ehdH1wb6AxjlR5sEj2IartEwqM6rFXbwVUTyN3d6FRerO2iaa3YrBtLIk
   mXM4LcOVy97Deg+1asopJulDxMcyskrG4A/Q+pEiOMUyHe7KeF8PIG4eA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="343690632"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="343690632"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 12:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="686095404"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="686095404"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2023 12:18:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:18:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:18:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 12:18:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 12:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQPi4YaVcXohumesS/1w7nRB64AA0dUeIhU4/o4rXlIHYv7tik6wp8JkbgmoRbJ6jB8VUMZKfTGHWXD8d6N+GJLpXtDs+1Q0SVE0xlfRc4JP2BSzZGPVRjUHkVjzV7nI0HecdaKC8okhetxw43yntoZo2OhXpNjKgWkuf+rK7RimKvQzp5SyCESMeBwAlwp4MeQmFUuCoz6nC7PnPe8MjCmfYwzSyuwE5O01WK5QqHNnWkPbLlbfzRR1cCpjeYMtMX28CbtdYVMtmr5GE24zpBq+20TgU7F4dBflduAtWF8+vGarcUmY/GGW7mc4gGobGIqv/6Y6xPvBbBC+Yka7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUzgRmmRIstmZMzFZvQobb+HrPhHjzOPsLSSWFLZUbk=;
 b=oe34O3deCnOS7xu1A5RjONMWpogNkfqAUBoDikAD4cbyPxEEOiuYVnv+8OcBnbT8/tUAwciocYHWRNmdh+AAbcEbL/HLN9W5jwwIRp8p4WME7njvnkdxN4X7KwjO6Ksiz6snFjjeKEJy1pRpHENZL/pl1uxqZAUSVtaC5yrCj13MUKZZX87RWnjB4XHIUCtjeCVFr1zb10ZmG/93bA2JQWEjRGN7goonu2ZAiQyIl1PqQqmprhgCrpoEHQQejn+lFfhs83IUtLvz7/hSWKQEeLkAEWCVjjYt0pZ8ZCggG5vb6ayuceIFJ73lrGJD1DRJqPpfTM8h5AoC+Ja0Uyg5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Mon, 3 Apr
 2023 19:18:02 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46%8]) with mapi id 15.20.6254.024; Mon, 3 Apr 2023
 19:18:02 +0000
Message-ID: <261135b7-6d81-d330-2beb-2473d9d4a36e@intel.com>
Date:   Mon, 3 Apr 2023 21:17:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC] PM: runtime: Drop device usage only after remove is
 done
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-pm@vger.kernel.org>
References: <20230402103951.2510773-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230402103951.2510773-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BL1PR11MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: feab9d44-0188-4706-271a-08db34782432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPxRZNIk9YoCbZxE2BhFu4A7z3obW/VrCpgXA8zsxm84tZ5jVP7pMeTtGtcfhaynTa6dNlQsG3AELdjqXuCftzuiWOgyFjuWOkoC083TXsBSzdgnGDwhve+dBP2yttqnNCpukifCFK5QElNhSMZPg4FHa0cPjY5//k2UHoKMKNhtLJj6vCHJhRiMhUE3yS6bGTag/WaHiK/rjcu1HAAhi0EVaW5I0AIeZcMF4wr/1rf63kLp+g7Q8veXbwzi31PR2ZWQnQ4OQ67Jgx/arcgiydFH8xrf5WSJHfAOP91VwHggxVQXK5TPD22G5/ehSmMRqIuqACjmV0i0Rog4TfWb7MJefnmVU7jDyFGDtn9nvbz2CJZT0kUfET5/P1AosIOD8uNJlt/k2wU7bFjvbSecaWgS34mC1wcqSl96dcpdZvQCbrs0dZZYzUrVKlvZRGspbONqf9RWqzZvI8WKksS9oGUQ7eUx6ITbfxmbdG7yZq6p7Wd78y1ipymfY+hfvh/AdBkDKvwvliDlPDzE7tEwDhA5N/cEZ85FxscXqziPPqML8pMENanlkRotY/Oie32KWzmXc+0bp+cjOhQheTPSRZL32ynpLF5cRQ9LlHWKopS94rplES34Z8QdNWG46/CVyNdyudclI4DQFpHOU3qYCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(83380400001)(31686004)(5660300002)(8676002)(66946007)(66476007)(66556008)(2906002)(38100700002)(41300700001)(4326008)(82960400001)(66574015)(316002)(2616005)(110136005)(8936002)(86362001)(478600001)(6666004)(6512007)(6486002)(26005)(6506007)(31696002)(36756003)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJOUktlRjlFYWZHU3ppUmkzMllnYzN0TEpTSkxoTytMQ21DeEs1SnRFLzI0?=
 =?utf-8?B?VzN0dTZUUW8zbzNpMnpMOTIrdGdMMWNvN0xUeE03SEQ5WUt1bWUvRlZQbzNK?=
 =?utf-8?B?TE9zZ1p5T0w0U0ZidStZalJIeDBOa2NzckRUMFVOL0pweDZBVnNnUy9qd0hT?=
 =?utf-8?B?cy8rTHVveXZBdTVmZE96c1I4NVRIamZWNm84eFhpWnF5VkFWUWhkUEx4Wk1H?=
 =?utf-8?B?MmRFUnMvL1dwY0lKa0RzYW1pRVdTa0ZXSUwyZTlCY3NEMDgvc1podmVyVlVh?=
 =?utf-8?B?RHVJR3cxVkxMbGVSTFRaWFdLVnNPd3RHSEc4NGNzeVdPVi9BQk94OGlTTlB6?=
 =?utf-8?B?azRDMjcwVXlyNkxKTVBpV0N2elRUdlpLYys0NldvNXFiMHBjN2FSd0htL09Z?=
 =?utf-8?B?QUtKRWM0dFJZc0RqSVdCbVZBZ3dNQmYyaGRsWUJEWWI0ODR1U1M5VDIybnhY?=
 =?utf-8?B?RWhPai85cmIrcU1XekpGeStZOERxcFhFRW1DVGRHNC9ZQmhzSDhvZW5maHF2?=
 =?utf-8?B?V1Jnc2U1b1Q1UnQ5WHZsMG5iNWxwTmJkMFI2cEJzWmczT2lzSDJjRHR1WWRE?=
 =?utf-8?B?SjM2RUJrc3hldVN1c3NGTEZVVFJBYVJndS9pYUd2QlBOMU9HK2RwSUFNY2I2?=
 =?utf-8?B?cnZ1RjJldUFQWkFSdXV0UHdoQlVpR0EycGhkcnB3SnJyQTh5Z0Qza1gwUndT?=
 =?utf-8?B?Snhtb3dQaGpKY0dKUndQWWdHU3huQm1ESUQ2MUloaGZCUDFJN1I4UEZjYXFa?=
 =?utf-8?B?SzVtUUFWbUhSYzk3T1NYajhrVlJ1ZDBXNU9XZEtLbFRrL0dWWXNrb2lPOG5s?=
 =?utf-8?B?Lzg2MzRmdThoRkJEdVlVSEo0NXo1aFRVQnYrMG1SbGlucHo1ZzhuR0ZHSXNE?=
 =?utf-8?B?VTdyOWgwY200OERTd2RnUHpadVRoTm12dGk4U0UyZkQ0ZmpyK3J3eEo2V2Ir?=
 =?utf-8?B?WVRkalJBaVYyUFpKWkV5c2N6aTUwQjN4VXc3TWNuS1R6ZXpEcmJxeFNqcllU?=
 =?utf-8?B?M2lySWc4aHpCNDdTQUYxU0hGcTZNSlRpb283am1aZGFsSmlqL0o3b0JHNVpI?=
 =?utf-8?B?NFNIR1BtVXNBOFZ0SE9FR1BpRlNFSnA5djRGWWZ2QXB5ZS92NkREZGNIZ0RU?=
 =?utf-8?B?VVU1emJMekllYm5OeFZCaXZQdmVaT2laSWJoV0w4a1BOaDFSQm1VVUtwUFRP?=
 =?utf-8?B?U1F2ZGQ1dFFqZDMycFEzZFR6UXVYUG9QQ0hwNHk0ODRiV29wait2a2Y0SEMy?=
 =?utf-8?B?MjNBNFJZSG9jdEdmRGVXcGI5Umw2M24xT09rcFBwbmljai9hQWluVTBvdW5z?=
 =?utf-8?B?eEJQd0lZTHFjbjJ4QVUzOGVEclJ0dStBejBVdVo1OFoxMkVxWWJIQWdnZDBK?=
 =?utf-8?B?REZjbDNFajVQVTRFUVJqamdtWnZOMWY3YmxzZjkvSlJGTWJXMWZrTWpKdHV1?=
 =?utf-8?B?RkpWU1NFN1hYUkQwdGFqWHdxMWpOVWpvN2IxUkkrSERlMjhTRENCZGkwLzVL?=
 =?utf-8?B?WFRQR2tTK3NENWZ4SDVOam1NeXhqMnpSTG00SEYxcXpFdVN4MVNDS2ZtUUI3?=
 =?utf-8?B?NmZiT0xZRndDa2hkOUwzQVgwM3B4N1I1bkh6a2VYWEVJWUhGd0w2Ymgzb0E3?=
 =?utf-8?B?ZUljdE4xdWppdnBucnJCTTBGVlFBUUhkZkF4am00THJ3c1QvWU9aaXM1Wm40?=
 =?utf-8?B?SUVNUElWMGpsWXZpVDNZejNzZ3Q3TlBpRXp2VmFZQmordjNXU0FqczA0UGZ5?=
 =?utf-8?B?Z1VWNmVhS2lhVGllN0ZCNnI0TnNZMGVYZUljUTViZlpUQXNLVkVEamd4V2Fi?=
 =?utf-8?B?UUlpOVVkQkd4MEgvQmVwTzFNUndWTi9MQ25tUlNTWUc5azZpS002TUxJYUM4?=
 =?utf-8?B?dnVkY2d6RFlmZDRsVVRTRFJXd2svdXBYcTF1ZjBxMEZvZWtudnJmMlNWVU05?=
 =?utf-8?B?SEdDNmExc3R3aFg4NDQ3ZkhDYUI0QW1GK3pJayttd0Q3TWFQRFBCQjhhVUha?=
 =?utf-8?B?WmJ5L0p1bUNGMjZhNlJPK2NiTXpmc3E5ZDNHK3QwcndlSWI3R3NVcldTWmpP?=
 =?utf-8?B?Skl1a09lYTFwWmpnUTlneTdMOHNWNTkydUlza0VOdW5iQ1l4d1diU2lpMFdn?=
 =?utf-8?B?OWRrRmhRYWRRMFpSM1hKR1JWYlRHS0hLWXVtbXVVSFpMMjNrZDZCUmxxWE8v?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: feab9d44-0188-4706-271a-08db34782432
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:18:01.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6atnuEguhihJKZv0vWel7mDsYJ6Z9sIE/tO76J3CcyWcrhKo0d92HEZphOIMnmiFeD2DRGPpus4j8Cg7s8fPtF2444ReICdIF7oX9z/iAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC-ing linux-pm would have been nice (done now).

On 4/2/2023 12:39 PM, Uwe Kleine-König wrote:
> Many device drivers call one of the variants of pm_runtime_resume() in
> their remove callback. So calling pm_runtime_put_sync() just before that
> is ineffective as the suspend callback might just be called just to
> resume the device directly afterwards again.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this is a theoretical issue that I noticed while doing some research how
> pm-runtime works. Not sure it makes sense, so I marked it as RFC.
>
> Best regards
> Uwe
>
>   drivers/base/dd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8def2ba08a82..6beac141d3d2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1235,10 +1235,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>   
>   		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
>   
> -		pm_runtime_put_sync(dev);
> -
>   		device_remove(dev);
>   
> +		pm_runtime_put_sync(dev);
> +
>   		if (dev->bus && dev->bus->dma_cleanup)
>   			dev->bus->dma_cleanup(dev);
>   
>
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
