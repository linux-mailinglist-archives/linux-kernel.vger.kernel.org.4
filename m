Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04480688B14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjBBXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjBBXrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:47:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA4233CF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381635; x=1706917635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uzxa2fM+q/8hMjHOJbhvj60E3OJ/OaaP3luti/gHJcw=;
  b=koCLKs2gGty9NPZXpzYhc2yaw0rOnv9YdoBDa9Z2PZfHgm9r2CG1Yl6R
   XFMY4LZwwvLO6J4eRJf4g6qcY2cYZWbYue5/O5x0drVtg1dLfXL/oUQHN
   Tn/hKVMfguY2QeIWWlIIVpNJtKEXn4S03p9U3rjrk9vY5zPLJf35cj4AL
   1f6EquyDwiX4Cqktd4O9dVW4arXenZ/NRzXS0SHnWMFo9qQ424yH5nmMa
   eovEFzkBcJJ8jeJopCJcQJR8qaOvsrHAKxX/XobxjrnoVs/T08SzqpjfA
   olaze2FFsQUI3Y7XBb+/woqPlbAjftXMF8qnXKa/onAEsOkI94VUltoYY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355945188"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="355945188"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839398625"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839398625"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 15:47:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:47:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:47:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:47:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L53SGMcC2+tS/nlkszX45n5UltPU7bIXN+yZvRumsCS4YsnxzwgCzVbELjykLdZmFP5V0hOv1qrTm2+Zh4rjLU+wscChrt5adNxxVPoaMpsyaTksp96ibkXMrvHkbqxKnUDbKfhcSV6VtShj8W0bRyM3Nm75NrXRSWTZeNl7gEM8oB4LYMTICqIGzLhS7lTo0cV2yJ0GLMicRJ7QhFGqjvxT+BhvDuYt9TprkSYEHeaK9c1m94EzwMSv+t9mZhM5YDKNdXgeEhdHTqM12bB+jdjjh+uhrjouGiQmEdDA++i2Udj6uDN5qmx82JMOGyis82NXdTr2/kso/Rpfe11zUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRHAdLzKx9Ge+FHOEj+N+ugCInOgppVGxkAS6AusoLg=;
 b=UxjwRBgE9r8Fc5UvjeJPVn62GT/QzALS7N6hoNwrcjK1dPrRIi8dNOig2BU02XSScC9CUkLCgJ9zlKHBx8mGacva1JGU+GXtZ0J9bCP+SemCv5LWzjsrPXrPN1asPeIdeGlFspHnIhLu4aoiAwdpo7bLU/H3X4DyRr2Sbvi5vucqK9gQmmimf8PxloqFlti+XWIlRfY2gpslpdiyC+H+qYJzYe1FRw1ZGuk3KU63oeqq+Ujmi4lGzjkUeWCPd8++Hx87NWMaW6nbQmqTPwZaiUc7Drrn6Ec+UiXfy3V9NdGGgt0GwIHFc8JHSvsXTcJezEyUZ82wjR/GBcNat4GoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:47:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:47:00 +0000
Message-ID: <50324934-20ee-51e5-67a9-f1cd823230d1@intel.com>
Date:   Thu, 2 Feb 2023 15:46:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a1595d-1439-47fd-33a9-08db0577c731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJ5HDHw0I7PJJs9ePTmQa7gpjPfehsrThnvCf80VUPrQK/18N4HcqHPbQ92gIRF0mVrj5bnjwq3tlGdGKm+2Hp/5mPwHnGHabYOEp5TWGF+rc8TU+rNfY8BGVR4KUvMI/xUfYw/keLYUULp7g5LiWg1BhFkRlMuvRelmTQzx3SrXwi7rTzyHHC/B6x162dEUmLWi58gI568WF/cnD6ANPCpr9+0fQI88l6CWiH8VPe2pBS17LU6dvokOhZIeF9y34rKgjcQCJYS+Rw7XxjIHd++rALAa7Bb44jSrl9rKpqLLO87n9QtwUt26KQ6YU1/cMW8WjeXNkuafTXFqV9otLCG6EyKSquoqEjGItQECHe83IJKzoptoZwVqHPD3VFC3ix34Vrp9PO7c6gnK/KFBo5RNn5s7ESNZ/7Mu1UrKiLk5OAqyN21JwC+MPsrFWKotwjUintcs3fzEYjWlfFIo+mFFsbC5yOrNMYRmEXoneBmhrhNMk4mYLVu8MsMhDBioIX8YnGE5/wn7tPX3yUeNIxhJltx38lIE6+qCCbXh/Gx4boftEm3fMzqZkdC4bSY7EP6muMooatj7jvSXuVbLw8POm+3N53NMSD4i7iLQZ6bhqYIebzAOH0O+2y7N8ig51PUudAiL5BpdLSi3BEKkUgPL9V+uP7Dqk+4xEqBjoNR6AW1fzJ0KLCR29//mE2EL+c172kAiIK8+enUGa+Y9/Q4BsBnDcNbtaGmyfIYvNFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(316002)(82960400001)(41300700001)(83380400001)(66556008)(54906003)(26005)(478600001)(38100700002)(6506007)(6666004)(53546011)(2616005)(8936002)(6512007)(186003)(66946007)(8676002)(44832011)(5660300002)(4326008)(2906002)(31686004)(7416002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRibXpKdjJzcTl0NlYramQzbFRLVE1ESENKbW1mMGg0b2JtVWp1a0MrQjFa?=
 =?utf-8?B?clZEaGltVmtDUHE3QlFQSHdqYTFzVE1nZWlFMzVBdzczYzE2bFlMRDBmZXpX?=
 =?utf-8?B?YlNCaUxMMkVxZi9vaGM0VjVCeEo0SlRBb2ZaaDBRVjV5bU1oZEJYdVpUcFJC?=
 =?utf-8?B?T0dVZ3g2alRGTkVvbGl1c3QyUzkvWEJQSlAwZzA2RDVadjNtamFWeUxuNDRv?=
 =?utf-8?B?by9ydHNRY29zbS8yN0F4c1hVSjFsQ1ZQa3pMTGgvYTB3WCt1dGJnS05OaXRM?=
 =?utf-8?B?S0g0OUlDK0gzeG1OOGVUUHhzMVdGM0ZWL29zK2sxNjRrcUVuTGlGd0RoTnQx?=
 =?utf-8?B?Y2NHMmt4dk9xV0FKcW05RHpFNUpSRk1adW5ybUE1YjhQYmI3Y0F1dzVuemhY?=
 =?utf-8?B?dWpwN0N6aXltcjdONE05TUZNMk1DZU1OZ2lEcDRQZDRVakhZcENzWWdKL1JT?=
 =?utf-8?B?em4xd2x0eTYvUWlLUnBlUGVFakR1UEJJK3dXOXlSMEZ3eDRFL3NyRnVDS053?=
 =?utf-8?B?RmI1bURTanlEUDdyMGZOREJVSmNVam1RU1FoUlZZSU10b0NYcmR3QmdGQ1Rj?=
 =?utf-8?B?Szk1VEVMSmswSFVUYnFmVGVpa2lRK2pOOU16d1Jzc0ZuV084UzZFMjVJbGVM?=
 =?utf-8?B?K1NYQnloUFViZEMvZjUrRHlJS0F0RmhDMnMva2NDNVlWdHVEbEpNOFBtdm1D?=
 =?utf-8?B?QkFtVU5ZN2cvL0V0c1NKYWhlRDNYTWp3MEFnVUJ4aGhBT2VKRTR2VElWd1dG?=
 =?utf-8?B?TFgzMmZGRzR6Y2VDSFRYYUZaK1hFK29DUHduQlM5RWcxczFINDdjaVFKVnRC?=
 =?utf-8?B?YTBvTlJFMzl2Z3hOd2U3enVMNk9YT1BPTFhEZXZrL2tYTmswS1JRdTdRdXBn?=
 =?utf-8?B?dUozc3d2VjI4TkZ4Rmx2NmozUWd6bGNUT3V1ZlRjeHJGT2pZMllaMEk3SEl0?=
 =?utf-8?B?SGZ4S0hKdlBwUlFkNzBwM2tVL3IrQStKdGM2cEtMRTkycE8zYUFHZW9FNzli?=
 =?utf-8?B?ZTJZdlNQV1ZsWTRNQm0xMjZOZ3o3V2VjWkptT3RINzNPa283RFk4UWxFS0xy?=
 =?utf-8?B?SnhaS0hSQTBjemsxYWNLTHpxSnd5Zk8waDIxVEFiOEU3RnRUZUFOU1JuSUxs?=
 =?utf-8?B?RXB2SWxLeSt0SldVTFJWN1Y5ZnNvN2o4d3hyMGpqU1ErU1RFTnF0TkUrUmtQ?=
 =?utf-8?B?cWpySUhCb2pKUFZNVWovc29xUEkxWU1FYUVLUFhQalZzbUxheWRQOVNHWXFl?=
 =?utf-8?B?eXFHeXFvN2xON3R2SDBzbmNvNDVLcUg1NE9wMmVsZEptWEJDRTVFYVh3c25N?=
 =?utf-8?B?a2N3aWlkYVZNUXIxeFN3aVVTY2g1TG83SWdIbTVrUCtHZEYvakR4Lzk0dWlB?=
 =?utf-8?B?Tm5ub0xZeFRCSkVzTjFlcytzR3c5MUJRWk1FNkhCbFdPRGFRTXpndmRhNzZh?=
 =?utf-8?B?ODE4SGFUeER1RmRNNlBkQUZINmt4ZGRZaVFDYnVJeWFJM0gzZG96R3JOREtR?=
 =?utf-8?B?WjJnRVBIT2pid1Q5Y1BMaXJtbllWeE9aUy8xV0J6VHBiRmZ3aU1PL2JYb0x6?=
 =?utf-8?B?RzNoVFJlTW1pSWo0TlBpNVJUeU5PZ2RqcnhleGRBN0phZWJvT201N0QxWjJU?=
 =?utf-8?B?djhDdTVXYjQxSy9RejRSYWwvZGErUEVKMlgrcEZFZW5NcmQ3TllvMXRMcXNp?=
 =?utf-8?B?NUVpN2JEeVNPaXJJZjJremJDYTV4eHJwWFl0NVVQL2lmcmZUTk9HU3pWTWNZ?=
 =?utf-8?B?WnJ2NzZKMDlaTDd6Tjkvb1Ryem9HcFJKQmZCaEZ6eEpKTzc0cW1sN2NUblAy?=
 =?utf-8?B?UlhQUElYaEVxam1LdCttbGlaT3hyZzlKaEU4SFVWN21qUlAwdXRscjdFUDQ4?=
 =?utf-8?B?T2JsQjNKZXRjOTIzK2M3SndTN3JMbVg3VE50c09ERmd4ZnN4Z2VHRDBySUI2?=
 =?utf-8?B?TnF2L2FUYTJrQnhqR3djTUpBQVQ3M1lIbUt0WGN3dFhQbnBkMnhQZm9sbURQ?=
 =?utf-8?B?RUV5QStYMXNYcit3MVlWYlNWRlEybnI1eCtGazJQZlZBbC9SRHdCSjZvbVAr?=
 =?utf-8?B?WjA4K213ZXkvZDU2T2hqVmFFRkpINGZhT0NpczZtWlZDU2JRY2lVclV0czg0?=
 =?utf-8?B?cWE2N0MyS3lPOEFPTytRYUYxQ3hnT0tMZDVseHdHbmhzM1Zqd1lPMFpGclZU?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a1595d-1439-47fd-33a9-08db0577c731
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:47:00.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md5uXrPTwuYG5aPEEG9jNqWkGVCWeSqY6tvpCvRAbIkBzUCZUEyoDlRkIOI93k9HVVlnnpRmEtwqHMWIsx6Tqp1tQSygREiXrCURu24Uld4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty
> RMID values. This behaviour is enabled by a kconfig option selected by
> the architecture, which avoids a pointless search for x86.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>  * Removed superflous IS_ENABLED().
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 31 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 ++++++++------
>  3 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 013c8fc9fd28..adae6231324f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -509,6 +509,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
>  void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
>  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
> +bool resctrl_closid_is_dirty(u32 closid);
>  void closid_free(int closid);
>  int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 347be3767241..190ac183139e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -327,6 +327,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> +/**
> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
> + *                           CLOSID.
> + * @closid: The CLOSID that is being queried.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * only return clean CLOSID.
> + */
> +bool resctrl_closid_is_dirty(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +	int i;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return false;

Why is a config option chosen? Is this not something that can be set in the
architecture specific code using a global in the form matching existing related
items like "arch_has..." or "arch_needs..."? 

> +
> +	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
> +		entry = &rmid_ptrs[i];
> +		if (entry->closid != closid)
> +			continue;
> +
> +		if (entry->busy)
> +			return true;
> +	}
> +
> +	return false;
> +}

If I understand this correctly resctrl_closid_is_dirty() will return true if
_any_ RMID/PMG associated with a CLOSID is in use. That is, a CLOSID may be
able to support 100s of PMG but if only one of them is busy then the CLOSID
will be considered unusable ("dirty"). It sounds to me that there could be scenarios
when CLOSID could be considered unavailable while there are indeed sufficient
resources?

The function comment states "Determine if clean RMID can be allocate for this
CLOSID." - if I understand correctly it behaves more like "Determine if all
RMID associated with CLOSID are available".

Reinette
