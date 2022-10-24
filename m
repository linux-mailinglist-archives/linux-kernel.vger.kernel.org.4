Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584F609862
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJXC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJXC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:58:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2D73902;
        Sun, 23 Oct 2022 19:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma+k57ugln40vF36wPtTCt35TXdOqMNdfOtpmqu1Glze8qM1IFf+6Vg8qUAiw+atXH28aRkI/dQgSisETivRmwQ4wSgPSLtPngBJ7eALiA2I04oN4mSvx0mZJBSdN7SK8l7muX1Om4hQv9wzfk7/qIJPrnUtwis2TMNYxcnqpFndl33BxSGrS8wt/6eOiAi3vJwc81trup2qvv6n3Z+37UfB6rHt+XpZtxqZJaEh4YY8Lsvi+2IWJoStseete0sRW5QBgP6QA2KZOATB5uSVS5sauzJMyYWG1nA5DdeYFAF0U/FoieNIZEBW49St9MnEmLzNrs39dsz+1C7ErFCH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg02wMxIUqh8qn74WUs3764KHHD/5KjcuTOl8ys+8l8=;
 b=nSNAMDh1lQFul4JOpubSjhfC9ed2PCjSe0rlE1u8/5f5xJ6mCcq3XEoSy65u26Ettri1mOs3MXuw//YTmev7QDzli6uV+eCtJiL16NChOGQzsDoMaH0NHpTkoIB3wHPiZwgi0N5dpsNtX16XR+vRn5o1/zdkCSfouq5APYd34qy9R2KCodMxeC89w8Xp0J95Xy6Cj0vIzNkewTYS/pnnMM96z02kb62PZVKgInHOc+u56nqOd0y9eNQVAyMotu/lNehCloGysumNei6S2/D7zsCsBrYG8mkbybmI66nwDPX3MkbUuSQBuqewrDTb4b7+ynGZprcqhui3/K41b8npTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg02wMxIUqh8qn74WUs3764KHHD/5KjcuTOl8ys+8l8=;
 b=nlZSOuGBG8fyYjQnW+S+z1+Jf+c8LBnL45DKoF0iJrwWpL4loOUvhfhxTgbLqMKxBCI7NSWpj9F0unmN+CQ5t9mlQczzyAs58LarCQH/RP2ZvAy860/msTr/snohgCc5dUayKTh19yWJddW2a0zJ4bwHAviXHB5uRVUGtwGd/7M=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.38; Mon, 24 Oct
 2022 02:58:08 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 02:58:08 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MSt/PlF0KNBQ02nB5ERDMK6Va4SZAsAgAUbdVCAAAJ5gIAA3qKAgABHcgCABEbuwA==
Date:   Mon, 24 Oct 2022 02:58:07 +0000
Message-ID: <DM4PR12MB5278C8AA82736EFB6CA956749C2E9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y1Isg4q9Vsl8zNPe@amd.com> <Y1JoXmC+sOSxZffT@zn.tnic>
In-Reply-To: <Y1JoXmC+sOSxZffT@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-24T02:58:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=13cb304f-9d4b-4599-a2b8-6ad3140b8674;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-24T02:58:05Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f2d09424-dc92-42fb-b2e1-1599bd080c24
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB6044:EE_
x-ms-office365-filtering-correlation-id: d9fac2f2-5824-4d39-59fc-08dab56b9433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6ed5Vos3mVDl+6yAR7mCWMKx5ir91jqdTYTg3pesgTjy/wyOfistGCfgpVYyBKm8+bR67wLivILpxR/3Zs7WReNXymdrZskl9ZQcEgt2MRxj7AJeOqBEA8cJcAGC+MhlpmZ4GvX0xFrV6lL1EJ9uwrO5uemPls07zgqcTUtKysVIVhA9cQwpNQNZFlr5OJyNAAlaemrt2qC5q38d4jnyMVuHqV2fG8wsytBROzxkwV/SPIGp7fyDbc0CFpnJd9cHGMyEixiT+fd9FoYbXh3ppv+c3dKfqIUP9wx7N+ibCSky9ZTNrbo5ZZAcg1jFCQdP5GLzE8/QQETWW76VWOru7/m8qhLXaRPuItuwMUvRFEaVPrEowVGzQL1+pAaGrj1ffhRN8dVYulIhGxjZj9G3/IMI7cZPlWmSWg1O0nbZAFTVokflTXJAxdo7v37OBgf1My6TVWptcCo4hhobi3Zt5peLB7PxbCVwwi+16c4VnTTNxIo1eiKlyA6v4RbZeCemCOXN3aJM/pAGK96szgkaiegPEG7/e2LZRyqttXzHiNOkYJRIiB2Nz47KOcm83vv0qctczWv3vmheWRn5Kwp4X/9sGls8SLX9iPnd+y+u1F2PM8KK68N4hQ4AhWwTX/wwY+xsQuGraVl3SCFj6AwDWbfL548z7Mz+wBUUsjACSh3JtAvbRIDMAdAe6IdT+aL6gXRdMiQchVOBR6j1VOMNFOJkZf/P9/ehHCdX8o9SuzP339pmgr89uLdhGdUZXgvFIDTTyYua1/ur4KZTd+SUsRvIvBFQB+tTvItrsSjk6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(186003)(33656002)(2906002)(86362001)(966005)(71200400001)(45080400002)(122000001)(38070700005)(55016003)(38100700002)(66446008)(83380400001)(6506007)(7696005)(4326008)(26005)(53546011)(9686003)(6636002)(316002)(54906003)(8676002)(478600001)(110136005)(41300700001)(52536014)(8936002)(66946007)(66476007)(66556008)(64756008)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?puOL7L7/FAeCYDkLJ7KOOT5TuI/8LGJ3mxMO1f6HcaY68BDp6WkbHImnCNaw?=
 =?us-ascii?Q?8NF2Z2LUDmgOaWAu9BA8yokHGV8stIUa5psxz1yQVwu6H2EK/6xi7YsVhg3t?=
 =?us-ascii?Q?JBqGd4VdbsYOdoVj/9C8kBq0TGHy0Ql3BvanGmKs8hz/KXQMq9kTTLiaQQ5z?=
 =?us-ascii?Q?Yz+6u5AePUguXKuNJtBoB1lIfRa+n8pvivCkmkAhkJtZiNdxsv+sm7LZlGQl?=
 =?us-ascii?Q?CQCBncBSxhvHm8WPIOp44morE6yyDNWlgUaKAU6Kj2fs0goDgGeFlJwipoIR?=
 =?us-ascii?Q?fJq/l305Xppy3UWSpI2647rVGppNqG4NkqycBY1S7mJpfI0nnTgR7lywJEbQ?=
 =?us-ascii?Q?58mDpnpFiAsCKiBovChEihbpMyxgl3Et02/rWiZmjtaVulPorFZoyMJjwiae?=
 =?us-ascii?Q?KI+a8TOTcNndlYT9il7zJYTNGpk7uuSWDiH/ZakN/+L624vahqpuUJwOmKPD?=
 =?us-ascii?Q?P/Hgj8uT8WEI/HKsilRqLLwIHcBKj0xf4VE1FnGQyRuNuCIW6My9LMWOVidC?=
 =?us-ascii?Q?BarQE/dnESAzS1S53WBLo8+8E6sOVrYPxvLakT20LVha/v342bEgfJZP1y+0?=
 =?us-ascii?Q?2W2yH/kSNsGUQVFkjXQpwGG7piOvbhiQ+gxrdOiFAXTmTCuj9cm6kjJGEBZZ?=
 =?us-ascii?Q?GaOPi/N5fXPl6s5UN7D5q1a32mBehwxrO5jXKKWOqmO6ucEIDQYqqzhQNfpn?=
 =?us-ascii?Q?0UeE3DARyE8lXTYu9ft5D1aJOrt1FmEu/nTbvXoVD/udCGeRHDLwCzodONJd?=
 =?us-ascii?Q?aVSrsHrsk/z9vFJoERY0x5pQ4EyOnzimuvggneenEz7/BBA2ap2wtQyqlkQZ?=
 =?us-ascii?Q?YYGmFDBsoRZ+ODxYSUoVW6b5QAr/+Y1r/1H6eQ+JaLljICMoTkvC0K+qTefN?=
 =?us-ascii?Q?Pa940vlbDeRxpKsBR69C7Tl0wgmQOvo+t49ugxF9vvMmd8uY5EJ4eFBHQ1/A?=
 =?us-ascii?Q?8jiu5A8uVJs3oTWiC79QhCd/dSrL3GlCUEptMrBHvogce4wv/PPumltNNxpy?=
 =?us-ascii?Q?iVRaGbDp/Egl5NE9c6bL/XQN4YfG2Jdx8epmuKhEiMKeO4lYp7sLz5qKZzHM?=
 =?us-ascii?Q?Jt1IBSAMcGqyXGbKGf/Sp3LU4PZ9Bo8btr6E7O92cuMz6wErAMdTtVice/Jj?=
 =?us-ascii?Q?tAbp4PifzGz802m02iJK4BtFT8/9LWmH05F7A/txWAAfIeotEekVYZ77zEIr?=
 =?us-ascii?Q?yykxS9u0XmgC0Bf8lpgq8W3uiMd2+LMQHInsokSuJ5b6zSbQR4JXU6hcc6+L?=
 =?us-ascii?Q?xoi7G5drYNRPDw/CyEQPIWn88FqBFAkdkjuSJGbQ7JF88FAxManx8L7M3Ee2?=
 =?us-ascii?Q?aQ9QqHkWAJlbdjQxuafsJ2iUc08cBhWZNm77vcagH1K//dEV2CQW4byPz7xL?=
 =?us-ascii?Q?Ye1SAVbcSRyaydNQ+nLLnywi/mVzQRa48rAtOz/P8u95KrruBmOH/qSY2KmU?=
 =?us-ascii?Q?caObjgoeWGHyBQlV+Hg5DXOp4GMWv3zIgvMKmsRi+8tDDc0y2sv2tt2rJF/K?=
 =?us-ascii?Q?2q7OWzUCJqvDUg8x/1bYbcJALBevWBf5SVmesizU/JGrzgsI6dmZtWTeLzoN?=
 =?us-ascii?Q?CODyVvaFCXG9ljN9NRPe6Q2Nw6MXlqfEz+sCdxUK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fac2f2-5824-4d39-59fc-08dab56b9433
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 02:58:07.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLFO8bfBraIk75cuRbDnEQMsYjTMFW0+Aaybf9CfE/yskhDnMbARYziG+9A+gfbD0enI1nrzQT8u6XTtLbxkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

Hi Boris.

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, October 21, 2022 5:38 PM
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry
> <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On Fri, Oct 21, 2022 at 01:22:11PM +0800, Huang Rui wrote:
> > > > If I rename that the MSR definition string, that will cause lots
> > > > of driver file change.
> > > > So I suggest to add one new MSR macro for the CPPC, the
> > > > MSR_K7_HWCR is mismatching in the CPPC Pstate driver.
> > > > If you refuse to use this new one, I will reuse that old one.
> > >
> > > To avoid changing too much stuff at once how about if you give an ali=
as?
> > > IE something like:
> > >
> > > #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR
>=20
> Why would you all even think about adding a new name and not use
> MSR_K7_HWCR?
>=20
> The other code uses it just fine, do git grep MSR_K7_HWCR.
>=20
> We have waaay too many MSRs, no need to unnecessarily confuse people
> with an alias or rename stuff. Just use MSR_K7_HWCR like everything else
> does.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20

Sure, we can continue to use that MSR definition as you suggested.
Thank you comment on this.

Perry.

> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeop
> le.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D05%7C01%7CPerry.Yuan%40amd.com%7Ce3d156c553
> 2a490a2f2d08dab347f1e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C638019418849896672%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3DwVEYx3BNksqXxaycPl81BjVotrWMlcJnVNdbFO7bQto%
> 3D&amp;reserved=3D0
