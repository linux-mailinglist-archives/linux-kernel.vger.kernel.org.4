Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8B71FAC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjFBHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjFBHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:13:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2220.outbound.protection.outlook.com [52.100.165.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6325C0;
        Fri,  2 Jun 2023 00:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if9SLZ3Yv2DYHOeeoAr6WftJ8I9UO5TpAagKbCQo7XHIJL3L+rhmVUd3Aa6ow06LZ1n9XQ/zLs52aRqWf+yb9mHOA5m8cVVbagZY14HWLtI5f+pdKubAgE82cOab+f4V4ZDqOPDq1p0MNQno7lqKqFaMbgNDqilqC9Ktf0eXrxVAfmoh11ETeaLhb/UYQ1HtxG8BqyZWKDyLRERmbC0umujD6J/mjibLYPenvaEKA+Ur0GziHDIY0JO42ZqJD20HEMAShsj/Wq8I6a0Zzg2+MXYHaryj422wOiZLuLTdorlDXtz3Vdd+6hr92yvEiJJe1NHFEUSGawJ7FziQbXOeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkX1vQ/NnBDVx8rvbwiLg+MizYSoQFIVEE0RQnsbLTk=;
 b=H43xU8UzW8UnBO3pmRqBdy91rarzZe+lW888uLoEB8TRf7ipjiRwaoPzNwHbO3ndoohtd/s7kZyt21d1stQOFTYC+G9Hqh0smpnGSN1D81S/R042KIa/Yqe90J2W4iV6AFINsxn7DBI0R2KYK4Lg6xf+vDKXQKo6CtPN7Morhye3xw8Yo2WJKmQ4Ig9AthUZcLxcuLk8NYXYtO7ab0Xd8Z5BDp/m3M4zsHzuTrrQadxifoP7sIudtmhDOPVI+WqN7E0jFGbuJ/5vNOcj4kKQfV+2kJ9Gg9lEf6qdg8qH7YiOe2q2n0bEkAOaYT7gmF/lRzqyuOxxvMo1x8rOQWQ+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkX1vQ/NnBDVx8rvbwiLg+MizYSoQFIVEE0RQnsbLTk=;
 b=HJruextU0O6kLTpVE0Ve+IcKzr+iHSTxuS/dJl5yQWhRhACr3UNLGaDldmNFtfXLZ/4le3kSer9BfUo6bIrjt37vgiODmc5z0n85gjjQuQCWPDRjj6Iyu/6a2/eLGxGoUyMphvYHFm0Djxxu7byDDnEWhet60hXpuQQsQZjBEi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB8541.prod.exchangelabs.com (2603:10b6:510:2ee::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Fri, 2 Jun 2023 07:13:46 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 07:13:46 +0000
Date:   Fri, 2 Jun 2023 00:13:36 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for
 Ampere SoC PMU
In-Reply-To: <e15f1773-e843-3bc3-f265-65524ea3385a@arm.com>
Message-ID: <607a395b-b01f-33e1-c67d-d4bd4d92c3d@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com> <20230601030144.3458136-6-ilkka@os.amperecomputing.com> <e15f1773-e843-3bc3-f265-65524ea3385a@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: a919e249-dc2a-47b6-57f9-08db6338e80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tLy0tKv0UejyuO4RksAwDYN6qLXhm/SsWfvu0jBiKyMa8Puy5DctIowtLUe?=
 =?us-ascii?Q?znYiZTCXU0HDPokI4Ig7HA/z7HBHSW4hxMCQibI1boj4eh89t/8HcbIgnwzJ?=
 =?us-ascii?Q?fzQwD8ME9vaVcqDRayTbZqyGmfMy/9kRWpABDLV2xVW4m5Ny4LprC9EpGSIm?=
 =?us-ascii?Q?52sgmIRwtIeKFFmdyYmNRVVRpmZlHCfc9tH3JSYaFyo1/xOQ43sltfPap6ae?=
 =?us-ascii?Q?ie0brRDnn8Te0A48bIYh5H6kRHdEHqv6Z0M6n4B9v72iU6zik1OHj92Y7DCS?=
 =?us-ascii?Q?WMGY6Wg++6D4pOEwOvLg00sx/HaJnOH8kh1vBPg2+zsKacbfDyIXwkdYdASo?=
 =?us-ascii?Q?A5HCfeIK/SDS8pKAGQ2bZtU8FqnwIwl784dn3sT3cIin3s1Q/FN0A9DRc1OM?=
 =?us-ascii?Q?YYAwolYiTt0JYUNfRK67nI1OYBclrhaxSxFFFdf8i1hzi1WIJJbIvCdD7pC1?=
 =?us-ascii?Q?fsSebN6MqrfxburcJbik6sNl2dF4vtYv2TEz3HwUlpQRjCfYIORP8MYEBk9y?=
 =?us-ascii?Q?XI/InWQGNekAFztqyIkcHaYPpr16WcoyK3k1/t8a5ZbYU4EOxLtUJgReGWow?=
 =?us-ascii?Q?og9MFdwLvSWhJHSzGy2mjsoRh12Ijvz9AWFpuqeoesT5egEuNOe2Cbdn3DzQ?=
 =?us-ascii?Q?Xt7BFV1bRln1fopCaSXxC9iwlK3QFwwTJuEygUcdv+NvopG5mbE/EaZJZx3K?=
 =?us-ascii?Q?hVYJ357h9XdSCAI5x1RzTEV8hX67xuQ80VU6JagqhNlKZtTXgfybhejN0Fai?=
 =?us-ascii?Q?7amEYIrLyjWc28Wi4UdPAVpDmXTaJgrEWEwi10hlEqsP6RgqlGwt5gDXrYVf?=
 =?us-ascii?Q?k88bDj0I63sYkZvR80gnXexV95qTfENobIUh3OxeTYjJKRJTBe7VI6qlqDMt?=
 =?us-ascii?Q?IbCb4tAn8J3wN4FRfSwpRt7ajE5SSct0Y32P5FMFmPWCcBZGN92JwfcYReSn?=
 =?us-ascii?Q?c/VFR6da8aLDls2sZbPLu6l5Rf9FDr3I08pwLZyrABbjRsBylzhJSzGOtBW9?=
 =?us-ascii?Q?yWPYWMCKgj1mWi/GMD46wdSBf9C8UbV+tj1L1r5RR1FwMu4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230028)(4636009)(136003)(366004)(376002)(39850400004)(346002)(396003)(451199021)(38350700002)(38100700002)(5660300002)(8936002)(8676002)(6486002)(54906003)(41300700001)(478600001)(52116002)(6666004)(316002)(66946007)(66556008)(2906002)(186003)(6916009)(4326008)(66476007)(86362001)(2616005)(6506007)(53546011)(83380400001)(26005)(6512007)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQ0SCmUQDV4ewLySjHRbn6Uws4V3CFMDLthcF+WzRjAybsYh7ssg6vMOR6Pm?=
 =?us-ascii?Q?dAw27mkPT79O45tdFurDsVyh7NOy53hnDc8TXjNYD37ARzC8dWdQvG95aaUJ?=
 =?us-ascii?Q?XKEgTfdQQ60TC9Ti5O0oBv3eunYLeGUtdb0s56j29hb3N6csn5wdFfoyZdpo?=
 =?us-ascii?Q?0d2TPS7SO5XIJdL+bmvCZdNDZRMco5Nlit5Fshr9UUpM5SNRIlHxmXl3xXMV?=
 =?us-ascii?Q?psKspeTNn4mRAgY9vRdQ54IQe0z0JQeptGo9/7uTCJYD6KeAWILxzRgLfoO1?=
 =?us-ascii?Q?fs/gXPqvnen1EWnmt3IxTT+hHBD4FHd/n15/DEBDR0qdJnF0TJ3gELvF4BS2?=
 =?us-ascii?Q?JGWeIXbXdLrb0rcvJmeSHhgUQPBZPH9X/Ge8wmzC+FoVfN7ZQocu2kRKwc2M?=
 =?us-ascii?Q?0mIoYnkdWzCHKCrGySvo7TCzaJhejtb6ThwrwnBZ/ONl7WXSH2UslfcKUtsx?=
 =?us-ascii?Q?SWr9l4A7w/MELWCGQLPTbp+nfZYzkuQ3xkW9F+MQr4C6SSJSOFP9Ks+1OOem?=
 =?us-ascii?Q?E+Z7kSTMjuTn344f5GWcT/yfwPf00gdX5i/Q0e7v96F7LLrmqVikPueijHPH?=
 =?us-ascii?Q?ag5EdszngEu//+Qun5ViMAbCRdW5kc/werHWTJU9lgpiqx3//4hnY9RV88E4?=
 =?us-ascii?Q?0UUhLEvT88ctsWsTXHWfw2QNhaNc7j6bKSX2GuEqPqGfMIB8mF0SzEInDF/D?=
 =?us-ascii?Q?UWduRIOzME5xspH3U+Ec6DvdOYfDrVP+TM/bcVCHc8/Vk+G0OilbK+nT0f33?=
 =?us-ascii?Q?GZf0mG6a6Te8NiHVKdZtV8MNneVR5tlMbTlQMGavm3pidRIlcz7YQ34Z21AC?=
 =?us-ascii?Q?NHwMs7I/mPeRodybvbjk7zMJgAkc3oA7D1FyMILdqNCSFo1IBFDEMD3jeKQ6?=
 =?us-ascii?Q?XzkGyjQ+Cw3iVzvLCFcRJb6b/me3OyyUYMBtRvqDW2N3wr0kisOP/Q0fseXR?=
 =?us-ascii?Q?B4sbS+C7k9YXxXZhNIUC7uI1KHCoo5OK2NX7bHK7IbwZvYrROWwQ8v+6yUMV?=
 =?us-ascii?Q?RKtrP1a1M/SGpj4GVNYLE5eNeX39y3A508Rc+xLf+IzCO24wjYfWCY1RzoJe?=
 =?us-ascii?Q?8n2GzwnEA/bxzW4coXgoJFr3qxTPO0xQ5ePBLzuW4rSNAmMQ2+fBgusL+o0+?=
 =?us-ascii?Q?APU6npfzp47xLL0zAhK5ZkYS9JEuELe0RxiQfTh1S9tW7LUd+qsZigmog0wH?=
 =?us-ascii?Q?ZIKBxqgXKjHOAv8jQXAtEEO22pbSn7d8elYwsmSciTMHo8w0HpLxojkjuRUM?=
 =?us-ascii?Q?Admegmq4iOFLAJ7zSGWhafTfhZOWLFXjAGdEsZjLT1PbIRBNkrodox/ucTl2?=
 =?us-ascii?Q?6wnXzdbDuXinM/iActPRn+fd0oQF8VCKI3ji+9fNYl4UmMKi3zoP0aR1XVy0?=
 =?us-ascii?Q?zY8rmjMeUpdKDerSK3yQzSIb5C+6lCe4NhmpVOnZ/108KlyczX/tq/YzKgVK?=
 =?us-ascii?Q?LCxi2gRu7xY1oxU+BmPvgiyfM0u3PZ7yuZG/QVWTc1WUApv3k91h53+l9Rn+?=
 =?us-ascii?Q?SN5NTeKCgoxlL62iGfmtcnYBvQAefNUh2CBHyZh3oyH8YT3B3HKr5Yu0vw8V?=
 =?us-ascii?Q?dN+2fgAxJgmAjyWXKq6Pbs/DJZdJY4RgziYEOJb59dgzJfv/nHe6xaufy3uy?=
 =?us-ascii?Q?FEvsbZKx6a4rlHp5tVjSXz0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a919e249-dc2a-47b6-57f9-08db6338e80a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 07:13:46.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNyv3E1qqScE19wi6ZptzW1ObSxfgGMBgJ3S3plJckpa1r4rDgoer8JXiIZ5JQ/eMHlZwRRGP+RDQYrepxni3RSeHMNhsIM84EXemdqUZUu9AchwfD25yjEtKp2xdcwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8541
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

On Thu, 1 Jun 2023, Robin Murphy wrote:
> On 2023-06-01 04:01, Ilkka Koskinen wrote:
> [...]
>> +static bool ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
>> +					struct perf_event *new)
>> +{
>> +	struct perf_event *curr;
>> +	unsigned int idx;
>> +	u32 threshold = 0, rank = 0, bank = 0;
>> +
>> +	/* We compare the global filter settings to existing events */
>> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
>> +			     cspmu->cycle_counter_logical_idx);
>> +
>> +	/* This is the first event */
>> +	if (idx == cspmu->cycle_counter_logical_idx)
>> +		return true;
>> +
>> +	curr = cspmu->hw_events.events[idx];
>> +
>> +	if (get_filter_enable(new)) {
>> +		threshold	= get_threshold(new);
>> +		rank		= get_rank(new);
>> +		bank		= get_bank(new);
>> +	}
>> +
>> +	if (get_filter_enable(new) != get_filter_enable(curr) ||
>
> Is there any useful purpose in allowing the user to specify nonzero rank, 
> bank or threshold values with filter_enable=0? Assuming not, then between 
> this and ampere_cspmu_set_ev_filter() it appears that you don't need 
> filter_enable at all.

Not really. I dropped filter_enable at one point but restored it later to 
match the smmuv3 pmu driver. I totally agree, it's unnecessary and it's 
better to remove it completely.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>> +	    get_threshold(curr) != threshold ||
>> +	    get_rank(curr) != rank ||
>> +	    get_bank(curr) != bank)
>> +		return false;
>> +
>> +	return true;
>> +}
>
