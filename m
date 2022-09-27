Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FA5ECF91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiI0Vvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiI0VvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:51:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C0A110B14;
        Tue, 27 Sep 2022 14:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBiIuSKC36+Z/tdmRNbj2xaQ/aT/ZRogiIGWBmgVpzxNheu7Q+OVx9ie4q9kNDG2SzNekZIxJTbpyFXcrdEci2+nD/LwfCQlRfNVvsTbvVM+SQyCtH5itgJ+dTWdptUy8k367QMVK0F4SzsO435WzfiD3brJic6098HWDEyzEXC6GBVTJlgkGM7fTiedP2OAptTgbKtOG0Zj4Jxf4Fh7ikzHy/6TgrS8cVHL4sqD+ylfZpfL4LD/OJIuYofx27YYSUREZxKSfFSR8xYERLiPY3YkrhoPzGYyRxvy+wqepufS3hpWFnDN9w+qCf9f0DQA8n2MIMr0sRDMbZ/7Uhf9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP4qd1kTsaNCz5b7h0LmGc0EhepktOdGJJvtEG6RIV8=;
 b=IJOw4XjKXDVyg0cUMdGnj+pYXBceZ/FYN2IY4rB+ZVOoiIlJKlkHT4OU5XiuFT2IPkBSFqbzu5A5BXbBN6GBcZywFE49cU2RGaZgBtw3mBdrdDdI0yYRaMvil/lXSCuOj2DHo2bOd15Im3PQseu1x8ZB2OpzEcV3SnziMESPXoPYLZf6uHrj6zCPZfE1NN40MrZ+oqMODgflPOZouQgubadIjqgMpiy6lLrYnM3od8OqK8Izqip6qa2X9lz3aDOX0N3BrLPDCoBghBvGkJk5KRMiVBcTSXaL5WQUU2vsyL7784a6CTeYb+U6uK8TsvpPpZX3KQwMzpXkojroMV+ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP4qd1kTsaNCz5b7h0LmGc0EhepktOdGJJvtEG6RIV8=;
 b=kZDWRLj2Ua1thZAJfHl2WYWgdv6vUtp6k+BlG3KdL7ofDO1B5tVlE4YeNkj55FY5fwx8mVWdGe+K/OrRYPr4a/3KJIO5GdD4/9nII4CJcKNV9pcj+hqwYjMhsqmv/HSvpc0bFO7dYqdN4ZaUH98Kw1mjQ/tvxBhG9Hpj2RT4rX3YrWj+Kj8nH9PEEHdb1VvXz/1e/MguLTGugUyVHrNoZXGiIzcr7yVu8GZBedez37Y1zlsf4FakJWJNJHk9/qxbeYWsm7NgM80ehwvzwOw5MUsZJrNkgrC+8f9NNRljsxTh9sta83qTQqICORuRML4LqnQ+QI0yS2l/UysS7OQ1oA==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 21:50:55 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec%4]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 21:50:55 +0000
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
        Stefan Kristiansson <stefank@nvidia.com>
Subject: RE: [PATCH] soc/tegra: pmc: Fix dual edge triggered wakes
Thread-Topic: [PATCH] soc/tegra: pmc: Fix dual edge triggered wakes
Thread-Index: AQHYwfbKiCUYTFCSC0Gw7bLmqIXNza3fFQkAgBTdczA=
Date:   Tue, 27 Sep 2022 21:50:55 +0000
Message-ID: <DM6PR12MB3164991C713F5695A1290C87B5559@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220906134417.341407-1-petlozup@nvidia.com>
 <YyHvfuCGLifv9OX+@orome>
In-Reply-To: <YyHvfuCGLifv9OX+@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3164:EE_|PH7PR12MB5807:EE_
x-ms-office365-filtering-correlation-id: 088a19a1-79ec-468f-d6b0-08daa0d25ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCgF7m5kiXyjrlh5eY3AGMFygdCHtQqRlM1t3Yk3yhS52xkX2mLmsC+IMOcCdRqlVXRABkdlYyeawkAAlSZdV3XAiOhMbbYIxgYJoy+AT7dgVRR2HlPUy0/0yvUdii63al5KtJd3YpgwEcjtVUfAfiog+FZpP0Mt+vvyRdkBtmBKFu4NzONEnRcH9SC1m7KMdegpWu+b5gzZSO5HC1GQsZqTt0VGDy9G7mmOn0CqKU3WbJTjnQJkaT1HDE2lO229+tTqYDd5Hvtz2LotTkF70aNUIKWLAVbLX6oBJ7EGQUNvcEgtdF0X/tqnoTLLQCuxcGjzHjiafuOtJDoNhCSZAMhTYlCjSNlQvLdZzCMCF5O/lLydVl3siVDsKRyen3lmod7awh9lLkdS1k6b+pqu7xT7mbFgKmSsXEtmUVrQlIh7H9jJf9B0l5Xj0haOLds7nC7qcbtL/yP9BBbK4BZv8MWnTFLbv0FoLs33fN0CZ+SKXXT8Azy74hzhGR5JYmYCKqBDrRaQuOStfQQF64uFAk1P8+nWmNHiN8jIQF1E3P0nzVYhMiiaBxPCjDS6433EKcKoRgkqm9L8I5IH6kcVbTS1qG/s0bUvf6ossXfb6L/GMK2MFsV/FOXV/QO/WdV52n8inBdznpWRm03uNOM+iqaEJZ+MtX01xOAJzRYn0rp0xWhf58sKD+8NY89WiU3zev47/iKIdqllJvBpv4HR8Uwa5oq71ODmVEgKHXLL5IZ8DQoJzPWieQsjtg5f6dRtP+3Dglex2yYBXf75EPmN7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(86362001)(38100700002)(33656002)(66899015)(122000001)(38070700005)(2906002)(186003)(5660300002)(26005)(55016003)(41300700001)(107886003)(7696005)(478600001)(71200400001)(6506007)(9686003)(83380400001)(316002)(4326008)(66446008)(6916009)(54906003)(64756008)(52536014)(8936002)(76116006)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6zSQ3GfShYXn2R/pxPj2rBApVMws9lVDFZdMb3F6ND9pqh8GRYg6WNnPjU5d?=
 =?us-ascii?Q?p88Oj2AeISe4eipcyHufU7UdJMYOVkQfbPYzmoHliv+sXqDstidEM1h5bdRj?=
 =?us-ascii?Q?FalPJH+vf3maWCidmVha5zGxFZ8oUM087B5rLYSEVujVGyNzpOGKABkF/02G?=
 =?us-ascii?Q?S8pSXPNZzBs8l1KZN8DBxMPn5aBA8Nh7vB/JaqaQJluqXIjjJEIjHhg9T6Rk?=
 =?us-ascii?Q?ZpMoPimt/Fdn5JYAZRQracH1Lng/AdT1U5vdDQFiHFNqHl0lnjPZPgsB6QO8?=
 =?us-ascii?Q?3zwFFCTpxhZrMm7/x8NbscrJAUJIOLyi/5um1UtggL6PSe3rAjS7r2M1a7Cr?=
 =?us-ascii?Q?N13JCcHO15dsboOvm7duTb8bMj7pmzELNsEuTx6ngJVtLf76WYfLjjzVqB7r?=
 =?us-ascii?Q?Bl7o1jOFqdbnEwSD1X2HRWntnj0hlD0fbqOW6aVPxSqF11+qIlWOQGrglvdM?=
 =?us-ascii?Q?afdO1JHOIIjp6dBXjKq2hvwTkHLNYqmM1hsNUSI7isJO3NmAXl0g/Iat3x1x?=
 =?us-ascii?Q?QaUsax+lC/JiVL6njikh6AiNSaBldWh0yuAGDSMlQ0tvMAJyXcCPWFIa8ZjU?=
 =?us-ascii?Q?7pMHKE6jfZO0niuycnu6jRVkEQwywGlGv8IoVW0DKGVI319EufUoDKIhC93V?=
 =?us-ascii?Q?clLCzPeyDE8MJyfz4fwtSca5hhHyTjBxl/R8hv7wl79FodVOf6OUocFykgVI?=
 =?us-ascii?Q?v8c8i4P4ji/OLtkYnr1fm3P7CnRWb+qVb/I38nQy0B8gLsU8igATo3PETTUp?=
 =?us-ascii?Q?O1Ei/hkc1cEd3Mcn6Hz6F4LOhZUoQgDgPNJ+69nzBL3ITaCWzfiZMlZbECG5?=
 =?us-ascii?Q?nN4pdfR6TxaMdxmOFZHvpAeiY1gZDyCdooLTr6T+CKJpVxdsAHcm31FAXKtS?=
 =?us-ascii?Q?XOAqQM8BX17PoYjf7A2LB4TfrWwnZT/OQKD4pHHSLv6BTaM45zF9yp4hIx72?=
 =?us-ascii?Q?QqyVymc6eceMLHmplhWIDycALbobKqIw3EaYF8B3thKaR9RueiwrjqfguCYo?=
 =?us-ascii?Q?P2NuRR665XQSyYKtIpmXRJ3uMQk9QUXGXpPeNQIynMJ9dQMCMcY18PP3KzF9?=
 =?us-ascii?Q?0WlreJ2MTNS8ISpTe4XYb3ZR+MBBG120OfzZVB6dQ7soHE/VVoKfXbcl8b6R?=
 =?us-ascii?Q?zNKb3chBn7W5+YdMiNbG+FIV3iBQm98e57QYKV0WmdW5BpnoaumzlUED352C?=
 =?us-ascii?Q?Kqa4RzI3+f4Fs8uPEFl/vv3oSAN0ew1HzE0p2d+IWL4PqqtGH8C5WVDe98MQ?=
 =?us-ascii?Q?3HLi7zzsoZKBSFV5JNKahjpU0IW6KujwZRMjORtZK6BY3hhsHik52lEQoGIW?=
 =?us-ascii?Q?QQO8f7GRcyfTnQOVg+wHEyW9WY7k0eDazQ2GhLkXH8UzHHA1D81UQNnI2LRw?=
 =?us-ascii?Q?RkiPPSk8T2IztJfwpgJU9QcSJb8uu0j/L67QrKSSPyzhaGIZnWrlCI1EGfed?=
 =?us-ascii?Q?K76pAh4SEhWRRPSHBa/4GpNucJLZwIcypGmWfLbxmQnkne2aZQGQCTbae/yp?=
 =?us-ascii?Q?qpCk5P7TBAMFAsyN2LIYs3kASpJjRjsId8JZc/qHh4fUFXKD3xFhXQP+o7Me?=
 =?us-ascii?Q?Dnj89wdgPck0GdHvoF8QhUIIqpyZPFyqxPfPeh4d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a19a1-79ec-468f-d6b0-08daa0d25ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:50:55.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsWaZ2QEw3JFFjaW7HuzAJMVqFbdYW9u1eeX5dghmLUTVlnC7D5OBmGe51oBUUjYJ5r9V9rg+SFCKYlpn/p4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Tue, Sep 06, 2022 at 01:44:17PM +0000, Petlozu Pravareshwar wrote:
> > When a wake event is defined to be triggered on both positive and
> > negative edge of the input wake signal, it is crucial to know the
> > current state of the signal when going into suspend.
> > The intended way to obtain the current state of the wake signals is to
> > read the WAKE_AOWAKE_SW_STATUS register, which should contains the
> raw
> > state of the wake signals.
> >
> > However, this register is edge triggered, an edge will not be
> > generated for signals that are already asserted prior to the assertion
> > of WAKE_LATCH_SW.
> >
> > To workaround this, change the polarity of the wake level from '0' to
> > '1' while latching the signals, as this will generate an edge for
> > signals that are set to '1'.
> >
> > Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 141
> > ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 136 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c index
> > 495d16a4732c..6a86961477e8 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -182,6 +182,9 @@
> >  #define WAKE_AOWAKE_TIER0_ROUTING(x) (0x4b4 + ((x) << 2))  #define
> > WAKE_AOWAKE_TIER1_ROUTING(x) (0x4c0 + ((x) << 2))  #define
> > WAKE_AOWAKE_TIER2_ROUTING(x) (0x4cc + ((x) << 2))
> > +#define WAKE_AOWAKE_SW_STATUS_W_0	0x49c
> > +#define WAKE_AOWAKE_SW_STATUS(x)	(0x4a0 + ((x) << 2))
> > +#define WAKE_LATCH_SW			0x498
> >
> >  #define WAKE_AOWAKE_CTRL 0x4f4
> >  #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0) @@ -191,6 +194,12
> @@
> >  #define  TEGRA_SMC_PMC_READ	0xaa
> >  #define  TEGRA_SMC_PMC_WRITE	0xbb
> >
> > +#define WAKE_NR_EVENTS		96
> > +#define WAKE_NR_VECTORS		(WAKE_NR_EVENTS / 32)
>=20
> Are these always 96? Can they not vary by SoC generation?
Yes. They can vary by SoC generation. I will create a variable in struct te=
gra_pmc_soc
for the maximum number of wake events supported and use that per-SoC variab=
le.
>=20
> > +
> > +DECLARE_BITMAP(wake_level_map, WAKE_NR_EVENTS);
> > +DECLARE_BITMAP(wake_dual_edge_map, WAKE_NR_EVENTS);
>=20
> These should not be global variables but rather part of struct pmc.
> Might be worth to allocate them dynamically based on a parameterized per-
> SoC num_events.
Agree.
>=20
> > +
> >  struct pmc_clk {
> >  	struct clk_hw	hw;
> >  	unsigned long	offs;
> > @@ -2469,29 +2478,37 @@ static int tegra186_pmc_irq_set_type(struct
> > irq_data *data, unsigned int type)  {
> >  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
> >  	u32 value;
> > +	unsigned long wake_id;
>=20
> The usefulness of that local variable is questionable. Might as well just=
 keep
> using data->hwirq.
Agree.
>=20
> >
> > -	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
> > +	wake_id =3D data->hwirq;
> > +	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
> >
> >  	switch (type) {
> >  	case IRQ_TYPE_EDGE_RISING:
> >  	case IRQ_TYPE_LEVEL_HIGH:
> >  		value |=3D WAKE_AOWAKE_CNTRL_LEVEL;
> > +		set_bit(wake_id, wake_level_map);
> > +		clear_bit(wake_id, wake_dual_edge_map);
> >  		break;
> >
> >  	case IRQ_TYPE_EDGE_FALLING:
> >  	case IRQ_TYPE_LEVEL_LOW:
> >  		value &=3D ~WAKE_AOWAKE_CNTRL_LEVEL;
> > +		clear_bit(wake_id, wake_level_map);
> > +		clear_bit(wake_id, wake_dual_edge_map);
> >  		break;
> >
> >  	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
> >  		value ^=3D WAKE_AOWAKE_CNTRL_LEVEL;
> > +		clear_bit(wake_id, wake_level_map);
> > +		set_bit(wake_id, wake_dual_edge_map);
> >  		break;
> >
> >  	default:
> >  		return -EINVAL;
> >  	}
> >
> > -	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
> > +	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
> >
> >  	return 0;
> >  }
> > @@ -3074,28 +3091,142 @@ static int tegra_pmc_probe(struct
> platform_device *pdev)
> >  	return err;
> >  }
> >
> > -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
> > +#ifdef CONFIG_PM_SLEEP
> > +#ifdef CONFIG_ARM64
> > +/*
> > + * Ensures that sufficient time is passed for a register write to
> > + * serialize into the 32KHz domain.
> > + */
> > +static void wke_32kwritel(u32 val, u32 reg) {
> > +	writel(val, pmc->wake + reg);
> > +	udelay(130);
> > +}
> > +
> > +static void wke_write_wake_level(int wake, int level) {
> > +	u32 val;
> > +	u32 reg =3D WAKE_AOWAKE_CNTRL(wake);
> > +
> > +	val =3D readl(pmc->wake + reg);
> > +	if (level)
> > +		val |=3D WAKE_AOWAKE_CNTRL_LEVEL;
> > +	else
> > +		val &=3D ~WAKE_AOWAKE_CNTRL_LEVEL;
> > +	writel(val, pmc->wake + reg);
> > +}
> > +
> > +static void wke_write_wake_levels(unsigned long *lvl) {
> > +	int i;
> > +
> > +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> > +		wke_write_wake_level(i, test_bit(i, lvl)); }
> > +
> > +static void wke_clear_sw_wake_status(void) {
> > +	wke_32kwritel(1, WAKE_AOWAKE_SW_STATUS_W_0); }
> > +
> > +static void wke_read_sw_wake_status(unsigned long *status_map) {
> > +	u32 status[WAKE_NR_VECTORS];
> > +	int i;
> > +
> > +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> > +		wke_write_wake_level(i, 0);
> > +
> > +	wke_clear_sw_wake_status();
> > +
> > +	wke_32kwritel(1, WAKE_LATCH_SW);
> > +
> > +	/*
> > +	 * WAKE_AOWAKE_SW_STATUS is edge triggered, so in order to
> > +	 * obtain the current status of the input wake signals, change
> > +	 * the polarity of the wake level from 0->1 while latching to force
> > +	 * a positive edge if the sampled signal is '1'.
> > +	 */
> > +	for (i =3D 0; i < WAKE_NR_EVENTS; i++)
> > +		wke_write_wake_level(i, 1);
> > +
> > +	/*
> > +	 * Wait for the update to be synced into the 32kHz domain,
> > +	 * and let enough time lapse, so that the wake signals have time to
> > +	 * be sampled.
> > +	 */
> > +	udelay(300);
> > +
> > +	wke_32kwritel(0, WAKE_LATCH_SW);
> > +
> > +	for (i =3D 0; i < WAKE_NR_VECTORS; i++)
> > +		status[i] =3D readl(pmc->wake +
> WAKE_AOWAKE_SW_STATUS(i));
> > +
> > +	bitmap_from_arr32(status_map, status, WAKE_NR_EVENTS); }
> > +
> > +static void wke_clear_wake_status(void) {
> > +	u32 status;
> > +	int i, wake;
> > +	unsigned long ulong_status;
> > +
> > +	for (i =3D 0; i < WAKE_NR_VECTORS; i++) {
> > +		status =3D readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
> > +		status =3D status & readl(pmc->wake +
> > +				WAKE_AOWAKE_TIER2_ROUTING(i));
> > +		ulong_status =3D (unsigned long)status;
> > +		for_each_set_bit(wake, &ulong_status, 32)
> > +			wke_32kwritel(0x1,
> > +				WAKE_AOWAKE_STATUS_W((i * 32) +
> wake));
> > +	}
> > +}
> > +#endif /* CONFIG_ARM64 */
> > +
> >  static int tegra_pmc_suspend(struct device *dev)  {
> > +#ifdef CONFIG_ARM
> >  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> >
> >  	tegra_pmc_writel(pmc, virt_to_phys(tegra_resume),
> PMC_SCRATCH41);
>=20
> If this code is really no longer needed on 64-bit ARM, this should be a
> separate patch. Also, these conditionals are becoming a bit unwieldy, so =
I
> wonder if we should instead move to C conditionals using IS_ENABLED() to
> make this a bit more readable and get improved code coverage at compile
> time.
Agree.
>=20
> > +#else /* CONFIG_ARM64 */
>=20
> The implied condition here seems a bit broad. I think it might be better =
to
> conditionalize this code on the setting of tegra_pmc_soc.wake_events.
> If that's !=3D NULL, then execute all this context store/restore, otherwi=
se don't.
Actually, on further analysis I see couple of issues here.

In the below code, we are trying to flip the wakeup trigger level for dual-=
edge
triggered wakes which are currently asserting as wakeups. I think ideally t=
his
should be done after all the device PM suspend callbacks have executed.
So instead of tegra_pmc_suspend(), a struct syscore_ops.suspend callback
could be a better place to ensure this code gets executed very late during
system suspend.

Also, wake related HW register organization is different for tegra210 SoC
compared to tegra186 and beyond SoCs. Below code is actually applicable
only for tegra186 and beyond SoCs. Currently per-SoC "init" pointer is NULL
for tegra186 and beyond SoCs. I am planning to set this pointer to a new in=
it
API to do register_syscore_ops() which would register a syscore suspend
callback API containing the below code. I will update the patch accordingly=
.
>=20
> > +	DECLARE_BITMAP(status, WAKE_NR_EVENTS);
> > +	DECLARE_BITMAP(lvl, WAKE_NR_EVENTS);
> > +	DECLARE_BITMAP(wake_level, WAKE_NR_EVENTS);
> > +	int i;
> > +
> > +	wke_read_sw_wake_status(status);
> > +
> > +	/* flip the wakeup trigger for dual-edge triggered pads
> > +	 * which are currently asserting as wakeups
> > +	 */
> > +	for (i =3D 0; i < BITS_TO_LONGS(WAKE_NR_EVENTS); i++) {
> > +		lvl[i] =3D ~status[i] & wake_dual_edge_map[i];
> > +		wake_level[i] =3D lvl[i] | wake_level_map[i];
> > +	}
>=20
> I think these can be done using:
>=20
> 	bitmap_andnot(lvl, wake_dual_edge_map, status,
> WAKE_NR_EVENTS);
> 	bitmap_or(wake_level, lvl, wake_level_map, WAKE_NR_EVENTS);
Agree.
>=20
> > +
> > +	/* Clear PMC Wake Status registers while going to suspend */
> > +	wke_clear_wake_status();
> >
> > +	wke_write_wake_levels(wake_level);
> > +#endif
> >  	return 0;
> >  }
> >
> >  static int tegra_pmc_resume(struct device *dev)  {
> > +#ifdef CONFIG_ARM
> >  	struct tegra_pmc *pmc =3D dev_get_drvdata(dev);
> >
> >  	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
> > +#endif
> >
> >  	return 0;
> >  }
> >
> >  static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend,
> > tegra_pmc_resume);
> >
> > -#endif
> > +#endif /*CONFIG_PM_SLEEP */
>=20
> Perhaps we should then also drop the CONFIG_PM_SLEEP conditional and
> instead mark tegra_pmc_suspend()/tegra_pmc_resume() as
> __maybe_unused.
> Could also be a separate patch.
Agree.
>=20
> Thierry
>=20
> >
> >  static const char * const tegra20_powergates[] =3D {
> >  	[TEGRA_POWERGATE_CPU] =3D "cpu",
> > @@ -4069,7 +4200,7 @@ static struct platform_driver tegra_pmc_driver =
=3D
> {
> >  		.name =3D "tegra-pmc",
> >  		.suppress_bind_attrs =3D true,
> >  		.of_match_table =3D tegra_pmc_match,
> > -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
> > +#if defined(CONFIG_PM_SLEEP)
> >  		.pm =3D &tegra_pmc_pm_ops,
> >  #endif
> >  		.sync_state =3D tegra_pmc_sync_state,
> > --
> > 2.17.1
> >
