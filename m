Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2E6D9C29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjDFPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbjDFPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:24:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4B86B4;
        Thu,  6 Apr 2023 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680794653; x=1712330653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wxAYEhCIlUOwMAfaYCMOTezaqK/as3N4+zWJbMdcQi0=;
  b=cUP+8YXj2eN8Un1Ct4B0DWTCOTUFOXAeQfWrgfXrRwM2xKW5kQFl+fKd
   +3LLZ6nDvrPs/Cg+YRqgr3SvPYs6t1YmMzCmyUE8cT6WK57ET26XA1l3D
   rMEq4R5YEwnup3nn+h3hcGHkEShpguDQuCt2lJr5RJPgGfBASjNf9LeTm
   lpisyjg+AaU/67AxTYFFye1dTz9qencclaiwDkblJMD0cJE6NkKRuYGjw
   VGY8YmgnxV5AV2KrGOpLiTk8ZRecC7rr683JKgomxjZ6x6xnuH2oKhhcY
   G2LGvNJ9zJhL0pHly0cEUxb/8Jx/c82wu76B2gxYgg8ByloP/zUOVzwIA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="340253068"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="340253068"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 08:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="830791032"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830791032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2023 08:24:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 08:24:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 08:24:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 08:24:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 08:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVECSIEDOIhopA2ktUopx/7tcstmIZmRHnDDoxyGMNaCLSD2c7t9zcdYfCRfCvp6UEHa2/sSwJ+9CwjJFddgkwmyUo1qTLDGSRS7bVHD1oO99zfSK8IKOx9uB6vkCBFOut0vLg1XJSGu9SUZ6M8D2OauZXUa2ax6t14xljZGCGS86NFMdUyx120R/K3oYGURyBhxaxXBKGaHKWv9bModsHQnO3E8O4OPPDSTJI2wNypt0u4jhJ3BpsMulE72x+dJB/LJP+5gK6i2wYc2JdDoJbsorlLCCjDowpNjIjJxuW93wzPo9+fDlKyeqjgFSFVOC0+GrB/X+HkZajXiobEnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65G7t0spT+5STS+7YJpbMXbtIPHh2QS1Z+Q1lESwUYc=;
 b=XO2HJNGKtYN8NIhAxzS7/+aO65+q/+nqcclrbKWzL1S29EfxLJpZCgo+BxsJgZ6V0CLGMpvTuoX8hN2EnL6kqP9zOXt1qXeLWr1Qj6tQhWYYPQDr2b5IPYhZBSppLH3dLeiCeAwALOpM98VXMC8dP/5PR59NKgOzL38++s3ZDHrJMKKAVd2YKShxbP560018J2SyXu0hyTDxNl/9K6BmURteK1ESS+EUhDS7/RUL5oSNi3ajIO3c5rb7SweGWF70jSgv1IvvTcHZq8CrTM1L9M3/UceSXsyRkewaIlQGPJGv+tzK7FDdVHMMvUxmkheMm6/5kMl99Qm1REJN/WxpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 15:24:05 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::7911:de29:ded:224]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::7911:de29:ded:224%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:24:05 +0000
Message-ID: <0ff0548e-7348-d6cb-75a5-838a110b7d82@intel.com>
Date:   Thu, 6 Apr 2023 17:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string
 pointer
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     <linux-hardening@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kunit-dev@googlegroups.com>
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-6-keescook@chromium.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230406000212.3442647-6-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW3PR11MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 998b5b28-9f8d-4484-2710-08db36b2f50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AH883KvWxxEptJ7IrLuWY8Jd50qCxTYwKiZ/WFpeXdHy/4GoC3U3pTSypVJXlvTalPEa/KcZiymtL/GbFcVoS/oR7uwc5ITNyPwBBe5wwkjdvscYcREQiLZ1Lsrd6q9qGOcLgPO7Pu8LLJpCzKZUQAzLioVuJZ5uomj49cXJQ94C8J489xFLxIJbXBMFr7CAe4TWgqqrRdh5UiE5nOKs74RABBD1oZ2Dx0Z7xe6gX6w70PYHfUOaP2ruH+UKdHlW/WsAdCXfdb33UITdExR/+d6cTy+4q6adNsagci5E1eQbD5sc/gjEwHvpCPm8RJvI9+WIQXZFs3pL5eKgBPuZTe8315qzp4jLeHpffxAwNqp6YGALkmoeSt3LldeOkH4Z8bJso5TCZj6fVQgASoNhZbqza40hs33WN0XXxsk1c44TRleujLHIl8xIvPfavETC6V6mSv+6Y8oDASqZiHJHLS9AIEyz8k7aBVzvabjXnS0U1uwc+GsPeoO2zuH52Y2A6VPpz+a05JiZxUyEeKbJdJdVTuSagUZNR56oCQAS4EarPyyAL0Y0NiqTDrMIB5RToKYSjLO7LuX/ZTNgJP26hjhjjDaf1QNyRWvPzkvpBqoTV38y7NaO+vNSKGD+HiSJkAk6rN5Fbd+KayiP5oTxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(6666004)(31686004)(83380400001)(2616005)(86362001)(186003)(26005)(6512007)(6506007)(8676002)(38100700002)(4326008)(66556008)(66946007)(31696002)(6916009)(82960400001)(2906002)(41300700001)(66476007)(478600001)(54906003)(316002)(36756003)(8936002)(7416002)(7406005)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXY4R0JZR294S3VyQ3grVXRwZmIzNjBZQXowT0QzR09POXhuS3IvNmtkUTQz?=
 =?utf-8?B?bVVSejcxeHNxWWZKbTRJY3BCcjkweG0zbDl3MDIwOXE1QlJ2VWJzbjRaRHhB?=
 =?utf-8?B?RjhiZlV6ZXVhM1E2am4vUnBvY053Z3FhRnNuL2Y3ejl2MTQ3MDdkK0pJZ21D?=
 =?utf-8?B?YWszeTdIMnQ3Nm51dzJZWlV6NWVFZVhnT2xSUHlYaUxTcGNPRXlFZHNnWStX?=
 =?utf-8?B?Um5vY1oyQ3N5UXkvM3NrTHRLSW9rVXBiSGJ0MGNsR2cvbDlTdjYzZUhIZ21h?=
 =?utf-8?B?RUcrNVpreDc1aHl5aTl4aVZZSHJ2MWh0ODhJRTRuQ3pqK0RJNDAzVG1uK1dK?=
 =?utf-8?B?RnU0b2YrNUlsOEFPUGsrbkpnZ1JaNEdUUTRseXdpS3JpejFTaWZxclo2YWlZ?=
 =?utf-8?B?d0RIMktaMjBFa3hiRVhOU1E1ZmF3VXR6RldMSWN5MXNwRG9jejZuQkhvbDh2?=
 =?utf-8?B?S3BYYzNXNXlEbnF3aE5NNG1odmtaVUxPR2ppVzlVZnZjTTFpUkdtUWtqa0pX?=
 =?utf-8?B?eW5weklZYS8rRlFWY0s0cnlOeksrSFpDaG51azZHY2hOS1U2clpvYXl6V0g4?=
 =?utf-8?B?OC9NeWl4ZnFWNkpROTFYVDZxMXdWYTdqUVVPSUovYTd4VGRrVnordi9Jekcx?=
 =?utf-8?B?ZldTYnovZDM3L0Z6UExCb0swalYzYS82UHBncFZuUnFadVNDelMvbDBFdkk4?=
 =?utf-8?B?eGxubFVxdm1EYkwvZXprOGlvVmFWTGQ1VnlCeVZ6dWdxV3J0Mi8rd1RwRFE1?=
 =?utf-8?B?elY2U0E5TlBQVWkwV0lYWGdGTUZ3eUE2eThRekRaT0pWbmVyYmxacnZJaG1q?=
 =?utf-8?B?Y3RmOFJESVg4c0xaSVBDZ0FhNlJreGloZEdwcXNIeGs3QzFLalZHWkpIVDdQ?=
 =?utf-8?B?a0VWUEdVcFFId244aW5ybEFFeTR3SEJHMnNHWmtBU09FMysvakpDaFRjZ25U?=
 =?utf-8?B?NTBLSVhwY2MxbDBHc041N0E4cEFyNk1IL0YrUnNVelZNR3dEck5vd0YvYXEy?=
 =?utf-8?B?SWhBWVVoemZWTEltSVhXd0hlenJ4dkQ3WlRZTHdhLzJYSm51bHYzOHRzaHZH?=
 =?utf-8?B?eWJXaHhGUVpjNWxuaUVkQk5oMHZUSFEzVW45dFp2alpIdmlXSjB4VHZxVWZW?=
 =?utf-8?B?RUpsVmFrTGpmNS95NXVaS2YxYjRSRFVTSktRVTZranhESWxhS0E0c3kzY1dI?=
 =?utf-8?B?L2Rqd2ZjUlRxOUJjdUs3Z2o0bVIzczhHc09tUExIcDBEQ0ZCMjRGZHZJRGk0?=
 =?utf-8?B?bS8vK2o3aVdrbDU3YS91UVVyaUxkTStmekUvTGRzbnM5NGlqZTdQeXNIbVE0?=
 =?utf-8?B?UzFYdml6SnVvbmIwaVZ2RWJBa3BCdkNxMDRUZHAzd2tJdXNpY0R2ZVpYNEgv?=
 =?utf-8?B?d1o5TDhoSjdiTEl3WnMxdStMTFNSSVZHb0UwcWtCREc4WWR4ODZ5YTczTmND?=
 =?utf-8?B?NjB1Vk1hamFmTmIwVFdteUlRYmo4SVFRMkxpQlJHVEl6TUhiSzZRcWtUODk2?=
 =?utf-8?B?QXFEbEROOERyRVZ2K0lkVENMVEVOVFVHKys3Ykw3QXNXbjNuWVB0a2U0bGRz?=
 =?utf-8?B?SWkyV0w5T3F4RHpyYzhoNkhObExqWVJNKzY2TENxQW9oeEhyNlRxUllrMFow?=
 =?utf-8?B?VjRYTldwcUx4VHpsVTEwNXhxMDg2STlvYzVHaUFuMHp6b0xtNmkzWEtFNmlQ?=
 =?utf-8?B?VW93Zk1YbE90UXUrOWoxbWRFOVR1V0lzNkY4ZlBLeUVWbExYanhuclBQZW5q?=
 =?utf-8?B?NjlOSS9XVXFNY3BlYVVqTEFhcnMwUkRKczBMdXB0K2ZMVFlrTElMK25JaDF4?=
 =?utf-8?B?Y0llamxHMit0TTg2TE9LdlZCcXVEaGhJVk0vU2xyZW9NclE3RkZ3SklWcmp5?=
 =?utf-8?B?MGpoY1Q4WFFNU1VPRHRjSTU0Um9CSzJKTk85Mk4ybXFkOVFHTlUrL1RIN3d5?=
 =?utf-8?B?K0lNYU0yK1dVV3Yrd09KUGl4ejd2ekdiT0VONG5QNVEwd2pWT2hoZXc2SzZZ?=
 =?utf-8?B?UDZ0d3FNcGwwUmRlemVDalV5Z0xNVW5lTVNQV0h3bWI4TFZ0OUhvK1QwdGR0?=
 =?utf-8?B?QzQ5VVJiZDZ4MVROYmx2Wk9nbldsdUwrOUJuWTQ4VkVuTmh1VFhaZmZ3d0Ro?=
 =?utf-8?B?RFVqZWFSdnZWVVFUQ0x4aXQ2dHlWcjJKNmVXb1RDWWhQK2NLeXh3aENNTjdm?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 998b5b28-9f8d-4484-2710-08db36b2f50d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:24:04.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adqAtdpNzpZMa8dsZXjeY0faGf1Tx6Ejm060+PosOg7u8GihuRPDMnChAMiKbjYX8Nm3JezWE/pkRhyOBF+JBZ89u8fsfclLkaY8nnX/kII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed,  5 Apr 2023 17:02:05 -0700

> In preparation for KUnit testing and further improvements in fortify
> failure reporting, split out the report and encode the function and
> access failure (read or write overflow) into a single int argument. This
> mainly ends up saving some space in the data segment. For a defconfig
> with FORTIFY_SOURCE enabled:
> 
> $ size gcc/vmlinux.before gcc/vmlinux.after
>    text  	  data     bss     dec    	    hex filename
> 26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.before
> 26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after
> 
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Puyou Lu <puyou.lu@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 72 +++++++++++++++++++++++-----------
>  lib/string_helpers.c           | 70 +++++++++++++++++++++++++++++++--
>  tools/objtool/check.c          |  2 +-
>  3 files changed, 118 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 41dbd641f55c..6db4052db459 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -9,7 +9,34 @@
>  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
>  #define __RENAME(x) __asm__(#x)
>  
> -void fortify_panic(const char *name) __noreturn __cold;
> +#define fortify_reason(func, write)	(((func) << 1) | !!(write))
> +
> +#define fortify_panic(func, write)	\
> +	__fortify_panic(fortify_reason(func, write))
> +
> +#define FORTIFY_READ		 0
> +#define FORTIFY_WRITE		 1
> +
> +#define FORTIFY_FUNC_strncpy	 0
> +#define FORTIFY_FUNC_strnlen	 1
> +#define FORTIFY_FUNC_strlen	 2
> +#define FORTIFY_FUNC_strlcpy	 3
> +#define FORTIFY_FUNC_strscpy	 4
> +#define FORTIFY_FUNC_strlcat	 5
> +#define FORTIFY_FUNC_strcat	 6
> +#define FORTIFY_FUNC_strncat	 7
> +#define FORTIFY_FUNC_memset	 8
> +#define FORTIFY_FUNC_memcpy	 9
> +#define FORTIFY_FUNC_memmove	10
> +#define FORTIFY_FUNC_memscan	11
> +#define FORTIFY_FUNC_memcmp	12
> +#define FORTIFY_FUNC_memchr	13
> +#define FORTIFY_FUNC_memchr_inv	14
> +#define FORTIFY_FUNC_kmemdup	15
> +#define FORTIFY_FUNC_strcpy	16

enum?

> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -1021,10 +1021,74 @@ EXPORT_SYMBOL(__read_overflow2_field);
>  void __write_overflow_field(size_t avail, size_t wanted) { }
>  EXPORT_SYMBOL(__write_overflow_field);
>  
> -void fortify_panic(const char *name)
> +void __fortify_report(u8 reason)
>  {
> -	pr_emerg("detected buffer overflow in %s\n", name);
> +	const char *name;
> +	const bool write = !!(reason & 0x1);
> +
> +	switch (reason >> 1) {

As already mentioned, I'd use bitfield helpers + couple definitions to
not miss something when changing the way it's encoded

#define FORTIFY_REASON_DIR(r)	FIELD_GET(BIT(0), r)
#define FORTIFY_REASON_FUNC(r)	FIELD_GET(GENMASK(7, 1), r)

(+ set pair)

> +	case FORTIFY_FUNC_strncpy:
> +		name = "strncpy";
> +		break;
> +	case FORTIFY_FUNC_strnlen:
> +		name = "strnlen";
> +		break;
> +	case FORTIFY_FUNC_strlen:
> +		name = "strlen";
> +		break;
> +	case FORTIFY_FUNC_strlcpy:
> +		name = "strlcpy";
> +		break;
> +	case FORTIFY_FUNC_strscpy:
> +		name = "strscpy";
> +		break;
> +	case FORTIFY_FUNC_strlcat:
> +		name = "strlcat";
> +		break;
> +	case FORTIFY_FUNC_strcat:
> +		name = "strcat";
> +		break;
> +	case FORTIFY_FUNC_strncat:
> +		name = "strncat";
> +		break;
> +	case FORTIFY_FUNC_memset:
> +		name = "memset";
> +		break;
> +	case FORTIFY_FUNC_memcpy:
> +		name = "memcpy";
> +		break;
> +	case FORTIFY_FUNC_memmove:
> +		name = "memmove";
> +		break;
> +	case FORTIFY_FUNC_memscan:
> +		name = "memscan";
> +		break;
> +	case FORTIFY_FUNC_memcmp:
> +		name = "memcmp";
> +		break;
> +	case FORTIFY_FUNC_memchr:
> +		name = "memchr";
> +		break;
> +	case FORTIFY_FUNC_memchr_inv:
> +		name = "memchr_inv";
> +		break;
> +	case FORTIFY_FUNC_kmemdup:
> +		name = "kmemdup";
> +		break;
> +	case FORTIFY_FUNC_strcpy:
> +		name = "strcpy";
> +		break;
> +	default:
> +		name = "unknown";
> +	}

I know this is far from hotpath, but could we save some object code and
do that via O(1) array lookup? Plus some macro to compress things:

#define FORTIFY_ENTRY(name)		\
	[FORTIFY_FUNC_##name]	= #name

static const char * const fortify_funcs[] = {
	FORTIFY_ENTRY(strncpy),
	...
}

	// array bounds check here if you wish, I wouldn't bother as
	// we're panicking anyway

	name = fortify_funcs[reason >> 1];

> +	WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write" : "read");
> +}
> +EXPORT_SYMBOL(__fortify_report);
> +
> +void __fortify_panic(const u8 reason)
> +{
> +	__fortify_report(reason);
>  	BUG();
>  }
> -EXPORT_SYMBOL(fortify_panic);
> +EXPORT_SYMBOL(__fortify_panic);
>  #endif /* CONFIG_FORTIFY_SOURCE */
Thanks,
Olek
