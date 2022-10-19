Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D060504D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJSTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJSTXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:23:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6C16A4DB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666207384; x=1697743384;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kCMCBdYAX8dIYC7a5TG+DTZHL4aCMbmlnr4U/JRT6MM=;
  b=Nehl2u4q0ruJJkjFIIqw9NydfmExrqnEu2i4J7UTDt+olZe44ciOL/tR
   AWzZfzPm4/WXIQk+s1Su0ZZke1GkQ81oFV4t+Qwb+ntx7JHEwzFMsoca7
   I11xcTRZjhB5hLEh8gWVBBZTDrjlKhejtzdXE4ch21tWI79d7Sq3yJdBr
   MR2lyFDh0ElaCQjj4ExXPqQHuyfj//zRQRzJUhq3gdtE+/jOCU1Y2I0py
   GYgAX9dJHY/y4pK2xKCfXfMqA4uKa8u4d+sMsg9veovPHImUzBpTXKfaE
   5xRZQFvjQZTUMGSdsPFx22b/iU8YJHbfnxUdX0PFjVaVb9eLmOvGQs+Bi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370725120"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370725120"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 12:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="804452922"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804452922"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 12:23:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 12:23:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 12:23:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 12:23:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 12:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elWFdiPYiC6QjJBb0HTBbbTzGi+xZP+fZwj+VE8gYper+bseI7FT6BDKOunSh0PTpEkY6KTvntVMWZO/38id9qkGRdtEmIREA/ITiMZ77a3Fq9yMtwIkmKGUW5aV/ZC9EZl6RZoWjE/ihNeA2QgLnJOEJ9jzBLf3Eb7Ei18RjxGpC6sBtFuymsaTnz/PU7j6aS5CIU9d299PVuen8SB0FPpoGD+MUwLGEYpFp+aoD7KWiI90qggs4tuSBt6mNDTYywxMIMqE9Lfro5nBrrOIHSMVKtYjj5dL4dqwEbyfnovDGXBiy5rhMoCW7A+amfaFchBqHslKDrNQ+eNGn0z0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V78r1QkXklAEIhqx2zOhniTUVQcd/cr3LtyA5ZmHviE=;
 b=XOtTprEh2BPNvnx7x/mZl2Ot26TLOtb3bgiExZW30WUeD7CDiQVPZdWme/JvvLMKAncd1o+cf++o48D9LmtbA2ueYYDKmALDYqlava5CbZKiPuVlRR+MYlorpQWFZ9NIfH7ClWBa4CIo47HWe/q0ikPocJKvwczsl8/GYkslNsyYQTIZ+aCXQqglzXcBu5Qw9cuddKM8YxJ+auaH/MW1oyXtq9WBvlVbIvZqG0bFR63fX0msoHgoH/+xxxwX5X1uPqq+CX+4HtXof896PFBBZys2eziyuAfC7CevBOcM8XCq4tuIkgO4Wt+xSrfktB7gO9BudrAHKbHfFk2SbiCwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 19:23:00 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 19:23:00 +0000
Date:   Wed, 19 Oct 2022 12:22:57 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221019175426.31025-2-bp@alien8.de>
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: d1aa4a4c-08d7-4960-db76-08dab207561f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY72rnsnmdE9Tp9MycfzxCdQdGv55UE6wALr8U8Jwj0IQrvvnQqvvlDDg847fr6L1dOiPcZOFr8G+JZiQV/Hifo9gcnWQI0Ymtab6vm17xL8cNdB6c+2UR7HSvJyziU7+E9l7xvWOS5gu2Qbapg2S0e09/kNLYKzONY7c75k83ozDy9ao580gv2ZkvWS/e0BDSJUY8cwWhwM8XbXsfEwG7oHHggs2XAbfU/7fGw2jH5KKxS5dRWdDPqkXYsa/YUUh9lK9+vlZP0cfhnVBNOJ9iyU6uhyR4a1I5EqZhor4uHmCJqt7R1583WuRggDkqox9rgljElvFL7v6rc/NTu7X6Cs9RWh/h1eCyLN90B3GyufZxfEBnH33+odlxNzkJRr/NuHixbGcFN+XwwjbHCuKw4yrhPHLuqpxkkc7ujEegPYV4KWLx13mQmpEJaXFemaN3wRLRCKFowNSyduGBzioN9mZKckg1FBSHBlXLI04HbGwYXeKAjFRsHJR3vrSMgBxse6PFgpZfMpeRKEDQBMoAUXzVU61a28k0bcrSCRYzuF0c3PTIADbOC11udPUZ7IveIJ9sOAGkeIUmcwMmZ7gC7H2ge/epTvV8OqQiG19m5Oj/JcGeUyI1eG+Evu6mWEEW8BuGlhUd5wWrE0R26CNmYpIaDjiGG6684qQKBBCC+wyXhCPBLOF6+l57F4qnoNnZGZ9+csxJ5bCzIPEbr/BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(86362001)(4326008)(5660300002)(186003)(2906002)(26005)(66476007)(8936002)(54906003)(66946007)(6916009)(8676002)(66556008)(107886003)(82960400001)(38100700002)(6512007)(478600001)(6506007)(6666004)(4744005)(316002)(44832011)(6486002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osJzht1uuYLCHTy6ewFdWV5+qIs/JOFEcnTexNH8EA7Vd/glIji2fSWZHLmk?=
 =?us-ascii?Q?/f5wkx9AGK4VG7mlCspx8YRHAQDiEnTHciggwXvPdHDr9ep91xnxDr1Pa9Vw?=
 =?us-ascii?Q?s+iJ3OhHjLdT/CP9kXFF/PLzvLqbZlcnd10NavkcdUtlcAqrOzkUHLNaCIAm?=
 =?us-ascii?Q?xNEG3k9178i0mapw/QTYE8doQLvJfsJP9XPcBSq9LEGSrWmefpANHp/lZLUB?=
 =?us-ascii?Q?oOhD1YWeKWQHxDFNqFx9z0F580l+R2XmqXmdYGkVM6RFF58N8Z0KKJvbiEoD?=
 =?us-ascii?Q?uWrwVHH/SWIV8CG9rKQVUDsJBQ7J6cVEy5qdEhCk7iw872gK+YmCzUGA1tDt?=
 =?us-ascii?Q?HJlGSE2cBQaqyKQfltSL8rNpkdAmQ3bhSPHf2SqHBeNBI7wVSUdpDgTuSQCL?=
 =?us-ascii?Q?mfkkJGiwyVRFgVQJOY9tZyV6J9sykEWzM0WpGlIyfV4DpSVAv5TzbyIKMyDI?=
 =?us-ascii?Q?FycDSnIW2xMbPXelUU+ye2odcDVCPILoutCYTHVOiNtGi4eRhFHdu8TOMqtI?=
 =?us-ascii?Q?qqxvutHlYJuqsB8X1DiRTOet2T1EUi0RlQSpalynZlRUr8WY1c+LnIHNRiCF?=
 =?us-ascii?Q?tVKgszXTUL41bc3sxVgfqRbrrWK6hICPxQReneoBPMvccxxbMS313Je9HcLc?=
 =?us-ascii?Q?pzh0deoRQ9j5zk5so3/7fZluh6CNLQRGTZxHPe9PhgsSuFwhLbwhD44QNLyL?=
 =?us-ascii?Q?aLe2aSO0dOQqIZSFUgsH4UnbkbsYSRCwrLDIp3R2gGCKX3ZWMJKv5dhF72dK?=
 =?us-ascii?Q?sqMWV/bYFp3SYf1gz97D50Sx0c+nlbgBLYVPV9Mg2mPQzWy6q/kTiEgU99Fa?=
 =?us-ascii?Q?sPh+YaZS7jB0MI9w+JfEd6zJzHhvLkOD5LW12YYeOyu079EIAEvJx9SIpvJQ?=
 =?us-ascii?Q?pHxhiHw17Th8kVHDo8WiohQ6UQ9Xjrx42+eI3COqIKwl7uGkNG1uI2/BVDfm?=
 =?us-ascii?Q?JelJsiharWUZC2dFb+VoQA/ATZZpoNHBuvg+lmNmmkKvhbwrK8Aj2l3KAmnp?=
 =?us-ascii?Q?hJuKTt/5rqToZvMm/zALczebkykkv/P+173Us+TdvNK0FyAreOZSiQ7II80e?=
 =?us-ascii?Q?RklKkWmJtZbvtLzCTT/emALCqNOEdhiUygxxbopA83+7DHRdQwCXVaBvYMTt?=
 =?us-ascii?Q?uPduLDGdVdoF2lwR0g44+XJb9c1tCA/QgX1KOejQQ9vyDGKgNRBu+SJcLH3Q?=
 =?us-ascii?Q?TZs0XKoo1M13ekRt/UV0xUE44KceoUU0ZHPt9De+Uf3km6wn3xMRWy9gAEOS?=
 =?us-ascii?Q?m6u94jbrA3uiO7Q/Mf5d2PTV09Gss+NRJiDEEdYFBohVxlZDm2ofRQml68Wl?=
 =?us-ascii?Q?2HXmAmtzCg+ODvYYRlUsQM7jjIplIikZjKPY1p1YmE4OmNr0TsP2v/p3mciM?=
 =?us-ascii?Q?F+/R4KdzyTJ5D7Auf6CKJVEH7dbTZFGLwbAhXdkjZDqe7HPDHHd1w8uKF1kS?=
 =?us-ascii?Q?ZJOd6aqWujqezjKkNjeh4SKaonSBELpCas3knm/gVyRRrMs04a3X98ACB5XX?=
 =?us-ascii?Q?iE3cfhNBVP8HM+KdlzNSccdf9ylbrHHNOuNxatzUcvyiU0JQ8lrr1lIV8Q5a?=
 =?us-ascii?Q?06+G4hh5DgalLmBoKIyv8U1HlJQHbze/MtWep3H9TszEkIwtlzLuHGI70Gf3?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aa4a4c-08d7-4960-db76-08dab207561f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 19:23:00.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw2fqjvw+6oC5ORtVKnUCAze4Lqxt5Qtw4W4vd4Xk/J5TC5dq0ViAiWnY3KuRBCAwV2Qoq+L92KhkSITkFFxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 07:54:23PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Get rid of all the IPI-sending functions and their wrappers and use
> those which are supposed to be called on each CPU.

Good cleanup overall!.. Trying to apply them and do a quick test.

[snip]

> 
> +	/*
> +	 * Try to load microcode once on the BSP in case the initrd has older revision.
> +	 *  Frankly, I have no clue how that can happen but hey, loading here is cheap so
> +	 * why not.
> +	 */
> +	microcode_ops->request_microcode_fw(boot_cpu_data.cpu_index, &microcode_pdev->dev, true);
> +

You need to call a microcode_ops->apply_microcode() too if you want to
apply. But you also want to pay attention to the return code too and call
it appropriately.

>  	/* Do per-CPU setup */
>  	cpus_read_lock();
>  	on_each_cpu(setup_online_cpu, NULL, 0);
> -- 
> 2.35.1
> 
