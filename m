Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31856E0EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDMNhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDMNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:37:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8C93FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681392904; x=1712928904;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XV/NJE/wtsNDsTnWueIOp1p3YnWIH+bkC7nU/zHunUw=;
  b=NYlY2zMnjl7jtn6QRge/cxLr8rWRtxkcMmoeXCLHpKmxbdSrXVpuBBa3
   Qu8qEwZ/pIQjlDJZW5LyotFka/bY0XvBZPMxqZwsCnVe8enJTMDhJtDRW
   5mwxWi1vKhJnCxrgdRFHJHJ0jOMA8tQ0rXroyLAZ9hF/aXdqWuFq85cwO
   ZnGgw+xDKuGSlgjqBawK2JdLtM6M9HT2q0PY5i5ugtjxcYBNg6Vpn2Qhc
   wccu0gjvV4msnH4DUdYkz8PF0Vx+uWau1jWsbJRb2wzwvWPB83LGvywri
   fyOlqB5Jrq2a8n2orWcrixxso0c/5JL6NCNAFtFRmBO4/o2iPQocsQ6V9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="345982565"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="345982565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="666780004"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="666780004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2023 06:14:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 06:14:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 06:14:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 06:14:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 06:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de7VjCB7PearTlg1yQ3cbL0DlLLB7ny8IwaA+AiLLKHA9c/t3xsOOL1ZgK78rgWQqwizslUrJCTVsAlqjR+rGbQ2GvF650nU2qCBzQmR3GXLIL3iEdXv2pWgrSyJ+g8dP4+vLOXkMgd8T8rTYx7DmAIaYo1om7ziXDIroe8CrgenC1VPw7m3l6T2gaDBRv4cwsYh+ZuMG1CUPJvL2YACAaIPMThEncFHU/o4hRoFuC0HpSaY/beklJImpyiJdbLgn+F4oE8LkMyeC5pWpS6FagkfAaY/I6NRaKMLbkOA8ByR03mVI7Rnc71NGvP4jz5tUVCrHVkzr9Gp8bdggmhyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ5viOMyuhC5vOIMIQ5bdQlqJgt1UxL1KjJoS246ynw=;
 b=Lk/P+tEAzZ5x34I/RlqFmS1tAMDjq6sLE5bu4cmTR4HljrYlllXH6Ew3ONscqRpawLw7ajKpehMFBHlqLWJrYvOJiVWWkDC6Wje8pCeLbMYAO8j7zdn0dtDtHIgG7cTuEj8RD/+Yo3viTISzYTuaZa0aVInxe/64eWP9PtT25NO2PbTEXv8vPV9D05wDW5bPgZT4GvRdF1d07I1YA2783eQBmxXP0zj9BzTc/o2XDd80LT3vlaROmUuhEGoNGS8NfJWnw4104GRKTJgoYGe5l2qRQbx/W53IGbzBPsiqSDvlQZQVaa8f3+z6mlr6FRt4dH1EQOdjATKT4nlbiD0FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 13:14:03 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:14:03 +0000
Date:   Thu, 13 Apr 2023 21:13:53 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230413131353.GA214119@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230412042747.GA10674@ziqianlu-desk2>
 <9b5eb88c-83b3-23f4-fc31-1bd1b9e3dc87@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b5eb88c-83b3-23f4-fc31-1bd1b9e3dc87@efficios.com>
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: f7913fff-f89a-4546-b4b8-08db3c20f3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/qB6E43KCamQ2vlr4AcndbOv0EQxm1Rku4Uk43rJ697i7CfyA3f4JZXEYJFDWAvX2sqGhq9xsp/Phd14VTN3q0r9gs75Avo0QmwuID1dmgdWN9rFH/t8lHyB1ddoXYeaduhpsjZu0utSQT1g0dilsw9VLz+MnX45AEI757ZfiXs4EsRijwplOIuCbQrAEh2IAFiWNDQx5TCsjy4YKG6y7Ii2jklS6gt/gOzp6SRn5LNx1Rh9DRFoQEhSOFSFneAL+NvcXrvaOUnNBNFwY/BpjferEaVNuNlddXo3Dx+wOsYK777essl48TZCT9prdsqRm1ywEaCnHkowUqfMFKNQVAv+ADx+VZ10sB8oujhyJZCq4Eomll/0jhHz0DhSixWfFSGLxrzb4z5ZNoL9G3VakznhbUUjlqexN38715rhxkvfs7jEHboE09MN3IQtSrpD/EYFNbjrQIfkvk3cDEmbi2k+2+lFzsuJnTmyhZWbraGIqN4OfOEIjM2F11uCO+c5JRjhGep39eI6lCxoMHw5z4cgm58/axqHfIoCTB+REM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(966005)(6916009)(66476007)(66556008)(66946007)(4326008)(2906002)(44832011)(33716001)(86362001)(41300700001)(82960400001)(33656002)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(45080400002)(54906003)(53546011)(9686003)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNAcpAUZjV7yMTBVQ94EjMnU7eruO6UcBlE+h80bDmTPtvgYlrDZUL0KM/Uf?=
 =?us-ascii?Q?JAi8HqygHCNx8qzWO7+0Ypq3GB32k7fM9OPaBCU+H2j47n4x1BLtpoyU97cq?=
 =?us-ascii?Q?C0qxE9P860NVUNEGWjDhmVT/ZOaMtgg3YI82VWM/vj6lcA5N8fqO7wlDf+ru?=
 =?us-ascii?Q?+4718gFtmlmrX2TxtTeYI51jtrlTxhlw7Mxn8+PWq0efERi4+HYgc83Ca/HY?=
 =?us-ascii?Q?QKB52Ray0MYi8s4ROBEVZOc1hMdUQGSvLkTi/EpAJkgMxPkIoSvW7SHzvc7V?=
 =?us-ascii?Q?xB91r64rmeolHJIxzXdkI9JhKCHNnh7JVmLawfXQuQLdLkfKK8IP2+bfYHxb?=
 =?us-ascii?Q?47CVLAMISFSgfeWPhYLZFtccwZgpPimStT2B1zDcrhttqIGjmlkYhYpnYgi6?=
 =?us-ascii?Q?ZxVfMTsOGe1E5QFJGxmO4igbdkmN65GirsueyljJ7ebUnsp0kHksAXR0gD+5?=
 =?us-ascii?Q?X3wV1hduNQuouqbxTo8N6ctu8e8ytiKi90q/8IgqJgPHnLtlG3XajFUtwz+6?=
 =?us-ascii?Q?p1m0MfDPX5jliwq9yqIBdhoxpA6qolYaF5QeqpFCn3mPZzT8LxBiMz2a2iIX?=
 =?us-ascii?Q?79jhnhhGi8FXursKNUp/T9rZq3lQnxLzs54qwxj9yCGWBOgXjWOwk19LPDqd?=
 =?us-ascii?Q?mgHhwA9mXclCnJsohMX3y37SyOtoY9oJc6ScooT313St+J7qHK8DtD2tqtRL?=
 =?us-ascii?Q?PZyigy0fVPNgnC2soO1Z1i4+1VoNHtxcKEqsRNyQPaxL8u/SHW2m/zknLPmG?=
 =?us-ascii?Q?MG03zanEpyPwahiZMHOj53+kcwmZn8FNYEgRvSM12Yo2VLnIDwl5sp7ST8Kg?=
 =?us-ascii?Q?oxfAT/f1Ig2zSilJY1SdJOffjzSdBzdi6gCjbR/k2iztw+dtrvV1nCW0QDGw?=
 =?us-ascii?Q?2fvXIcJI0vJgSZttmmSs1xoTV5uS2zewdsJmZVc56BWCQ1Y4BlOocWoWNZYO?=
 =?us-ascii?Q?d8+J8iPM4b8eMdFEu17nMZRaWYVIKuFj+47WZq1vRdw43z+1EVF6DBCocaxR?=
 =?us-ascii?Q?uPk36BpgZoMpFW4uWMos0f9Mp0Mk9AcXM8HRWR3fxyusTP6vpk45PWEokSJ0?=
 =?us-ascii?Q?cD+Tfjm7uxwB2T6WpMvc+CpaX5iV61mrK+pC6TpoaNjkPa3MlSybUMQ00hdY?=
 =?us-ascii?Q?4X7ZX0NlqkoSdIL6uDFG+2tBIkukdebNi8fwDO3q6bZyVMIJpShAyfwio6OZ?=
 =?us-ascii?Q?nefx+EJMIimSjp9TQ1GaK4Asiu9QK/xks3pgrqeGllauu7g+jY09HzYC03TP?=
 =?us-ascii?Q?7oulr25ibjUh/DG2pvML9jvkhiPsYmtdS2qpPGFRn/xtOCQ9skD8REaSWuns?=
 =?us-ascii?Q?QkAy2wR38DBNJxeHfp5gGM9vLrCTlkG5OGO0ntLXPZulKomilI3nzmIXGfl8?=
 =?us-ascii?Q?8ZXwUW59vAx5RuDi0WDy1Q0PHwgNjTk9Y+y8v+j5S65WJys0X55NFSIpRf6Y?=
 =?us-ascii?Q?IiM1GKzm9tkSBNFZVunxwgE3nqh7xAYHDqB7A/RjWBC+PuUXtt9eAEgTAhOo?=
 =?us-ascii?Q?LxolgQIknxgHc9N3OVNwGC/C5oKHNifFIJqTbhXnxTP1TUs87fmkDLMD6j7o?=
 =?us-ascii?Q?eoZHgp5e5iWpxhB5SdW8ke4P9sUdaMllFjcH06uD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7913fff-f89a-4546-b4b8-08db3c20f3f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 13:14:03.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyTtpfHa177awDSRu4wBCGlLDN9RiggYgmA+W4h67qV7VaAdxLUXRNSwP4P5D37xdTIvyUVoVuV2AnsTygdUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:57:50PM -0400, Mathieu Desnoyers wrote:
> On 2023-04-12 00:27, Aaron Lu wrote:
> > Just noticed below warning in dmesg on v4, the warning is triggered by
> > WARN_ON_ONCE((int) mm_cid < 0); in rseq_update_cpu_node_id().
>=20
> I think I know what triggers this in v4.
>=20
> See sched_mm_cid_migrate_from() (near the end):
>=20
> +       /*
> +        * The src_cid is unused, so it can be unset.
> +        */
> +       if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UN=
SET) !=3D
> +           mm_cid_set_lazy_put(src_cid))
> +               return;
> +       __mm_cid_put(mm, src_cid);
>=20
> There is a short window here between successful cmpxchg and clear mask bi=
t
> where the thread has ownership of the cid without rq lock held. This can
> lead to rare over-allocation of cids beyond nr_possible_cpus if the src c=
pu
> runqueue reallocates a cid concurrently, which causes __mm_cid_get() to
> return -1.
>=20
> Because we want to avoid taking the src rq lock in migrate-from, I plan t=
o
> fix this by doing the following:
>=20
> - disable interrupts around this cmpxchg and __mm_cid_put(),

To reduce the short window?

> - modify __mm_cid_get so it retries if cpumask_first_zero() returns -1.
>=20
> This should take care of this kind of extremely rare over-allocation
> scenario through retry, which will be bounded by the duration of the
> instruction sequence between cmpxchg and clearing the bit in the bitmask.
>=20
> I have not reproduced the warning on my end, only figured this out from
> code review.
>=20
> Thoughts ?

Sounds reasonable to me.

I tested below diff to verify your theory:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3e7dc2cd1cc..2c0764e53b83 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3315,8 +3315,10 @@ static inline int __mm_cid_get_locked(struct mm_stru=
ct *mm)

        cpumask =3D mm_cidmask(mm);
        cid =3D cpumask_first_zero(cpumask);
-       if (cid >=3D nr_cpu_ids)
+       if (cid >=3D nr_cpu_ids) {
+               WARN_ON_ONCE(1);
                return -1;
+       }
        cpumask_set_cpu(cid, cpumask);
        return cid;
 }

And it indeed fired.

I then applied the below diff according to your description:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 425766cc1300..881571519a90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11536,6 +11536,7 @@ void sched_mm_cid_migrate_from(struct task_struct *=
t)
 	struct mm_struct *mm =3D t->mm;
 	struct rq *src_rq;
 	struct task_struct *src_task;
+	unsigned long flags;
=20
 	if (!mm)
 		return;
@@ -11623,10 +11624,12 @@ void sched_mm_cid_migrate_from(struct task_struct=
 *t)
 	/*
 	 * The src_cid is unused, so it can be unset.
 	 */
+	local_irq_save(flags);
 	if (cmpxchg(src_pcpu_cid, mm_cid_set_lazy_put(src_cid), MM_CID_UNSET) !=
=3D
 	    mm_cid_set_lazy_put(src_cid))
 		return;
 	__mm_cid_put(mm, src_cid);
+	local_irq_restore(flags);
 }
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3e7dc2cd1cc..41ed7022bab0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3315,8 +3315,10 @@ static inline int __mm_cid_get_locked(struct mm_stru=
ct *mm)
=20
 	cpumask =3D mm_cidmask(mm);
 	cid =3D cpumask_first_zero(cpumask);
-	if (cid >=3D nr_cpu_ids)
+	if (cid >=3D nr_cpu_ids) {
+		WARN_ON_ONCE(1);
 		return -1;
+	}
 	cpumask_set_cpu(cid, cpumask);
 	return cid;
 }
@@ -3345,8 +3347,10 @@ static inline int mm_cid_get(struct mm_struct *mm)
 		if (cmpxchg(pcpu_cid, cid, MM_CID_UNSET) =3D=3D cid)
 			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 	}
+	cid =3D -1;
 	raw_spin_lock(&mm->cid_lock);
-	cid =3D __mm_cid_get_locked(mm);
+	while (cid =3D=3D -1)
+		cid =3D __mm_cid_get_locked(mm);
 	raw_spin_unlock(&mm->cid_lock);
 	WRITE_ONCE(*pcpu_cid, cid);
 	return cid;

And did several iterations of hackbench, no more warnings from the
original place rseq_update_cpu_node_id(). It appears solved the issue,
will let you know if I ever hit it again.

One more thing is, with the above diff applied, I still get the warning
about cid =3D=3D -1 in __mm_cid_get_locked() so I suppose disabling irq in
migrate_from can't entirely close the race.

Another thing, it doesn't appear there is an user of __mm_get_cid()?

Thanks,
Aaron
=20
> >=20
> > [ 1819.649803] ------------[ cut here ]------------
> > [ 1819.649813] WARNING: CPU: 188 PID: 29881 at kernel/rseq.c:95 __rseq_=
handle_notify_resume+0x49b/0x590
> > [ 1819.649823] Modules linked in: veth tls xt_conntrack nft_chain_nat x=
t_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_def=
rag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables nfnetlink br_=
netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common intel_unc=
ore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_th=
ermal intel_powerclamp coretemp kvm_intel binfmt_misc kvm nls_iso8859_1 rap=
l intel_cstate mei_me isst_if_mbox_pci isst_if_mmio idxd input_leds joydev =
isst_if_common idxd_bus mei ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_m=
sghandler acpi_power_meter acpi_pad mac_hid sch_fq_codel dm_multipath scsi_=
dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops pstore_blk reed_solomon pstore=
_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid ast i2c_al=
go_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
> > [ 1819.649903]  sysimgblt crct10dif_pclmul crc32_pclmul ghash_clmulni_i=
ntel sha512_ssse3 aesni_intel dax_hmem cxl_acpi crypto_simd nvme cryptd cxl=
_core nvme_core i2c_i801 xhci_pci i40e drm i2c_smbus xhci_pci_renesas i2c_i=
smt wmi pinctrl_emmitsburg
> > [ 1819.649924] CPU: 188 PID: 29881 Comm: hackbench Not tainted 6.3.0-rc=
6-00002-g1acfd6ae9afc #2
> > [ 1819.649927] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, =
BIOS SE5C7411.86B.8901.D03.2210131232 10/13/2022
> > [ 1819.649929] RIP: 0010:__rseq_handle_notify_resume+0x49b/0x590
> > [ 1819.649934] Code: f0 ff ff ff ff ff 00 e9 00 fe ff ff 48 ba 00 f0 ff=
 ff ff ff ff 00 e9 3a fe ff ff 48 ba 00 f0 ff ffff ff ff 00 e9 66 fe ff ff =
<0f> 0b e9 7d fc ff ff 0f 01 ca e9 a6 fc ff ff 48 8b 4c 24 30 48 8b
> > [ 1819.649936] RSP: 0018:ffa0000018b0fe60 EFLAGS: 00010286
> > [ 1819.649939] RAX: ff11007f73500000 RBX: 00007f81a7226fe0 RCX: 0000000=
000000000
> > [ 1819.649941] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: fffffff=
f828f9477
> > [ 1819.649943] RBP: ffa0000018b0fee8 R08: ff110040c192cc28 R09: ff11004=
08e2a3980
> > [ 1819.649944] R10: 0000000000000001 R11: 0000000000000000 R12: ff11004=
0caa64000
> > [ 1819.649946] R13: 000000000002fa40 R14: 0000000000000000 R15: 0000000=
0000000bc
> > [ 1819.649947] FS:  00007f81a7226640(0000) GS:ff11007f73500000(0000) kn=
lGS:0000000000000000
> > [ 1819.649950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1819.649951] CR2: 00007fd8b00d5000 CR3: 00000040cf060001 CR4: 0000000=
000f71ee0
> > [ 1819.649953] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 1819.649955] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000=
000000400
> > [ 1819.649957] PKRU: 55555554
> > [ 1819.649958] Call Trace:
> > [ 1819.649960]  <TASK>
> > [ 1819.649964]  exit_to_user_mode_prepare+0x13b/0x1a0
> > [ 1819.649970]  syscall_exit_to_user_mode+0x2a/0x50
> > [ 1819.649976]  ? __x64_sys_read+0x1d/0x30
> > [ 1819.649980]  do_syscall_64+0x6d/0x90
> > [ 1819.649984]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [ 1819.649990] RIP: 0033:0x7f81a77149cc
> > [ 1819.649996] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8=
 b9 c0 f7 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05=
 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 ff c0 f7 ff 48
> > [ 1819.649998] RSP: 002b:00007f81a7225d70 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> > [ 1819.650004] RAX: 0000000000000064 RBX: 00007f81a7225da0 RCX: 00007f8=
1a77149cc
> > [ 1819.650005] RDX: 0000000000000064 RSI: 00007f81a7225da0 RDI: 0000000=
000000135
> > [ 1819.650007] RBP: 00007f81a7225e50 R08: 0000000000000000 R09: 0000000=
000000000
> > [ 1819.650008] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000=
0004a3c12
> > [ 1819.650009] R13: 00007f81a7225e10 R14: 0000000000000000 R15: 0000558=
df7af6d00
> > [ 1819.650012]  </TASK>
> > [ 1819.650013] ---[ end trace 0000000000000000 ]---
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>=20
