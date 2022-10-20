Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82906606526
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJTP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJTP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:56:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663411A5B32;
        Thu, 20 Oct 2022 08:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBAj8MuG4yxPaORLsCq+t/J8H57dIeDgpboGKWJqBny1T+S7r7/FFyOAuTsb65ppwLT8rGR6p+f9wQ46DN4tuPTKVgyRnFzuF66Mf7Ga8HXGjKzYmyKqWwcy4oX6SFPR5BdWCX8hecVAcG+2LBPKCyv7nkTQ/FzAeyPipr5+UQ9yFDWfLPjbNoyiwlFGXTRTe+NuJd7cI5TEVczQ1pJMFeMZqkgITazt5XUFo3MgLv8T+knQzsljWJFbl4yE46bc+CwMXvUcpGvXjqIoa7uYXIN6iWN//ZLejzt2OzQ2Td4uRp1YzHMn51dkkYKZ/Tv778usq2Y3LreKOa41fYrxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxsdAlj+8kF69ncvIBMQXp/K+1KMB+1VrruvQr7gnas=;
 b=jvHqpv1pMscZD0y2/PSJAd0GyAWZhCi02ERuT+eafKQgl8EX9tBOKa0jiFYqrVOAObEY+SvRR1Xip6wAZDrKlXnLY5vISmGO3JYIMlelP+n68uJE1KsugKgCnd2pUTS2iqJoc9f/6XWqlxyYWrotnkrpTcYLAYn60jRADMSvEM6+n4YuS6bLY1NYOsuq+B470nIaWypWyOhiZ+95oRQGzHOu5c0A8FY4z9WCo/XouIL08jAiAvkKkYMPwrc1eVNqYnzqr6bfjRiqREEhzGESHapUdSRMsuJpFVDlqzIPHPSzxczTuc4/Q6zUiYGEqC3Q2VE6/nD8zePrIuIZ1wEaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxsdAlj+8kF69ncvIBMQXp/K+1KMB+1VrruvQr7gnas=;
 b=tLxDLsa1hh3oFuU3kogQqHTaP4vksExoWAH+jmyw4hZ4uh2DOBMdSTY3I+5dosEnFuurW8vnOZT0L5URvtSN8+gyP7t+u5AyUG/yRW/MX7s0XMxclhpBRQDm7CvOz7ip8/Xh2Cu9PEik2rW4uvo+XAp2pbUBY/S3IiLgFwo6DRU=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 15:56:21 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 15:56:21 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 2/9] cpufreq: amd_pstate: add module parameter
 to load amd pstate EPP driver
Thread-Topic: [RESEND PATCH V2 2/9] cpufreq: amd_pstate: add module parameter
 to load amd pstate EPP driver
Thread-Index: AQHY3MScv4q6idw2vkK9CXgEWYjnha4SYVSAgAUdjiA=
Date:   Thu, 20 Oct 2022 15:56:21 +0000
Message-ID: <DM4PR12MB5278526E62147200D16FF2B99C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-3-Perry.Yuan@amd.com> <Y00koVkHD3ECCY7H@amd.com>
In-Reply-To: <Y00koVkHD3ECCY7H@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T15:56:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01e2e654-c993-44f7-bff9-c406cdc2348b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-20T15:56:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 17bfb897-fbb4-4ef8-9054-741334b570ab
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB7542:EE_
x-ms-office365-filtering-correlation-id: 83b0bdf0-a00f-4aac-6c3f-08dab2b3a20b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDDblT5FaNp7nZEVDex+yXnYbOMoLIGzlbYriQJ5JkoF25g656nFqFHRy5SJkNN+BRP3CXgQxfirPag1wmuAvlzJF7Cj6emz9bYbiPpZd1zO5bPGkWkpdIzPPAGBgF/Rg9ud/6IeG+KAXIjk5mNXJ7+HpgJ1rbi3k4ZK2AAE3YC/tbLENA43nlAUJQcSgrwkjI5oEj5MdlRi+SvRUhZ/XWDaqG/14NBO7TE4D5iKP9hPKAMI79SJENV1TujgJwXnvUZD9sl89OyYF+TBeQJ07ZZHgaXBbIRhkGkvYI+CfjL+NMXaC+oDEcnUC6GhQqieDDKYCyHFqYL97G7cBesiUg4WdpLvQZGUPbuZlzGaWvvPdPQn9A/VPHcByteSbtt4Pc1p8nxvV7K2sGdNPvUrcP8Ybig8nEuK8ThwMleOmBpKhV70yCqdbvFK/qU992+GrRv7ehIpFRBxeg+SvV0SwcbgMbMZOnH//7slR1lSukRG05H99OQrh4/m767DO32K9tbhetBAYkmJsUwMq82Sjg1kQLk13eKguyBACUFZ73qiNyNjPtt14Eku8P80pYMtnIrcxUqen93myjde/sl/3yQJMeCvSjgPYHYLMm6tdHryXwJaHt78i/vjdkWIHhR65RigJq7O2hK9ap1V9UsKIqRS0AXz4JeBYqFIO+n9p6rWAEabfd5+bU22DhHdkmdsIQGVefTNtryT4mFKkDXAzH7lVYROP/LN3MelmPmQxFaPNlPbN+axP4v7wn7BVVpANVkmNrU84592lG2ap8zI8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(33656002)(86362001)(38100700002)(38070700005)(54906003)(186003)(55016003)(5660300002)(66946007)(53546011)(122000001)(26005)(9686003)(6506007)(66446008)(83380400001)(7696005)(52536014)(2906002)(478600001)(64756008)(76116006)(316002)(66476007)(71200400001)(6636002)(41300700001)(66556008)(8676002)(4326008)(6862004)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzr+6PfUyMHNYYBBd4FgYVp1H2huGY4KSmjYRK/Wtpf6Gag0MEYHeEXMBv4I?=
 =?us-ascii?Q?zrL0LtDd+To/QIqAtC5qTLWDoXQKJRVY4cZXNw04yxvJx1D1cObiel1aBb2+?=
 =?us-ascii?Q?wBNGjG6M2Tvqp/h6QuaUVPWuhgdiRtUj5fO9q71uEgtb/L5fXaIgxuHf51iV?=
 =?us-ascii?Q?Zxl9MdE31ENY227fhWgwPkF4fwTZYSGUE2kqq7936ye5DKyhFu9/TcTraVQG?=
 =?us-ascii?Q?voIo8C9X2/ioLj8fx4GqKqZZC325eKwcdINP6YlKW13lAXuskK/859be+pGa?=
 =?us-ascii?Q?18SLKXZNiljgqhWoLdSMLR1tj27NcN1Nu6f91hRQYwUoQ+kKcBYbPsY59ORv?=
 =?us-ascii?Q?qBbq89J7B0GGskinLK+SGKTX6SXl9GMUv+cOXeQf+phplpBjbm/UCXTukt+Q?=
 =?us-ascii?Q?7uRaCRJXPgog4kVyz2rWtQ/p3Y3DISrNtwSAJpHm9GQc9Qm93GRFpG9LBJ5g?=
 =?us-ascii?Q?BkIm1wj1ondwR4JIJzCAHnsDwctN6eSxFFoN9tiIt5IK9YyaKpjVHRG3TvPk?=
 =?us-ascii?Q?knZdbh9k2YSQdrPOVmZu3HEhyUSTz9n7ZZP6yrcO5gD21OXtrMJE4/Enyytq?=
 =?us-ascii?Q?eB/0098M5NfLaHP7yAJAGu2kzubT2DomMq2rMGsrFBq52pNQoRlSBl+Cm0TW?=
 =?us-ascii?Q?QSS2PvBFIA5kWFpGBl/3d9l4bGLjnsHPdAb+EDFcTvbIGK+ypxt+pmFHeVAP?=
 =?us-ascii?Q?ePHTQWJaMoCfcmL0jp/WfKDMRLllGgbiXCqSuhcm9R4GfuF8grlLVeNBPbS1?=
 =?us-ascii?Q?JvbCLDSjEnINtnaOvzw6+9xrOhhfPdaav0ZO0cKs+SOwhSiQyClCHEp8VL1w?=
 =?us-ascii?Q?VmS+0OaV+z5mk+UFzDLe40MVJ0AXtWTCArPJM/upq3qi2cq8irsiZLkVYNGt?=
 =?us-ascii?Q?qN6fZeOJyXjZbnnZ4MH8WfxHJPQQYBNKBdBafRpGgr91XCqTy709ZD7809Rm?=
 =?us-ascii?Q?FLsdVpHqwH5W5M854/oJbaWPLvPdPgKqfGmQieNYcvwcbygCAaxjttPNnh/W?=
 =?us-ascii?Q?PUajELinZWFB9BXtO7X76kV0eKZCTo6BS+BOyDFQRy4RJkZZ35qb2H2S5vME?=
 =?us-ascii?Q?toNjktbEyqMVvk0fBvrJR31iDnVdvStdcmUkprWRNT4k36h4B9GbxoO6yjBh?=
 =?us-ascii?Q?ynQXRdHMo+jystp4WAX4OTHv0I+3umbm145KCnL/Fog0udnlykYDS2AWZ3J6?=
 =?us-ascii?Q?9h9Usx5uKBiY+dCKAPSZ+OcwbMkVBinR6XSBQw7ADXSsZJfKn0byYJJD4772?=
 =?us-ascii?Q?M9yEZuYEfl6z8sMtdbAzcDzUVzazdVh6+EaqSqutn7tk+XlZdRuJx/e1ZH73?=
 =?us-ascii?Q?UUKynYIc79GeY38d/pRG511550/fsqjpJBG9mW0ly75yOKcnjnkyRuO+O3ij?=
 =?us-ascii?Q?k84uG7YAk6nHF0mCFoSnHrnECeYtYahqOMJeS+yFw3+ondBZYn6voJWAm2Tm?=
 =?us-ascii?Q?/Cl1XStrJ84XLXoqRmg5WqkuYNpFH14WUs/4bubd+2ayfm+hjtQ+FhgHgjan?=
 =?us-ascii?Q?k5LoAKb3QN915KFMG3q6xgR5ZTdRuvTyWBhi5aMj9K6wd1LN1PwPr72SaAPJ?=
 =?us-ascii?Q?Ueql8LT4h/OsrRtxP61PM0Tg0QrnYl4OIQi7H1mu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b0bdf0-a00f-4aac-6c3f-08dab2b3a20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 15:56:21.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jR8BX56cssXxQQHtp8CK0O2igtHg1RDOGX9CJKg93qyqC/ixNKsnDR4yZOhENWCElssCP1SyCpVV0NDPd6bZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, October 17, 2022 5:47 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RESEND PATCH V2 2/9] cpufreq: amd_pstate: add module
> parameter to load amd pstate EPP driver
>=20
> On Tue, Oct 11, 2022 at 12:22:41AM +0800, Yuan, Perry wrote:
> > The amd_pstate mode parameter will allow user to select which amd
> > pstate working mode as booting mode, amd_pstate instance or
> amd_pstate_epp instance.
> >
> > 1) amd_pstate instance is depending on the target operation mode.
> > 2) amd_pstate_epp instance is depending on the set_policy operation
> mode.It
> >    is also called active mode that AMD SMU has EPP algorithm to control=
 the
> >    CPU runtime frequency according to the EPP set value and workload.
> >
>=20
> There is one concern here: how can the user know which kind of processor
> supports the EPP function in hardware?
>=20
> Thanks,
> Ray

Checked with internal team, I was told that EPP is part of the CPPC impleme=
ntation,=20
The Pstate driver already check if the cppc valid when driver loading, we d=
o not need to check the epp again.=20

Perry.

>=20
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index f52b8f2fe529..2d28f458589c 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -63,6 +63,10 @@ module_param(shared_mem, bool, 0444);
> > MODULE_PARM_DESC(shared_mem,
> >  		 "enable amd-pstate on processors with shared memory
> solution
> > (false =3D disabled (default), true =3D enabled)");
> >
> > +static bool epp =3D false;
> > +module_param(epp, bool, 0444);
> > +MODULE_PARM_DESC(epp, "Enable energy performance preference (EPP)
> > +control");
> > +
> >  static struct cpufreq_driver amd_pstate_driver;
> >
> >  /**
> > --
> > 2.34.1
> >
