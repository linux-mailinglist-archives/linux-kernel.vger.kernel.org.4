Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A360985C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJXC46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJXC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:56:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB9D6DFA1;
        Sun, 23 Oct 2022 19:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErEefSA7L7yHGLt7TQMCqysMo5dHcq164H0HeJga4aEKoWkTtDf5yIYF/5nWhaNTU9z+9ShCNQX11AjnyXwoydd5EARgHX7KlC0Y1hZHKCaowLbng2KSGhXbAmyJgnVpgGGIMaPe2LD3ztsb1JdM3pqS2BaP1lBIBHVY5IIwomLyVUimDywQMG9Xm6BbRii1yZr8+LubVFH1zcf7QJR3+NW+wzWulKxMFcoSL0cZuS6WpLYdGC7HL51Lz/4owzqrOeNIkhDRJ4QUcFRWOmOt89Cz0wA4DoU9qY7LPvn3cS5Qcr6zii+5UAqadzKqsDkq9bjWmxZy5HLk0VG5HD8LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuR7niVJ6Q4IDOYyWpLlO5zej5nI5tKZR4asyyzNcOQ=;
 b=X5NaaOYNXqtr/vIIexhEgbxorafWtIYr14t89ulKM1D5zYbwvLGsRMGvlwDI+naeYENxZtFkwqpYIBmXV7OQwoqIXtMp7R3Uj3tYLlql/xoPGcrO/1bQlVbKC2YQYFwXhLNedwrNI4hPrsjLLxCZDNRHZZGGJhdbxdW2zHA1CfqQPnznCM5wqITGJWuJqhSTrgM9cqsTsuhKr2MAt7N/sxajtHY2S2m6GyfrtImlSrkzNyYCkGMi2iTo16OHrXGOzCBuOsTLRQ+gVCbrgPU6f/BqAeneO2LUOuJIN6zWZY5LBFq4BhNh1jwPOYuaVmFp4ttePW6c9gZyMWFHDsExAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuR7niVJ6Q4IDOYyWpLlO5zej5nI5tKZR4asyyzNcOQ=;
 b=dvVfVSUdyzBRePNyQhx+IgG2kdrXS2Y0/IZ9dxTK/Topl4C8XE7jGR8XU6rWc4hx0CsMlTVsMfBn0LdKZhhVko2ByS08ihO8E22OkcTBViS2T/XEscjenZ2woc4hQ99NwYBSBFotS459kwtoYqXUFwmvaeFOBwCLL1NLK8tR7vg=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.38; Mon, 24 Oct
 2022 02:56:50 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 02:56:50 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MSt/PlF0KNBQ02nB5ERDMK6Va4SZAsAgAUbdVCAAAJ5gIAA3qKAgASNm4A=
Date:   Mon, 24 Oct 2022 02:56:50 +0000
Message-ID: <DM4PR12MB527822E265E6D6C747C5709F9C2E9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y1Isg4q9Vsl8zNPe@amd.com>
In-Reply-To: <Y1Isg4q9Vsl8zNPe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-24T02:56:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57b808dd-0b49-4326-83c3-2b54ab1e8198;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-24T02:56:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 42f4414b-959d-4043-8b4c-cada9d6303ad
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB6044:EE_
x-ms-office365-filtering-correlation-id: 7e2aa62a-675b-43ce-c8e5-08dab56b65ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atfcwq/w9pg+jGzrYpltonpQDkZwcmhH1wDNHHO24nAph2TD/Dif+b9NZDOoPMXEd6OHrD3D1TxQA5eKm0y+BbzKrM9MYAGI7u96pyZznuTvD1YU8JHQ625VyrmYZ2oE+Vd9blYRWGfaCECoRh1CmzCq4d/TSNQ4drQ5i8g5jve7Ui1Zfq8LOEnWdsZ85YwSPk5pcgucV9QDzG3F9II3LMH8lI2t69Vdqro12Op64Tf9YHoKEuLlxM+1qHrzLuUeG4rQSykp+Mr+/aoQBs4wlFuupZkGqA2MxTIaWX1UMs5UzDcO03VjZVjhwayZJhFlXY/JFsiYTuItbAVLRY3q8tGvmgrTyf/c6enWme7dWfHTZe87dZQnNOTJR1zL3dIfFIYzHsoCpE7QCteG6wcHIarMLNoN3oNSRUp43PMjjgUJ1meCYcLNkkcJoUJorvB/iFk3ThFkRTuXDeXOM0pEFSzo0QZXdnJ55/oA3Hp4RbJMsCSw3edIWufZ6wp/ldoZ7GBrtzpz0YzlGmyg6AuOVhEpIyxXVdSfvLCnfnSDkFm5d3HxJ7k4ZWRMO9CNWS1qK0c2q6CNOxJSzzkDSvJbSD++xCHGo+n9+haFM+sC5YoqUWqtxb5oS7ODueIVB0tFvazWxSOCcLv8jpCAjC+z6C2JP+nd4Xab3h8bhNT2rUeEEMCOPRAH1l/ywVQEz/BGvMRvsL1dHTGFWKr4cAQVQRDN7pohOU5VcykxDVZmzums5squijtW7rhAEpoN0dnD7mDes3mWVw1GMr/u5t3Hl5U0LPXQv+2hAgAcBtuvST9iQ6n1DyZupKPbSRA8K2MLglBpU+lVzECtslpIpKyGjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(186003)(33656002)(2906002)(86362001)(966005)(71200400001)(122000001)(38070700005)(55016003)(38100700002)(66446008)(83380400001)(6506007)(7696005)(4326008)(26005)(53546011)(9686003)(6636002)(316002)(54906003)(8676002)(478600001)(110136005)(41300700001)(52536014)(8936002)(66946007)(66476007)(66556008)(64756008)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/cipq1coti/3ur9L+fpdiFGH1zm0QmIBCMVO6PLLwGOqUFmCB1rA9L1/N0nK?=
 =?us-ascii?Q?rOFHCq5EVlE91Gps+VjQQNkM97ShWR5Xjrwmp3EUOqXywFrZzT7zQGRzZp1f?=
 =?us-ascii?Q?kO370C4hAyvgd9eb0NP1ScUmm0+l8lf2OsOpj/Gs5iWfqceeDE3+KBVzoc0T?=
 =?us-ascii?Q?19uyLMhQQ4g5O1zySALa698DlTqUay1Gel5Hos5aspeVXa+fxD2cGOifXuf6?=
 =?us-ascii?Q?4W9SlV4GVpiHDPHVs71XDQz/tUPVnnb0VHi3/35hm2ca1l98npcgs84sL8My?=
 =?us-ascii?Q?3TdeAdlchicfuHGHus2GQCD6W5fa27Omvgm7mBEMGGKElgfnqybRsIJsq5fv?=
 =?us-ascii?Q?V+nlcH0uWAPS7yiuPRCEfHwak79elyZm9nkYWcXWJvtfpCADRNdgmiD7VDPs?=
 =?us-ascii?Q?f/7fekJsAmGHwKVB7BfOUma3S6G8zFOv1rfpL4JebyvtcwNBC0j7moFqIDdL?=
 =?us-ascii?Q?1+js9e4SvQp+RD3Z4aNIwC83UapfC6MIUYFUQeD8tSFpxrtoYEKUajkdNqYo?=
 =?us-ascii?Q?qX2cC5Ho4a350ALA2I3OKV/qvzV/e0QDeg4zRsb2lsthrt5/UUu4aGv/zyCm?=
 =?us-ascii?Q?lW1Jj1ODSwJ5AZU+wPALJIGpLIXXHN4tkR87Bj7uf4n1q/VF4A6yzGt0dOMj?=
 =?us-ascii?Q?ktTu5IGjw3Q34D1I3ecHHNcnII7rPrFnW6Z7AaeZIGCEf2aVB8PSW/sSAC/G?=
 =?us-ascii?Q?THioSS9TK8W7bsw9YMEBUa6n1no0Ma+yG65CnP27/GOuGEkleinfDx2Pq+vT?=
 =?us-ascii?Q?7ZEtdMheywontXKsffgAfmp8xELlgl+6gI/85sINwaCLOzbAXjJBOcbcC3jC?=
 =?us-ascii?Q?L+0L/Nea0khwmsyW5dabs+0OZ3p9uSZdZCt+RkRDlA8k97d6m49EI1PowFvz?=
 =?us-ascii?Q?33EeJuV2yPCouzXP5UhdIoIvYi4L2Kf/5KsbKAR5Y3QPbr9LrwqNULKe/hLW?=
 =?us-ascii?Q?iPAAtxl0qYLaHcOSu9AK7uTwBiTAYl04dFUE9mwgRgIuHF3kjpbvXogZo34p?=
 =?us-ascii?Q?UNICBHJTwx/juG+UMOX5K1QCLfYG34jDb18SSp5mgZiRsMytQVUWvU/L9Hz6?=
 =?us-ascii?Q?VapeFPMafo7N1XnDin2jR4Xpg/Sq2sLgAA/dhCFMKLLBuIPrHFgybIFCa6R5?=
 =?us-ascii?Q?OUbO1lSRz8XHDF66pgwsUB0gY+qQshOtCBkq+5TO8YyfV6Nq+cQxZ6xwP5qe?=
 =?us-ascii?Q?07Vh37n/F6n376pkDhUNWXBsOucUrO86bSTVp0hrdCPyA49KF8+t4Vwb53oM?=
 =?us-ascii?Q?7eaWtv3DI/A5c+TiYuxkG6u0dIZPpDuYkTP+nr3v2dnYjkojVqkpRBgTtcJa?=
 =?us-ascii?Q?mgkayszq/Hk4MhHt5nmo5gCX+sblw8SfnyjD8wLTMJE30ehfngSkiij3a9ae?=
 =?us-ascii?Q?pS/j0wRomXVVlAXhf/NrAt+1m3TiYHnJQN4pjXQnoc2Vq8Xrs8/1ozkonxbX?=
 =?us-ascii?Q?Mo8NjJbBWjXTkvlc34yPbRAXScaeqy/9hAIob1MNUSAnDIva6SgaccJsh2jj?=
 =?us-ascii?Q?nANiHY+q7wQubyeBdcmmV8g7VF/I+gxAhUpXZdUAz/UFifYzSJkCtYYcfyhw?=
 =?us-ascii?Q?xh+sXy04i8iv/gfWLOcsvhKRMckTYEv6C4GcTaTs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2aa62a-675b-43ce-c8e5-08dab56b65ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 02:56:50.2244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRJ74sx3pbkiJw7LyfDKpWz2FsJ7AGK5APZ62jGm2K/165QZMMpdAw6CkWvfajguazxeNtYHesfOO13PyxcPvw==
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

Hi Ray.

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Friday, October 21, 2022 1:22 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Borislav Petkov <bp@alien8.de>
> Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> + Boris,
>=20
> On Fri, Oct 21, 2022 at 12:05:21AM +0800, Limonciello, Mario wrote:
> > [Public]
> >
> >
> >
> > > -----Original Message-----
> > > From: Yuan, Perry <Perry.Yuan@amd.com>
> > > Sent: Thursday, October 20, 2022 11:01
> > > To: Huang, Ray <Ray.Huang@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>;
> > > Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> > > <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > for AMD CPPC boost state
> > >
> > > [AMD Official Use Only - General]
> > >
> > > Hi Ray.
> > >
> > > > -----Original Message-----
> > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > Sent: Monday, October 17, 2022 5:57 PM
> > > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > > Meng,
> > > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > > for AMD CPPC boost state
> > > >
> > > > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > > > This MSR can be used to check whether the CPU frequency boost
> > > > > state is enabled in the hardware control. User can change the
> > > > > boost state in the BIOS setting,amd_pstate driver will update
> > > > > the boost state according to this msr value.
> > > > >
> > > > > AMD Processor Programming Reference (PPR)
> > > > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf
> > > > > [p1095]
> > > > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-
> PUB.zip
> > > > > [p162]
> > > > >
> > > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > > ---
> > > > >  arch/x86/include/asm/msr-index.h | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > > b/arch/x86/include/asm/msr-index.h
> > > > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > > > --- a/arch/x86/include/asm/msr-index.h
> > > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > > @@ -569,6 +569,7 @@
> > > > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > > > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > > > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > > > >
> > > > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > > > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > > > @@ -579,6 +580,8 @@
> > > > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > > > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > > > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > > > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > > > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> > > >
> > > > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > > > MSR_K7_HWCR
> > > >
> > > > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > > > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> > > >
> > > > Could you please make sure address the commments?
> > > >
> > > > Thanks,
> > > > Ray
> > >
> > > If I rename that the MSR definition string, that will cause lots of
> > > driver file change.
> > > So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR
> > > is mismatching in the CPPC Pstate driver.
> > > If you refuse to use this new one, I will reuse that old one.
> >
> > To avoid changing too much stuff at once how about if you give an alias=
?
> > IE something like:
> >
> > #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR
> >
>=20
> The mainly concern is that HWCR is for legacy ACPI P-State control not fo=
r
> CPPC. I talked with hardware guys before, it's not suggested to mix them =
up
> together. This register has been defined for a long time even before Zen
> processor.
>=20
> Thanks,
> Ray

I have removed the code not to write boost state to that MSR, just check th=
e boost state from the MSR bit value.
It will not cause any problems, I have tested and confirmed that the BIT va=
lue will be changed after BOOST ON/OFF switched in BIOS setting.=20
So we can just check the boost state here for pstate driver notification.=20

Perry.=20
