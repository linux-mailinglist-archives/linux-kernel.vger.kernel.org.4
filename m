Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E373AD24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjFVXXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjFVXXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:23:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEF13E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA34AUdFGa9Sq+eCkyP5J5VgLujsMTBhDddT5CXvmDQvWWKO7UQR2nnTTkYRuad6ChRny6mi3Pw1YvOj0gmcXjgMTHGFFzVIi5sovqh8WTKLZMWxYKUxQMJHBO0BnpMLxOuld0P6t2wQSQjJPf9hqS24WKDYAF0wY6Q5N4/Gw2PLDBAhMWE2NX/evlZjtccNxY35bip+Jo6D9y7iSpNEgfI9eiZ/LaapHbGCkHSBxTHThdWvzUFd+1/wNEGtIar4J90amZlelYc/+6aXaPCxjEtuQw8HEzL8bZxRMzuI7riHT5vp2ocoOq5SxlErkD+yao/SUm7d30EhHcseiZJ2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur6zPoK7H232ZgWLHzVY2GQO7Qt0AjKyLW9W4B9hk/w=;
 b=lzYlMuJHXKswv1TwmC6aRD2i3Z2vZTvLoiCxykl+/2rfIHg0zrrsxI+6M0BFedDMxQ99jPAcxJoS1ldfuprtyhBApGs3x/2W3H4DzNvrAfa/WsMXL8QDaDeZNEFS/YHhyFK5wMuHWzBxaSvsoOc84NLWBtnYF1o3sfabnX1LySp/cpf1cB3Cl8d+vEDw78emlEnE66+X89Xy4Rk5YZULAsJvo5ooSFDNmdLmtlEB+qlqmhH/g5SpSh+/Avt+rzGkgHPbOMJEtA9RzipjLvdbE4M2ZjZrPZ5BHDgsYh70Im0QXY2FspYKx0ocFj9hEEx2XkU8yMtZfuK0bEMF5hjHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur6zPoK7H232ZgWLHzVY2GQO7Qt0AjKyLW9W4B9hk/w=;
 b=LqY1sOYJCWnfAPdeJqhv+BqSuncOGzRWTLZQDTCp63Li2nu4uhlzx81IgK87V6AjJBwNcxZ1JRg9FKzMm3DSheUB1XreRd46KumJwcyezCOdyQoQ6GJgUD75Mv166oqfhoLlqP0PhEwPZ9W2ZGKJr3eDnXn0W8WxGfZTOxleyWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 23:23:48 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:23:48 +0000
Date:   Thu, 22 Jun 2023 16:23:44 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
 filters
In-Reply-To: <SJ0PR12MB567660F6F997C94D499A5D5AA022A@SJ0PR12MB5676.namprd12.prod.outlook.com>
Message-ID: <187ba6a0-976b-db72-42fc-a7dee688b15@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com> <20230622011141.328029-3-ilkka@os.amperecomputing.com> <20230622093338.0000420f@Huawei.com> <SJ0PR12MB567660F6F997C94D499A5D5AA022A@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f38710-5fbd-429e-ab15-08db7377bb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mdfii5W7he8gIZqI/7wL0YeCgM04VKRHmBb0MobhrnXDEgcNKCIhO7mHrhJX?=
 =?us-ascii?Q?2lfYPj84EOKSkgaKMAp70gW3gsLE9fH4B/b9/l2gZN8fjr9it4HuLGWZLLpg?=
 =?us-ascii?Q?YRUn/bXyQtNpDUyabEsYogNHU1+zJ2Ko4J+fSfO6soWVChpV2tQwWyb2auGx?=
 =?us-ascii?Q?/n0uY9LK8dV/IbJQ982T6uoyzwhM8NctXTiVxieBRbKtJwPrGpRwrnnlHZU0?=
 =?us-ascii?Q?6dSLmpbl7+ei9m1ec+Zrq+6c9Si53or69Fh3aaoXZGaOzcaTRWmI/ptTzKX0?=
 =?us-ascii?Q?fxVvVDbf/VQQQi3bqItGUGMWncjImvJn7rLF+q1M2vBIDicvHa66YVuwxrkb?=
 =?us-ascii?Q?GMJ/k6BTfWqTzLH7AA2zMR8zrZ3fR6hzwvuh0hcOZwH5xw0xuDJaX1CsO0jn?=
 =?us-ascii?Q?R7wbsKBqKHH+YQ6N9WbcnCyiXUfE5+DNM9zGzDaEzryZwJBSoTAO8Qi7F2OV?=
 =?us-ascii?Q?4Na+4I0WKt5X4dGczEFoeRHF0eX7x8QAkJkCHsAF9GkDEkUgV8YcwDi1ZNyz?=
 =?us-ascii?Q?Awdd/cqEfcvBWWrSBqpFljJv4ZIRLu43HiJlfKSsizNjUIEURCMAaT68v3Ua?=
 =?us-ascii?Q?mU4cgmwNpz8kOdZYCuET+D4ffzcJrom1VfLpO3BRzUyw/Bc2GS/g2tu8ITtg?=
 =?us-ascii?Q?rmHvWb0/VDQ1y8UHCtcOPQkDo4X6TLW29zhzAJqwm0Qm+EaVqjTlrnyyTzdE?=
 =?us-ascii?Q?sFBENYEmmr84eVN2nOAinH1/f2PjkEVbm5J51OyW4dhHWybfkiomvq2sK9DZ?=
 =?us-ascii?Q?aewkdJSfyFHceIxPJWQTzq5hpuCid8UCS+j03xXtT8W1cghmeghoVbtzYBvA?=
 =?us-ascii?Q?x0HKVZAnI2dj5qn5XH63Xc/3Fskoh7fs0D0VlD5Y3OnYB0ctTwNPpCE7VXFN?=
 =?us-ascii?Q?HHS1esRdjSWt3l7PlHhXfJZK0zdiOT8uuCihRiS2LLzklPxZO/87WicMlzXn?=
 =?us-ascii?Q?6OTykP2XyomI8W4hG0dOy4X5ng6rMROayf7FyeBaCCUXGWbiMYK/0K77abbx?=
 =?us-ascii?Q?pCpy/TQQMHRs3hXWZhYg0drxIOKFLVEj5BakIqV7i78sXMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230028)(4636009)(136003)(366004)(346002)(39850400004)(396003)(376002)(451199021)(6486002)(53546011)(478600001)(6666004)(54906003)(2616005)(83380400001)(86362001)(2906002)(66946007)(186003)(26005)(52116002)(6512007)(38350700002)(38100700002)(6506007)(4326008)(66476007)(316002)(6916009)(8676002)(8936002)(66556008)(5660300002)(41300700001)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bde8jzxAaMJKpxlpmeRxRgXFJFJfzVuBur2tTzysM7pB/TzCgxNi/bL4eH9M?=
 =?us-ascii?Q?5MJLNDBxA8M2o5L1Yvv4tHGB2yQpd0KznGlry8NHLv6up27ItnSrbfWoWW/k?=
 =?us-ascii?Q?xYr+f2O8YwGhtBsKVLbLmoEBgOn8oApacBl8EgBD7B8fb0G2FTD3OkMQX1vS?=
 =?us-ascii?Q?ki+V4STv6zTkqwh7JPxgwa7nEAhHYtZRAy9QUfEyqVwZlvL6Brk1ZCQxSEog?=
 =?us-ascii?Q?TM+WJGaTome3VvjGgf1YdPQl2ihkgwhpbj+ahEkytxCOgpfsd+EBSAKvhbbv?=
 =?us-ascii?Q?SHhCEUvNY/u72jJCKQrZjH8v6qfFdL4IfTlafYSpJphGdnnnBzD6LybUElWQ?=
 =?us-ascii?Q?rct+1UuoeLbcuF9fe35Ebj9zm3pFZ68NnceQPpVjwcG5ORAI32mQXg/cruln?=
 =?us-ascii?Q?DH62Uz9MJoh26RFDdeh00sjiHxwnZelpGtwRlBjIawS9shBDmYCYO8ThhOk3?=
 =?us-ascii?Q?EfvX9pvaE/aBviJ3edOf3s7tL1b8CFy6gs1Kg+z7B4h4+IYgHTK1YMpAgB7k?=
 =?us-ascii?Q?V7M6uNIfLWnWhpEVKlcXNy38HSY45fouLVXFnHMLJkJQOXy838JLnStscjgi?=
 =?us-ascii?Q?AVAd81GmEG1GWc00/gNq4W0Woy53WHjqdHSl0S8mO6Gqy9RjqYD08Z4t1ul3?=
 =?us-ascii?Q?bUqPBP8Pl1GEHdiNyNUC9TWQazTFDcs6dxOUsZSoPZK+qzMj7dslyu3gqjGm?=
 =?us-ascii?Q?/83myCA03i6YnG27p4jRJYniZW2BDdsy8D46yYwe5334iURTU9NQ+AOiD9X/?=
 =?us-ascii?Q?fi+1+W2schhYihRUsFGxC5+reFML3DsrAcoqElBywnYOs4XlnhKi6J0l6rhE?=
 =?us-ascii?Q?d2TNobnKtnG9+LvzQyseJs5l6iAwBXhZqTZp7ZbnkJyqjl/hlUN1CFP7yYZz?=
 =?us-ascii?Q?+k0p2bploIppFN92d8k7aarJQeQjOdPgOEfLsO77COyxbHhbQPEYHcEqN/8Q?=
 =?us-ascii?Q?YDk2Ak/EredjZFez44D+JHK/d552/xJaWzZrlZsN4x4uzzFCd0FdUAZflxOF?=
 =?us-ascii?Q?KBrr79sZaucODIqbyuOPPNaXCgAjVIRmlhUtygGnX5kxexrwT7JvByWSxXv+?=
 =?us-ascii?Q?c0/Qh4sM51y5MDFX1zLm9SpH7FmBsvZe9UBmmdGVQh+kwczZg04x2vaX33Fz?=
 =?us-ascii?Q?Inu+UlYBQHTWY3Coch/XRiJj32U3rNJ+d9XhjFJBS4JH9736ICHdyRJ3zGW4?=
 =?us-ascii?Q?IkgK2dKJ9oyC8sF5v+VazGohFE3IsNiNagRSX3hOi/ytp+ETrxTobRgGAtbm?=
 =?us-ascii?Q?SFLB5V9iZUNw35/AnJtN2564zr3Cs2b75nMAVXGCzScwjZx/sW77r9lkJbSR?=
 =?us-ascii?Q?1dmXj232TuHr2G3Tw2nJMxCis9JQKGpwH9QRXrJpypKEaUdwaXEk5vBEZiqi?=
 =?us-ascii?Q?0QuU4GyVNdg9vYpdaKo64+WCZACepq5v/yrn3NcDb/+rP6SZPqyTS8QOxqDx?=
 =?us-ascii?Q?BObN59ygQd8d1zZAk31K/yPSENz8i6EkUX2wrcyI6khlXmLVv3QiLWsLUfip?=
 =?us-ascii?Q?EvSROOgGhHeFk7Y7J0odX9DLxY+nE5HGbtDX0QVZJMt2Syi9UPan8+l9zO5M?=
 =?us-ascii?Q?D+JMy1z5f98tLDzg+Wa/oreZgT0rrn0Ty24MCLGQFcSDwUebSsrQVc7vFlqe?=
 =?us-ascii?Q?Saw2Gk9RH9zheLG8piIk8UY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f38710-5fbd-429e-ab15-08db7377bb0a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:23:48.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7uNcRym17tTb2XIBCjHvmoIfLz+eLUXXflQq/lg+Uj1HZZEND9Z9wM5cbFXFF/XTawLlR5kRh876ZHmlBUZNkOuLuYgXa2v3sxKs/B358/8WkHtuam761ilvYrQ9+0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2023, Besar Wicaksono wrote:

>> -----Original Message-----
>> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> Sent: Thursday, June 22, 2023 3:34 PM
>> To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Cc: Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
>> Besar Wicaksono <bwicaksono@nvidia.com>; Suzuki K Poulose
>> <suzuki.poulose@arm.com>; Mark Rutland <mark.rutland@arm.com>; linux-
>> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
>> filters
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, 21 Jun 2023 18:11:39 -0700
>> Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
>>
>>> Generic filters aren't used in all the platforms. Instead, the platforms
>>> may use different means to filter events. Add support for implementation
>>> specific filters.
>>
>> If the specification allows explicitly for non standard ways of controlling filters
>> it would be good to add a specification reference to this.
>>
>
> Want to point out that the spec considers PMEVTYPER and PMEVFILTR* registers as optional,
> please refer to section 2.1 in the spec. The spec also defines PMIMPDEF registers (starting
> from offset 0xD80), which is intended for implementation defined extension. My interpretation
> to this is implementer can have other methods to configure event selection and filtering, although
> maybe not clear of how much freedom is given to the implementer.

That's a good idea. I do that.

Cheers, Ilkka

>
>> Otherwise one question inline.
>>>
>>> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> ---
>>>  drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
>>>  drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> index 0f517152cb4e..fafd734c3218 100644
>>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> @@ -117,6 +117,9 @@
>>>
>>>  static unsigned long arm_cspmu_cpuhp_state;
>>>
>>> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>>> +                                 struct hw_perf_event *hwc, u32 filter);
>>> +
>>>  static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
>>>  {
>>>       return *(struct acpi_apmt_node **)dev_get_platdata(dev);
>>> @@ -426,6 +429,7 @@ static int arm_cspmu_init_impl_ops(struct
>> arm_cspmu *cspmu)
>>>       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
>>>       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
>>>       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
>>> +     CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
>>>
>>>       return 0;
>>>  }
>>> @@ -792,7 +796,7 @@ static inline void arm_cspmu_set_event(struct
>> arm_cspmu *cspmu,
>>>       writel(hwc->config, cspmu->base0 + offset);
>>>  }
>>>
>>> -static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>>> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>>>                                          struct hw_perf_event *hwc,
>>>                                          u32 filter)
>>>  {
>>> @@ -826,7 +830,7 @@ static void arm_cspmu_start(struct perf_event
>> *event, int pmu_flags)
>>>               arm_cspmu_set_cc_filter(cspmu, filter);
>>>       } else {
>>>               arm_cspmu_set_event(cspmu, hwc);
>>> -             arm_cspmu_set_ev_filter(cspmu, hwc, filter);
>>> +             cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
>>
>> Optional callback so don't you need either provide a default, or check
>> it isn't null?
>>
>
> Right, the CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter) above will fallback
> to default if ops.set_ev_filter is null.
>
> Regards,
> Besar
>
>>>       }
>>>
>>>       hwc->state = 0;
>>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h
>> b/drivers/perf/arm_cspmu/arm_cspmu.h
>>> index 83df53d1c132..d6d88c246a23 100644
>>> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
>>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
>>> @@ -101,6 +101,9 @@ struct arm_cspmu_impl_ops {
>>>       u32 (*event_type)(const struct perf_event *event);
>>>       /* Decode filter value from configs */
>>>       u32 (*event_filter)(const struct perf_event *event);
>>> +     /* Set event filter */
>>> +     void (*set_ev_filter)(struct arm_cspmu *cspmu,
>>> +                           struct hw_perf_event *hwc, u32 filter);
>>>       /* Hide/show unsupported events */
>>>       umode_t (*event_attr_is_visible)(struct kobject *kobj,
>>>                                        struct attribute *attr, int unused);
>
>
