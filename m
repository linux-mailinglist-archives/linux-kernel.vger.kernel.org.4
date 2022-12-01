Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837563F916
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLAUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLAUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:25:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C3BFCE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669926341; x=1701462341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DFrdSRc9MQbjSFAz6jSFqaotfRqLw3+/7QMvK2Xrgb8=;
  b=ZolXG99nTYkg847D3TYs1P1EGia/U/QFwqHzYb7CrtawvvOHyi08s19N
   K+HFQbzN70yyV/KDd5Fmb05kiALqBc4HNtSDK5f5jdUSmd3J3A+Ejg3G0
   zTLpwGUMSiECAEJ5VNKIP7q2cAVmKEWzfsXfmYbTUkOFETrDworbCfHT9
   RZNW5XOdvplrpbTjDVWyL5nf5U0MJH45DNF9emhmfO0HXarx5iLKcl0E/
   T35gdm8iffMFLyP5x2ikx2+u0MZ3Q7TFvXYI7XjZc6ragD8iCVBk7969W
   KLahkhuDROnWg4fiyVfu76QPzLgSginICTHq8BhBB9hMdUH68GXVPYqSD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="299159076"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="299159076"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="638521728"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="638521728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2022 12:25:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 12:25:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 12:25:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 12:25:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 12:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvLiyb3dFJEprNN8BHHZK8QCJybTaiSk1/QDKw6cUKrM+Y1vEbI9VnF8bvaiCtLFsKyGsP17cbTMUVXZbRh5RniIkPnnLVjzymwa7QUobr8H4nC1Ky19tHYAg6nKsJuxQvUDkFBNHf25CSTPpQSheP2/2Hn9qdJu41fYUXkb+4fjezxobubm+dusFLX0WWxxvr4TyBPW24oA2ADUE8TJDcyeBmdxjtMs7kOsONzTnQ08EaDsUxeJedsyOuKPmg5ra4ndwPsJiTkv4hWdpFIvXcH0jjUp3/FeAjyQbnRRQIEDAupQr5unDo1F8TdaK8fZKhWnk2vKsuFrUswr5vPF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GELDTjWftQDcNzs4CtqBtfEdF6MuZn1qUYHiZG/gruc=;
 b=cOk6FUGqcMLIvLhtxpYwxJZiT8g2bWk14mVMl1c6rk1+3nKmrgmcvu/ck5FdxePglOk3ESv3gm36V1vLZEZKMvn4DtWhHoW6FbIZsyCQm2MWcG2qDSlViXZIyLc6MyBdmfNwe1hNMmj/HYvHtNDENegaGdi9ek4XqlQDPt7yAz7vBCVpycyffCK8nQAm1AuCHOuOf0xSrB0GsUsOSl8foqHCd874PfCQ4rUKcvJSnVXyUtUQfxt7xK79L1dTA8LvrtsKRyM2N0fAA2qvCV1isFypKZTnPq+5W96JYZtkTbQov+OFp5Jg+rfq1V9T6hjMDgaEMDGlO3G03vkK4ZDz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BL1PR11MB5553.namprd11.prod.outlook.com (2603:10b6:208:31f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 20:25:35 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 20:25:35 +0000
Message-ID: <ce7e62fa-5b5a-66c6-2154-31f99e9dfaca@intel.com>
Date:   Thu, 1 Dec 2022 12:25:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] firmware_loader: fix up to_fw_sysfs() to preserve
 const
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <20221201193057.1195255-4-gregkh@linuxfoundation.org>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20221201193057.1195255-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::44) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|BL1PR11MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a41d1b-6bc2-4ab6-36ee-08dad3da33ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FepnCZhj56u41P3WZzuU33chJje5zLBKwuaGoXKJNxuN6fr/5wi2jK77NuAZAk8l/N7XL3RLPcykjLnPHkga6GjJgKcf/+ol3PEBAtaqtRZ+1XAKLzTEKqfj2advxKFlmd/mxJs1rkivPqJL3Mdlw8pOyRcCc3kYixkd0alDNg1CVAPPI5ilJt+mvC03AxasEM917fY0Ux9AS01fdmMzkOVp+sSaQN38AmDzIwbwkU+LliZHiOXwJo7qc8clmAxtclPr1qXJQ8NrvMOe/03zUS7D/lbmnwvR10wif5cDKcr0DQ+2IVJkoL5G/Z37SWhdUQ3+YtGGeYV2PPI4MNQQIbulwVPoMWhqoWBFuD8eGjrfmXw+PsWBPPuoplPdknR0LJVuy4unQVspWq9pr+KTo9e6ymn4PNe9Dz8LKu31v6C0s3KDAIX/xMlbJIi/X2m9cfrchmBUSztRLgSsIqD1GNchTTGwzIFFEbg1b8Y0hi2e7r6vG1lFDGgE+xTHpFttrK2+iyyPrnex4dcbXEXNTURO0bywVQz/WydN+gkG/py6CwBgdOeYdGH0PikiB2SS0f1P3siVmg4QAdR3zjxfl/GPTx2aHXB1gDf7aC4TCGp0qbrRZbjlAv3JhUXI/Kn7AeCGh2SccwYOCfMWZ6hNGMuU2jzrb4+RXfHa6xgax/8KSFuah0qFeS9DVMsVTWPGpQjNYu37ihGpmnnhCJnuXYYoVbVWvm4mZQpiXc3B80Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(83380400001)(31686004)(86362001)(31696002)(6512007)(53546011)(6506007)(6486002)(36756003)(82960400001)(186003)(38100700002)(2616005)(6666004)(41300700001)(5660300002)(478600001)(26005)(8936002)(66476007)(66556008)(66946007)(4326008)(2906002)(316002)(8676002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndwV0tkTlBNcENvL2tzZTRCVTY1c0VKeDk0ZjdLT1o2YzZHUlJ3RDRLRENQ?=
 =?utf-8?B?WlBnS01yNXZPaCtwbVBFbUZLRUlBaEw2dmJDY3BkdG1lenpuVkg4WHVlYndC?=
 =?utf-8?B?TlVBdVU0NlFvWFRkOFpEdzZhbjU4V012NWZjaVhjY0pqbGF5Z3VicnM1a0gv?=
 =?utf-8?B?dGFSS09DTkt5Z1o1ZmM1ODh3SEV5Wlk0R0xWbDBGbnJ4Z3RxcmR3MnhHbWtl?=
 =?utf-8?B?c3pZenY1U0NlM2FSZjdlc1dmazY1eHZMQzNMaWRDdWtzdmhlOVpQN1JNbit3?=
 =?utf-8?B?bGphRE1QRXl6Zm9jT3d1d1IwemtzRGdJYys5MkZZMGY1eThmNXhYTU9ld21T?=
 =?utf-8?B?bkp4emtHRnNPVkpoV096QnZpT3Y4YlFGYUhYZWdib0pQNUJJcTFpVUk3OUdt?=
 =?utf-8?B?cjNRL3lXRjZQZU1HMXJHU3RGVlNsZHN6QWpRdG5BbWNCTXpBYlNJNWJzK2hR?=
 =?utf-8?B?WkhQSlZCdWhCZmpNajRyTm82TzlNR3N3QWdGcmZLRkdCU1RWZi9YY2dxNGdM?=
 =?utf-8?B?dmQxZWpCTWN0ZTFLRzQ5VFhMc2FuQjRMcnN0dnZ0alhYd1IrOTM2RVRJbGRz?=
 =?utf-8?B?Z1JzcTFpc29KUFZheVQ0akRrL0FmT2orMy9SZ2FZNGhUYmxuZGp0MUgySld5?=
 =?utf-8?B?OGdJenFUVXpLSm1xcldTcWxLRGl0U2E2UDNHcndzWWhyZ2RuTmNKcjBJV1VU?=
 =?utf-8?B?ZnlnNTFGS3BWWXhlVTBibnhKdjkzcmFqeFo2cVVxeXh4T2JaeXY5WDhRRVR3?=
 =?utf-8?B?aG9hM2ZybXorOGNOMEdmMi9YSWlVckpHME5lbmdUR1R2Z0c4c3VJNGVkN1Fl?=
 =?utf-8?B?Q1NCQlB1NVBUWlNjZ0QyNDBoQy8vcWdyMlVzODVEYUVHKzJzYVFBUGtSb2d0?=
 =?utf-8?B?WElZSnA3Rzh1NVhicXYyc2xFeTkvd3Q3enN3Z0JhYmNpMmtuekd1TXJRclVP?=
 =?utf-8?B?Q3Y5cHVGd0Zxd3JiWWdSNDJPVStwNWVRMm9kREU3WlAvV2RQVUZHd0Z6TVBs?=
 =?utf-8?B?elFaSWU4VkxuQWxmUFNwOFE0KzM5bUl2bVA1NjIwWFhIVXFtYXBERkIrcDlv?=
 =?utf-8?B?clI2MVVuR3crcFRwbmo3OVdKODl6cXQ0U2EvSFFzMjRPZi9GdjNDUXdGOExQ?=
 =?utf-8?B?V3FvejRaNlBqM21WMmd5Mm40b2h5UkUyQmdQTGVPeVY0SEdxNis5QWNxN0Nq?=
 =?utf-8?B?VUV2OGN6YndlTzhITWNGM01FWVBUR0w1VDdPUjR3UWl6T2ZWOGtRbVlQcDVx?=
 =?utf-8?B?SE9nWWEyTUFmazNKQ2RmRGppd2VMZlNIZ1JkQVlzMEc1ZU1pMTFzWmxHL2s4?=
 =?utf-8?B?OW1UWVJMWlJrUDdmaG9uR3JQN1FSUXl2YTJSVlgvOThGVEx5VzNQL2sxVWN4?=
 =?utf-8?B?NzZXazJadXJOSlJTK3BjYmVUSE5CZXRhTU5HY3E0b3F6SXcxdmJzemI4MGF6?=
 =?utf-8?B?ck9mZElxZitXNCszR2p5NmJYKzZFSWUyTmdWd0c1MzBjUEhoMC8zaGdBL0ZM?=
 =?utf-8?B?enIwM0NtUkRqT0xvMzl1OWFkWk9DK3lvdSs4Y2g3MlgzUWI1TGZUN2REWXdv?=
 =?utf-8?B?bkFLUGhwdXlueCtzTkw2c1VtdW9tWWt3ZDZJNGN2Y0QrdFJCMjlnK1g2SVY1?=
 =?utf-8?B?OUY3VnRFVXduaHJ6N2NRVFFJOHhUU3lIa00wZ2YvY282UVJ5aDN4Z0pFeXZn?=
 =?utf-8?B?aE1Mc0xFUy91cGsydUErSEVzek01VSsvbWJGZjVQa2x4Skd1NDJSaG8wYVZh?=
 =?utf-8?B?UWZ0UGEySWdLb3d5dkV4eE40dHRSc0N2andZZXRzeG5rUndZRmprY3NBT3Jx?=
 =?utf-8?B?ay95aDd0bkRoM09BVUNCM2tGeWM1dHlUU1dtMXpqTkFZVlM3bGhpOFdwWTRi?=
 =?utf-8?B?N21qNkdsTUJtVDFNZzNNTC9tNDNaMTRZbEFkRDNWMHd1NkVZdHpRb0luNVZI?=
 =?utf-8?B?VExsa0lwYUZCcUlMNnJIWThpODR3UThPNVNZVWxnaGQ3dmlTcGQ1UjFqU1BC?=
 =?utf-8?B?VmYwRzV2QUx1QWlHV2IvN1NYT3NyMW93a05NSzlmTXZwaitqUnhuL0tzVEtY?=
 =?utf-8?B?RGhJRHZldXhCMEZUd29zQ2dIWkhtbWZqTGhTZHZnWHM5QklaMXVnMVRtYmpv?=
 =?utf-8?B?bXYyZlNwZ0N5Uktrd2k5cnNDQ3VKQlRHeThIb1F4TTFqNlRPVWozQklTdWE4?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a41d1b-6bc2-4ab6-36ee-08dad3da33ff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 20:25:35.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJiJ4djHs0dNvQEaTGP8INIDuv4HZr78Xx6IJliDK79gEcncUEYv/66xFBFwuvD01tcXtRJfQLAsjZtgQ4MQMThDEyx5TGWYtezNK3g8QlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 11:30, Greg Kroah-Hartman wrote:
> to_fw_sysfs() was changed in commit 23680f0b7d7f ("driver core: make
> struct class.dev_uevent() take a const *") to pass in a const pointer
> but not pass it back out to handle some changes in the driver core.
> That isn't the best idea as it could cause problems if used incorrectly,
> so switch to use the container_of_const() macro instead which will
> preserve the const status of the pointer and enforce it by the compiler.
>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: 23680f0b7d7f ("driver core: make struct class.dev_uevent() take a const *")
Acked-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/firmware_loader/sysfs.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
> index fd0b4ad9bdbb..0f0b1f7bf335 100644
> --- a/drivers/base/firmware_loader/sysfs.h
> +++ b/drivers/base/firmware_loader/sysfs.h
> @@ -80,11 +80,8 @@ struct fw_sysfs {
>  	struct firmware *fw;
>  	void *fw_upload_priv;
>  };
> -
> -static inline struct fw_sysfs *to_fw_sysfs(const struct device *dev)
> -{
> -	return container_of(dev, struct fw_sysfs, dev);
> -}
> +#define to_fw_sysfs(__dev)	\
> +	container_of_const(struct device, __dev, struct fw_sysfs, dev)
>  
>  void __fw_load_abort(struct fw_priv *fw_priv);
>  

