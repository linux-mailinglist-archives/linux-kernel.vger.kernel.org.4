Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03B6877FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBBIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjBBIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:55:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573723ABD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675328149; x=1706864149;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=otmWmhNWSZ+TyNqoozhBuNo8P6r9ZQ6UeDbgmRFSSaE=;
  b=BJ4BfnoZ1jVWpUpyn4B+Q+0thYEn/oyYhleIJhVMGM6qhniTgj2HoIb/
   GrHc4Wx6POqSL2kGbl4+y5GSF1fXcmAlktx4VLFtQOw7ZJvtx2Lpd5WOU
   M/9MXVkLL7putao/5kwu53tLelVGfjD1fGAeBVeBY/XCkZlCYlMIi6xvC
   kLmEvpdIE6R5igbDajK/X+vma5tUhFhWAKNn4XESkrhFyjKhtE2UtePUx
   2h+4I9jh1g1bWBOhi4q5Rlanrt/LR0WWsG2J2+vk4P1r2CrKT/bsIpxFG
   211M1L7XXD5JLPkBZw7H0RanGw0yb8bd42of7GopgPEJ6S1ERmOCNJm1r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308735875"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308735875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 00:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="994000010"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="994000010"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2023 00:55:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 00:55:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 00:55:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 00:55:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 00:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAIH/GllTJ6FksWIOl7doAHd5W84lF9MVqigGX+Nu15gRbpOnbmX9eLkA4hnXhymE41ehuQ3AJLRc5GN7gzXc7mxk8d6FsO2RcZKcW7j2uyioWmTP3ZRRzHaHnHIXkMdlMTJJ4Qph2ebxndmWlWjgp12eZl3j3jGwFfslllhOB9n+lxuqMWLD0FUQ3hD+vWrfxQ1WG7CG+T3FIDQrGjrexgMspIvMN08Om+y3bzeT1v7Pt//fyqJ3KWg5k9Oaa9mtorKKROO+R7nZNyYJM8qdv1tdKwgNMbko9GtqnxyAA/KFAARMYm18gPL4rWKTQVqUaeSaKS1pQIATM3wDr8pXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD+gVOweRurBg6EHG4G4vjVkEE2HLWO7C9NBWdhcP8c=;
 b=Rupojarb8GQW0KlZCCPhT1cTW1ol+CDYew3jRJVJkhToI0eElgCea+Xj4UPF0TSHPwKHV3t/2KHUSmgxuWx+GK9lAidWmgl2TR8PR3988VHqomFmt6i0VGBDSOXFQzWRDTKqdVU0UgX6PZWHis9cM4RM9EVNka9SLN6OpkW6Aa1Sx9NjnQmfGSggpW4HFgKzPnISr+BnfbAIc51gkhc8NOUhiAFOQ4WwPCmT+xtrJhyeJbPLWtpKUvNvgbcvri6n9opl8C2+5Qg7R+JZBQ8+R8y3ms1RDR0nP+7hkzzYzR//SUyxWQ8KXcaVAbpQDSEwwojKTCjK6CSzSF4wFJ/mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 08:55:19 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%5]) with mapi id 15.20.6043.033; Thu, 2 Feb 2023
 08:55:19 +0000
Date:   Thu, 2 Feb 2023 16:56:21 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <axboe@kernel.dk>
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
Message-ID: <Y9t6tflIcFPy84S5@xpf.sh.intel.com>
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
 <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
 <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: f18f997d-1e6f-4cef-4a0d-08db04fb35f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsXznFJ4KzadiFEL+N37ehGQzYQJ962kRu1S8N+rkIGhRiP0bUYa536pY2iORYcv8Bd3sCEsJUdWjnOA39MOpqzaJk/htaKuWBXr16xzwLuX3OqUP5igri/H08fknh94nvplFew/aG0MQ0UIDUNEuTvxSsUQl/qlGtpTqDyPT848MJPaphQqA9uJidTSWT7ENeCta83+Fw2o0oYeoeVtUBPLDeLgVgHKzGvpG44M/oIRNZ1T43Qe6IWiyi3ZrtmRkdUfH58vedni1ml8ToXbzb0dMo3YDmUkaigIs6PTIjWDmItuVQt3UeXF4Pad+A/q2XD2QStwEUJMkjfe5DZ/4i9ucDmPkeU20vtFgDL/5XxwROwcfPRUqzFR2oG/JWmvXXLsBAdKlVD/g8WOa9OAXc5RxHLuuJWnit5YcAKeeZHpOp9xx6Buvyz7snl4xq4oLgJtiHcRfOOhYn4dc9hzrzUKTM3jzALrocOglIXJ3QHSyI6jp0QFgphe63r/xGgZ1v+S3wAuDzL/RVGnR5gDUEmqdjE1UKfRmmnxNbX38zgKjx2BAE893fi19waLSR/nKyQhB33x9sK8MkYnBm3VcA6nx7zk3k7BE7NiNrY/2oY5xnQMk8uIz1hANIOfoE+8WxYmIqaWSso/SW90Hi1T5lmFAqRWN5+fgAf/F6OpxX04jH/vZBC9cNnG91U/Kp2RogIhjPUtVRGRcCSrjrO/Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199018)(8936002)(5660300002)(316002)(4326008)(2906002)(41300700001)(8676002)(6486002)(66476007)(6916009)(6512007)(6666004)(478600001)(26005)(66946007)(6506007)(186003)(66556008)(53546011)(966005)(83380400001)(38100700002)(44832011)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AZd7TZMPfoJPEX5O3/Od+92Xd0S8JbilSpoBazgDi82pgS9g9lF5OZl5FS?=
 =?iso-8859-1?Q?rbCe1kQNfEZD2HQ4g9L89xHfme1ryopNlzupx1bCgrVuzG33fmQPVyyRjY?=
 =?iso-8859-1?Q?nqCHznHchh+artkpVcNVR8tO2vuVK6jt0DvVoLcdYsN3u6806TzHhSBhzn?=
 =?iso-8859-1?Q?nKoXNw72UjVzxgFQ1D1mYUnVxvY6YzfVFkCsSV0BGaxd2Xi3Bkj4yLbFE0?=
 =?iso-8859-1?Q?vwvB8x2tfYKqG3dMIq4vxMIGo2ADZlYMvIwFj3VmrGnBIlQY4j9jkBPIoM?=
 =?iso-8859-1?Q?H0kqFaw+HobCwkn18R7MMlGnURjZVvSckq9RV4nsDXyQ5gnDLdkki1sNhN?=
 =?iso-8859-1?Q?ngjKBUq+HpSbHQW2ZVcupq5rdY+3OYQyU7EO2Kzig1nj8G3RR2BTk/Lc96?=
 =?iso-8859-1?Q?m3XH75sPOh7sX+qpss3JmbvplaS2opnMJePsRK6glzXHNIk8GuROjW9Fy6?=
 =?iso-8859-1?Q?oLQClFjX6OLQ08sn3B5DqJ7SeU5jeNGflyncPknfc9sLSNHAHuOjdD0V09?=
 =?iso-8859-1?Q?LMdTo0+Pe1avKAHhElYQc4MojIHoVFNMI3GJ8S18rNsk49tSSzZ8/9EoAB?=
 =?iso-8859-1?Q?iAWLHxpiZkdS32+WPPoZs9c86z4hEjHuubDh9iS9WTcL9vynJIJwLVuEpg?=
 =?iso-8859-1?Q?MBq8niL9SUi7fJfUZzeyRkrwy6nfwKOxykELybxz7ojTDT20o8opaeAhqk?=
 =?iso-8859-1?Q?yCqACXKSQ8vKFIblF80+7Rx/xj+zoari94Qy1+W9NbqvCZdIEhXhyT5Q4x?=
 =?iso-8859-1?Q?3Cpu40fejTUEWlYvcLkb1aGE+cxmHC9aFomlwCxiXxDbpf9ERkuNtuVNsJ?=
 =?iso-8859-1?Q?bAxwr8C2RCJx3OnaBiyox2FJwTkud7XH5XgHTM1uOjQs52U6SdCkMMvAL/?=
 =?iso-8859-1?Q?0w5L3U0JTDuwJe6Etq/tZHoFoCanLFG4GhWolTvPIFEWcK/7wecIVgYjzm?=
 =?iso-8859-1?Q?h/Pz2spd1yFCm3utxNmwWv5dCJL5FxQhJev7R9eSOpXw7k7zRdsWPaEaWR?=
 =?iso-8859-1?Q?+Wg+wl8deslnPf5/Ufl6rGxs2frLkeSeUxJaVK5r9HFRyMMHD2y+7zJSvu?=
 =?iso-8859-1?Q?SZA+OwtK4y8lTpxdNNuuZyphpPDlc62/kD2IKQmgzNN5AGJemgVKOYXrnC?=
 =?iso-8859-1?Q?POAqgcbDsVjqVjk5mZhPti9QsPO9I8nhdC0YMgHy+se882upomEBYWjfDd?=
 =?iso-8859-1?Q?D+56w3scgPdE0r94+4OkZykoU02qyCjVncJt92C1DrH4rbq8kPJjuspo0Q?=
 =?iso-8859-1?Q?6VXyooKrhQewxvOOX+YMO9rCYQ1fHsLCqNMCu150OLni0Cx/dWgaw/1Vq3?=
 =?iso-8859-1?Q?u/JwD6JR84PJx8nnZKC/DWzoDyeW0C5Mv27lkpj0fLWpmP75+3VfLbSxaG?=
 =?iso-8859-1?Q?MUZoXHK66uZwSiHjnITrpzIy2mpq4Bmd5GnRqmVfJOo/AYgr84q6peWb4y?=
 =?iso-8859-1?Q?T+hfm9/U5mpxAXBWLvji7fShF7rpt/brEgeqE0Y3AlyaDFQ03I2sYhwMUQ?=
 =?iso-8859-1?Q?DF++etrM5evlU974u+2yDqQzFVkyPHK4wmV1SOak0NBBVegapKpluVnc+A?=
 =?iso-8859-1?Q?mA3lZPlz9ZfE+Y54Hlt5WmymVknidRQTXvAyB31nKh9da9LbXpkLIu2MvA?=
 =?iso-8859-1?Q?JksaRVkHsdsbkwMhzcaip2HQM52j67ABjK2tJWv/Q8HIj1+uSJGt5Gkw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f18f997d-1e6f-4cef-4a0d-08db04fb35f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 08:55:19.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwdxxCLuxdLzIiFS/kY8+3DbZWy9DqaVrues09kYU0RyGMMspwWHQKr9L9wU9NSiDQpyH0/nz7qsckQfe13opw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel Begunkov,

On 2023-02-01 at 15:52:47 +0000, Pavel Begunkov wrote:
> On 1/28/23 14:49, Pavel Begunkov wrote:
> > On 1/28/23 08:44, Pengfei Xu wrote:
> > > Hi Pavel Begunkov and kernel expert,
> > > 
> > > Greeting!
> > > 
> > > There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
> > > on Sapphire Rapids server.
> > 
> > Thanks for the report, we'll take a look
> 
> Not reproducible for me. Apparently, the repro creates a normal ring
> and immediately closes it, then io_ring_exit_work() hangs waiting to
> the task to execute task_work.
  Ah, I put the reproduced virtual machine in gitlab.
  git clone https://gitlab.com/xupengfe/repro_vm_env.git
  cd repro_vm_env
  tar -xvf repro_vm_env.tar.gz
  cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
     //start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  In vm and login with root,  there is no password for root.
  After login vm successfully, ./repro   to reproduce this issue.
  It could be reproduced in about 6min.

  If you already have qemu-system-x86_64, please ignore below info.
  If you want to install qemu v7.1.0 version,
  git clone https://github.com/qemu/qemu.git
  cd qemu
  git checkout -f v7.1.0
  mkdir build
  cd build
  yum install -y ninja-build.x86_64
  ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
  make
  make install
  Done.

> 
> It reminds me a bug we had before when the task was being stopped
> for debugging blocking task_work. Maybe some signal interaction, or
> vm and/or syz magic specific.
> 
  Thanks for your info!
  I hope it's helpful.

  Thanks!
  BR.

> > > INFO: task kworker/u4:2:32 blocked for more than 147 seconds.
> > > [  300.212512]       Not tainted 6.2.0-rc5-2241ab53cbb5 #1
> > > [  300.213087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  300.213921] task:kworker/u4:2    state:D stack:0     pid:32    ppid:2      flags:0x00004000
> > > [  300.214849] Workqueue: events_unbound io_ring_exit_work
> > > [  300.215506] Call Trace:
> > > [  300.215789]  <TASK>
> > > [  300.216051]  __schedule+0x385/0xb00
> > > [  300.216467]  ? write_comp_data+0x2f/0x90
> > > [  300.216949]  ? wait_for_completion+0x7b/0x180
> > > [  300.217445]  schedule+0x5b/0xe0
> > > [  300.217836]  schedule_timeout+0x561/0x650
> > > [  300.218301]  ? _raw_spin_unlock_irq+0x2b/0x60
> > > [  300.218816]  ? wait_for_completion+0x7b/0x180
> > > [  300.219341]  ? __this_cpu_preempt_check+0x20/0x30
> > > [  300.219893]  ? lockdep_hardirqs_on+0x8a/0x110
> > > [  300.220384]  ? _raw_spin_unlock_irq+0x2b/0x60
> > > [  300.220881]  ? wait_for_completion+0x9e/0x180
> > > [  300.221382]  ? trace_hardirqs_on+0x3f/0x100
> > > [  300.221868]  ? wait_for_completion+0x7b/0x180
> > > [  300.222379]  wait_for_completion+0xa6/0x180
> > > [  300.222897]  io_ring_exit_work+0x2f7/0x747
> > > [  300.223383]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> > > [  300.223947]  process_one_work+0x3b1/0x960
> > > [  300.224446]  worker_thread+0x52/0x660
> > > [  300.224884]  ? __pfx_worker_thread+0x10/0x10
> > > [  300.225376]  kthread+0x161/0x1a0
> > > [  300.225782]  ? __pfx_kthread+0x10/0x10
> > > [  300.226225]  ret_from_fork+0x29/0x50
> > > [  300.226688]  </TASK>
> > > [  300.227791]
> > > [  300.227791] Showing all locks held in the system:
> > > [  300.228501] 1 lock held by rcu_tasks_kthre/11:
> > > [  300.229003]  #0: ffffffff83d617b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> > > [  300.230098] 1 lock held by rcu_tasks_rude_/12:
> > > [  300.230601]  #0: ffffffff83d61530 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> > > [  300.231733] 1 lock held by rcu_tasks_trace/13:
> > > [  300.232244]  #0: ffffffff83d61270 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> > > [  300.233377] 1 lock held by khungtaskd/29:
> > > [  300.233842]  #0: ffffffff83d621c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x27/0x18c
> > > [  300.234866] 2 locks held by kworker/u4:2/32:
> > > [  300.235351]  #0: ff11000006045d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2ff/0x960
> > > [  300.236502]  #1: ffa0000000117e60 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x303/0x960
> > > [  300.237696]
> > > [  300.237882] =============================================
> > > [  300.237882]
> > > 
> > > Bisected and found the first bad commit is:
> > > eebd2e37e662617a6b8041db75205f0a262ce870
> > > io_uring: don't take task ring-file notes
> > > 
> > > But after reverted above commit eebd2e37e on top of v6.2-rc5 kernel and made
> > > the kernel failed. So it's just the suspected commit for above problem.
> > > 
> > > Syzkaller reproduced code, bisect info, kconfig and v6.2-rc5 dmesg are in
> > > attached.
> > > 
> > > All detailed info is in link:
> > > https://github.com/xupengfe/syzkaller_logs/tree/main/230124_055801_io_ring_exit_work
> > > 
> > > I hope it's helpful.
> > > 
> > > Thanks!
> > > BR.
> > 
> 
> -- 
> Pavel Begunkov
