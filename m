Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DEB6BBCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjCOSrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjCOSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:47:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FC315889;
        Wed, 15 Mar 2023 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678906055; x=1710442055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=McNF1ULeJWTPHkYd75asvZZL/GkzEDlk5v9qPz7BPNc=;
  b=evpMgUI1lZ8ePtMvaekHeHJTq1F6i6VwDAJBtsas0s2cdbSsM7DxNR4c
   dC2KsaDIkeXn76dh2EkifuxV+JP4krlePtNd6HN6y8Fq/+6mRxiuMk7wP
   W+lbOoQrLfQfG0YqCSscNiZy6ztBik9OQxRdRZKEjkrJ0s+ryI8brp7+P
   4lvrvqxUCv64GH0IVkuxu1By3HX1qYKZOxgZ0DPMRZ2evGKscpIf85FgZ
   bOeDWewuhw9IDZYnqNcYFZW3UbCCplGgqlX9ExXWYdi+F7YO7eZdqI86u
   gXhXmjkWA/snfu0YPxaf/qIHalNsC+mRIhnocrW/+UCqConVNywlVQ5Wd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321639284"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321639284"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="768618575"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768618575"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2023 11:45:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:45:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:45:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:45:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYYz1nFHDTMs2TQTgkNxr6Ha3xhGaJhv6I3OB1NHxXQfFDxkrK1i+7duxo2Y0I1i6lA5fQvf/+EBwLeZ2IgXqU9v7P0oZY/tgOCmTy8iDEVlIHcbzw8ZqccucTwICU9lDA1CpUFytHyVjyjXlJvyPYRSskc2WxBssvWwqHXIASqVRRvV+V1b5OBcSLMFtQYgGYE0pnBHVigfh+WfmFJNR6nAH4PTWL6PXvfjB6lAdE6SPVppnVhyEd2wbQh4CcBlycXo7sk9yGtbRisUjL/IGeUgrhW/byOEDCLURlM2kH4SsCUsKLV6wQ9ewbanpHoTAOjagvsr0yCKLt6HTaUSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28sr7hPk2+tCyeSgwDWaPHW8MR1hnMF+kTzQOdtB6fE=;
 b=FYilIjdkL8F+U8M7A6G98b1SbLiC03gBVIuzrvcXIF3vHU0WKML/Lw9y5/UYHGYbsTRWHSHnaT6J74yCK5+1pboECAn19bj2uX3SmYMA7Mv51raMDY3LFG7XuxC0LO9R5GL3pVdSomXBNeN6vWoxIU0dZCMjtFSr/P/YjvL7Aoe+rM6Mj6oFSjLhlf8VrGWOOWKzo4KMTtq6Sg1tCL8bSOeJpu43tEF6T61q20Oi1KvUtr0R02BKoSqr4F124UkaijQ9uezhc+oBXa2vvDy2cbSKcD10PYv3lT9r0j9V7WlRNiBT0XvzoDBaxRVcli903ajrKCdwQhYNRoJQqetFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 18:45:37 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:45:37 +0000
Message-ID: <fef12c9e-7d6f-bcd4-f92e-e776eb9e673b@intel.com>
Date:   Wed, 15 Mar 2023 11:45:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/7] x86/resctrl: Add debug files when mounted with
 debug option
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
 <167778870823.1053859.9940104139782066465.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <167778870823.1053859.9940104139782066465.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 424be8f6-bb13-47c6-e1a5-08db25857748
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/jwD/Xc3Qk0liv7iib1aZw/hNsJ/CAbeWMm7fnIHNf6qu+KnPgYtOYDUbUD/A2HdsPinlqHl6wkp7vg3jMAVW/NhMumxXENCw81Ap9qxMTAp3ZrgBkr58jSfVfE5an3nDfrWL/4ch54REZk5DuydlafnczYFGhZkLlrf7uLjqx1ubZQM0QFNNlFNqsdy9joKDYw1Zj75pCYkNk+USq4Hy0JIl2T1hHWgjY0ft4UDr2GF3mMTtJdKKpgwL9WCvxDX3SyR369o9bRgamumPDMdSDO3IcTASKUCY7qwqpwZ6U7t2fDbgIgNMmO4jDSdNsdpU40MeMuDbtrgQJpOclODiq6MO5fhaQtS1Hq4B5Ei5jXnoJr0opj4SWYWhPpst2G1AW1mbWd5Mf7O+e982guoVZkR5bPb46tdE7pH3OMdQua/sWX/tSc5NCTQ1kDMN9ySOsS5Afpd49+qpBR39rn6/ZAx7c+HFw4Yx8j2iWYt8/Tmdd9bA+gJtmWrRV1x+fHEyYGP4VJGaXlsCSaE/d8fAp1J0wj5HTdVATzOCg2svEv8JYLnN79wCPbzEkxUb0ecoEBiiLcI8b3El68qNfN/AGfiRbU6yiqncnISGNKi6Krdp12YH3p8L94moMBypSxi38+X9yqrcN0OyGKPaqfrYMP8rDDlTrjFogAZkWhNp1EiBTVFXUtXdXWRXjxe6OkPxjVLQHUnQYEe2wY4Dz0bXzRL78GUtZJNoHQ4qcqNHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(86362001)(31696002)(36756003)(82960400001)(38100700002)(478600001)(66946007)(8936002)(316002)(41300700001)(66476007)(8676002)(66556008)(4326008)(44832011)(2906002)(6486002)(2616005)(7416002)(83380400001)(7406005)(53546011)(186003)(26005)(6512007)(6506007)(5660300002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STk5SGFxY2RHWW50UXVXZ242UkRrRm9DYis2MFAxaERYMXFwL0w0dG5sZE5U?=
 =?utf-8?B?eWVzMFhCVTV6dnVUc2NKcUVIUjhETE1vVlVvOWxSQi93ZkR2dnBCMW1PSUls?=
 =?utf-8?B?bVBiU3NQSmdLZlJPeHh6MTlIb0swU053ZHVaYmhkaGZNZE0wWWZQQUVEN1RP?=
 =?utf-8?B?eDlLYkpVempnQW9zRUZ6ME9CUTZ6Vm8yZVcxbm8xT2dXOGpRQmpRMXV0OWpE?=
 =?utf-8?B?azdQQWppOVhZazJFbTdJYkZkbjIvZ05xTU9XNlZlTnRzU2V6MG5ZTUlibGV0?=
 =?utf-8?B?aUtCaCtDWmZwaGI5MXZXa1NGYW5ZZmlxcUZ4U3NvZXJQVFAzNERJOWlxQi9q?=
 =?utf-8?B?RDZWcWZ1aHVMdEFnb0Z3blVFOC81WkVSZ1lwdWJORjJkMWdIazRPejlTemNk?=
 =?utf-8?B?TWIreStsWm5RRGY4bWhQdkpCMDcwcm9LZXEyRnQrY21PMnl1dW5oV1V6R3NI?=
 =?utf-8?B?K0lJbEdnOC9JdW1tZG5Ga3NOWFR5ejJoa3pGaG1wb3dUU01ZQndoOHFYWFR3?=
 =?utf-8?B?WmJSelFRTmtQV0ExMzlsUXo4TnZkMTQ4cDFjUVNRbnlNYnl4Nm1hdjhPY2FS?=
 =?utf-8?B?TFZUdjl1eEFDSERJcnNEa1MwUTc3MHJyQjdCSUYxWnJnVHAvalVQbDJRYUd1?=
 =?utf-8?B?elRQUUlaemVJUlFhNkx1S0FUbkxxbHNCVm1JSTVhQytER2JIOG1vbDJ3dmI4?=
 =?utf-8?B?MWd5aFZFWC9KZWRNTkRScVBzTXFIbzJueDIrdWwwWWp6VVdzSnBuSStxbnFQ?=
 =?utf-8?B?R0w4VXJGVmhnZE9JaFg0TFVnUXBrV1E2U1dTMEh2UHo4bldsRThDZnlMQjBs?=
 =?utf-8?B?enV4bThUczcyK0dtdFp2bXE4RVpkWFFWV3pIU09NZ2VnWUljZUF1b1RKTXMv?=
 =?utf-8?B?Q1Vvb1AxbURPOEtLNkZtcW1uN050b05qbkx0RzZEVTl4WUM5ZjJMY1pjayt1?=
 =?utf-8?B?cjh1VUNMbm5lbDNwQkxrU2syR1gyRDE3Q1h4N1d1NVBVajQxWGRmV25sbk4w?=
 =?utf-8?B?b21TUDlzWU5FMXJ2cTJja2NTYnhJem5ScW15QVVadTA0UUk1dmw5UGUvR3RL?=
 =?utf-8?B?TFBmemE3cGx2bE02eXJHSVZsRElOVkZpczhGRlVab2JTS0pEdU1wektsZVpQ?=
 =?utf-8?B?aGR4c1Noa3M1S2pZb1doN2VPT0Y2MnB5QnlUMkYwanNKSUdEZkgyRm84T0NS?=
 =?utf-8?B?a0RLVHVJa3JmL2s3NTE5U3krQWI2b0xjMGhOL3EwQ1Z4Z0JJY3ZtdGVaNFg2?=
 =?utf-8?B?TURYcXRSaFlWY2h4TW1RbWkybVBtZ1g1U1ltT2VlZzJ4TVRTL05BVXdGM0F0?=
 =?utf-8?B?ektlQkpjaEZqL3FwS1dvUlJodTJ2UnAzbjBVYWU3Tm1yT1hvMnJaUlFOWUFx?=
 =?utf-8?B?dVBtclVhZTZLbW8yaFZ0YlIrTDJaV2NXZ3d4WExaM1pIeDlZRHNObXFZcFNz?=
 =?utf-8?B?U0svT0J1cDFZMForQ0FkMm9MSkhtVmtYcDFUeE1Hd1FDKzAyU1V0Y1BzWGc2?=
 =?utf-8?B?SUJZQ09oeEF5Q0ZXU2ExNWg4V1VIYWxZT0pwYXRwekJpMXFYMG40WVpaVG9H?=
 =?utf-8?B?SC9YUXZUTm1GNlhodCtQWDBqYnNrdTVpQ0orQzZZRytsekdTQ0ZJaFBUMmJ6?=
 =?utf-8?B?UWNEZUx0SDZkM2ZvS3JqdFVDd0dFZ2hFQk5MVGpaU0FtOFhPQnRRUS9rLzZS?=
 =?utf-8?B?dnM1VUF2MTNxTWQ3VEIwQnp3eW84dlFpdlhGUWpvU0ZXdWc1MWIxUkorK2wv?=
 =?utf-8?B?dDBuSDhnREJRSXgxMXUyTzl4QWI0ZHp6Z1MwQ0o0eU9ZK0pzSGhRQWpLNVlL?=
 =?utf-8?B?SVdqV0JKalh0T1dVUUYyY2pNWThkUDRqT2JpRkkrWVpBUlNXSnQxUXh5anNT?=
 =?utf-8?B?WmdFWC9xdTFrZ2Irak50Y1FaTkVZWHZXWFRNbWdBaFpmWEVNalliMkJPREE5?=
 =?utf-8?B?VTdPaEE2Zzc2ck9WN0dOdUduNEwxekF0dzlWVFZFY2JBQ1Bmc3NOS2RDWENl?=
 =?utf-8?B?eU5HOXp0UUNIS1lhcUpkbzJNUFBkYlB4dGFDNnBFeDlPNFA1d3o3b3lIUHZF?=
 =?utf-8?B?Zm9pdXNUOUk3eDV5b1puelZVTVNiYzd6RmdrMWo5WkxuVU5XREpMTFQ4Unpl?=
 =?utf-8?B?YVpiZmRJVUVyclp3K1pYY0hEOFJrNU1CeGpHWHZ4dnFBNHBuVFBLZkVyajNO?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 424be8f6-bb13-47c6-e1a5-08db25857748
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:45:36.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMGPD3rIsxlMv+GU77QLrY1dAuB2KYn1eG/MQMfvV5j+oWfPdn2A8tWI9v0/5cLIz4q2xID5Rh5/HaYhhjy0yDcz7JU2Rml97MNbmfZFGos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/2/2023 12:25 PM, Babu Moger wrote:
> Add the debug files to the resctrl hierarchy.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   48 +++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a1f13715a65c..790c6b9f9031 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2400,6 +2400,45 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +void resctrl_add_debug_file(struct kernfs_node *parent_kn, const char *config,
> +			    unsigned long fflags)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name(config);
> +	if (rft) {
> +		rft->fflags |= fflags;
> +		rdtgroup_add_file(parent_kn, rft);
> +	}
> +}
> +
> +static void resctrl_add_debug_files(void)
> +{
> +	resctrl_add_debug_file(rdtgroup_default.kn, "rmid", RFTYPE_BASE);
> +	resctrl_add_debug_file(rdtgroup_default.kn, "closid", RFTYPE_BASE_CTRL);
> +	kernfs_activate(rdtgroup_default.kn);
> +}
> +

I think that separating this from all the other resctrl file creation
can be a source of confusion and bugs. Why not add the debug files
at the same time as all the other files belonging to a resource group?

How about introducing new flags, perhaps RFTYPE_MON_DEBUG and
RFTYPE_CTRL_DEBUG. When the debug option is enabled (when resctrl_debug
is true) then the appropriate flag can be OR'd with the other flags
before rdtgroup_add_files() is called.

It sounds to me if there are plans to add more of these files. A function
like resctrl_add_debug_files() requires a lot of changes and care (and thus
potential for errors) every time a new debug file is added.

On another note ... what are the plans with this debug area? At some
point it may be better to expand resctrl debugfs.

Reinette
