Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A7672550
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjARRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjARRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:43:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038A59B72;
        Wed, 18 Jan 2023 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674063773; x=1705599773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eushi8nEahZY6K+1cuY2FhPeZCqDcoATkwjL42YQqnk=;
  b=XVgTCi/TBPvjDlIcdxHIW7qpI3da2uijmsCfnlUNn0TF76Ld3pzBJOj7
   Gk46srs8EIuvmvsrh1enYjsf2Ind0JfFyB2fm0gKZJEn3IHQwZkMorGyi
   efjV/MfpxHkTlC3TT1UqxrQ+sH/7JLDiACQItdTSYRmS0C9bqL3n0a7hw
   krGPZVhpaxL54sdl5KLGjrU0gR6pQj5vKC+rlHzqY+3x7Cj8kWJEuNXzj
   qveM3NRrs0uGsObuI90yFydS3JXgOLC4PGr+64nuoO3mVYdar8gEWXbMd
   jVNRdd0PVZloksLR32+Yhv8OGcg1lvV2ReM6PRcRnG/5dO2jnyKbujojd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308611006"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="308611006"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 09:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783757241"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783757241"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 09:42:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 09:42:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 09:42:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 09:42:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 09:42:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfaXB0A7B/bzyZGP4XZf6LygWIfdAR8PYMpSB/1oXhLmHmRI1gSBn3W8M7lQlQA+JwdeQ6HC51aKeHYs5bb3NaiDJMvuuC3w02nIE+11pjieE7ByoN9vv9H0897DqjCFzae5p8wc7LaPy7c0V3nylV3qBhpxEOKExwG5d5M8TIIdr2EfHtczH1B80ShlgRIhmq2KoLDPlzTTZVwINLxw6T9TwybB/oNMTu076T2pT4N/GVOQLD1WT+M/SBdZTEsSnJE2++AldLcQSq0R0UgpY1Z5mDEtYOUf9JI4moRVJ0B04bZRjRfKwIcTnk/OmF/IPlIziPIbDVwi7wK2AsGTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxrXJC1qFMu/3P/4tnZQuejMBtJ/MQl555E8KD6PXDA=;
 b=mmy29ASuUuVpa9aWEgRdW7wkff0HsRUr92IST3gggiPDKVzYctItAXoCixN7uy8M8aWM5rKFw5FpGFBOqchJ4DcH0iZ4wv5zsP7Oa58voi+MY/EBSpl73QX7ZzKdjTe8HhRhCCuhpDbLAHLVxHmcGU/ui+utGTTfmPIvEqdtoMtjwlqylYouxjGVVaiUrOxekHUaxn0UGxpHHxROeyn1BCS/tINn3pwtpeQ8J7d4cZKmAKFjyq7qba1XJuadteld7Pe4iF7Qy0mDR3TYO0VERfL1kqAtGf0zEGFTwyEK26LZVCbRjA5ql+kLj0DgjXVDeKJzPWTg8X1XsYOTP2QbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 17:42:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 17:42:41 +0000
Date:   Wed, 18 Jan 2023 09:42:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Deming Wang <wangdeming@inspur.com>, <corbet@lwn.net>,
        <akpm@linux-foundation.org>, <fmdefrancesco@gmail.com>,
        <bigeasy@linutronix.de>, <ira.weiny@intel.com>, <rppt@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] Documentation: mm: use `s/higmem/highmem/` fix typo for
 highmem
Message-ID: <63c82f8d56933_985ab294e1@iweiny-mobl.notmuch>
References: <20230118025403.1531-1-wangdeming@inspur.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230118025403.1531-1-wangdeming@inspur.com>
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3fefb7-a13f-4077-d414-08daf97b65ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF3T9n5eRXPQCq9/BufxJ4oJtRA5LDpgISWCW7evUt820H0SEX9tBpxgywdSEGhg7pmUo59PJPFU3bVwofvEdo2FhnLlE3V1wFkKvycEaWn8KYUfIOzHVB8XlKvkxrtvEMJdLMAOyaJkwskY2GbH3+rX/hUId5QY9+DycwdQUbOyTfQf/CRq6JEwDTSrgpIyFXKTzedKVDFzHj2eR7Ntq5zxBKM3BHhFoSJH0A4f35TmVSCm1TEGIEZoxTKWbPtUEVw6LOpN9yt5VC/Ek0VhoF1s8zvOKY7HdHNO5PLW7vBqUCJ0KdymG3xpEwtZfzzrl88cNdBOFAExvn3Ci/sWy68cVyn3u2sILrXwav7GzxlbTWkcA/glBuqEsQoz/YtOuGC/ThNGcfIPU4NLK4z1dSlp7vxsaC5MDEL1kTlvTZeZ17T0KxUdZI1KCnbwf+LZxWXX/Ic1yEk5SarsbnjuJ8K/Y/y+Lp+K3eFjos3g2WslW+ppIzNZaKbKGCJyjiRgY7QWj6oBYcymjKQYGnfwdE3S9g6AdMcq1frrGPS79Z+slZ8vVWzf5ivudsP7p5jES3ZFBBDUSe5WFlc3SzqDJRctt2UutE6JGTo6r3oQ4Hv1aUwyWI5AGJmo53nNDMlEA7XMWdR0jHoljamGhCiDOjYU5cC94npGJUO2ZS6zrsm+/n0c5GbZ8UQnS+z6+FC5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(316002)(41300700001)(4326008)(66556008)(86362001)(8676002)(66946007)(83380400001)(66476007)(478600001)(82960400001)(38100700002)(6666004)(186003)(6486002)(26005)(9686003)(6512007)(6506007)(44832011)(2906002)(5660300002)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kH6L/AaxqSgTHbJADeYoUfrprg3o4J+P64ZsFkVvPt8abosF++BB13qDwfMA?=
 =?us-ascii?Q?EiD8WI2nm+v9AEtO7sxzW9u1zfO/fBaz673dwG3DUdzZ/zdss3BTYKVuisgT?=
 =?us-ascii?Q?taAEmSUGRrRDFTTz+j3ELPgDKeUuTDkqvSOU+Cg3Ot+sPv7gVaRT1d5yehgs?=
 =?us-ascii?Q?AKnI6kkS2MZ0darNAw1zWUdianXP+wEjonMIPfcEVhiRixNa+jjhPTbpEfmO?=
 =?us-ascii?Q?95lGShQNcgAh+Kw76AANNrMH75Zm21zBp74KQupI7kH5jfSi7+0ax+3i/FJk?=
 =?us-ascii?Q?3fooL/JA5uQ4ysSkPbPHkwTI4NcQQPtlhU6sVS9A95tY80glUxFrzRSvY4+m?=
 =?us-ascii?Q?kfb9LjEZQTsnH1wZQIy1qOwh1QAoUcN51sRS413q2Q7k4GzgzE1nlb7L9cei?=
 =?us-ascii?Q?k7P7MBsN39ri/yLqZuABQ44zFIb6YscMenQiryjm7VVnhmb45MqnnDEtBPkn?=
 =?us-ascii?Q?G0e3YFSUTDxtAXMIPzjQzUXxKGRMPh67OucyUSxHXNGbm5/zvb8wWumYGavz?=
 =?us-ascii?Q?ryErY70i7SDSy0xffEieZuDmny+6LS1Z47cf/YR/jWzElDaSPedmsk+vVCjJ?=
 =?us-ascii?Q?FmCFlW0xDYBJUkqb2qRZ/aG0a0pWkXDdaLnyvJ3ka0vPOAOijmFeuJ0m/VTb?=
 =?us-ascii?Q?uLVwMQ9PSYTgfq+NsZg8CAI5GQLbsu0p9fC6ACJKcL5QOCGCDRjFvI/9VaXf?=
 =?us-ascii?Q?BQZYMq8Qeenn0YlHVQN0n6DjVk1N8KvhyhNXF/5FKBhmINqLpXYMtqlWkT6v?=
 =?us-ascii?Q?aYiYZDYSych2rLSMeUDKRPFHhPZHKxWnNFNA4b4Yc3aNK8OBfHHaK8XLr0gZ?=
 =?us-ascii?Q?XdSlYMTf27mn99jEfdugOr4nzMXTl++agEdsJSo7uuCqe9xiL34I6K6UXOqb?=
 =?us-ascii?Q?73plNqndsahnYRmZp4PWn8NWx0LvrpOlwAo+rKuDGiXAxb9t1Fsm8MwCUENE?=
 =?us-ascii?Q?6ts4gMFLmNcweeQlI9gifg0h/hdQtn7li+GSfaTpJ9uxyGPkiDcr3qUg9h6i?=
 =?us-ascii?Q?U+/6rEIsAVEb+TL+9hf//hv7YT34wBvWKvv9Xd04H5CNhGlFr9sn3t94kA6j?=
 =?us-ascii?Q?A3iTpUPV0GDeHmZdWTUajqYGDpKNOcn4VeGtAbvRpmjx0n+qLcOno6XKiIYF?=
 =?us-ascii?Q?D6UhamsDLZWGmBSM47s+/ZIlMqi5692+spGfX1WG2DHeurwMNKozrzsdU1TY?=
 =?us-ascii?Q?W9yO7/zHBQgw7djkxwlYuyYcaaFXZH9ZuXbiVVZKq+yMv/aR2+K3K2n8lP5x?=
 =?us-ascii?Q?0+bkTgjW462kgSGP+a9LH4ZW0lEHOUaBh07wvEW2rYm5DQDZq4LNtm5IjUBz?=
 =?us-ascii?Q?HdAIORDqZdxWYE0YBn0JrtYrDQcHQrjIS1EVrihuTUEr1NNloIQMT8xs9JY4?=
 =?us-ascii?Q?t3ipSPDDy8ntwsLUb5/Q/qTZV+Brn/B8MJ/OJE7d0zl+v7ue8UqADqnEO1ky?=
 =?us-ascii?Q?HMxM1dGF/OonM+QgUHHLQyscb+Q4snShMs3jQDiimBWVMftP39lQLQ7LUeeo?=
 =?us-ascii?Q?R6ex3JrtMnCqFyMUJt9h4VqhGFGX+f/NQsb804dF5MvcDZ2cJWsCiT2ErZNd?=
 =?us-ascii?Q?DuV2PCA/V5WlAYQBFnf4hDHxlMJuHKeAhsa9t20z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3fefb7-a13f-4077-d414-08daf97b65ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:42:41.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EOKkU+9dLEPtqvgyKavddLAHRg0xKa1jSHAOTsA6OGWEPX8AF6H4m54JE+I93ms36VIAW+VRH4Av1KupC1IQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deming Wang wrote:
> We should use highmem replace higmem.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/mm/highmem.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 59d1078f53df..7da4a0d175f0 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -83,7 +83,7 @@ list shows them in order of preference of use.
>    for pages which are known to not come from ZONE_HIGHMEM. However, it is
>    always safe to use kmap_local_page() / kunmap_local().
>  
> -  While it is significantly faster than kmap(), for the higmem case it
> +  While it is significantly faster than kmap(), for the highmem case it
>    comes with restrictions about the pointers validity. Contrary to kmap()
>    mappings, the local mappings are only valid in the context of the caller
>    and cannot be handed to other contexts. This implies that users must
> -- 
> 2.27.0
> 
