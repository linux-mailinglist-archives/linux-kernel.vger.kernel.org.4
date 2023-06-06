Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF67F724104
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjFFLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjFFLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:35:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF78110C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686051327; x=1717587327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qGDK688RBWs8QqHZFXkSDakYz3SShIO+BkJRgaZ0UQg=;
  b=frE8lnk6Oy4LWr7Ao632DBMxAwiPutT2S3ME5+QVQokMnsaP9x4frN3V
   PdYSd8ht5Yhd2tnvOXaD2u3Qo7MaLmLsu1mchlUs3xzi1majQjWjTVWLL
   dk6q6Q/Yd+xWDOY66xIFdnCGGLcoudIaI8xpe3x8ml2VPduIb6mENylzs
   CgOlaTdjoaPg2pr2mripXEni5cb8IxrZme/8cnw/fkzXAo+8+d3I7HClu
   RGAPoYJMhW8NY6XrmY6182N4gvdGPNy0+UyPbKKiBJyPsBkm5Zt+6tZN0
   3SEAJmCnt5hOSXsuD4amckyC9/HwENhkSjNYzy/7q1HFVT4KzMqtNzOS2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355497452"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="355497452"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 04:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039145719"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039145719"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 04:35:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 04:35:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 04:35:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 04:35:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 04:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZrWTyr6IkM6g/PE6gvhiSmRwsZbhBgBtHQjqrQ4pGxCHXW4kRIGI5ZVCbrDml6dkPyBT2xYDuE/OmHQZpCyIAxtox8VkpFjC/f5wwuUL6y72954yXtO/5voDfPc9V34J9TY61Vl55iu9ZMFenLqsY//vLWeeUkE9xqepv8RXtTFgu52fnrzc63goR1LGS2ZbpA/x+F6gaUFCWy4aP6Rh25kD6d6Ifli5C3wcsybyl1Cgrgsv6pDpEWyvwJAv+X2+DaTtRfPF/Synv4r48YUjM/zctGbugV8QWxDPsKajP5ug4fau3FoIHiq8fMIlA2ZMpKsC9upEJfXNQRjtSDj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPj4owECRo+yLj9+mj6w4/SgjhoD4eEYUAZisGTM9kc=;
 b=mM6MkKcU5Xt3QGfODgBB3vqF/9E2IjhSuafosdVGtw4FdcXW2ub9NACUWN/QgpfBBrC60Es0MpgUmCgRtbiwe59/VJv3msAY6KaEZ1igvSuww68hyPpDojTpH6bpU0RRpjdcvDYlY5Fk/yel+IYEHHjXjnHRCWbNLExueMOxFlrxMNN+yvbwScmML+tfzxrz3/BqTDJXMpf3xN39k+Tbh1NA2wCVLIUM2jnDfarBcNgOUcyyIVmwTAwSvLgLYqb0zZ2nj++JD1e4TbmF2YJ5xpG51AtppyOB1v0xGcveaplDWxiv867qdDOWG6Dtk/YiGU13OsWwzadd1qPK57+sBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:35:20 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::6e71:ad0a:bec3:8df8%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:35:20 +0000
Date:   Tue, 6 Jun 2023 19:28:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chris Bainbridge <chris.bainbridge@gmail.com>
CC:     <paulmck@kernel.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <ZH8YS+LxMM1ZPpsc@feng-clx>
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN2PR11MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 7570c36b-827f-4afd-c41e-08db66821b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QUdDOcPJO63H3/kHbAm46mtaDECw7A+98TIZs58L2zlh5ef20Q0m5kZOLlJ7balFHSToVoDzhCwONNYY6/aHZPuA97SCgMXauH5JthrbCERKwlo3bhQXZwN22ZOKosHmRDp1OMnPg5cTDpORy2ZYJSO8Ex4LLT6NWUwPqBl/QvKJRdTL0G8S4iJkHnk0vq2AUhVBDu+oja0KLkGjLCkYVcGGhfW1FWmKje6qQAvQOvH0PmuaCxwFrVpd8KS3UKiAYUrsrgKaZwFwOWO3qEKbjS9mqMAqd10n77yzxDfPhvM1C5zn1Yx+nU06E/3xknSZOf9CXqJ4yomcPEelyFY4kTh2iGjCnKYqPNJ6ThhyMhKXjwjWh81DBDHQGvRnrIqDXHxWBlRvawNGKi6/qnusCks38hycbG9FyE9+bqGoO8wT/Wqgytjg7c1Q7YB5g8M/9DcMtR9uiwAmZ4oUFk0SwnIKgFF1U3DZ4b260u8QA0I72D5u9wkARabQVzvTrlgSzGq6MYSVdGzgMPQAPNe5eSxkffWIpi6iR6CbhLnjNKXEQV62NIEPfQEFRCN5C2MATeF1ybDKbotd+h1haZNGxvYPTfAiBqIVzTdUb/tH0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(82960400001)(478600001)(6916009)(8676002)(8936002)(4326008)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(83380400001)(6486002)(6666004)(26005)(6512007)(6506007)(9686003)(15650500001)(33716001)(86362001)(44832011)(5660300002)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lyvdqaPGU2CJ18Hclx2Rll+89dQ8pLh1iFYG5xys34bJ9kzwZqgsnppvG6cT?=
 =?us-ascii?Q?w6y2dlkBH5oRKXqUS5XsgkVbmVn1sRtoodR6BPx7cbkKtZ/dhBwi6Wm0hxJC?=
 =?us-ascii?Q?dAgx+ExKwME+SEhzvKxEG5mr56Cbjvtr+ZW65SEDpKS5UibpT4JS4YBmehoR?=
 =?us-ascii?Q?zivilxclptr0BOcMMTyYDxC3SL74iqZAObhCsRc8yH6cgcW9rMTTyh1aoH41?=
 =?us-ascii?Q?vGKz8Gq+vIVj9+WW2Ub73JbcmOH7DIVDNfNOUaBLDP4TfpgyWWlB+IFYoCPh?=
 =?us-ascii?Q?MPUamIuRQIKk1nF7AQ+DCF7cJdyi5sxZNrXgGpAzcGSlHvLw/C0yzrOXFedl?=
 =?us-ascii?Q?P6a/79edmI+3yZ/ESGKYX0FooEMAVRpntIxunQaLoKML91XIcTtxhlWS6lDQ?=
 =?us-ascii?Q?+iLGsx84Cc9YuZr0u5AQIn/UHReQuBM1isixalpknCiWECjK5ElWeUF6pUJl?=
 =?us-ascii?Q?IQrBu9u3ybrIETBb+uyREZx0iHxy4PBiWwU5v+dRwvC7gxyPewhnFRFc1I6d?=
 =?us-ascii?Q?8GPFinW78QrSwEfQqOQ0wkuMpyULcQ/zcZfnDCHA7AL5AckSzdYRpVBVQYeP?=
 =?us-ascii?Q?8p16MbLKVlMioNJuFWkHsuuTv5HwsjpHFvfVAGTpnBg4NoEHnhQ2pRxm8kkR?=
 =?us-ascii?Q?R8a8CnpyKwHsp+XpHAFhFQbFXq86pyjn7Cmg+L3UMLt6YPTZFAUA5lHGY2V0?=
 =?us-ascii?Q?ABcyk/bKBGmk7PZPQ+mmm6k1F51VDyfNc2+KGT2OJ85wRPJDy72lALesX1mx?=
 =?us-ascii?Q?PpdFm+4EZv5mrhAikJufRu8mDC1GEqohKBVzBUX1AO7yyeCnDJZ7qdr8wZxT?=
 =?us-ascii?Q?QD5Q5CDektvSPQ6q7wH3vjOsfKUudsG7VgaYT6Qbs8Oc342Y8G3a0+YIiO6/?=
 =?us-ascii?Q?QlmygF8vzY9kV9rsJpqgOQeeSf8uHKVss0he1dwVTsbC/OZ8imUHXJNC1EQs?=
 =?us-ascii?Q?+Q+39f9gqbjHTKbkljObNubuLvUsnJuCWyGyxnlSJi6M6C6Ewt7fpLIxgPb/?=
 =?us-ascii?Q?RA4ilqnxlRnOmqcTYWjWpYqQ9ovmnJs4IdPzyNkBphcsYD2xtKoie10cCVQb?=
 =?us-ascii?Q?fo2V+xXRGxxtfQgwq7jT8ArjL3WL0MEDGM962TyiOxI1V1ZWjj2vVUnc7Fjn?=
 =?us-ascii?Q?IwQUgCPfZegGHRDWLrtcnB8hpQU8wKi75T9sgLULcWOa0uOlzhq9m0FRO2PJ?=
 =?us-ascii?Q?Pn8hxVy/BdlYWKQhZHc4KNfzqOiBRk2baT1KMegfZzSh7Az6b9UlGgbB9Bjn?=
 =?us-ascii?Q?0eVTSroGHLwBVe6lHVh0a0qo4zlt8zF2/Vi/YIQcNd6P2VpW1Gw1lcAvBhKo?=
 =?us-ascii?Q?5WrsecTf+I1rKDMTqFs+lwkWD1lC8yM2kr19iu7tKHolSm4yPsdhJIIKCDSH?=
 =?us-ascii?Q?2cg3TWMA7P5S0rfh9erS4gyNtKRsPQDxy+l4VKvgIyI/1SqlfNYecnH4xSS/?=
 =?us-ascii?Q?9NA0D/Ignm6ekBDW4XrlQ1iiBcd4yiZZ1Jx5v5Rh2o0j7WzF4g4KwM1Pg8yZ?=
 =?us-ascii?Q?CjPcNcXV6wTlURAcKzSYVSx5UMNOgSlw1O+QXfMVB0ZZQiyh9b4WLVQMVFrV?=
 =?us-ascii?Q?zv4hn+ibvDTRzXBMIpT5/FwDvL1/4isqBJGWHwsX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7570c36b-827f-4afd-c41e-08db66821b6f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:35:19.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRM1MOtQArp3Pld2TpMElhbmm/P91xkIvldLx3OlIhFDFL3EdcoppGEj0fTYw34GxCRWIS7/UFylXcSgcWDEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you share more info about the hardware, like which generation,
how many sockets or numa nodes (output of lscpu, 'numactl -h') ?

Thanks,
Feng

On Tue, Jun 06, 2023 at 11:33:50AM +0100, Chris Bainbridge wrote:
> Hi,
> 
> I noticed this message in the log (booting latest linux master
> v6.4-rc5-2-gf8dba31b0a82):
> 
> [    1.416270] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> 0x36c4175520f, ma
> x_idle_ns: 881590509340 ns
> [    2.087102] clocksource: timekeeping watchdog on CPU3: Marking
> clocksource 'tsc' as unstable because the skew is too large:
> [    2.087105] clocksource:                       'hpet' wd_nsec: 512006134
> wd_now: 1c0c752 wd_last: 150ea9e mask: ffffffff
> [    2.087107] clocksource:                       'tsc' cs_nsec: 511127975
> cs_now: 65279672b cs_last: 618995074 mask: ffffffffffffffff
> [    2.087108] clocksource:                       Clocksource 'tsc' skewed
> -878159 ns (18446744073708 ms) over watchdog 'hpet' interval of 512006134
> ns (512 ms)
> [    2.087110] clocksource:                       'tsc-early' (not 'tsc')
> is current clocksource.
> 
> Note: Clocksource 'tsc' skewed -878159 ns (18446744073708 ms)
> 
> It looks like this message was introduced in December 2022, in commit
> dd029269947a
