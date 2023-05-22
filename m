Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6B70B81B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjEVIyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjEVIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:54:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD138CE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684745651; x=1716281651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kX35+eEXocL4PT/UDdfwMB78FK1QumvHXTQCxv8Dq8Y=;
  b=Qbb4NxWJTTYZvcYAHRWh8KIr+jGOXju3Vav/v0qMvJOgvw63JM/6Zu85
   R+VftugMoV70rNgpY/F2xoMkCcBU7NuqAIoJKf7TI3855yH+uTn8ZiYSY
   BatEhv4liTA44nl7Dpk0Sqc9l/oppw6af33xLv+FroqzL+W/j/PjWazNY
   X9TxXYhSvmFOPvoKAdSq6I9vFwgD6hGVQC6S52VVqNPXpeL4XExGlo4PW
   btEksoM7oWNcMKAfg3mtzoUAuJzIy18qXDTd1h/A0uHJ/McmPNlQrn4lx
   z13BKt3+qPuVC9S29mi9joFC3Va1HQ83uph8wYeVLXBFPKyqG1Hwwsj+r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="333232119"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="333232119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 01:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="949985576"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="949985576"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2023 01:54:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:54:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 01:54:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 01:54:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 01:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi9l/hUxRr8ZCP2uwW8oniDR5YiVvTOiVaTDjw+YApP0kjjdIRQstke1uskeJBIJRU/kXIhigeSxEX9gpI3APbzvriwHwjnQlGSoZOQoP1VJRsFC6RFJbEtl7OnSNJhIdB0znmJXX4DR212aefJmUWB0kXvU5nSJRcxVp5Y07mwZqtVXSLYffdonqcRr4aTWz9mdNiXFxYZgVyczFkR+IZ4+82lFEvEdPb+TgQOGwZRHvrXMwEeaYQ//Q0fiaNBEAUVWfSo7ogNsZQPSvGxydQNeDKN8TVGRAsf3VFwY+RglztD8kg5JjYhfjskGC4IhfmY/6QXCV0QvgvDdlhCycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecMSU4cy9AkPG8Dp7n0iNlaTS5pl6zzjuGM3QC233Bk=;
 b=IoLjdYbEpfYBnSIlzHcnmfS6FCvCAHURq67sMqvUrO+33xChYyfSudK3ohJI5JkloD9oP/B51I8xLyQLBCxrTSwyPLNvZK/tNQrdw/g4rgy0sSvpHmgAbVmmKVZ8SOHroCzsYqFO7xMsoz1j2zZC78EmilIFVkLXokts8M76EvxeLFnS/mcoE2K4+NdbmVJ2f+zjgB2DT7HmmZlfxkLknVn+WiYfRLio76lbrnc36mAAhTkBdfg6D3SK44V+pa8jMlxJmYUj7AQN9zqlcE5AUKNLrtY2wwkg5Ptnv2+0jWJmrohNYzZPSPX450WZNOe0zEHxTmyMycJkigu/lyNzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 08:54:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:54:05 +0000
Date:   Mon, 22 May 2023 16:47:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <paulmck@kernel.org>,
        <rui.zhang@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZGssENXFKmOk/zL7@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6s4ye9b.ffs@tglx>
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d62d5a5-fe3a-4c99-4186-08db5aa21884
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqqE+bHsRF5XfePG4OzAQFfEnWKBLhEfYIzTtCEnHRP5Xu3nmEWqMDsckvf8O8zYTn73CY8Gev4vwUE/00kFQpBhSjmtzwHId95MnGeJPqblCN6tEKR0DGYQxMaCKwkNw8fhCTUwbthNJj58+f8WTuXHz882hWSeUHDdGWx4yFmKxVSZKmqb2EGFa3Jjmgrtov0RGMp9DEIU0wWdZsPcN7ByuYzIfSQE6hiVGPfojt/+12ZbWqxej0ZWktRJphDDYMXykihSMtBD79yOt/IvduPNEQdkN6a+387IF0pe6WiQs51m1lxL+HwBBE1wUirfOH1LL6hfdpfFFdcXIBEpCyWs2db0UYTM+fR1xFrkVOhaKqBR7RRs/fco4oMvf1J4fTIo5tDA2n0PMYGepf4zqxOE7aA9Bhn4T4hJhwZrr6P95aSfge7RcKpBPTM684ABo1p6wbi5TiRm/3Jao70PZ7Agr2LHRmHK+nySjoiNBnsEAMgK7Fe0lbgoR1sK8hlZ3ErK19OQoUzogXt3nCwU3AKMdIZOxtbx8vG7Y52c8jUnlU+wvZwvNnhdVExh3dr+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(2906002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(66556008)(4326008)(6916009)(54906003)(316002)(478600001)(6666004)(6486002)(86362001)(26005)(33716001)(82960400001)(186003)(6512007)(6506007)(9686003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqYMqovS8Zi6KsLLwO3C+DRzg8xm8BD720Hc2R/pIkocrCvyxQJPnb0VApDe?=
 =?us-ascii?Q?AoQi1ST+Yk7ZRJqEt1AR+uYQFOsP87dOtUQO8lf/523hqx0IoQtF4SLMesIt?=
 =?us-ascii?Q?FseKSI23ogXt2k8omuIANgln2xP7ym4AADjUiUJ0ztKuSnts3eYyhn3iu5gE?=
 =?us-ascii?Q?C+y5y3V0N53FQfDHf/o33XYWZcAsyEMdMbHb9Lqjze4gLCc+WnM5VGvpw4nY?=
 =?us-ascii?Q?JqBIMYTr+Y2ANaRU+sbdvLIpuaAaaGzs/bxgH0n7Bn5Tttqb0qWZexIanvoB?=
 =?us-ascii?Q?cLJLMVtPSf3qeximkhaXg4prehO67q5C9K+QcTU0RvFQrLccnQaZtm2jXJ1I?=
 =?us-ascii?Q?6jjE0FJ2++IfqHZy1+YNaTnLRDAnhNGdD/YtGkWTYE09XJ2G4X+r8W5YFccl?=
 =?us-ascii?Q?WsJv4IjhyNmhn1BvRC5Hb91m3Uwa7omFQm1Ig0fg+A2o8+Vumn3SgRcbceEQ?=
 =?us-ascii?Q?/sAASTXspCtVhSPLB3E4StEzo2o357Exoc42J1TDsSWBS/zcTrJtOWx6EDXi?=
 =?us-ascii?Q?PkaEJ8W4znFEsAqWe/54CmqE0qCNJgUWU4Y3K9A3cjg3EOzxK7aRaarNKPG2?=
 =?us-ascii?Q?jVLQGjsgXYc/HzPxMu3xya2DVv52jW9aUiZQ1GKr7Fc6sdyYwh1wRu1H94SH?=
 =?us-ascii?Q?1v3Q4J7BQv75jsqBNN7jmA4ct7basQCOC2nwhycaAnBxH8q+Kt3mxUK3101j?=
 =?us-ascii?Q?b7zse4bTFm6vtt5DtZRAVL7oVd+8sOvpdG9AGCUqT2A++Ygny6vr3tGH/ibv?=
 =?us-ascii?Q?EwQlrcaUOVAscNYLfErXHL0FMuEjmWQgVj0cjMnvpzKim8fzzbr65US/8rCd?=
 =?us-ascii?Q?PD/U27ijKdIaxb1I8WkHooaIqHEk3PJo0yIk/pMZDkBWlKYody7i9up0D5oj?=
 =?us-ascii?Q?+fA3ekGIT2odMXJVYTpN4eYKnODWgNQvy7TwKiN8MgaJsKt/GNpOH/PYWoDq?=
 =?us-ascii?Q?l2XrzeJi/uSTTzN6rSY/mmlNhUBW3RTQPv9qCBzrjS5jifhms0sAT3Grc2No?=
 =?us-ascii?Q?Z7BLp9Y3ANWdc5fZJaN72w43mJg8EKrats7vabjGe8iuU57r2INFabUg2n3D?=
 =?us-ascii?Q?5MN2eBjOTbEl3KzXKSfmqG5f61De/JECsGDG7Da7xuGldw0Bn/GgX4767y9Q?=
 =?us-ascii?Q?0O4cyM/4JiQGiehOwjZgDLN1TpjtUyB13dFkMAxkzHIIz5PmCWgMuzXmRwbi?=
 =?us-ascii?Q?Dr0vI+j7oAbvSqM2+7S93wOiaFRwSwGUkbZ9Gtel/fM4DK82+4hl20h86qwM?=
 =?us-ascii?Q?F/a8N3ohtEPnFtB30prhBnhV13jszawtM5lxN6Hrjn4tm4I20h1yhm1lmLEu?=
 =?us-ascii?Q?peSCBZnKPwWNn3BX94IdQz/VZJfgi8CMfC0WF5ltLxqS/r2g2OdYlONXgVUb?=
 =?us-ascii?Q?Nt8C80APmGfqAk79/DmTF4whXyq/zqjBFaoQOr3OU5hbGI2Q05vjRbrctZAc?=
 =?us-ascii?Q?V8OA4q9Bfb127dX3cAvSG+PRkTTPA7RSzpYnKXZgGksOqje0eXTwnDegj6cU?=
 =?us-ascii?Q?GViUNqeoyXelI7rU4AAKcD4h/JcGU6z6CiYVL9MO9M923TgqRburJcGHRMHz?=
 =?us-ascii?Q?K2kzuBgLAuCtv4DXbkZmkLKspDVR7amK5UzIsqJw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d62d5a5-fe3a-4c99-4186-08db5aa21884
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:54:04.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOjgu9qsngZE3gbOKhf5MeIY3Qcx1WBo4fKqJTm2leFdxMiNzuchgeWaCoKj8cDbGJTS9cWjon0rqUmIBYkspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the review!

On Mon, May 22, 2023 at 10:14:08AM +0200, Thomas Gleixner wrote:
> On Mon, May 22 2023 at 11:30, Feng Tang wrote:
> > Commit a7ec817d5542 ("x86/tsc: Add option to force frequency
> > recalibration with HW timer") was added to handle cases that the
> > firmware has bug and provides a wrong TSC frequency number, and it
> > is optional given that this kind of firmware issue rarely happens
> > (Paul reported once [1]).
> >
> > But Rui reported that some Sapphire Rapids platform met this issue
> > again recently, and as firmware is also a kind of 'software' which
> > can't be bug free, make the recalibration default on. When the
> > values from firmware and HW timer's calibration have big gap,
> > raise a warning and let vendor to check which side is broken.
> 
> Sure firmware can have bugs, but if firmware validation does not even
> catch such a trivially to detect bug, then their validation is nothing
> else than rubber stamping. Seriously.

Yes, agree.

> Are any of these affected platforms shipping already or is this just
> Intel internal muck?

Paul and Rui can provide more info. AFAIK, those problems were raised
by external customers, so the platform were already shipped from
Intel. But I'm not sure they are commercial versions or early
engineering drops. 

> 
> > One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
> > and they will also do this recalibration.
> 
> It's also pointless for those SoCs which lack legacy hardware.

Yes.

> So why do you force this on everyone?

How about we keep the optional parameter, and enforce the check for
bare metal platforms which got TSC frequency info from CPUID(0x15),
like:

---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..ec1ff6aaf5a9 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -670,8 +670,10 @@ unsigned long native_calibrate_tsc(void)
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	if (crystal_khz != 0)
+	if (crystal_khz != 0) {
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+		tsc_force_recalibrate = 1;
+	}
 
 	/*
 	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal

Thanks,
Feng

> Thanks,
> 
>         tglx
