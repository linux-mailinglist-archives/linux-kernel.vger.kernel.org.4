Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB76259E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiKKLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKKLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:54:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FF623A9;
        Fri, 11 Nov 2022 03:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668167690; x=1699703690;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JMVWL9i+cHJWOE0mbft2sdSnrd4jbFigvI7i2nC6IHc=;
  b=aEebhTr9c1plLqEiivSmMQSaXyj6dHvulZOUmFRkwQTgePj2Nu99fnxm
   L7RQ8w63gYtBsNfwJJtiIgMA+XdwR8ITjUAL1HmKpCwc/5l6OsfFvhuS0
   lVXa9+1oL8hQTOsd52G3XqRmTGAKPIct1hEC7O5Xua5Qh2dJWWs7Gy2wq
   3NpFEHVA82Ty7ySw0zIQUQgnPkCERlhi0jkE8oJLYkbnPlHmmvusHcdti
   m0wD0JC0wAF+NrmT4X0bTUzDA2pWZfzwfeDjEfP2EjCXcMG19A692pRY3
   e6jtFRBJGaxBfmvgNqXuzp8hb8rsq4cZ6lYmldFYValVLUJi/9Ll2+Ywv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313371430"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="313371430"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="762648568"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="762648568"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2022 03:54:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 03:54:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 03:54:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 03:54:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 03:54:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APyApZzdma8oliYSl3OMBXi7cSO3Txz39Cg50cSmMybiKPPhLuUp3FHa1r5dibkTtBnkZfyrrzG6uxsuw0fVqZigS6ilqj9dlnqmh7NCkRkTeHjNIsnRRYXIhQ8JTYdqonzMqAz+5jTt0cyQsg2+GBShDIBcMWTaRTY8EOBDz3ubaYzyv+WGWIqwRSKMVu7y9LxM6SMCrJam7l04spa8CCMnAb3ti4vP128sykw4deqZWaNEKzFqUhO+/WMlPu1peuz6Wsn6xzPtrqfIjHsz78o8it2zMw1Ehn0gjFmFy5PFb1xYpnhtc4UBG3AN6sQY4aAyCvxxqVD32AaH5kK4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giOHfyZ1/oYZ/nM3Da8/fxbff9qV3oDjZ/kCv3QzgxU=;
 b=CGfTTcnF0hUkQC4I5nAI3mE6uFigyr3PWDpu7GZZ+4km/Di0HsNhGVdeewki4tm7YGI4hB7pc2631+O3h3rC/NYGd/wOIDP2cKMrLIsgrXSAiGBJuPvjDusn6q4sRua6DLdl6ZM6o3e7RG64Npu5HMAn5c/y1rJtutZEsffN5S5X3BggkG/4QPWEjPz6A/40pOR9PKjaav/7PyJR/4jkQ9bMIDbcpbF/1tglW/YDyFm/9m86NmKMqtbdVj3mDfaXmjnAy3sRkaBOm8ysMwOzRMPXW3Akg5/JssUWy2NsXn6benWSRe0I6PqkLJhIrKIr5dY+lpphfoKTft9oh7Sr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 11:54:22 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 11:54:22 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Topic: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Index: AQHY9bjOyeVrXHxgy0el1PqNXBMQja45mfHQ
Date:   Fri, 11 Nov 2022 11:54:22 +0000
Message-ID: <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221111102822.224-1-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB5163:EE_
x-ms-office365-filtering-correlation-id: b6d9cdfd-fc26-4750-8bd6-08dac3db7948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ys7Cs4+kgnEw+IubxxoOSIt9IcD+6OiIPGhkSgJbsGLGJrXXerbuFbonbMafYinB6qCzfvUDhvKu6cFAwZkkccp/E48iWucB89mOuoLGsgT49QYr1fVsCVA/LhwMD5apGeH7tjdiRjbbxs8tM6w6+dKtx9y1LvzoIdvVxM+bOsU5+TF/Ec+ZahEYGgv7YgjdG+1Lu6Y3okwqqYCo8KRNRDxvqV7bGXj6WPPqOx5IZ47pnFHchpIGK+WoYFrsgEbCHY2yAFWTrhVU2um63Z1wRBWIGH8gLAGcCrr5DgtC1+K5gVSGIbsxculgPL6V1SsnFu+ixFYTQ9qwYpMgP6XllNl33YyS0U1RdWDOrviUOwt33iW8ArwUztCKpwydCMcuPPzBwARXGCuJi90EIwy1dQUnUb5ImF5Wvbl9hIolB1DHNbil44OPVIobfpcFmmI5jXxSmZY48MXJtFOFLkq1j4Gg9p8dXP0nLKBlwhoiwpaq0BUR16+GOVcFjGFirtQcFkOGFtRNWJ2CzZemhDn6wFlGCrt9vuf1bQHQ0U78GK7C9Ue869N/3xERnvFBaXHonXwjz5+ZBK9X6rglliiG2aUj1aZlCuu7Js/jPr/u6yly66trJFj0Yo5N7TYx5IrDkhtcZek04ECCGczAHdmBp4dWUBhxeqWzl8nfWjAL9Acl6j5NTWJADzuGTkVJtM5CfttM/G8+xg1GmyDxOuTjZvBoGKb6ez/HKrhkZpqQ1+d8vrwzsVJZx92l2IoF/9YNqHRGpgdfNiuACr+9FHbuee0GSLnwkf79Y6knRAJJUCM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(921005)(38070700005)(71200400001)(478600001)(86362001)(38100700002)(82960400001)(122000001)(110136005)(83380400001)(52536014)(8936002)(26005)(41300700001)(7696005)(316002)(6506007)(9686003)(66946007)(55016003)(64756008)(66556008)(66476007)(8676002)(66446008)(66574015)(2906002)(33656002)(76116006)(5660300002)(7416002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WHC+BIqo0lHsb04lQyDhoH97Um5+ClOc9cjuZYxmJ4kgpAv6koTHyXXsWWf5?=
 =?us-ascii?Q?1SSk+NT+bL4YVrmzf7oARk16JsIvJq/6VFTaD1lv7OJcBd4bFviEBO06Axjd?=
 =?us-ascii?Q?E0gbKGfmawc7v9JPKWfYs6Bzfs/tiF5G44l9jcKKW7/RYJJNYHrEJJGKv9/F?=
 =?us-ascii?Q?+mraYOFTdJvlTRibdXwG+0s5e4t794d9GS2s9/RgXkVAeJYTCi521MYMESwM?=
 =?us-ascii?Q?6p+JyVCXLbiiBGO4QytCLUP/EEb4oExWRujuI+zzxitYQWlYOxwZwh2YJcgs?=
 =?us-ascii?Q?erLbl9aE82Uomi2bkqm10Y0EJMllTewJG5oN5bvsRm3Y6ADqqgteddDdczOg?=
 =?us-ascii?Q?gDIZvwRLZ53cD+MyiH316ZKrh8NSWAasywONcXyjhAA6/PYQppuGrayKBl6V?=
 =?us-ascii?Q?R7Pm+bdLDKIWTMD//vB7a5Uu3vNz0cUnlHumD9NKe1ShIfIxD1R+yXNsQcSW?=
 =?us-ascii?Q?JaC9tLUaigNeZLRPrNTL5d1KKkzNPMHEGMZIB6x9a74Fepsf3TypL1L1N/nJ?=
 =?us-ascii?Q?65SOMhlgUDPsAfEMMuB9/YrrI+4Ie3umZDrWiv1O/FGHX+dLcplA18N/CyYk?=
 =?us-ascii?Q?TinlqxGAoNGsGd7BCOjKONfF7JKmbiKibvKWCCJuZajq1dU07mKUpgFcNxQs?=
 =?us-ascii?Q?m8jVfxpzgeZo6OFEUFgL3AyS3PAQ4U6BZnr5ljm/gHcCrwCogVjkHWD7wu1A?=
 =?us-ascii?Q?smHq6gpMkN3NzXghOrEr+hCVCbLs1R4+qjnOZJsJsSBxKj/kkHDTQkqox9wl?=
 =?us-ascii?Q?WiJFrp0m15UjVgAOAY/S9rUSYBuo3L3V+tqewXBZKLnog88OYXhwIXv5+IU8?=
 =?us-ascii?Q?i0DP604NpDYR7L3RiaLxj1KywbJiueqfllFI4iClX1ZtGYsdtMCWzx0EqwPI?=
 =?us-ascii?Q?SdXjWYnV/l5Pqq9wQ6sClPnrtQ3DqZclPZkM+f+0yiqCH+KEc9mRT6BDOVkx?=
 =?us-ascii?Q?0f4/LO7JuH+1LufEdkH3LcgZ0/suwIeH2iKDFyoPaWFcu3yQeHoNhgpHJOej?=
 =?us-ascii?Q?XyiAS2KV7pRLHFNMg/wFm6BfEvn2lBpysONanxBpk9aNuF4dQjkG58I/0b5o?=
 =?us-ascii?Q?scWTpghSJZqncgUkCyt4M7ET0jnVIKOWT9G2t9qoJKP6nY7dP5l2TL6Ew+BX?=
 =?us-ascii?Q?JpyC1ynun63tnnXyNrKD3gbv7WWwiz9BMMzTGupK1y7CCvFah9b8nW6XAKjg?=
 =?us-ascii?Q?wt4HlsxOqUENSJFsPCEFnmdnL3P3egbT8mFvW1Crq/wUk0MRV5MPuAj038HR?=
 =?us-ascii?Q?O9SzGalttwnmPOTX8/J2wcdnXsMvQohVgysWPLXssMn2eJbqrPMCha7MhuWz?=
 =?us-ascii?Q?CkUV/039k/kf1N08til9zQM4wXknkzLc0oLT7q4TWIkZP4yJ4Im/QNb3SYLF?=
 =?us-ascii?Q?/exR3NJ/49jkl85L/IxxLMVOa2b1y+Q9yeLrnLpXkTIJN2/FNHV/zfueKIpx?=
 =?us-ascii?Q?/t6T5gLmOh7o4gyGOiwFd8FgSmCq04dm3maweKIZ+XVBUexFC/D1ToFv56aS?=
 =?us-ascii?Q?fRKBJOSMwVxKCUKvH7SwlyGsfgZtPt6UKwdB+vk9o506JdxFdVSnQQDZRJ6O?=
 =?us-ascii?Q?KtB3M0AhP5yh/NJuI8MUyCUXCbTzL5guBS/zxEnm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9cdfd-fc26-4750-8bd6-08dac3db7948
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 11:54:22.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAwiyiGTgeIdz9dFQ9Tr866/PKUuEPCf0xEVL1B72otN806odi8vJvgS1Ri2EwcV3P8yJE3fpaG1Gh+y1ehZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>When a structure containing an RCU callback rhp is (incorrectly) freed
>and reallocated after rhp is passed to call_rcu(), it is not unusual for
>rhp->func to be set to NULL. This defeats the debugging prints used by
>__call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=3D=
y,
>which expect to identify the offending code using the identity of this
>function.
>
>And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy, things
>are even worse, as can be seen from this splat:
>
>Unable to handle kernel NULL pointer dereference at virtual address 0
>... ...
>PC is at 0x0
>LR is at rcu_do_batch+0x1c0/0x3b8
>... ...
> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
> (rcu_core) from (__do_softirq+0x24c/0x344)
> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
> (default_idle_call) from (do_idle+0xf8/0x150)
> (do_idle) from (cpu_startup_entry+0x18/0x20)
> (cpu_startup_entry) from (0xc01530)
>
>This commit therefore adds calls to mem_dump_obj(rhp) to output some
>information, for example:
>
>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
>
>This provides the rough size of the memory block and the offset of the
>rcu_head structure, which as least provides at least a few clues to help
>locate the problem. If the problem is reproducible, additional slab
>debugging can be enabled, for example, CONFIG_DEBUG_SLAB=3Dy, which can
>provide significantly more information.
>
>Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>---
> kernel/rcu/rcu.h      | 7 +++++++
> kernel/rcu/srcutiny.c | 1 +
> kernel/rcu/srcutree.c | 1 +
> kernel/rcu/tasks.h    | 1 +
> kernel/rcu/tiny.c     | 1 +
> kernel/rcu/tree.c     | 1 +
> 6 files changed, 12 insertions(+)
>
>v1 --> v2:
>1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on =
x86.
>2. Paul E. McKenney helped me update the commit message, thanks.
>

Hi, Zhen Lei

Maybe the following scenarios should be considered:

                CPU 0
tasks context
   spin_lock(&vmap_area_lock)
          Interrupt=20
	 RCU softirq
	      rcu_do_batch
		mem_dump_obj
                                  vmalloc_dump_obj
                                       spin_lock(&vmap_area_lock)   <--  de=
adlock    =20

Thanks
Zqiang


>diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>index 65704cbc9df7b3d..32ab45fabf8eebf 100644
>--- a/kernel/rcu/rcu.h
>+++ b/kernel/rcu/rcu.h
>@@ -10,6 +10,7 @@
> #ifndef __LINUX_RCU_H
> #define __LINUX_RCU_H
>=20
>+#include <linux/mm.h>
> #include <trace/events/rcu.h>
>=20
> /*
>@@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_=
head *head)
> }
> #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>=20
>+static inline void debug_rcu_head_callback(struct rcu_head *rhp)
>+{
>+	if (unlikely(!rhp->func))
>+		mem_dump_obj(rhp);
>+}
>+
> extern int rcu_cpu_stall_suppress_at_boot;
>=20
> static inline bool rcu_stall_is_suppressed_at_boot(void)
>diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>index 33adafdad261389..5e7f336baa06ae0 100644
>--- a/kernel/rcu/srcutiny.c
>+++ b/kernel/rcu/srcutiny.c
>@@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
> 	while (lh) {
> 		rhp =3D lh;
> 		lh =3D lh->next;
>+		debug_rcu_head_callback(rhp);
> 		local_bh_disable();
> 		rhp->func(rhp);
> 		local_bh_enable();
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index ca4b5dcec675bac..294972e66b31863 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -1631,6 +1631,7 @@ static void srcu_invoke_callbacks(struct work_struct=
 *work)
> 	rhp =3D rcu_cblist_dequeue(&ready_cbs);
> 	for (; rhp !=3D NULL; rhp =3D rcu_cblist_dequeue(&ready_cbs)) {
> 		debug_rcu_head_unqueue(rhp);
>+		debug_rcu_head_callback(rhp);
> 		local_bh_disable();
> 		rhp->func(rhp);
> 		local_bh_enable();
>diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>index b0b885e071fa8dc..b7f8c67c586cdc4 100644
>--- a/kernel/rcu/tasks.h
>+++ b/kernel/rcu/tasks.h
>@@ -478,6 +478,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp=
, struct rcu_tasks_percpu
> 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> 	len =3D rcl.len;
> 	for (rhp =3D rcu_cblist_dequeue(&rcl); rhp; rhp =3D rcu_cblist_dequeue(&=
rcl)) {
>+		debug_rcu_head_callback(rhp);
> 		local_bh_disable();
> 		rhp->func(rhp);
> 		local_bh_enable();
>diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
>index bb8f7d270f01747..56e9a5d91d97ec5 100644
>--- a/kernel/rcu/tiny.c
>+++ b/kernel/rcu/tiny.c
>@@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *hea=
d)
>=20
> 	trace_rcu_invoke_callback("", head);
> 	f =3D head->func;
>+	debug_rcu_head_callback(head);
> 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
> 	f(head);
> 	rcu_lock_release(&rcu_callback_map);
>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>index 15aaff3203bf2d0..ed93ddb8203d42c 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -2088,6 +2088,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> 		trace_rcu_invoke_callback(rcu_state.name, rhp);
>=20
> 		f =3D rhp->func;
>+		debug_rcu_head_callback(rhp);
> 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> 		f(rhp);
>=20
>--=20
>2.25.1

