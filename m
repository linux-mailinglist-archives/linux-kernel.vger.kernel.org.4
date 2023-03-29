Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6197F6CD6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjC2JnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:43:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0CB9B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4XfpOU5bVrA5PH4Rn5YPNf3mBsP+vo7li2WzN3Lll4cmBly+YO3sPibiXNrHUvsf136Oh+CDBdnBylilfIwoDAByV2cdm1vZBYVLJU4XJsqQj2+6FOwySRPQc822hweisK0L/QsGf/xgS2NRriup7ThLZG69HgvLnn1kUnxkR3sfINqO40mL9nIYBR4REtXeoeqIw/hmnrkGsvOwEkjWbbG7ROle+5wSftTpjXmpb6wkXzosMeZE/wYqtf9DxjZ1r3391IGc6dPCzWmQoT/zgGj3G7IrkW1N+Z8MROBBkKk1++ufexWpsKtyvBz4jiuiMs/YJy0nOMMnQodCMoU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnhzkfBmDxrA88Nb/xSeLoD3HkFUBWKm09jFl2BtyT4=;
 b=XJSv9ACYlsyXkxNlctSO6hMAwv+eVrYpu8D9b19939glc81f+MTjhK7S2b4arRBJJP/amIWnW9YnRyD6+S13xBvdsohbkCHFtTUme4YCVOa6I1keRJfFrvgHFM6Q+SDwOv2yzNor9oBJDtnMeiIj1v6VxTE2HwyjS32oGDfsyaGXsuPk15jBafn8GnGbA+sDs2VfmdNWsG2n1IScK9XFNu3T5yIxFDh0+ppS2T+VPZUuOD2KL6Rt9lR5vmNz0OTAOkBehBXLWKfDttYuCU8rTPZK5xroLmFARO8eSQf5vmy+5hrfRJ2SEBF6caBUWGenItdJtoSTtu1CUXATx+pdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnhzkfBmDxrA88Nb/xSeLoD3HkFUBWKm09jFl2BtyT4=;
 b=zhQWKcufpuPcwJjKUapiKURBnSNirCKozdQHOsDqzv0CkqP8EsYeb7NoT4C1FjL90TzTSxfE9L5vIkMBSINyPjvOIH0GeyHc3tjfoMPAMoDzKpTo9+OgF0L8wg1LPmzn4C/FaHD8/lDKY4EOZjEvFSshLGTYVLFb2iEq0j1U5h8=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 09:43:10 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 09:43:10 +0000
From:   "Yang, WenYou" <WenYou.Yang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "Li, Ying" <YING.LI@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Topic: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Index: AQHZYeESu1Z/BgjKTUGFWIVG6kMXya8RV0EAgAAB2QCAABojgIAADcWg
Date:   Wed, 29 Mar 2023 09:43:09 +0000
Message-ID: <DM6PR12MB3531933678779C5923989925FD899@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
 <20230329085023.GO4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329085023.GO4253@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-29T09:43:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=494d8e2d-14ed-441a-8c23-7470be41f8ff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|DM4PR12MB6253:EE_
x-ms-office365-filtering-correlation-id: 16146edf-988d-4eec-f29d-08db303a0191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4L9h+byOpXrRqFTXuwTbEYJR7jpeALy3kGVlgu9RoLX3cG8RdTqYVweazpVmT91WhYjPj2p8+WW7feDrCtWxYJIEK+Sufe6IN8fOWsMMZsraVh2DTpa8gqKyNFg0bwG1TsVZJG+O3EN1LbWURMUt/DX8y37blCyrCRz24TEPL/VHZo0TCR+xoCnGCzP8uh09NyJPYrEd99pKdk0+s5Q5GHou+S9yyFyqO65bCbBT8KDg9sT+7lAz//lhF6BiXL619mGjAO8HpsPy8Umu9iKEvhcxZiEn0i9Pc+ppzIyCCGs7BDjwsn4NaTTaXYOkt/mDz8hNQK/C0d5qSG3E3U3EWwM8rDaSbNuIr1bL23OlabOlRFFzsbE6rywVDnFMs4tomNMFZ0yph5ZToWaBZuthPpT0XcIOwZBeeQxm/VxXlM5+mAwEHrke6sPFJiNhNZ5J7y0zMCrjVPmGBmPJsdC8JaoYEtdTBxD0OZhtvKhrO3ey1iTvRDtpTGM29+pKjDJPyjgqbOGSL8luzRsOGDss1Fr8oYyvBWWHN+uI8uqa0pLSBTbz5htrYrhy9xgsuotGCedGbax4BH5H1AASbASKeqgR/E6PDLtIq2P5+QkEjLXcsIIn2CWY01zCe4nKirJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3531.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(2906002)(71200400001)(38100700002)(33656002)(7696005)(66446008)(64756008)(66556008)(66476007)(8676002)(66946007)(76116006)(316002)(41300700001)(54906003)(6916009)(5660300002)(122000001)(4326008)(478600001)(55016003)(8936002)(38070700005)(52536014)(186003)(26005)(6506007)(9686003)(86362001)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/q9kLMu1jSENpW4ILuoXgALw1mjbXlx4SFMfZnNQIvAcwL8xLxW3LpDWV9em?=
 =?us-ascii?Q?Y+ARPIyKyQc1UYV2MmLOtuX5KzOmPyaJCgr8VUfecRKHtt8nlnTRQzxmwh6x?=
 =?us-ascii?Q?N7Db0lFZAJz29G4GBhxbo0sMxcXlVOe7ipio1GCrk+Nr5wIN1TCAwMpFWC6w?=
 =?us-ascii?Q?iNasvpGdWkZmCyEwyztXSYzlPQxLhGdj61ijlJa0XYmiHmQ8macK3s7I67Dh?=
 =?us-ascii?Q?XzdLt3w92hzlXx5eubBJxc+xEdQ/fX7Hi1rxTj6mUs/vzREEPjJ43eGJRLYa?=
 =?us-ascii?Q?2D019h5cm39vTq4m8cyyg2ij4NZhLefsd7WjzMrUdSXgoxIU+55Sx3QgRKtF?=
 =?us-ascii?Q?JQev1m4UzZbxG9zUOwLHzokwousjOqIx9uQaEFxzVvJJGdWBjGyVQQbZ1n4u?=
 =?us-ascii?Q?dWGxS1hI4uERVn27P2yaXZp5S6TL/yK1y91EaA9aRSQTzuDVpy6py1N0mY4q?=
 =?us-ascii?Q?ldkEjD6sdMZPaRhxNnvZsPZYSxEQtoDYk4EglTJr1V2nz2lm6w+61tv6Oj6Q?=
 =?us-ascii?Q?554kfKOphdXvCbTBk6ic+HnU1rqMzkCF8Ib+E+bRi+fzL8QUw5dGMP8ce561?=
 =?us-ascii?Q?yCk9ezEA+DaDlrfHSkQlSmFlnAjGT7JLL+aqRCOrCu8L126h6sSsGL4Y63Tr?=
 =?us-ascii?Q?wQi1gCvUjhaXeSXwyYCHOXyWKZvMXpgIM/duf+w9tT6qOxoNIEL2P3a82EPD?=
 =?us-ascii?Q?VdSl3NnC89NKINFIrCHpre4x2ht3N9itWoEVmG37QSR5WMZRxCeEKlr4W4os?=
 =?us-ascii?Q?3U1MnMzOcSudrSAX+u6U9B0QftZ7FjcjOmTOCH2cUcSeBiqjBoWOLKSiW2pJ?=
 =?us-ascii?Q?ImO/aBqQMUxK48ayiDP5BWsktT2grRsiETrP7JW7dVExvGC0SLIdCEDKNdfQ?=
 =?us-ascii?Q?Fr+GzffqnRzO2jt9WomEIN7urabNDuePZlu7bbSZPmW/eLn2dkTrb84XRzzj?=
 =?us-ascii?Q?Gfi+lXq3Fv37KibiH755KJyBC3jBjqhs9c6Rd5FeOS3Cop4HmNwiAoc7+6aJ?=
 =?us-ascii?Q?fHQQkF6n8PpY/xNFmuMKL9JVJ+vLvHPa8Cq8I0mP8SfqPTikDjvsDzn8JWE5?=
 =?us-ascii?Q?L/asevTQjY/FU/7viPr+iFYIbEAi9dS4uXycLjqkrPg1mE/yT20sIQn9g0Kx?=
 =?us-ascii?Q?pM7xmWKi7lAueZfw46ZCIjfZ6BF/a991TgC+dIB1rx6tPexFS9yQVhmDpLex?=
 =?us-ascii?Q?cMvNZMtHXqqatRaTv838krhML9/65YWy8Bs4u61GOc29h+ArVGkFmj1gJoaw?=
 =?us-ascii?Q?BcK2wNB5ly54ghtwN6jK+DMofh2/yR6rnJcKffYKzT2UMhx/kmfGehjZuZpc?=
 =?us-ascii?Q?LpzHAnn+1JOT3A5HLdVTejC04/d36yWc8sCEdGAWcBEDsk5TresBEsRwtgVv?=
 =?us-ascii?Q?rAdsz8S+hG/tfMO42i61WXKHGgGNAXNQcK7XkhsHGINUrXWM4qRIuwlEwDux?=
 =?us-ascii?Q?7V1yGsZbw/M/x9k/xVewOPAzQmtElblRI8a6w5Cu1ZXPD25r9hjOVXFf5tM2?=
 =?us-ascii?Q?KUWvnjEuY3CT0n3RpyCMWjzIYodMp5chriT/HbBlp3J4sg9JmNVO6dhxInNO?=
 =?us-ascii?Q?jFn0BQ/2Lk1d1D1+QRw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16146edf-988d-4eec-f29d-08db303a0191
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 09:43:09.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh/+Bv6h5DBsfA1yCeimB/7S6T6HYGYY2g54g9wXlN6lv1t3qGa2jLssLFQVoJXvGPfzM5EptY0ej7+PBrIelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Wednesday, March 29, 2023 4:50 PM
> To: Yang, WenYou <WenYou.Yang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> bp@alien8.de; jpoimboe@kernel.org; Phillips, Kim <kim.phillips@amd.com>;
> tglx@linutronix.de; Yuan, Perry <Perry.Yuan@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Li, Ying <YING.LI@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>; gpiccoli@igalia.com; amd-gfx@lists.freedesktop.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT cha=
nges
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Wed, Mar 29, 2023 at 07:23:29AM +0000, Yang, WenYou wrote:
> > [AMD Official Use Only - General]
>=20
> ^^^ that has no business being in a public email.
>=20
> > Hi Peter,
> >
> > Thank you for your review.
> >
> > The purpose of the patch set is to improve the performance when playing
> game for some AMD APUs with SMT enabled/disabled.
> >
> > When change the SMT state on the fly through " echo on/off >
> /sys/devices/system/cpu/smt/control", the kernel needs to send a message =
to
> notify PMFW to adjust a variable's value, which impacts the performance.
>=20
> When top posting I normally ignore the email. When not wrapping email I
> typically get cranky. You 'win' *3* 'I cannot use email' trophies in a si=
ngly try.
> Surely AMD has a HOWTO somewhere you can read?

Yes. It is my fault. Sorry.

>=20
> So what do you want to have happen when someone goes and manually offline=
s
> all the SMT siblings using /sys/devices/system/cpu/cpu*/online
> ?

I don't consider this situation.  Any suggestions will be deeply appreciate=
d.

>=20
> I'm thinking that wants the same PMFW (whatever the heck that is) notific=
ation
> change done, right?
>=20
> If the answer is "yes", then your patch does not meet the goals and is
> inadequate.

Yes.  Need to improve.

Thank you.
Wenyou
