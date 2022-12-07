Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F86458B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLGLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLGLP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:15:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109D1FFB6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670411717; x=1701947717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iIloGzfGf0WypCBT0wIvTKPSAU3A2QeV26VP6loiHLA=;
  b=NNYS/9X/MUmBqLn/y1aqtiFh+FLMsDRqrBBTFzSF7LzZUhJuhFmoPa9D
   tN0K7VyYzH5ip+3yhJ8TB37DsBVbuy7iaF6TRhQOLysPG4NNw8IHfGrtT
   fNoGJtx+iSwepGiyVfc3rWiLx3qlnYNw9/p9yTrcXrjiIxUOE7hXezilA
   YNs4N7kQuYvbX7jzpLp+CD4S/rshlcr9RItycgRgnT9H/Y3Fco81m3myv
   jOLxdRPTELdyc1zJaoMUA3aDdqi2EDCd6dP33eodqryXStjOZp6xD18c5
   84gRH7sCincGK3H0OwC4XdYKl2zv+8mad4VYRRRdJu5AldKGIdqPGgFf4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="379032880"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379032880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:15:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="788857083"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="788857083"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2022 03:15:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 03:15:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 03:15:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 03:15:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 03:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz0CVQQXYewmY2ZEwanbUcTDpiDE0NpB0/ktvgPL2zlsBDL16LumZnl9yPTQB6NKhRb5ToddLepPZojDh4I/XBThEZ9wKRq303PMdF8rIEOEqua5ZP8GYF6CQJnAR7o19wNa6T90DKeZBa/K+Q9xbj5plcZcBlnlLV0GFJyOzUbHWv3zwKsVFC2GwEPs1yb4/9eXoE1itAD2wU3wwa+FmqVfRO4bIwtfsJ/kdkKIdSZrThRKdbNx+fubCvQECZcPr0YtMdw/EqHkvKO8kP8cSU0NHwyHsCA/8+f7nRdx1NHHx4RTRpdEiRmja42H9XY8f9Gn4HfsFZq3urq1XschKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTTIAQonn4W7BE8EBpkIB+z9+xhP7rgFiQtxsQh6erM=;
 b=ZtzitrbJqa89j7eTVrnzsYyzkCs4/intZ4KDVIrO2EKdSEcxmn49ZyffCLy4n+oIYkL8OEcAK6np+gwER2IBzyr5y2oq5gUcg1IUBSoXk1cf/CUJK0zWBepBiYs0cN0hs7maOiZgn6i5vpeqngXjO4b2rxYhaav+P+jd/I3gmOJxrXK3hZ49GiyY3PXvu8nV75dp40bzwH8oBsuOtH5biukMXxIYwMovIkRva5xF/LzYpyPyUI/g9eYjAT97Ic2vxrCLoZsbgjzhB0tUPp+kZIMzcJ3nuH7Oi4ee42fuNGSM4LLsDz2WnpiBeCdPfZur06wpr0/gwmN/MZzOnKqMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:15:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:15:08 +0000
Date:   Wed, 7 Dec 2022 19:15:38 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jan Kara <jack@suse.cz>
CC:     <lczerner@redhat.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "ext4_xattr_block_set" WARNING in
 v6.1-rc8 guest kernel
Message-ID: <Y5B12qBrpHZpuAGx@xpf.sh.intel.com>
References: <Y5BT+k6xWqthZc1P@xpf.sh.intel.com>
 <20221207102555.m77yk7oznzx2b2xt@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221207102555.m77yk7oznzx2b2xt@quack3>
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: d85f0f85-748c-4a1f-fcd5-08dad8444c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZ8nHMhxhiGFxogeRXVUWkQMW0HMtCL/ACqk3hdwY41n2dpiPDhawh9wDOG+AFdkRsNbj9DvN/pTMEUo5eh12h9XOT/Jskqxdu19ys5GzZC4WfV+cUPMT2K6PXUjEwhysf5vQhRyR3lDosK+KljzAXmEVI8EUSElTV1SAkfi6c3alVQpouldgD8V/4KoHorbhyTPMdJLT63OA+oKyJ83sdZjIUNKPp+eAzqxWEQqyDZED9l0moXnpumv1nMr/ZugzBPAjXnqCppahu3y6MYrnmQjE2QKsQCBfBGryHDiWTdmx3DKby9VjPyFLKhZpSrMOrjnAIcBS/EmvRsChzRTIOYLgeyCFgxOtzjkJOeU3m2e6X8yzrUWNhtW8mJLroBLAtBEmlN0rjpqQckEmNbLp2ww6TreMd+2YCdDpTA8sK9VZnJTzLzNxnkt68ayxYbckx2FIM+GrjE36ozJqE1CZ+emWxRDmuvKUEzeThAWG6pahXv+3/u74prmkVjBq34hEJtU84IBDGTM80BKUM/TvLkhgU1fi1lGJFkyRwuGaqF1QKBDjaSAtXmqsiGFUB7qfDj2NODRUvGwq/JvrdPLFBLf30ZlMdLDLMCeEwxrxPxQI6AYKiqdsiuhIyCsVWX7xcF6v/Pri8cJyb9WDh2zQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(82960400001)(2906002)(44832011)(8936002)(5660300002)(86362001)(83380400001)(38100700002)(41300700001)(6916009)(316002)(45080400002)(478600001)(66556008)(4326008)(8676002)(66476007)(66946007)(6506007)(6512007)(6666004)(107886003)(26005)(6486002)(186003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfTKkIi82eykSTgGOKrPDLmkQicQQZ/T9uVhKFvSUiu7sQabx+7gGh1tfKGn?=
 =?us-ascii?Q?eIuj6rO5RoRmFboVhgnT8Jck/nUYFFyOYPQtB3cbbIBkVeGWjn5dyABF1H5z?=
 =?us-ascii?Q?oKzac0TdkokNe8rm+4MXVWUj1Q+ymDjeKr3d9pgYsO6XO/uWmVhuHvp195QS?=
 =?us-ascii?Q?DEwzmUKT4YPh9YfnmVCt7jSG7tmicytFH6rNE3ibIQEpactkrwWQ7GbHeK0L?=
 =?us-ascii?Q?ugO871s/lYlnxxoDdirFFrtXfZVxlL4xvsEqnRgnFK1fuKYpXEAMnUZ9kkMw?=
 =?us-ascii?Q?p3ZGUuwi8xQnb0KnYEJVAohO0cEBL39kBFIwUtzsatJ5VAfpXXqrYgdzMijS?=
 =?us-ascii?Q?FW1ORyGuNCRpFg62GN/+M6J5bgGRzB1QJ1yGn1Lgok862166g1qDGUn5SA/3?=
 =?us-ascii?Q?jeTKWHh4Mj46hvp1ZQdx7BL2jTmviBHvsxlhh6/EdwKf1MCIS1ZrrHqqcnqa?=
 =?us-ascii?Q?e2f1fXNit7MIfN+veL/VT5dskUC+O+WLXUNu3SCeqFcziVuATq30weOFa2q4?=
 =?us-ascii?Q?U5ECBREJxKxOyBKCu57cu62DaD/MEvMaUtzuVY7rcUsm6Kp1RPsGcalrY2k4?=
 =?us-ascii?Q?RA0bFbiNVAAkfNWrLT8L7qygyWjdv1RQfQjLv6JpKbpHqbBC+ijHd8Q8jz4x?=
 =?us-ascii?Q?kCPTziiTuNRd1pqp0ZR98F+7BhpGBHwk739BFYyQc+pmIbX/mUIFaGv4HcL+?=
 =?us-ascii?Q?k8LS1qJieCe48Rv++RUys7pg/JYTSwZyru3DvuIo0XRyI+SeTXY3kFc5kfBu?=
 =?us-ascii?Q?IumoZ2x7KONkAcxQv3k4aIc/3YEb91WNO+70aur49XPzIhvSfGiYZZUYO5nn?=
 =?us-ascii?Q?uz6WhpG4END1TNcjF5q+QfsZ8cEPToGfrEcpmx7zDaVrFLwXSk2n/C+Et/PV?=
 =?us-ascii?Q?f0QSgqi93o1tENkQAux2vWGTUs/k27vsvYf/m6r3XkU8+BOTa3BHc5JoOTag?=
 =?us-ascii?Q?oxCmx1jbE0Rwl9oZg4miCyJUulkVK/oK/p/hmKWqykd5PHEWhVoPL95ZZSwr?=
 =?us-ascii?Q?PmBkhKGayhRKcOuXJDk2FMj1PxzrMNsm2Q9Ox/Ku7Gx+SJ8ArmODkeWriC93?=
 =?us-ascii?Q?eIPEQmNWYAduQvbkL2bGvuya+OFhGmSoPRAtjknVEVYmZLbXvkkIyTex80qn?=
 =?us-ascii?Q?da0hGIEr04usgksqrgU2AbnIzKfk8HM4PeT0zaPDULNp0XyEqIr++y8UhM5A?=
 =?us-ascii?Q?WQevl98q37Oj9R50QBc8v69rcBKQJaL5Bsh+4uOOmzBciljHsqsBrhSQQmPH?=
 =?us-ascii?Q?FUwgKVxAU9ZzAt6AinEAr17cCHmeLibQQPY+DbmVcSJSouQm3HeF9LzSWPb/?=
 =?us-ascii?Q?Ls9lVJv6C9iAlfU3Ix+rJUW5KtvfCsqRYTEF+4rF+avLMoOica5eBoFYtlzK?=
 =?us-ascii?Q?+eJEjoSyB/hnTiabTWmPHkroB7R6aY0he4UiDpRg7SYRUT/8qSXfdn1EOMmP?=
 =?us-ascii?Q?clF/7bVl25jdbL4W8NLuGVGRONYNXpfYDudAY0kaAifzqoQNdGSgfcEBgPg8?=
 =?us-ascii?Q?ztwspaIFF8jAEt4fLYytAh8R2ips/tbt/z/n5R1zX8bbSMMrfvKl1BHv8Yxl?=
 =?us-ascii?Q?tMwSswnzoGEr6bDMKhMW4iElivosLeThKBzwp+p8oUCbshzgMOv7rpeM5Zbz?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d85f0f85-748c-4a1f-fcd5-08dad8444c7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:15:08.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OdMNquGWZS/u19mtbzE+0urlwrkxnSLeWyQF7uIl0Go4y1HXe76zgW6UBM2Ac8yg8saoUK/H/xXKYqPWh03hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan Kara,

On 2022-12-07 at 11:25:55 +0100, Jan Kara wrote:
> Hello!
> 
> On Wed 07-12-22 16:51:06, Pengfei Xu wrote:
> > Platform: raptor lake
> > 
> > There is "ext4_xattr_block_set" WARNING in v6.1-rc8 guest kernel.
> > "
> > [   27.922337] loop0: detected capacity change from 0 to 1024
> > [   27.922663] =======================================================
> > [   27.922663] WARNING: The mand mount option has been deprecated and
> > [   27.922663]          and is ignored by this kernel. Remove the mand
> > [   27.922663]          option from the mount to silence this warning.
> > [   27.922663] =======================================================
> > [   27.923771] EXT4-fs: Ignoring removed bh option
> > [   27.923947] EXT4-fs: Ignoring removed i_version option
> > [   27.924204] EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
> > [   27.925839] EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
> > [   27.928984] ------------[ cut here ]------------
> > [   27.929173] WARNING: CPU: 0 PID: 567 at fs/ext4/xattr.c:2069 ext4_xattr_block_set+0x170d/0x1770
> 
> Thanks for report! I see where the problem is, I just don't see why mount
> API would be really related to that. That is likely just a coincidence
> caused by the particular reproducer from syzbot.
> 
> The core of the problem is that we try to expand i_extra_isize on every
> __ext4_mark_inode_dirty() call. Now there are certainly moments when the
> inode is dirtied without setting up quotas - in this case when
> ext4_setattr() was called to modify file permissions but e.g. timestamp
> updates can be another such occasion. If the inode already has enough
> xattrs that after expanding i_extra_isize they don't fit into the inode and
> we need to allocate external xattr block, the warning triggers.
> 
> Generally we cannot initialize quotas in ext4_try_to_expand_extra_isize()
> because we may be relatively deep in the call stack and I'd be worried
> about the lock ordering. Also making sure quota is initialized whenever we
> call __ext4_mark_inode_dirty() looks like playing a whack-a-mole game. So I
> think the easiest approach would be bail from expansion if we need to
> allocate block and we don't have quotas initialized. I'll send a patch.
> 
Thanks for finding out the root cause of the problem in short time!
This is so cool!
I'm not sure why bisect commit point to "new mount api", and I made
the revert commit on top of v6.1-rc8 failed, so this time bisect could not
100% confirm the bad commit, maybe there are 2 or more commits trigger this
issue.
Anyway, I'm glad it's helpful.

Thanks!
BR.

> 								Honza
> 
> > [   27.929514] Modules linked in:
> > [   27.929651] CPU: 0 PID: 567 Comm: repro Not tainted 6.1.0-rc8-76dcd734eca2 #1
> > [   27.929931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   27.930355] RIP: 0010:ext4_xattr_block_set+0x170d/0x1770
> > [   27.930562] Code: e8 78 18 ff ff 48 8b 7d a0 e8 4f eb e5 ff e9 80 fe ff ff e8 25 3d b5 ff 4c 89 ff e8 fd c2 e9 ff e9 b6 f5 ff ff e8 13 3d b5 ff <0f> 0b e9 21 1
> > [   27.931241] RSP: 0018:ffffc90000fc7a10 EFLAGS: 00010246
> > [   27.931442] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff816fa04d
> > [   27.931708] RDX: 0000000000000000 RSI: ffff88800cb6cc80 RDI: 0000000000000002
> > [   27.931973] RBP: ffffc90000fc7ae8 R08: ffff88800bae3824 R09: ffff88800bae3bfe
> > [   27.932236] R10: ffffc90000fc7e28 R11: 00000000fa83b201 R12: 0000000000000000
> > [   27.932502] R13: ffff88800cb85800 R14: 0000000000000000 R15: 0000000000000000
> > [   27.932781] FS:  00007f69b3c68740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > [   27.933079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   27.933296] CR2: 000055c48486e5e8 CR3: 000000000b76a005 CR4: 0000000000770ef0
> > [   27.933569] PKRU: 55555554
> > [   27.933676] Call Trace:
> > [   27.933773]  <TASK>
> > [   27.933861]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   27.934048]  ext4_expand_extra_isize_ea+0x5e9/0xcd0
> > [   27.934242]  __ext4_expand_extra_isize+0x188/0x1f0
> > [   27.934443]  __ext4_mark_inode_dirty+0x246/0x370
> > [   27.934637]  ? ext4_setattr+0x1380/0x1380
> > [   27.934794]  ext4_dirty_inode+0x7a/0xa0
> > [   27.934946]  __mark_inode_dirty+0xa3/0x650
> > [   27.935107]  ? setattr_copy+0x11e/0x320
> > [   27.935259]  ext4_setattr+0xb26/0x1380
> > [   27.935407]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   27.935593]  ? ext4_journalled_write_end+0x900/0x900
> > [   27.935792]  notify_change+0x3f8/0xb50
> > [   27.935943]  chmod_common+0xef/0x200
> > [   27.936085]  ? chmod_common+0xef/0x200
> > [   27.936235]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   27.936420]  do_fchmodat+0x76/0xf0
> > [   27.936558]  __x64_sys_chmod+0x28/0x40
> > [   27.936713]  do_syscall_64+0x3b/0x90
> > [   27.936862]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [   27.937062] RIP: 0033:0x7f69b3d8d59d
> > [   27.937203] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> > [   27.937900] RSP: 002b:00007ffccac7eef8 EFLAGS: 00000246 ORIG_RAX: 000000000000005a
> > [   27.938184] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f69b3d8d59d
> > [   27.938450] RDX: 0031656c69662f2e RSI: 0000000000000140 RDI: 0000000020000100
> > [   27.938719] RBP: 00007ffccac7ef00 R08: 00007ffccac7ed60 R09: 00000000004028e0
> > [   27.938985] R10: 00007ffccac7ed60 R11: 0000000000000246 R12: 00000000004011a0
> > [   27.939250] R13: 00007ffccac7efe0 R14: 0000000000000000 R15: 0000000000000000
> > [   27.939517]  </TASK>
> > [   27.939605] ---[ end trace 0000000000000000 ]---
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
