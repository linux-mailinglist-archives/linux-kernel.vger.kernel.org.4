Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476C6A3F85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjB0KgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0KgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:36:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42047D9B;
        Mon, 27 Feb 2023 02:36:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG73SwYmViPCQdS/b4AZBI3st6qU2CFzMaAMga84y467EaFk+VvQvkoLKlMWIG07sE+fYi4ryc67lWYwf2++CzA+OEc5hbIKEl1r1KSY09RUpjiOcZzpizQIOllhiGKtcuNoEK+BaBwJ8euk/PG47566eKCGTXD7uwrfGWs8Y5a3Ku+ELR991KWTNEHx0G94oomx0Jz6I1aWMbEuOmu7bNMvF8jKM9IhkzTlpNulNcab8JJOH5RVp/DXsR0bFe59CqpM9NH5I2FjsX3OgBgDgNhp86roTsu7ZOgPfLp9deWGJuRmxSjhOBP97VZjswKE49Wb97NkEKKojYzZ1Ebcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIutSpxE7R+kLz8znD9DiejX1LH8N4HS0Ky7CoYXF6A=;
 b=NqaM151UBrrnSbVJhJvFtrzAQvEFoX+4NRgh5GZtjZhSwgIHRiWIpqXguTdaUQFcbKdYHDFp6DuHJbmdQ0owFbtc9Vj3zpEHC/h+zTVm761uqau1/+VxHeQJwGOTYonxewyZtDQhzf8bv8htebvdCO2E4+MP1Vgg+0uld+9ANl5ojDy+VDK2kGdh3dkfjNWwd9VtwNEf7YTul2I3XXppKMxmwmb26h829rG6hHjXb5oxStqws0U1ieBH5ry6Et78MdC4usHJoS7L/h55JSfqWMvakrpninwypXSetPrem53ptRAgmEj4za8F8HqoJ7eSJrTQaqYX0gW7xCVCGzhKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIutSpxE7R+kLz8znD9DiejX1LH8N4HS0Ky7CoYXF6A=;
 b=n9O58IWhTj4Kv6+whrbk0YxX6uEjxlpu360XinuvcuVXACx5VpGk+OPqRzPltAMuB7p2YMgeYMwgcZHTAmYf14CrPc7OaYoAHJtYiQaSXGrhPor41uQDVzK14KslTBBI4nHjtLcoALmrMDSt0s2noqX0rFIsZfDBnhZslFQXdokMMn4KLhl0h8vuXfXQ0gKqejIUMWcDQetBjmjtnujpZb+3M3BwFUnD4uF8Y5/8ZvrCVo7K2FdVXPLHxqNYd2T/yuLyIlATgXvQ6aDxK3AKaCHdvQVepV2f6vo2p94IvE/qlTWMbCuC9/ZlV3ViEmHBlCRZ/Jrwbfm7nv1D86WKVg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 10:36:19 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 10:36:19 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Thread-Topic: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Thread-Index: AQHZSG4K8+wSVKmZRkimkrAiwHDmq67eTmSAgAAAM/CAABMSgIAENYWg
Date:   Mon, 27 Feb 2023 10:36:18 +0000
Message-ID: <DM4PR12MB576994B630B7D8F43BD21F73C3AF9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
 <Y/jqCRAenwbqc1Uu@sirena.org.uk>
 <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/j6MxmOkZj/TKej@sirena.org.uk>
In-Reply-To: <Y/j6MxmOkZj/TKej@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|CH2PR12MB4264:EE_
x-ms-office365-filtering-correlation-id: 6e9fea3d-8709-437e-bc6e-08db18ae763d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUXOGP+k/1trXe1oi+l6dWVfK+1ZHybsEuCZmutDCryhZh89Q6Im28XWTtUYrGgnwb6c9hkxHOWQv+I9U+8NQsY53I2zkexYGxWlcXNwEcSTHh1CcAa8R0H4Cu8y/riqQqhlvq8KLCT7QvkdO0K8VqXr/AtMlUU7TQYgQLF7NK4vkHxXotrb9l1ARENxLJzqM+5DjpIOLZyILaO7O3j4VZLrl/FY8BzQE9HmyrjyOlLMMzzOo99Jwg0n3PnvaYZAAv+j5f3F37+lF/ly2NLokdYZR8k8a3za+ZUMMDTY5M53qPZLvBC8n2ddfWJYhVxJN5COAMWMhymgmt3NJkjOZbMlCONeEgpWr2TipUehPvU3u5Coue7ehWyNq5l8BxEgsZE3O35ceA9v5xpMo4phpDhbk6YBmiruKCo2sH8Q516n/jSbO2psJsGymX7qnRb4xgFLjJcTRjy7CW4mlgmOMuxck7+7ZNbJzIjemuPusWG07ZSj/Z+tpGf34c38aYXjuLpL/Mu9WP69T4iP68Z8SUAOR30PRpPZEC7k4dCwD5bqQ+y10EjfT/cJvYqHUbkeQ3jEC6+7bdz/UzmgY8d/n9rmc3DKo3jM8dfyFt+lVKABap1+4ab6gqgsRXMSgvCBvCa9xR4ZkuWknMyia7F/dsKtw7wMD137DRyXCMBiK5AUVsP/qkb6mNqDXpcS2puRK6AB67QApsaYrXsUQQymhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(33656002)(316002)(86362001)(54906003)(9686003)(186003)(2906002)(8676002)(5660300002)(66476007)(66446008)(76116006)(4326008)(6916009)(8936002)(41300700001)(66946007)(6506007)(64756008)(478600001)(53546011)(107886003)(71200400001)(55016003)(7696005)(66556008)(38100700002)(52536014)(122000001)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txHpz4MUkgkKbKw3G9VtiwYTOq8cYJuI61oyL55kxt/KfTUOlxbZ0qQ1fcHS?=
 =?us-ascii?Q?E80/UG9cH5O+dYvEzzZvN6b6boHIVblCHcD4BEJTSiNu+JuuvrzD/F0zxsDv?=
 =?us-ascii?Q?detNngmR3LjKapJXZo00x1OcrhK7Ubju8i/96hX5CS6DiU7rEbDIHtTQ29pC?=
 =?us-ascii?Q?PMF0/MSnlKYTVJNXhVg1HHVavFZyk7wVhLSZt5+CK4Uqp/m4Qha9Z8Cglnc/?=
 =?us-ascii?Q?3r8+fauvPDs9PiN8q0qTDQN+cLwncpGaXFE22MNz67aYU0D2+FD0MsGfX3Mp?=
 =?us-ascii?Q?0/QISUnFC1coBgj+gv6Y2Cu9Tu/Qm1xnrQQZjAPV4wT562OV0CM0uqwJMwSX?=
 =?us-ascii?Q?xr3SKPExpDHtc89AemUC+KdYbLfZsGKc5tRBMSOAanNv4teXzJudxquttMf8?=
 =?us-ascii?Q?JQsm08OttUWaSrI0lfefiaPu2kIhFdzrPdsDpVhrIASxGMZDpBD2khLuvKz4?=
 =?us-ascii?Q?bpa9kS44wx/QWxo+qpGihMGWMcRGuWMlz1aXyB/OV0A9rnYWx/r4LC7Aqubk?=
 =?us-ascii?Q?iweMwsExcstZk7M1GyQbBwxQWMmYeIcUZYL1e+zigc7nTIcd1QLp3l9kjyhx?=
 =?us-ascii?Q?WGdgrWZqkj1P0a4h23LSH3EvUuwxcAj6W5SdwBa+A9wOtBB5shmTfG3kQ5/s?=
 =?us-ascii?Q?EJrY9+Vr0wzBcDsUkALq5Z0D58LL5FZY6H+zcs23kJSWR9ODh9wZEWgCHrP6?=
 =?us-ascii?Q?G3eEgOottNjL3OKHl1OgBLNKECpHFweCJv8fJVCIt3i65MDpXBNSuOpKRlTa?=
 =?us-ascii?Q?fOpZowg5FlJMfmYAkK/WmjfxZrbhnHrGmNUHEaLi6d35Rc7xepy2UQDyPwbk?=
 =?us-ascii?Q?FInesRCMxZem4g9dgOJy0aXUca0exvBwT6JLzakMQpVMZG0Y8CmEoVH93OT6?=
 =?us-ascii?Q?asC6X8ryc/1hUD8tZYVF3mIVbtLzj0nmKxw5UU02fNZ/AIny/j6vztzjzDDN?=
 =?us-ascii?Q?nfkEzGT+u8jp2Jp+rf93CKPAhYzjS3PBM1lK9t9zrqG9IOCe8CX/HePoy0R3?=
 =?us-ascii?Q?9QM0c2dmiajjGXQJyW8R/oWfCKxqeSmsMJCCUAkddObD+0OY4lq9e6beAv1A?=
 =?us-ascii?Q?nQoo/a+lfVehMXaUEB/u3RhxgG6kVxmcwJGIZ/dDVDA0q+G+oxmPu/bY+rVe?=
 =?us-ascii?Q?6nJw/OWIt8F6+f0Q/cX8xkthFZOFfLw4ySfyPWLjLExKPkZEvhFlinZjLVN/?=
 =?us-ascii?Q?vI6/2YI8mY2rD+jBrM3WyB5C9r0N59jGXHzG0lpLxuaXU+Jhc4rMcWpQR8Gx?=
 =?us-ascii?Q?SrBJd1shSLCKwYe7f3VIOdpMn7e8PYp926GG3X+Re+UE/D0G5Gt2SAM3Bwky?=
 =?us-ascii?Q?l8ksU9saIrdpxaah0cpO/VN0rqj7bj7RBlp9bOo0eoxBKz9fwTgg8melI2Xp?=
 =?us-ascii?Q?TIdFp8XpDnCA0xMybWFLvkFWjcVQQj6D34xe3Ka8rN4yVsayc/RMR1Z+Hrmr?=
 =?us-ascii?Q?oYtoNOO/USK62ACWWZvVTqKRViBPKeQI8K4LHF890hRmBiI+pO+z4I2X5F1Q?=
 =?us-ascii?Q?gG9d4cuLCyTaPdzZ0ck+0ffcIOD2Dvpn6BYdpHfts6ELQNXtDEb4IwFmwjXz?=
 =?us-ascii?Q?f91H21ZbTk3pg9jOEy+CKV+dcZs2EMTWcgfshTqcvrNcGbAMUuIhOVYaHbyS?=
 =?us-ascii?Q?xj6EtVKSd1UwsKDVpk7cwy4tudH+0bjpAAU8hSyIf4+1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9fea3d-8709-437e-bc6e-08db18ae763d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 10:36:18.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kaxwduTCcvEz6yY8Dl33VYIxfiQbeheI3OMuDVuUQFMGZ3/vghsPvBbXzCFhWbH/EimjSg37fMGZtTHTaSbMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 24 February 2023 23:26
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
>=20
> On Fri, Feb 24, 2023 at 04:50:00PM +0000, Krishna Yarlagadda wrote:
>=20
> > > >  		msg->actual_length +=3D xfer->len;
> > > > +		if (!xfer->cs_change && transfer_phase =3D=3D DATA_TRANSFER)
> > > {
> > > > +			tegra_qspi_transfer_end(spi);
> > > > +			spi_transfer_delay_exec(xfer);
> > > > +		}
> > > >  		transfer_phase++;
> > > >  	}
> > > > -	if (!xfer->cs_change) {
> > > > -		tegra_qspi_transfer_end(spi);
> > > > -		spi_transfer_delay_exec(xfer);
> > > > -	}
> updating the length of the message.
> > > This looks like it'll do the wrong thing and do a change on every
> > > transfer if cs_change isn't set?
>=20
> > This condition is hit only in data phase which is end of message.
>=20
> Shouldn't this just be moved into the DATA_TRANSFER case statement?
Calling transfer_end after updating message length.
