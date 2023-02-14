Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F563696A31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBNQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjBNQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:47:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0865A0;
        Tue, 14 Feb 2023 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676393253; x=1707929253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FarIrdgbNfdQJdvo70c92FVGcmQ5ZjGJ3VbPCq/dnv4=;
  b=HiQs0lS5M57MQ14V7plfoZDnysEs1NdIb54f0x1OplAFqSE9Rrg0yA9k
   QMReFdNhuAF+pX6mqHCQGADddHzo9E2+xxRvEc+IoWAI54VoY/SRqc5+d
   nt5tPIBdTAIiVRLwlfwbVV8YjXqTo1nHPFNLaIe+uuhHjq1qbyZ2QjFuy
   lXzCwc+gERF8wL/Nn34FEs6DcgG39Va1kdEWru3IHLH6dVzg8qiuZ+06z
   WPN6c0+uRiLufqLCkPJkGZDq2r0CiUZMNcswy+fi5UVAzCUKVPNln4ROZ
   Boua4topkRGaYoUv47PsQYrYOm11uik1apz1DimHfWEEh0VQQKLnc561O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332515372"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332515372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812103280"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812103280"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2023 08:47:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:47:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:47:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:47:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 08:47:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWCl/rS5LnJs5WYWwcDDS9X/sF1VrDyvUTs55P18/+zulm2CwJ+WRnZir+9Jb1KwgvvvpwcpTOhitOD6DuMY1ybKYvkPHsl2FgTUB/B2sfP7g8KtkFM4wqSLeyrKVx9LKey10IWFoz0gsHpaocaBv8I13x2CSzOQfSm/TOe6geLXXCcQc3FpGVQeWgM7wILtkx8ofDMGfVkILHU6fkXSSRrh2Io8S2dYGo1UIExLoraggtYO18kAn3I85Xr6dqabP6pY8s5sf3Y4KEEQ29cf2YoTbppE74gXX99hj8MPpciYUJPA+PdCDvYbx3zd9L/dfE1nT96ydmNwrd7gN7iWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xYqTxnRqueF8Qs6KYqHkSgrgUGWaaGn7IgMATqlLJI=;
 b=Scq3x3f+uEeCni8r/xrfvSfE5VxTMX7yGpgNuLJdXI1+N0XnTWAg7WtmtpYChhLT7xpPVaFsULHHLavQp+jp0weAeqClGP9JGHXKk2pVDEzNYFeYAJqrRG6shZF7bAnBHf/J9ouQ8Scs2DdRvDZIAGkQq/6MwbPTZq6CR48tD00MjZV1Yl8baaQJwNbKpg2rs7cDSUS1uN/F/XuDFc1bQPcwJZj4BcL8hKkm/4WN2MUZ2uNyH2vgndj/6JfnZMae+u5DVbhTZ7KXjcHTKhPRjC2orgNH35WQEbEKlibEPQ+38ETVXaH71VnnSGGGBCWy9i9Txgkiz99R+qcuf9aV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:47:24 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:47:23 +0000
Message-ID: <eade11f9-22a2-1e7b-93da-d52b63cf9a5f@intel.com>
Date:   Tue, 14 Feb 2023 17:47:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: linux-next: duplicate patch in the driver-core tree
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230214125700.606a89d7@canb.auug.org.au>
 <Y+suRQBtzCWx+mjo@kroah.com>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <Y+suRQBtzCWx+mjo@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SA1PR11MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 919e9de3-250d-4bc0-ee27-08db0eab2543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qg4DOfr0UJggCHpRWD5+6QFlBd79LwEoXA8sj+NmxOW8wiC5G7BhEixCOlZa4onTvReBOob3zV3p6YVe+MxEsAySl5mdiK8KACpAfQalc4VlTniUngj5PkHyG8cV4PYr8kVQo4WaxV80oLTwdNsLhppYPSD2GvDO5fuDd0AL6e34uSi4uwroDxdQd8Pf2VqKeBfmhA7oaylAw9vKk+w5WPyy3zio/l0PBFSZr4Hgw6ib4A4whfsKcE0qbnosVDyl9cdArVabuY/C6lwMYtRmR1em/7pI5EsTcKvDp8fkDux7UiELxUZoBGCHNVSuw0lwVcU0UeFIKTMfDu7LogtB4TjS1gHReu+q+XdKus5vy61BIRpe85D8Kbmp/05ezOpmIyrhlRvD0tLSBXQXT0dxszjYsZjJMaotPEZ7pGX/EYyBzbEcty9TNUvhJ98X4Bj1MIu674W7xSzBbER64x1FxBHTkDUptfyT/SXUdPn9CSfV7mSPm+NgbAouYvzBgiLLc6751tdC1aKwtniKwfUu3PPewxGSFVSA5PNjnKqZBmlZRr48j7xmJvnqVA5DsxeLPLa2Ebpr8vhfjjcPcvc5+OVLOktfACwHlaAglroMRVpLyTrzjIdGLDOwyYRnMzgEZ5zqJcsQrivBf0l3BBXomHcDSvfRBw2wKwuvD7Zhe1FWEfWppBKMk8V7eNjVbixIrD86NLNXu2/yIJqi0YoyNXPelKzOM9oLfAuN7MKUh+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(31686004)(83380400001)(478600001)(6486002)(31696002)(36756003)(86362001)(8676002)(38100700002)(2616005)(26005)(6512007)(186003)(82960400001)(66556008)(53546011)(6666004)(6506007)(66476007)(41300700001)(54906003)(110136005)(8936002)(66946007)(5660300002)(2906002)(316002)(4326008)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWswcm1kL1VlVERQVWd0dkdEQTMxSGZadyt0UVdBcFF4aEhLV20zMXVMWnc0?=
 =?utf-8?B?SmJPTEg3N3NQODdHaG1KN1NzbnpEMk00MDVzdUtMTi8xdEtsN2JtU3BucXR1?=
 =?utf-8?B?dDJKQTBEU2F3OGE0RGtreTYyOWo2aHJmN2h0WXlaVzliaUZheXJQNnlhTUMz?=
 =?utf-8?B?cmgyR0dkc2ZLSDVUbldCM29DQzRLeEFLaVh5dy9haU83NXJ0b3paZjJhRzJI?=
 =?utf-8?B?NDF1bWl3NTd0cWp3MWREaVZnM1dLMW5QNlVjWXR0NUVDdmxCOFhGL2dnUjN4?=
 =?utf-8?B?U2dBd0hQejloNkJ1LytvNlNmcFZydmtLTm5YVkc5ZjVzKzVIWnNYeG9ESUY3?=
 =?utf-8?B?TGlwd3ZteFN5SmRlcXBPTmsvSXlLWnpHRXpDcjlFY2hDdG5ueWQ1SU1kcUxu?=
 =?utf-8?B?anJWWWI3OFh2OGdKY3crNkY5Qk5UQzRwSUtPUHFLLzdQUjU5WHVWTG9FTnA1?=
 =?utf-8?B?dHBuZGNPMmhjK1lmeklJWVpjMjBYTXovd0ZhUnVjYnk5QWVkUGFxQUs1YVgz?=
 =?utf-8?B?UW8rUnplUXM3YTdHZWFzVDYvalFKandwOUZCdHJMZ2YySklXZXR6bE5KaW1M?=
 =?utf-8?B?SGpxQ3pCeHZNdlM1WmZma1lLNE1wQkxNUlpuWWsxRUI0WjRVODh3OFVUdHhM?=
 =?utf-8?B?UDE4Rlc5dy9WTDZqbWtsczVZMytDY1NlQStzdHJpSlVYY01PNk53ME9iQi9P?=
 =?utf-8?B?cnBEM001WVE5d09GdkRvaWl1ZkNSejRtN2dJZVpxV0ZmQzhVdlJBM1htQTBZ?=
 =?utf-8?B?RjkwdXFjMUdrSFg0ZmcyaW1FNTYvNXRNZ3dNVWZxK25iZGVtYXFZdjdsbisz?=
 =?utf-8?B?SXBOenluaXVzUmRaRXR1dE93R2ZmaGNPZmY1eXJVL0NFb0VoUlVsL3UxWFBT?=
 =?utf-8?B?ekpMcElQTUVNQ3A1NmF3bmkzd1JtNGlrQ0ZXZ0xjK0lFVHB3WU1BSk9ESzVQ?=
 =?utf-8?B?ejRxc3RhallaMk9Bb1JrbFZxMTJxTFFBYkNuQ3NUY2l5NjYzN3F1Z1Y3V2xa?=
 =?utf-8?B?Q3NOSEdJVnlJMCs4aXR3eW5KWDdtUHM0cmFDTENIK1Y5U2tmOFJwNkhjV3lT?=
 =?utf-8?B?ZXNnUXlLZjlhQXJ4dDlsZkRVWnVLM0l1cDk1VVJ1b0RCNVRIS2s2ajBlalBY?=
 =?utf-8?B?SzhxTXY1cHRrci9Qak91TlFxRjR5UDUwVmYvMHhpdXhsVHVrbWhiZnNGRW40?=
 =?utf-8?B?eWpEMkxGS2Jta2RHb1VxdHJYd0g5STVKS2E5aDQ2WnR5citsWU1QVnQ4ZDJ2?=
 =?utf-8?B?aHlJbytpNHZCUmdNSG5qREp2akNKbkJubnVzZUJDVHcyQWtpbFVNaWx1NnZ4?=
 =?utf-8?B?c29xdnY2VUhhSzV1SnlhbFNoV2lYRy9FVHRwMGNqMjJzK0dGd042ZVJVQ3dl?=
 =?utf-8?B?ZG9SYkFqWDZXQVZ3WGM1RSt1eHo1NE1iNUpwSXBuY05nMlk1TjBvbDNENXRx?=
 =?utf-8?B?dFUvMS83cldkQzRKcGdjRVhyQ3F3R3d1dENFaWpNVDhlYlBDWndsbTc2STRt?=
 =?utf-8?B?dno5K3UzS1lzQmxtWHlybitiamxuU3VBWG45NDNPS1NoUVlSY0RkcUFpc0E2?=
 =?utf-8?B?OGlqRFAvcU9mV2ZZOWRJYWp3TzU5azZXRWk1Mk5NeVZYRXBVWVAzVEhnYTNs?=
 =?utf-8?B?a1J3aXZxVUZPYkY5TlJnZzZ1QWsxSVV1ZStiU1NyS3o0MUh4QWs5V0xRSHB3?=
 =?utf-8?B?UysyRGJ2RDBhU3dtRS9zeEQyaGZmbGc4cmZaOFFuREozN1ppTDhrOFF0NW1I?=
 =?utf-8?B?V2FmYWh3RHB1K0ZGSjNvUStlc2NxbVZVSUl0Q2dZQTFSUmIwRDh3QTZLM1RO?=
 =?utf-8?B?ZjRIbThKeUZLWFVrSW5NTThEZkEvN2FFbDN0YmRuaHB0YjNIYm90ODZuWG1W?=
 =?utf-8?B?ZHU1MndKWWhyTGhCOVU5N05ZSVc1SHRYRUhRblBzb1JlUHlxNVNiUzd2cXIw?=
 =?utf-8?B?MjNPbzJRdy95elNoME9DNFBIeUxWckc3c0d6VDUrZCtuOVhEenBQWlM1TDRP?=
 =?utf-8?B?cW1UamJhUDY2UUFJUk9FQ1M4Skhhd21RZ2swWnFJaEFZK1ZFTTJsT29wc3JU?=
 =?utf-8?B?R2s1THdieXA2UThPbGJWR1BvNElicGdGaVBEdng5UU4xcW5HdE5rZkdGUy9F?=
 =?utf-8?B?ZnB1WWtzWmZXMXRRSEZ6ZWNXSEpqdGE1aExRNko1WFpsbHQ3czhtTXluLzVP?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 919e9de3-250d-4bc0-ee27-08db0eab2543
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:47:23.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4PWnMOqcv6MuQyoYNqWEq8LXdv+5TBuadITKga5kDHW/ixsYlFxPCktzihRVV7CUgJ1xtgyt443pciWHcwbJwEwZFEmECAIreqSEKf0AmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2023 7:46 AM, Greg KH wrote:
> On Tue, Feb 14, 2023 at 12:57:00PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> The following commit is also in the pm tree as a different commit (but
>> the same patch):
>>
>>    a0bc3f78d0ff ("kernel/power/energy_model.c: fix memory leak with using debugfs_lookup()")
>>
>> This is commit
>>
>>    a0e8c13ccd6a ("PM: EM: fix memory leak with using debugfs_lookup()")
>>
>> in the pm tree.
> That will be fine, thanks for the warning.

I can drop the EM change, though, if you are going to carry it.

Cheers!


