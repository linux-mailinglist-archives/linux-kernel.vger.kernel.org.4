Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809E5EB909
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiI0D7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI0D71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:59:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D35F7F0;
        Mon, 26 Sep 2022 20:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enOoLOPIUgbfLdeDlKVPFkKnAYtPXWf4n/7DmWW142HQvzH8/xshuCfYx9gHS3JipXlZOFC5yQaJAcP3YdvVgY2okiGX8XYIM6gg+n7BH3j7Gmd3sW/eKWaWcdXmHo1tyOZuJWV0jtqjA4kqkAkCEFrgcWFSmJ3gfqH385F7YOgfbY1VE/8TxTwBPtSzvxFk/ddO8318DyxsMfwPG4Ec+4JHuYVHvh+BJVkIcFPTdBXe9XclEd5m5o3cg5cW8IxbAERYGcK9PdO0k34MVXpLWXUvJDWIbCBQt+CC/h2VLEausK/wxBQNlVpTKH1jSNnQjuGy/VvD5kwfijGAa2jiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfxX2HgwTbt7thB9MAPd3FZCe6Xa1HnJGhwchHDGbXA=;
 b=d2POsM4HtWZJqKmt9PM89mS/wVsJCJ6Xq7BIO/jNpTwyblbiRxnXP7ecXc5JVu3p+o1OrQaXDi68O7AeMLCUQ7AJJ5BtJwuiZfqAjVD9CwiUQza10ypo8uT7tuGIMS80RyRCmUCzPcWrQU9UP4l7Ta9M08XaskX/tWZgbc1r8zCAT1/t8iVc2srEUoKiSoJPWGkc5qOhGOFgF+5RKhYW73LQMvIWMay2VJWX1o+WmIgvj/CxRzAOgTKCEMwSZZNJ+UUuTw9tJZWZPgDeAqDJ7mG1vw1RtGRZ1fyut+yXag/ZiCnVA3TDDxEWXswXs+jlBgWSkFSNXz3UCVnmqzafrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfxX2HgwTbt7thB9MAPd3FZCe6Xa1HnJGhwchHDGbXA=;
 b=Z/x4NlXJEygY/XQ8i/Y7/4X+cJiiKLt3Oz90SfxOa92rJoe9ygxU9Fq7qhXCBTq2CotQhGVTr5dtWiLTRO6Gfv3OHX3tm2tqP4qG92TFMJx0vG7mCT++bBvQp6WyBtQLZ4+LBMbE/R1+f4ZZ6Lt8ZPUZgHiOe00yoJ7UDFuMs2kkPHerspUV7z5C0EJ0a8Ks2UUEDZRneleEixVy7sDER39Umj3v3Y3lJ87t8SUdgnX318Dvgxct8W7lrdEDFNPU7elE9DFGTTv/eflV6UIbAQfH6xWoa4QQfkZYl4CmMgfk9M2bjdVlYU4Rq7SWoghG4700MtL9tLEdcs3BR7SCog==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 03:59:23 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5%5]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 03:59:22 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
Thread-Topic: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight
 PMU driver
Thread-Index: AQHYsAscx+1Do35BjUm/Kr4IwLOFta3rtSeAgActf4A=
Date:   Tue, 27 Sep 2022 03:59:22 +0000
Message-ID: <SJ0PR12MB56763459EE6CE776680E0762A0559@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <20220814182351.8861-2-bwicaksono@nvidia.com>
 <20220922135257.GD12095@willie-the-truck>
In-Reply-To: <20220922135257.GD12095@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|CH0PR12MB5076:EE_
x-ms-office365-filtering-correlation-id: 760677a5-2992-4f54-c9e4-08daa03ca991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIjyU/mtzxrrQwHW+92g+It2GjlU/Ip29iwWryK6YXVrD7ZCN9+laDUXDt929vHN1++sMOKKJnUsfR2Ih4CcqWjWHv/m9B9t2y8Nqx32o0U57aJEE0LgD0YrL/kD+/Z9P9zq+FsyeY6jncqfW9Z2dDYGinZ1haCVEQxoa7QW6oJ00So+/LYfaugIsMH4TpC4Gc3KgtIY82eXAvr7n6H2y60o97NOuBeYyY/19s/krSIBOfCH4hM+rTt7ArX86VABrWJeHRt1qrTr+3rWl+oWg6i2vtTepTijJDuOAqcjScS+hPvt9h3z33b3C6to+ozYf0Ksf5Q9khMY49Xy7pDTh5YgsHzeV5mzhmxneCKYG0gav4tKtEuLsbOY7h69ZRNOabvnxQsQa4IAQhR9QI0XIUX0WVDA1fkkc8/hKCt3NgxJPzdKi95XjaJyYqQDtG7YXvXuFraLXFdVZU+mxtYwskXiJx+zdS/plIoayTrv7rvQxEvMcAMGDaWpy5Li8DkTA+vbVLJr56628VFPW53wnxFdbBf+c+gbpekERXc6bdsU2PPtj7yisfmEZbYHzxBeBrFo+xOVt0X5H5mfoC1mpx2IrTzkndG2LAGwvPDvpKb9ZLr1nZwlmAbYhS2QwpIxyPTIWOYGnIcoy9ruZ/htI65zVqcGhpA/Px53msCK10dvkZ+xJ/V2QcWBciBsWrV/QAasBu0lpRzFR+BxKuscEVkUVng+nJN8TE4cUGfRKgrINrvstWqN7qqGqLFlXy56OqgQ3wLoMXP1e+1IT6AP9RVjOzQxSd4c1DnONLtZqONUNO0PerpnHpH7q7ZWoIyKZQm81VC6cO463u7qQ27H7m8UpJLrQhQHrcYVC3i6Nxz35q5AENaRlrlZWZMbSdYaQ2kChgyc2wGgI7nwW+5YhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(6916009)(316002)(478600001)(9686003)(52536014)(8936002)(41300700001)(966005)(54906003)(66446008)(53546011)(71200400001)(7696005)(6506007)(2906002)(64756008)(26005)(7416002)(5660300002)(86362001)(38070700005)(33656002)(38100700002)(83380400001)(66556008)(4326008)(8676002)(76116006)(66946007)(186003)(55016003)(122000001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xJVOso1THm7oVLaVIWeJebbGXI0D1QCJ2U/8RDRHKGKdyN6mVJLn+Lc8vDWs?=
 =?us-ascii?Q?3Ke+pUWPmCVKuwci/9811SjKO/oynaRb+SYacCdMQJXwLmQ1JslMbk1zO5oh?=
 =?us-ascii?Q?qVXAwd+R4Hn+6vGDRWwti0aIcn9CA62RherCdsIEqv+MmjpoAnP7fJjk2ZX7?=
 =?us-ascii?Q?xRfEiv1ILAKWIxOSqa9c3kF9/HFWMvInEvxPoPQKtw1hxyPW1eITF+bRa4i3?=
 =?us-ascii?Q?Om6gCPHX+ontNFe+hjhz/RNoQbUPbU9d4ItKQgU28saHeA0gIPwVJ+OGydyB?=
 =?us-ascii?Q?uegiaBGSC53vQ8xR6djmRLvtJRLiIMBOtBiExXHzOdQaJxxYtjxLGZ2Q4kFT?=
 =?us-ascii?Q?LhyAKuGcLS58+99tFbsdcgsb5kMiyHomHyJYYSamrm0jizjyOvNm+/Ix8YJ4?=
 =?us-ascii?Q?9Tcux6WC4zwTdNmHG3yg7cpwjzyjYTJWwfXuZZDrX0ru8AFzJ47O64KL8t5N?=
 =?us-ascii?Q?v9flxt6X8UKU4cizaIkue3Rv1Nm/etTk/lWrtspgE330VsiAlG9ws8e8YGC6?=
 =?us-ascii?Q?7gwCrhw/Iuja8UB3vxuAwwtPN3s7p/FSsdeMfvFEnFZ1AM6HjYJe/VmO/Mck?=
 =?us-ascii?Q?BaVKyexI40PjH84VV4m7+Cvwt9BwhK6fo9eJl8y0tYzHGFew0AwKx8bOJ7MP?=
 =?us-ascii?Q?HnVGq2df0Pav6PVL/CksXI3ZMzSVGct76p/Y4KmDdHpnGZNFw1bT6NmOGwoS?=
 =?us-ascii?Q?YuXVseMrRD+jcXKW9k5hKPP8WaLfcwISX+arGLr7lju0jCggMIwpERj8c7H0?=
 =?us-ascii?Q?ZglZYqbCOVs6Kxxn5L37IObuj22GQ9iVbf7ZEstRO53qThVq3H4EFSpOViZY?=
 =?us-ascii?Q?oPNkIlsZrgJRcHfVInJxN9MbpemTJ+eHSTBLZRWUKiOrDClBZz3YrkzpHE9x?=
 =?us-ascii?Q?JJhdkbwUoV6YZHrm5oKodfUDoQJgiyCe87XbqMM860O5KaNNNa9Mtq0nD1yY?=
 =?us-ascii?Q?xb0OST8Zja6jTPhU4ZxGDELicwU+BvH24WlfiNc/DAQVOqyvSvG/ABSst+Of?=
 =?us-ascii?Q?IZsWXt7PvZdcTk5ZiPZ/6SbG5AqFXgOu0FrpLg/jmLj9xn/BOLxXx+zfxjSN?=
 =?us-ascii?Q?19vmhaLxRjY+Jj4D0KJI+0BH2bEXADUwspSxv9tt5iBWsgVrHIhLnKybqQj+?=
 =?us-ascii?Q?K29RstlALbLIWB+5W8zL3iCsOBI9wqtQgPQtHYUnKKy65Wi8Mrm+RRyUlY7l?=
 =?us-ascii?Q?YOW6UfMJDgqnikbn05ODyGnBtNkR2iLVObd44R1PNIPZJU9Pj0YqpYEBSg+p?=
 =?us-ascii?Q?CJN2s5HmfVSMoMcugxDwNXGhoxRmQWMoKowbUSsJacV+5n4dCmMGAz9PrzQE?=
 =?us-ascii?Q?9qMqK1TSdSp9D8ZnVaBSGjVAhSFLbMLuZ5VYYoDtIdE2HRn5iJqDhdDIcepS?=
 =?us-ascii?Q?u09kQfUiL5hW/fiKbtOWLnb/YaO5XdTVVxD1J4hmIF7DXCAMkDjJLidwG5VK?=
 =?us-ascii?Q?9lTZIqz3vZ9sAqPnb5m9RIXhug7Eo7RJw3N0kAhc28XJ/UPRCA5ZolgriIuW?=
 =?us-ascii?Q?ZtOHDK/n9uDxbElWlwU8ZUFsa1qGqeUDM+6MjffrCGujZGD8vNJS19/6IDp5?=
 =?us-ascii?Q?8Bf69OqfCSdI/UWdEb6E4NHSBZaH26ceirQb4J2N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760677a5-2992-4f54-c9e4-08daa03ca991
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 03:59:22.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTOwcfIbzt2Ox9rJe8tWpGGoiAllSoNQr/X5efIwYlrD6ucZISnLDD0/gfxAYtWsVWHZcazIG8dGQ54CqWXLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Thanks for the comment. Please see my response inline.

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Thursday, September 22, 2022 8:53 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org
> Subject: Re: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM
> CoreSight PMU driver
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Sun, Aug 14, 2022 at 01:23:50PM -0500, Besar Wicaksono wrote:
> > Add support for ARM CoreSight PMU driver framework and interfaces.
> > The driver provides generic implementation to operate uncore PMU based
> > on ARM CoreSight PMU architecture. The driver also provides interface
> > to get vendor/implementation specific information, for example event
> > attributes and formating.
> >
> > The specification used in this implementation can be found below:
> >  * ACPI Arm Performance Monitoring Unit table:
> >         https://developer.arm.com/documentation/den0117/latest
> >  * ARM Coresight PMU architecture:
> >         https://developer.arm.com/documentation/ihi0091/latest
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > ---
> >  arch/arm64/configs/defconfig       |    1 +
> >  drivers/perf/Kconfig               |    2 +
> >  drivers/perf/Makefile              |    1 +
> >  drivers/perf/arm_cspmu/Kconfig     |   13 +
> >  drivers/perf/arm_cspmu/Makefile    |    6 +
> >  drivers/perf/arm_cspmu/arm_cspmu.c | 1262
> ++++++++++++++++++++++++++++
> >  drivers/perf/arm_cspmu/arm_cspmu.h |  151 ++++
> >  7 files changed, 1436 insertions(+)
> >  create mode 100644 drivers/perf/arm_cspmu/Kconfig
> >  create mode 100644 drivers/perf/arm_cspmu/Makefile
> >  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
> >  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
>=20
> [...]
>=20
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> > new file mode 100644
> > index 000000000000..410876f86eb0
> > --- /dev/null
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>=20
> [...]
>=20
> > +/*
> > + * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi s=
equence.
> > + */
> > +static u64 read_reg64_hilohi(const void __iomem *addr)
> > +{
> > +     u32 val_lo, val_hi;
> > +     u64 val;
> > +
> > +     /* Use high-low-high sequence to avoid tearing */
> > +     do {
> > +             val_hi =3D readl(addr + 4);
> > +             val_lo =3D readl(addr);
> > +     } while (val_hi !=3D readl(addr + 4));
>=20
> Hmm, we probably want a timeout or something in here so we don't lock
> up the CPU if the device goes wonky.
>=20

This function is used to read the counter register. The perf driver APIs
(read, stop) that use this function do not return an error code. I am
not sure if we can just break the loop and return 0. Any suggestions ?
Is triggering a panic acceptable ?

> With that, how about adding this a helper to
> include/linux/io-64-nonatomic-*o.h so other folks can reuse it?
>=20
> > +/* Check if PMU supports 64-bit single copy atomic. */
> > +static inline bool supports_64bit_atomics(const struct arm_cspmu
> *cspmu)
> > +{
> > +     return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC,
> SUPP);
> > +}
>=20
> Is this just there because the architecture permits it, or are folks
> actually hanging these things off 32-bit MMIO buses on arm64 SoCs?
>=20

Yes, the PMU spec permits a system that needs to break 64-bit access into
a pair of 32-bit accesses.

> > +static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
> > +{
> > +     int irq, ret;
> > +     struct device *dev;
> > +     struct platform_device *pdev;
> > +     struct acpi_apmt_node *apmt_node;
> > +
> > +     dev =3D cspmu->dev;
> > +     pdev =3D to_platform_device(dev);
> > +     apmt_node =3D cspmu->apmt_node;
> > +
> > +     /* Skip IRQ request if the PMU does not support overflow interrup=
t. */
> > +     if (apmt_node->ovflw_irq =3D=3D 0)
> > +             return 0;
>=20
> Set PERF_PMU_CAP_NO_INTERRUPT?
>=20

Thanks, I will apply it on the next version.

> Will
