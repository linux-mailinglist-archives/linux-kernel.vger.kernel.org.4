Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75205F15CD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiI3WJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiI3WJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:09:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F38D127;
        Fri, 30 Sep 2022 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664575780; x=1696111780;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5SVnzb7FgWxUm1RmMWdx/Dj36pBl/Xoa9mewdYRE+MQ=;
  b=Gw3hvEeTWV2uDT/nFd61CULmrxki/O4c7w7ggJEp8YNb4v628m87ANtR
   Z3knAvrLEUQoJg5ZmfUzqcgH8DRaZfnBEXgV7V+5leHaQA8J/gi0Ctvhj
   n/w/HQabBGPd2Fi8cptZutH6ETbOsN4ZCaIAGIfyKBtaN6LZ3TI94PFOf
   Qhmg9CY0XKA2bUfZuj6JFQZ0EeemicYoD+wLRR+q0IcdZJJ3OyUcQ4sUm
   BkvBHuZ/UKIXxuSHWwEEAX7QK8EygOAgVH881+FrUlxGel1TzlfM1UlUR
   RUJIC3ZuQQqfXDk2FTuQ/Ch/nLH39+9CivrjRgTn4soF6WMcAEIa4rT/A
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="364145413"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="364145413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 15:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="656102113"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="656102113"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 15:09:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 15:09:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 15:09:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 15:09:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 15:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAw3g66J5vmef6nPxv/+HwWsYNvnZuKs72gMOvAIcufX8Fa9aO2gRso2V527pAH+/3+mSd2d8a18Stci276Pqrvhmf7blcvD9QW2sXnXyRdagjDf4UUSjjjIDd7WgmQgL6dJ5aB5ujYnnGKiXKDsF/2zVAOt4x5qTwzC2mPjBLjyIULoDmn4jlWs/glUUgbo6r6shU72ob3DdksPwdVvueJm7UHhSmoSs4aobXf9ifJ9cF+d52o6nDiwbkgcC+25o8zsBMo8L3yOho7vlnepYLJFkVjBe7YNSwf1V+u3wcmdV0epZHkOR/YXm5ZaT86br/nAb7DpViuhQ9D6CX85nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw1B1ESmc1bCbD1W+VmLnwgh1zXP5FpCHXGHkOziL/A=;
 b=LJcaIbVVCF6gbvRaZt34S42IbEokGbfYs5CySteqyD1D/DUrB+KoImXMWaN/G4zN5cqnHa60x5+SFJt+/oN8T/CPZR9jhxCF8s4w7OR+lv3B0KymC4/xqdZfDCsGIMoJGbNht9JX9kEd88J79fB8u5UcD2cy0LZGBfocRRmPeSnYgCSa+IddZ8Ax3p0hG1xoMTisFXDT6OKM8akgyy3Ba69zMJyFaydQ7rP8UUrkBqm4LqbS4E+epPX+GEsN9W439uite+wPzr7OgDH3cpfqEbmFJ2QvWRUOyr1OZzz/iFgQBY7LQBCcCqn6Twp0f1CmKOAy76dwoU9u15+rWzdTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Fri, 30 Sep 2022 22:09:36 +0000
Received: from MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101]) by MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 22:09:36 +0000
Message-ID: <ab0d9840-07e3-ec49-a9b3-c4b65d7d61bc@intel.com>
Date:   Fri, 30 Sep 2022 15:09:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Content-Language: en-US
To:     Robert Elliott <elliott@hpe.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <jarod@redhat.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220930214014.37194-1-elliott@hpe.com>
From:   Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
In-Reply-To: <20220930214014.37194-1-elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To MW3PR11MB4764.namprd11.prod.outlook.com
 (2603:10b6:303:5a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4764:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2828dd75-c648-445d-edb7-08daa3307656
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8KuukVuNUvyecdLlrl7yOW6YBKHleQ+WxcZh6pL+XOADRJI45YjcEvJqoBBXXyWBKkD5itoHQf8XBSzjY5Aj4t/dFXyig1U88rO0EaImcndXhmnWpZqOKSYuwijb09GW8ZJZiIaSSvkHRoFUA6PW5NyjZX4reOklMIJc6aDxZUzCht2dGyFMJEDgcO4AkM6GKqAmkXAIEK7rakE7rxJbIw+M7zoyDqh8agjFXXjEaoQlto9UK/2Lq970XTFQdEa8rxNujJjZHW40AfOSPm2KTIE7/QCJ9AjWnm2Voec7whlhw1aRMcUT6yRxeVTe+S+I10W14NJYa6TFaURtMQlc1eqnx6xwiNmf+OMSa4WQhpbZYUc96g/Y241z5ALTDLZtMlcZ2e6uO+LOSSDtYnHo3LJO1BLujx4y9CW85lQgP9uqIBWGJ3PZm1lzReBlvqKUdf3ayUzVVmIkGunhzeqdP1meHiWgCe8QiZQvz/llfSMaRWCZa2NQLMXVwyYjIcQ21welzSzTTxC4ADUfWSczsYoSXasq2SNcxn0C8hvIYLQYKPBZgMJMju47QfuPNcvE895dN5y55AMSzTpPZztnkftuO4wtfb8rgrbh2AFWGxsLLeZwAODnk3eUGBqpsvxpR32itZneECbl9Zw1VNWzYZgWLACBUVUB96fWbXOuPMuv9PqQ1HnjRvVeOqbibVp1FkAuRKSfCiMTJnB2XUm8dCOpUAvU3klFbGxzYPN91iRW7nCJ01gdPj99yl2vayVjANLmgq1ZhqvJzbBfTxPQfuDfH0GOnuO+B7Zao8aO0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(2616005)(6486002)(26005)(186003)(478600001)(6512007)(296002)(36756003)(4744005)(5660300002)(53546011)(41300700001)(6506007)(8936002)(2906002)(8676002)(83380400001)(44832011)(66476007)(66946007)(66556008)(316002)(31686004)(82960400001)(31696002)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWR1VVJOZWdHei9iWkIzMDZNbW5VNUJZYkoyZ2U2VlI1djczSnRPYTFnRzdM?=
 =?utf-8?B?SURQWnRkZ2lselpxRHNaMG9FWDVPdTF2RDdGdlV6UGZuWGo2dTRTaThpOTZH?=
 =?utf-8?B?Z1hscWNBU3dFR3pqREpXMnRreldOUnVxU2x3UGlXbDJCWGlydmp4L2RPMW5B?=
 =?utf-8?B?dVBJc0N0cXZHbHVodHhFeithYXpjdUtyZ0toeTdFa0ZaMnBNM2JESXJDYk1C?=
 =?utf-8?B?NkZZZm42VE9aTkIyaDR5ZUcrUVpieHRUMjhnK25tOFNmc1JlUTd6RE5sRzda?=
 =?utf-8?B?OHllc2pKalJ1WUdUQ3ZyVVgwaVA3aW0wZ0pCMDBMamVrWTBjWjE4RzZHK1dK?=
 =?utf-8?B?V3RoOXNoaDdlU0RXeVhCUTRvcDA4RWJUWk5yVHB2Z3VaOG5SUmtCaXZtMUJD?=
 =?utf-8?B?dzl6VVRhY1RPSGNqYVZmdWNHV0kweHI0Sy9rL2NIckFlYnpYaEN1bVd4NlNu?=
 =?utf-8?B?WG4wc0Jac3pnc3FrR04zWUk0bjFTdTNWV3dvekg0WUt6VmRjeXZxK3FWT1hp?=
 =?utf-8?B?WlNGc1ZpRWxkWDdvNTBmSkNTMDdlQzB5SG5LNFprZllkQ0xFLzhXdEoydTg5?=
 =?utf-8?B?aUltR0xlbUFIK3M3cDFoOWh3cnY4WEdTbjkvbmIybjlJVVEzeHJqR29qRElu?=
 =?utf-8?B?SkJrS3c1WnVoQVpwKzNGZGY4S1dLRkVKTjJSUkdGckphemp4cmdtbnA0eDNv?=
 =?utf-8?B?UHkxNjN1M0pnQU9LME1UOTVjVndlcWtJRU1INUEwTFdOR3BmcURTWkMwMzht?=
 =?utf-8?B?aS9ZTkhNUjJDWlErU09PU1NhdmVUcTdMRHdXclJJU1RNWG80NGNYWE0wTkU5?=
 =?utf-8?B?OVNMdG1XSzVCc0JKT1pTMjZoTEF6Z2hSMFJ6eWlDS2VmbVoxelF1ekd4aElW?=
 =?utf-8?B?N0tzejVqNDg2bTF0b2pSSkdPaEYrOHp2eEFHRytWM2ZmaE91MVF2c1V2ZXRk?=
 =?utf-8?B?Q0E4MGFJb0NUKzZYRzZqWWpZanBmS2ZiNmJnTnlGcDdPem9xWSsxM2RXek5y?=
 =?utf-8?B?UGZhazZtWlJiNjMvQ2RWM0FXazV4MUlZTCtOZEpta2hqQXBQSk9nRzl0Kysx?=
 =?utf-8?B?QWdKZHdwSDI4Y1RtMHEzZFVrWnhvcmtVaXlGbnpNK1BQWjArTDFiTnhTdTR5?=
 =?utf-8?B?ZjlXdlZvYVk5Y2NFS2paU3RwMEluclArbkQ1YUN0VkUxVlRWdytYMnJ6bGZj?=
 =?utf-8?B?Rno2NmhHdzJXNXBEa0dJTVpXR2dZTk1kQU1lYVRvVmZKb2h6SVZQanpYS051?=
 =?utf-8?B?SjVvRzU1MDJLQ3dwak01TWE4UWdSQzlrYUlSdWlneFB0SGsxVWl1azNGSzY1?=
 =?utf-8?B?MjhnTmdYcDVwNkYvMVlGZWJkbUtKUDl2aHY4UkR4OVdGditlNURJMTRFZ2xV?=
 =?utf-8?B?ck5GS25OeUVnNTZlZW1kY2hzWnRaQ21CM0t5V2l3RnlKUkJTRTJRUUtVdzZO?=
 =?utf-8?B?UGdMRHVvdGFkcjJ6SkRuZzc4cVFFZUhyOVZWUTE4enV2M3BxK0V5bm9neTdT?=
 =?utf-8?B?YzZ3ZERmZVNJL3JkcmJUVFdRTEY2OTZiUHRsQUhBeXZEUUtxOWRSRWdYdkow?=
 =?utf-8?B?Z2k4aHF0UzVrcW80N2RaNEh2S2Q1akJLM0VUTmM2VWtlRWJ2S0tQWGxjV01x?=
 =?utf-8?B?cmJSbGR5RWRIQVAwVXh6QkFqM2czUi9FRU4xN2FtUGQ1Q2NzOGxETHBma3p4?=
 =?utf-8?B?eXRHY2UzWmp2Z0xUbEYzVkxTYzhtVnlXa3M3ajhnMXg5VWlScTRBdkZSdmIy?=
 =?utf-8?B?Q3Fjekk0dTM1NTlJU2g4QndnQXVRS1VnMVpWRk5KUzlCZm5BY3phT2xpVGJr?=
 =?utf-8?B?TlFQV2RNNTNTNHZ1dWFoRkxVM0xTeDhsa29ybmcveUVSWWljTktTMVR4Q201?=
 =?utf-8?B?RC9IQ0xaOFVlalhvK3UyaU5kbEw0bE8xVW96aVhtWXhMNXhUSFE5cldUdXlu?=
 =?utf-8?B?MFR1VitpRFE2K3lCL2pNMTN5RVB2aldmb0ZsYUZ4M0JHSEJCN205YUl0WDl3?=
 =?utf-8?B?VEMrZGN3YXc5NHFyelRiekdaSDl6Si9JVjFHM1g3ZU1DNUhlYlN5cEp2VjQ3?=
 =?utf-8?B?TEE4QnJZMGt1enJWMms1VWw3a1puVTJGUFNDOS95QVcxOXZjSythME1aMUxY?=
 =?utf-8?B?cWkwUXFoN0xwUFF1L2NPZ29VYXhlYnYrOFNsS25jNzZVY1A3RHhBVjFveldu?=
 =?utf-8?Q?3iKei26UMQh5uvSMaDO2mIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828dd75-c648-445d-edb7-08daa3307656
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 22:09:36.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKR9iwEj87JwhHtGWP5H1iymcHE/ECxQJFcLUB9GqAJQfW1dLsi4m7ZhZLgSMRaScTrPkBUoeb2jQy0I1Bk5kMYdPSjE3Ubgy9vu9x3h8lX89zLimN6sA744KVbP3olw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2022 2:40 PM, Robert Elliott wrote:
> When a test mode invokes multiple tests (e.g., mode 0 invokes modes
> 1 through 199, and mode 3 tests three block cipher modes with des),
> don't keep accumulating the return values with ret += tcrypt_test(),
> which results in a bogus value if more than one report a nonzero
> value (e.g., two reporting -2 (-ENOENT) end up reporting -4 (-EINTR)).
> Instead, keep track of the minimum return value reported by any
> subtest.

I am assuming this is for the case when fips_enabled is true?

I agree that returning the cumulative sum or errors isn't particularly 
useful, but how is returning the minimum error value useful? Wouldn't it 
be more useful to return the first error return?

Ani
