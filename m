Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E061ECB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKGIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiKGIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:16:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6B13F85
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667808960; x=1699344960;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4ieOc8aQNp5cmGDaxCuTMKFEtZTTWjcfm+v9oJT1ZNk=;
  b=d1CLoMcBlLVrJoOq6+VTZu8FJdMMATS3EgZtLnAnBdecfDchCeFb26RJ
   JaXFxZbhiXa0hmJiBGRs4DOTqFaUZkDaqnE902V6PTs1ucpuPC3BsoZ0y
   2C5Zk/od8XCn4ILmKednj/S3H0ntbhalWPuNGDXVPucGeyUfHKOiX3ON6
   ywormcAYGPArWmpuIj04jmRug6I0kpyQ6ApCkgfTJtSZGIdR1q60yf58q
   hJNNXChDnaHdLnB/rFrHmd2z6/YBRyf6byIhSSVav/l3iIGj0YReDq9Eb
   ACcbm1h4pU3saB0DX9LeBZQ3LJdvwQUHT7JwzzWNFkLQ4zo4ofdHz5zBq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293700366"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293700366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 00:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="586887397"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="586887397"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2022 00:15:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 00:15:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 00:15:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 00:15:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 00:15:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXyjJ4rh+Dz40yDYY1olM0DOQzRV0cbbO7cKs8kdCsfH4xPj3WCapq8//GPQ0dUaJyknnel9R1vkzN8HnSlpUvmkY7GwzxOH8ftPs6gqwu6jgaw9XRN2tnmt+0hkh4NSgfLYdhjVpmTcMH4+yMsy+kLOz5TFEGHgc5OSHsR4qqYRB/2OoR6wNfIJlpIbkjop3FuVXNuim4ATnMtJVL9XlrvH2W9CdUNuC1VGboOEXwkENB5sKuMM0sO9/nMRLtwALeeL7sg7YV7WHBYWOGz0E3DeOE7lJZl8J+mkETyj/o5bdicjP3FgsoAMENuU96nIhmBIZPj45OVZYV/nXBR7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilTnoBZJpBvBC2LDEmfuiCoOFI/zMQ3qwHLo4maryhg=;
 b=QqsVAkuezxdl/Oft1+P1328HKQcgvNySr80+cB9xlqmv4c6mXY465m5MaftzfnJAR1bS9c8KTKiOSDya8zIHxXM5blKrfBj87uAyZM5BvoAvODm0TBie4kiycPkYvxUrSYTbaZIg3zSnPpkHZgI/4p32fMre8iQKOHQ/ew7PhKbxPvAGx3w6FMrNY24bbmukbBvYb3QSVgrOxGAjvcPYCkdtIjZgEDAOxL5WaeHpZC+7UW/L2/Iax4asUxxs26BSW0FOolhjTtDXiiTusbb+jnOM8VOMX48RYnSwNE5Ddj0izi5M2tIxEJvN60JnpUZp65P0uxYsG7M+BpzPvb0Bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO6PR11MB5572.namprd11.prod.outlook.com (2603:10b6:303:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 08:15:57 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::97bc:91e6:e791:97cc]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::97bc:91e6:e791:97cc%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 08:15:57 +0000
Date:   Mon, 7 Nov 2022 16:16:16 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Eyal Birger <eyal.birger@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [syzkaller] There is "lwtunnel_valid_encap_type" WARNING in
 6.1-rc3 mainline kernel
Message-ID: <Y2i+0N5zkwxmuyNO@xpf.sh.intel.com>
References: <Y2h7PgIkraOI1zVC@xpf.sh.intel.com>
 <CAHsH6Gt92EH7eC5MyL23G7ySYk4OyNoC9U=0Y7vXbbqVyyZ7SQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHsH6Gt92EH7eC5MyL23G7ySYk4OyNoC9U=0Y7vXbbqVyyZ7SQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO6PR11MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 745ce9cf-8233-4046-bbf5-08dac0984c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: su3gRNugxOOtnhx/NliogUqPb+BzozXZTR9Ad8AtG9DpDT1V4R2tPftFJV0ndf2vqzectmK8riG5JVtb21G6QSlGdYIZ2lm0cfstfGE2igUqHBnnALyhP6H7VTmB+Cbleon44nXSx0/r6Fke9F/mRWqS8CFjJjTfmIjSanPx400R8IGQVFJnYLaXE0t5SfaENDoZ1+mkzn1bQ3fEbNs+kud2uIf8yHhtezy5OpHSgPacfJ3qJR7aUzFrbcCTn/wKurrlz1pTZkMssQqMCFPa/xqMZ6t56WjZYubzfvcnSRpzWCvHxjefl1CD54lS88OynBAoE5b7X0ES0+KPJBFkIQDLKSeU1U1U9t6KmqRV6GL/u2CREFVY71shB82Wd/BM8NK2WjLlUZY5tfoqrXO3dO8KfMr9wq77HjQwIaMZaeO9HfOthVxHoi7YnMFLp0h6gT9GtmkxpE5WEwRcUhCkHv5ABAU+dFfuKts/ZXuWYJKlzILrIbSqYPpmaaBCyLlu+4Z/qY6TbkjZeHuON8R1Ho6idePxzVd9ZbIsD25pEKudJwhTKkB3muuq5JY3ZbIcOqtuqouU/cE8HOjiE6b69SNj1PTDnvkTHu1BtRJs5/h62Jivkn1tiBvyQcTY22GRWrXzR15M//NdbNB4QjHvW9VRp6Flv5iaXQ/3ITG/bqv/jT+sj+DbSDyT7ztwiKjfmoTYjF/LeeVc3p9p2PDtAltLdC/F/oiAXTpJG9OZGquv4btQFRXi2S3bhiVunanbHCMqnu5qYdn/tJecxXTkL4b2QnBqz7XmCxTM98AlQ3s2cxkPbQvwOwxSlSVAM0XD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(86362001)(82960400001)(44832011)(2906002)(6666004)(107886003)(53546011)(186003)(6512007)(26005)(83380400001)(6506007)(4326008)(66476007)(66556008)(66946007)(8676002)(6916009)(478600001)(316002)(8936002)(966005)(5660300002)(6486002)(38100700002)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1BL4KvWv5ZGaRj7cHEa58J01OQw5yCuEkEQr6L6PqFHbIWSo3ZgYZoAB56W?=
 =?us-ascii?Q?mUZdpKodi2vgcO75256oblwl3hbd3dxnoaZ5onhmkmGuwu5Yr2tae9lYt3qn?=
 =?us-ascii?Q?z9oyVnYjwJ1YwuD3fdHpo8Or7/ISK6eLm309XopOhnv/96LOKsMMecLDf7DG?=
 =?us-ascii?Q?QhLoQmcNWTonnJWPuojwy2f2zKR7lSDMLQ+RqOU/vSPwaTJWOB0GxeT+/veE?=
 =?us-ascii?Q?hGk1U2/q2N4Y0xEeAUqu4c6L2kFW/yzeDzq2AUiatagSLBrXye8L2tEm3Ddg?=
 =?us-ascii?Q?pXJj4isK2LvXUQQoy/0kjBFtXiS9yzm/dmhPhFSaskdYnoCd/+YOUbf9AgVE?=
 =?us-ascii?Q?cH4TAU366lX6dydShiQ94o1h5Cf3b1ivLg19ExpkHlMAIe83JARl4LVcFPKZ?=
 =?us-ascii?Q?5YcLF+zIz0BPO2SgH4EkQBlQzJYfZcUXHl2RP2v/vWwmmCXCW98qThHGWWC+?=
 =?us-ascii?Q?qHeRvNuOUY+fPTg568E+Gl5al/KVKH3fmOqDeaetK9hUDzFUl5Bq2wD8wBxN?=
 =?us-ascii?Q?2SLNBwKWs/12hHCOOFgyxtXQyGi3JEt7ZSuSk4VbyBoCu1aBIcYY5KXO8sb8?=
 =?us-ascii?Q?HWP191kT+VceY6FJEWUA1WqMdEg/nTh5xf8NauanG3suxcZ8FZZMUk9pOME/?=
 =?us-ascii?Q?HeTtl2Y3J8aMTshpuYZj9ysxVHOqe+gpQUpZIRc7xHJBW0HD6yPq7DsrlPNp?=
 =?us-ascii?Q?R2tXFKJEZ2Dpv7qUW0l+yOI7W3zETfQ4wflxreq3bq1W+FCqyzHJeSkPWglx?=
 =?us-ascii?Q?ihNJYVJO6flHqDBqf1d72T0sudcWX5hrxugJxWsAwUPAn3xiTsamJYjixltY?=
 =?us-ascii?Q?8WQp6K0d5SlItnamcaxWWkuAxLNSZ2RyB7xO1MYrcmCI/Yh7FWIz1F4nBmaA?=
 =?us-ascii?Q?nxj8f9Xp4+zrE4g7RvApL9kSVxdVUjOQfolinINGuC20unziJwG5RbHc0e1k?=
 =?us-ascii?Q?D+hxHpiRHgTLqp7jHkmoggaqckP687H3Qa6ZIPs25QZjDs0OzAbDd221VBh+?=
 =?us-ascii?Q?rByQSgDX5gDoDjlg3hguJtilEmFuIGL8BpzWylhsqxH3uq8xexW5Xjy85GeD?=
 =?us-ascii?Q?0bfuYgoCVSsMFoXb87e3D1nTE8iF7XrLMu5cY7tknC+ifmmb0BaFzJGnytVD?=
 =?us-ascii?Q?hIsMH8tikVQ39PUKXn4yeIjH03aIvV+SgHTHprsgvvHKvLm+SOVNGE/gtKwg?=
 =?us-ascii?Q?hC92jL9Co00MXecVHsbwBYGodm9+GsGwWbZqpeT44e87uRUqPqoVuQ8KHjKq?=
 =?us-ascii?Q?5vspRlMOez6uwF7iJNIcmLvZFAwdsNOgKa0Qqgf5bnDDKMYn+8rrDYy54MJr?=
 =?us-ascii?Q?P4dmwoZhMHnPKOVhQnO97QmV19xM2wEUcVuxLErz0ZbYUgT1zl1RuNuCjIJa?=
 =?us-ascii?Q?yxtv+jKgeMkNBa2TAGCjOy22ghDgfFYzlnRtqjGJSTJ72flCpxytdi8JpTx9?=
 =?us-ascii?Q?LTuOss6BBnfpLhTBWGvPDnu44Oh5PSQODg3MonMkdThJzK/I3w2un8eMNXWi?=
 =?us-ascii?Q?dsSbvFGluRb9dzRRrGfHspl8PPsfuJV0jfzz4siBv5FGhwjzfzoi8mC81AZq?=
 =?us-ascii?Q?u6zvMFZGUOWurEhiuHVgyymvNtZyxaBt8wbk6OiE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 745ce9cf-8233-4046-bbf5-08dac0984c0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:15:57.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDO0n1fQDKXp9sPau0iUAGCaiasyXvoKiDIbvtKo4fZeMbCrdEIbfnklI/as4DBPySgYu9aQFWh4vdluhKAtIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eyal,

On 2022-11-07 at 08:09:39 +0200, Eyal Birger wrote:
> Hi,
> 
> On Mon, Nov 7, 2022 at 5:27 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Birger and net expert,
> >
> > Greeting!
> >
> > There is "lwtunnel_valid_encap_type" WARNING in 6.1-rc3 mainline kernel in syzkaller test in guest:
> 
> <snip>
> 
> >
> > Bisect and found the first bad commit is 2c2493b9da9166478fe072e3054f8a5741dadb02.
> > "xfrm: lwtunnel: add lwtunnel support for xfrm interfaces in collect_md mode"
> > And revert this commit, this issue could not be reproduced.
> >
> > All bisect and test dmesg log, kconfig, repro.c and repro binary are in link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/221103_152117_lwtunnel_valid_encap_type
> >
> > Kconfig, repro.c are in attached.
> >
> > If you fix this issue, thanks to add the Reported tag.
> >
> > Resend the email due to previous large attachment.
> 
> Thanks for the report.
> 
> A fix was submitted to the IPsec tree:
> https://lore.kernel.org/netdev/Y0UwqMZQ6n+G%2F%2FaD@shredder/
> 
  Ah, thanks for your information of fixed patch, please ignore this email.

  Thanks!
  BR.

> Thanks,
> Eyal.
