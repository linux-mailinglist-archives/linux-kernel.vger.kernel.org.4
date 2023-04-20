Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE746E98CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjDTPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjDTPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:54:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3FA7;
        Thu, 20 Apr 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682006046; x=1713542046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNewy+n2KzJClBBsTBSH3RwRv8TnPVHHGbLWC+LnolU=;
  b=H0K4yzRhxEYZOqSJm0Ua8PBmAMvpplwuSGDeSj/ab7LDFG8HyjF30mvI
   wUb7LiiDGVqzdYMP0yU2cNbasSHFxOQ4QRrfCGSr5q0E83X4kg/xgLvJ+
   6TCq3n4tagCWI2baj9cA5jsepwezKJlxofpJGXzi8P5Dm7JmZeq04kO5F
   CCn4/Ssdk1zE1bvI8tjubU97Hkva04LKC8fbKziDepuGja1loBY8TjJ4B
   RaXu2/X9JVPaykRrpM5b6cUUsEuwMkTWvTvkTdWLdbuHUaAPLQyRP7rOY
   RMC5dEw1BCgx9anTjAgwY/z16afVZj9VzfFvXsvIdO+dfixFoyisBIw/f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334613694"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="334613694"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 08:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724461121"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724461121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2023 08:54:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 08:54:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 08:54:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 08:54:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 08:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG79Qs8YPciEl2w6E5HE1Z62mKtoeXnvS7mmBQum/x1YV7KTj20peiBeYamca+WrRrqlgBEZECmobemCa4fzuuskgGzamgwkrcmllO7IFilC8zq0GlDVSMo5qaz1O6M98PaK/oJ2CSE0IYnDM9Uen/lqvPsmwdTGneDCiT56C+wIWSG9Fw+ukzZhgtchu2/Nz1nuRX7xbkaKwTsZ+NwN5BI9UVkTicleo0KBP7jl9cuhVZpptpdz7Jmq3Ibe1AKjO4M20lE9NrIXQYo+QiGxzAAkM8uldVJ9umukD3yt9qeG7Glyu0U2TPn4PpzhVRuHgIuWzgWGrc0PHWTxC8WCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efbUCd2q4mru0RHt9JM+vZHKjMWRz5EUZ8FgcUizrsk=;
 b=nVrD7MOmQsMkWn69ZRe/dgQxR5yNWsm4n1emoQf6ApGrjakGFHPLkoIzT8bt4vPjD+WighNkDF5FzvGCyGOvjoo98WXlXhW2pRCqRNj3qfGOBPUqv00zsCDVb96XuJ9W+aUZDWJnrq8xm+HyexF0/Yye/6ffywWp99x5NOQ895Q9Mr+hKZu1pyOAW5EUQHOB5gSR3/7m7oCpjHEKu29EjYfAW5foVCw6Stfr4a5oVYo8yq3S6ZOnkKA3VBocrK4BTO6CDafzIZUufIDtK13pz14dwRSQClYTCsYtCiXylUgbeOa7MMbJA1p9qd013nq4GfK+i0+jah9OTN6x1bzQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 15:53:57 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4c38:d223:b2ac:813e]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4c38:d223:b2ac:813e%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 15:53:57 +0000
Message-ID: <822f2bf4-0c7d-f4b8-5fe4-4edac7e67402@intel.com>
Date:   Thu, 20 Apr 2023 17:52:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/10] fortify: Split reporting and avoid passing
 string pointer
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
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-7-keescook@chromium.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230407192717.636137-7-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c8b5ae-44c7-428b-a2d3-08db41b772cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ilmBQzg5vCvZAZRpe8IPttrfIujv7l+Dgl2joCU0DU7CMxXcI33A4/7kw+I0kMRXZlmXZ5Loyt8gJGbfWx64QjO7lc1v9gMA5M9O5P5dM6z6QAJAo/bKTleEKe4N8my88fxZj9+bHwlWy6HxvcuVuM0thJnYnaqZ7yIThWXseTMGXayIg1sCWwh57WBjOg0NGr1vmM5Ql0TtF+AmdJfY8rl2RAUITmMUWy9HadKJwkEan0CAmSzdJ29U8CcCjtA+r/9oaO/5sLnDGKCy9Mv3pJZaQFN7sCpgEqW26XJm0WtKqK7V5yjTJ/ttPesJgAC03HaCT13SRAvaSy82WhK0oNzsTJYC/MVI+AJCfF5fSVfmnG3VQEhE1NYK89esZ2rtAlRcvlcmhVr26VB1vulU04+rf/m7TsFNQARYcsabFSokSkM0ibkncdz0mUN+qlMeDovj3Ec0vRODLSPir3LRviAm2FZuBVIQMvfMQuX5ZIfY7TXHqA9073DF/rjii3ql7uZL5u93od9xj0qx872sr105GlqVkznVAVMyvP4XfPdJ158BJFzIxUnAOWIuQsS5wk1P4GK0UGcYTsO/yD9StGpVximVGdc5YRypB8vxYhoPW803KbD0V4K4trmGhdB+r1GndaL9i7Aw1ZrVBayRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(54906003)(31686004)(83380400001)(478600001)(2616005)(6486002)(26005)(6506007)(6512007)(6666004)(6916009)(316002)(82960400001)(4326008)(186003)(66476007)(66556008)(66946007)(5660300002)(7416002)(7406005)(8936002)(2906002)(8676002)(38100700002)(41300700001)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UngwL0hUREo1bVZtSVJ1dTFJZVIrejRjK3pOVXlJbHIrOU1iRFU3UzlIWXVJ?=
 =?utf-8?B?YmJWaVZtSFllOTFvRVBnQVBwcTQ3a2JjNUdtWENZQmlWVzJXaVk3cWhNMmlz?=
 =?utf-8?B?b1pINGNCYVUxZnZ4VjgyOXdDV3IwaUpoOWlvRm1xc1kvcFhySy9HR0FCZzFz?=
 =?utf-8?B?ampuYlEralRVM1VpSWI0VVdZOG5YNGVhS0dEbWZUNjBpZVNiajdDdVI3aVk1?=
 =?utf-8?B?RktuMkd4YlN3L3Y4TnFocnNkcCtDWUFKb3RoSVkzL3lQVmlPVmpEMk51TVl2?=
 =?utf-8?B?dXlTYmtDM1l2bjlwWUFRMnp0UEFPZExIMDVweUJjamNzMEpjNC80U00xaDI4?=
 =?utf-8?B?aWtndUVGRFFZUFlmL3hEVlVJTUljY3ViSmozQnpaM0xCckdxMUlVa0xYdXNF?=
 =?utf-8?B?d0U0YlpyOFVHRFhMdVI0RWpyajJQNG90ZnU4SjI0Vjl4Y08xK0NKYkRZNUhj?=
 =?utf-8?B?cVlGZVlLWWVqSFh0d3VDZnNVWU5hT1lPUzhPeUdRaGk0dEFwbVdjSHBaSG1G?=
 =?utf-8?B?S0VDWEMxUUlMeEVJU0xPWHphTCt3aUJ0OFpKaFBMMWttSk5tR2ZDVThFc3JG?=
 =?utf-8?B?VEdtM1cwZ0NrUHptSi9leEt1UWphUEVNaGdNNEF5T3hVbkI5UDZST3N4WERW?=
 =?utf-8?B?VDNhcGJLQmpIY1FoUzlpWVk4QWs1b0owZnFBYVhkSkZPMENVUnJMRUJ0SkhD?=
 =?utf-8?B?WEw1SGxhRy9QWGhGUHBjSXpqbi82dVUwVWpZRTZmNExUR0g5TXY3TWZjTWg3?=
 =?utf-8?B?Q3NDWlRjZWplSGtUM3NCWGJqV3VhclpGbkkyOVNJeUs0Q3hZM1JCUDAyQjMz?=
 =?utf-8?B?bWJNaUdzMWJZa3o5OWNtZG1IWHpXYXJnV2pJelN5cWJ1Slg5clNpbXFLYXpj?=
 =?utf-8?B?WEhnMDQ1WktGK0IxdFRHSS9GYjNxb2ZPc294KzJ1c2puQUlvQ3pwVFNjczlZ?=
 =?utf-8?B?ajM4dzdlZTdscUp0M0VPMlBVbENrQmJjZ0xyZnJ3RnhzMjN5aVl2bWpIcnRD?=
 =?utf-8?B?bWF5cDA4M0VnOE04b1RBZGtCdlBDaVpYUHFKNm5GQ0hqTmQzQk5BZ0paK3NN?=
 =?utf-8?B?UGw1VkRHNmNKcDdWYWVZUWNKY0hKS3orbUZ5SlBSQ09zc0dQdEROMTgzOTRO?=
 =?utf-8?B?dmtHcHVRSDc1eHpCdk5Pa2N6QUo3eW1aUnRJQ01TYVM5RGd2a0VBTW5VRkxj?=
 =?utf-8?B?N2hKblkrUG0xVDlRSlRxWG9LTGZ1Sm90cU1nSzRmckhlYzNQL09MOCtZRG1D?=
 =?utf-8?B?UmsyQjZOQUdwUmZJOVUxZStXQ2RGcTZPTzZYTi9KZEhrZ3lBUTNSMnRzVjFR?=
 =?utf-8?B?K2JFSHVQTzhYckNIMGkwLzBqV0VqNnJZOVB3WjlNQStsR1dpR3pyYTJxb3pO?=
 =?utf-8?B?dnJYTU1iQjhhZ2NWazZEelBhSlBpQ2dKMjIwa21tVC9oOXYzdTJZTkVqSEhP?=
 =?utf-8?B?VEpOeWJIU3A0dHcvQ2M0ZERVKzlTRzZEbk5QNVl3aC9rRFp0ZTJXc2gyd0pS?=
 =?utf-8?B?VGkrRWVpQXNoWVg4RXVBWjBGZFlqeUtBUEIxa3E2VUVudVZWYkpQenRhNXJD?=
 =?utf-8?B?eHc1NTFqTklOTG05WnFZWGEySHJ3TFE2a3Zuc09iVmZzd3NoU1NaSEtHdzJx?=
 =?utf-8?B?Nkk5WmlXeWtXT28vV3JUWnRYa3dTOCsvR0hzMVJUMTQvdEw3WlpBV0t1QzFz?=
 =?utf-8?B?Q2ZnNWlNQUNsRnJ5Ly9tYy9CNFpxd0FQNHdBSlkzNTVEV2h6ajlzRDFZS0s3?=
 =?utf-8?B?bWtGeEcyT3luZFRyQmQzSUt3MVNzbGw5UXlXMmtycy9FMVRQbVJGTWRsUHp5?=
 =?utf-8?B?WnlKTzhOekdFang0OHFsRFcwdnVtRHZ5bmRxckIzL3Fvb2M1SFZwUjBRNGJy?=
 =?utf-8?B?M3lBa0RNWThuZUxQWjdFNXliM2FvakVkR0Q3NGtpbENHNjlFaVY0V3JiTEU0?=
 =?utf-8?B?cXcvZUlmYXQ4a3MwZ3BVd1NDb0lwNUR1UkpnS0xmV2Q3Nm4yZ1oyamo3QmZo?=
 =?utf-8?B?ejNJWUVHNWNGUXpPdkJQeXJhQXRPaW9EcDZteWsvc0lBV1F5MG44a01sVkJB?=
 =?utf-8?B?SS91NWpHeDVGb1RUUmhxRjEwQTduZGF1RUZuSjNkTU1UZno2UjRPUFBwa0sy?=
 =?utf-8?B?RVYxakxrR2dkQU15eHAwU0E1WGRQUTI2ZTNCLzA1TkxWeFkxTHBGeURxSk9X?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c8b5ae-44c7-428b-a2d3-08db41b772cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 15:53:56.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcbCsl1KGaHstmGwtYF4TC7F4uIBrCisuoyfzPf4GB4h/d1ojS5mks7kbjJw3DS12jHnBQMfCg1a2MA83307Kq90j7LrMIxJ7OyrJdhdjN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri,  7 Apr 2023 12:27:13 -0700

> In preparation for KUnit testing and further improvements in fortify
> failure reporting, split out the report and encode the function and
> access failure (read or write overflow) into a single u8 argument. This
> mainly ends up saving some space in the data segment. For a defconfig
> with FORTIFY_SOURCE enabled:

[...]

> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 230020a2e076..96d502e1e578 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -1021,10 +1021,27 @@ EXPORT_SYMBOL(__read_overflow2_field);
>  void __write_overflow_field(size_t avail, size_t wanted) { }
>  EXPORT_SYMBOL(__write_overflow_field);
>  
> -void fortify_panic(const char *name)
> +#define MAKE_FORTIFY_FUNC_NAME(func)	[MAKE_FORTIFY_FUNC(func)] = #func
> +
> +static const char * const fortify_func_name[] = {
> +	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC_NAME)
> +};
> +
> +void __fortify_report(const u8 reason)
> +{
> +	const u8 func = FORTIFY_REASON_FUNC(reason);
> +	const bool write = FORTIFY_REASON_DIR(reason);

Nano-nit: RCT style here :s

> +	const char *name;
> +
> +	name = fortify_func_name[min_t(u8, func, FORTIFY_FUNC_UNKNOWN)];
> +	WARN(1, "%s: detected buffer %s overflow\n", name, str_read_write(!write));
> +}
> +EXPORT_SYMBOL(__fortify_report);
> +
> +void __fortify_panic(const u8 reason)
>  {
> -	pr_emerg("detected buffer overflow in %s\n", name);
> +	__fortify_report(reason);
>  	BUG();
>  }
> -EXPORT_SYMBOL(fortify_panic);
> +EXPORT_SYMBOL(__fortify_panic);
>  #endif /* CONFIG_FORTIFY_SOURCE */

[...]

There's also a small build warning issue. Apart from that, I like how it
does look now, thanks!

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
