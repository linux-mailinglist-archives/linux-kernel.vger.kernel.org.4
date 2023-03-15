Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C46BBC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCOSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCOSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:46:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4E28D0A;
        Wed, 15 Mar 2023 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905931; x=1710441931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVAtWXC7SHjHVzGpxhS/es48DlTmqJ/q+TOSaAi52Y0=;
  b=Kp2Hi3bWZ+e44dqNrxoRGsGRH6zD+dmHHU2v42oWAqBIT4u+plwNGOfS
   bIU8zPYdWk2+JqwzMBQEfb2t0PfdJXsg2Zt4oJfRIAH5mq4sS+OIr0lt8
   aUQO3lDJ8vo7ll7oYR5gpmMOSXZ9OYb9XUReIHBuTpj4+XOjfmxMf5NEI
   PbqFz5FHqaHifnfP/2JN9SjD31uHWCvAlLXhAaNB4NotUL+nb7tb/XAA1
   WszHRK2sVNPFTjMtpobAR/ptPEH4fs3ksA4a+et8vIBQVV/iIkRdNaS3P
   W/pIlmbFCvxVcroi4DdMcj4gmhsGIwIL6mKqpOT6Sm7k8oA7tEDa1evW1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="335283195"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335283195"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679601672"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="679601672"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2023 11:42:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:42:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:42:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:42:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEtUEfLL1cGBBAIArOv1RVzg86/tEOeJ/E6vff810qUiAm2NPjh9RdcH4aLXfYG+01TWBZmN9DuBtT3+HJlCdyF66Eg8ZKFIZW91T/Xb5+3ytx2dIaUHTWGLSjh24SVhECxhjMRvTFrKjC7xGuGJc89T3lzXD3jjrivRoPjDFzcAhivSdQsCebHnEBq9lLI1E1GYzVTwJgPznMMVrS+Ty1RLqYeSN41NqQZq/iZ1z1Z+qKmH4RCZM8gYGz3yEQDQcAo51cueIhXrN93fNxLmNLjORMWtQS9UWTl6iL2jLl9J47PJXamN7h+dX4wwIKcZ1jnVNZf5sl5ICHMgF2mNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUa9PlQ5hchip3mIzrwNwlU7oTvjN87BmUAk+HFMO8E=;
 b=Gk+iAnNQdhkcrfSBDSenU9Lw8mY57RuMxm6N3Bj6cC78kztlqzaHHjgWVJZ2E34CQBpSs3EMnt2CAEUnW6bOUKSpjaGFWx6OCL58BzrZ48QF7vEjgcSkPhxwwXH+AQGTnaZe97sz7fWJdxBY6vJoCQpql4vH0CyEyuLqjBoW0GR1y7nVT9xFCn1K13wuFQW1GlUl5h+gzQHsY/U97DDSrVhGWBWDb3bHema35TkRcd+BYyDx0CWMMBQW75v5Evg+3jTD5JjsATbTN1KN3Xdecp4qNggiUhazlxmiAffKksca/1B1JoCcgZ823ugyOwXOqCeu5sSHmikKU7t6OjvQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 18:42:46 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:42:44 +0000
Message-ID: <f31e9db6-2ae7-83de-1b4b-4dd802a9da02@intel.com>
Date:   Wed, 15 Mar 2023 11:42:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6943e88e-5d20-4ec8-bf16-08db2585104e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvDMg8NPNHig0w62H/m2oaV2P16a0lP4uti1RLSJRJ/WH4ugqf73at6J6HSxF5AXImHLnY3PoKkyH/orIi+5JH695kS5OVXMr3UdNMPi5+WOGCZkhNY3bDxAJPQNmHIMsbuBd9yI4XFOygevdgl5az1VPFmRD+6DYCgVe2Ygz+Ab9o6XTAHlpLKGcC2bMwZs4a8FcYuG2k/awoTAy8o7yReAYOo+g0O9MMdX0LW6q41EjzInRzZgae33g/HZF9VcKd0PQY5WTik0Ks6deSVGIm6c2oOe++n0G/8llXu0LhuxrFpwME7s2fFFx+oxfQp2GRQy4C5o5TUQcBTpk9HN6T8KWVmOG5+TaLFH8W/zS73hHzOU8tGYVP6ZzUzPQR6GrTfES740rBMH7gvFBm9xmnlKl6p0zKlzTrSDH6YzdXkBOTPmNXs0NJ8aNIqq8sq7YQY9flnXxkWzl3IK5tqtQu3+HJt0u+uDF8ZlUfJndwlN3uAIcprqAfznNvgUsw8YgWJaKeDfGyrUjgO9Smr6YApEXvfXtE0aK8BvYWHD8/8kBSHlz/V9wSULmq+DNimHEv+aSfk1ini63FUeQLSmJvIfX7g+AHhkkl0BlcKPYJ+6KqEsdPm62WuwmCQwU0k30iAwzFdzM00r/mFZxpt2owSV81lVJWBthBkrPmhQ23dMfOmWRFHSa/T29VZpALS/3NT9JYbSbMfXB6LrjjXjnK+7b0/0NiuA5ulxzTWf6S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(7416002)(5660300002)(36756003)(7406005)(66946007)(44832011)(83380400001)(6506007)(2616005)(26005)(186003)(478600001)(66476007)(6486002)(966005)(6666004)(6512007)(53546011)(8676002)(38100700002)(31696002)(4326008)(66556008)(86362001)(8936002)(316002)(82960400001)(2906002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUU3QldiUFVIOVJma1VWeHB3ZFRTNVdBb0pNcWErWnMyWFcySERuS1k5Qmwv?=
 =?utf-8?B?S0F3dnltK0FNU3ZwR3h1T1ZvWlp0ZlBDRTlvY2hYeTJBYXRYU0VQTFRvUlJ0?=
 =?utf-8?B?V0Z5MGp5OXJUK1l6c3kvZWJsUndpblBpck9WVi9uSWtxR0dPa0M1U1lncTgw?=
 =?utf-8?B?NVlOT0JiZnVXQnBhNkpQcW9JcEVTSGFOZnJKVHFZU3E3NytmdjkzdVZPcUhj?=
 =?utf-8?B?d3YxdWhzb0Q4OTNlWUhpQVBwZ1haajFjZ21oZktOS3BFUFRTOEx6d3NBSERv?=
 =?utf-8?B?RG1CcnkxdW1rMGZrd2o3UjlnMHNFV0k3TUhHK0lJa2FnaUNXZUwreXJudWN5?=
 =?utf-8?B?YncvQmY4U0VaV0RBQU5VRmhCMmw2Y1g5b2lldGY2aElic3JlZXp6K01qcUVR?=
 =?utf-8?B?U0lXM1dlVnhPWUtlc0VibjEybk5CN3ArZzlRa281aTZTWksyeWpmZHhka0wr?=
 =?utf-8?B?Y2ZVNkVpYmhuaUFKMkF6L2NWNXdIeVJGVEhkc1NuNitwTkNxeTZYSHpMdDRs?=
 =?utf-8?B?VlhFL1hDM0UwcUFVNnlXZGgvcnQ2QWhGUEJ2WEpFWlVZWUN5bWJIQ0NzMkEz?=
 =?utf-8?B?L2IrSFVEd0VPSi83RUNJY1ArekkxaFl1azUwQWZ5ZHJvNThHc29SSWRjUDJ2?=
 =?utf-8?B?UlZuandlZXdVa3FaOEJmRmo5Wkhkc0tQQTJTaFhZQkh4QVZBcDNjYTAxT3RP?=
 =?utf-8?B?ck5VeFZraXBoUENvdUtMaVF2NVdMdG8zenBqcWxNbDM4a24rLzF4UENMUEox?=
 =?utf-8?B?V0orb0RrcnUyRlAyTlhIU2ZESXo1WW41T3JxQzkwMkhRbFFNbUpiV3FZNmhq?=
 =?utf-8?B?UzNqdFpvZDdTQW5xN3l3Q2RWVlJRV0xBOUc5dTgvaW5BdTVHOFFZMTZYZWdE?=
 =?utf-8?B?dHpGVStrVFRmUitlY0w2YVNNZ0FtVTl1cmFoVEFVbTU3alpMbjJqVWZTK0VV?=
 =?utf-8?B?cVI1Y2llYkQxTnRLMkZSazg2VDRFT0RSTlZyeVJMUXB3WjNxMngrWEluNWZk?=
 =?utf-8?B?aFo0Y0Y1MWREOFdocXVSemNnVnRtNVF1OWZJM2J6RUQxYjRnSlN3UVg5dHB3?=
 =?utf-8?B?cVdzcS9NNTBadVNtNXQ0K3ZCMnVrUlJ5R001RjBKMElFYlJHK2NabVlBcHZz?=
 =?utf-8?B?aUpjOEhkNzRhcDVTTkpiL2IxSEZyemEvc1o4QktZK3h3VjlMbk1jUXhDL1M5?=
 =?utf-8?B?YitwV3lkQktZdmQvTEE0ckNmT1VISk4rT2k4UGUwb3ZaTGdrTGp1RDN3K0RL?=
 =?utf-8?B?amRHbkhGMHFodnR1VUVFTS9ZMEpDZTloNWlpSGJHS2lGZElyeFZxbzJZbzdV?=
 =?utf-8?B?eFN1WVNvaEl3RW1kUjFGc3F1MXEvdXdIcVU1U2F3TTNDUG1RUjc2LzNXc0JB?=
 =?utf-8?B?RXdUVzFRd0c4SStBS2J1TXc1cW1yc1hYUUorTWFiU25CM2xDTWNPbTJsRlNY?=
 =?utf-8?B?aWJyeVo5d1YrdUtnUWJKdGY1YTNyaEdqd1ljT2lSdEFlaTBSdnRZbUpDVW92?=
 =?utf-8?B?d1lFZ0RPaGtiM0JOUHZ6ZTRybmRkb0x3Qmt5aFpFUUViUXpTSmhaSktOS3Rj?=
 =?utf-8?B?YlNja2JvMHpMTEg3ZjBPS01JWVhCVEZDQVRYN3RWNVB0L3JucGNzaTczR0Ey?=
 =?utf-8?B?M1FGZEJLbTFRRTVUMHZpckNiTFFLK21Wa1VmQ3pyTjdjOGhvM2t4Z1VYK3RR?=
 =?utf-8?B?bnF2S2l4aFNoTVMrY01xRk1ya0Z4Y2F2eUVMUHMwb2RxYUc5azF6TU1pWmU0?=
 =?utf-8?B?TXRaM2k2TWlieVV3emV4WXJldHkvUUFFY3lQNHF4T2VGZXR6VWNFZ2lkeEto?=
 =?utf-8?B?L0xXSmFTdXd1QVBtaTBTc2w1eGozZmJ2SnVhQXY0bXhOeTF5ckVXbGVBRGcz?=
 =?utf-8?B?c3FEbjZWL0k5dGVSZTlxU3JQOVBMNFgwMlhxRXFmL09hbFdKYmt6V3RsWlNp?=
 =?utf-8?B?V0J6NWRGL0c0ZzNqUWl1VjB4MXpwZWZxQ1NDS3ArY3lLa2QycTRIQTE5ZWlU?=
 =?utf-8?B?b2c4YWVUYVFoeEdpTC8razhjaHVQS0hZUjVXdmx5YkQyMnNXODBGS3hmNGJh?=
 =?utf-8?B?V3BLWndTWlJxWkI5cEYzUVFLZmN0UU5hSGk3dVRXektRbzVsZlNySHRVTnZV?=
 =?utf-8?B?aWx3UWVUZWxReVo1NmRkT1ArclBQVXVGU1d2VTZ5dmtBR3kzNEtwTGRack55?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6943e88e-5d20-4ec8-bf16-08db2585104e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:42:44.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+uIkNDnWc/Y3IEF2qGg2ft9SpYOZ6j/vnyjChgtnpyTc2+EAtWW+oQVHsb4wUhrbyp8m6uV2c9SHfjAh0mSZvnvqGnWILqyizq//xfbx3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Please note "COSID" (CLOSID?) in the subject. Even so, you already
know and have been reminded when you submitted an earlier version
that resctrl needs to support Arm. Adding x86 specific bits to the
user interface complicates this enabling.

What happened to:
https://lore.kernel.org/lkml/9ca06669-7826-b3b7-0977-02185be7ce08@amd.com/

On 3/2/2023 12:24 PM, Babu Moger wrote:
> When a user creates a control or monitor group, the CLOSID or RMID
> are not visible to the user. These are architecturally defined entities.
> There is no harm in displaying these in resctrl groups. Sometimes it
> can help to debug the issues.
> 
> Add CLOSID and RMID to the control/monitor groups display in resctrl
> interface.
> 
> $cat /sys/fs/resctrl/clos1/closid
> 1
> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
> 3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |   17 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 25203f20002d..67eae74fe40c 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -321,6 +321,15 @@ All groups contain the following files:
>  	Just like "cpus", only using ranges of CPUs instead of bitmasks.
>  
>  
> +"rmid":
> +	Available only with debug option.Reading this file shows the

Where can the user find documentation about "debug option"? 

Also please watch spacing.

> +	Resource Monitoring ID (RMID) for monitoring the resource
> +	utilization. Monitoring is performed by tagging each core (or
> +	thread) or process via a RMID. Kernel assigns a new RMID when
> +	a group is created depending on the available RMIDs. Multiple
> +	cores (or threads) or processes can share a same RMID in a resctrl
> +	domain.

Please make this not to be x86 specific. You can surely document the
x86 details but that should start with something like "on x86 this ..."

What does "a resctrl domain" mean to user space? Did you mean "resource
group"?

> +
>  When control is enabled all CTRL_MON groups will also contain:
>  
>  "schemata":
> @@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will also contain:
>  	file. On successful pseudo-locked region creation the mode will
>  	automatically change to "pseudo-locked".
>  
> +"closid":
> +	Available only with debug option. Reading this file shows the
> +	Class of Service (CLOS) id which acts as a resource control tag
> +	on which the resources can be throttled. Kernel assigns a new
> +	CLOSID a control group is created depending on the available
> +	CLOSIDs. Multiple cores(or threads) or processes can share a
> +	same CLOSID in a resctrl domain.
> +

This also should not be x86 specific. Also, please check the language
and watch spacing. 
for example, "Kernel assigns a new CLOSID a control group" -> "Kernel
assigns a new CLOSID to a control group", "can share a same" -> "can
share the same".
What does "a resctrl domain" mean to user space?


>  When monitoring is enabled all MON groups will also contain:
>  

Shouldn't the "rmid" (to be renamed) entry be in this section of the
documentation?

>  "mon_data":

Reinette

