Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C45F238E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJBOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:23:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CD193D4;
        Sun,  2 Oct 2022 07:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At+GXKuWANQG0UBGKFuWKeY5MA66FsIapbSy/UnQUDdIbL16pk69XLv/KQglb/fKhSDqEr54GLsV60drgtbtLPLbUBdWZCG+/mdf84eJCRcfwEEKk1qGh1C04sGTCuc5URMvaa/3/RLSJMphV5ejsVQPMxuFQuE6sWTla7z85p4fa6Vtr8hPKCZOZUBlGO1vv12fI9hwQHOww7cmWLyh9sBREWPo06todQVtj8KegFcdN1ZZJkcZUrXPRQ4rFsQfrRHc+hlUZiZUjjjKQyBfSCO369ut0LLFjPcmJp34eqZl+8n1HDFsNJBxMJY1CtNdwrgBY/YoDofnOOcvuY0eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0o1tP8AXrrWtWVjgPhTcLKBEZzrAsbA/tQrpjlS30U=;
 b=N3T8Z+pZLFfQi/RsOVmXGEKcz0eXlOb+J8o8Shi86nt7SfDIj3kEyvbMRnV/APwHcR88mL0G+yoS64nafP8TE2mCLqi8ebKq/CF6Lr+SUiPjozM+oh5TCXseefR1w9NtK1nJXTy3gEFAh1OuW8/K46V3ngbIDWMHfVIqVftbtibtdwXgywaubmiJ4Wg4CXLrMVLJW1pV/NX94KUBbX6iaA7DpjCcia3YUQa0C3zQaGSd7lazxL8GNP+FSOCj/eYV2yzHdbWklcGcxbfZjtXJLb1n6nFTuyHay1sEa/neHN6NTuvGRjlMguNN1fL7iLMdo6FnUpvuyu+dlH4WnPeXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0o1tP8AXrrWtWVjgPhTcLKBEZzrAsbA/tQrpjlS30U=;
 b=mPNnSxxxCT+uLWD8jm1p2gmL9aE3scqwEq58hl3X4sDdc3qxm9X2/85IensNfevtEjbKzztmW0V5X+49O+Wfy/pVTxraQSiQR7fkvUNBmhQhQu2D9d5iI9HPMgjFfWFp/butg7C3wL2tC5ICFqeX9OPkzL1YNfhCJk4t5B8fDp+DaC1FGa6zVSol9K1m3BxdPytI/nStlKWdz2FYY7fV0yeXJ8iVWmAm4EKNjR6owK8AdA1IEiEI6PMDKgWkR2CQOe7psxC70k5/ZiXgbNN1u0UFCD9UanDWq1cnCv2KPlW1n7JJ6WqwDKrA/OhRMpAb4poPg5aft3ALEIVXEIjp2w==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 2 Oct
 2022 14:23:43 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec%4]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:23:43 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prathamesh Shete <pshete@nvidia.com>
Subject: RE: [PATCH] soc/tegra: pmc: Process wake events during resume
Thread-Topic: [PATCH] soc/tegra: pmc: Process wake events during resume
Thread-Index: AQHYx/Pl+uAAGsxCqk+vOtnoSYWsc63fDJgAgBw4o0A=
Date:   Sun, 2 Oct 2022 14:23:42 +0000
Message-ID: <DM6PR12MB3164AA4BB761E2B48D9838CCB5589@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220914043831.654836-1-petlozup@nvidia.com>
 <YyHydhlIP4FcP7zj@orome>
In-Reply-To: <YyHydhlIP4FcP7zj@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3164:EE_|BL1PR12MB5921:EE_
x-ms-office365-filtering-correlation-id: 28e7b547-1bee-4984-b6f9-08daa481b587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ytNQ7+tqUpsWf6aWJRNdq6Oyp/XSwWo6UwP8kb1CcWg8/wTinCYmMj5mgxqAIc347qLjL7Aid2z6lJhIA6fakjJ5SM5PxEOBdJB1RiqUEmU95YyoUm6vIThnIAk6eMwIuApHhI/rhukWNevBMvEq+dSEp989astegaRUMkR8ooXJj9lm73E33GOKEkNoy38Ve7RgcV4lmZFOb92BysqvxPdflj8kD+ijMa6a9nGzIuvEKpNEVCJK9XVPjdOJBPVB07tkQByClLT9JoqEBFOaRvTYTuK5Hr7ZSySkNskqo/j8k42UsYWFPF9yAbUbLaPAU6MfYSWJLQ7+hBHlIiFZDYlBpjEzfwz7n/zBG9AVTveLtIyZqn3+jSQK+jglEJYKWCe7yLqgSl7XsFRN+sE6q0XUSlT2NSJKZBqFp1uuafJWiSmS6Vck0MmDb1d+EQy4sq9BSJA+kD/N5AygLKdIK6mS0ooJq1/PCB8Jr1sjr7vpEsZRcnMXSWPZEpKiUqh2qKaJ16IqIGdmPIukExKGUX+IkkcMuwXl8B1Ko7cai1K6g1ad4AOJR72eeQPUg+KyLN4gYdNGT/xRz3Gp1MhJQBpqidd3KIn9lJKRVDUMrxA/Dk3GUvUYVyRYTmDqA58rZPCodT+nTjoEK0FjfEUTRhQoe5Qx7jRt+NQiBJb1NgcjFEEGZVp0fVWAd8hiM5e7KKNKYVQwaRzabPecVo8P8LCAWaimwQHVY/eni4MMT3YF8BWk4uzhVJDIhLh34H93dw22YrxXlW1Ce+/DgEJF2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(5660300002)(107886003)(52536014)(41300700001)(6506007)(7696005)(8936002)(9686003)(26005)(55016003)(38070700005)(122000001)(38100700002)(33656002)(186003)(2906002)(83380400001)(6916009)(54906003)(316002)(71200400001)(478600001)(8676002)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ovB6yfydGksvzHp7Aj2udFOQjoqFmWcCV5zBVT7P0rjcw0G+4Mz4P7wBPCu3?=
 =?us-ascii?Q?qqxBYmEqc3sZF6xVEqLuSHAFmQyrhgPe0bNoJIqZp5+ptTiUDUfzZ/zqO7wP?=
 =?us-ascii?Q?gALL28hOq8QTlUtbUgNCLoVLE9KlzhSqWWaTHvI0JKaOMSqW5W+/1xCwzMLs?=
 =?us-ascii?Q?msE4fSpw0+a2HKE/bax/KHB8yAn9WZo1OHyPLUIK4HiGhDlzvXF3m8H+BL+p?=
 =?us-ascii?Q?Q30CGLG8yJst9kua3NMnyoXOI3YF8t5Q6BhCH73D/cTe1Se0uZuMLn038LOO?=
 =?us-ascii?Q?hWhZrEcWbByaAnwclOvitUfGGK4Qu8eCcrwOeAmwYeIyDt7TulCZiQQPQZOS?=
 =?us-ascii?Q?ZKnvc0yqCtxjh6+iJ40IY5eVmsmoOBsfBXTEa0Stf8TENZo7h06dTMBYtGyU?=
 =?us-ascii?Q?kDYw36sPi2KsKPz+dGWCyNmitDCN782RpsHTyGDCyUmxXzD4BozBOm0nzK4Z?=
 =?us-ascii?Q?r47Zm/5GGOZ3IhLqdoJu//p0UD5mCIySEngV95/MVW7w/6HJV+WqRp+XxL/A?=
 =?us-ascii?Q?c9dgvyoAo+OvpfeZeHkpOZkQcWxAUPNkHwXg6MFkUdwFvlNAAWYK74ZoUAJJ?=
 =?us-ascii?Q?+YFoTynzMtjhePrz3v+RJaXE4rK9oQcxOJeRJbCBcXwD8aY5DuP++ENolpmf?=
 =?us-ascii?Q?PhlvPtM4J7kc5ofYMtpUoIv84nKe+eAFkZyssVQk3lWcdfTLzWKCNt2DA6T7?=
 =?us-ascii?Q?m2cqiS1F2xnZ1GMTBBYqxZmg02sEA8ae8Q87W+qAQkxd9Icm1HaHuG9Xx5W/?=
 =?us-ascii?Q?j2hMOb/+zquyJyi9YLudwDVUqpUVnFBnBeWTLKrsZr7OtMaVpP5Wfq+Lu/+Y?=
 =?us-ascii?Q?a1uvvsRhqJ8+7yewQCXPNtIcMlQGClRJQvVT9EtSAfQBLzVfnjSOi5c7Bf92?=
 =?us-ascii?Q?NV0B/9LYB+74qKQvVVGuxFgV9I71/EfTiBfywmBColT7tseb9XJetmR4wQH8?=
 =?us-ascii?Q?IDgLSBITsbMX3CCoOp/8WISwcNSPXS1qUPKxyKzCXHZg76WQI87jiwQvJqDn?=
 =?us-ascii?Q?xqYzwNqdaE74j4oqwhjArOEtKP/MYjXoXriaN2tKbsU56iJwmCDclgCGQZp3?=
 =?us-ascii?Q?qte6vD5kfF5p76lbKH50218uO1TM0sEXVc4MrCWETsOItvw2sp6FtQubh2mL?=
 =?us-ascii?Q?jBmQlAZARlV0JZl4jpgqqOHPOABd0hu0OXvShWcRN6KQtLerkOD05QOH4Zra?=
 =?us-ascii?Q?cs+u0j0kI2VIP+4wkef1qKUpYQiTcIGxmGrO8VJETUiPNxIIroJ3Q3hIIQng?=
 =?us-ascii?Q?ps4bjf+r5MsfCAd2zsYIUw1g4+24YL3IzqyFBDMUTE7j1WX0ebhHUcAV/y1S?=
 =?us-ascii?Q?vx810LgMYfeAe4/Ai4ec7lcMkjvL1coq1kBODT8yf014T2aRT7YigKUc2/04?=
 =?us-ascii?Q?0duS+Y0KN9oSvnx6CqDrn2kb8hXHpePNFkSol8ZuF9YFGoGOScWRmm2Dqb//?=
 =?us-ascii?Q?9D36m5Awdqqp6hLA8P6yNR0MCqjyS/uAhMghmtmMe04xS35T4QDen3OIpMl6?=
 =?us-ascii?Q?SbtWkVM7XUKIyYCHQ6N3Mj3PpyLD4AQTKU2siJl8HRhReFABbyWkBRJqi4w9?=
 =?us-ascii?Q?F86Uzgs8sAUbkPJlCkzL4Puypqf7bQ8f4MeBqAen?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e7b547-1bee-4984-b6f9-08daa481b587
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 14:23:42.9497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DZk5t/JuYCl6ymSa5Kpy1rTl+g1s1RiSwXaEYmovtR5TyjcWG1OyQvneIM+j8NpZC/AYsXE221lSR+5Q1VFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Wed, Sep 14, 2022 at 04:38:31AM +0000, Petlozu Pravareshwar wrote:
> > During PMC resume, translate tier2 SC7 wake sources back into irqs and
> > do generic_handle_irq() to invoke the interrupt handlers for edge
> > triggered wake events such as sw-wake.
> >
> > Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 44
> > +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c index
> > 8c7b46ac6ad6..f275af15f2d0 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irq.h>
> > +#include <linux/interrupt.h>
>=20
> This should be sorted alphabetically.
>=20
> >  #include <linux/kernel.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_clk.h>
> > @@ -3181,6 +3182,40 @@ static void wke_clear_wake_status(void)
> >  				WAKE_AOWAKE_STATUS_W((i * 32) +
> wake));
> >  	}
> >  }
> > +
> > +/* translate sc7 wake sources back into irqs to catch edge triggered
> > +wakeups */ static void process_wake_event(int index, u32 status) {
> > +	int irq;
>=20
> Interrupts are usually unsigned int. The index parameter can also be
> unsigned int because it will never be negative.
>=20
> > +	irq_hw_number_t hwirq;
> > +	int wake;
>=20
> Can be unsigned int as well. Also, it's usually best to define variables =
of the
> same time on a single line to make the code a bit shorter.
>=20
> > +	unsigned long flags;
> > +	struct irq_desc *desc;
> > +	unsigned long ulong_status =3D (unsigned long)status;
>=20
> Why not just make the status parameter an unsigned long to avoid this
> clumsy construct?
>=20
> > +
> > +	dev_info(pmc->dev, "Wake[%d:%d]  status=3D0x%x\n", (index + 1) *
> 32,
> > +		index * 32, status);
>=20
> At most these should be dev_dbg().
>=20
> > +	for_each_set_bit(wake, &ulong_status, 32) {
> > +		hwirq =3D wake + 32 * index;
> > +
> > +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> > +		irq =3D irq_find_mapping(pmc->domain, hwirq);
>=20
> We already use irq_domain_add_hierarchy(), and so the assumption is that
> IRQ_DOMAIN_HIERARCHY will always be enabled. You can drop this check.
> We may even want to make it explicit by selecting it from SOC_TEGRA_PMC.
>=20
> > +#else
> > +		irq =3D hwirq;
> > +#endif
> > +		desc =3D irq_to_desc(irq);
> > +		if (!desc || !desc->action || !desc->action->name) {
> > +			dev_info(pmc->dev, "Resume caused by WAKE%d,
> irq %d\n",
> > +				(wake + 32 * index), irq);
> > +			continue;
> > +		}
> > +		dev_info(pmc->dev, "Resume caused by WAKE%d, %s\n",
> > +			(wake + 32 * index), desc->action->name);
>=20
> Same here.
>=20
> > +		local_irq_save(flags);
> > +		generic_handle_irq(irq);
> > +		local_irq_restore(flags);
> > +	}
> > +}
> >  #endif /* CONFIG_ARM64 */
> >
> >  static int tegra_pmc_suspend(struct device *dev) @@ -3219,6 +3254,15
> > @@ static int tegra_pmc_resume(struct device *dev)
> >  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> >
> >  	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
> > +#else /* CONFIG_ARM64 */
> > +	int i;
>=20
> unsigned int, please.
>=20
> Thierry

Agree to the comments. Will be updating the patch.

Thanks.

>=20
> > +	u32 status;
> > +
> > +	for (i =3D 0; i < WAKE_NR_VECTORS; i++) {
> > +		status =3D readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
> > +		status =3D status & readl(pmc->wake +
> WAKE_AOWAKE_TIER2_ROUTING(i));
> > +		process_wake_event(i, status);
> > +	}
> >  #endif
> >
> >  	return 0;
> > --
> > 2.17.1
> >
