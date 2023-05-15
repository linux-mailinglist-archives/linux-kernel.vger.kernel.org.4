Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19770250F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbjEOGm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbjEOGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:42:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A5D2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684132938; x=1715668938;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=dcjAfN/s1BY+D4Pv2lrSOqWlguayiNE3TAUuIHYYieo=;
  b=DpvVoB0Q1KylmSS7aUGqwZsGT70aGlGXUL2WPHNhb+j6pN+LiZMKQyVL
   +QyHcieW13nXkUTkRuSig3k0oVdwOBRRuDiRRHShmc9eiO/zAJkFDcdyL
   +cr92dXorCmJBwrLKlcQmNJ+1EvbOo/7DsFg2iWDdR7iOwuNKQLPy5xUm
   TAlgOyY+bNQhZhclZw0n5/19Bk8qSEsbT82YRgn3Eo2DLXDNpnG794FLO
   XzgMGx3scVPRQilTN3hhhTqXi5QbwrExEECXgoTtwmPjZit1tcHVZjtQG
   ABxz6e6KIYkYKIEe1X+pSfvhN4lIZ5/0ho/Rl6JZjwMXZXdxqIwRa4Tr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="379283646"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="379283646"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="703862409"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="703862409"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2023 23:42:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 23:42:15 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 23:42:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 23:42:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 23:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKyLLh8Jbsk4BCqO8ItOiphZ+klZwXqUcdnHlyD+xur8FufzmQ3uJSWkJlw5KsTzV+fUUD4bFHBQZ6dxTziNV21pFALKZZ+T31IiNPAQPtFFG3f2NsqVCTObYV7Z+dmFihkzJRVcZnlhwk3cICSugd4AusqkStpHTdCQV/HNYYra8MRFjcBjbdR0CA6r0z6WJxSWT4nnJ2CfjuCARL8L8lXx4Gt2ilwzOoUud5tnYi/9xcGrWu5moSvzZiIxUZH5fozOPm8jk4C6ao3kL7tQiNMJfpIHXicq8IxMgb7kOa7MxJ4anXcdYGBQ28UwJB0cZAw/ab7aOk1oDLGxAbwWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOUbR6qkF8/jr+gHI98uTkiKhmNhYpU0tj+A3JsgiSQ=;
 b=OIK4Amq4/doR8L2NTUPYxmxZdlJGr8ceZGlebym9lR0Z46qWhPNyRWsfDQZu6t3biCWHuDwKdkvYVS/h16+vej9ZPxF8O990myCNWqHMn+2u99ojbkN/eN9MC5g9TBuieRde9Og8ASQNZfSwWctejaTU/6dyysguCjv44saEmVNDRZ4vXTlyoECfFgBLsCMp7Q/4JwYxI1tKD2zNM8qQenvcSDE1fTCm/vKS5StRAPlnUlcCxj8UPOL2kOEARmlODYmRjp8cP5P0zZLUIJC467jBk5nQ3dS5/qJs0MR8RPQ84BPjOsnoovyGmqNdfOi0z3fU8XcerY05hLKHQZatwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Mon, 15 May
 2023 06:42:11 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 06:42:11 +0000
Date:   Mon, 15 May 2023 14:42:00 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Message-ID: <202305151330.ca5d459d-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="eyBhJIHwqkc46Lpf"
Content-Disposition: inline
In-Reply-To: <20230508081532.36379-1-qiuxu.zhuo@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 395e52da-1567-402b-e8e4-08db550f823b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ijy3hiULUNKWugtyQBVA1Xe2pKrQVzvEtJzUA35tFwUe3yij/1Cntu2iStyXHTJ2HuDfPzC/z4g+8KpLEIIlh1Jlx8up+d4ir5IP748YyxNIlMIwpCWMdxIr0VrF1oVY/1+cSR5Wss+zgqYats58NroxqPoEz19xy4vE7PJZYmdMa4bSGzLKbu3MN50OROYlwGpnb+cTCu91P0skkhqk9giqKCLl8TRYJxg4e9WNkeSzaALNDscp0ONg+DVmc3uw+ia3GTsVLu/k49kBzJFtqy7WTrxOuyZ1yB6krP7ghmKQdZZYjVZRT8lbAb96Ljv2c8jEePk3dGrhL11MPntQRHZG+KcRW0+OG0G3cRUmMS1EWJEp/5RsT5Ip0qn2IL2HKAdq0Z+FYOcQD2wjoWOay9x1aGYQy0gLOvOGYJjRXCLlpOzMn5+rP7CudCxfnNlHEFHoiyHIiD43ITfuvoMHd506SHBHksB3UmCo8InQI+CrM4Nc90BtIsqUnnNYVcc7j8HXOMnePWZLEfn1S8omEiR9s/AUnetIlU+oH6LOwPHBfTiW0ISAsbF5RjsonVgxs2HwWrw5nfd0kIZJyWpEPwTOFt3jzjDycEzEUCmc7uecK8rO9Y+jG2pBt1ZmsYKRtZU2/+x+60uo6KoCDHypzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6506007)(38100700002)(2906002)(6512007)(1076003)(2616005)(235185007)(83380400001)(5660300002)(6862004)(8676002)(8936002)(41300700001)(26005)(4326008)(66476007)(66556008)(36756003)(6636002)(44144004)(21490400003)(66946007)(316002)(86362001)(186003)(966005)(478600001)(82960400001)(6666004)(107886003)(37006003)(54906003)(6486002)(45080400002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbg9nQ+wYkztV1jIHeBuMyWFfMT7u1jEcCE3fy39gHmPrwjCGVv8DNuu5mZt?=
 =?us-ascii?Q?9R4T55y5VDWyJjcTp6f1M/nm7TDX3v/KMsUsjdQLb1xotOZ1OreFmNESLMlN?=
 =?us-ascii?Q?X5ZMWeCUATDXKgXn1XCtnb/NRknloP49typLrv0Gnw6Usl284RM0BQkdE03X?=
 =?us-ascii?Q?+CA06g8xQeRp6LQYjhgIeCCONKeAU9OIEAjyA60O8l+NGCzB4FMLSkBfNd60?=
 =?us-ascii?Q?qUSXErSYxcVH+HGNvgIrk9YPXseow/EUfhM7uXjRlpgS++6oosBwg8x1RJdo?=
 =?us-ascii?Q?neXjrvtoEsTGf05RN4Lc5v+5zEymvvW7gnDbBQMCHD3dBO8n11y9uDY6uQsN?=
 =?us-ascii?Q?6zChX4sf+C1o+hk7yz1AY5g0EYrzj9fgmFcojiC9a6xx4lyi392w7XBL8Rml?=
 =?us-ascii?Q?xd8icHf9d/eDVjDBc9m2GV8hwIJR60OK0dShChYzUG6uSdJPX6qXYllZKt45?=
 =?us-ascii?Q?oXic61UHC8w32P2XDmdpf7MGezLXhJ8xwl+Gpw4p/LdQk4CILY1mNhTaHbfC?=
 =?us-ascii?Q?Y4qugAkIxTjS7mQ5EIrNqgkBUIzHHrTWKQCAqFJKt3n/3uAABMA7X6RMAgE2?=
 =?us-ascii?Q?DI7C63+wp5c5dKPnXXxBAwhje9tqZjyo1FH/D2BkhRDWJJYQZpQ9Mg0n45aT?=
 =?us-ascii?Q?J0f1io94hjVpvYSzagkNLPDH5MtSqNZeXBoKRGOybRB8CejNtiPcm3k4ePQh?=
 =?us-ascii?Q?SfI/buh71Y/cYwFs30kaJesbB64vIXTxBIVv2kaxoJmWyOV/7BJFCFi9X97O?=
 =?us-ascii?Q?rXDiIfkviodf5ApbZPxV8/6ozO2JwJCVniGF+7xtRds29Pc/gd6vEln3EwdY?=
 =?us-ascii?Q?wNaEgWoBU0bC8NxwJyze8vyqSy9cuv6Bv2HeNIM4VWzakC+/Rwm7b3vL9Oq4?=
 =?us-ascii?Q?j20/FgHwJ8cbrMUgBvba94/pV2oZ9aZMjn+bwVeXhUNKB3E+KU1ItAGN+dcK?=
 =?us-ascii?Q?/n3/0TL5Y1ijJCce0jA4ERzKTp1S+SVr+taoU7xaLYXwldc+80jMfGFsRmP4?=
 =?us-ascii?Q?jqFepdbk3dffv3UWD8dTzT4bnf7C6JZhLZqSJLx4kAoh6qKgKZcJyS+DpFEn?=
 =?us-ascii?Q?h4ap0AoaOq/k+QPvolnPdBTvqBvBAq/N836FRU9zA222I6PH3fxJI0Ut7X0j?=
 =?us-ascii?Q?tJPT0IHcGQP8gkTzj11HdzB1hFzjVnAwUS0L+Gxc15f7p+F2D5Hu4JZLpWmi?=
 =?us-ascii?Q?eIKLd2/79Iz3q9xrEl6xKDLej4F5UVpm41XTdB/9aQU6jXH6t+8y6ymb/P23?=
 =?us-ascii?Q?eKbS6FRCmKGb5mOR3OgAXX8RZ4yo6JFU/gsLqBM6PleTXsBIadg23MxZD8mG?=
 =?us-ascii?Q?T3Mh8kYUZFCXA6lmgIw8v1inZnNASh0k7b23BNctCjNZsbhpK9goFccnE+vp?=
 =?us-ascii?Q?peiOsDEPfAVjS2OpRwPj6qB8KTxYF82RIhg9R5d36suCsf2dGz8UMFSRC/5P?=
 =?us-ascii?Q?nn5cdsHyoJKShdO4pdmHOSC+/Wi+Ed+/xFOwUEKaRLbEwKSgWVCxRgGfByU5?=
 =?us-ascii?Q?L+ggH2MkLzRFi+TiQz/HoU9BlQ3tc1qS7jCivgtE0XpSqU3t8dW9Nhw2wfQE?=
 =?us-ascii?Q?Lx8zxrc/vsQfZ4E9MDPDAJO9m1wXmfCxqBIu70iZYsiSJpTew38DHiwbpzgl?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395e52da-1567-402b-e8e4-08db550f823b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:42:10.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKlzAZm1FX18OYokZlT0dfBnwwoeAQy1y7gBJQB8pMT3RKl7PzdgWMRtmOx0kQYhzadB080RB2HDfCZo1sL82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--eyBhJIHwqkc46Lpf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: 3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302 ("[PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on locked_pending bits")
url: https://github.com/intel-lab-lkp/linux/commits/Qiuxu-Zhuo/locking-qspinlock-Make-the-1st-spinner-only-spin-on-locked_pending-bits/20230508-161751
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git ec570320b09f76d52819e60abdccf372658216b6
patch link: https://lore.kernel.org/all/20230508081532.36379-1-qiuxu.zhuo@intel.com/
patch subject: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on locked_pending bits

in testcase: phoronix-test-suite
version: 
with following parameters:

	test: sqlite-2.1.0
	option_a: 128
	cpufreq_governor: performance

test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
test-url: http://www.phoronix-test-suite.com/


compiler: gcc-11
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------+------------+------------+
|                | ec570320b0 | 3fa78d3cb9 |
+----------------+------------+------------+
| boot_successes | 0          | 2          |
+----------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202305151330.ca5d459d-oliver.sang@intel.com


[   54.397344][ T2693] ------------[ cut here ]------------
[   54.402911][ T2693] kernel BUG at lib/list_debug.c:59!
[   54.408314][ T2693] invalid opcode: 0000 [#1] SMP NOPTI
[   54.413773][ T2693] CPU: 2 PID: 2693 Comm: sqlite3 Tainted: G S                 6.3.0-rc1-00010-g3fa78d3cb9df #1
[   54.424166][ T2693] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[ 54.437758][ T2693] RIP: 0010:__list_del_entry_valid (lib/list_debug.c:59 (discriminator 3)) 
[ 54.443830][ T2693] Code: 36 6f 82 e8 87 98 a8 ff 0f 0b 48 89 ca 48 c7 c7 20 37 6f 82 e8 76 98 a8 ff 0f 0b 4c 89 c2 48 c7 c7 58 37 6f 82 e8 65 98 a8 ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 a8 37 6f 82 e8 4e 98 a8
All code
========
   0:	36 6f                	outsl  %ss:(%rsi),(%dx)
   2:	82                   	(bad)  
   3:	e8 87 98 a8 ff       	callq  0xffffffffffa8988f
   8:	0f 0b                	ud2    
   a:	48 89 ca             	mov    %rcx,%rdx
   d:	48 c7 c7 20 37 6f 82 	mov    $0xffffffff826f3720,%rdi
  14:	e8 76 98 a8 ff       	callq  0xffffffffffa8988f
  19:	0f 0b                	ud2    
  1b:	4c 89 c2             	mov    %r8,%rdx
  1e:	48 c7 c7 58 37 6f 82 	mov    $0xffffffff826f3758,%rdi
  25:	e8 65 98 a8 ff       	callq  0xffffffffffa8988f
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 d1             	mov    %rdx,%rcx
  2f:	4c 89 c6             	mov    %r8,%rsi
  32:	4c 89 ca             	mov    %r9,%rdx
  35:	48 c7 c7 a8 37 6f 82 	mov    $0xffffffff826f37a8,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	4e 98                	rex.WRX cltq 
  3f:	a8                   	.byte 0xa8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 d1             	mov    %rdx,%rcx
   5:	4c 89 c6             	mov    %r8,%rsi
   8:	4c 89 ca             	mov    %r9,%rdx
   b:	48 c7 c7 a8 37 6f 82 	mov    $0xffffffff826f37a8,%rdi
  12:	e8                   	.byte 0xe8
  13:	4e 98                	rex.WRX cltq 
  15:	a8                   	.byte 0xa8
[   54.463787][ T2693] RSP: 0018:ffffc90004ad3e50 EFLAGS: 00010246
[   54.469954][ T2693] RAX: 000000000000006d RBX: ffff88887567c6c0 RCX: 0000000000000000
[   54.478031][ T2693] RDX: 0000000000000000 RSI: ffff888854e9c700 RDI: ffff888854e9c700
[   54.486105][ T2693] RBP: ffff888108530300 R08: 0000000000000000 R09: 00000000ffff7fff
[   54.494179][ T2693] R10: ffffc90004ad3d08 R11: ffffffff82bd8d88 R12: ffff888108530358
[   54.502264][ T2693] R13: 00000000ffffff9c R14: ffff8881086e96a0 R15: ffff888108530300
[   54.510352][ T2693] FS:  00007f9d97379740(0000) GS:ffff888854e80000(0000) knlGS:0000000000000000
[   54.519388][ T2693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.526081][ T2693] CR2: 0000556700799178 CR3: 000000018215c001 CR4: 00000000003706e0
[   54.534170][ T2693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.542247][ T2693] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.550328][ T2693] Call Trace:
[   54.553758][ T2693]  <TASK>
[ 54.556798][ T2693] __dentry_kill (include/linux/list.h:134 fs/dcache.c:550 fs/dcache.c:603) 
[ 54.561399][ T2693] dentry_kill (fs/dcache.c:755) 
[ 54.565830][ T2693] dput (fs/dcache.c:913) 
[ 54.569770][ T2693] do_unlinkat (fs/namei.c:4321) 
[ 54.574289][ T2693] __x64_sys_unlink (fs/namei.c:4364 fs/namei.c:4362 fs/namei.c:4362) 
[ 54.579056][ T2693] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 54.583593][ T2693] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   54.589613][ T2693] RIP: 0033:0x7f9d9749d247
[ 54.594121][ T2693] Code: f0 ff ff 73 01 c3 48 8b 0d 46 bc 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 bc 0c 00 f7 d8 64 89 01 48
All code
========
   0:	f0 ff                	lock (bad) 
   2:	ff 73 01             	pushq  0x1(%rbx)
   5:	c3                   	retq   
   6:	48 8b 0d 46 bc 0c 00 	mov    0xcbc46(%rip),%rcx        # 0xcbc53
   d:	f7 d8                	neg    %eax
   f:	64 89 01             	mov    %eax,%fs:(%rcx)
  12:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  16:	c3                   	retq   
  17:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1e:	00 00 00 
  21:	66 90                	xchg   %ax,%ax
  23:	b8 57 00 00 00       	mov    $0x57,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 19 bc 0c 00 	mov    0xcbc19(%rip),%rcx        # 0xcbc53
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 19 bc 0c 00 	mov    0xcbc19(%rip),%rcx        # 0xcbc29
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   54.614042][ T2693] RSP: 002b:00007fff66911a48 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[   54.622596][ T2693] RAX: ffffffffffffffda RBX: 00005637c6657f58 RCX: 00007f9d9749d247
[   54.630716][ T2693] RDX: 0000000000000000 RSI: 00005637c6658287 RDI: 00005637c6658287
[   54.638820][ T2693] RBP: 0000000000000001 R08: 00005637c6657b98 R09: 0000000000000000
[   54.646908][ T2693] R10: 00007fff66911a20 R11: 0000000000000206 R12: 0000000000000000
[   54.654990][ T2693] R13: 00005637c6658287 R14: 00005637c6657a98 R15: 00005637c6673008
[   54.663083][ T2693]  </TASK>
[   54.666234][ T2693] Modules linked in: sg ip_tables overlay rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp sd_mod coretemp t10_pi crc64_rocksoft_generic kvm_intel crc64_rocksoft crc64 kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ast ghash_clmulni_intel drm_shmem_helper drm_kms_helper sha512_ssse3 syscopyarea sysfillrect sysimgblt ahci rapl libahci ppdev intel_cstate parport_pc wmi_bmof intel_wmi_thunderbolt mei_me video i2c_designware_platform intel_uncore drm libata intel_pmc_core mei i2c_designware_core idma64 intel_pch_thermal ie31200_edac wmi parport acpi_tad acpi_power_meter acpi_pad
[   54.731069][ T2693] ---[ end trace 0000000000000000 ]---
[ 54.736720][ T2693] RIP: 0010:__list_del_entry_valid (lib/list_debug.c:59 (discriminator 3)) 
[ 54.742881][ T2693] Code: 36 6f 82 e8 87 98 a8 ff 0f 0b 48 89 ca 48 c7 c7 20 37 6f 82 e8 76 98 a8 ff 0f 0b 4c 89 c2 48 c7 c7 58 37 6f 82 e8 65 98 a8 ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 a8 37 6f 82 e8 4e 98 a8
All code
========
   0:	36 6f                	outsl  %ss:(%rsi),(%dx)
   2:	82                   	(bad)  
   3:	e8 87 98 a8 ff       	callq  0xffffffffffa8988f
   8:	0f 0b                	ud2    
   a:	48 89 ca             	mov    %rcx,%rdx
   d:	48 c7 c7 20 37 6f 82 	mov    $0xffffffff826f3720,%rdi
  14:	e8 76 98 a8 ff       	callq  0xffffffffffa8988f
  19:	0f 0b                	ud2    
  1b:	4c 89 c2             	mov    %r8,%rdx
  1e:	48 c7 c7 58 37 6f 82 	mov    $0xffffffff826f3758,%rdi
  25:	e8 65 98 a8 ff       	callq  0xffffffffffa8988f
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 d1             	mov    %rdx,%rcx
  2f:	4c 89 c6             	mov    %r8,%rsi
  32:	4c 89 ca             	mov    %r9,%rdx
  35:	48 c7 c7 a8 37 6f 82 	mov    $0xffffffff826f37a8,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	4e 98                	rex.WRX cltq 
  3f:	a8                   	.byte 0xa8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 d1             	mov    %rdx,%rcx
   5:	4c 89 c6             	mov    %r8,%rsi
   8:	4c 89 ca             	mov    %r9,%rdx
   b:	48 c7 c7 a8 37 6f 82 	mov    $0xffffffff826f37a8,%rdi
  12:	e8                   	.byte 0xe8
  13:	4e 98                	rex.WRX cltq 
  15:	a8                   	.byte 0xa8


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--eyBhJIHwqkc46Lpf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc1-00010-g3fa78d3cb9df"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_PCI1XXXX=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--eyBhJIHwqkc46Lpf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='phoronix-test-suite'
	export testcase='phoronix-test-suite'
	export category='benchmark'
	export need_memory='8G'
	export job_origin='phoronix-test-suite-part2.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-cfl-e1'
	export tbox_group='lkp-cfl-e1'
	export submit_id='64610567f78c543bb5bbf399'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-128-sqlite-2.1.0-debian-x86_64-phoronix-3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302-20230514-15285-1wh1jzc-4.yaml'
	export id='5e1f25e732caca47126c3037953342bf37225fba'
	export queuer_version='/zday/lkp'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export commit='3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302'
	export ucode='0xf4'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"IGB"=>"y"}
SATA_AHCI'
	export rootfs='internal-lkp-server:/osimage/debian/debian-x86_64-phoronix'
	export run_on_local_disk=true
	export force_reboot=1
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-05-14 23:59:35 +0800'
	export _id='6461057df78c543bb5bbf39a'
	export _rt='/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='a071029f337f80d4a8f24d0fe7d440534a2065a7'
	export base_commit='ac9a78681b921877518763ba0e89202254349d1b'
	export branch='linux-review/Qiuxu-Zhuo/locking-qspinlock-Make-the-1st-spinner-only-spin-on-locked_pending-bits/20230508-161751'
	export result_root='/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/3'
	export scheduler_version='/lkp/lkp/.src-20230514-141537'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/initramfs/initramfs-20191118.cgz'
	export bootloader_append='root=/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1
rootflags=subvol=debian-x86_64-phoronix
remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
RESULT_ROOT=/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/vmlinuz-6.3.0-rc1-00010-g3fa78d3cb9df
branch=linux-review/Qiuxu-Zhuo/locking-qspinlock-Make-the-1st-spinner-only-spin-on-locked_pending-bits/20230508-161751
job=/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-128-sqlite-2.1.0-debian-x86_64-phoronix-3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302-20230514-15285-1wh1jzc-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302
initcall_debug
nmi_watchdog=0
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/modules.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export stop_repeat_if_found='dmesg.kernel_BUG_at_lib/list_debug.c'
	export kbuild_queue_analysis=1
	export repeat_to=6
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/vmlinuz-6.3.0-rc1-00010-g3fa78d3cb9df'
	export dequeue_time='2023-05-15 00:03:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-128-sqlite-2.1.0-debian-x86_64-phoronix-3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302-20230514-15285-1wh1jzc-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='sqlite-2.1.0' option_a=128 $LKP_SRC/tests/wrapper phoronix-test-suite
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='sqlite-2.1.0' option_a=128 $LKP_SRC/stats/wrapper phoronix-test-suite
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time phoronix-test-suite.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--eyBhJIHwqkc46Lpf
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==

--eyBhJIHwqkc46Lpf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/phoronix-test-suite-part2.yaml
suite: phoronix-test-suite
testcase: phoronix-test-suite
category: benchmark
need_memory: 8G
phoronix-test-suite:
  test: sqlite-2.1.0
  option_a: 128
job_origin: phoronix-test-suite-part2.yaml

#! queue options
queue_cmdline_keys: []
queue: vip
testbox: lkp-cfl-e1
tbox_group: lkp-cfl-e1
submit_id: 6460f2a90b9a93023b89f478
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-128-sqlite-2.1.0-debian-x86_64-phoronix-3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302-20230514-571-zdp1tu-0.yaml"
id: e8cc097e314b12aef1249a42087873c30dfb0a40
queuer_version: "/lkp/xsang/.src-20230514-222459"

#! /db/releases/20230508130436/lkp-src/hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

#! /db/releases/20230508130436/lkp-src/include/category/benchmark
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0

#! /db/releases/20230508130436/lkp-src/include/category/ALL
cpufreq_governor: performance

#! /db/releases/20230508130436/lkp-src/include/queue/cyclic
commit: 3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302

#! /db/releases/20230508130436/lkp-src/include/testbox/lkp-cfl-e1
ucode: '0xf4'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- IGB: y
- SATA_AHCI

#! /db/releases/20230508130436/lkp-src/include/phoronix-test-suite
rootfs: internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
run_on_local_disk: true
force_reboot: 1
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-05-14 22:39:37.747619958 +08:00
_id: 6460f2a90b9a93023b89f478
_rt: "/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: a071029f337f80d4a8f24d0fe7d440534a2065a7
base_commit: ac9a78681b921877518763ba0e89202254349d1b
branch: linux-review/Qiuxu-Zhuo/locking-qspinlock-Make-the-1st-spinner-only-spin-on-locked_pending-bits/20230508-161751
result_root: "/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/0"
scheduler_version: "/lkp/lkp/.src-20230514-141537"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/initramfs/initramfs-20191118.cgz"
bootloader_append:
- root=/dev/disk/by-id/ata-ST1000DM010-2EP102_W9APNAR5-part1
- rootflags=subvol=debian-x86_64-phoronix
- remote_rootfs=internal-lkp-server:/osimage/debian/debian-x86_64-phoronix
- RESULT_ROOT=/result/phoronix-test-suite/performance-128-sqlite-2.1.0/lkp-cfl-e1/debian-x86_64-phoronix/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/vmlinuz-6.3.0-rc1-00010-g3fa78d3cb9df
- branch=linux-review/Qiuxu-Zhuo/locking-qspinlock-Make-the-1st-spinner-only-spin-on-locked_pending-bits/20230508-161751
- job=/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-128-sqlite-2.1.0-debian-x86_64-phoronix-3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302-20230514-571-zdp1tu-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302
- initcall_debug
- nmi_watchdog=0
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/modules.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20230509145422/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0
stop_repeat_if_found: dmesg.kernel_BUG_at_lib/list_debug.c

#! user overrides
kbuild_queue_analysis: 1

#! /db/releases/20230511154539/lkp-src/include/site/inn
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/3fa78d3cb9dfb63f66f86b76a7621c9d1c1ee302/vmlinuz-6.3.0-rc1-00010-g3fa78d3cb9df"
dequeue_time: 2023-05-14 22:46:26.388540120 +08:00

#! /cephfs/db/releases/20230514154859/lkp-src/include/site/inn
job_state: running

--eyBhJIHwqkc46Lpf--
