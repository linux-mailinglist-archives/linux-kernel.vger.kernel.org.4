Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782E5721F88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjFEHa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFEHaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:30:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3898
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU29as8cHuip0whjCxNeX0ZUXQ/uNp/COhLw9lnAF0Qr0k4aklXmfEwKLFVA3/u4xAND0ZS4gKay47/gjSyOGn0qP2IQM8MaH5Fki/qEJ6iIrILCimeFpvV698e9j4ZOzLM/JCQ+ph1naJNlyD1Wfc0rekHc9RYUgNPtkMCmjcEyJ5LNqnKEHzViTSiNLoJRZJuCWTMqSnOdZZ8P1Jbos1u9FPvF9VTpJ3bFhYVatLZL7ak5RpddDxfpgEvBOxAp3xiKv42GkiY3Bink022+Ow4kTGLVr66nEEXX1nDVk16j/vJmK6C1MaB5hV0RIKUk5rvrJsOmntEDB4l20Aa6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vb02E/YAgvKcqV4Pwyiz6Lmo3k3BIP1pe5LNCTyycw=;
 b=N0cDdXLbwFaaEZ3V4jjypkoMMMmciZ94mPhmBF0Q8dLNUEG7cAy0artu250n/Wjh5P9Nl1d6wQ+WWUN/MXactyt2bET8ogjiRMUVs89DM5ozGBFuJLMJYUitZrs4JoL5DDiGH3RSeehg+n9iYNl0BKUKLNPDg+92j2YE4r7KGhQUeT4v7/rQji3pbUaGLmAOCSx/RcmdW51GxU5SAQryr7Etz5Wt67Qqxv2BKvu8tFok3yrMvGAl2uFjndoYgDYKkrVCyWSeb0I/gEAFBg+w8iyknh31OOBxaICUqQqU8XW093uFjZBRt1jOz5iW7quGbzZQZUN5fT3qmwABbVncDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vb02E/YAgvKcqV4Pwyiz6Lmo3k3BIP1pe5LNCTyycw=;
 b=mvWgL9lC75yq7x26wp9b90o6IzekOpKOTKWCDafAM27CTdh8GN9zS7etF/2EYzDJvP3eFPv6tPo8mxxdwIwZgLGx60x/5AoVPsB0FzbBnCEzElFVgFf60RSQjfFvbdk/hJALwMM4r6qlAqC2pYhrVCC8VpYBXUDEIwgiGjHP5iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB8028.prod.exchangelabs.com (2603:10b6:510:272::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 07:30:00 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:30:00 +0000
Date:   Mon, 5 Jun 2023 00:29:55 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/arm_cspmu: Fix event attribute type
In-Reply-To: <83b65c432db89df0427c2d55e09c643264299f08.1685619571.git.robin.murphy@arm.com>
Message-ID: <cd2b7a77-aacf-363c-3ade-59646736d8db@os.amperecomputing.com>
References: <cover.1685619571.git.robin.murphy@arm.com> <83b65c432db89df0427c2d55e09c643264299f08.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:610:cc::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 4195094b-b4b2-4b25-00a5-08db6596aba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4A6LvmTzL3j/du5xmlJ+u+t+0+jYQZJ0hM1HAH1F3mJjCqqLTUjk6DWwW0xTBX5UEVuNz955DORhDOR9cZEuVwyvR5Mw8UqAnzZYV4lhP6y4QuNxeN76c1AuO5NAfLj8s8v4pSZRvMpqvdKhVX7AyZ9jDjpNd7jU4mSLZobOtdQ9wP3mubmjWpKgUQ+IWw75igux2fGt2no51ubnT9RIK1BPYgjZS2EnJl9l7tspi4LM698Xhwf88YaaumlCZQ0wfHRnCuwscNZBOvpiSOdJqmlh24Jpdk3iBe1E8ES91cNFnooj2t7Q07mJw/VMUj2kN61anlfeXLG6ouQBBosKYuJquSAmVJbSYEIe3Jt3hFwprD4t6mLapZy07E9+ucJZF1QK+YqfZRafiAfOVJ5joA8mEsn6NcujZKgc6JK+wqsUtUK4g89hiKFk5POW0mZHFGv4UAxWSof/0IhnfPk4noFeLS5zmD0FD6z3bYEa6+QDuohz/IxZqjoWsnJFJq8bBzbQ1Wm9ab2oB4G7M6pFql8vSwG2sqtqSXNnF+kGirT3LMD8Ss/Ji+D32jzEo2wd9AciUtYfW5dGmgVWg6GlpnOarDKzGOeTlK0TY5rdoKnsHTaRVWl9M1OoQ8My+iSW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(451199021)(83380400001)(2906002)(2616005)(86362001)(31696002)(38350700002)(38100700002)(6486002)(316002)(41300700001)(52116002)(6666004)(5660300002)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(31686004)(6506007)(6512007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mF1Kjabp24/MQPvpyzBtTm7GCbZ/XVZjb3oc5S5oRISQNaobc8+uPkfhqWV?=
 =?us-ascii?Q?vryW/7Grm70+eIJDEXM2iPJ5VJq5Wc0V0dNe+Orm2Zzy0tNUveYvIv4RjTKn?=
 =?us-ascii?Q?SxmkeK5wdZyu1KfCtYphB0YsPlxI8teFgdk8OZg9r7q6HXzh5HGdQDOVdC8q?=
 =?us-ascii?Q?bpuSywWtQwh4Bribn5LFq31IF3t/peuMCP53aIVo2NgUU8mXyaAteVibUeS4?=
 =?us-ascii?Q?iqIIRR/u9965V1zkZOJ8NPxiSxo+LWhsUyYtVKVCxuEs+9czzxuSz5UzTq5h?=
 =?us-ascii?Q?2GYQDxtnOabg1Izm301+AEu2HDlfk3Fys2isS8NuTfwECFSIWCj6doKqP4LP?=
 =?us-ascii?Q?kwed5LUcOr3tR3e2ztqmM19kzcVb511tnqtRqxjcWgmiMdTeLnVklsnl0hbi?=
 =?us-ascii?Q?rtIKYWs6hmvpjbkP78M4Gie9tWV9q727Dv1Wii4KemziUouLOSwv9W8gCoWV?=
 =?us-ascii?Q?lVXCUm5bxlR8SXu7XOvzzGUrymXgQyfGgyRnGUrzSiT7qwJSIHiBcgVTwiZY?=
 =?us-ascii?Q?YJSeWpxOmWyTGwIZmerCB7HiUn4NknqkicXXr5sQIlw5qjjeYqvdpObYC96I?=
 =?us-ascii?Q?yK32A5VTe4aZ516i77MwliRcUdCSNyxWK9nGeG8Fqwi4gB+Ls8C0sa9NFSYj?=
 =?us-ascii?Q?HrTXmj74pXljMgIFPfooKV6wy5ezUd5geN2alb4xpG+07K9LJHEH6tJGYeHl?=
 =?us-ascii?Q?SYOQcAluaSD4lzX8vzSCMcNn8lRnyBomtScr2nEU8JgUSVe7JRHYEB9yG+/q?=
 =?us-ascii?Q?lK5eUz1YNDbR6EGGFdWGaT/wzRcTNdZ9UUdbpNyni7uieXi687KP5DXoqn3B?=
 =?us-ascii?Q?rI2fj4ViFCp6+JQkbpRtbz0kk+UvJRjH4+w3Cus7d8ylBcaOJ5gwxDl0STct?=
 =?us-ascii?Q?lOEcdOyMrkEtVzqrZRECT+ZNvtSmFhkEdEhOQMu3zdTsxGv3+TwpJ5mNzol1?=
 =?us-ascii?Q?9TYJyOSdote1C99/wqUL26B27DPVTyUyesCr+dAb7ISETP7H0GJhAN+5rcNc?=
 =?us-ascii?Q?2GNUYTKTUpR15T7pk4hsypJpjqx3MYydwJM6R6ObvsMP7ZJ8JJETvI3dMnCk?=
 =?us-ascii?Q?IYUk3JhmBbmerG6AaJ0DQyohKBM3SLAjcgMFByod5JznafgxOQg9ZLKShZcX?=
 =?us-ascii?Q?nqJUsqwmK/kdODQ2OLwKyRhViK4z5He7kTPvQ1iJeIHGnm1C7gIDxo3t7jCc?=
 =?us-ascii?Q?42Mo5OUBSOwdUB2fIF5KQPijDAp28vUEaVJ8O20tJRiQ+Qv1i5+dIbKbyCFF?=
 =?us-ascii?Q?dv/D08kJaRNf1sH9fuEwdl5ks9ZQ48guN/wJ9UI6tBoQ3fBAk1RHd1sr/6Nx?=
 =?us-ascii?Q?c/YB2BXSMDVlugGw6cnXD1S3X4Gsnj+tJjHv7EywqrDvX/pz8SykpKQaPoMp?=
 =?us-ascii?Q?kankpS4coaUU0BUlIpLWiNshVXAsc+2ld4g1F9OirOhNYtMTM/AWCtoq5Iu7?=
 =?us-ascii?Q?3cPoq8gBMv7vuHzGJJnZQBZyRQ11uuXzLlub1hgxISAjqFrgpQAKnSxnias8?=
 =?us-ascii?Q?WIHa3gRHyD+kRj/sAy21ZvGwmrexaZhhwJ6dxoLtN58DiGLweUIoSyghaftm?=
 =?us-ascii?Q?t5fFxwZ7tuk1yk7N5rRpsvfIJFUJmHB5jC2Y+yLB/H1YOe9RxV1dgwLX9Hex?=
 =?us-ascii?Q?2mkj1QE0Mp5GWoUnAn4Mn6A=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4195094b-b4b2-4b25-00a5-08db6596aba7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:30:00.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ielXkahiUvt+IySXkhEY8Xz9w5YK+cg+G7XibCqdVrZ/t/5Hf8GhuM57kGg5NKrwKCHX3Nc+M3Rt2ph0hno/TrGmDcHUx/Ty+3iawA8ydPiM+yjVZyWceMpXkrHL/EC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2023, Robin Murphy wrote:
> ARM_CSPMU_EVENT_ATTR() defines a struct perf_pmu_events_attr, so
> arm_cspmu_sysfs_event_show() should not be interpreting it as struct
> dev_ext_attribute.
>
> Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index a3f1c410b417..72dc7a9e1ca8 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -189,10 +189,10 @@ static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
> ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> -	struct dev_ext_attribute *eattr =
> -		container_of(attr, struct dev_ext_attribute, attr);
> -	return sysfs_emit(buf, "event=0x%llx\n",
> -			  (unsigned long long)eattr->var);
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, typeof(*pmu_attr), attr);
> +	return sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
> }
> EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
>
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
