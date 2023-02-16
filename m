Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C125699F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBPWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBPWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:13:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB73B203;
        Thu, 16 Feb 2023 14:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676585590; x=1708121590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WupttrLmBJqZl7L3E9823NyyqHRg+nzlCvjIe1XQOvo=;
  b=HG6CvoOv4+UB0NluxY469C10K0aUDiPufuqkGI5EV8ErNBymOUSzO9eJ
   ArDICfQo58pwpk2wek9YBe2dVNwww26MZH0pSXH+oefzxaIrfX7Tg8bfu
   /e1EEp4T3MrQcffPBvqltsnQ1d2qjN7fweSQYgCb2Y7K5qZO/kj9/9Av/
   cY8lnFkDDxDR1lFvxKRZDHxZeZn/MSdXFqBeBn+EIT9XBP7ckU5qJjmpN
   tv9jq/+4pFBgRPFV0n4SroAr1Akoud9JJlsKoNj5gGB2ls197/5yrXIqs
   pTld9J+vRB+YPohczvxOJdo3E3aja6NK/F0frRj/FTGpIJ3GAfWOWOOgL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="334052610"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="334052610"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813151424"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="813151424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2023 14:13:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:13:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:13:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:13:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:13:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQjS0zAGTm6TA6z6XPf4NZhoVLOMiqBfo3QfSA+BTigKtXnMcCyuxacQOhWRX+HK4919YPhGDJUtub9u4NwPtUzfox1XshkLidSIxIu/L74FWL9xfo4WWf36BA+zCDdSVOH+uqSw38aYVeMEA0KYfvknwbdvUjjW8QQtT93kX4sxU2UYCmFgKeDnYZVIV+dMustlnd0K+1iKssM1MO2JnijKR/rID+ff8OorrNf2iUlpWglUNxcRe5wnGLHcEIk7NMg/f8RBhus8f+uiuxPQlSz9XK5f2B+P028FjBhmjkZpb3yaRZgNDDyPImOqKtmG/DAiKvS9i5tHmS+rpLCiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WupttrLmBJqZl7L3E9823NyyqHRg+nzlCvjIe1XQOvo=;
 b=EYaVCxAetlDTRrDvxZy084rFogb4hH7CriM9vqxtMSfYb6FitXBCjK7MWwoAVrdGKI+YM7q/M7fpy+n54KpWp0Wq+mHFFZqTgoBJ+xcwvm5fR+Ihy+Hx5HDrMOKAyPx+UhEPORxWFNGA7mTNmM+LCzI6FvAQMCYmDJJupR9X84iE27bM7ZrOyIvoqC0MXwhiaO3FaaxSvfBVkcIoGdm8cVX6CAHI5OSxbafoQq/Jddws6cBXr/WReZc8Z1NpSB4xLTby/Hlg2n8KME8JjpfB0UOGzgDT+R56gGXkqxJYYKOzyhprGSvToKr+Tc1L0HYL+xNWaDP3xrQie/O1zAeBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 22:13:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6111.013; Thu, 16 Feb
 2023 22:13:03 +0000
Message-ID: <54785d45-ee1a-c27f-5d4d-e5fdd53bd03c@intel.com>
Date:   Thu, 16 Feb 2023 14:13:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [RFC v2 PATCH 0/7] x86/resctrl: Miscellaneous resctrl features
Content-Language: en-US
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <15a893b3-e6d4-5bfa-85e9-1f5210173073@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <15a893b3-e6d4-5bfa-85e9-1f5210173073@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: d444497b-970c-4f04-bde3-08db106af90a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is+ID7Bsb5KW2DlELzu+qmYniSEqq4n+V2gCW+f0WrSQ6+FviZULZPAKc3tNnrl2rR8RBeEd4j+YywMJccm7ausDYlZvgOYiR8zh1u22wIx6iLmICN4xCNSefpyGSchBi+JpOFgCnecA1Vt7Orb4zreHptj8T972MUKd6RpSszEA1m2Y855UTL/WHSp086BINQTlTvce8wVzWPGGJoQoizAxAr6qqwnzM1HmECWrzg7i9HoF4AJtrBVipKP89xt9wjn3GOf1Hfi/e6q/MEc6I5mZxNB9pVropVoTWroxfK5ZpKAdhXpihgnTkoKb0yxxqGUDaJS3jJzxjFmtXeNFSvymu87sVx4SxV/d2ObLsDen98Txax9fkHj9BQVqFbh1WkijyCk+rKHrYB6Rty0ZTKHy+FN2pnvvvIaOJjRSQeL1d6fqhCYv1EJ2wpVy9CkpPMbdizaR6y2zwShq/1atuOi3smw3glGwIynqY9A+Sie4AfQxdAt3LaKcSKnsN7sQsVGrKXFp8ykYsEi+BezsnwVlAkoIwS6nzfA+Gp7Nm7fg6zPeoYEAxu//6Q7JMyO7b/OncB17gN8atiBHJ/zpURtZewTQ5Igngd3LKxFk+K6z0hsf0A8t9JIMxSjya2LCcEkJh8W57gWWny9LFsNveZdae5Er6ZCEGbyhGCcTfIta/P5vHUU4AA0foBqnQpi4kOkTz3S1yWgv1m/lcT2Lby87fsDVe6wYNJq2TGUUSlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(2906002)(31686004)(478600001)(6486002)(36756003)(6506007)(558084003)(6512007)(44832011)(41300700001)(26005)(5660300002)(7416002)(2616005)(53546011)(186003)(31696002)(8936002)(86362001)(6636002)(66476007)(8676002)(66946007)(316002)(38100700002)(4326008)(66556008)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRyMkE1ZUUra2lhdWlRNjVxL3VCMlY1SDBWdTZHSzlXdUJjUEFBOGVpSVVZ?=
 =?utf-8?B?ZzhWbFl2cVV5eUM0d3ZuVk5RUmxiWUdJUGZKb2FEWFgrQmk0NkJTNStnTTQ2?=
 =?utf-8?B?QU9zRVQyOURqUE1jOHFqUWRiMVJaaW9PRWNqQTkwL2M1WE50anNDQ0JUclkz?=
 =?utf-8?B?RnRpNk5NWGpnK2NGUUljMUsrSVhaY2RJbEtQQklLK1A3SkRGblZYZFdZNzRy?=
 =?utf-8?B?WGtONW1XcllUSGt5ZVBSYlJGMFlvQ3g4N0xtTXh1d0RFbE1mTExiL0trRkN1?=
 =?utf-8?B?Zm9CVE5od1F0dkJnS1R2aHk4VllzN0I1bWFoTFp6QXNnd1BnK21jelR2Z2Vn?=
 =?utf-8?B?a1QwMEN4Q3FlalUxR0dZa09qTzhhb1F5eCtINlhjVUZQbVNOS1VvN05VV0Zk?=
 =?utf-8?B?RjRHaWJZQWJBUGhzOVdSNHB4eU9sbGxxQWxsREk4ZkdqTjVKVmUzYUdsQUdn?=
 =?utf-8?B?S2JxdFhhV01ERXdxTVNieWRyczVDQUVRRlNEbnZpRWMwTHNDbzRKZTVoaDFz?=
 =?utf-8?B?U1A0aTNpYnpLeTVvak9Gay9RSGF3ajBsZUg4MVM5ZVF2eTBVUjBCdEs3aWd5?=
 =?utf-8?B?Z2pkaUxaVXVEVUtPV0hjWXFBelBVNVp0bjdPd0pteHNlNXVYZXU4MXVvcmJ4?=
 =?utf-8?B?MkJmWlY1QkNXSE9FTkRNNWZnR3JqRkFUV3lnc3d3UG1uUFo1czE0NDVBUHh2?=
 =?utf-8?B?SDN5aVYyd3ZncVQyUEFuYmRNMUlOMmh5bWZadU1CK0dCcmNaT1k4MTNjZ3lI?=
 =?utf-8?B?UmZGck9hUUdWUGVRcXBvaExZY29wbGl2U3prVCtsY0RianFWTlh6TWNGWXJZ?=
 =?utf-8?B?ZGV4U0tzSWhLbmdybGcvTXAyb0V1UHdHNUxjUk45S2Z6V2ZFMkZCNXBRRjBm?=
 =?utf-8?B?ZDI5MEtjWjg2NnhpNVMwREVlZ3dQVG1zTmcrdUtMNG8xUU1Ualk4QVlZTFpB?=
 =?utf-8?B?bWhmSm9SeUx1c3N3SUZJOGlaWlpCRjRsYWU3SjBSR1ZjMXM4bytyNXJRdmo0?=
 =?utf-8?B?WXZwdFhDRG1uU0pNS3JmM1hLTUttMkY1WCtXN090QjlPZHFxRmF6REhDT3Vk?=
 =?utf-8?B?cXFIaWVyc3h2OHlMUnFvUndEdStlRnN0WTZjSDNtRUM0bytQUTI3T0tqSmNy?=
 =?utf-8?B?Nno0c3I4RE1ya004QVJsTk02SHprcWEycEVkaEdJa3cyRmRIZ0VBYjZhS0Zi?=
 =?utf-8?B?SmhDWEJ6YU1jekcrZE55a2JYVUFTUmRzNytiN3psUFo5R3dlMFcvTHYweTAw?=
 =?utf-8?B?RmNNNWtac1FkVnFWZ3dmN28wMzJDM1I2YXc5cFNJVDRBckM3YVBPTnU3c3FV?=
 =?utf-8?B?c1Rvc0ppbWxJdkNkUEk5Qkp4NzR5UUxLYlg3VmhKcldldWU3Um8rRGJPb3Bt?=
 =?utf-8?B?L2EwNHlkbGNVYlF5ZkowK1VveUhsUXVvOUtPTzZCc01tNE9oNGVNVlJLZHZC?=
 =?utf-8?B?ZVNUYU0xK280NmVkUzVTYW1Ockt1K3JPQmk2K21wNkwwSi9yeUxFTkZQdW9V?=
 =?utf-8?B?MytkMlhZNUxwdGpjMEdySmcrNU5aYkZET3J2Nk4vKy8xZE53L0xUV2FCMU1o?=
 =?utf-8?B?TXA4NDZ5ck0vcE5IZjdvbURQaVlRQ1oxUkpJeVZ1ZGRuaHUyditXbE40QkQy?=
 =?utf-8?B?Wk5XczUxdVBFSVZGU3ZaMy9sbXBTM1pWSU5Jd3NidHZMVzlOYVlNYm12NEtV?=
 =?utf-8?B?QktJVHlqKzJTOHBBTVVxQ2FiZ0ovcXVHYXpzNmZLaVNBdDJOa1RwVW5rRE15?=
 =?utf-8?B?QjRvRHRqVTh4bnNnQjlIYUxEUkI1MjRjMytNMFV6TkVsSHRjM21SbUszSGs5?=
 =?utf-8?B?TCtnM1pYY1MyTmxFMjVjVmZWNng4MXlRNFhkaXZBT1pMSHp4OTFTd2FNbXlz?=
 =?utf-8?B?MlhZYzZaMkI0aWhrYlFic3lCQXBPNC83OHFIOWJ2ZHV5SzlCbi9Xckk1eFNP?=
 =?utf-8?B?WkZYTzBSWEFzT3lzejdqUnJiQkI1WG1lS1RBOUdCUjEzNlMyOEtML1R3NDVV?=
 =?utf-8?B?RTdCUVRiNytPNUpIMm9EQmdROHVMaTZ0WkZ1bXR2NzA4NEZWY1pPcGtvV1J2?=
 =?utf-8?B?NjdDNHBMb1B4UzVHYmd4elp1QTM4bC96ZGhwZjNONXVRWnNpb0VpbHlzbVVm?=
 =?utf-8?B?cXp5LzNGUFBSTEFudWdEUC9CQXprd1RTU3pKaEZaak03NGJiNnZ2WUxkdTZo?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d444497b-970c-4f04-bde3-08db106af90a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:13:03.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLUgwWvS9AWsdSg/yy9Dh5LgSTevNnhoOcXgXOfkrV2ea0f3akNSraj/eGFjV/05ZzYkHJWrFJZQjM+Ch3QGQhiAgb2wbTBbJgzoe+yo3KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 2/16/2023 10:05 AM, Moger, Babu wrote:
> Gentle ping. Any comments on this!

It is in my queue. At the same time I hope that the
folks who pointed you into this direction would continue
to participate.

Reinette
