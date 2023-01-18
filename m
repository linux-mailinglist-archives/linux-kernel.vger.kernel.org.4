Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D1671AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjARLl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjARLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:41:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF25A36A;
        Wed, 18 Jan 2023 02:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot8aQ+5VXj7eFAUew0kOzzdhHuW2bT94AiS5dLuEIheeUJBlfVFdd7FQzdVITmSPJTCGtBKeG7EMYq+NIaqtQyeh7GiX0awfUEhyN/fE1lF+nXjINIbTnHMgKBMRfdwlzWdBbar5WNMdVNUQGUvHkfXaUkbIRhS7isoBXsdK1/Q+1ntgePRi3YaCn08vyQ2/X3eW+sv9UG96ZADeZztnIOyGuH3krr9S+PbhDj1N+7zGgmPkNDBz7GGvNiXd8njuxkxOTmCI8by/IuFsjvFbdveRxeWtZ7RFzr9tXajg0wr6Zly6jkNSpoBIPAi/UvU9hBmSORP9yZjt8gFqHywOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt4qltfbh0A7CowIkCV3d1hNB/VgRwq0oCE4C1GmQyc=;
 b=nQzWA4agwhO6Us/QG6ZvbSZ9GKyC+phk30JS1w8Iv4BLrjnDhjRJNtESfrrR9PSBILL77iABEnrLHU0Y0NjfpQYysJFf8TVij5WCDYbgzI/kclbEfeaUyGKFS2qSyT0QehBIj5W8T8koPJq5qpFCWT3Tfo7F4aY+zVP81faDVGNXrVswCT66kuuseKamAMi9L/c4BKKs/sbnet04Cm4W7FQSQCFb/CRg/YugrfuecSvnVfs6LfDpUisV6XdPnC3MldCBP/isBxcGhFOBaGnXVqXmp1yQ+C4NdRVFOytx+5rSNcOAA/iGlFtYR9sPiJCHRX3adpX17ZspFYUnE+pk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt4qltfbh0A7CowIkCV3d1hNB/VgRwq0oCE4C1GmQyc=;
 b=covQ9Y3fA11BmsR/e0r2+jfee0QNCxiVghSosmWHdX0NCckvfuBfuXQxl5IyGBB2QHCbyZCaOVRU0P06KIQR/dhAln2sR6nopJ+6YjO20YSkRvGdfE8v8XVdxXLXV3zLPJ1Dn21/1aAuUTYJTJKsHTZVPoRoPDuSoXOvStxGFm4=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 10:58:05 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 10:58:04 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 04/19] bus/cdx: add MCDI protocol interface for firmware
 interaction
Thread-Topic: [PATCH 04/19] bus/cdx: add MCDI protocol interface for firmware
 interaction
Thread-Index: AQHZKnmRWG2ApEq90EqmHRlj1aAziq6ipV6AgAENgkA=
Date:   Wed, 18 Jan 2023 10:58:04 +0000
Message-ID: <DM6PR12MB3082155E317B9CB28500192CE8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-5-nipun.gupta@amd.com> <Y8ar1+QfRR++YfKJ@kroah.com>
In-Reply-To: <Y8ar1+QfRR++YfKJ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T10:58:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d26776b-3c77-4e7f-8154-cba2b33028f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|PH7PR12MB7161:EE_
x-ms-office365-filtering-correlation-id: 137eef39-5c73-4377-b744-08daf942dffb
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GqtyyvNNlCv1RItVJcOpGODPeQ1EBoDRYprngSgBq3XchQWub7kQsV/uHouLecw680mnCPCe0NOojGySdvV7nhg0o+R0OXkTChIcOIx6fLp+DKycfJQfKxb9boYJVs26NO79/UaeQuk9jfa7CP4mvEqA4dQ1QOX02gS0MtI+o7BEX/jsexo4jlh9Y1USsyfym0ExMKlD8n45LG6/iZctemgemG9/FSTYw6k/VsVFSvCFEYfgjjDRmKg90COK1W9Z+Vuv1ePSfPtA/0XKUOfbp693+bo2A05zM8Zk27VxInyVci9KFpnzoAVt4MsEitK498uSgsvxPvuOZLGpdPU4m6OsByVamOhY9GfDoqJArlZygkeUlrawcTMaWj8Q99Fbd+h4a2gbcgUPi6IWnkRkFwfhEMOUygwm6MJ9QxglAu/ME93dm73v6uxKA+qT++NmdTZraCH2d2ZRNRZtL9vS/FTez7w+8nEl5d8jtqAuoBN6ZjnXdlTYDSDq3zi5cCpsimDMkJk3H/TYWNiVQa6wp3dyZh4hUC5En9HUSmxeSZ/2vSKEN2yPqMcpUAhLtgn+Prju3UABIjQITZ2sRff+ojICCw3H6xsY3GHaMSYErVfs2T201aRp+cC+nynjXxY3/gcO9d4PIb+tVcyZ4npXYpoduQ8Flc0rpSXDdFknaGyOypNUSHxbd4ivfsl50RgH8OelbD8Dpi2U2bvZNJBGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(83380400001)(38100700002)(66476007)(122000001)(33656002)(38070700005)(86362001)(8936002)(8676002)(55016003)(2906002)(4326008)(7416002)(5660300002)(52536014)(66556008)(6916009)(66446008)(76116006)(64756008)(66946007)(41300700001)(53546011)(26005)(9686003)(186003)(6506007)(54906003)(7696005)(71200400001)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zth+invopm8Y3vzecIqQkjF2EEEMB0WwepOHJhsB6Qxwgqwlu85bdU1wXvxL?=
 =?us-ascii?Q?xyItQSUNVGgKZNKAQQEkPhDmC/8CdXgbhqwKKvHOQKZQpkfvvV3UFtcB8vgS?=
 =?us-ascii?Q?G8LJSSL7zk39TXVAqxo7WsBk3tySyxKnMjJ8mfpt3yIUV9llk/edk7iojGNU?=
 =?us-ascii?Q?eRxfB7+4XRsvmzJH/R+kQ7vwpoU/p7ZjEsYLf/RgZi0H4pCTcDSnYnPdvjqT?=
 =?us-ascii?Q?Wq5t1Z8NFzbWHJG258ZeCQlnWzLWHChsbgeziAVYM/mvVKSVAtyIfvFk6UZl?=
 =?us-ascii?Q?W2Bz14zS7Ka1Dm0fApsY+Y+uQ/eNsQJ6sg7Q9lOAcJyvZmU7+6Vo7/UMBhTr?=
 =?us-ascii?Q?nC0B5/RftJ5hntrDB8MxGoTnMDgKm/tX/ICH3T+0woAhC7fuKS9tqJzYnw5U?=
 =?us-ascii?Q?x4McgCYtsRDHQLlPMj/Mko7ahhu3b6vjeoXeMAx+eTBkScpVzxzt3mmx7+5M?=
 =?us-ascii?Q?WceVUUVbMiO4KpswwpaLB98W0LRYGiao+NZVFdOTlOxHhsdNLKSNTB7A8H3J?=
 =?us-ascii?Q?N5l8DE45SUv7rciQ00a4lytwr/69Tdz+LYV3/6DQD5EmVIlYbLK+m3AIjEXG?=
 =?us-ascii?Q?wgtnaSKVm6v1ySxBRMJGnoFz41qwPNAMRRLpludzjfchRRKLxDU2usGNgzof?=
 =?us-ascii?Q?ohVBUJT86XqzT0tZpsYCZG33plQaj7T+lgMP0BnqIFfnkaGyo3Cn3PaotyET?=
 =?us-ascii?Q?qQX/23Ib2PsVoodzeRdFZjYMqBKwqRpDZW/EenMyxenmoEHMMPcI0ihycvXe?=
 =?us-ascii?Q?B1H793Loix0jyG7i7M6+7Vz6q6cZ0F8KGbdZmA1TetQNJnM3vk+f8zWHgOlU?=
 =?us-ascii?Q?avOqkHhhBRmrIis0mE1xauC3mRuYtB1JROd2pl1yYKPEkeuhzsKrlqtk8OkD?=
 =?us-ascii?Q?hu1SGIwDrD3+fg7VSeWRUFoEC78K61bZJ0UXnOAlcb6ZsKyIU3/bOgJSdTYt?=
 =?us-ascii?Q?u4IW7r4y7GEWr/6wIOkefAJ0mB5gTK2CLbHQYer4pAi4dyeFhxyDkXfA68ht?=
 =?us-ascii?Q?+34JMr6UR7i9sSF4AXtAIp6QhAaOK48BhdmpuIkCcq77PkBtWHWEdwpmilCU?=
 =?us-ascii?Q?5zYhIq98Ah8Tj1xcTQkeYz9vUR/5QNjiJRkJyKg2kSVPIzKvipKnO08r+OA3?=
 =?us-ascii?Q?ju5eMgJlXxIHI8nBJDQBwKj/vYaDTvSiHUoBgw5XUNiyHkxsjHgcp2YHnPz5?=
 =?us-ascii?Q?Br32m/O4BYPCScmcejfUYEKBUnofxM+W13k0W2VTTnZ8wBnvXVLYWmTBcgda?=
 =?us-ascii?Q?b56djEOtRUdW6fSzhfV1MLpkrR/EDs2ISLoILufgp2r1vc5o9mPBwARMsxS1?=
 =?us-ascii?Q?Y/yTS9w3UeAfA4YvH1n9gc90VurquuxMAtJ7tgqScR0MXbPXxLLsZl6A849R?=
 =?us-ascii?Q?iu18PsvhLCT7WHFobg2adBlhidiBny4MDrIZQtKfP4fPpWb309pa6kx3/eyR?=
 =?us-ascii?Q?Wlr6BD2GS4NgGR7p3ItoE7xp2AlPmQuTrtHHgUe+zAxCBcWcDzHuzZMteWmR?=
 =?us-ascii?Q?Lc8yeuJbZovyet1C4hV6RqsznEVwRdynjQ36QpzrH4L4dpzZT7oTLZyP26uw?=
 =?us-ascii?Q?afDIdYrh4ITd1qREWng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137eef39-5c73-4377-b744-08daf942dffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 10:58:04.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fShG4LpCUeeztaZdcfrg4sK41b84AktXlSGweGwb0uzTHdfzVS4F4n4RlTg3tMpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 17, 2023 7:38 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; rafael@kernel.=
org;
> eric.auger@redhat.com; alex.williamson@redhat.com; cohuck@redhat.com;
> song.bao.hua@hisilicon.com; mchehab+huawei@kernel.org; maz@kernel.org;
> f.fainelli@gmail.com; jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com; linux-arm=
-
> kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 04/19] bus/cdx: add MCDI protocol interface for firmw=
are
> interaction
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Tue, Jan 17, 2023 at 07:11:36PM +0530, Nipun Gupta wrote:
> > +/** Request/Response structure */
> > +#define MCDI_HEADER_OFST 0
> > +#define MCDI_HEADER_CODE_LBN 0
> > +#define MCDI_HEADER_CODE_WIDTH 7
> > +#define MCDI_HEADER_RESYNC_LBN 7
> > +#define MCDI_HEADER_RESYNC_WIDTH 1
> > +#define MCDI_HEADER_DATALEN_LBN 8
> > +#define MCDI_HEADER_DATALEN_WIDTH 8
> > +#define MCDI_HEADER_SEQ_LBN 16
> > +#define MCDI_HEADER_SEQ_WIDTH 4
> > +#define MCDI_HEADER_RSVD_LBN 20
> > +#define MCDI_HEADER_RSVD_WIDTH 1
> > +#define MCDI_HEADER_NOT_EPOCH_LBN 21
> > +#define MCDI_HEADER_NOT_EPOCH_WIDTH 1
> > +#define MCDI_HEADER_ERROR_LBN 22
> > +#define MCDI_HEADER_ERROR_WIDTH 1
> > +#define MCDI_HEADER_RESPONSE_LBN 23
> > +#define MCDI_HEADER_RESPONSE_WIDTH 1
> > +#define MCDI_HEADER_XFLAGS_LBN 24
> > +#define MCDI_HEADER_XFLAGS_WIDTH 8
>=20
> <snip>
>=20
> This whole file could use some tabs to align all of the values for the
> defines to make it readable.  Any chance of doing that?

Yes sure. Will update this.

>=20
> thanks,
>=20
> greg k-h
