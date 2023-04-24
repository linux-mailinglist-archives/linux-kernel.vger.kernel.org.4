Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671996ECFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDXNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjDXNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:50:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3D9ECD;
        Mon, 24 Apr 2023 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682344208; x=1713880208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dwhya9lMyO0ExAN9LpnV5VJ0gssIuNsSvJWOYNfOeL8=;
  b=fmKghB0Drj3M6JYz/UwIM4tp0XJ3/ZHXACM/USAm7bfWhITe/9Nk9ZfB
   slQxRgI1SOWbkHXRwRrqM1jmG9x/EwszZGBtlRzoUm9n1T5q9Aviq7+qR
   0KN+7DaTaoa7h2wCu/vqcOGyKF/GdJqUAVU342wlzIvCy0D4vtidqKzlf
   iHz+Lsj0GV1KAQop7VW6zyY7lZJd5sP1gYdvKfE5p7CAxyVvE0uhB7jZh
   yR917k4Cbyv7Ih0H5m5o+mhp62g9s9zHYQDKDwEYQMyvcMKb60xdMeRwM
   eVYVCynm+86Uy17s3Nz0EfZCfozBHD7HgGm6hFL67Cu3yaoRV/j8fI5wa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374403537"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="374403537"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939332988"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="939332988"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2023 06:48:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 06:48:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 06:48:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 06:48:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 06:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2hHkFMUPW75Uf5UXsrv9SrfWE1HP9L5/84ue142Dl3CEoGkFW5e9k0HmxIqg+CfGwdSmjYPPk/cxv+RTvXHMLbTOsqplK7XbNahVxyAXXm680/C5PNDILuP1ZnnFIaf8Blut+weuG3rq9wqE7opndkcFakE06XfGRTMC16yCACLu4xWQBSgtnrQiDsd24whiEB4sdRe4s9rZsV7BEpTs1LKmXJM4YKReUkxXk8b5OAUYfm5C2qcAvjplr09rYJmL1r2dNbGDslM5ymU4Es1FYSYaceaKp0OpGIISjPsr3/GtnaOOLBY2hREiwmDdDYBzYtWcogTycxyqV80q6vDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcp9STYLO2yK6BgKCtseqlqGb7m7fprOdiUKhmTwUmg=;
 b=fKdU7B6gizqUeRXsMdTX4BNkOKAj/flC1KQf/XTXiqBEYK/+aTEhe6l+SvVi5Qo/0hMyis9WI974UQZKL/qLbKzko7/MW5vQft1Z98ehhqXBb7iyf0/lWDNmo+ue+tj/N1jXSj8FDXknFjHXF/IdMJePp782k6pAYMiqvoLVxgZwii4Wi/i1xxELkvf7UA2hdovpJaFWNH8d2IeXRxW/xDJmQ/JVsPQxMXMX+5vt3UHBz0nHpBQ3IE4ObVbCSO6gBTuIjVlw662p+8r27bRu82CknF/tBpWW6kbQMXIYP6PApiGW9RLUjj2tbY5TKX7dQpmmaKxAlyyivGjufob6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5447.namprd11.prod.outlook.com (2603:10b6:208:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:48:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4c38:d223:b2ac:813e]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4c38:d223:b2ac:813e%5]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 13:48:18 +0000
Message-ID: <ce1c307e-b7ae-2590-7b2e-43cbe963bc4d@intel.com>
Date:   Mon, 24 Apr 2023 15:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Gong Ruiqi <gongruiqi1@huawei.com>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-hardening@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230315095459.186113-1-gongruiqi1@huawei.com>
 <b7a7c5d7-d3c8-503f-7447-602ec2a18fb0@gmail.com>
 <36019eb3-4b71-26c4-21ad-b0e0eabd0ca5@intel.com>
 <f5b23bbc-6fb5-84d3-fcad-6253b346328a@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <f5b23bbc-6fb5-84d3-fcad-6253b346328a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 69454748-e253-4595-5765-08db44ca8f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfnM/suNFEt9asxGVmy5fvO0F48tJ6O7MJq2LL/9CxXALz9jkC/DR7SwoJlyfX5/C2TLSLWXLMkyiCu4wnybHqN93AgvbUNBzcHJ5eHeRnrhhcEdMQYh34yj+kK0PtYZU29PgckhP88M/3AX3/LqIKUyczrY2GbKIpm9R4x7szuS+R1pd28H/1nQdGiwI6Tb5D2DXkAfgLLVA0bh93k9Qxdcl0cViu5+2rsRSS31lQofCSsxbZEohP7ghplH5ABCbT86nYWqhpCVCVva1lrxNncGWiJFAGNNAFeSZ/nDhRn5WKybDGJt+neCRqKjySB/x7lrutdyEIdXrScPZWfJw8sYXGsp/USJQK49VpqMDTTkWlR9Vsni5SoIYCTNnvNn1mvwP/y0SfyvewOUj76he6n9GQ2XtjSg6saxakDYxBR1CKXjSinN6OgYwz+bZoyPQ19LzyIzJvw29VxX7SztZfx0fnzsIeRoq5nOUHNJxAmG2L9rGzTOSI3i4rUdS2OzxQvhv3CmQTC6Sfk868c5pkTMXmtIctsPfr78qK/g3WoRyuvFWwX6ruigJaatNt74WxqjT535FXeCSY4dWNZl/xSWPRQo/kJ6quqW82m4imDbNKZxB0uAwHfnggM0BLCQpsrAwxovqfpViEI+wutVsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(7416002)(8676002)(8936002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(6512007)(26005)(186003)(53546011)(38100700002)(478600001)(6486002)(6666004)(31686004)(2616005)(6506007)(82960400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZOMGFneFZQVjFHZnd2SHdBeUpSUFl3OGtrV3gwV3ZqaG9KdnlwRVBGOEdq?=
 =?utf-8?B?SzRsbEdXaTd0WlZyVDRseHp3SEx3MHdTV2dURXM1anBHV1hNRUdMYUVCTDl2?=
 =?utf-8?B?am52WjNyMURPU2xYanYyZ0ZCNm42Yi9BWXNDbFlSNzdEbEgzZysvSjE4OFQz?=
 =?utf-8?B?T25qMGlFUUlUTkdxT0hBWmFvaUxEMk5SaGV4dG1DUGFudGdXQ24wWHhua0l0?=
 =?utf-8?B?MSttb1JYOEQ1YXk4ZGYraWgvb09zUTFRQ0h6NWNvK3ZXRkpBTzc2VnZJSU1S?=
 =?utf-8?B?MWE2MEhyYm04LzNsWDRyVy9hZDlpVXhsTFNMczJ5bDd2Wkh6VGtDamZCMWh2?=
 =?utf-8?B?VC82WEx3Z0RKM09hQVlGODFHSUZKcmNRTVFpTnFzenBDdGUyNnZ0YmdVd2Jk?=
 =?utf-8?B?Y1NQTmZETGN2bnlJU0RnZFhRMjlqZ3ovVHNUVDlkcDFUUjRIYU5DK1Y4RGhJ?=
 =?utf-8?B?RDFNN1hhOVVuWm5ZVWZtaXY0Ujg4QnFGVlAzYk53bnJWUjZKOEwrOFkreHlF?=
 =?utf-8?B?TG5INjI2V3pJelp4YVhOMkMzN2l1VUYvdllQa0hmY0UzMVBDNE9ubVBicFd6?=
 =?utf-8?B?ZU5PRE1hbjUvVlRNTytneXoyRTg3b2tjaW90U2lhdGZwNnZibnh1VmRqbS9C?=
 =?utf-8?B?cHN2VCtqcGVybVpYUlhPenI4RjBrclhXZy9PbVlWL05IZ1gyS2dqcmFqaTFx?=
 =?utf-8?B?RjE4ZFVwdnliUDlDeldNbnp0RVh4Q29TNHRmNk50M1VqYU5lY1dqM3FURTlD?=
 =?utf-8?B?TmwyYVNzYjhKZkpRVDMzWFdwM1FmWU5Rak0va3VjM2JGVWZzeldOV3oxNTRi?=
 =?utf-8?B?RkIyRHV4RE9pQU5pdFN6VGxocVVUZmlycHdnRWFrM1VBYVB5Sm1tRmU5bUpY?=
 =?utf-8?B?KzhPbG5vZWtUeUFqVXpKenY2U21saWNXbXNFWHF4aVNoSGJFWkpkR2lvWFRV?=
 =?utf-8?B?MktlQStCQlcwOFFaSFdnL0VxSkZteXZLVUMvNnJCSG5lc2tFcjgrVU1kQm44?=
 =?utf-8?B?V1pBWW9oSHhiMG5TbGYxWTFFYWtHM3hEeVZQSm5XMDUyTnZ2dnNtVm9vRHg3?=
 =?utf-8?B?TFY1UGtkYWF1d1RpOUJZWTcwN0Q0enN3T1VqWFNDRlBDODk3MmZ2cVpjMWti?=
 =?utf-8?B?c3VmTEZERlA0em12b3phRTBhcmZyVEUwQ2dkS2xPR2pBbEZQR1llWWI1Vk55?=
 =?utf-8?B?QUJJYXlaZVZUYm1UWGhWOEduaXBpMTRMSEdWdncyTEloaHF3c2JZRWdRTGt2?=
 =?utf-8?B?OU5BbjNBbmtvbHhISXZSdFIzNjlBbDBOc3hvYzNtblhQaUoyVTBjMGpkMEM0?=
 =?utf-8?B?UG1NcXBmV0hIaWdLYUxPYXc0RmxPb1I5OUp3WXZEYjhWUHdDVHkzRWZINFl1?=
 =?utf-8?B?cGZsZnZIQm15dTVvcGNVQlNGaXgrNHJuRmQwcXNkS1lyYXNMR2xWUkUzYmo1?=
 =?utf-8?B?TVZkbDVqaU5qeEQ3YndmZjlKc0RGMkNQdmUyZTZ1N3BjblV1SHdLUWQ0Nktu?=
 =?utf-8?B?Vit1VWJSTm9SeUhUSzZUd0FzVVdiMWFaMjRHY3V5Ryt0SkJySFc3YmhBQ2Jw?=
 =?utf-8?B?alhRYTNJeFVZb0JLYmd3UFVTcjF3NFZoSWpIM3FvUUVMTWNoU0RrSXg4bjJL?=
 =?utf-8?B?MVc3NmxaaEJCd1JRaUlPTUVjbVpZZmxoRXBsOXYwMEpCektod1RtQytHU1l2?=
 =?utf-8?B?OUk1SHhRSHMwbHpCSTZZZU1XQ0t0dU4yclFXSzZyVk5GalBpc3lDb3RJNlJ3?=
 =?utf-8?B?b21udjNwNnd3bUsvQ3g5UlRwZ292ajFxWHZwUXdQbzVyVlFkek1aQ2VUTFdy?=
 =?utf-8?B?YzcyMWRiU1JmVjV1YXhpN2xwYjY5Mk9hUm9naWxGU2NaQXJUamZNUWJJZk5M?=
 =?utf-8?B?ak81OFdCblVxbmZTMzQ0RTB4VGpEVlA0bncxL25ic3VwUFhsM2YxL2Q3SURw?=
 =?utf-8?B?WFhQQktMeUZxUXVWSW1JcFdkSnJqME1BeTFnakNqcStSOHU4TnNja0U3dFlh?=
 =?utf-8?B?QW9Cd3BxeVFLNDJYT3pzMDRRVzVjaEhxWk1JZzNoSkx0bmwwcHRjLzI4Rjcw?=
 =?utf-8?B?R2NmYm1MdWlVUklDZ3FFVW94MzFDUnovWk9PaGFhOUlUQmgxRVRTVUcwVlFy?=
 =?utf-8?B?bERGdkVNTUlkUVkxTUdoOEFYdEl4aUtUSTRHdFBSSk80MFI3NGVBajQwYWc0?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69454748-e253-4595-5765-08db44ca8f41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:48:18.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBEUQjZYgrSsCb4qLNjexKvAOM87Ta/ONZv5b2ppNQXN4EQ58SZeg4U13QyuF5BYlHthQFiBh/9nO2RdIb2vM1y/i8UBgoRucxenxkgvxQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gong, Ruiqi <gongruiqi1@huawei.com>
Date: Mon, 24 Apr 2023 10:54:33 +0800

> Sorry for the late reply. I just came back from my paternity leave :)
> 
> On 2023/04/05 23:15, Alexander Lobakin wrote:
>> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Date: Wed, 5 Apr 2023 21:26:47 +0900
>>
>>> ...
>>>
>>> I'm not yet sure if this feature is appropriate for mainline kernel.
>>>
>>> I have few questions:
>>>
>>> 1) What is cost of this configuration, in terms of memory overhead, or
>>> execution time?
>>>
>>>
>>> 2) The actual cache depends on caller which is static at build time, not
>>> runtime.
>>>
>>>     What about using (caller ^ (some subsystem-wide random sequence)),
>>>
>>>     which is static at runtime?
>>
>> Why can't we just do
>>
>> 	random_get_u32_below(CONFIG_RANDOM_KMALLOC_CACHES_NR)
>>
>> ?
> 
> This makes the cache selection "dynamic", i.e. each kmalloc() will
> randomly pick a different cache at each time it's executed. The problem
> of this approach is that it only reduces the probability of the cache
> being sprayed by the attacker, and the attacker can bypass it by simply
> repeating the attack multiple times in a brute-force manner.
> 
> Our proposal is to make the randomness be with respect to the code
> address rather than time, i.e. allocations in different code paths would
> most likely pick different caches, although kmalloc() at each place
> would use the same cache copy whenever it is executed. In this way, the
> code path that the attacker uses would most likely pick a different
> cache than which the targeted subsystem/driver would pick, which means
> in most of cases the heap spraying is unachievable.

Ah, I see now. Thanks for the explanation, made it really clear.

> 
>> It's fast enough according to Jason... `_RET_IP_ % nr` doesn't sound
>> "secure" to me. It really is a compile-time constant, which can be
>> calculated (or not?) manually. Even if it wasn't, `% nr` doesn't sound
>> good, there should be at least hash_32().
> 
> Yes, `_RET_IP_ % nr` is a bit naive. Currently the patch is more like a
> PoC so I wrote this. Indeed a proper hash function should be used here.
> 
> And yes _RET_IP_ could somehow be manually determined especially for
> kernels without KASLR, and I think adding a per-boot random seed into
> the selection could solve this.

I recall how it is done for kCFI/FineIBT in the x86 code -- it also uses
per-boot random seed (although it gets patched into the code itself each
time, when applying alternatives). So probably should be optimal enough.
The only thing I'm wondering is where to store this per-boot seed :D
It's generic code, so you can't patch it directly. OTOH storing it in
.data/.bss can make it vulnerable to attacks... Can't it?

> 
> I will implement these in v2. Thanks!
> 
>>
>> Thanks,
>> Olek
>>

Thanks,
Olek
