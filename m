Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610F6471FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLHOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLHOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:40:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F504299F;
        Thu,  8 Dec 2022 06:40:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI2rf0aqaklL+uHodRoQDYrUOE2FXAygH9ANH5kRFbTsVod0Ao0AI2hvx/aH8dYvVc6iyfd58mavHDk0cuuFDepA/WdLckHXeiFOBOn238FjiYR/4oiTZmgR30nDZx700bIkYAkjMSlZjOWylG+qjQyDOuev9ag3OGG5Ir5gsMspUVDHznaXqm46BiddxMhMbZk1wkF+Hn8p7/xk1jFR9SzHvb5zPxPQcAmEe6rfmqOweBpXZi1ctJYfEtElcUODO0KTjZ2A+pJK9g1pMOV6JPpt7OYl184+VmWSfaFsFTH8twCfemEa4xLd0epGoKFRMqeVJcTvl7AdGMgfQidy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Mgvz71D2VVBx2pWZe8TdrzkOEpK24mA3cnlhi2aEts=;
 b=EnFGEAUvhmCjsRtvqjUm9z+PLvRT3SgGdOPwIHGt6kCcWkQwWMvHIn855cb9vjlecAP1SRNzdJhuR9OJMtCHeQ/g9YhSLUUDl7T4I795eXHGDkFjT4wrWV4G4PSe4B4STLKfuq3W9Auz99kuoTW6TJgeMo8dJYfPfTekDDRMFFLOxWxrd4MP58Cfadktmcu+fa7yi2DO+y//P4zK6hy1oderA3N65auRs3khP8Me7UJGtf7fbtX+xPLfkvywUrV+8PfqI6CNVZO08EPXHvf7jCN7/fzeSXvIWQyeS9b0ycSxbNIG/ZmMonX8b0oJk5ZK9pdgITWnBhGKxMGwcRHC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Mgvz71D2VVBx2pWZe8TdrzkOEpK24mA3cnlhi2aEts=;
 b=FyOS1UVe8725SH/WqpiCwTnae9gsQ1vEUW5RtEpymcL5OFqb9gxWqXs6JYtM/Tc10+kYvhtQ81jifFh98kmNce+L2E+zkO8/G3xEnL3oyLG3lDbyNM35VqLJ5/o9TSZjXc8nV4oa7rprq4BYDLZ/ttm3ZdTRoJepcdnAspWTLqU=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 14:40:24 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:40:24 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZBiLQ6rZzYmBFTkKNjTIz9JAdfq5fMtqAgAAvbfCAACM3AIAEbe3A
Date:   Thu, 8 Dec 2022 14:40:23 +0000
Message-ID: <DM4PR12MB5278E435D3DCF8AAFF3EDF539C1D9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-4-perry.yuan@amd.com> <Y43aq2gMKnFRIhxh@amd.com>
 <DM4PR12MB52782BAACEE08C09D704F0BE9C189@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB6101CA08E8D0BB0B43420FC5E2189@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101CA08E8D0BB0B43420FC5E2189@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-05T16:42:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9b83cc6a-25de-4115-90a6-c882a1c6dbc0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-08T14:40:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1a041d67-3db1-4dda-8c50-7533554732b4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: 5f210a4b-48c0-4068-f966-08dad92a23d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SThLeT3ui/GIbPXemubv5H7UCaNxLyrafqzThQ3jSXZIq1+cyVSJIbyZazMeUNwRooDeiiNG47HPn64B3aHZUI/Kttc8wjzLPAay6MZ3abMNRL9gCFY2Ti9XUhFnDeN3+8aiM+7iI8OBNurP36OOPgah0KLRr1Yaipcm+x20ipvGWv2ib0/xHpygHdalMkOSawCXgMesmBM6vzWbslaa79qEfHLn4I5GrRYwE36cQqJ8KXAbiyHfd4nVDv8U36ChY+tNLNDt55GFzFzPrsngx9Tk6EYbJkdc203juaRewWodlu62kfBMb3cGQje7KW8VpAaqBTPBP31rrpqdOg2OmiUUMrQ+9HeJDj99rQK3InUqyEtOHCyn4g27+aCCmpJ4yv4uUcH372YjaIKZlfWmFnb7UrxnoonM1kWM4EqD7w227JzGiwFYzsGV7TfZxp92lWTnzlY/MDpb58fBMsBQTC8TyBpCDwESlxoRulaUStwPh162EZYSvSJ1Z+ymTLLwtVimkszynpKgQf6bK4Rh05JNFF4zeVSVJob7nJug6Zd0gQ4712X/XDIQKuP3atKmUW5XXQ1JvcwEGAdX8hAhlWQBEl+Io06zuxyHcxfgG9H7VoLCFh/RXca7hfKhrtLshb8ZlAL78sJG6hhbeXVEbi5kuTfmWoZxNkh8TgapIK41cU2n+bHIW4bP8boLUgJsmyrGdJbb2c9NNrxUt7bQ5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(122000001)(33656002)(2906002)(38100700002)(55016003)(86362001)(8936002)(83380400001)(186003)(38070700005)(52536014)(316002)(6636002)(66446008)(5660300002)(478600001)(9686003)(26005)(54906003)(71200400001)(64756008)(4326008)(41300700001)(8676002)(53546011)(66556008)(66476007)(66946007)(7696005)(76116006)(6506007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?arr6i2x6JiCECSgvyt9Z/TJ0atzvRgZyWw4D99cxeAaugvmK/f/Qf+cCsfmo?=
 =?us-ascii?Q?W7Dqp4mzFifLHw4jSnKYQEpDHWbJ3d6jiygm6ZZMApdhEa6MEjGtFQAefUQd?=
 =?us-ascii?Q?z7ppDo1mh18jfI3aD5iZfkYy1+fAcRfjCD722Kt9wcnByjMUmCP+Fxpddo57?=
 =?us-ascii?Q?LAg6iaDeTUrQ10wnVV0KpLFJvtWDZ2jTS/ffMju4nsyVdTzO7vW1yfm0FWck?=
 =?us-ascii?Q?7TdJUM4Ylgxcwb1mxbV4FlhluSLU6cgFfLMzh2v7jkiG1sEx/Y/gCkq7d8Sb?=
 =?us-ascii?Q?y9hitwYC1eFM2+SwvVYlgKE6Xb81b5DOkVH+wVKtUmRvMpz8WxIKh1sqvc4I?=
 =?us-ascii?Q?Ppx7SR4CHJT0m9Ldfx8SPobK6L5Kt9gHybdbXIwDFlHkx9mGvChFxWH261eD?=
 =?us-ascii?Q?+xH2Dwu3Zg2FW+/o1h7Zwk2qoJd4/+sMFf3fEpfiqQYpF9a849HGBObtX5Oq?=
 =?us-ascii?Q?vxWadBfUuxpSL7F1tXJiAMcfQv9a8QX0rR9gDJ9M3XMKoHjjRzn5eD+MMUqp?=
 =?us-ascii?Q?DbRO5dPIgO0dfYQ7ImyfgBfJO+ar5OhWpvcEsrwme5ohpLGw7wiHcirUVW1X?=
 =?us-ascii?Q?tnd1/mmWh3u5OvC4rj620DZXywzb7nTJZivy8t7OK9f5mlHfVT0XPZ/V7Ity?=
 =?us-ascii?Q?yN0JtPO0GThZRYTCEszKOIKJDlPiiMLI/BQeGshM7icn429qXi0+n2VMH7GD?=
 =?us-ascii?Q?wRuIztSg3Xjlkfa6w4tfVhHeQ26yZfqMhnngJvDMNMHV0/GQXIik0fNSE20L?=
 =?us-ascii?Q?QGhEEIYPNswhj9uGEnc/5SS4eEaYx4F6GVYhH91x4SwdHPP0zTBVyMRAfB1M?=
 =?us-ascii?Q?K/vhyef2Stn7FxI3HKo64Wsbccg3q9oFp1zD7yMca5z6aufy87E09eeoWdU5?=
 =?us-ascii?Q?81ALbTILBGRbxGUKcj8LzPoYwcbuazBkbTD4TqwzWhJHGXr7AfzGT1huqh47?=
 =?us-ascii?Q?CZ80hhWCU/tD8+A9hoaCXOUHRLgkixV53ZfMydPLwp9tYbqFXt9yurL8jzDf?=
 =?us-ascii?Q?TPOfGwRMkSnrVeFcQEgk+zqlMKsCNVFOPVyayNhBust7gE1s5qK6vXbIi/zN?=
 =?us-ascii?Q?CerJPBCs8wspw0iUKD92rYXwKNrSrFGxZMJjbt8zyqnrgWlaQs9TlceNq1Mw?=
 =?us-ascii?Q?9tXpE97Uh6YRo9S2Vk4C0IwXORNENWLxn5+8flCbJw3JXLhvVPNe0+Y/fLqN?=
 =?us-ascii?Q?uJvI2ebiQeeZD4h4b8I6MB6/LgR/jKBm0eD2R1E7toenUDmbd2v7s/EhlaK+?=
 =?us-ascii?Q?rnGD61qnWhnV1n8r50Pd7NL/ikPWcpPO4nhxyqW4qSL/QPZqL2Gf5DMIXe5N?=
 =?us-ascii?Q?I/aSYQnwZduHpr+DUzgbqCyyXsxXAbupsuxzfWpRQk6f6pBA/mvH/AD2TUMO?=
 =?us-ascii?Q?R4Gfd52QluDQbW28LEiB/PWknKySeo48KKKBmmwrijXzM2XAsXAaZ0uNQvu6?=
 =?us-ascii?Q?/npwjKPIvMvj7MYycu4blIQVmTj6Zmrs+MI5A4vt4cil0mLd0imxswXpfG7/?=
 =?us-ascii?Q?14UJs/Rlu8smQzA8kGlFqSwRXWsna4+1zlUx3foYumxRwKikCTqRSbvJAZeX?=
 =?us-ascii?Q?UaOm+BgPwXshREaR5MOd9ZwF1O68hUSH9OZQAClE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f210a4b-48c0-4068-f966-08dad92a23d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 14:40:23.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Px3LF79Wr4LiqnzZ4zcn1IWNYII+0xA1Dw/ylZ6SczGTlVN6UwEcHU/F0YlGb0r6WC+Au8EbqHaECJNuRQ854Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

Hi Mario.=20

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, December 6, 2022 12:45 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
> definition for Energy Preference Performance(EPP)
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Yuan, Perry <Perry.Yuan@amd.com>
> > Sent: Monday, December 5, 2022 08:41
> > To: Huang, Ray <Ray.Huang@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng, Li
> > (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
> > definition for Energy Preference Performance(EPP)
> >
> > [AMD Official Use Only - General]
> >
> > Hi Ray.
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Monday, December 5, 2022 7:49 PM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> Deepak
> > > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> > <Wyes.Karny@amd.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v6 03/11] cpufreq: intel_pstate: use common
> > > macro definition for Energy Preference Performance(EPP)
> > >
> > > On Fri, Dec 02, 2022 at 03:47:11PM +0800, Yuan, Perry wrote:
> > > > make the energy preference performance strings and profiles using
> > > > one common header for intel_pstate driver, then the amd_pstate epp
> > > > driver can use the common header as well. This will simpify the
> > > > intel_pstate and amd_pstate driver.
> > > >
> > > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > > > ---
> > > >  arch/x86/include/asm/msr-index.h |  4 ---
> > > >  drivers/cpufreq/intel_pstate.c   | 37 +--------------------
> > > >  include/linux/cpufreq_common.h   | 56
> > > ++++++++++++++++++++++++++++++++
> > >
> > > I don't find any specific reason why you have to use another common
> > > cpufreq_common header instead of include/linux/cpufreq.h.
> > >
> > > Thanks,
> > > Ray
> >
> > That is fine for me to use the cpufreq.h to store the common vars.
> > I will move the declaration to that header file.
> >
> > Thanks for the review.
> >
> > Perry.
> >
> > >
> > > >  3 files changed, 57 insertions(+), 40 deletions(-)  create mode
> > > > 100644 include/linux/cpufreq_common.h
> > > >
> > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > b/arch/x86/include/asm/msr-index.h
> > > > index 4a2af82553e4..3983378cff5b 100644
> > > > --- a/arch/x86/include/asm/msr-index.h
> > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > @@ -472,10 +472,6 @@
> > > >  #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
> > > >  #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
> > > >  #define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long)
> > > x & 0xff) << 24)
> > > > -#define HWP_EPP_PERFORMANCE		0x00
> > > > -#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > > > -#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > > > -#define HWP_EPP_POWERSAVE		0xFF
> > > >  #define HWP_ACTIVITY_WINDOW(x)		((unsigned long
> > > long)(x & 0xff3) << 32)
> > > >  #define HWP_PACKAGE_CONTROL(x)		((unsigned long
> > > long)(x & 0x1) << 42)
> > > >
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c index ad9be31753b6..65036ca21719
> > > > 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/vmalloc.h>
> > > >  #include <linux/pm_qos.h>
> > > > +#include <linux/cpufreq_common.h>
> > > >  #include <trace/events/power.h>
> > > >
> > > >  #include <asm/cpu.h>
> > > > @@ -628,42 +629,6 @@ static int intel_pstate_set_epb(int cpu, s16 p=
ref)
> > > >  	return 0;
> > > >  }
> > > >
> > > > -/*
> > > > - * EPP/EPB display strings corresponding to EPP index in the
> > > > - * energy_perf_strings[]
> > > > - *	index		String
> > > > - *-------------------------------------
> > > > - *	0		default
> > > > - *	1		performance
> > > > - *	2		balance_performance
> > > > - *	3		balance_power
> > > > - *	4		power
> > > > - */
> > > > -
> > > > -enum energy_perf_value_index {
> > > > -	EPP_INDEX_DEFAULT =3D 0,
> > > > -	EPP_INDEX_PERFORMANCE,
> > > > -	EPP_INDEX_BALANCE_PERFORMANCE,
> > > > -	EPP_INDEX_BALANCE_POWERSAVE,
> > > > -	EPP_INDEX_POWERSAVE,
> > > > -};
> > > > -
> > > > -static const char * const energy_perf_strings[] =3D {
> > > > -	[EPP_INDEX_DEFAULT] =3D "default",
> > > > -	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > > > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D "balance_performance",
> > > > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > > > -	[EPP_INDEX_POWERSAVE] =3D "power",
> > > > -	NULL
> > > > -};
> > > > -static unsigned int epp_values[] =3D {
> > > > -	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > > > -	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > > > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> > > HWP_EPP_BALANCE_PERFORMANCE,
> > > > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> > > HWP_EPP_BALANCE_POWERSAVE,
> > > > -	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE,
> > > > -};
> > > > -
> > > >  static int intel_pstate_get_energy_pref_index(struct cpudata
> > > > *cpu_data, int *raw_epp)  {
> > > >  	s16 epp;
> > > > diff --git a/include/linux/cpufreq_common.h
> > > > b/include/linux/cpufreq_common.h new file mode 100644 index
> > > > 000000000000..2d14b0b0f55c
> > > > --- /dev/null
> > > > +++ b/include/linux/cpufreq_common.h
> > > > @@ -0,0 +1,56 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * linux/include/linux/cpufreq_common.h
> > > > + *
> > > > + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> > > > + *
> > > > + * Author: Perry Yuan <Perry.Yuan@amd.com>  */
> > > > +
> > > > +#ifndef _LINUX_CPUFREQ_COMMON_H
> > > > +#define _LINUX_CPUFREQ_COMMON_H
> > > > +
> > > > +#include <asm/msr.h>
> > > > +/*
> > > > + * EPP/EPB display strings corresponding to EPP index in the
> > > > + * energy_perf_strings[]
> > > > + *	index		String
> > > > + *-------------------------------------
> > > > + *	0		default
> > > > + *	1		performance
> > > > + *	2		balance_performance
> > > > + *	3		balance_power
> > > > + *	4		power
> > > > + */
> > > > +
> > > > +#define HWP_EPP_PERFORMANCE		0x00
> > > > +#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > > > +#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > > > +#define HWP_EPP_POWERSAVE		0xFF
> > > > +
> > > > +enum energy_perf_value_index {
> > > > +	EPP_INDEX_DEFAULT =3D 0,
> > > > +	EPP_INDEX_PERFORMANCE,
> > > > +	EPP_INDEX_BALANCE_PERFORMANCE,
> > > > +	EPP_INDEX_BALANCE_POWERSAVE,
> > > > +	EPP_INDEX_POWERSAVE,
> > > > +};
> > > > +
> > > > +static const char * const energy_perf_strings[] =3D {
> > > > +	[EPP_INDEX_DEFAULT] =3D "default",
> > > > +	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > > > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D "balance_performance",
> > > > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > > > +	[EPP_INDEX_POWERSAVE] =3D "power",
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static unsigned int epp_values[] =3D {
> > > > +	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > > > +	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > > > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> > > HWP_EPP_BALANCE_PERFORMANCE,
> > > > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> > > HWP_EPP_BALANCE_POWERSAVE,
> > > > +	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE, };
> > > > +
>=20
> I don't believe you should be making these static in the header file.

If I do not make these arrays as static type, it will be reporting lots of =
build errors.

ld: drivers/scsi/lpfc/lpfc_sli.o:(.data+0xa0): multiple definition of `epp_=
values'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined here
ld: drivers/scsi/lpfc/lpfc_sli.o:(.rodata+0x120): multiple definition of `e=
nergy_perf_strings'; drivers/scsi/lpfc/lpfc_mem.o:(.rodata+0x0): first defi=
ned here
ld: drivers/scsi/lpfc/lpfc_ct.o:(.data+0x150): multiple definition of `epp_=
values'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined here
ld: drivers/scsi/lpfc/lpfc_ct.o:(.rodata+0x60): multiple definition of `ene=
rgy_perf_strings'; drivers/scsi/lpfc/lpfc_mem.o:(.rodata+0x0): first define=
d here
ld: drivers/scsi/lpfc/lpfc_els.o:(.data+0x0): multiple definition of `epp_v=
alues'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined here
 ....


I will check how to get this fixed if we really need set it as static in V8=
.

Perry.

>=20
> > > > +#endif /* _LINUX_CPUFREQ_COMMON_H */
> > > > \ No newline at end of file
> > > > --
> > > > 2.34.1
> > > >
