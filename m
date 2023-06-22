Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E2739E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFVKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:14:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79AADD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XigzDwMxLpDkTYTmsixjUOG5GQwwEIy4HMF3ZuAMi5df/wPsWiwMf4MBxNKO0GkY6C5KPXAaiHjSZa2u2KRvcwuI0x0MLU9qI5S5stRq81ol0qKfXOS4uImOYnsOq1TEXGTMZWkP1Iqi0QPwLr74qi190YMBUL4M+MGLZ8egjh65bkVyDYqTSSA7YwGUthszRlx9XZUk6i1H7GO7hpuMJMN55b7RciPpn/aKVH3DkIX/1temakLSEebOo54foeQ+b7Jvl17hSQPDoazgGjyjbZ858pIzd1I1n/At8pJh8QfVrkaMza+sAP4PQVz2pYNViYBbV2uGY0TcO23IqgT8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1oLVQYpgbj3pb3qTwlWptt1OhdXzUJQ63F70kQs7f4=;
 b=QoESEE1JfYDlllHJ96+/6U0l/NlPggUplMcSnHFQ3I+iNvgzHeUdC7B9QA35aH2PjQCwCiEwXT91u/Q1PJLcB1rZELBLlw/1K6Vc5aWhX9gKCS8kgmpphmNgRUWlzqby85A51iSJtPvJhW+DvYnDKDcqUxYA5SK0gnDZDMVGHitk7KpF8bjQ5Cyq3uLzTri/g2IEuKK4V51XRWFCaQO6dwNv84j0dyiS6sTttHkWUZ8jquorpkuLSUL8DabqSIusj7+u5K/H4uR0mUrRPQBZGuTzKYIEcQQXPxmaXOgke0crg4RgDZDJbeil92U0ueUTkjXasWgaEpu+bQ6huL21oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1oLVQYpgbj3pb3qTwlWptt1OhdXzUJQ63F70kQs7f4=;
 b=YvwhAmXUgknrHqsxLR3XDorUHpiqkEJwnBG1E4Lc22WyENl9bYkc1ZOCWWVNKFMyr91QhKQouXGgTYTQ35HdS+d2vKQu3CVZL7W5z+LJ/q+pdjeflGkk1t+2vfynrWj7zhhmeWaY889oKyB/H2jNbXrka3iLKt0Wgi28dUOqRFZQAnyFPEANrLjG4UeLLLWt3jndoq+Hsh0wuHNss51/yWE8a107JULWhwUJ9Gaiw8zhDZ5hasIi5QS8KDcl+Sz1mg50MPRzlNmjPe0EahlxCIFvZbZq7vcPSIa7bjzgfNQe/v1sNN1lH9V8DOro6ba4zyQuCiVqgPFOzTY9Vur3iA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:14:24 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd%6]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 10:14:24 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
 filters
Thread-Topic: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
 filters
Thread-Index: AQHZpKaisx1os2XUdkKocQH6PSxFDK+Wfy4AgAAUgEA=
Date:   Thu, 22 Jun 2023 10:14:24 +0000
Message-ID: <SJ0PR12MB567660F6F997C94D499A5D5AA022A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
        <20230622011141.328029-3-ilkka@os.amperecomputing.com>
 <20230622093338.0000420f@Huawei.com>
In-Reply-To: <20230622093338.0000420f@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|SN7PR12MB7451:EE_
x-ms-office365-filtering-correlation-id: a15b4187-44bb-41ec-2e6c-08db7309742f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VI3qVSS7Hr9QW8Bj4OYM9VFhG6MQxxRcX+jlAGVTUEoapBQ+gmjZo77s7KYVJiuUIiJ4nIIogVgphm2EPV+/VbVpEhsk38i/nGHuCaPgSNJarsaw1LH4anQPR32sX3MGNAZ3hsW/q5BVAJOgwebIonfri6da84p8JQU10LaluPDDVMd3BqyffwKSFHvltD83YHzuq2KDmfajUBCgxPq7cxpj1MDaFilyiCrJfQy228OFP3vTzAOq6mbzjettsOeb0h0Mn6S9D/kp+IrAea/ph4ME7UD7/wQpoIk1k0qi/kGPQnzEpcTN88N6pyBmd3I6Zws7zi04k8kgRyJR8HYkYlv4R8He3RMFaDAm9psV30PNYHCeyB9t5Se/Ddxl6cttQ1zRZoRrWaDd5mkBiOs2NAjzkNlgJvGP70PgMgN1PkbGm7gp1MYMWB+pI5ThcozmDqzUC9sho8GuNyE2DJlcPtClzYzKti1lHVh/RahjiiLvAiUGOI5xo11YBr3iemw/4v6RoGqGqtUdDVm484fOXLJcZOdJxbwYlEVy9I/Fmm9yDZEUOVyAjT+q9R5pa0Ahj1/D0rYm3UAkBt4lYEfnpB+61buU/gwuFgYWpgxPsi9msPjegJ9H+oxdVMJyV/yl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(52536014)(5660300002)(8936002)(8676002)(122000001)(38100700002)(2906002)(38070700005)(55016003)(478600001)(186003)(7696005)(71200400001)(110136005)(54906003)(86362001)(33656002)(53546011)(26005)(66476007)(9686003)(6506007)(64756008)(66446008)(66946007)(66556008)(83380400001)(76116006)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VWIzBkrsWJhtl/BaZYkUiFeP5im6S7nuRzfo6qrIKPdogvnz4QFwemNxIuPf?=
 =?us-ascii?Q?tesBsWeZA6uDEOb+fSqOLk+4r+D0VSzgnnYxTpW7rVt8Dv5oCN/qBei9OW7P?=
 =?us-ascii?Q?/Ir9qW2+hI1hURD/tYHFvqqYL1OHBvEY6jOpThPajLrxxyPtVzYGM5mBEEU8?=
 =?us-ascii?Q?TWWrrKBQDOeC7xooe2t/GscS3jr41p1qWnmTU0KzF8uWTRlbxPb6XAEX20nX?=
 =?us-ascii?Q?rKf4M3UUtcytRdqiJLWqEQUiRtaGiIfxPLUn6RqEwdE4n52bI0Ge4lY4OKa2?=
 =?us-ascii?Q?Fe5NQHLmizlqU/EZT5ZXq9AAYo9e5eTUEbpdW7ichwGv/px3G9IUKRPMBN8W?=
 =?us-ascii?Q?VLw9+UqNr6LXpvisC820Dy1VEy2cj16x9ipQIhrNYizFyVVVWcdnJvzl3acw?=
 =?us-ascii?Q?Cy9EXWdGjHn19UgyKwMFwUmBCZSQEST47VGnnkJbrejnTU6ZdSGwP2yBP5B+?=
 =?us-ascii?Q?KecDHEPjIZk6d1A+WJXu+Ijlq14qWOuqSKwSnvbkw47XI4kX829sxXotOogV?=
 =?us-ascii?Q?6ybURmI2rsVrqaBPCBJfhUBkwkojzjRuc/iDrsV4pEufvYI7IB+O9Q4TtCsP?=
 =?us-ascii?Q?f1qM6NhprYtZz4LNDyALVVjyDWpndkGOiVmVu39n0mp+VqosWrNpzTpwlmOd?=
 =?us-ascii?Q?YQHRtq9snutsnqdaiMesvkkoY0W959X1aKp5QAxEZIFWWvNnyA6QzfKzHvQu?=
 =?us-ascii?Q?42Fl3XE7hhrOCfqHlSht1uUuAX790jT/mWPTKPZAzHcARNvBm40Kg2lCk9K1?=
 =?us-ascii?Q?jXb6+mZNycWTC2dh9rYssW1a18gPrAOUfNLzXJ2dVjhdQzJ3qMI0lcWjyehC?=
 =?us-ascii?Q?/Yugnnl8dvmCMGHE+B349VrWEaCtXbuw6irVj1aHTsBrAoDtpeadjRIj6tSq?=
 =?us-ascii?Q?0sYEWS9LZSV4CMJ+fkTC+4O+LvtSfDwnn3jKN7SW26Zq3yDCyjPfoOA8dn2l?=
 =?us-ascii?Q?HUqmeVusVEJDWjWkHlnRtifYs3FRRS/swq+QYASX+02Z+6U1T5oSgrVCMXeN?=
 =?us-ascii?Q?x6PZMRcitAnAkCh2q6J3JH/MRhPxkyXvUDenUvRggceOfYvc7zGu/86eqSsU?=
 =?us-ascii?Q?PzHjONHW+nzPgIIWUbEvXStuiUC9Dnvjio2myQpzVvSPY3C8gB+MzoN+MkIE?=
 =?us-ascii?Q?ed/LhKiIyiqxKELiW5ecrjIj3gtNaXOWjdcAtBrtOqjLkVfK77aONelKDaJ5?=
 =?us-ascii?Q?jiDqqGcuVq/oLOZuO5tnUboah69huBquvI6X5Q76GF07krHksI+IiYy+lMfe?=
 =?us-ascii?Q?zMRtKedSMG8syPFwIevM5cL7Udz154ho4Z/a42/EqPzAPhP5KZEcv7cXhDDs?=
 =?us-ascii?Q?wB7Lr0cSGF1rDZ23G14AUGnzwRwew9mfzzKl0IYBdXPIlqs4eZbzt3BYO2sh?=
 =?us-ascii?Q?jrpa0pVxKDetiW861KWYlq7n9cz3ls7g8ZFoTXuxQc31QklQYxOJDiRCecyP?=
 =?us-ascii?Q?M60jtQMcAXmmY8rCnT19H2wGpSRbx2XLWvYGUNDP+65OSG0c9CFGMvadUWZt?=
 =?us-ascii?Q?/+BIGwvYZfcbH8YKYhSZ5jz5feZQ+sR9M5jkHXqSif6fHDDx7QYvmCw0sJLI?=
 =?us-ascii?Q?hIIsJqEoSo/wby0kJ/4PAd+hEA/U4D7E0YFWg2Ub?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b4187-44bb-41ec-2e6c-08db7309742f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 10:14:24.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtrtHcjlaX3zZutXCHRvcvbr7W0AjSA/UcNaCbhnBA8rZjBVdhvLOXkzqXl4XDM3R7DQdyl0wxpgXsYxkJc/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, June 22, 2023 3:34 PM
> To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Cc: Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> Besar Wicaksono <bwicaksono@nvidia.com>; Suzuki K Poulose
> <suzuki.poulose@arm.com>; Mark Rutland <mark.rutland@arm.com>; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
> filters
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 21 Jun 2023 18:11:39 -0700
> Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
>=20
> > Generic filters aren't used in all the platforms. Instead, the platform=
s
> > may use different means to filter events. Add support for implementatio=
n
> > specific filters.
>=20
> If the specification allows explicitly for non standard ways of controlli=
ng filters
> it would be good to add a specification reference to this.
>=20

Want to point out that the spec considers PMEVTYPER and PMEVFILTR* register=
s as optional,
please refer to section 2.1 in the spec. The spec also defines PMIMPDEF reg=
isters (starting
from offset 0xD80), which is intended for implementation defined extension.=
 My interpretation
to this is implementer can have other methods to configure event selection =
and filtering, although
maybe not clear of how much freedom is given to the implementer.=20

> Otherwise one question inline.
> >
> > Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > ---
> >  drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
> >  drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> > index 0f517152cb4e..fafd734c3218 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> > @@ -117,6 +117,9 @@
> >
> >  static unsigned long arm_cspmu_cpuhp_state;
> >
> > +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> > +                                 struct hw_perf_event *hwc, u32 filter=
);
> > +
> >  static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> >  {
> >       return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> > @@ -426,6 +429,7 @@ static int arm_cspmu_init_impl_ops(struct
> arm_cspmu *cspmu)
> >       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
> >       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
> >       CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
> > +     CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
> >
> >       return 0;
> >  }
> > @@ -792,7 +796,7 @@ static inline void arm_cspmu_set_event(struct
> arm_cspmu *cspmu,
> >       writel(hwc->config, cspmu->base0 + offset);
> >  }
> >
> > -static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> > +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> >                                          struct hw_perf_event *hwc,
> >                                          u32 filter)
> >  {
> > @@ -826,7 +830,7 @@ static void arm_cspmu_start(struct perf_event
> *event, int pmu_flags)
> >               arm_cspmu_set_cc_filter(cspmu, filter);
> >       } else {
> >               arm_cspmu_set_event(cspmu, hwc);
> > -             arm_cspmu_set_ev_filter(cspmu, hwc, filter);
> > +             cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
>=20
> Optional callback so don't you need either provide a default, or check
> it isn't null?
>=20

Right, the CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter) above will fallb=
ack
to default if ops.set_ev_filter is null.

Regards,
Besar

> >       }
> >
> >       hwc->state =3D 0;
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h
> b/drivers/perf/arm_cspmu/arm_cspmu.h
> > index 83df53d1c132..d6d88c246a23 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> > @@ -101,6 +101,9 @@ struct arm_cspmu_impl_ops {
> >       u32 (*event_type)(const struct perf_event *event);
> >       /* Decode filter value from configs */
> >       u32 (*event_filter)(const struct perf_event *event);
> > +     /* Set event filter */
> > +     void (*set_ev_filter)(struct arm_cspmu *cspmu,
> > +                           struct hw_perf_event *hwc, u32 filter);
> >       /* Hide/show unsupported events */
> >       umode_t (*event_attr_is_visible)(struct kobject *kobj,
> >                                        struct attribute *attr, int unus=
ed);

