Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCB6E09AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:06:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203029C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681376796; x=1712912796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uw3hVB84QNO+eEO9vJqjU/BtktMBaPMXi8OiFuzfaHs=;
  b=IjTw4RErk6aGRx6ZehiQ4EZD5+7Yn3EViswrm63gnbvnhJleAu9hDXVz
   6LH8hIO1lc3n619qEqVDN/UeLJYffUjbsLBw4+pB50f9aeIwy7evSI3Ey
   gbjDT/1Z7r1BaW2SMZlVRSuhYkHWH4T0VPnAGEmyQhi1ZNVa3rAZSi6YG
   t2oEpObc7A7e8S+QMIoglx7OhNipF5k0pXhoBckgrtFoGbS/UHpdnd/wu
   tJ/C0LsapdhD/vmvAgmv10nhuhYL7VVg3+E78/vIE9BIp5ZONZahT1AJn
   Q4/7WuJb8fZwuX8FdTQdtVHQX8I4mfScUYgwcNfE2xFT5O0ZU4lue8QyG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324489368"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="324489368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 02:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719758249"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="719758249"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 13 Apr 2023 02:06:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 02:06:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 02:06:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 02:06:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 02:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY2SU9myApyCyx6n2ZcioxwUJx0w8uKfRdiApx4L2jc1DdYMeMkVqkpXtgCON0YC+zjDYHTVyddKbsXUZBFkKZX/jJjeik8tvO6XwXzmJaUEnNflR4i00EsOu4fxyN/sx+rjdD+5HRtMhKauWJhyrHDx8Fql0SY75hf+hLYXC5RNSUAiHo9ZHUlg03Dq2I1+h0WvxAjv1+Y89+krEc+4As6Ay6y0YIgQer5NgqeQ/938All96Wh1E3UVeJfoeosGzLJZm89o2QiCcGU8QtRzexigjDmwlhCukx9K/5Vzir05hpdyglAAglP2qlqzk3Up/vjNlpNn87zGB6iRCRZlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33npM9LeoREHSrAaj3gw5LN6BerrzoNhkTm1suTKs3I=;
 b=QOoFEcDSZG2iZxAIiFN5yXl7mUrrClb8sunzIv4Oy90aMpYLUzgMQ/0TB93bVq77lpsd2laQY5O6/otwj7fT0Hmi9a6NWBWtf8B/YDmj7MFA4snUSh3poIvmdRoTVDGFefeiCFVxp55KF/OaeyaIbVQusJK32Bgb40islPRnTqLNCtk9TIPzF3qgF6gmgOnaudr5rcm/ZK1h1YEO1y5N/z+JhdjyzlYfPrBoKM+ji7XabNxkzBlIexE1tJSoCL/oKT5vI8ic13LqzbAE2278g0tHMvNfVokJRq5ttm5tb2mcyxgkudz70D3XFGUegAGdFLoa5SfnlOEJpZWbz1O5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:06:29 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:06:29 +0000
Date:   Thu, 13 Apr 2023 17:08:08 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <frederic@kernel.org>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDfGeHcIVLw49KRb@xpf.sh.intel.com>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <20230413070042.1479-1-hdanton@sina.com>
 <20230413083017.1518-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413083017.1518-1-hdanton@sina.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: dfed6b19-cc6f-4956-fb78-08db3bfe5e07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlO6iFU4L2qjNmEPQIeMW0HtQG71aHff15zGXEACiW4YEqQJ5IhtbrEupyI92pItyG1ygr+OhY8LYblZhIlUBsnFxgAZJTfO4eDcAjuRLSfk+b1QiC+NmpInVDKMeqFNggSA9GonRc14HcnG0RoKinP6rRT/UibGq7kBm7EnFcY7RQH45oPft2aPaIpXsLWcjGfobETlfeAgf6CgCgdtmvsl3dMfQ0azSxnRUTb+sApQDynzaydpGSISGnHouczM0uRPUNYki+m/yls5zDngtShxm9w0xggEeEh+CQWBEuNTsIFVRTU1Bc0LOCuXxpQLiT9lo57DuUCWHvZrHvOSqsYYAi9vq7VPUhkrA6oTAyIF46flXuPPZZBDg5nOY7YlAxCGAVBVQJg+MCWyAr4QUj+q9/RPFgFsTcg8RAR4JPUpD1kVE5fJ9vdULUI/7ZnK0a+w1fRDgM4fdzSAtdNIbcpjmCMkPwCCqUZ2GKoPhaQODi7B1uymaKUMJizt9fLQB0xiu2o/tfyg8DrYVgFsTj+XE0Zh4Ttp2YVDnKZBKN8FVB+bbcIMsmSwZVFcEcVj7kzA7fCIAKEOfMt2o8zI3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(86362001)(44832011)(478600001)(316002)(82960400001)(41300700001)(38100700002)(8676002)(8936002)(5660300002)(6916009)(66476007)(66556008)(107886003)(53546011)(6512007)(6506007)(26005)(186003)(4326008)(66946007)(6666004)(83380400001)(2906002)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3jBXaCXm0Z6STB+fvhyGNsLMZmcaJVk0FawxmOQNsUCTNG2ez3plQdEUv6h?=
 =?us-ascii?Q?EGL8timdmvCoSg5Qv/FRLDizCipVKIMicNWILLNhmnHtVrdpGBrqESnroLJ7?=
 =?us-ascii?Q?fGX7rxZ8nFoOIhbm66c3FM1nThjbfLwObY+BYuIQ5UUn/F9TdOuWjNecWm8z?=
 =?us-ascii?Q?R6pYo8JBBM65Dm4d+Vp8jmpCH+UQOyT0tHierxm/+urYAcWrVjS4JarNAQl+?=
 =?us-ascii?Q?dj+0a67QGvsY8sjldJlWYwTYOWxlENehGE85K97T1DlWUe8N+6rRgadIDm0g?=
 =?us-ascii?Q?0eFjjONIYitdRpCJLQ1ZeWrzCZe13TULTwyCW4F9CLgyGVBgcv0e7a9XcEt8?=
 =?us-ascii?Q?lIJCy5fjlTD3HcwjfYafBh+qaXaj/NbUR6iEudnYb9YnAiqDFlfD3ALqysDN?=
 =?us-ascii?Q?91aVN+9CjOx1a1hlH65Oq2M0hcp8+mC4fDRsKqRAt7owWUkQuabglE6CN0T6?=
 =?us-ascii?Q?iTi5gH2pAWDuVHIw+HJgMx7g6TXpF1i84AqChkvLbPyhbYl0idBhNIvH1D2h?=
 =?us-ascii?Q?BY2FRmo8plfxOyqYmQzESuoTDFGAkRueaH5cVpObFZdPKF9NzkK+gjDGLCAc?=
 =?us-ascii?Q?NeoBGrRBNNX1iv0zkuKWIjKj5wcuP+z06NgvizbJONfKj7G4a1CB4bvfB2xr?=
 =?us-ascii?Q?iPuhtu2Gk0ob5G+s5KErdMFKtGm5+ApN54lDg71s6MVqAD0Z8L3WdyL3rWvF?=
 =?us-ascii?Q?KThFc16S5RK/sFfrvrWf0qIEJbi7ZUFZrVbKJVUjuVonfCNRYNGnMfJbdXOv?=
 =?us-ascii?Q?JrajM4jMFK038ntSJZo0p/zVKmoHhgvtpSiqXxWWti49WiYpa45wzik7GMg3?=
 =?us-ascii?Q?K0shb8Y6Hg1PfAt7YlvzV8kQUB1oYOS1/qfjn60MQ6OafE3akO3ihtWxNzEN?=
 =?us-ascii?Q?6/H8LkKANw0p0czoOwUy8wK/BfsSo3j202Wn7N5AOPWbtUxLMaeuYTECwghb?=
 =?us-ascii?Q?L0/whGSJJCRX6Y8v+L6v4sRBo7KSFvgmvkPvX8GnJVm5617EukoaSlJY31lE?=
 =?us-ascii?Q?ERq6nLYoPFWRcXtpBDuaPHn2APhWwhzXuo9JiDzvHoh5hmwS/jD7re5DHmcV?=
 =?us-ascii?Q?tkDul4Tk8t9j+4MPy8v4nHHzDGewhzK52wVuXNuaU06PO2GC4OWihpfv6jW6?=
 =?us-ascii?Q?7FWTrPNajOdcCDfSLoJPMcT91C+95TGpeKHea+/RhTgdgbm499fr+WjYXIZF?=
 =?us-ascii?Q?Q6sM0iu1P/ALMlbqlSc+WLhsq3fIr6I+QIVbtMGFFt4bCADNoDTrAzn4uugy?=
 =?us-ascii?Q?2rrWmvCYp3nA4pIDFinyBnDRBBHDNkwzyw0YnfPXV2tGOyEVz0e2ZHtCYQj7?=
 =?us-ascii?Q?rz49QwoPnKyDRYi/RiGBBQqMpLiM5PL+iiIPyrvU2fZ5a8KGQfodan/iBKzj?=
 =?us-ascii?Q?0Y8lPgj0RPumiTrHC2FspWgMR7t0RWODwWHqvVT659/QxMpo289fAuBxDUo2?=
 =?us-ascii?Q?m1+Vw/1LCKNqvsFNzC2APZJrXd/+yGVChBIjnvGABI2oaeKcyAzUmTPrWOCH?=
 =?us-ascii?Q?3DgO5552RxhGLktW5I3fj1yLj8EloJbwCztX5R3Db7AeOqij/Qvbe8OpTe2e?=
 =?us-ascii?Q?JJD6PXzq20NT9PBQE8Oxs6I6bo7EgUXFT+QhmBUj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed6b19-cc6f-4956-fb78-08db3bfe5e07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:06:29.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzlCe/h7Y4zyULUvosDED2xUdXfZeJsXPyb8GPgqFZX2D5x0RMoWHBCtLats8y53d0ABFHGwn34JCYSnn7QIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 at 16:30:17 +0800, Hillf Danton wrote:
> On Thu, 13 Apr 2023 16:03:51 +0800 Pengfei Xu <pengfei.xu@intel.com>
> > 
> >   I newly updated previous alder lake S reproduced syzkaller repro.prog and
> >   machineInfo0(vm info) info in log link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/230315_023443_synchronize_rcu
> > 
> > And tried debug kernel on alder lake S, there were 2 cpu in guest, and
> > CPU1 reported "interrupt took 331596 ns", then kernel should not trigger
> > "rcu_tasks_wait_gp" for this issue.
> > [  104.171591] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=334 'systemd'
> > [  126.770981] hrtimer CPU1: interrupt took 331596 ns      //  "rcu_tasks_wait_gp" after 15s
> > [  141.127282] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 2571 jiffies old.
> > [  171.272100] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 10107 jiffies old.
> > [  261.767189] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 32731 jiffies old.
> > [  300.102911] INFO: task repro_rcu:398 blocked for more than 147 seconds.
> > [  300.103408]       Not tainted 6.3.0-rc6-dbg-dirty #1
> 
> Similar issue, and hrtimer trace helps in both cases.
I enabled "hrtimer_*" and tried again.
I didn't find some clue for this issue due to lack of experience for hrtimer
logs.
Anyway I put the issue dmesg and hrtimer in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu/0413_debug_on_alder_lake-s

Thanks!
BR.
