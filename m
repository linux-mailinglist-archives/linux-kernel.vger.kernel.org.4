Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7785BEC21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiITRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:38:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A2146619
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663695527; x=1695231527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W01nLM1wKMXa667Y69/+GMUH/stkbAr1m5qqVibhAfA=;
  b=UOEkC904fKtcSjFZWElEt6yTOaFX/6E5qc/VJoz1hv+dLEwceTj6Oh5Y
   geWDjMhiY6p7u+s6aaeZ5xewKKmvgnwFvYza4r8rz/66sWVmAa8xVWvUO
   kX+Sxe0hNZFrT9RqjDgS/UzLQxORDQts+7nQeigZJ2g6ONWW3AKjr8AXH
   30vYhQIDZCNoOhlDHfMzS0GXiJwEzRqAd+5WKI2tHjUWaNGTtJ66wdImw
   eqSyUVstM0DCVqraTrLSdNVbXFYgY9XBEqZRSCO3JXKcYQPr7sDquWv2f
   TqXejv1XsCrjVjGTBYweNps+ErCV/s1J/YPo2x7XKx5aQQMZkfMWIDYtz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301146323"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="301146323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 10:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="570174645"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2022 10:38:45 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:38:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:38:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 10:38:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 10:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cALGvIMe3lyCMQ8et+SZjnZ6xmLPAVrhOaBeilEZUHZQHhCKdyq+mjZkS2L5Zn1KEg9fcjGRsyxO30+02auv9bfbVYN0Ie0XddA5mMBgHc6W8fKUj3KhLRrEhENH3bbS6y0StqRf6+rx0vEm5AZxAEMXvAHARPQv5I5DPNyGZi0shyx+MnrwPHEvU+WREnStlGbL7E1pGPrOGPn9exLp5obQBRSH5650B11sdi94IFvxMjIwUIjEkWKuIq32VfBy3kbiA7ySkDONzIa0qbaRtbsvb+d899X7qIGD2fwmOl+0IgUcTz5Z4Ed/Y9RIIN7aoCDVezOIqVaxuAqj9Ml/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2a7pOscrlUR1CUa8bnFlfGVvD5SgK//a9agOQMhiY0=;
 b=npA8xsMnx09beV6tnf4vg+MeNPFZh9HgudhAXL2QwTc6iHxQgLgaQSZq6s276EAJdlIvj8+1wcjX2rbQLp0Qx34kj3soiTag9qPwFn/CIyYCllWthpvpGEzO5nojjH522gc1SUlmATkEz8R+mpXP8rpRBCFxlaAkTV1+FUH4p+mduWwUxumhsiyTvOY6o07At5PprFk3lF/LRchcCO6YanUnX7cLAskpdPIVSe7BiprUf9bo0kHS62tRFgmNwAerXln6C8Aff4B/iA17OEyOKrSCaPj/FdN/OnY4e3Clo/86w7klaQINq4lUjQ+YjMLjvJKcKOSOR3/mdipxKTe/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7056.namprd11.prod.outlook.com
 (2603:10b6:303:21a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 17:38:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 17:38:40 +0000
Date:   Tue, 20 Sep 2022 10:38:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bo Liu <liubo03@inspur.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: RE: [PATCH] dax: Check dev_set_name() return value
Message-ID: <6329fa9e928de_2a6ded294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220805053319.3865-1-liubo03@inspur.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220805053319.3865-1-liubo03@inspur.com>
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW4PR11MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 086e8d19-1c73-4bde-4c91-08da9b2ef4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMmDayyjHq+f2lEIOGKF3eDNJIH3ZNfpfcQbt7aGF7udTO/IIj7LymRj+wgm4X54+ehz1oNTzS4dnTzxt3f9wC7QWdE+/YY6qWUOJ95xLQd5afHxktQctNyvmF99rDO4qIG33vlSNPxQljzG7+44Owu7z3XqsFiFLzi2MLw/DpUQkbJdRBBVoNwj9bLtLcQMf/qV+RGI9oyv/jogetvw3Q7yWpZileyozejlqyVczM5Z4qSMYYNRHCcB1DdiEpPYOxjL86ODZEQaUTPSGLa3WCEU1IiT9uoE3kUyVMVZq8bFMobpAHA+QbimdQGi+gPwfChoGDUoepRYqNjuo/alM2Qb5xXqFGks7v+/bpE1uwSPeE5lVX5DxoCWQxvUsqzxDl1wIa3aovyuNqqbvZqKYNM+r1uJYczxTuBXMuwcIKV5dHDWUh7VK+KR/bYwpsSqRKICrXjpI97faCYjsOc1PDuiaUzag2qTcm3Cz+qTnn5Y1YX+RL0kFhnXQFdunT/1SYms7Erk15tw3Mw8alumrwvZpgqypas/EF7QLsXeFbusVod7fKkG+W4R/sA4zZZvtRcLGYWQpKmCScQ0Cbm9oJHYjipqfTsiN9Lt/MpMbGl6K2Kg1mwuzo26H8VZ75Xp/3WvqbiGve/Fs+b7HxPFuljJNPHCxOq2AuSvcKoyNAsMnfz/cdvFSyb4G2v5Ut3GP/u3MCd6O/wi7Cy343Gq3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(41300700001)(478600001)(86362001)(4744005)(5660300002)(8676002)(4326008)(66556008)(66476007)(66946007)(8936002)(82960400001)(6636002)(2906002)(38100700002)(6486002)(316002)(186003)(26005)(6512007)(9686003)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+2bzED5sda7GHwt4qxpEM3rZMz7zuxqBxuZyA74i+HxO7NTZJH7yKbk+U8c?=
 =?us-ascii?Q?NA9ZVCVRecpAv9tErKDBuITO2Jdf0bdDXZPbKPX7hmSD/g0s0VEgOKByWzTK?=
 =?us-ascii?Q?6j12pgZzzs9TA2zMoH8qHBW5xC5FSqjXjkRyGSVo9ur7cO/xFeOiadZKv3z3?=
 =?us-ascii?Q?z8Tj+6JJ7ez7iz9uUWhilxevCHEYjFbhJN4kD8LmgmghW1gbD3iEO6n3m+Lw?=
 =?us-ascii?Q?xJ7gwLMlfeTDKuoCzqAoxMXZyY8hM+KWPvmrcbSwvLjL7TiHkFA1YYMumrpP?=
 =?us-ascii?Q?r7x9I2CMDhHop56AU/faTcHeJ7W/yzr0uR8GmXAb4HdBSVHbSciAq74bhtD0?=
 =?us-ascii?Q?Bzmmkq+Zq9aQiBivQjIyIgh/ONm3plzzZ0lq6dn/gRTn55uzUkjjhoSlt4iD?=
 =?us-ascii?Q?kmfrEudJxkYhJnYvz8bqYAjk2C1YeGODP06juvT6ONYtsjwHAYOKVEZ8Jpsu?=
 =?us-ascii?Q?/YUBef2yOYnloajVQXgMB9G5XdRPXiDEHOGI135GMty7porObr/DPu0xwKDf?=
 =?us-ascii?Q?/Hm71Cszq3Z71Ez0Qxu3Pu3XyklamazJ547Xr8ZB21xQNa1weNoaMNw4rgTJ?=
 =?us-ascii?Q?isY8PPY14QVjNHqgYVnVaLk5SuFuVogFEwbv2tVaAtxBzZRJJrNwZPGI9sDG?=
 =?us-ascii?Q?mDCHBJMrgBNZ/+qd+/5hrUGk7Brt5D7LFslrNptDBauzjQa/1dh5XhAOp7xJ?=
 =?us-ascii?Q?jiDCfqZzhJ/kNLG6/gbCj5lWJ1jljZkCypf6tlDZDJpcsmTldX2IYtUDzKSn?=
 =?us-ascii?Q?7u68DqaJ8rFII0idnphfWLIkmVysZ1letZNYT0/CzuLNdUQfKXlI16OiLCpD?=
 =?us-ascii?Q?k5c1uSb7eWswBcdI70rqZhFc4wmRobRDPdvIJjpXsKTTJp/75pB4KLlSkDs3?=
 =?us-ascii?Q?Oq+k7Qb2DrP6R7NjcIwcUEIq05Y2WYjJ0ts9O6AQWltnX2oyaaWikFV52ap8?=
 =?us-ascii?Q?koEcjeBxz8pa6g4se22a6lLnZXi6MHJEgYVw1eCUWmcp4ujUNeN8IONNvvuj?=
 =?us-ascii?Q?htUCI4MyI9EdvxQN2JMt1XkXSpTjqStHL8FDg8dsGMn+gt/XWeK0eWGs2LBa?=
 =?us-ascii?Q?s4hE9YSxCesIeHjjcUSe8IQw/EAsuLYK+FPNDu2ZcyXcJzVIvSDjvayLpGZK?=
 =?us-ascii?Q?tXcgOKN/Excw35XAAKkvwqnFNbftHmfjTTriDX3Crmkf/w1ezJP11webIDpi?=
 =?us-ascii?Q?oG/gEWe07+2FA6OE0BMDHl6CKDbJiq0qbSgwltCNwvDVSPAAnicXok3Hao9J?=
 =?us-ascii?Q?pb2Tc9EEf4LHl+Hil0/smioJzs8orn0s/NxW+4JBZMiww8kMSIJ69DPUTYen?=
 =?us-ascii?Q?EZtG0krHXSQVdtQb4I3rvndaE1Se34LPzZai+InEMBNBCkN7Tp5ULuZ3+VEK?=
 =?us-ascii?Q?f5vpz0S1aCjHnzJP5pn87oFj+jSDos0T5ZDzaJ/Ceku/PS6spiKKckLBMLIw?=
 =?us-ascii?Q?+GBREkzvIMLi5YF+sdyc54JsU+cQFkeeRDIVaGGfrHFW6+P+IpNZqmdcbcNy?=
 =?us-ascii?Q?Q7ZgLaCFz57amUqE/zqSFfNrmwUpVWvPWX9I2Mf62cqgrKg/PbMIGWdCcyRc?=
 =?us-ascii?Q?BJcF3NAy9scPwqBvqxrULWzh85mwxlF2lmFbrWK9PsjPRIi4+kDU2XjahYKL?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 086e8d19-1c73-4bde-4c91-08da9b2ef4e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 17:38:40.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIY3j1S5QZYk8rxwn+nqDyDe6Kl3AW/dJAet8MT6rrOtg5T+V2RR+zkRCmEMOQYcY/B79vsNONNgbPWAGzYidywZhEJT5IhcWylQnMFGdto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/dax/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1dad813ee4a6..36cf245ee467 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -765,7 +765,12 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>  	device_initialize(dev);
>  	dev->parent = &dev_dax->dev;
>  	dev->type = &dax_mapping_type;
> -	dev_set_name(dev, "mapping%d", mapping->id);
> +	rc = dev_set_name(dev, "mapping%d", mapping->id);
> +	if (rc) {
> +		kfree(mapping);

No, this needs to trigger put_device() otherwise it leaks mapping->id.
