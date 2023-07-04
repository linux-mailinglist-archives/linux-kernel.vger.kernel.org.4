Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7859747353
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGDNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:51:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4901DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688478698; x=1720014698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k0bn7LbFOKlMg/0+Q0huKM/p7FeKCHJjC8b6Wc+C5NY=;
  b=AjyVtzmuDMJKHU/n8/o2aMxJlZ96c46oAWLVZAukyy1drqtxjGYy08en
   Gi5+zNWNNoWgEI96olkHIdt2M//bRyVbUpODp9E8D2MwSDUiiNz1FVrxN
   BTjMnQWs3CtJPh9MaW7VrCaa8GMCnOqgU3vwFAzauGJlf8zdmL0CASy0/
   PjpYov4YJUC2o9TkBtrTH7p8HYIsdvKHBv7SSHmhhct6VMqR2V/b4Hjdk
   Y6KlD3jLdX6gEfAbtIEJ4uKZkEtTboPRhWQF5FHCoZCjYclkUI8P+clYj
   r7211/jGDOHQ9d6I4o1XIyIaPSBXMRik4DV8F8mdfzbZ4G+2AsQJYE+4b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366607754"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="366607754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 06:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="965510675"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="965510675"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jul 2023 06:51:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 06:51:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 06:51:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 06:51:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 06:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GerNCYg/fcLYTgAKga7DMA50E68SkDa2vvat/DJ3hpHkFKygE97a68nZ/b6Don18I1PCgSnI+HT0KPkVCssIY6ClVdgsDxnn5jygod8+60DBVUSeSubGJlEIhzLoKIiINLwwYasXScnkuqmnU6z0qdsl/jJRS7AxTAB8YAlhGZRYw/VgZJSsHwkDiEVbnMMD00E3ZJRcdkcj3zacO+ogaKH2iHVJhYjALBBKWAruqusOeEzG9eWiSsjgagchIeni+2ihy25FN92hA65hrT8aiEva4ywcAqT3y57FvdGbrcVA4jQVmt8he2NDaf53KiF5r45IjhDspYvpvsfhqesQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsuWI7g6+ZlFZiHu52BVEyTkh24wv8NdbSI+xjotETs=;
 b=YgFcTxvhAJbr0rB1e5K5j6LA0lFcYl7ANfCHB6EqBaiap+UN9cgoZCZIp1+7VUVYPAilqJgCi0nd5ekl0wWCn6nuGWJwdZlItkgwirDyuqGLRgpBHY81Uk2x7XYT7yKWk9Pnxowr9vocJDRkndVs3snt0U1cYPFf8MuqBA/z538ehvz03RUvAEAskjYqUcfM/iJD9HElxQtskwFXF2OhsKYJQTi0ekpF2xolAMM+9DrA59i1w7lgSSnmaQTSMWKQgXQj/7UiAJleg6q/yrJPpVfXKakYiJsL37Cky7cGe61q2Q81zVl+OEimFQI1BFo1UoS2iDTRrUVlyjGQ3FV9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:51:33 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:51:33 +0000
Date:   Tue, 4 Jul 2023 21:51:23 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <oliver.sang@intel.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <ZKQj238p843J4eZ1@xsang-OptiPlex-9020>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
 <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 322f9294-1d1e-432d-6012-08db7c95c6de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztOieO4yW8O2SRtBEjLf7vPLwk1xd0I/meQgY0W716QQtua73eME8SAKDPPgMYnnVlxtGwoNulHn6uqZoInlDI6/5fIGNlg2pSzU8pLw66OrFkYRVJm50wGnuz0TFKkWWf5dlujUmBZL7iwnF47++LIFLparU0M8+CtTc49gcdkz7QXD5pwSq1CHnZi7ENDCMu+sm0dPtHdRh8KfsYX6l4IXtMwzsTdDMdYiKEqkeylwDr/DqOSL7X9nBMIZiRamSQPoXinlg/pMBJi5OTTCZDMFUKQpdL6uKn5JSM5r/QqRH88Bx25ziOX//b5jQ8CgMDRMAcEu5HdgRvPx4dtbelp+FczBd7Ea52HfMF0pj4GVUBqWDiFYuqMUkunuemS7uXF6h10luDswd7sF1G3/2idsLFv7N/bEmw5xT7OlGkDz/JptQWonss8FFDN/eGmXhmdIe+6UYsVfgT7/9IivqBFxVopV2yzc0739tWmQuvtXGktRNAN3q099yE787fmTjFFgRBR/bnybHpw0UFJP84Xl+gGz7I8B67Hi6JZ9RCs3683H8C7VCjqrWDcoSMju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(44832011)(66556008)(66946007)(4326008)(66476007)(478600001)(316002)(2906002)(8676002)(6916009)(8936002)(5660300002)(41300700001)(54906003)(86362001)(9686003)(6486002)(6512007)(38100700002)(33716001)(6666004)(6506007)(26005)(186003)(82960400001)(83380400001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74gxEWPVl8nXqlKPyc6MsYf4uDbK0MbUy1gAS5zf8lZlIG0Q/6VlRY9lU140?=
 =?us-ascii?Q?82SwQWQl6bZEVR69P7YwHk/ZVbUES+RqTRiaLJUfRsdzC3pNaOQOVDJA/OSp?=
 =?us-ascii?Q?YWagZgIheML7bbRHHTYeeKKdDbW2+IGJoURN4vAqvFUWEAavCoOqyQmDAtPO?=
 =?us-ascii?Q?Oxg/ccNQhvvdl8XTVihVSoBz91JRPuSR/8y3Ukn+QMtIjmY4R5D0tR1UUaBt?=
 =?us-ascii?Q?O8XWDRibSngs9A/ol1ntclRmxnGbXNh5sBq28/Jah0BHTFK/+ESLtn5tE1Bk?=
 =?us-ascii?Q?807SrP1ki6AZqn5zCwycbp6fHeNW53mj6el8XwCe8JtNegTArcoLMCCmQQt4?=
 =?us-ascii?Q?x74S+CNeiSGhP+LULjPVTDEsTE4wlpyH3GAxGjDFxVzrrjgz6xK97+Y6cuQZ?=
 =?us-ascii?Q?+W2UNJqDHmhw2feszv01bjIbaz2sBeSF8gxn7EqBRop//c4b/W/fZNY8ZaWx?=
 =?us-ascii?Q?izTY6pBqQ9J73Hn0YyII/7dwoilmgEsF1xzDaHHZ8CdH5LRj1zbkDxT4Yf8t?=
 =?us-ascii?Q?OCZkZhYN5NFYLFCFss0tPxzEL66O5KhHmau9E1IU3VEQAVFOhCQ2wFDjr9kJ?=
 =?us-ascii?Q?brMnJmD0vRFStiGxl9PxLUANN+LyUs8jd2OjOnKAzd1NVNd4kMrPZoyAiOSm?=
 =?us-ascii?Q?rsUf5F2VIeo7dpUutDQ79d0c9e7TkLfb4cM9c9oEJXEWsHy/RwdWUJFxPJj1?=
 =?us-ascii?Q?2CR2NEAfySO5h/QH+ZELV3Z1pX/xcvSPKqegK2AWyHT9rgKP6eut85SVxOEZ?=
 =?us-ascii?Q?vq6sHxwDzVOF9/NrC5BxEhi/ebHO7zunrTfjhHwmhbCAXgwjJvzO/w20Cvjy?=
 =?us-ascii?Q?TEKko6kFTe+jRyfSfTlhbXBZ9Ng1QmVbni2rwDll6pTpFFk0nS6AxymIM6mb?=
 =?us-ascii?Q?oewnJqwzLItgozkZJHpWplQpHXwohJXfF/eA6ZAIH3XN0ZIyl7ueRqoSUX2y?=
 =?us-ascii?Q?+RQ5KaiworBQiXgJL9tO6koZRVAX+PwL6EateTJgx6FmVIZRZxxK4Fn4a8ID?=
 =?us-ascii?Q?hjiPikrtUS+7gO8jePPV+DAypUXtg2Fm2e5GF3cQixBzstivBAFPyx0rs2YS?=
 =?us-ascii?Q?+lV1AgSwMQrHDItSKza3vDvy7W3OYlgJ3Ofy+ldPcC5wNVJR00eWeY1AEmKs?=
 =?us-ascii?Q?/HZwPJgiBFf7XyOgyqE3tWgaWAHhDJzy5qMtEY+rWRz0lxSnClueMRdK3D0G?=
 =?us-ascii?Q?Zpq/vDVEw0fmzoJuzpfvUpYFzRdzRLZYYAGg9lDfu6sPLbMK8f82nerU8T/n?=
 =?us-ascii?Q?0BEyHfF7r8BnYP36zI0mHCcPu6MNHv9mVJhDsQ/KL3KSoxaqv6gbDf9avv4+?=
 =?us-ascii?Q?Wa9jvWc2YypaCVDJ0QzMv62U2xjzTMDu6BoAFTuxJweYPL7QiUAisMf9oQZz?=
 =?us-ascii?Q?KY2nWHWIp/6Pos0dWJ0z0NZL7wX246EPuh8jSAbhYtwUl/atjuoyqoAqrFTP?=
 =?us-ascii?Q?7xVawgnnt2LkBLNmClu1lsp4f2BsiyvTD59HFiRgGgF7mAfPW5v/spCN0Wk0?=
 =?us-ascii?Q?U+IY+I2m3V3ToGeEGcm7gTcaZ6kNzCCt6WJmXruOzbBp4YIrg/5Q4m+iaBoh?=
 =?us-ascii?Q?AYe61ye0eRYqCmCrfBQ8cJ/xEm4iXfW4OjBfcGFvFEwbE2IQChzlJN1Dt3W4?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 322f9294-1d1e-432d-6012-08db7c95c6de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:51:33.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Tq8D2JiudtGUweLyLkM8P40ynrf4depwTLWcxNhTtnMxLDEVe9v7Cbxydr+a+SsU/bYlVjKiqIlEEL7SiZXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
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

hi, Linus,

On Mon, Jul 03, 2023 at 07:29:48PM -0700, Linus Torvalds wrote:
> On Mon, 3 Jul 2023 at 18:48, Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > by patch [1], we found the warning is not fixed.
> 
> Hmm. I already committed that "fix" as obvious, since the main
> difference in commit 408579cd627a ("mm: Update do_vmi_align_munmap()
> return semantics") around that validate_mm() call was how it did that
> mmap_read_unlock().
> 
> > we also found there are some changes in stack backtrace. now it's as below:
> > (detail dmesg is attached)
> >
> > [   26.412372][    T1] stack backtrace:
> > [   26.412846][    T1] CPU: 0 PID: 1 Comm: systemd Not tainted 6.4.0-09908-gcb226fb1fb7a #1
> > [   26.413506][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   26.414326][    T1] Call Trace:
> > [   26.414605][    T1]  <TASK>
> > [   26.414847][    T1]  dump_stack_lvl+0x73/0xc0
> > [   26.415225][    T1]  lockdep_rcu_suspicious+0x1b7/0x280
> > [   26.415669][    T1]  mas_start+0x280/0x400
> > [   26.416037][    T1]  mas_find+0x27a/0x400
> > [   26.416391][    T1]  validate_mm+0x8b/0x2c0
> > [   26.416757][    T1]  __se_sys_brk+0xa35/0xc00
> 
> Ok, that is indeed a very different stack trace.
> 
> So maybe the fix is a real fix, but the first complaint shut up
> lockdep, so this is the *second* and unrelated complaint.
> 
> And indeed: it turns out that do_vma_munmap() does this:
> 
>         ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>         validate_mm(mm);
> 
> and so we have *another* validate_mm() that is now done outside the lock.
> 
> That one is actually pretty pointless. We've *just* validated the mm
> already inside do_vmi_align_munmap(), except we only did it in one of
> the two return cases.
> 
> So I think the fix is to just move that validate_mm() into the other
> return case of do_vmi_align_munmap(), and remove it from the caller.
> 
> IOW, something like the attached (NOTE! This is in *addition* to the
> previous patch, which is the same as the one you quoted, just with
> slightly different whitespace as commit ae80b4041984: "mm: validate
> the mm before dropping the mmap lock").

Thanks a lot for guidance!
I applied below patch directly upon ae80b4041984, and confirmed the
WARNING gone. Thanks

> 
>                Linus

>  mm/mmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 547b40531791..204ddcd52625 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2571,6 +2571,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	__mt_destroy(&mt_detach);
>  start_split_failed:
>  map_count_exceeded:
> +	validate_mm(mm);
>  	return error;
>  }
>  
> @@ -3019,12 +3020,9 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		bool unlock)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	int ret;
>  
>  	arch_unmap(mm, start, end);
> -	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> -	validate_mm(mm);
> -	return ret;
> +	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>  
>  /*

