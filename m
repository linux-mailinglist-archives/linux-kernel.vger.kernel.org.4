Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF6647492
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLHQqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLHQqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:46:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D5AD9AF;
        Thu,  8 Dec 2022 08:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2vvLUHK10PIjOEPHHF7dfl8dLNH6y51683ME5wsbtSWzX9AY3V4eyA+8v2l8mbMauxemn4oFWeFMBsOrxjR3vtEYr/oeSCXSPDxMKchRVrV4Pw4cQilo+lyAMzVEPr59pcSYlBXWGmyFzGlJZWr7ZOEqgJ6xmJGQQ0tzOtUiu4/MaYr1gldxWJfdqnXkMec3ZLgipPIfOV5DXn//k15bj3FP9E7jQkEyp8u3gRUBwESDygFXnFFjxUZEww/hOa0SgCqLBCfJvvKUdufwHl0VzA4fHE6JeapZsGGz6b5QYUTTyqgCummbjTaGGmJowE9xGctmIw5Y6M4XVQf6jEfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOWjgni3D5NnzP6i2ctbxTs60Z+zEkoGFSVS8hGAjnc=;
 b=KpYgbO2bvii3Yg11IUbbeFzZwZMYxzGnSkd0SLWR9un7OVE1/zTcW+564olTuHAwaszXDj6hc/mOHNKY6iDBaPm3vFBoSqYraD5F94vSujiVfwL43Ibhh7h4FyywjwuHJSZ0uxbn5J/35VwwF6zI6x5J0vXkw7fw/2SEx5lY8GLwVb2iK1gpedBjB0zazzhb2s6ObJ0kXy4ugdjfUaCn5OyPr7UmjTqsaCJW0E5o+ZH8QYdSutQj60dSngGW2HKKkLXiWzRwO46Xzgo3LNeeoZykAs0EL8klcZioo2wjAwCSBVib/r7fAGHZtyo8cHFYhY/QP7kKQb1lWQevs/02VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOWjgni3D5NnzP6i2ctbxTs60Z+zEkoGFSVS8hGAjnc=;
 b=bqFZoBF8dhblIIaSwd6ZQNknnBYrgNQlgdSMLLu6+trSyiXN6OSyFQSIwdCcWwABRMSDLX1KgwDpCyUazqnr++OCF8BH08UWkVrFj08f7T3J2LSQUP3U35D8J0YZDwt8boQk1lqrw0aYdAPitxTdefGOMORGmKJTzMVELIbi7I0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 16:46:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 16:46:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
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
Thread-Index: AQHZBiLElIywIeMeWkOd9ikqFenAm65fMtqAgAAv8YCAACIX4IAElNqAgAAi5fA=
Date:   Thu, 8 Dec 2022 16:46:37 +0000
Message-ID: <MN0PR12MB61017B3409E33ED7EF3FBA0DE21D9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-4-perry.yuan@amd.com> <Y43aq2gMKnFRIhxh@amd.com>
 <DM4PR12MB52782BAACEE08C09D704F0BE9C189@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB6101CA08E8D0BB0B43420FC5E2189@MN0PR12MB6101.namprd12.prod.outlook.com>
 <DM4PR12MB5278E435D3DCF8AAFF3EDF539C1D9@DM4PR12MB5278.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5278E435D3DCF8AAFF3EDF539C1D9@DM4PR12MB5278.namprd12.prod.outlook.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-08T16:46:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 525292e8-7b3a-484d-8888-48fbd65da492
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW3PR12MB4396:EE_
x-ms-office365-filtering-correlation-id: 148d64fd-f020-428b-0d06-08dad93bc5e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7pcDsYx2/Mq/TMqKGbArw5yqVj/C3qr4AjeYuFMSlirERD29C1lBVlPYnB0Phw7uvYzniBgqBh1jtfQwTDlYaTzo0vZV9rok7eq2yigdnSI8GVejk4kQUa/p0SrH5aHkW4E+jp0mTQXeDcsVEAc7SFI7L4x6i+y0+54jdXS2fhT/hS/gL4f5CrDsjt9WSbYOQAYOrheCCTYQiUCJKpSMYjH0a60lkeJb3I3FSdju09x9aLMk5Ffl0W7uex76w+WvHYZRUrs7+RQ332D9rDauBBeBL3HLBQG8faxQeUmqyymdmsng9mqQirO2uWWQ2JlaEWzoHSaeqAPNyHrYZgoynk+ptHDraSgFXsRXwxm8XFqAVmLICCyOh7+5z20lm/n3uda5SZ7Ke1/+U1WAcBsomeIIMpUuW3rH0AltR8ca4e3FA6CM0L+LSyEC6JBZXnom+M88nN6iKy7NZflUQPGT4y5cmJ+QKR3ypcCA8NQEc+UtQ984c99vvpMMAK/KDiuodFdfY0iYWJ3otzRgjirIHb4EzgPE5hYLTbAY3zHiJEGXtrfbBDs0WgPa1Rofta0Fg5Iajo9+wBnK4XXY0GEXYYYOTkb/cfGuqJJ1Avw3E3LRnlAJoZrN7xRMZL8LTQp1CU4UQ6XJ/tHcoMABBVUiDGN7VJAFv+qtVWZSY+MMN7j5uZXTjwErLCjFysnWNnkkFyNriVGvuvVwYosdRtJcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(86362001)(66946007)(66556008)(4326008)(8676002)(66446008)(41300700001)(66476007)(64756008)(2906002)(38070700005)(83380400001)(122000001)(38100700002)(33656002)(6636002)(54906003)(110136005)(316002)(76116006)(6506007)(5660300002)(478600001)(52536014)(8936002)(186003)(71200400001)(9686003)(55016003)(53546011)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x2zR550fcYZJQ+Ns/v7I3w8iFQBaYQfCNm1PN1VrUWsJCzg2OBZwkAbZbk4N?=
 =?us-ascii?Q?4hb0gsDNkVh7l0m/K+boeDQ/6xeIKGGIVbm8K+MJWrPBKk6SWhAwwP3ep/wa?=
 =?us-ascii?Q?UfP0F7/MDi2EKO/e1TZhXNy2iWV8W4mjCmjDnTNqeSRI2sh6ZUnQGTURTlMM?=
 =?us-ascii?Q?ubvTNYBsnspXYMg0rEafdlDl/ZxTwW8oyoETuT7eH8Bwkq+H8xZo7HwvH+Hi?=
 =?us-ascii?Q?GUooxtz/0qyjH6EfjcdEMC7dr6d2oKCUbmuao6sPuMikwz1Di3TAbxqAZpfl?=
 =?us-ascii?Q?obnGphsy2PW/41NZmCJVLpMnYwbzfSgsxz8y6Z/k+cX+Q1Wix9bE0HD5XmY2?=
 =?us-ascii?Q?zMESA/qe1rGy3lhmGUHts4uufev7eY5pMxOnwCOkCXXI+r/TXdH06g5tpKSI?=
 =?us-ascii?Q?IqbrKLrBeR5nGlYBlII5xjP1q4pWEwwni+Q7scybyUi5k1RhWtNGllACUEYo?=
 =?us-ascii?Q?z3Fc154D2kEpOsCa00zO0BUaQTEs17mabtGZwVvDXDRVa8FREq65dSCHGYp5?=
 =?us-ascii?Q?2OoIWbH0P1kbNevt3knu0rpksVvhXWSYMUTT8ZJSFCTGv1ep+FeKh1WF2qgV?=
 =?us-ascii?Q?YX4Mc7irdSH6bmm2Wo3yJPFjGIDAiNfgwcoMx3HqFceKwhaZZqPXWTolNF3C?=
 =?us-ascii?Q?3fmKYovwsHhhbh+3kxeMe9bK2TzpHMM08rgnqr4I7iI/EfWSvs+XIDiRRdj1?=
 =?us-ascii?Q?dLpAzSHR1jwFad2E/5FdcgAIaNsiEy/HrTBnXr5sNgThl7y0ZQBGsmTVjVZ8?=
 =?us-ascii?Q?a26hsmVuI06NRdqckeQiRhky6k8ZlcQi+1vj/duV08os1mvesblYKPxqf+mx?=
 =?us-ascii?Q?HfDvCEZrA4+MMplRvgEURqCXPVkcFMlw+uycX8xXTKMsH1qd3RaLL5KVkIK4?=
 =?us-ascii?Q?Lm5qmkDO5IIghpe86ZTXdeIMQ2tQ/tIpBmFWI4jlLWw1CNz6vj7TMVA+jy/H?=
 =?us-ascii?Q?4q//3wupUX0AJF2Hv6L2+VVDIBXPgW9/lfSIT5inaNEHf1SsM3T1c6CMjxDQ?=
 =?us-ascii?Q?GauN3lk14f8YkNjyo7qD7MvuZj9KtE6LLiGEWTS71fLDa9VVh3q3GL0lodw2?=
 =?us-ascii?Q?P23NYipoBXDoeYNKkqyc6WVcy2DhJ+0IG1Ha1o6Az6KBGNnq8BoNdPnFnECn?=
 =?us-ascii?Q?+XT0QYqZPBwSi4E25Fj3owOKyf/xim3MQ4BgnB1IZ4Y1yWNFt0ZE+qUM+kBe?=
 =?us-ascii?Q?Q8+r5cMrfN4A4u9PFZRAVvpKBfq2k4d99gUmfrPzQB2FqOe7C4cjwEFbAaGc?=
 =?us-ascii?Q?TjBUYArZp4BgNwNJ/gR9rh/y+CdaLM/QE6oJwiZXsNQLlMuza3saFWJMZfpb?=
 =?us-ascii?Q?NMObyAVJ2Gp4A1KTEDpnTATPy5w3GaUIDkmBmrKwV4iOhZRxxIG72MLE98nS?=
 =?us-ascii?Q?+Zpqruj72UG6lJH3hDMvTPdZNRJjRE97OCfMGWp1zk8XMbSalSn5lzf6JRxY?=
 =?us-ascii?Q?KRWSccZTjbksRf/+SdNYlhlCeSIbhW/CUX4100c/wRa5Ukyg42NBFPY58Obi?=
 =?us-ascii?Q?1Uz8YcygSmolVMaivimC/U/zx3oBa886pTYud6etcsDv3l3ZjZ0oLL/OyE5m?=
 =?us-ascii?Q?z6h+FSdjJcK6utUK8lg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148d64fd-f020-428b-0d06-08dad93bc5e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 16:46:37.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykvruDR2a2rMN1DwfN0pTCO9AEePPOVMslTV9vFDzlDrBkDR2idhCYlGnCR5MMwtc6D9+ruskJb34AmFAuIL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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



> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Thursday, December 8, 2022 08:40
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>
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
> Hi Mario.
>=20
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Tuesday, December 6, 2022 12:45 AM
> > To: Yuan, Perry <Perry.Yuan@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>
> > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
> > definition for Energy Preference Performance(EPP)
> >
> > [Public]
> >
> >
> >
> > > -----Original Message-----
> > > From: Yuan, Perry <Perry.Yuan@amd.com>
> > > Sent: Monday, December 5, 2022 08:41
> > > To: Huang, Ray <Ray.Huang@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> Deepak
> > > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > Meng, Li
> > > (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro
> > > definition for Energy Preference Performance(EPP)
> > >
> > > [AMD Official Use Only - General]
> > >
> > > Hi Ray.
> > >
> > > > -----Original Message-----
> > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > Sent: Monday, December 5, 2022 7:49 PM
> > > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> > Deepak
> > > > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>;
> > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang,
> Shimmer
> > > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > > Meng,
> > > > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> > > <Wyes.Karny@amd.com>;
> > > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v6 03/11] cpufreq: intel_pstate: use common
> > > > macro definition for Energy Preference Performance(EPP)
> > > >
> > > > On Fri, Dec 02, 2022 at 03:47:11PM +0800, Yuan, Perry wrote:
> > > > > make the energy preference performance strings and profiles using
> > > > > one common header for intel_pstate driver, then the amd_pstate
> epp
> > > > > driver can use the common header as well. This will simpify the
> > > > > intel_pstate and amd_pstate driver.
> > > > >
> > > > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > > > > ---
> > > > >  arch/x86/include/asm/msr-index.h |  4 ---
> > > > >  drivers/cpufreq/intel_pstate.c   | 37 +--------------------
> > > > >  include/linux/cpufreq_common.h   | 56
> > > > ++++++++++++++++++++++++++++++++
> > > >
> > > > I don't find any specific reason why you have to use another common
> > > > cpufreq_common header instead of include/linux/cpufreq.h.
> > > >
> > > > Thanks,
> > > > Ray
> > >
> > > That is fine for me to use the cpufreq.h to store the common vars.
> > > I will move the declaration to that header file.
> > >
> > > Thanks for the review.
> > >
> > > Perry.
> > >
> > > >
> > > > >  3 files changed, 57 insertions(+), 40 deletions(-)  create mode
> > > > > 100644 include/linux/cpufreq_common.h
> > > > >
> > > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > > b/arch/x86/include/asm/msr-index.h
> > > > > index 4a2af82553e4..3983378cff5b 100644
> > > > > --- a/arch/x86/include/asm/msr-index.h
> > > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > > @@ -472,10 +472,6 @@
> > > > >  #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
> > > > >  #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
> > > > >  #define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long)
> > > > x & 0xff) << 24)
> > > > > -#define HWP_EPP_PERFORMANCE		0x00
> > > > > -#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > > > > -#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > > > > -#define HWP_EPP_POWERSAVE		0xFF
> > > > >  #define HWP_ACTIVITY_WINDOW(x)		((unsigned long
> > > > long)(x & 0xff3) << 32)
> > > > >  #define HWP_PACKAGE_CONTROL(x)		((unsigned long
> > > > long)(x & 0x1) << 42)
> > > > >
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c index ad9be31753b6..65036ca21719
> > > > > 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -25,6 +25,7 @@
> > > > >  #include <linux/acpi.h>
> > > > >  #include <linux/vmalloc.h>
> > > > >  #include <linux/pm_qos.h>
> > > > > +#include <linux/cpufreq_common.h>
> > > > >  #include <trace/events/power.h>
> > > > >
> > > > >  #include <asm/cpu.h>
> > > > > @@ -628,42 +629,6 @@ static int intel_pstate_set_epb(int cpu, s16
> pref)
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -/*
> > > > > - * EPP/EPB display strings corresponding to EPP index in the
> > > > > - * energy_perf_strings[]
> > > > > - *	index		String
> > > > > - *-------------------------------------
> > > > > - *	0		default
> > > > > - *	1		performance
> > > > > - *	2		balance_performance
> > > > > - *	3		balance_power
> > > > > - *	4		power
> > > > > - */
> > > > > -
> > > > > -enum energy_perf_value_index {
> > > > > -	EPP_INDEX_DEFAULT =3D 0,
> > > > > -	EPP_INDEX_PERFORMANCE,
> > > > > -	EPP_INDEX_BALANCE_PERFORMANCE,
> > > > > -	EPP_INDEX_BALANCE_POWERSAVE,
> > > > > -	EPP_INDEX_POWERSAVE,
> > > > > -};
> > > > > -
> > > > > -static const char * const energy_perf_strings[] =3D {
> > > > > -	[EPP_INDEX_DEFAULT] =3D "default",
> > > > > -	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > > > > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> "balance_performance",
> > > > > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > > > > -	[EPP_INDEX_POWERSAVE] =3D "power",
> > > > > -	NULL
> > > > > -};
> > > > > -static unsigned int epp_values[] =3D {
> > > > > -	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > > > > -	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > > > > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> > > > HWP_EPP_BALANCE_PERFORMANCE,
> > > > > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> > > > HWP_EPP_BALANCE_POWERSAVE,
> > > > > -	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE,
> > > > > -};
> > > > > -
> > > > >  static int intel_pstate_get_energy_pref_index(struct cpudata
> > > > > *cpu_data, int *raw_epp)  {
> > > > >  	s16 epp;
> > > > > diff --git a/include/linux/cpufreq_common.h
> > > > > b/include/linux/cpufreq_common.h new file mode 100644 index
> > > > > 000000000000..2d14b0b0f55c
> > > > > --- /dev/null
> > > > > +++ b/include/linux/cpufreq_common.h
> > > > > @@ -0,0 +1,56 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > +/*
> > > > > + * linux/include/linux/cpufreq_common.h
> > > > > + *
> > > > > + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> > > > > + *
> > > > > + * Author: Perry Yuan <Perry.Yuan@amd.com>  */
> > > > > +
> > > > > +#ifndef _LINUX_CPUFREQ_COMMON_H
> > > > > +#define _LINUX_CPUFREQ_COMMON_H
> > > > > +
> > > > > +#include <asm/msr.h>
> > > > > +/*
> > > > > + * EPP/EPB display strings corresponding to EPP index in the
> > > > > + * energy_perf_strings[]
> > > > > + *	index		String
> > > > > + *-------------------------------------
> > > > > + *	0		default
> > > > > + *	1		performance
> > > > > + *	2		balance_performance
> > > > > + *	3		balance_power
> > > > > + *	4		power
> > > > > + */
> > > > > +
> > > > > +#define HWP_EPP_PERFORMANCE		0x00
> > > > > +#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > > > > +#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > > > > +#define HWP_EPP_POWERSAVE		0xFF
> > > > > +
> > > > > +enum energy_perf_value_index {
> > > > > +	EPP_INDEX_DEFAULT =3D 0,
> > > > > +	EPP_INDEX_PERFORMANCE,
> > > > > +	EPP_INDEX_BALANCE_PERFORMANCE,
> > > > > +	EPP_INDEX_BALANCE_POWERSAVE,
> > > > > +	EPP_INDEX_POWERSAVE,
> > > > > +};
> > > > > +
> > > > > +static const char * const energy_perf_strings[] =3D {
> > > > > +	[EPP_INDEX_DEFAULT] =3D "default",
> > > > > +	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > > > > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> "balance_performance",
> > > > > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > > > > +	[EPP_INDEX_POWERSAVE] =3D "power",
> > > > > +	NULL
> > > > > +};
> > > > > +
> > > > > +static unsigned int epp_values[] =3D {
> > > > > +	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > > > > +	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > > > > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> > > > HWP_EPP_BALANCE_PERFORMANCE,
> > > > > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> > > > HWP_EPP_BALANCE_POWERSAVE,
> > > > > +	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE, };
> > > > > +
> >
> > I don't believe you should be making these static in the header file.
>=20
> If I do not make these arrays as static type, it will be reporting lots o=
f build
> errors.
>=20
> ld: drivers/scsi/lpfc/lpfc_sli.o:(.data+0xa0): multiple definition of
> `epp_values'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined her=
e
> ld: drivers/scsi/lpfc/lpfc_sli.o:(.rodata+0x120): multiple definition of
> `energy_perf_strings'; drivers/scsi/lpfc/lpfc_mem.o:(.rodata+0x0): first
> defined here
> ld: drivers/scsi/lpfc/lpfc_ct.o:(.data+0x150): multiple definition of
> `epp_values'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined her=
e
> ld: drivers/scsi/lpfc/lpfc_ct.o:(.rodata+0x60): multiple definition of
> `energy_perf_strings'; drivers/scsi/lpfc/lpfc_mem.o:(.rodata+0x0): first
> defined here
> ld: drivers/scsi/lpfc/lpfc_els.o:(.data+0x0): multiple definition of
> `epp_values'; drivers/scsi/lpfc/lpfc_mem.o:(.data+0x0): first defined her=
e
>  ....
>=20
>=20
> I will check how to get this fixed if we really need set it as static in =
V8.
>=20

Right; What I think you should do is have in the header (.h) something like

extern int epp_values[];

and then declare the actual definitions in a source file used by all the co=
nsumers (.c).

> Perry.
>=20
> >
> > > > > +#endif /* _LINUX_CPUFREQ_COMMON_H */
> > > > > \ No newline at end of file
> > > > > --
> > > > > 2.34.1
> > > > >
