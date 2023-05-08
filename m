Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55F6FB64B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjEHSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjEHSSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:18:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEC5FC3;
        Mon,  8 May 2023 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683569902; x=1715105902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TIN/MAliZopfaCQKVBcTP0iU6r1xj4aAiotVNkUmmFM=;
  b=VZ9aUYB/YJN42OGVBCVU6Lt4w3T5bbGREbSL0B4AWxNqHm0Tq1cD6Dpy
   GU1hw6IqQZL/IXoFLefwpFQ0mzKmT7M65heKYQUBA0dyh0yRu0CrSRCUh
   a9tJAOpEXeCWJ2MNimVcVH5+80Eli9Qerv9kbYnoCThu93GOQmc9Bcd/i
   IfzldBNJpc6s9KG+kOmXXxPu8ZRvdLEPkFegqiui0S6ixyGUfTdDjxHuT
   BYfP7VQjO8ev3a6lF2uxxYMzaioTA3jUxwaKy6ZXDKzkVKCHSOA6+SuCS
   1K/YUGdVvLPWoGxNpjrLazxOpbsKnPmsi/BMWb/xCG+oeQUbpG7ydH20Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="415283495"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="415283495"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 11:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788205487"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788205487"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 11:18:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:18:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:18:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 11:18:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 11:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICUtO9Od3VavMYKE5CCOJCa+8mt9WbzCjzLXXyRzcg1rGkLs4mBI3projtuFZ3OfNXt1vkr3bv37/NcwjxGltptNDRyK7Pi/z0vVF6vXx5Pigc/jZOaZF645EKfF3w6DW1sdIiJv6c0PGAfBL9smUXtwUMFzfgohJKWlQpT3NslCOFgYPPUA9gsVJLa2Ho5ZgMRL+QFVTG0TTlGbj7ln0auJTE3H/MbQ006krcAFmpuKhzB3sZzx0kGISA6Vk/Ox2N6xHp5/0/AYxh5+5Fg6WNnfEjOrQhBzg1xGjVASxQrcDsPVsBmscYycT5K3dEh7AeXYw3Xwjg0uA+vns+D/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkNDIzoeRWzvDRpB+jvfwQXIV6RGKmlT3qRuCr6FZS8=;
 b=YhToZ/S18PuLp+wusk47s9/yaD4IpGN80yrTtfaScX4bhnoJ1fvmmpOAplPGoczwmM0g/4cGtBuvtnhGDUiwhmbdM+hxEHtx20q8j8QkJ9+wDiW20y1nyM5oyj68nrW9EmAOXH3fKjbqG7cIRmzQF8QgI2Z1UlhUrp+j5zftpVNUxakJmmTWwsuBlPu4WVM100KA/4Es841EB95OqPG1qJpSbKrOBg6bQPVLGAiitks94xZKbtKxzMFr7PJMumevWn/Zi73kbl8g8WQLQ/WoEb2Oj4TssN2OMwK8WgW1XUnDwz/eMR+aiZl3wbaUof1+w1z986L6SbQ67OUZJYxwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 18:18:17 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 18:18:17 +0000
Message-ID: <90ce2028-dfdb-9b9a-24a6-9f9210cedbcb@intel.com>
Date:   Mon, 8 May 2023 11:18:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 08/12] x86/PM/keylocker: Restore internal wrapping key
 on resume from ACPI S3/4
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <bp@suse.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-9-chang.seok.bae@intel.com> <ZFWMwQc4NKg7ueqG@gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZFWMwQc4NKg7ueqG@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: ed718c69-7605-49d8-9f41-08db4ff09883
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DrBZnYs+qp2unAhOBMmdr4D1jWBo2YkCjfxaZHwHHDxP8Y6ccsMc4aErUcEIiYlwQF9WEchInPUG85DD7sWAxsP1bxlbATgYQ65YGaZ87xWAacJyPRuYdCoxG+4DwsihTsZPhCAbnJ1mrH92vR2Z1TUhskqnum8A9V83CZTbp87WUQ7bgcBr7tRtvCye3Qxi5OjblMp3wLcnYbcUsDBDYCAiwgE/ZlzILwmyuv9oR8Z0eh3fM71TzHJ3RMc6NBiXABYVuZbyXIXk9uPzYZark5LYZuTaVrpe4gKo4Ie2CFYDrtCU/OcjnLBW2EwlsT15x08z9MuZ2h7xJF4ZL9w8btC/Vn7kfUwU6yKrobwFZ1Wls/JyMRYcUk2qPM7KYriNY7iuykvzT8LncGkNNWqnAeG9nnAfwRxXp8MCGqXOG/bBeyvrIMgtKaFHr4eD60F1dz3ao/zIPnAAfP7wQXpS2eYWCLBgCJxs4ssMloyjadSCm3PqEQbhGOM1eDWrIIP25e8EesW5C8Ns+2ZzXKyarhAhk6gmynk42QCk48jDIrMwckB2wXLzDzIxLm7VSVbIbe3R5FeJkwKN1X4OZWiuXMSt54qqPy3hTnmN2zpWCk2M80nXA9Uye/NJXRI4ARwZapNT3b7nB322mMms1GlrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(2906002)(7416002)(82960400001)(36756003)(38100700002)(478600001)(6486002)(6666004)(54906003)(31686004)(83380400001)(2616005)(53546011)(186003)(26005)(6512007)(86362001)(6916009)(4326008)(31696002)(66946007)(6506007)(316002)(66476007)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhNeTBicnd3dXdidXdtWEdqK09HUkpJWkIvM0FwSWVIUzM1M2xUNWY5UUZF?=
 =?utf-8?B?bmw2aGlpcGVpbnpJVU1VVEp5WFIwWEF0d2tBaERObWpXS1lEMmk2Z2gxNWk2?=
 =?utf-8?B?WHJXVTZ1QWt4SU1JdUg2OEZ0cHhsN25pVVNQc1dFbEFMTkdUeEtDOUluaFFr?=
 =?utf-8?B?cjZYUUlLUjMwaWhpdkZSRzVOU0QxMXJPVEdSNHN3anNhUkowR0pKU3Q0Ri9T?=
 =?utf-8?B?L0RCdTB1WDFuTThHWFBPS3VEdDdORHpjMlBxWmUzWXFTclRhbGZwcXZOYlJV?=
 =?utf-8?B?djBqcWxwcnhEQXlQMWxScXlkeGRlM0NTbS9nMXNJQUZBb2wrZmx0QmFadVVB?=
 =?utf-8?B?L0hEVUgrZElISG9MMlR6bE52YkJtWGp4clB4OUh1YlhlYzYwN3gxbjUwNm5w?=
 =?utf-8?B?VDlWSjVoYm50UlE1SzlqaVVNcThPTytNc0lPTHBNeHExcTRSODVjYnQydEpx?=
 =?utf-8?B?b1F4UzBWREgxelc1OHhKdmRIK0xHNXZMYWJJWWU1djR2NERjYmtlODJZV1Ft?=
 =?utf-8?B?NTZWSHdBQmMwOS9od0k5a3llRi9tbzFxYXpEVkxzUVFLOHJlQmFTUmNobngw?=
 =?utf-8?B?UzFPZkkxNVoxcy9oL1lKdnUxRkpQa1hyb09GNVJTMVFPcEpLWHkvbnNZU28z?=
 =?utf-8?B?RlV6OTgxcDhiYW43UG5mR1F4SUV5N1RCKzBQdmlocjA0VmlTWktoSnRSdGlW?=
 =?utf-8?B?Y3pTaTZ4Q0wxdE9Qb1I1TUFHNXpxaWFTZHV4NFI1TTBVKytDbnVseDExUGVD?=
 =?utf-8?B?Z1hqYTFsOVRCYlQ1Mk9DbDVDMUZ2TFo3WTNlTmhMRFNZTEkxdDl6YXUzOEZ5?=
 =?utf-8?B?WEhHNmpIWW5ac2NMWEdmc0dGeldGMUdJbytTS0RBYXBjWGRzQi9ZQjA5UHQ2?=
 =?utf-8?B?S1lCdGdQOWR5aDNyUWJ4NkE4QlJ6UUwyYUVNQkEzbXdCSmVNNVN4ZHZwZEhI?=
 =?utf-8?B?SmlheTBVaFRkemdlbmdjcUFCZkdzN1BOdkFzemhzcFhLbjkvQ2djY2cyRG1v?=
 =?utf-8?B?UjhJM0pRaXhlTVQ0elBNK0xoUEZnQlk0Nks2Mnpuc1k3SWFPLzFPMHlWWVJv?=
 =?utf-8?B?SGxoK3k0VXEzRTZabHMvQUdtTlptZ1NWZk15Y3h0TlBkK0ova3RxRlhSOFJq?=
 =?utf-8?B?ZUtMUUwrN0d4TENoaDc5RlRWSzJoK2lwQmRRcnV6Q1JNeDFqczFMaG5jOE9N?=
 =?utf-8?B?QjY3cE9QWms1TitkQ2ZMVjZ4S05LOXVmNUFhWmNMZGYrVlpsaStheEs2MmRH?=
 =?utf-8?B?bEx2L2x5bnFDeTA3UGdHcDZPRlNZRTA0L3RhM2tGSUFTYngvTE1UZGt2RWFo?=
 =?utf-8?B?K29UdEk4YTFEbnJzS256WXJWOHZiMk81c0pETlJLYzQ5dVJTRS9XYnY4Qm5x?=
 =?utf-8?B?eFRyTWh2ZnpvUUhYUDNwb3I4dHFsengyQzVoRlVZQ1lDdWhHZm9JVy80RWJP?=
 =?utf-8?B?bStMQzhhT3Q1ZUU0Qks5U3dPeXU1SmVYOG9yMnlyMVdFQy9ra05ISmlKR1JS?=
 =?utf-8?B?UVJkRjBzemJuVVdLS2VJYm9jaDVGOVdUeUxMQXl2cHU0U0FuNTBya1V4WUFo?=
 =?utf-8?B?MGt4REJEZElhMFpMOURzd0o1SGY4RVdMSmhkMWxLakpHWEVmSEtZeUI1bVNk?=
 =?utf-8?B?SVVlSnVnZlEzZjBXMWtaOXd1OTBKY1VYeVE0TjdRSDZCVnlGdUwzcTZqTUZ5?=
 =?utf-8?B?TS9vRk9WSXIvUDRkbDh6dEE4TWRycWxtcmdTTDd5Mko5bFFVR2dvYlhqM0x4?=
 =?utf-8?B?bERZMlBhdUMvOUxFbkUzeWpJZ2ZhLzNwM0NWZjRUTE9EbngzbTd2OFhIL1B3?=
 =?utf-8?B?bHdEb0ZQdFYydks3YlcrZm5semErTWFtVW5Kdy9BSFRpS3pNaFlHMFZlUUxx?=
 =?utf-8?B?VkYyNFovVVdqdGw0SGsxbEN2ZktmeTNYczdjbkRFazVlRi92NDRDNUx2VFZR?=
 =?utf-8?B?VnkyTmhOOTA0ZkU0NnhFQjVTd0JJdHM3ZlhmSFV2bUoxeXlmazB0ekJRMkM0?=
 =?utf-8?B?YmpacTc2VnE1dEZrNmt1Yk5ZUTdkVGY3cGhFb0tSREpsbm9JT2hMMUQ1blFm?=
 =?utf-8?B?MXRwaTVEVEpoVzJpaTRUMnpSbFZxUVNZeEMrUGw4Ynl1dEVXY0ZOZnUvNzFL?=
 =?utf-8?B?SUdUQlpmbVpiVTNKWTJkSVllUDk5NzhXMy9jNGJ5VGh3VnNHZklYblU0cDE2?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed718c69-7605-49d8-9f41-08db4ff09883
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 18:18:17.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf0vl5voZ3upq7glWWubEEZaC6H3/fZrTIMGNdm+Lx2Ta6M7pBZDdml3Aeib6B3RDy9XeFcCQa3Rfnc7NxZASy4fGdp7OvH9H1DCY7Vi+dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2023 4:09 PM, Eric Biggers wrote:
> On Mon, Apr 10, 2023 at 03:59:32PM -0700, Chang S. Bae wrote:
>> +/*
>> + * This flag is set with IWKey load. When the key restore fails, it is
>> + * reset. This restore state is exported to the crypto library, then AES-KL
>> + * will not be used there. So, the feature is soft-disabled with this flag.
>> + */
>> +static bool valid_kl;
>> +
>> +bool valid_keylocker(void)
>> +{
>> +	return valid_kl;
>> +}
>> +EXPORT_SYMBOL_GPL(valid_keylocker);
> 
> It would be simpler to export this bool directly.

Yeah, but this wrapper is for code encapsulation. The code outside of 
the core code is not allowed to overwrite the value.

Perhaps, it is better to export it only with the AES-KL module:

#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
EXPORT_SYMBOL_GPL(valid_keylocker);
#endif


>> +	if (status & BIT(0))
>> +		return 0;
>> +	else
>> +		return -EBUSY;
> [...]
>> +		pr_info("x86/keylocker: Enabled.\n");
>> +		return;
>> +	} else {
>> +		int rc;
> 
> The kernel coding style usually doesn't use 'else' after a return.

Yeah, right. Will fix up.

Thanks,
Chang
