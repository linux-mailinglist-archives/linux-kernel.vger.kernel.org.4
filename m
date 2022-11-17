Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21EF62D23D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiKQERK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiKQEQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:16:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE43554FF;
        Wed, 16 Nov 2022 20:16:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FToXcUD/0ZDaxMg/d2+lFb3ebvFDbovNJsGqIR9Gfuvp0HoVdK8ZqbY7sKqYtYc4QfHK7oXtJ+v3NnTHHFa6LgDoVpwCSkrO1q7OwsHNIU6V43biuCqHos+w36xBl8HIYf2aDIzElybLFfweRb4o23EXoisdsFz6cJVHZ60ziU3YVl814CztOxnqk+/BbjIcfveJDRqXCFYNDl3Ktu4t8euUc+WPlV6DraAWhHFpaBtZU7RX7Fmz3334V3CM/67JHW9Q/H+iAcP0mehgnlO77RpiWNWYL1eF70urEe4LYe/fQUoJkKZrymhSeaJ4xbXk4vSUGtyzFr/UX9EjixH7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuI9APGJgJMRZRD6pafjqhvgOIkWOv4bjHzYCOR3zCA=;
 b=a1JXN+NlGomHt0b2yb+L4Nl6Dw/DBV/JbP1k597EqEq08M3rguvJmmQaN0ew0bvpcFLrIz7wMFmRBErVyLy1TbqqCUiEOPPe5kR5dZLftXJZOZ55f6E0170gjxghTefxONA17jxbh+Xd8c7u927IFcuMMw42CLjL26PxLWbpCHv30/e2m9E7JH0pqW2bH+6S4ztA5SrpJ7Kms0gn7ObHw+T/tHMjRqa0BZeSPnV6jv5SAGHu1rDWjYGmpgQ8AjDEq44QoU3E6mASFTmTpSSnLVFYND9WwTCLJL17IABh7noQfkKmYVWSsgFH+jKKJEzanCRFsGsY7Re/5wzRIAryvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuI9APGJgJMRZRD6pafjqhvgOIkWOv4bjHzYCOR3zCA=;
 b=rVPhoTHm8HEUBhEiYPZeP+v5rNHl4IiXHiEEyzpGJ1Nf0EGOJjMwRpVZJNg9FMvIBhB2YESUo/9gcqxqyHPS1aqC4DXRiWaNAlHq4V7Gyjmv7RMOVeLjwpREl1eBPQjCD/mqTJ1TZNQJaHN76W3kJjUgsMlSYV4xA1+zX6Cdvw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 04:16:04 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b%2]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 04:16:04 +0000
Date:   Thu, 17 Nov 2022 09:45:52 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, ananth.narayan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Documentation: amd-pstate: add driver working mode
 introduction
Message-ID: <Y3W1eGfSQBsCASUG@BLR-5CG11610CF.amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221117024955.3319484-5-Perry.Yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e118eb-bb4e-44cf-3ff2-08dac852716f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2Th/Hu9UaU7NmGFIb3AN1k3gW9sIPTjKSylZOv2hpnW9t2QhAZQlyzeYD7vqFAn0wPv6CBmX3h2ROCuqLCNSCPCeXHM1kY1TgC2e5QLEyd5iML9d02Dbx4rtyv5ZbkldeFOXcKz+Q9453IbeEhTlpR68eFIoMI6ASqX2y1QX264o3ys9xqU6a+b2GKlqKE9HLAlo3xqe+be2+PTEE6u4g7yjpR0BwhPPUthIovOdzd8E3tZFMPjfhyvM5tJyLt2qOFSbrT68STp7Zt9LZqaD5X1IVc8hHbMFjoJ1FnlVVGyTZP3S9ZcTnznQb8lwqpYZskhmB+Xytt4u2nc8I6FJH86DUw5Vz9yNuquO8q0oOvqyUl1XEFdg1NmVErO2kixB52UjKy/DNBerWh2OJc5VFxQ8/ES2UFtVbs7ugDXP8ERLy3MP1dqyO8swQL0+yl/JNfnMEgst22IMyz7kz1zCDdtCCrS2HOxJt9SBTcy3zuM6GxPZuOBzj2G1/VaBWvydwi7Bk8cjVgjcxg8lfi0sTCRQ3HrLIuSStzua8z/hndnUJHK1MGp9aYCR/rx5gl+Ey9uPhOtdUgd7d8J4gy5JmKilWLc5X9cCEWV+cYZfh0Z5QXKrGgeE8Q5+9jqluSrzXwhesYZLnS4hWnp7YSrKxx6DwRLwbFTMCdPhPiW61k3n1ZgaW3zZhKHQUFqnIqN2Ik87eFUes7Xb8X+jVISIpkb1BQoDKg4FGzZkS44/f6WmiycSXf8VIDemLerq1m3Hwk9kwjwuHNFBlo9qd6CeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(6636002)(6486002)(478600001)(4326008)(8936002)(5660300002)(6862004)(316002)(41300700001)(8676002)(66476007)(66556008)(66946007)(83380400001)(38100700002)(6666004)(86362001)(6506007)(186003)(26005)(6512007)(2906002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgoU6tyvFjqWyeI6INykT0Gg+aX8uKQDtA93xn4fpOwbwBeOPONO1nduQOit?=
 =?us-ascii?Q?u6EwUhqLwRGnTnHP7S7IPJm2pXoOG0TYw3MLeoCINnf4umGOCBm6gDYZN0XZ?=
 =?us-ascii?Q?1/DOw6F2kOzWz/RxI/1mUMGBKrcgC0jm2HURGdwyss2Oq0N/WSl6AkE/LfQW?=
 =?us-ascii?Q?I9OkEt8aFWHcvjKzrhF65NG1metBSKal2EbbDIAXiotFT77hHdUOGonwvz1l?=
 =?us-ascii?Q?vTIs3+QyJHSEv+KHjebpmJuFohaqd/BmROuMKKgnw+cdgWnCycrQlHGhTUO8?=
 =?us-ascii?Q?D23eluPmaIFAeBpH1GoMadFVyJS92SQDje1uRsF0IpnUpXBvB3+dZfz0WbEw?=
 =?us-ascii?Q?eLMr77z+It8gC+W+ziIc1qyJW1dYtpGamVOhxYcJylirf+kmxoMT8w9rmEZt?=
 =?us-ascii?Q?zZvMoI0sZBn4Ed96Lm7za3IL4qeBCFYko3aJrRZjcAFshB+h88+ZtKz3iQIK?=
 =?us-ascii?Q?u+uvfLIc8WnPvbD7hsnva/XfKLDXWFvvyJPmBPII/NWpPigabj7i9trF/My5?=
 =?us-ascii?Q?9AE+08HJyCGbbXiu0StVSL+3o8vNYtc8wqQ1Uthkmqxl189KRtcn0p+/7xsz?=
 =?us-ascii?Q?BEffsUxRvduRzz5GwyH3B5DozUt/Z2O8dGbnMqil6PHt6P+5wpOBAt5CDl1n?=
 =?us-ascii?Q?Q8Ki4LpaCnNh6JBQyAxoOvmltUkLS66PMLGAEBKF5Af9AXu4Wpbgnv6iBvmA?=
 =?us-ascii?Q?U5KLUMQ4o0zEIYAjyt5QTbWkhPbPu70W7Z0MhmEvkYRwT7NIwZSLbsefVkuJ?=
 =?us-ascii?Q?FIyZD/qLR6a8q6tmOERI5cAlORtcvcYKWh9qy9wJHxisce6kB/JIC5PaNN5O?=
 =?us-ascii?Q?CJ2EI+bvNfRJgrq89uhHo6zkMKyxU74KHGPPyH3jcwIg8T3e9PbNeOR4cYOU?=
 =?us-ascii?Q?76Xhp6Gi+u356Q+bEfYYuOWdsko1hGOp9xMoFrdT3UAqvRGeDIfRD9fRZ6vh?=
 =?us-ascii?Q?TMGC6gIvOp8Unsod2op/RXhUFe1ePw71vON8RLAys2xfOuPoQiH6StOlZRKB?=
 =?us-ascii?Q?im4ELo41bbCtfhKmCKGb4/VKVCRDE0QVZLbXes+6r4KN3NvbEuClqoYlcUSV?=
 =?us-ascii?Q?ztTnalz1Ld5uYTmpkitx12HVIovz2RdJiYk4Yo8bK7RTRKRxFKfJlFAyb7NC?=
 =?us-ascii?Q?70v1Rw9HYMDvhbKE451hkNJe9HyxbLal3/pY81aRCJwydKsEsWAMPmAuGd3U?=
 =?us-ascii?Q?KH7FVv8o9FlTqHjf2N+Z/0gWTzFr0gez0+RW8BvpXFs35A5OkzBgKQh/r+/9?=
 =?us-ascii?Q?ZrnQiqENnyaL88TQ84Ty7pfkw8K6Q0KhmPr+LMWVJ/VMVEU2gjEmpLSXC9KG?=
 =?us-ascii?Q?W+MYkaxt5Q5mIDA2CDHOb2X8Q7JoOkZfxXshpohXPI60oDP3RbiJu+t0p1Ha?=
 =?us-ascii?Q?YQK7idk+NWdGdIuTVJqDaaqFzLePMDyNa4S9hvt8XuJR39GS5llkbG6S3dRW?=
 =?us-ascii?Q?YrR6sEJ3JcVk+J7eDczrsjumsr92sb9smb/WcLYxQchxf47hng7pIVtxJzCa?=
 =?us-ascii?Q?2RASptbrGU+vkUR2Tyng54f8UsrY0LCUS/Gm4J6abvG1bjug5CqxFUo87O0J?=
 =?us-ascii?Q?YYlkg+D9rH3TyIETLjbb6CTtU82D7rcJC8RfvK3l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e118eb-bb4e-44cf-3ff2-08dac852716f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 04:16:04.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14DnI+5Se4IDmH338+lWmYlJ0pjOU38Xu31+1jtJpBE2pWSrmBgk8NMgF914GGFPskAQqOxNnxwgXOZLfOMxtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Perry,

On Thu, Nov 17, 2022 at 10:49:54AM +0800, Perry Yuan wrote:
> Introduce the `amd-pstate` driver new working mode with
> `amd-pstate=3Dpassive` added to kernel command line.

It should be `amd_pstate=3Dpassive` here to be consistent with the early
parameter and the rest of the documentation.


> If there is no passive mode enabled by user, amd-pstate driver will be
> disabled by default for now.
>=20
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 30 +++++++++------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/=
admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..06e23538f79c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -283,23 +283,19 @@ efficiency frequency management method on AMD proce=
ssors.
>  Kernel Module Options for ``amd-pstate``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -.. _shared_mem:
> -
> -``shared_mem``
> -Use a module param (shared_mem) to enable related processors manually wi=
th
> -**amd_pstate.shared_mem=3D1**.
> -Due to the performance issue on the processors with `Shared Memory Suppo=
rt
> -<perf_cap_>`_, we disable it presently and will re-enable this by defaul=
t
> -once we address performance issue with this solution.
> -
> -To check whether the current processor is using `Full MSR Support <perf_=
cap_>`_
> -or `Shared Memory Support <perf_cap_>`_ : ::
> -
> -  ray@hr-test1:~$ lscpu | grep cppc
> -  Flags:                           fpu vme de pse tsc msr pae mce cx8 ap=
ic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx =
mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cp=
uid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1=
 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy sv=
m extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wd=
t tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 c=
dp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bm=
i2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt x=
savec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clze=
ro irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save t=
sc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic =
v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overf=
low_recov succor smca fsrm
> -
> -If the CPU flags have ``cppc``, then this processor supports `Full MSR S=
upport
> -<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>=
`_.
> +Passive Mode
> +------------
> +
> +``amd_pstate=3Dpassive``
> +
> +It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the kern=
el in the command line.
> +In this mode, ``amd_pstate`` driver software specifies a desired QoS tar=
get in the CPPC
> +performance scale as a relative number. This can be expressed as percent=
age of nominal
> +performance (infrastructure max). Below the nominal sustained performanc=
e level,
> +desired performance expresses the average performance level of the proce=
ssor subject
> +to the Performance Reduction Tolerance register. Above the nominal perfo=
rmance level,
> +processor must provide at least nominal performance requested and go hig=
her if current
> +operating conditions allow.

Otherwise looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
