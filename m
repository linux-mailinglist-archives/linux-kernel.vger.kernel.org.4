Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5B5B93CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIOFCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIOFCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:02:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2AF5FAF2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663218163; x=1694754163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dOVndyTdTz9uLXpsjxTOR5IRPS+/6HF2tTM1PDi9GbE=;
  b=l+AsF/DYX2jtYZXxBJyU1SNbmL5iOlMrWU8T0JJ9UlJ4QHm6pXocdzGK
   qEA0NbBWB/6fFVkgqueLQ6WLQSujMat8b7Nqyux3e2NZ+hoyTOAYPXCqi
   WZCPM/dyE0J/vhshlhNHGvXcmQ44buwjwtmuQ0guR+1KQ97AXsI5vcq3T
   NuyT2ShDEulFbllecEBleqo49AkZdwghE52ETLnD2c7sE8TyxBhznT1hk
   Lo4WSQ29Arzvzp9dgYbIGY5i5K3xF1aDsEtY4Ea+2j2MfXlgZhTnoiBGS
   bOwdGU48KqDjzgvoL5BObu1OdQgO79NInN+Cjp9nDT+hh5sbUXkHXyJ+O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362573596"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="362573596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 22:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="650336132"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 22:02:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 22:02:40 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 22:02:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 22:02:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 22:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h19QaxbxtvGWoWmm3yDI+1NUDY2YnRgAg6xS0aYkpx+9yNSprtA9dOBQK5iDTPWFwiESWO30uhCUzNQYcXZqcE/mbeaBW8Bp7gPj57RnwnCeB1qEHCn3lLcvnTV37sHkbC3PTL1AP2x1l7gygbPJdaFUHJR7f2nuFR0WBES7hhLsQeX8uDd8sxFQyMmEjovg+L4tgG3JrP9cH1QhyvfpH18cN42Xp0KpffiIZIvDn/HRVarSIP1zjYIkcmXIDk7Kmn1lpK/bVnTx+60PcyW/BGRgfLXkxd16IkBKuevI8PG7j8K8vKC6oQy9sVGjpVZbAdSEzEzzRvB5ccpQ68Hgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5jtvN0hU7QEY2T1fpFfs+dRk4JwmbBQQhzt98pFsyY=;
 b=KwI5UWGuY34vygLSGNXwEjmRcC+zMc5kx8boYyIHjUPfY2O9P01Es8klUdSviLiVz4qdwoiZL8u2HdGfClihyoqoZqHRGwNRclNPrHFuJxp3g3lJSyzWJBdEk0zO82/7u0/kCJWH3t6hXn/gx2PJzlsUGTo4qN9IjUxfOGDONXnxbBl9qp+EcIxlsrJhKcR/qZL1l6AH/iC0ezQH/j0cI5OksnMjDly1d7eeZhfnW05Jcv/ONdC+o7wEvShnwWsGfIsU88VrHq0nBmfLO1kkTLDROpAtH8lLaDFZKGrRZ8C0vIW/8g2lgOASyTgOqC9n/Ykyss8an0aIAh3+hbETUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Thu, 15 Sep 2022 05:02:33 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::3068:ad4d:42b5:6b0%7]) with mapi id 15.20.5632.014; Thu, 15 Sep 2022
 05:02:32 +0000
Message-ID: <77a699fd-82d0-87fe-fb61-09b786f44151@intel.com>
Date:   Thu, 15 Sep 2022 07:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [topic/core-for-CI] Revert "iommu/dma: Fix race condition during
 iova_domain initialization"
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20220914124045.903883-1-karolina.drobnik@intel.com>
 <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
From:   Karolina Drobnik <karolina.drobnik@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fe0a52-9e6b-4bae-385f-08da96d77f7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Timh4Rp6gcWANCnjSmQFtTQjSKX3xRpPg4UrzH6/PRc1YvABPE9GAW/Av2XstsMmMBapoMekfgj+C3UCx7L0Dh18Fny2Tf3Ye98jbttcgl9uG2kiZhPubNYJDZCjFlV5/q7CrOoCjov7z0WISJthfRr8piAFrQWRhQAMaskeVUg16TpZZ+3t21t6ty14nv6zmEPUSYiQ6T1psfa6ouyztzr0mboYJrZD+sHKKX7mQ+nha5Hw9j9NkefV3+9fP96heyVMI4H7nw332DUv1F1My14a1lnFrnPOuYyCvvty4+YvR05T7jiKgLeoSluxQR4K66fK4Ja9co9nQ8JYDam255WbEXvQdHYHaqB3bpgFJ0UuM9F2oD8SabNOH5z9fzwFUzNJif81A8YH7Y7w42Q5GPPyruT7poLv1G3ZmQYGcaTyVqsucW1M05SAckUno49+1R04fWoB8tu413Ypy1/nzZ5GKaK8xSrO3B5suu4nGs81YGBBNlTCFzfQQz6RQchyt6m9vy/cfdHNszRwiJvCbeDZ1saCExMYXHMHOU+mUOcn9+10lGYD57C618LXxIr1PoPiws0fK4V0OSuarW+xuoUX0CYmF/mb4q32yXc/f7B2WnQa/tY+ndrOWHqfKVtJUObHW7BrPPBx+xlS+93wfxeGCTC2p45Ij7knw+cEe0PUfsPux4+qBjt1QZGDB+P3CuWXKhZXi6Kq5KED6SASNX/WCNWsj/RQw4PiQJWv+ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(31686004)(6486002)(36756003)(83380400001)(186003)(2906002)(8676002)(5660300002)(8936002)(54906003)(44832011)(38100700002)(6512007)(6862004)(36916002)(6636002)(966005)(37006003)(66476007)(6666004)(4326008)(41300700001)(31696002)(316002)(66946007)(53546011)(2616005)(6506007)(66556008)(82960400001)(26005)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZ6RHI0TU96SFZ6NW4rZUdQWlpVaXgvSkkxTTdaVHRHUFRKTDd2WHVLZ3R3?=
 =?utf-8?B?QWYyc2VBaDdKYnJESnYzc3ZDRkV2MUxscWlGZzFKY1Ria2FRaDZQaDdpNHhQ?=
 =?utf-8?B?bGtYR0JJWEVSMFpxQ280ZWVZWks2cjVXcTlPQWNwK2lnb2tSTTdlK2pjNmxq?=
 =?utf-8?B?Z0Q0U2tJRmlyaERkOHZkWUNQWGlCR3Viei90TU1UMSs5czVIb2s3SG9WZDlL?=
 =?utf-8?B?eSs0TkI3YmUzZFhob2FSTkNlbktNeVhDK1FrYlo4U2taVC9nem45UGoxMGtq?=
 =?utf-8?B?bEpZUWxqL1ZnTFQ0OVNJdG9KQnRnL1JOZVJrTlU4cjVoUG1rclptY3Vrc1dt?=
 =?utf-8?B?dGpoSDRjMTBiWm5XY1kxUmRsN08rNE1mbU50VmpwLzNuOUpJTXJuUHVMTVFK?=
 =?utf-8?B?S1F5ajZ6Tkx1R05tRXFUNE41Q3ZXNHJudXhiR2g5VkhJSHpaWmVaREpCdmt5?=
 =?utf-8?B?MnFYK1NJWjM2RzBsL3ExTTk0dERwME9RWFpEMTY4TnJlcUhaNjlRVDFiUk1s?=
 =?utf-8?B?UHcrSWM4QXdxVUY3Y2U1Qi9uMVMwWElBM0VzV3I5a1JIb1BsT0loczJTOFZo?=
 =?utf-8?B?NUxxWlFYN2JKcW5pYXZmOWF2U2RtSXVSSTRpSUFBYm44V1lTSTd2WHk5VzFO?=
 =?utf-8?B?aisrdnc1MFFGMDRKS3Q1TVo5R0d1ay9aRzg2TmgwNXhZMlAzbHRwSXY3VnZw?=
 =?utf-8?B?VlZPa2VsRExubFZ3VUJ5Qk1xcGYzS2NIMU11ditmVVlXOG5WVEpCY2g1Mitv?=
 =?utf-8?B?SFFjZk1LZ25kM1liRWp6SGtUSEtoOGtBbzE3bnhhYnZPVm1Uc3FEOGRYd09G?=
 =?utf-8?B?RStZZjdyZktXODQ3amZnc01URzU0VWNLNmh2VVVzMlZyT1l1MGU3Q3hHbWhC?=
 =?utf-8?B?OXErdkVuTkRVVk5keGIrMTJjblNvRUl5MEx1UWF4QzcwUlRDQVJTTkpLNU1z?=
 =?utf-8?B?Y2dDcFBsdGM1dS95WHlUUVdydnYxTldRdk5rVUNoMmQ1U242NERTc2FTa3hN?=
 =?utf-8?B?YXZRYWZPRXFhVXZRS29OS3prWWxGVzA0S3daRHF6V1JhdWZwa1VPNXBrdXNh?=
 =?utf-8?B?SVNlOXRncXVuS0FCZ1YvaHZ0YTF3RGdxTnhDUnJHUm5pRXNWRHFIKzR6TUx1?=
 =?utf-8?B?blBMbWlCQW5CSmRWeHkyTk5hcHBoVjhrNFBNcDgrMzB4S0g4WTE2ZUJScjhh?=
 =?utf-8?B?eHRWRFE4a3poZHNDbXZnVmxTOHQ1OWZiUnlPOVVpd1QvS1g4ZkU1bUNINVVa?=
 =?utf-8?B?RXBPalhJVjdFeGMyVG92eXRyZ241R3VwRkJzMTlES2xGOExsNG1jL1ZqNVlV?=
 =?utf-8?B?ZHFYNlhZWjhVZzI0d3Via1BON0crTXdldnRQbEVYU2ZNaXJxNHdPRDJzMnhL?=
 =?utf-8?B?RG4ydEpVUks1aFBOd1hpWDlpWTJpSlRSdzV3T1gvN0RjdnMramxTdUcrUS9U?=
 =?utf-8?B?L3BTRlc0aHhKaVFHenZlai9XQ0NOSDZaYUdkT2QxUmJlVXR1c0NITmdidy9o?=
 =?utf-8?B?RWtBNEgzN1ZtUFBIYWtrVUFGejJGaFFzSTlKNHhkcWdleTVKaXZKSStQbjhr?=
 =?utf-8?B?TGV2TDNTQjhPUEE0T2pWd0NpTzc1cWVnTUVETWpnNEE5S1BiUVZmRzJiSzlI?=
 =?utf-8?B?QnBvSTIwWTFGTERDQVg3RWR6R09OSHRFcDZId1ROcDVqUlJOK1NzakIvSjhV?=
 =?utf-8?B?UGdRZkJveXdiN3FKaXE1Wnkwb045VVhwUDdOU3E0QmNQUzduOVhEdFdCeWEw?=
 =?utf-8?B?Q05PdlQvbE1mQVgxczVScnlhK2VEUWNJWmRGbEVyVlU2QVNQNi9hN2IzVjdD?=
 =?utf-8?B?SlN2MFJabFhkVjB6ZlNFZ0c1NnFoQ0pUMjlLTFdpdGJWMmFveEh4ZGZOeWQ5?=
 =?utf-8?B?RmhCYzNzYUxrQ2pUZy9KalZ0QzlJdXVnSXFuZitpY2ZWVm1pclNtbTFWbU5t?=
 =?utf-8?B?bVZySC9DSjNPTjk3WStJS0YrbkQrYWZPZmhDeDBqQTd5aWUreGFtZHFrd1dt?=
 =?utf-8?B?enBKdDZlSFY0Y1NRY3Y1N09wNGRTanRRM0JPTkU4QlJiZWRFbk8rSklnU0tC?=
 =?utf-8?B?SmNvMWg2dDBMQ0pVK0ZuUmNQZGlJUGkzd3IxZDI3Yzg5TG9UWmZ1VUVvTXk4?=
 =?utf-8?B?dmNkRkcwRWY3YmhwbC84eGJQZHNNeDJDWE5RazBrdUpCUWN1OEpuYUxXaGcv?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe0a52-9e6b-4bae-385f-08da96d77f7e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 05:02:32.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LCV/3nX38UANTYvaNHeX2gxG5JLPK81fO1qp76cqSfvakJ79r2v6V1WSKNyuh5JHnUyUxMKZzaNQKSf0qeMW41mep9BylDH+E847qE+6R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2022 17:01, Lucas De Marchi wrote:
> On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
>> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
>>
>> This change introduces a regression on Alder Lake that completely
>> blocks testing. To enable CI and avoid possible circular locking
>> warning, revert the patch.
> 
> We are already on rc5. Are iommu authors involved aware of this issue?
> We could do this in our "for CI only" branch, but it's equally important
> that this is fixed for 6.0

I planned to reach out to them after merging this revert on "CI only" 
branch (hence the topic tag) with more justification. And yes, I'm fully 
aware we're quite late in the cycle, so that's also why I went with this 
patch first.

Many thanks,
Karolina

> Cc'ing them.
> 
> thanks
> Lucas De Marchi
> 
>>
>> kernel log:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted
>> ------------------------------------------------------
>> cpuhp/0/15 is trying to acquire lock:
>> ffff8881013df278 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
>> blocking_notifier_call_chain+0x20/0x50
>>              but task is already holding lock:
>> ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
>> cpuhp_thread_fun+0x48/0x1f0
>>              which lock already depends on the new loc
>>              the existing dependency chain (in reverse order) is:
>>              -> #3 (cpuhp_state-up){+.+.}-{0:0}:
>>       lock_acquire+0xd3/0x310
>>       cpuhp_thread_fun+0xa6/0x1f0
>>       smpboot_thread_fn+0x1b5/0x260
>>       kthread+0xed/0x120
>>       ret_from_fork+0x1f/0x30
>>              -> #2 (cpu_hotplug_lock){++++}-{0:0}:
>>       lock_acquire+0xd3/0x310
>>       __cpuhp_state_add_instance+0x43/0x1c0
>>       iova_domain_init_rcaches+0x199/0x1c0
>>       iommu_setup_dma_ops+0x130/0x440
>>       bus_iommu_probe+0x26a/0x2d0
>>       bus_set_iommu+0x82/0xd0
>>       intel_iommu_init+0xe33/0x1039
>>       pci_iommu_init+0x9/0x31
>>       do_one_initcall+0x53/0x2f0
>>       kernel_init_freeable+0x18f/0x1e1
>>       kernel_init+0x11/0x120
>>       ret_from_fork+0x1f/0x30
>>              -> #1 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
>>       lock_acquire+0xd3/0x310
>>       __mutex_lock+0x97/0xf10
>>       iommu_setup_dma_ops+0xd7/0x440
>>       iommu_probe_device+0xa4/0x180
>>       iommu_bus_notifier+0x2d/0x40
>>       notifier_call_chain+0x31/0x90
>>       blocking_notifier_call_chain+0x3a/0x50
>>       device_add+0x3c1/0x900
>>       pci_device_add+0x255/0x580
>>       pci_scan_single_device+0xa6/0xd0
>>       pci_scan_slot+0x7a/0x1b0
>>       pci_scan_child_bus_extend+0x35/0x2a0
>>       vmd_probe+0x5cd/0x970
>>       pci_device_probe+0x95/0x110
>>       really_probe+0xd6/0x350
>>       __driver_probe_device+0x73/0x170
>>       driver_probe_device+0x1a/0x90
>>       __driver_attach+0xbc/0x190
>>       bus_for_each_dev+0x72/0xc0
>>       bus_add_driver+0x1bb/0x210
>>       driver_register+0x66/0xc0
>>       do_one_initcall+0x53/0x2f0
>>       kernel_init_freeable+0x18f/0x1e1
>>       kernel_init+0x11/0x120
>>       ret_from_fork+0x1f/0x30
>>              -> #0 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
>>       validate_chain+0xb3f/0x2000
>>       __lock_acquire+0x5a4/0xb70
>>       lock_acquire+0xd3/0x310
>>       down_read+0x39/0x140
>>       blocking_notifier_call_chain+0x20/0x50
>>       device_add+0x3c1/0x900
>>       platform_device_add+0x108/0x240
>>       coretemp_cpu_online+0xe1/0x15e [coretemp]
>>       cpuhp_invoke_callback+0x181/0x8a0
>>       cpuhp_thread_fun+0x188/0x1f0
>>       smpboot_thread_fn+0x1b5/0x260
>>       kthread+0xed/0x120
>>       ret_from_fork+0x1f/0x30
>>              other info that might help us debug thi
>> Chain exists of                 &(&priv->bus_notifier)->rwsem --> 
>> cpu_hotplug_lock --> cpuhp_state-
>> Possible unsafe locking scenari
>>       CPU0                    CPU1
>>       ----                    ----
>>  lock(cpuhp_state-up);
>>                               lock(cpu_hotplug_lock);
>>                               lock(cpuhp_state-up);
>>  lock(&(&priv->bus_notifier)->rwsem);
>>               *** DEADLOCK *
>> 2 locks held by cpuhp/0/15:
>> #0: ffffffff82648f10 (cpu_hotplug_lock){++++}-{0:0}, at: 
>> cpuhp_thread_fun+0x48/0x1f0
>> #1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
>> cpuhp_thread_fun+0x48/0x1f0
>>              stack backtrace:
>> CPU: 0 PID: 15 Comm: cpuhp/0 Not tainted 
>> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
>> Hardware name: Intel Corporation Alder Lake Client 
>> Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419 
>> 03/25/2022
>> Call Trace:
>> <TASK>
>> dump_stack_lvl+0x56/0x7f
>> check_noncircular+0x132/0x150
>> validate_chain+0xb3f/0x2000
>> __lock_acquire+0x5a4/0xb70
>> lock_acquire+0xd3/0x310
>> ? blocking_notifier_call_chain+0x20/0x50
>> down_read+0x39/0x140
>> ? blocking_notifier_call_chain+0x20/0x50
>> blocking_notifier_call_chain+0x20/0x50
>> device_add+0x3c1/0x900
>> ? dev_set_name+0x4e/0x70
>> platform_device_add+0x108/0x240
>> coretemp_cpu_online+0xe1/0x15e [coretemp]
>> ? create_core_data+0x550/0x550 [coretemp]
>> cpuhp_invoke_callback+0x181/0x8a0
>> cpuhp_thread_fun+0x188/0x1f0
>> ? smpboot_thread_fn+0x1e/0x260
>> smpboot_thread_fn+0x1b5/0x260
>> ? sort_range+0x20/0x20
>> kthread+0xed/0x120
>> ? kthread_complete_and_exit+0x20/0x20
>> ret_from_fork+0x1f/0x30
>> </TASK>
>>
>> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
>>
>> Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>> drivers/iommu/dma-iommu.c | 17 ++++-------------
>> 1 file changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 17dd683b2fce..9616b473e4c7 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -65,7 +65,6 @@ struct iommu_dma_cookie {
>>
>>     /* Domain for flush queue callback; NULL if flush queue not in use */
>>     struct iommu_domain        *fq_domain;
>> -    struct mutex            mutex;
>> };
>>
>> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>> @@ -312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>>     if (!domain->iova_cookie)
>>         return -ENOMEM;
>>
>> -    mutex_init(&domain->iova_cookie->mutex);
>>     return 0;
>> }
>>
>> @@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct 
>> iommu_domain *domain, dma_addr_t base,
>>     }
>>
>>     /* start_pfn is always nonzero for an already-initialised domain */
>> -    mutex_lock(&cookie->mutex);
>>     if (iovad->start_pfn) {
>>         if (1UL << order != iovad->granule ||
>>             base_pfn != iovad->start_pfn) {
>>             pr_warn("Incompatible range for DMA domain\n");
>> -            ret = -EFAULT;
>> -            goto done_unlock;
>> +            return -EFAULT;
>>         }
>>
>> -        ret = 0;
>> -        goto done_unlock;
>> +        return 0;
>>     }
>>
>>     init_iova_domain(iovad, 1UL << order, base_pfn);
>>     ret = iova_domain_init_rcaches(iovad);
>>     if (ret)
>> -        goto done_unlock;
>> +        return ret;
>>
>>     /* If the FQ fails we can simply fall back to strict mode */
>>     if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
>>         domain->type = IOMMU_DOMAIN_DMA;
>>
>> -    ret = iova_reserve_iommu_regions(dev, domain);
>> -
>> -done_unlock:
>> -    mutex_unlock(&cookie->mutex);
>> -    return ret;
>> +    return iova_reserve_iommu_regions(dev, domain);
>> }
>>
>> /**
>> -- 
>> 2.25.1
>>
