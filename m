Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6365EEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjAEO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjAEO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:27:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3758F94;
        Thu,  5 Jan 2023 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672928834; x=1704464834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NjjZlnbOHb+S9WnejevnyDszhMpYYiDCNfewYWfBFWQ=;
  b=l6oehtsI+gxObXqTKtQfRR1x5CiCCvpAZdouMyev/xdv8DsB8tOJKzmZ
   gKVXd4uyjsr673EeMxz5FNneevZo753ioYCIeWgaYFE8Pll09TUGX+5WJ
   r0fmj2knBsD2A5Gf9PY6DocmGk2iDo0zk7vOcPqHUCzZYacQ5Pqe+vyuR
   /RWJlqWk7RYvsLM4owyw1fbllFVZauWdF7RQXP9OatDwuvYHJsnnEDV/0
   7LuKnMe4CxTLo1fzuFAkSuYWdEZX7t4FEDN+ayw+KUmmjE+GblCBfhAtC
   DyB8sJ+GRUtAJA8jT6pji6910jE5VC6nOVA9zvA/klpug9Bk5pZKRAdBS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320924091"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320924091"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 06:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687927246"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="687927246"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2023 06:27:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 06:27:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 06:27:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 06:27:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 06:27:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkftGO0BZkxad/J0olDL2NLFiOUDib9w0QcJgOwBHXgygJfXDbXskAMxkkuugnTHS/tdGnU9THrZCv+IJdeoI8HZWt9d0WAN7NHN9KIvNLBSeY3vsycxhAS4H8vXZLVYGEWO98HXOiAIaq67RGvyGHZlftJRcT14/0fRiTEvUZ5Ieh67YelA28LqyMcZ1dkwZaFgsEBAHKG97BzTzHnFHH1XVL832S5O8IXF68IK7/Y0nobj/EVLTvBMc6ISqw3G9L0JZry0+sGAx6MxjqJzk3j3HtpXgWyiar5kjH25rxKH5Mt87jT6HO9O/1v+cAvtZu6mT9NfO6XxlmAFl5trMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMBBgx95++Si3nvYZ59EbztEAsXjXfeZzFPMJ6svy9o=;
 b=BCswQg1/KnmjrWDmjIuDIgEnVCmrAhlTdgYtRc7ATyeTRmiDZOmE/nO52IOpj5X8kyw4T7LbqY1smYfrcS4N6FL7gkf5l+EAr13hg26raBpfWBSNh8q4tf/95EZXZki1rkowNukf/ppfhfqfaPfTWO9AU8Uc3ertyEz7xkoxfyH9QiDJzYTFP7V00+IMewt3BqXTbQhdGs2IrI5BG1UvhDi3lY8n/ZqbVGQDeG2ugZnFfqWRXhvTlTklzhl33NyWLwjYKJm/VX1LO3LuqLum4XmA2c4zudV7HBwL/Ob2sE4GPBrSFDGPL10MPQzOgBaIzalv4SQYrUfIjjEcij/s3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN9PR11MB5498.namprd11.prod.outlook.com (2603:10b6:408:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:27:10 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::61cf:8d4e:a75c:9389]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::61cf:8d4e:a75c:9389%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:27:10 +0000
Message-ID: <bb71721b-ba20-90d9-df35-aff3c175194e@intel.com>
Date:   Thu, 5 Jan 2023 15:27:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230105101054.108ad186@canb.auug.org.au>
 <20230105103519.4e849420@canb.auug.org.au>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230105103519.4e849420@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BN9PR11MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 598ca375-e095-40b7-1ba7-08daef28ee4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nVJJyKnX3ck9hKd3xCO4wBBMGK/WAyZufkT8CKqaQRYBctMuQFODRNcyQG8jCfxCqBbpCP/N5iYmxvKmNkDAeQcIvrRMo6VethDE5BuPzG5jP2Ux49rz7pmynkx6LGzX54uGUTj1pVPR0zG+EwiJ2fedZVIDqFtX5IBceUirr8gCemi4xgsf/9uTYWfW+Q08Znc05oJjks2+EpYEEZbnmLXGExkgd9saHaSMaTf/FRYLBXUVHOAluqDsrQNU5V7X3DjU+9LWUEo+hd1vF/LjTQVAWpX1UyD85XXgXKJj12kbk3YsJVhFOmhcV+R/dOgVdnXdE6E7ZMG0oGPjGyU4HNbIqFOd2l1YaYUlWkCnvVNOAbvOUGlLyuwfc0o8UXzHxWVWhxhT39sE2aEGRh/Nk3OeREW/vIQp6MvPuWga3s5tI3a1O+OiXTr003Z03bdslmeN4rli73z7EOUPBTrWl38E+xKgdDnDI5kZDTSRelj2KlEaokpyrP803IbsR8BCpZSrhqQN5d1+dnDiRJA8RHcQg2f8Pe0L0kfYi2S9xCQVfN1n1t8yswqjRAoqIcLMHmzZWnwfWLTpCTtivhfVM+6E0kwond8QVunR0JdGsd+Jfxq1UQf2JVED4IpaQ9YWicsOluTcJYIEC1pCquyggxB8RWx+/Fo2QHQYlkaLoWi/gcK3gAYCMWUK2X4ubH9bQvd0OSxZiNX9JCVv1ub8MJ2X5afzBXO3cuntIvaAF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(26005)(2616005)(186003)(6512007)(53546011)(6666004)(6506007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(478600001)(8676002)(4326008)(41300700001)(31686004)(8936002)(2906002)(5660300002)(66556008)(6486002)(66946007)(110136005)(316002)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRqMzU1RmtoM1Z6aElHVGwzYUlNVlN6MTB0S3Nmd092ZGpCbFk0dVV6SnBF?=
 =?utf-8?B?Y0t0Zy81MWVzdFltVXBiY0hoQXJpaUlzSmdIckdnb2hwYXY5c1A0d0ZzV2Uy?=
 =?utf-8?B?R1ZPRGV5YURnNW9aNWt1OC9qV1dGajVRY3FwWXNBTkdxUG1iODJRVWZTcE1t?=
 =?utf-8?B?a2VGUkpKeTJXN2NSUWhnaS80LzJ0OU9hR3E3cGFUMHpZSVVBWVFnZ1FkcHMr?=
 =?utf-8?B?dEdvWW1KRnhJRFRnLzFLR1ZTSFNHZUdDdzk2VVoyTVdHWnBoVU1OaDg4MmVu?=
 =?utf-8?B?eTM1K1FKMzMwRGU0QWdXM1EraStzWHRCei91bTc1ZVRBWDZsNkQveU51NFp3?=
 =?utf-8?B?WnNYV3JnOUhjZjZtVkZmM0FCUUt2MmYyV1ZBQ2x1eWhYNTdFWkpvRkI3Slpr?=
 =?utf-8?B?RU9mNVRxNzNFSFNBODExaHdTZFYyL2laT3N0UlFqWXg4NUNBZndhd3NKeFBu?=
 =?utf-8?B?MUVVT0V6WHc3UXdXZzZHR25ZaHBDU1pDZExpZnJKUGtpNEUzcWRrTTU3Z0NK?=
 =?utf-8?B?RlI5WktKWFhBVldMQnovRVkrYmtLS0QxcEI0T2xsdFQyV2xpdUkyajY0S01S?=
 =?utf-8?B?V0dlSm12RXJoUC95TGRieVY4akpTbHVneTdLbVJ3d1NMdTY3YzdLTG5iNVdo?=
 =?utf-8?B?VEJ5ZUxPOVBhaHFrVHZKTGplbzBnd3JWaW9QdkJob2YxOEJpOUl4OEZNMmZm?=
 =?utf-8?B?djlMSHI2Qks2ZGtQSmZIdFNPUy9jczFtWis2bjNCaVUrb0JzWlJ3VFlVbHRD?=
 =?utf-8?B?TjZiSjVwK2pQSkFYUHZNYXB0eDNUbFBqdVJwTUFvUXF1NFNsbWpvRERRQTVj?=
 =?utf-8?B?WERwNWZFODdyOWxKc0N3Q3dvR29nN2tmdU5Hd2ZWejNwelFkT012S25XMWJR?=
 =?utf-8?B?K0JaQXBLb0VUWEVmL0tJR3ZKbDNnMm11ZklpeXJhUk5Ud3labjJ1cDdzSG9v?=
 =?utf-8?B?dzRSSVRSbk45blljR085eDd3QnhUSjUvZXJ6NnFpWUt3a0J5TllITmpIUWtn?=
 =?utf-8?B?YTVOVkdFSldYc2o5ams4QTFBYzVhTnNoNHV3SVpKZ294MWhUeThmNHE0SS9F?=
 =?utf-8?B?ejVEU3FITGJ6SGZldmFJV3FYWHQ2enRyTE1mQWpZZHlRTm82UkRsRGpUNS9y?=
 =?utf-8?B?ajl2YUJZdURFMEJVdVF1YXlTOVN1cXEzVnFEVWhxc3ltMGxHT3k2bjhOTjdX?=
 =?utf-8?B?bWtoQVl4YUc1TFh1R0xiUGROVDV5Q3NDOWdjbDdkNkM0K3c2Q0lVUzhnSkQ1?=
 =?utf-8?B?YXA0WDRYcGI1T1pYTXNDdG9LNTgzK1NvZkYwVkpJS3pQczhFUm5CN2tHZTV0?=
 =?utf-8?B?cTA5UnpuSTB1d0paQUdyVDNQWDdBTTkwUU1jbVZwcTFwdDQzWXdsS1RQVmhY?=
 =?utf-8?B?WnIyZWEwNTQwUnM1MnpCdFp4ZXlWMnEwZEpkRkZEVG81dU8wZ1ljVmpWYUlL?=
 =?utf-8?B?MXU1SmkyM1BIZkJRdzR1R05RVFR4bmlPSTRGbGFQYkxDYlhjVFpNa3NiRXk0?=
 =?utf-8?B?UlF1R0JYS0ZraWp1NE50ZFRjdHZ6MFkwa2k0WS9Fd0sxUHFuQnJYZ1JWKy9Z?=
 =?utf-8?B?SmZrdWV6RDFCODJ4RjZib1NUb0E2UkljNi9QWG1JUnp6TWYzdjh3d3VGU1Jt?=
 =?utf-8?B?SUxmWkllbGdYZUdnNVE4Qks3bHlHK2J4akc2K0E4dFkrZnd0dVZVUVhBRzA4?=
 =?utf-8?B?L0dNU1JSbTV3MjNlbWxoK1VrMjVXbWtKUjJMU1doelhaQmxqVGdBbEVTSFRX?=
 =?utf-8?B?ZXNZWk1GUm0xMFVkTGlMTG9qb2VNbGlvT08wTnAxUlFUYTJYM1lnYW5zN0E0?=
 =?utf-8?B?bW1LZk5WNHVOMWJEKzcwTENaM3VRdjlNaEhzRG9VWW9YTTlheCtsb0tuT2xU?=
 =?utf-8?B?b2dvWnRvcnpCRTVmNTdTWmNXYS9LRTRQcGwxOEJqZ1VZTmpQVTBhUUpzdWFi?=
 =?utf-8?B?S2R3TU9GRkpiZURaT2x0eTlNdFNEdVhmYkRKUzFGZm9nNm01UG9ESzdydXYy?=
 =?utf-8?B?RDVsbnlteENkUVpydG5jbWhEdkt2dStQaGRETnlrbzB0Nlp6aUZMSGRJSVVt?=
 =?utf-8?B?WDhrM2lRY0tMNGk2SkFkOTl2QVlONGx1VzFNc2p4Zkp2Tlc1NUhGM2RBWmhN?=
 =?utf-8?B?NnllamE0bFV3Y3pJRHF1eGpmSkkwWkdrRVlwZ0JNa2RISFd2SDdHOFJUanVw?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 598ca375-e095-40b7-1ba7-08daef28ee4e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 14:27:10.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHqLB6lNGqtMwmL6/T6JkGRZryY+/K9hre3BKQq2PVUFsVKFwI5vRJiHWrGDw7B/JHQknthM7bWesnHMYHJsUwmvGk/YIHoDVEQYm8hoVq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2023 12:35 AM, Stephen Rothwell wrote:
> Hi all,
>
> On Thu, 5 Jan 2023 10:10:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Today's linux-next merge of the thermal tree got a conflict in:
>>
>>    drivers/thermal/intel/x86_pkg_temp_thermal.c
>>
>> between commit:
>>
>>    58374a3970a0 ("thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax")
>>
>> from the pm tree and commit:
>>
>>    03b2e86a24aa ("thermal/drivers/intel: Use generic thermal_zone_get_trip() function")
>>
>> from the thermal tree.

I'm wondering why the above commit is in the linux-next branch of the 
thermal tree, though.

It is still under review AFAICS.

Daniel, can you possibly create a bleeding-edge branch for such things?  
I can merge it into my bleeding-edge branch on a daily basis.


>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> Actually, the resolution I needed was this:
>
> diff --cc drivers/thermal/intel/x86_pkg_temp_thermal.c
> index 9e08d8c8f5fb,494f25250c2d..24c7774cc4a9
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@@ -107,56 -108,37 +108,17 @@@ static struct zone_device *pkg_temp_the
>    static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
>    {
>    	struct zone_device *zonedev = tzd->devdata;
>   -	u32 eax, edx;
>   +	int val;
>    
>   -	rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
>   -			&eax, &edx);
>   -	if (eax & 0x80000000) {
>   -		*temp = zonedev->tj_max - ((eax >> 16) & 0x7f) * 1000;
>   -		pr_debug("sys_get_curr_temp %d\n", *temp);
>   -		return 0;
>   -	}
>   -	return -EINVAL;
>   +	val = intel_tcc_get_temp(zonedev->cpu, true);
>   +	if (val < 0)
>   +		return val;
>   +
>   +	*temp = val * 1000;
>   +	pr_debug("sys_get_curr_temp %d\n", *temp);
>   +	return 0;
>    }
>    
> - static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> - 			     int trip, int *temp)
> - {
> - 	struct zone_device *zonedev = tzd->devdata;
> - 	unsigned long thres_reg_value;
> - 	u32 mask, shift, eax, edx;
> - 	int tj_max, ret;
> -
> - 	if (trip >= MAX_NUMBER_OF_TRIPS)
> - 		return -EINVAL;
> -
> - 	if (trip) {
> - 		mask = THERM_MASK_THRESHOLD1;
> - 		shift = THERM_SHIFT_THRESHOLD1;
> - 	} else {
> - 		mask = THERM_MASK_THRESHOLD0;
> - 		shift = THERM_SHIFT_THRESHOLD0;
> - 	}
> -
> - 	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
> - 	if (tj_max < 0)
> - 		return tj_max;
> - 	tj_max *= 1000;
> -
> - 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
> - 			   &eax, &edx);
> - 	if (ret < 0)
> - 		return ret;
> -
> - 	thres_reg_value = (eax & mask) >> shift;
> - 	if (thres_reg_value)
> - 		*temp = tj_max - thres_reg_value * 1000;
> - 	else
> - 		*temp = THERMAL_TEMP_INVALID;
> - 	pr_debug("sys_get_trip_temp %d\n", *temp);
> -
> - 	return 0;
> - }
> -
>    static int
>    sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>    {
> @@@ -330,18 -340,25 +325,25 @@@ static int pkg_temp_thermal_device_add(
>    
>    	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
>    
> - 	err = intel_tcc_get_tjmax(cpu);
> - 	if (err < 0)
>   -	err = get_tj_max(cpu, &tj_max);
>   -	if (err)
> --		return err;
> ++	tj_max = intel_tcc_get_tjmax(cpu);
> ++	if (tj_max < 0)
> ++		return tj_max;
> ++	tj_max *= 1000;
>    
>    	zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
>    	if (!zonedev)
>    		return -ENOMEM;
>    
> + 	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
> + 	if (IS_ERR(zonedev->trips)) {
> + 		err = PTR_ERR(zonedev->trips);
> + 		goto out_kfree_zonedev;
> + 	}
> +
>    	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
>    	zonedev->cpu = cpu;
> - 	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
> - 			thres_count,
>   -	zonedev->tj_max = tj_max;
> + 	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
> + 			zonedev->trips, thres_count,
>    			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
>    			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
>    	if (IS_ERR(zonedev->tzone)) {
>
