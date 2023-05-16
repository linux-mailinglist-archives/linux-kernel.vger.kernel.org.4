Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2205704687
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjEPHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjEPHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:37:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC501737;
        Tue, 16 May 2023 00:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moc8JHWcNSlzBTiHLfTqgZ0egVcgpDFmzAzJX4lCva633XOVi30f5X3tkW9u4dyGeEQ6pp0Bb+iNnspTTFnLILd21WkZViXctiwe5VZKdEyFqVkTYBlO73mxAOsmPvRqT6yXAvoFF/z5siW3Fzi23wopNoKpDy64F1TJ16cmY5FEWTY0XTCwbxm114nyR/mO8Tm4tFvoWFdQnp3RKrUPko7A6og8XNyMCY/4gA2LLEhzCcdljlDtKzo0YXYy7k1iWCD1UW2Cpue1u93vdzfbIecFbQIVp01c8cvGfWGYCxrKk02HaIfnXPEsaF7xoQnrR3OCIbKIGY3WBQNLh6vgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoX8YDfuNaRsusXtA6dbKrs+T8M++t+ize1FNQ/O+qg=;
 b=LuAyxcO7OxuaojtBoL6ITrwqnz0aXlpQBSNuyr1tB7WqS8DfG0ZOhFSCjENZ6LBByqzfsLxmMJeNmFl/xFsP0UQ/tjgOFKdFiG/Nne0BOgUNZUizMaMTOsfVWDbSmXKBgsBJi0Xl9pM9696ouP5UXhQj/j61jwvGAkeJL1WGXpu7+fwJIn5IRtvoOKBr85x9xekoA/BZtDc8Qx2nX1wDA8bJ7Om8uzMi4ig4fZN1R833yFzo7FGZgf4LNRXLO/aMt8A01pG5qJB/N77x7Vjr9IVQlPoLngmy1l4uveqov0MvQzSPFcp3z2LaExhwb9eqmAyW0PDw2QmQMDnnHIDGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoX8YDfuNaRsusXtA6dbKrs+T8M++t+ize1FNQ/O+qg=;
 b=ONMAbLjypxcgBEyBvHvdkpbL8A43jxTBmV+7BxZan4AIW6MV2UgYi+nTglZVk9u7FncYpuQF8qj2BlREAgF0NnzLzYvV+fh/xq7OnNlV3CVW4vXJ036H8LL8CO0+V9FXd0mQHZ5bLd1KZ0QPB6l/Yo0rilZnDYz/CmFYlbuzSdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by DU2PR03MB8076.eurprd03.prod.outlook.com (2603:10a6:10:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 07:37:34 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 07:37:34 +0000
Date:   Tue, 16 May 2023 09:37:29 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Message-ID: <20230516093729.0771938c@luca64>
In-Reply-To: <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
        <20230515025716.316888-3-vineeth@bitbyteword.org>
        <20230515100616.33ba5dd9@luca64>
        <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|DU2PR03MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d2b325-2987-462d-74af-08db55e069c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mg5Ds7OFzbc0H+iK41QpDzyrYtIJTbTpj8PTHPSZcwgEpDdH3BOirqhN0Zder6gW6chpLrA295gJdoaXvBnTbOM5u/hyHR+uxnQAUiB8f/ep/EgTRpqQtoLpPgwaeFCR6+VSw1zt/t5KLLlPFK1FQjK09eygq9JaKNwFtPgzeX/l3i6iWt5zBw/nM3byBujtCb7ECKKzcJ5caNAoD2fJ4+dtorPv8Evp6T5S7ZFs6g9UN3yjjgVhOyidTTRmUuZNx1RNirZEKHRFXwYeTTWcDwkd2vhQW05Ow29vJ4MxI1CMJKdjOlRChhuhugLfrmBiAAPbHTt5EQICP+mkqDVO6MIqqojMrnRyT1HOOqK1fe/qv9Q5Hd9mPAgTwzPxq3Ye1fS8UkR9r5dQmOshy8dNm1vEDLdgfzWRwGPThhEvmsGIU27QHGte/E/AdUFwsOjkz/at5zzAzv+YZYPeG9Z6khzexOrPmbw5qWlxSrdDC2YNeGjbA9pYautBMPTUJXFDT2G3nS6b5gb3cmGORXAPLaZvKJfEzuIa/7LWtmqYbwpDAED5NUSYn+bPk8EYIjP/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(376002)(39850400004)(136003)(366004)(451199021)(86362001)(54906003)(316002)(786003)(66476007)(4326008)(6916009)(66946007)(66556008)(478600001)(36916002)(6486002)(41320700001)(33716001)(7416002)(8936002)(41300700001)(5660300002)(8676002)(2906002)(6666004)(38100700002)(6512007)(9686003)(6506007)(26005)(53546011)(186003)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmF3RGJGdXdGOGZoaU96MFRqYWtrZUlvUGYxbkVibi9mZHNUemt6elRXZXRi?=
 =?utf-8?B?TS9BazcrQU1rc1VtdzkySzNhRDJpdFIxQkJZSWFQWGVaaVFRd2ZpNGRBRGNz?=
 =?utf-8?B?K25tdy9zZmZrSU5ha0VkRXhCcGVSeEtFVUdQUzRuVGc1VE1VaU1VWkJDWFkw?=
 =?utf-8?B?Vkt1UEM1QmZSanBEK25kV0lqMEtVQjhub2pSU0trV0VMNlJxNTVuRTVXL09T?=
 =?utf-8?B?VFo1ZUs2SHBJK0ZwcWdaQ1RxKzdMV2hUUlc3STJYTzdmZWdoRGdiTlMzSXZi?=
 =?utf-8?B?V0Jscm4reDBlZjEvbVVFNkhHVkltOGtqSkV3bmE5WjVhWGhmSGJEd0hhMjdu?=
 =?utf-8?B?Vk9uSzN0TXp3bk8rYXJJZUJkdmdFK0xNeUJkbk5xU0ZWN3dXb2QvV3NDRk1T?=
 =?utf-8?B?Tmk4blg2NTI1bStFdlJlWlU5YjI2b1dLa1hPT2k0NEJ2b3R1SVlETkdXRFhL?=
 =?utf-8?B?blZBdVh0K2s3cnlRTndEbUY1MGk2eUhxVEl1dmhsbWtxeWtONmpPYU5ZdDBH?=
 =?utf-8?B?UU9JOE1wb2J6azZ1SDkvTDdTbHEwOHFhZWhZSUFFWE0xTnd6a3VVMDJ2NUJF?=
 =?utf-8?B?NEV6ajBFUU5jQVYrbXFwRDhLSUk4UnFZMVNCZWZNVGczQlUveHY4dEZjSWFR?=
 =?utf-8?B?eWN3cjFHN3BudnhiWG5OZ2tZaE9HM2M0c0xtejVZSmJWeTExQzEzdHNLYTJG?=
 =?utf-8?B?bDhKTG5RT3NvK3l0Y2w3WGpGQ251T20zc1NTTkhzYisyUVl4OVBrOWNSakMv?=
 =?utf-8?B?WUZwZzE2Qlc4SmdNaEd6WjZHeC9UV0RRK2lFRXBGUU9lZy9Sd20yMEp2eHVJ?=
 =?utf-8?B?WUlnR3UrcUVXVllnb1djWldMZ2prRUo4WkNteHpndWZPSkNma1RRU3pFd1Rv?=
 =?utf-8?B?QkdyQU5qYlUvdmNnb2pISFlHRE1acGJ5YmRkMWpvUEc5YXZKT0J4M1lJc3ln?=
 =?utf-8?B?b3ZrSHMxSk5ZaWdmWnhqZ1Bra25nSDZaT3h1ZlcrUVdWcWc3RDJZcWNlWVBv?=
 =?utf-8?B?MzUvUHA5U0pxQng0R3I1VjVHdWVzZEk5bDNlT2l0c2hxMzhMTUJwZDN2dDJV?=
 =?utf-8?B?OWVlY2dIeUxlVitmc1BPSUdqeTlIM0xhbXh0R3g4azZIWElrOVBtNllqZUt4?=
 =?utf-8?B?bGVWcmFzdXh4a05MT0toOFdkNnAwbkNseUVweDlROTlVMmd4cnkvWGJYVVZv?=
 =?utf-8?B?R3l0WFlHTkgzZ2hoOFg3NENrUHBQcy9XaVJ3THZnUHVMdUlMVm9BS0JibzMx?=
 =?utf-8?B?dy9PejdNRFgzSzMxQkdHNkhvN295Y1BxamtCaFVsNjBNZFZGRkhqV3JVdXhu?=
 =?utf-8?B?RGpoYmFMVzRQZWoySHBqejVOR25MSS9jZmY5eHVpWmNBa200NEJtRE8vckZY?=
 =?utf-8?B?c3NXS2FjOHU5NUwxQzZPazVUS1BjS1ptMW5pai9kaGs3VmZIeVpSbndwalln?=
 =?utf-8?B?REkxSVJOdFdCUHRBQytTSUJyMncvVHNhR2pZbVRaRXcyVHZSWFc2c3g1WEtV?=
 =?utf-8?B?VzB5NWd0QkdyUXVaSTdkVWx1RWxoaVJKcjdUVXVwRkU5aWo0MkpBSzdISEVU?=
 =?utf-8?B?YTk2cGQrTkRxQjhpQzVuZmlwSWFFaFN2SVpCb3F3ODYycXJGUk5MK2MzeUJJ?=
 =?utf-8?B?ejdaVTdiNWNMMGQ1ZEhIcURJN080b21sczJBM2lPZE1yWndjY2lBSkpWQUlT?=
 =?utf-8?B?RFYrdmZNYUw2NmtqTG1QK1FHY3c1aTVVb2hIa3JXYWlLQ0xxUnlBUXl3TENr?=
 =?utf-8?B?V016U3ZhQTY4STM4ZCtudVg4MW5QRng4d01UMUxMWnJmWEVrZ2NiRzR4SGRE?=
 =?utf-8?B?aGM4K0NVeDdRbmNZL2hFZm5sb2FUUUJaNnR5UUFkeXY4c09Lcm1wUU9TOHNy?=
 =?utf-8?B?M1dST1BiWEZVMDkyQ3FZM3JmcUt2clRkZWU4d3NLbm4wTExlNFo0NnJYcVRE?=
 =?utf-8?B?YWM3VlJHVnAvdERNclhwem1vQ2JmSGF5Z1ZRTkg1RFhrQklGK0o3cUlFdmFV?=
 =?utf-8?B?YllkTmhPeHZYbHEwTUpwWFZNSlhrOUJuNXpDeWc0TFRoUDl2dy9iM1krVUE2?=
 =?utf-8?B?bVRWMVNxYWRJNVFqL1B0WWs2SjZ1TUxMV2JEeWZkVDUyQXpGVnlWZWpHN05B?=
 =?utf-8?B?c0pqcEh0RStSRzgrSXVheE9OYUJaR0dxdXVCbkxUNFF0VktjN3VwSUFaY3dN?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d2b325-2987-462d-74af-08db55e069c0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:37:33.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNPCaJqVLmkIm9gJ1zrBo/cEvEZUl/8VCzzja6bC85ql/AlbenHXyomdbKvRFqc3AiGxNNIOAxsLA2zJZcnmVcXc1FOPTAKuASK47bxNij0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB8076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 21:47:03 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:

> Hi Luca,
>=20
> On Mon, May 15, 2023 at 4:06=E2=80=AFAM luca abeni
> <luca.abeni@santannapisa.it> wrote:
>=20
> >
> > this patch is giving me some headaches:
> > =20
> Sorry about that.. I was also stressing out on how to get the
> reclaiming done right for the past couple of days ;-)

Well, this math is hard... :)

> > Vineeth Pillai <vineeth@bitbyteword.org> wrote:
> > [...] =20
> > >   *   Uextra:         Extra bandwidth not reserved:
> > > - *                   =3D Umax - \Sum(u_i / #cpus in the root
> > > domain)
> > > + *                   =3D Umax - this_bw =20
> >
> > While I agree that this setting should be OK, it ends up with
> >         dq =3D -Uact / Umax * dt
> > which I remember I originally tried, and gave some issues
> > (I do not remember the details, but I think if you try N
> > identical reclaiming tasks, with N > M, the reclaimed time
> > is not distributed equally among them?)
> > =20
> I have noticed this behaviour where the reclaimed time is not equally
> distributed when we have more tasks than available processors. But it
> depended on where the task was scheduled. Within the same cpu, the
> distribution seemed to be proportional.

Yes, as far as I remember it is due to migrations. IIRC, the problem is
related to the fact that using "dq =3D -Uact / Umax * dt" a task running
on a core might end up trying to reclaim some idle time from other
cores (which is obviously not possible).
This is why m-GRUB used "1 - Uinact" instead of "Uact"

[...]
> > I need to think a little bit more about this...
> > =20
> Thanks for looking into this.. I have a basic idea why tasks with less
> bandwidth reclaim less in SMP when number of tasks is less than number
> of cpus, but do not yet have a verifiable fix for it.

I think I can now understand at least part of the problem. In my
understanding, the problem is due to using
	dq =3D -(max{u_i, (Umax - Uinact - Uextra)} / Umax) * dt

It should really be
	dq =3D -(max{u_i, (1 - Uinact - Uextra)} / Umax) * dt

(since we divide by Umax, using "Umax - ..." will lead to reclaiming up
to "Umax / Umax" =3D 1)

Did you try this equation?

I'll write more about this later... And thanks for coping with all my
comments!


				Luca
>=20
> If patches 1 and 4 looks good to you, we shall drop 2 and 3 and fix
> the SMP issue with varying bandwidth separately.. Patch 4 would
> differ a bit when I remove 2 and 3 so as to use the formula:
>  "dq =3D -(max{u, (Umax_reclaim - Uinact - Uextra)} / Umax_reclaim) dt"
>=20
> Thanks for your patience with all these brainstorming:-)
>=20
> Thanks,
> Vineeth

