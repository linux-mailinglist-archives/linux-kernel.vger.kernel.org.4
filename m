Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EA6265B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKKXsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiKKXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:48:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EF836B0;
        Fri, 11 Nov 2022 15:48:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfm+a85gL8PxNfgCmYSor2TsTl0IFYR9W52D1uiZI17l6nZbIw1tWWWc0AMjQv0ejPvMpOpqsKjLEEcCzwMznZPbmsm4XHDgjXkTi8+HHxRIz3C6GjhBD9T+9bBs543ojAQfJILtjY26qXRuSqepCBCyLoo6D1jJSsqRqCdpSCKOf1GEH2HSS/5SSP6gpvIA8fQTrNkKo6QsKP/lfdyM3YFc3UkxH4lRqxBOQDOfGY8GBZ28snBtskELb680Ntb7QR5sspO+CI3KzrmdK+zZIUTdQBtv7IcddZLAV8lB2TKYpk8eBfS9BvBK0Fo+Bq5ccvikBznqqb/qgLfvBkNILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQqKxKqnD4HYkhDurFBNGnEc541UyQEshW4zctdhutU=;
 b=bX7oANoUbu65SoXuZgcc94cwQt/fOBWUT0qHXF1CkUY8Y/xq6Zpm694qTrS1mHLYctfPHwd3WoSoXiZLIDQ0t/2PSwUtY4HPCX2NpHGILUvD22sszTEpsra0ceYvdV3UD7Xa42Xw05im99paE7ChR4KB17kgep0c8r1VVzz43iEaSb8IgihIWl6M5OzY5e6/SHtcHPCShbWO+l/NefDx8F4b4gXzqz29LWBDNQbag9xhLKDBfU/2xphB252obumnU9IFzyrPd7hq7gXtJDB4TFHtj/JBBfVSPgvQbCPfa7keqxMn2zkO/pF6c1P3t/Rn3Pt+UH0cLliZh8KwpVI8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQqKxKqnD4HYkhDurFBNGnEc541UyQEshW4zctdhutU=;
 b=pvyYfeKZrFSFjH1b/Tacmli9oR3sYCF0rPD5QOtcQyM9xQY4sPzPQPcmcRaUFF3Kdd9pY98Q3BtYd0fJb44ZWcmlXWNOgK4fojogEpi8j9E6D42EQXKvgvUmiWsgp1fCXHCVM98C7mmIaz6NK3TcPEPjT/Nre63psU6akZ0J+oXBRZzSQb6eDTU/4DzqoYIShC7j+edi0bxQjjS6sFmRqjRq71XH10PCZz6Bcj+OTNAYI2DK5uOsvKSKHB2irNpqcah5edvxIRLJrFkX8eYMxvSLFlpacCbO+BkBjqj9C9laHPMQSHjdADRa/RhA6naHf16GavOR2DNImD7eqOCrVA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 23:48:17 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4%3]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 23:48:17 +0000
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
Subject: RE: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHY1HVBF/GLNzqT20exjr0smAT30q4z2SkAgAARs8CAABIIgIAGqaxQ
Date:   Fri, 11 Nov 2022 23:48:17 +0000
Message-ID: <SJ0PR12MB56762D3DB3602D161456003FA0009@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220930023443.9463-1-bwicaksono@nvidia.com>
 <20221107155311.GD21157@willie-the-truck>
 <SJ0PR12MB567614CC049F93584631DFBAA03C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20221107180104.GA21769@willie-the-truck>
In-Reply-To: <20221107180104.GA21769@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|CH0PR12MB5203:EE_
x-ms-office365-filtering-correlation-id: b12fd5a9-54ef-4e55-c7d7-08dac43f34a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ExgkOUEZ0RN2lEZ5DWn0Oo64tenM+gnOuqnnaN/FCWb5A+K3eofJctOnvpY3NGBj+P4HlOyKfEp6GoQrWELRgJ4oqfe8PDJXrZhoMczaJYEm+RvfOehhD8YGQ0dk6Lzm/oRXajl5rosAzyUAXsRYBLnVwZMppVOG9RG/LtdknsGeUnntM9Y4/UgUq0v8J0DRFVGSRWjSUkP4AxzaRZobWuM0/wvwY4oE3M1HqcHNxep+KSf2iJ6snRhiL3hYbRRkNZniJAkE3pgymt4usp3R1cXSZurCSWdE4x0m126+9yA62Qjk3+F7Aokk9YqKuPzuaJTyWMBvP5s8blbOlxJQbU+FVshBpOW30doR8/sDM3KUjPUEpDql6WvSq0fZ7x+Tb5bpYInbckjI3LlZc+UsG7bGBGRRC9/La43z/ZfhFJ8bzuyYM8VxD+dFjX0to2vENJOgOBcmydOi6ndWuGs4KiIEFbo15SGOa11TgoV+KnlykltmD8v/GEvO1IPkZ9XA80VVuTuJU4ARSk/ZP1FHSxky/hDLfXaYRLJx+dl5MOzSXJOhX6uwxcVUqDEj4V70TY+7Z9gbiQ/W4nvoLjuXrKSIY5fpBt2418lBOm5/UMQUu5VNVPNK4p66AWi5o9mJBVPgF4C2hr2ZIDeQLJOGU62oRW4GvBGtzy8FApHpRK3ITqYLLZEdUPfFzCoSX1D/wuZ7DPMzA/UMYFHy4EjKuSDY2m84G37+yolQhvm2qBZTDWCwShmBmhM1w51b1R7vRAvakG5vpnIVk2o+YgusgcrIaaG663MTX17Sl1w5hNLuctiv2xW25Jb0q0w5WVux1apNz4xho3lYT5m9+sBYLBuehY9o46Flluj3fmkaHzKtRZWrxOSrxKEB340jsHZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(6916009)(316002)(54906003)(122000001)(86362001)(66946007)(66446008)(66476007)(76116006)(66556008)(186003)(64756008)(8676002)(38100700002)(4326008)(2906002)(7416002)(478600001)(9686003)(8936002)(52536014)(71200400001)(33656002)(41300700001)(38070700005)(83380400001)(26005)(5660300002)(55016003)(53546011)(7696005)(6506007)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w7uXHIflBFqeDbjGc7wpzsq+x6te4zsVDfM9SqD5aMULvGGQPLqJhfAwXtGx?=
 =?us-ascii?Q?3pHckRHsm26KMFpp31kTRGJ/udiOmHRXbUQkxLJqkcJWvTc2WGdT1K9wFbFT?=
 =?us-ascii?Q?AWXJFT5JdN3StD2rsb750fjeGU/b+2rYRI16F5zPRZvbI7nYJ4Vn5d8Mday7?=
 =?us-ascii?Q?7QJYV+Uc4+SKWaB6azuWG2ab84VAtvhi0+T1v4+l5yuI+n8dYWs8FLZ6CnpM?=
 =?us-ascii?Q?6Q8Xzorce2dYemTONcsZzw3R09vl0M262YrpFyOnFDfQ1x33s3H1B0prQUtK?=
 =?us-ascii?Q?7oQP/SjTI5HyAlO2ZnEPtbOxzLy22AdOpT/fcBCfJZdIvRGuy591GCqN/RH3?=
 =?us-ascii?Q?4ljUl2OVnuRWWjdi0nkS5YLaUovPFgadplHzQV5OPDErwjMd1Vj/zWlCU+fV?=
 =?us-ascii?Q?NOgi63Pchc9R5Kbo3s6t127kFrGUWgmAaNY7OZkTq0NyYGhZ2Fn9C2ChEGRQ?=
 =?us-ascii?Q?nBnhOrpzvAzlO+TDfl3aJcGPYNtX14hOXoh+uyCffA932Hg76FzAiUAksPkv?=
 =?us-ascii?Q?4gbGJM3h9SSswGmPlk0S7dD/CVzFzszRrOQNTXVHy3bDBvGI2pBGpWlpaoN6?=
 =?us-ascii?Q?2ZkWc25Clk+V5iOW0xpwcpKwYl+nsHKtBWhFTc9ciASEDM+pfx93pT0zgnes?=
 =?us-ascii?Q?hjwc8Uh4VVYRZ5FCB/VsuC9M+SGI8A66uCemm9i4IzYa5jKaiid87QLrbChV?=
 =?us-ascii?Q?vMD+PPsq6Y3KCjbKoLJ4YBZikeHFx4675+hNelWff96hjezc7ZpwpbGrnYa5?=
 =?us-ascii?Q?bvtw8OMVISP6YmAtA8pRNyVKvbQSrAFacsDhplJNAb2BlGuwN7pDdV7THmSc?=
 =?us-ascii?Q?WJH1HxWjNjOxumB3zz0h0wfs2OJx+uI0dskVfQDUD6ArAnEEoaBVD8c4KnNQ?=
 =?us-ascii?Q?61WzUnSce2IwEryYejlSGZqKS+P+c6PnLlVTQZ0T2bulkt8XrUKd2GrA8wjD?=
 =?us-ascii?Q?JepT23WRuLG6/EPhX7NYX03oB9r4MxHkKABN+Nki20PY4CJe/Im4TR9E4Epq?=
 =?us-ascii?Q?NCpkhrSRZI2Qt9YTcackvzckjwa4Q9KWDqaQJtXf6x5t61WcHIEOgJDx0A5a?=
 =?us-ascii?Q?t366iTR+P0zFKoK6kri/t92bclArhY6BkvaKSgl4ObRdRgX6smtTCEEIIOq9?=
 =?us-ascii?Q?jfwxKRelM1v/ozNUZSm0iGsqVcKYXQHjy2hDpTMI16Wp8zrr1fZoZyapXP7F?=
 =?us-ascii?Q?dtV8JB/pGxdUSDRLpbBBMyDbOMYcj2O2BDUEM02vSb7MxsG9uHchaul/ju9v?=
 =?us-ascii?Q?V/ObhtZNZJIU+heL+gy8fsHXQKCDjk8yNMrmc/MW6MiCXNL4fuL2JUSLPXgM?=
 =?us-ascii?Q?S7PT9ZHlaMKTbsG5HZJXSVBO7MFbK5rK0DggojEnzekx9P+c3lMex+NoGuy6?=
 =?us-ascii?Q?D6rw4AhYrsX5cWBvjBoqqEnrYLZvUEwHatER9INu1ET+C+TuGkMD4i6LPyjl?=
 =?us-ascii?Q?ecmQmPaEGolrCcyeqD9wOByh7K4aKcM4QI0Mp6N/eAxTxF0DDHpAey/OiI4U?=
 =?us-ascii?Q?yhwT8D1Rk0HCywYzU1Z8BDge+XFaqqgvEtqs/lUevL+kRFMHFGgSKtVJpLHu?=
 =?us-ascii?Q?4C+Q5T6F3NynpYxHiFSk7GzqxlP/U82r/sVBL6tE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12fd5a9-54ef-4e55-c7d7-08dac43f34a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 23:48:17.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7UJan9q+27iC6CQA1lg/gALqZLI6Q2aY9KYTDRoELLEgJgAtA6HJcpKkUQ1fkR3wokapJXj6WqlvIZVBhPW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Monday, November 7, 2022 12:01 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org
> Subject: Re: [PATCH v6 0/2] perf: ARM CoreSight PMU support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, Nov 07, 2022 at 05:11:07PM +0000, Besar Wicaksono wrote:
> > Hi Will,
> >
> > > -----Original Message-----
> > > From: Will Deacon <will@kernel.org>
> > > Sent: Monday, November 7, 2022 9:53 AM
> > > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > > Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> > > catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > tegra@vger.kernel.org; sudeep.holla@arm.com;
> > > thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> > > <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>;
> Vikram
> > > Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> > > mike.leach@linaro.org; leo.yan@linaro.org
> > > Subject: Re: [PATCH v6 0/2] perf: ARM CoreSight PMU support
> > >
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, Sep 29, 2022 at 09:34:41PM -0500, Besar Wicaksono wrote:
> > > > Add driver support for ARM CoreSight PMU device and event attribute=
s
> for
> > > NVIDIA
> > > > implementation. The code is based on ARM Coresight PMU architecture
> > > and ACPI ARM
> > > > Performance Monitoring Unit table (APMT) specification below:
> > > >  * ARM Coresight PMU:
> > > >         https://developer.arm.com/documentation/ihi0091/latest
> > > >  * APMT: https://developer.arm.com/documentation/den0117/latest
> > > >
> > > > The patchset applies on top of
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
> > > >   master next-20220524
> > > >
> > > > For APMT support, please see patchset:
> > > https://lkml.org/lkml/2022/4/19/1395
> > > >
> > > > Changes from v5:
> > > >  * Default get_event/format_attrs callback now returns copy of defa=
ult
> > > array.
> > > > Thanks to suzuki.poulose@arm.com for the review comments.
> > > > v5: https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1=
-
> > > bwicaksono@nvidia.com/
> > >
> > > These patches no longer apply. Please can you rebase onto -rc4 and dr=
op
> the
> > > defconfig change from the first patch?
> >
> > Why does the defconfig change need to be dropped ?
>=20
> Oh, just because that file is a big source of conflicts so I'd prefer to
> keep defconfig changes separate from patches which add new functionality.
>=20

Sorry for the delay. I have sent v7 patchset with the rebase to 6.1-rc4.
Link: https://lore.kernel.org/linux-arm-kernel/20221111222330.48602-1-bwica=
ksono@nvidia.com/
Could you please try again ?

Regards,
Besar

> Will
