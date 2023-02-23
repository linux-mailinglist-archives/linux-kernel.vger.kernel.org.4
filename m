Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3A6A03EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjBWIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:36:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D324DBDF;
        Thu, 23 Feb 2023 00:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677141370; x=1708677370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aftTK+ILsF2a4cPsExhjKuKon7aDKj90O1VnmXDrb5E=;
  b=Fhsxh64CG0OJ1isl67lILJf7HQ7Om2oJ2jaEu+k8cpQ+o1DnNL2oJkm3
   YO+BdCMaJb5cwWjzS1XvFPnOp3jiNnfluLwUNirGdKMaJqhOv/SrzMpib
   S/syZdSIbJzXP38uN9C4eWC08Ub1EYL+QpXRZKX9igz1oC82Zh0MR6bDl
   mI42RN8GXMn+GenxRVu0B94BXuZSC7zj2JpJhEJmvQ/ONXBQh0LeiUoIg
   CMIHGUEbgwOa4LFA1dwRaghrFNNRP6oVIfJ84k8HFN8O1mWitg96b+veN
   drk2rUog8QPeS2tGlIFgNfkMeF4W4aB8s4fs3Mi9RBGRKzjg0PknFRjhr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="395634585"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="395634585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 00:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="704768319"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="704768319"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2023 00:36:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 00:36:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 00:36:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 00:36:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 00:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEqrw63qBSsvib3P/gIQzGAFQ3iOzQBjBubGHD/utFKn3/AY/SNPutZRMgyearcVosGOJPQEUPXn1LxVl8blXHU+0pBrN4btCOPfI99fCIfcktTk4qp4voVrubFOt26Vk9eaJLW+9cNN0hpmdy5XQq4qxi/BqbzXNNP3YPrTvJRwZFiICx2M1gV0yBaxNYRfXXg4c+9w6kBQOOPCwgIgI41/PTkxdT66mFocRI6fmbQFamJKab4sM7kL19RoAIJwaRdY66qfh1K43bblNv0mOqzXjqf00tdpi5Hm/+Vo4oK9o31Q/UdfS/K/7/z2iLSN33x9xjVQWcNpmPvyfgrpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG6UzuTEdCq2pxZpYqyiVU6bd2K1Er4wmljyU7Z2oRk=;
 b=KS5yylK14xZnLAY6+YyhBtJxS+54WdGDjcg62w0F8Cp4hWY9OM36wTyunQXAPVtNpdC0HuFaOoIs1qpC7SujxBUqtX7AU5x7cJq2uzZ00r8P70F1gOVzC9LaxFnkOrYZUqSoU3R+zIrA7aJ86wCEKCMldzf0vuv8fJ8KIn9Ko6DviuWuad9aQy9ptgj9yrLcidFNwjiF2QFK9uk2/W/7BsqaQFPO7yGn/67Tbqiity3bxMH/piL4NKGXGg4paqjIARzHeLoaEvcSWJKFH0u/nS/wKJD6aAXVfuDGIwAGc2pImY7D+H6Mw3o1Ep0q8Ct3Qjcvphbz+0t+MlK02Apeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 08:36:06 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 08:36:06 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+oSq8/M5EvMEKqC3ssehkf+q7cNNog
Date:   Thu, 23 Feb 2023 08:36:06 +0000
Message-ID: <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
In-Reply-To: <20230223063022.2592212-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: eeb76ef8-5269-4214-391f-08db1579019d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0DQBUr46kq6HBpvzgDBHOOVd2E3RQaJn19rW3kHp/DaPt3tevoUwgI9DkhbaG1Onmfgucc0vEw5cMzmBkTZr2IT6inSnRFmUfWxniH/CzwDITrnH0cS1gwQbOAJPjFTbLItGVDJVtdCyK/aQpAe4dwkXnrfTPwNX7m7kFx7izgPdf8bSKcA5xLXBoH/iY2FElhhzzw55tDNTdQoB8S9fa2cKKdl7kNbWHx8AHnASum3jyM7OC0aNL0NvtGWux9hDwpm10C40PN0EmV7vr/swH1J8wqQHf1sSnoo7TKW8mphZebL0PRtZdFEDRsJ+SqkrTgxpJjLHAgqcPO544bJHX4ywhMs75qsgtQ13P+8ocst+WIf1O5WsXTPGMxbdU76I6Tl/95zxArcmfyrOe8sSWRHy2UYp7F3DufRgNdyTFSJCVvKD+dPg21usaL+NnlOXyZ2Vvz2CRVPW9lsmfnKjL1w4Mg5zGYLKevETYrWl7EEGAeimAKTPqufAW0cExWjjfMs1IXaYq2XwgZoXvAponm1jMDwJ8rAVsRyGhUc8H+i7iT/8nVgZxKUa//M8JvCWL5//wBfAH4igvjlAAiNk6tAzAgqTsYeQRADfr365JtbcdALQoxFHAyyiWvJ0OG83+WMGPDLSTyo93kVo9VzfYv8CijGr1ZCIF/nrOmDu6JSYD9nRS/Uf2rqn4QRqKeanLoDIwElvwxhIE3GGhN332/SoTW1x4aMwJqng9RAjIq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199018)(478600001)(83380400001)(316002)(110136005)(38100700002)(54906003)(122000001)(2906002)(82960400001)(86362001)(8676002)(66476007)(33656002)(66556008)(66446008)(76116006)(66946007)(55016003)(8936002)(4326008)(64756008)(52536014)(41300700001)(53546011)(7696005)(5660300002)(6506007)(38070700005)(71200400001)(26005)(186003)(9686003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kv5FJufXez/5GyKbdy+WXnDuhdQkNRl9EpwxyY3EXTiDC1gcANiKbrG1dIA?=
 =?us-ascii?Q?Tbr1H8HQnlT+EISTZW7TaAioPHt1Yi7NExJDJrmoFLCs124e4m4A9lnZ1w3l?=
 =?us-ascii?Q?yTLLGaG3GwA3lkr8IcMEs1Ozi0fDqKYV3mylY/Ku0gO6pIVUvvqToe96sIxT?=
 =?us-ascii?Q?38Z+kI/tq7OLWAj+XUBTrFepQky2bQ8hTad8o21DuSrGXMlxBd4iaHrb83EB?=
 =?us-ascii?Q?vMd1voedSH/LDb1V9fQTqxOBTv24TVnbI123c8n7i/S9NufF6YWnMwjon0Gc?=
 =?us-ascii?Q?9eJRDjFuwL8bcp+dCuf45LV/sqQ9cMzESZclZ00FnEODEkMsNYnUnyafPth6?=
 =?us-ascii?Q?TlqxvNQQUSJgviDg3B1YvxX3+TaIY7bAoRV2wmqNSmjE4jBcPRifLDZ8hVMd?=
 =?us-ascii?Q?XqWCquioNWHBgh7/vbJyHrIwsS1uQXO9Wvq+r5P5+mDrrPaEZBdhd1fy41EO?=
 =?us-ascii?Q?qqqm2jnyss2QYKhV3eG0yi5dUQWBUY1io/4PtmY9EaPdd7Io+D7xM0+iYC3f?=
 =?us-ascii?Q?TdXLBu8MBa7W7vkgtX5wI592bqMrfo3HeGoLQGJbv+AnvNYgS0O7x4/9rnXh?=
 =?us-ascii?Q?yiYv/ayUrN1/Go61zm2/MzfOg3/i6k/tyq5gZ+s3TB3Sad1PUzalg/VISvUn?=
 =?us-ascii?Q?gvaCVPQboUHq5l+clnguAwrvqxdlppUnOm8fml+/gVbSs7NFlQ5HuL8P/+6H?=
 =?us-ascii?Q?TndkLcj6ksLkHPNjoScbdfxC8Osv+8YZ0nGOqf6v40I4r+ylTDLx5oDMEStu?=
 =?us-ascii?Q?cpvTgejKRVWWMJ42942JnnCyBXnWapUQZXIxSL9X2etY/HnOuxjlFiYgsyWg?=
 =?us-ascii?Q?j56PxMh0laLvCqhzg09mZy7mcXXhH/tEmmlkv8M2fH97TGvcx/vsfoXRIDkI?=
 =?us-ascii?Q?p6bWF3VLNKnrINN2JJ594x3+oWjTk48gGouK7qOt81+QpV+Jrl2BQzDM4ImB?=
 =?us-ascii?Q?9mEfL85O1GK0tPbaMtpnNwh5FMGbnQZg9b0XGx3zYvFQsPXUSnVotlhEXdH0?=
 =?us-ascii?Q?/JK1CeXsLeoKE6RG1QDOiopiIdLewQebsUEuiFwY6YNwYflgX+P5HYDw4B3P?=
 =?us-ascii?Q?YXW6P7eGFA4UyYp3yMTwUUYghgbjj0Q35By0bLFyZPhJ5Vwcdr6yHWca8Ov+?=
 =?us-ascii?Q?m408wJZjhHPoq7ltAcNbjHOsnkhGM6tVHA6HPrpWUbirk56iDbp2Z4kGnAgv?=
 =?us-ascii?Q?Q03Tu0PVC0P2i7z1V+q6qHM6PGTC2IwMJ8a/L5pcur1EXXYCQv2OVViLnkKc?=
 =?us-ascii?Q?sSsz08TedomBv43vx4i+TTS+l2e1hOZjxsAlTVG3EBwsm5GP9xjg30TrJKQ6?=
 =?us-ascii?Q?jkl2bkJGI45L9owKKQgUCSYqaxQqWgk5O22FFozPspnHtvyanwUeGlMldnHR?=
 =?us-ascii?Q?UOgS55DQMzwur+WEQBnmD3V97OfWG78b+yz+P/xXAwnk2WqAKxeQNMoX4ePM?=
 =?us-ascii?Q?AK/llRPIUOI5pwzX3ELVQPC+7Q/QZ28HAFaqJCicNF207PTVb1ZhcQwUM3Tr?=
 =?us-ascii?Q?YDXOqAFnaZEvDYGX6yzL01EypFxv6ftytMunrg8lruHvcF1V9euOLt24XAyw?=
 =?us-ascii?Q?XJKPFBbquRaQqurtvHtmR+1A1+rNt6Hb1cyaKPuR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb76ef8-5269-4214-391f-08db1579019d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 08:36:06.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jAs4CNQ6GjCZoeQli3gMNQZMdyZpFABQETb+nRB80affeEgzLT/KQvuLtlQ/qEVgHWYiuH52R46ponL5/a80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zqiang <qiang1.zhang@intel.com>
> Sent: Thursday, February 23, 2023 2:30 PM
> To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> joel@joelfernandes.org
> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> call_rcu_tasks_generic()
>=20
> According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeu=
p
> using irq_work_queue() is because if the caller of
> call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built w=
ith
> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, due to a spinlock will be hold in
> wake_up(), so the lockdep splats will happen. but now using
> rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> rcuwait_wake_up() no spinlock will be acquired, so this commit remove usi=
ng

There are still spinlock-acquisition and spinlock-release invocations withi=
n the call path from rcuwait_wake_up().

rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:

    raw_spin_lock_irqsave()
    ...
    raw_spin_unlock_irqrestore


> irq_work_queue(), invoke rcuwait_wake_up() directly in
> call_rcu_tasks_generic().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> baf7ec178155..757b8c6da1ad 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
>  	unsigned long rtp_jiffies;
>  	unsigned long rtp_n_lock_retries;
>  	struct work_struct rtp_work;
> -	struct irq_work rtp_irq_work;
>  	struct rcu_head barrier_q_head;
>  	struct list_head rtp_blkd_tasks;
>  	int cpu;
> @@ -112,12 +111,9 @@ struct rcu_tasks {
>  	char *kname;
>  };
>=20
> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> -
>  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> 			\
>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) =3D =
{
> 			\
>  	.lock =3D __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> __percpu.cbs_pcpu_lock),		\
> -	.rtp_irq_work =3D IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> 			\
>  };
> 		\
>  static struct rcu_tasks rt_name =3D
> 		\
>  {
> 		\
> @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rt=
p)
>  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> >percpu_enqueue_lim));
>  }
>=20
> -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic=
().
> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> -	struct rcu_tasks *rtp;
> -	struct rcu_tasks_percpu *rtpcp =3D container_of(iwp, struct
> rcu_tasks_percpu, rtp_irq_work);
> -
> -	rtp =3D rtpcp->rtpp;
> -	rcuwait_wake_up(&rtp->cbs_wait);
> -}
> -
>  // Enqueue a callback for the specified flavor of Tasks RCU.
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t =
func,
>  				   struct rcu_tasks *rtp)
> @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> *rhp, rcu_callback_t func,
>  	rcu_read_unlock();
>  	/* We can't create the thread unless interrupts are enabled. */
>  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> -		irq_work_queue(&rtpcp->rtp_irq_work);
> +		rcuwait_wake_up(&rtp->cbs_wait);
>  }
>=20
>  // RCU callback function for rcu_barrier_tasks_generic().
> --
> 2.25.1

