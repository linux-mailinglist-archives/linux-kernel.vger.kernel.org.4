Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4884D73F678
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjF0IIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0IIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:08:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7451FCC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687853310; x=1719389310;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hzSFQ2PJe865D0/NRm4h47b4gpiDhlZf0r/up7soO84=;
  b=UD9bQO4F7B6Pw0b9ymA8TUmy1PZF1x8U4OAqTYSyeZpXZ257m5ghE1qL
   E1ulyiACf9/O4RnJDWGi3SXTUngXOzpvQtaiQlGdZkXZmpaA5SPvLwVPz
   JYgpqzf1/vtN7PLSVTp34dctKDlg/gDKqgAvwjvkiSz6HP3MIQmMT+dN6
   vl4gCkp+d5L4Nqk66fev1vb3ZFlupsxJHEo2NzIwFdk2RC2LxDYpH6GID
   iMJ6huk6wUcCw8Pwsdt+N2v9Pw4uN2b9Yyx0QepK/2Fr4IdxZ9bqASH/1
   6Ml8SHT1Usks6W8RgAuTzXb0m+QZLfjn/kSAcKcuRnGtKTv9KIEVL/6P8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425175415"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="425175415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 01:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="693755539"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="693755539"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 01:08:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 01:08:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 01:08:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 01:08:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 01:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrKXEsJrNPee5hcC2MLIvgc4f/3AkBSVQ0tH375hovP7h1xTSGPKL6qwAaC4fj/CeQ3naO3PtxZX3Nh8vW/4ZjMlrcLin4uq1lT2U3glp9zgGf0h5L3MngxlFaW7jkRL9BM/fQSrJ+gJp5nO5mQE0qEiVmN0Zgct1MJo66NnAp4WlnUsX6A/46cWYG9AYH2avCSACM5VBbIoxKAvhhQVWJvXutq/DDthnyFrAPx43IZSYKIBx1YYsIRsFeQ1sUdmlNxBQnaitATAQ7omKitopbOwdW2irF/1jNGk5QqZHOIDmvERmAFHmp2LIW/LLyoLl3vLuBJzD0Xqyj4eT+GkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCXGltE6AVSwpuqZ/4asgNoPavnpEWyc/yLDg4+AAoE=;
 b=jlceLNkcKj+ifBSwWaamQC681GyLZaZyCQb+BBaxm+VONdE2X3WAKLv6iXONrjdyVYF2gYzCd1seETtisXqIq0qECZ1b1O2hgaKsWCG/ruPs90PO+MVMlvkIEtuC1A0TBtFRbPpaPj7hiwOosTR+cOHudyWxlWtFmmxFU8sU+PH9RXKoXYeywkpMWCCOaMpj7vXrsNHsXuQw2smC31cc1hWt1QZFOnApru5xmPG6lw15zQCYBEaCCYaujj1EOg2vUmq7je/fvsLZ1UpLkYP95cAIQ+L8HWd5jsdIrA4Hgbk3bnmItadtEVE0NWzdzugXIE7IVgUc/gKxjL01/TP8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 08:08:21 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:08:20 +0000
Date:   Tue, 27 Jun 2023 16:08:07 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
CC:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
        <yu.ma@intel.com>, <lipeng.zhu@intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <ZJqY5xnCv7BNkWuj@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
 <0a611696cbc63a3a9b99a7966b8fe4f7e20a014b.camel@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0a611696cbc63a3a9b99a7966b8fe4f7e20a014b.camel@linux.intel.com>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c7a31b-8641-49e8-fbc7-08db76e5abf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYCnhgigNltBDQbIXKwcVr0JzL8cNW4Oode4eVCjsGKQUJHezlsycjxaDEVcGZT0tHiYWRgxhugPtAoNA2PKZ/gQzDsmGDvlfjdRegqFsaINo4ddnqTxURPB0ktLjkuq05U+5CU5vpKTFfWAiygHCw05OXhNYdfP7uSwB4PtCrTFJQIL2QuNbgdaK5cnUgqcjkv1L5NIwIUIqImIhP1QX+tpOvWoeJcy5cK0CyA0AQbB89BuDDAqfULuv+9x4uJLcZClehjBu4DhFBgD6fDWioDo+nxEvXuzIc9318+KWoF+tEHmcoH9YJpxWI9rMszFMfuAwCQ6VjWUoBWKE/WLGNuSPXSE8Rsu87TSjsRwRUbCXkHg95nkNlM8shiQBmbIgdqSMDLo+RHsGpV8BhQs6+Uoz8eCRPm5OZI11Ouy3Zv2Uat+7N3OSOzRftC4KPrHIcDM7It5Acp984gugK/QxPLksevHu8VgjY1hvXYgKIoO6LdtcmlvdbxWgJWU7R4JBucuNtS4oxTtkFCOeR97c5aCir03i2RFT5FZoRgYbt8nGcwvvqZIrIIEkjXYqBJW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(4744005)(6486002)(6666004)(82960400001)(83380400001)(38100700002)(186003)(53546011)(86362001)(6512007)(26005)(54906003)(41300700001)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(4326008)(6506007)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhJ+iQYn5Oq3ceO6hjJ72Cw0aYm5bpQQVbPAk6QM+C7JdApMuJ0lwo135DkH?=
 =?us-ascii?Q?ozdJ6SCpXi/0JNx5c6zvn9VlfHJ4JGKLvP+NcJFDpoNM7mCL0FJO8WeIvfPw?=
 =?us-ascii?Q?q9buOYIIs/kvHlZleWs6pKYkes+D4REgi0pru2gkJSO1eKF+ydkYCquF1rCb?=
 =?us-ascii?Q?A1zxZq21A/iK9Mr9Qxdwns+gTFtNiBtzV/yeFq6W80qYTTMLwU7PSOKiAIHs?=
 =?us-ascii?Q?p1CW+FmuooOWLnrSRAtb1pNoel7f/dUgl9utD2cEcRNhq7Unb+Q4c/uuuiR7?=
 =?us-ascii?Q?9QuMvr6oM22wlvUf05/HB86zogFno0g1Jw75McSP57DJoj02tUnlCx946UCr?=
 =?us-ascii?Q?kyz5WLjIw4WsipJFhMrCEcWn2e3PqZkX0X4N566uOdXw/ArMavOvIt0+J6Ln?=
 =?us-ascii?Q?fS3X3sj8cqqrrPcYxdypg6AzfcwWVPnZP9lEMpo3QGcQmXvqi/ht1JrpJb7M?=
 =?us-ascii?Q?eqCrMlvhkd9ByYmY8y6YsFFfC+Att/qA/KlAWmWsaGXZfOmCTS+FAl2A9ApL?=
 =?us-ascii?Q?1hAaUsZ7ct0Z9h2tTkCbMU2VPdLZvw/chPwE13jF+ePwXQOfEMN5k3lzIlU4?=
 =?us-ascii?Q?xsE8DT8cstJ1bpZjYBslJ6EhTejkMb+alvOdzs7Dp5a2ACrz595uV/ci5Zy/?=
 =?us-ascii?Q?3/c0vXYNXS2s1mduJuNoz1+n3uKiwNj9m6qkFO8C1Dhi6TySurw+xPnwRobs?=
 =?us-ascii?Q?bq+g6yHSQT2ls2C0h2o3QpsJDypzSzFn37z2dPi0eQHaXC3f9c+Q/SY1+Adq?=
 =?us-ascii?Q?f6h3x1vqp5+euqObD0+lZYBA9M1M64JWxMb66mJxh4W45o7Rd0NTM5GHxqI8?=
 =?us-ascii?Q?MLtjy1kW32pcp5bTzH2GmArSAr8Szd2UBBmmgWRddB2RkQo15jsP/Kbh9x9k?=
 =?us-ascii?Q?audZEQdf/w4JQnC1jwdfYtQAqKOeI5LDjiC2jLZ8BNXTe7L4Faby3tAKLdcy?=
 =?us-ascii?Q?5M+ubOXq/lJ2NsSEOeZMJ5y5MEa+xFv3Kw9OoCwc5MrtepyDN4thNKIV/pNW?=
 =?us-ascii?Q?+/aHkwvybWa/guyoPukNJYqcE+W3wojiemrVw/6n83AAEgVR+d3uEfRtecah?=
 =?us-ascii?Q?icGxODDB4rKxyJxTeywH0lmrFu3k4REk2inVsFqo4bBUF/CshWMqY8xycj61?=
 =?us-ascii?Q?Q7yMckneWNfosxTYR66dDH7SZQrEdLMT/T0bVVr2P7jIHMofutW59aF13iKw?=
 =?us-ascii?Q?xm+NyfUPwV9+uGOhfs4JAIWoKsnOSgXC6zFMXuDErtBINQ/CeQZVzXlg2+o2?=
 =?us-ascii?Q?E9KeTJbuO+wXR9pgDMXrSu1Jx82HD8+1jIak3mteL9Kz9VbgClTPIhSJXLJb?=
 =?us-ascii?Q?AKLiFy0gFOJS14NjDquS60hr+IzK2m38lNcwEdIqjVP3lqq65NW7uDM/WlTg?=
 =?us-ascii?Q?NmXmZQFs7GiO1F4HhWxPatOF15VMShgzeMOjgLycWmG2QWSPW7oVBcLDRRFL?=
 =?us-ascii?Q?Q+JdmbzQ4fY1gv4OL+FaxdmnQGqGzh8m8wXmGZ0ehxhGv1c4vQxTgVyFWl51?=
 =?us-ascii?Q?LX+Doh9KEQHGBrmn1aXUylF8gQeWnCnsAJbm/szlQY2xPEh7i1pzcQkGSWjc?=
 =?us-ascii?Q?sTOgwjQQeoAVsIZ1eUmHU2BPDJWR2x2zl6AWQmoI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c7a31b-8641-49e8-fbc7-08db76e5abf8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:08:20.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaqV/xhcVlr5N0IMBUiQr4u5uD+EENK/X3s/KqkIodP5NTQj9OM5f02IrEnxNuZ0Z1Jcpc59sNBpVPh0aXCN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
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

On 2023-06-26 at 10:09:10 -0700, Tim Chen wrote:
> On Mon, 2023-06-26 at 15:52 +0800, Chen Yu wrote:
> > 
> >  
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..067f1310bad2 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
> >  #endif
> >  
> >  #ifdef CONFIG_RT_GROUP_SCHED
> > -	p->rt.rt_rq  = tg->rt_rq[cpu];
> > -	p->rt.parent = tg->rt_se[cpu];
> > +	if (p->sched_class = &rt_sched_class) {
> > +		p->rt.rt_rq  = tg->rt_rq[cpu];
> > +		p->rt.parent = tg->rt_se[cpu];
> > +	}
> 
> If we avoid the assignment for non-rt task, do you see it further improves
> c2c bounce?
>
I did not see noticeable extra throughput improvement from netperf, with
above change + Aaron's fix + Pan's cacheline alignment adjustment.

thanks,
Chenyu
