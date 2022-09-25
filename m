Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2E5E95E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIYU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIYU3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:29:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C32AC52;
        Sun, 25 Sep 2022 13:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzerV712gXhf3iGAhKV2ZLajQFl32YjaWuY86RgJtRckfVgnkI2mlOzqLGPoRvjSiboDJzGyxr17YRiYHt5HEzJERdeWWecAaKfksEB9owW6F4RFY25vMvhg4jCoqHFInPcNgTdoGlMnZxWap45hsykbhDVZvzMZa6p/g3HHXIAckwBBPHeUupMH+VQQ0fFOd+rAk8sAy4Qh6PhuGquPUTuhI+Cz8sX3r3lbcziRNZyfZfJaDlZKFjLiCoeQosb+M7XLggF0Al8oSXWak6AnmUTrpPeOcne3uVrCMzBv5gZicfPGsoNyDduscLPHULpO+C4GwmVTM4adDleRL90bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBimPOvK6l/+0qXdJYq5gOZ7xgoPCmBmHlwQ3MvvGc0=;
 b=ewa7Wvnzfijos41iV1CbhJLvxlEXBYgfrgxLc1SYDT/AnUH65L0SN6LTa76fOsEhezhW6oaB5Swbij9bslmn/YJ7+ubMTLt0nZ9aNSTUDlkvBrR++DLbu4Kp1KeWiCvD07gADHQu43rJ0reHGne0vgSTu5VH7xS9uYDASR6DcqZi11bBAGqN80chX5WehUgr39zIYEar3RgMZwZP58ChaOiZo84UEYXRTUWdfmEM+blSY2JHUA98NetfpReM0+r2xJkTiM2/jTcq3RZ85Y1t0sHK9caiJgTuDsJjAJu5kG6EZobX8SpQglJ9T/ZCUGvNbFRUOU2XH7ABaYMKmyy/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBimPOvK6l/+0qXdJYq5gOZ7xgoPCmBmHlwQ3MvvGc0=;
 b=UrNpyUdX/BYGVDCXWJ0Rn9sf53CCIavI1rsWaDS7R8h/vImuAPCBzVjkmZK+Begg2Ki3NVY4opo+mM/nTH7RyaFUXp8GHJAZbiBNyrbPYzk/3B1p7EVWYHUFNFn2kKreE+QArxUTgVNJccjZzk7mzulJMMjXHUqOxna/Vxrn03Ja4Fl+zE7HaAyRAr8D5IyS9oyhYajJi/133ujxnOTO112NO/vmfMwdJj2LtZirz+6WIqmQeYuZvSFEHQrZ6sEJR6rq1UHsCFbjNfXRA8cAk3H5avrVuY8aioDtNP9EFploN5/P64MOj3agjZWRlmpgATu1Z+jRBOCu1RJDNiNVbw==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 20:29:05 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::19e4:50dc:477:c1ec%4]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 20:29:04 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Topic: [PATCH v3] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Index: AQHYt/f0R5V2L0xxKkCES8vfRWLgJ63fIuEAgBGoE/A=
Date:   Sun, 25 Sep 2022 20:29:04 +0000
Message-ID: <DM6PR12MB31643F1D57D0489E0D5510CDB5539@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220824202723.3340035-1-petlozup@nvidia.com>
 <YyHqVj9b7JxWInkF@orome>
In-Reply-To: <YyHqVj9b7JxWInkF@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3164:EE_|SN7PR12MB7155:EE_
x-ms-office365-filtering-correlation-id: fbcde792-fd43-4972-e31e-08da9f34971c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYHg1Rx53L1HlAj7fH3ef6NfzAw3O7p27gs43479ceHBVXkKWPwsBgHHKY4EZ4oMJ4yMWdXtYelXs78qStvEB7ZnqAw6cggqbWcP1uAq2PPtvzJtvUbwooo6I1RzA2Jzfbap7hA84u0yj2fl8md6pV/uNdUN2WEJ+lGD32I5syOhtntzRa57fwAsE55qBWsKDyjjQrmdRMVjjaBk4G0S+Uqj4GiBxzydOTi4udUPVojFOa2H0h/HF0Kn+8rU/IZBU6aolyPs+zeI2xrwX5jNQ5wKeK55/FYDpFiEYHbKwxYX1e8HlN3R+HFZobgtPC6Qmlu0v/cOoE6iyGHLZZ2qR8u1aAwAPVKpwWZDhS0/ns5rZ0JrIupxBN34MFDeidULE6iJX86XHZRSJe01HnE8HHPfuCXojVe6yfudvq8p41j1vzpMQjd4nHd/VxzCGJ/Sh9+ZMPMbG8egWiJQgxJsqTZx1mDP0j0vthfO+ljcQWq6ZoB8y23Hh+l44bCYzpkhksOwCE5Va7mtMevzwJHsMn7yJWkFKt21EdnWgr/MByYZPVUcpe6jtcxXg8egwwvKXDPW2PjhwDX7+culIEJyFnKbp48H27zGOtPqD+MQjUHvj3BFG/C5zqWd6vX3TB9fQuZQGMSdP0j6guWJ5EG8xbhM7hlZ0LqlRI+Hy/r+aESPnKoUHmX7kDGVKEbmk1Ul5g89le3F7PGh9PVWLthxGPpblU0auIp4X5tBpaTPi/6EeI1dk3lHvi+bMmEyDjKRjpwToCHPLJsbo2w/tI58Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(6916009)(316002)(54906003)(55016003)(38070700005)(52536014)(8676002)(8936002)(33656002)(5660300002)(86362001)(66556008)(66446008)(64756008)(66476007)(66946007)(76116006)(41300700001)(2906002)(4326008)(122000001)(9686003)(26005)(71200400001)(186003)(478600001)(6506007)(7696005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvQdoK59q+Eolhb0dgKugsSB5xi1pnrYxxL0oD/Nj/qfe+JrF3wYVL0rE59n?=
 =?us-ascii?Q?Q2aQUTl6LrZgwdNTHiqpOopMIo4ZFsMdc86cKdZYRzhaPvsBBbPhq8yd/toa?=
 =?us-ascii?Q?RaCIJM7dF61uAmAYEelq/2iibOk/dTaNtG8tZ/vrQimWZIJQblSNYZsjPYzB?=
 =?us-ascii?Q?1kFcYIPpTrrLzcYBispSkBEdQJQMq38BA2UnEfhdP3KJxDH41+vrZ6uODAVs?=
 =?us-ascii?Q?6D1vQoBpKiqLIvCYOhHsq1ZZOMQZ5r9mL/j+mi1pFYTZ2G/0Y1FT3YRL2i+W?=
 =?us-ascii?Q?tie/nFAcWbw3SW65A8uGFECz0sat7hqZDtc+xioJ+bGQa9K7IP8DGY21c8M0?=
 =?us-ascii?Q?0FlClCXpYfI+GRDXvR87bkVbEE6eMhsOiDl4PKcCgo5ImofwYDDi+4msaXIH?=
 =?us-ascii?Q?abLS+BBUBKAqolSGPKLcZgKh/mQEKAthCSmaxAc9RtAIulLCUL8+TOjClbbm?=
 =?us-ascii?Q?0xeYMl+t/DW8GZgNmHfm0EMb41OQ9u72FWZ9Fk+HAZkcwEmVABgozL+gPiZc?=
 =?us-ascii?Q?CPnUzlPfR7Uh6CoowfFqZGYi4i0NtCMjHygGcikTEbS5Gr08GfGKZyn8T2B1?=
 =?us-ascii?Q?XDP3tDDMGSxYl+ewVg7E5ENUd5JdBD2hALHrsAXMIYZgSIFI9oPixrVbP4QJ?=
 =?us-ascii?Q?qhgdnvEgSZfJiEbH28IY0ONk/4sl0mO3qF1afx8zQezz/9E4ABTkVQ3d8YYd?=
 =?us-ascii?Q?si7an3+ILSKzqzNt0GqVYoC6NhezfKHWvJ1AZEhJ1T/YmZ/civgSt31qC288?=
 =?us-ascii?Q?CX+j6Gz+GG18fkMD3C5Mh/jMp+T4u98KxoGSsG/O3oTwTpPAa7c2ff6k2cRw?=
 =?us-ascii?Q?GdZ4OSJYTFYMIs45yk7An7+lN4HVxkGZ1uqWPb9VHse2sXcj8ZCTGe3qbJbQ?=
 =?us-ascii?Q?JHG0d/oZYCXi00Xp4ZX4umGYn83wI7DnePl6jhVMLQ6lSGByBeF1WEl+KgB+?=
 =?us-ascii?Q?C16Ccyn/DPtXXPkUuY47o9lorqK4xbuMU7iHgbUDQFsDgkqNeIrSlYXahl7B?=
 =?us-ascii?Q?+Nh4U9I6gMu1Dx9HxLugKy0QRbZJfdWGhdmdwlFACbQa7Vk5ANIvzODpBqBX?=
 =?us-ascii?Q?loHb87NPllSXBT8KeErpL6w2RVQqBZKyNNwkA+hIePg7kAWY44CkDxhCYjiD?=
 =?us-ascii?Q?4G0aHWysZBcp7o5Uj8A8PjS5iR4V/Q7SwBmpADwgCqy62l3roMY4G5bbm31B?=
 =?us-ascii?Q?VeKtR58qyVQblQ0AtjnU3J15WQOG4M4KzG+PanSxT8fC3YQq8mdBnSiWf/UE?=
 =?us-ascii?Q?sC2pUhUQeoLKaa5NPuivpEXRBNMXxFDU3tjTs1Pu2gMTG21+chd1U7N3bgMu?=
 =?us-ascii?Q?qn3PEfS6pIQOpkLBdVd2v2qcGvami1WSrjKHsSVZwo10FdMSnj/SKbkeAlQ6?=
 =?us-ascii?Q?bkjnj/41UDE+BgsdH/dy9GlvSsBuJkrDWJ+qvmjkmRXC2UrO0coUeOVY2pCb?=
 =?us-ascii?Q?zWpy4KAPJyRjyyPYWXpRnGj8bdRZSV4WtfhfPv8MfG04nbwjNujMPy6TjXWI?=
 =?us-ascii?Q?JbcDDHTgDziJ+UTqffOV3xCljEQi0Ev2drGyga6ch+IV9c3rO1h33TTr5DKE?=
 =?us-ascii?Q?MC74P1jk8om23fAP0kULRN/O1aYEWVlvpPOEn6E6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcde792-fd43-4972-e31e-08da9f34971c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 20:29:04.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjiB4+z/jR9D5mwpsTcQGSict4yPJoMgSS4mZwhchTaFk3wKT72iAPhNSUF8uwLRL4CEkfzlbK+A+aR2oz1AMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Wed, Aug 24, 2022 at 08:27:23PM +0000, Petlozu Pravareshwar wrote:
> > Add IO PAD table for tegra234 to allow configuring dpd mode and
> > switching the pins to 1.8V or 3.3V as needed.
> >
> > In tegra234, DPD registers are reorganized such that there is a
> > DPD_REQ register and a DPD_STATUS register per pad group.
> > This change accordingly updates the PMC driver.
> >
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> > v3:
> > * Update to make the code more readable and avoid using extra flags.
> > ---
> >  drivers/soc/tegra/pmc.c | 163
> > +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 151 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c index
> > 5611d14d3ba2..495d16a4732c 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -266,11 +266,23 @@ struct tegra_powergate {
> >  	struct reset_control *reset;
> >  };
> >
> > +enum tegra_io_pad_dpd {
> > +	TEGRA_PMC_IO_LEGACY_DPD,
> > +	TEGRA_PMC_IO_CSI_DPD,
> > +	TEGRA_PMC_IO_DISP_DPD,
> > +	TEGRA_PMC_IO_QSPI_DPD,
> > +	TEGRA_PMC_IO_UFS_DPD,
> > +	TEGRA_PMC_IO_EDP_DPD,
> > +	TEGRA_PMC_IO_SDMMC1_HV_DPD,
> > +	TEGRA_PMC_IO_INVALID_DPD,
> > +};
> > +
> >  struct tegra_io_pad_soc {
> >  	enum tegra_io_pad id;
> >  	unsigned int dpd;
> >  	unsigned int voltage;
> >  	const char *name;
> > +	enum tegra_io_pad_dpd dpd_index;
> >  };
> >
> >  struct tegra_pmc_regs {
> > @@ -284,6 +296,18 @@ struct tegra_pmc_regs {
> >  	unsigned int rst_source_mask;
> >  	unsigned int rst_level_shift;
> >  	unsigned int rst_level_mask;
> > +	unsigned int csi_dpd_req;
> > +	unsigned int csi_dpd_status;
> > +	unsigned int disp_dpd_req;
> > +	unsigned int disp_dpd_status;
> > +	unsigned int qspi_dpd_req;
> > +	unsigned int qspi_dpd_status;
> > +	unsigned int ufs_dpd_req;
> > +	unsigned int ufs_dpd_status;
> > +	unsigned int edp_dpd_req;
> > +	unsigned int edp_dpd_status;
> > +	unsigned int sdmmc1_hv_dpd_req;
> > +	unsigned int sdmmc1_hv_dpd_status;
>=20
> This seems a bit complicated because there's an extra level of indirectio=
n (via
> that dpd_index variable). I think it'd be a bit more trivial to directly =
add
> offsets for the req and status registers to the I/O pad entry definitions=
. So I'm
> thinking something like this:
>=20
> 	struct tegra_io_pad_soc {
> 		enum tegra_io_pad id;
> 		unsigned int dpd;
> 		unsigned int request; /* these two are the new */
> 		unsigned int status;  /* register offsets */
> 		unsigned int voltage;
> 		const char *name;
> 	};
>=20
> And then...
>=20
> >  };
> >
> >  struct tegra_wake_event {
> > @@ -1536,6 +1560,7 @@ static int
> tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
> >  					     u32 *mask)
> >  {
> >  	const struct tegra_io_pad_soc *pad;
> > +	int ret =3D 0;
> >
> >  	pad =3D tegra_io_pad_find(pmc, id);
> >  	if (!pad) {
> > @@ -1546,17 +1571,63 @@ static int
> tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
> >  	if (pad->dpd =3D=3D UINT_MAX)
> >  		return -ENOTSUPP;
> >
> > -	*mask =3D BIT(pad->dpd % 32);
> >
> > -	if (pad->dpd < 32) {
> > -		*status =3D pmc->soc->regs->dpd_status;
> > -		*request =3D pmc->soc->regs->dpd_req;
> > -	} else {
> > -		*status =3D pmc->soc->regs->dpd2_status;
> > -		*request =3D pmc->soc->regs->dpd2_req;
> > +	switch (pad->dpd_index) {
> > +	case TEGRA_PMC_IO_LEGACY_DPD:
> > +		*mask =3D BIT(pad->dpd % 32);
> > +
> > +		if (pad->dpd < 32) {
> > +			*status =3D pmc->soc->regs->dpd_status;
> > +			*request =3D pmc->soc->regs->dpd_req;
> > +		} else {
> > +			*status =3D pmc->soc->regs->dpd2_status;
> > +			*request =3D pmc->soc->regs->dpd2_req;
> > +		}
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_CSI_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->csi_dpd_status;
> > +		*request =3D pmc->soc->regs->csi_dpd_req;
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_DISP_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->disp_dpd_status;
> > +		*request =3D pmc->soc->regs->disp_dpd_req;
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_QSPI_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->qspi_dpd_status;
> > +		*request =3D pmc->soc->regs->qspi_dpd_req;
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_UFS_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->ufs_dpd_status;
> > +		*request =3D pmc->soc->regs->ufs_dpd_req;
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_EDP_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->edp_dpd_status;
> > +		*request =3D pmc->soc->regs->edp_dpd_req;
> > +		break;
> > +
> > +	case TEGRA_PMC_IO_SDMMC1_HV_DPD:
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->sdmmc1_hv_dpd_status;
> > +		*request =3D pmc->soc->regs->sdmmc1_hv_dpd_req;
> > +		break;
> > +
> > +	default:
> > +		dev_err(pmc->dev, "invalid DPD reg index %u\n", pad-
> >dpd_index);
> > +		ret =3D -ENOENT;
> > +		break;
> >  	}
>=20
> All of these can simply become:
>=20
> 	*request =3D pad->request;
> 	*status =3D pad->status;
> 	*mask =3D BIT(pad->dpd);
>=20
> At which point it might even be worth dropping that helper function
> altogether and inlining the values there. Perhaps do the pad lookup at a =
level
> higher up, such as in tegra_io_pad_power_enable() and pass a const struct
> tegra_io_pad_soc * to tegra_io_pad_prepare() and tegra_io_pad_poll().
>=20
> This has the disadvantage that it requires existing tables to be reworked=
 a
> little and they will grow somewhat because of the extra fields, but ultim=
ately
> the code becomes much simpler and decreases in size to compensate for the
> extra data. We also won't need special I/O pad initialization macros like
> TEGRA234_IO_PAD below.
>=20
> If there's a *big* concern about the data size, we could avoid the worst =
by
> special-casing the legacy cases like you've done here. But I think it is =
really
> not worth it. On the plus side, the new version will be flexible enough t=
o
> handle any additions and/or changes to the set of request and status
> registers in future SoCs.
>=20
> Thierry
Agree to the comments. Will be updating the patch accordingly.

Thanks.
>=20
> >
> > -	return 0;
> > +	return ret;
> >  }
> >
> >  static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum
> > tegra_io_pad id, @@ -3291,6 +3362,7 @@ static const u8
> tegra124_cpu_powergates[] =3D {
> >  		.dpd	=3D (_dpd),			\
> >  		.voltage =3D (_voltage),			\
> >  		.name	=3D (_name),			\
> > +		.dpd_index =3D TEGRA_PMC_IO_LEGACY_DPD,	\
> >  	})
> >
> >  #define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> > @@ -3791,6 +3863,61 @@ static const struct tegra_pmc_soc
> tegra194_pmc_soc =3D {
> >  	.has_usb_sleepwalk =3D false,
> >  };
> >
> > +#define TEGRA234_IO_PAD(_id, _dpd, _voltage, _name, _dpd_index)
> 	\
> > +	((struct tegra_io_pad_soc) {				\
> > +		.id		=3D (_id),			\
> > +		.dpd		=3D (_dpd),			\
> > +		.voltage	=3D (_voltage),			\
> > +		.name		=3D (_name),			\
> > +		.dpd_index	=3D (_dpd_index),			\
> > +	})
> > +
> > +#define TEGRA234_IO_PIN_DESC(_id, _dpd, _voltage, _name,
> _dpd_index)	\
> > +	((struct pinctrl_pin_desc) {					\
> > +		.number =3D (_id),					\
> > +		.name	=3D (_name)					\
> > +	})
> > +
> > +#define TEGRA234_IO_PAD_TABLE(_pad) {                                 =
         \
> > +	/* (id, dpd, voltage, name, dpd_index) */                            =
  \
> > +	_pad(TEGRA_IO_PAD_CSIA,           0,         UINT_MAX,	"csia",       =
 \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_CSIB,           1,         UINT_MAX,  "csib",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_HDMI_DP0,       0,         UINT_MAX,  "hdmi-
> dp0",    \
> > +		TEGRA_PMC_IO_DISP_DPD),                                        \
> > +	_pad(TEGRA_IO_PAD_CSIC,           2,         UINT_MAX,  "csic",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_CSID,           3,         UINT_MAX,  "csid",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_CSIE,           4,         UINT_MAX,  "csie",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_CSIF,           5,         UINT_MAX,  "csif",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_UFS,            0,         UINT_MAX,  "ufs",       =
  \
> > +		TEGRA_PMC_IO_UFS_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_EDP,            1,         UINT_MAX,  "edp",       =
  \
> > +		TEGRA_PMC_IO_EDP_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_SDMMC1_HV,      0,         4,         "sdmmc1-hv",
> \
> > +		TEGRA_PMC_IO_SDMMC1_HV_DPD),                                   \
> > +	_pad(TEGRA_IO_PAD_SDMMC3_HV,      UINT_MAX,  6,
> "sdmmc3-hv",   \
> > +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> > +	_pad(TEGRA_IO_PAD_AUDIO_HV,       UINT_MAX,  1,         "audio-hv",
> \
> > +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> > +	_pad(TEGRA_IO_PAD_AO_HV,          UINT_MAX,  0,         "ao-hv",     =
  \
> > +		TEGRA_PMC_IO_INVALID_DPD),                                     \
> > +	_pad(TEGRA_IO_PAD_CSIG,           6,         UINT_MAX,  "csig",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD),                                         \
> > +	_pad(TEGRA_IO_PAD_CSIH,           7,         UINT_MAX,  "csih",      =
  \
> > +		TEGRA_PMC_IO_CSI_DPD)                                          \
> > +	}
> > +
> > +static const struct tegra_io_pad_soc tegra234_io_pads[] =3D
> > +	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PAD);
> > +
> > +static const struct pinctrl_pin_desc tegra234_pin_descs[] =3D
> > +	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PIN_DESC);
> > +
> >  static const struct tegra_pmc_regs tegra234_pmc_regs =3D {
> >  	.scratch0 =3D 0x2000,
> >  	.dpd_req =3D 0,
> > @@ -3802,6 +3929,18 @@ static const struct tegra_pmc_regs
> tegra234_pmc_regs =3D {
> >  	.rst_source_mask =3D 0xfc,
> >  	.rst_level_shift =3D 0x0,
> >  	.rst_level_mask =3D 0x3,
> > +	.csi_dpd_req =3D 0xe0c0,
> > +	.csi_dpd_status =3D 0xe0c4,
> > +	.disp_dpd_req =3D 0xe0d0,
> > +	.disp_dpd_status =3D 0xe0d4,
> > +	.qspi_dpd_req =3D 0xe074,
> > +	.qspi_dpd_status =3D 0xe078,
> > +	.ufs_dpd_req =3D 0xe064,
> > +	.ufs_dpd_status =3D 0xe068,
> > +	.edp_dpd_req =3D 0xe05c,
> > +	.edp_dpd_status =3D 0xe060,
> > +	.sdmmc1_hv_dpd_req =3D 0xe054,
> > +	.sdmmc1_hv_dpd_status =3D 0xe058,
> >  };
> >
> >  static const char * const tegra234_reset_sources[] =3D { @@ -3861,10
> > +4000,10 @@ static const struct tegra_pmc_soc tegra234_pmc_soc =3D {
> >  	.needs_mbist_war =3D false,
> >  	.has_impl_33v_pwr =3D true,
> >  	.maybe_tz_only =3D false,
> > -	.num_io_pads =3D 0,
> > -	.io_pads =3D NULL,
> > -	.num_pin_descs =3D 0,
> > -	.pin_descs =3D NULL,
> > +	.num_io_pads =3D ARRAY_SIZE(tegra234_io_pads),
> > +	.io_pads =3D tegra234_io_pads,
> > +	.num_pin_descs =3D ARRAY_SIZE(tegra234_pin_descs),
> > +	.pin_descs =3D tegra234_pin_descs,
> >  	.regs =3D &tegra234_pmc_regs,
> >  	.init =3D NULL,
> >  	.setup_irq_polarity =3D tegra186_pmc_setup_irq_polarity,
> > --
> > 2.17.1
> >
