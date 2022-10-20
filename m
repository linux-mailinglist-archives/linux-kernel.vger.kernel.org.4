Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971A60655D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJTQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJTQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:05:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A741A1B31;
        Thu, 20 Oct 2022 09:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcUEYHtiZ0lKBUFqJ2hx2MCTHZCfRoAeRd7nTU33JrY28iTNBIgN2tk2RFh85hl8DRMhh/eoSo6p4vsdiQQFI+aKW8cUh/qIEJcI/OOHgC46bjB8ioSa0iagpu0rhcuHsytqz7d9xQmueYQibLR+p7m+zev5/Bdo6ovrLKO/22OJ0rpv6IePbJVulrdXGr0mAMcbHoogE+CPGXaVzICFn5iNrgTgu6tPCb6Eo5TL8Nn2weD7G2TkAQAvA/kjlJEXpfHsZebLiBOKKAhFoDAtCf+9lJsNLdvsqWb5faJB0t4WXAXUpMDCHjMfFnXJI6aMvVm81jA+8HnRg3vLrhejBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhjMdFD5gwF2kafKOs71prKrOlw9/0ZreGIYWHQ6Y0c=;
 b=avvsbnTMqpw2zglTAa7VWmiT0Id2qRKitnn/aHmyjOF6riQCjrlrnDXAZw40yQi/Im00HDfjL6lI685JHHke3IOJKYTm70ph6Lw9BvFIGOVvirlCGLyt9vNgxAFgVQBzW1EC5T1HY8w9wqYvfyAyP3se1sQAsVvqdfpl8p7lWeBvss7BgVvufqXVR91QXCI028qverDrUI85NmBXoTfF73zDumOOAAkY5TIaDgAm+TLoEnhKWbcw0gGw2H0I8prFb+kxENqmvCcBh3omFiwpA/Yqrd5ICnlgOqfHbMS+ceM3pDuHiRbK2EH4nCA1HXAu+Nka1+yQ5CGGQ7HNF5OFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhjMdFD5gwF2kafKOs71prKrOlw9/0ZreGIYWHQ6Y0c=;
 b=wEOyv6Uvg7X0claUQx8kOPn9lauBLLoprccTVlM/Gt8SW3K7nvEhu942hkmDB3WCHELwci3ZOB2TfVFwjQXoDPyOVss7+br+7J6eTIDc2x2tV6L9iqQ/7NnXMBfcudZFrtznmDG+fcbFfXArlHLRYpnNmFZ+RwbcMz/yC+Y4J1E=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 16:05:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%8]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 16:05:21 +0000
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MStK4MnSnpf+0GQYE3/I0UgW64SZAsAgAUcwYCAAACbIA==
Date:   Thu, 20 Oct 2022 16:05:21 +0000
Message-ID: <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-20T16:03:26Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f35989c9-31d8-4161-a4bf-740c695873c2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-20T16:05:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: be75c1fd-59d2-4a06-a294-5392e1b02be0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BL1PR12MB5159:EE_
x-ms-office365-filtering-correlation-id: cce2fe04-3690-4d9f-76a2-08dab2b4e41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eArdpyCsRQpedVEk5LNz9RMPyS3r+fBXTRsnTUWPYkCjVJgDeCuxt0/RQn3yji2RwcShcrknEvGxyr5HdiIVDW4Q1oWsqIdZTWtrIo7/ILtupL0GVMNEPA3Ia5/YxQMJNnCz92rbhAYYyWTXhqXfIYyXG0XRQcWvXoRNRlG1tFGtSvtnLlFq3XQabcyH6coMJzBvFusYyk2Eml3XkcNU0S/RdrGLT+PHiZIRjZqa/vIYJAin7Ped0TIF4q03VIfcD6btt8LQfgmuRjSy7UQQxDdU5X50flqhcRRuWLLjEisqCQDFKrkNGHcLCR0zlIhSQeHxvujwbXf1ih4nVC6uU/2SbeGiQwC9SWruhWDQW1mHJiUWbVbBd5n1vZKpZ7YrirfgfCoG6jwaCbRZo2Im/OteJ8tMv866uq6Ib299KHbKUCToG9/KQ7okPk/eF0ILakzCl4ATFybHpfc2OJRBarh0Hl8vyf3UTY+pW+mj1JOfPmXrpDNca8X+1OO0diSRGejhb+htVTciu8Z1ABvFc3xZngLhW1mjEWx8oM1I/XdMXvAaX1GiKH4Ky5TUr8nJ7/Te9XDGMJf4UEYelrOdtcv9S5hC86dnyBi8nRvtSKsOclqnNIqn0goKxAxEjsOlOBCVRhPylEHc2N45OBE+kE+pxNO/Fyb8ZWPyHawn/6rrrjP6cuOHWImrYxXKYqegeaDSgTrBjSwhgFa0Qwgbw5fldUo+uib10xfcZ9yXzeEl5/7oJPt+69+7JxCOk6i13tf3jKcK4vp3TqOxM5qq32k17/x80QvJknsImXxj7zSMzlebYgtZ8nafalgNV8GMW985FXvJ5kSzlkaaNSTR0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(53546011)(86362001)(33656002)(122000001)(52536014)(66476007)(66446008)(41300700001)(66556008)(38100700002)(66946007)(38070700005)(83380400001)(64756008)(6506007)(186003)(7696005)(478600001)(5660300002)(2906002)(76116006)(316002)(8936002)(6636002)(8676002)(4326008)(9686003)(26005)(110136005)(54906003)(55016003)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jN+YxGn7hAyiJuPQlyzHFN3Cemd/Xhj5pVrAiO9cwqP9SmkN64aqly09bLOR?=
 =?us-ascii?Q?GPjw5WLqukhZTja6n2VsQyO1CL4l+NtMBFxnBD+KhHQWCeDbjxvS3kCAJ6vp?=
 =?us-ascii?Q?efB8v6ebSqlqqfvybTHqk2KWzc6deQEW2uYuL6KTZG4VhV3bcj0pGtwuZ+Id?=
 =?us-ascii?Q?c3ElICdptWGZLDTpHxFkSRYHex4DKJ5C6HeGdURbWIUDxxaIUkoRB4+OfCDE?=
 =?us-ascii?Q?321rjPkdlPOvxBmNSjWyb682IQWWpbpZH8IPTCOcov/ThQyetLj6HN0tP+jE?=
 =?us-ascii?Q?mWoLMaPZ9KodOdU6EU+dG5nrj+PW19Ts4GnhhYv2vH6cA+EwGmcyvxpkOD+Q?=
 =?us-ascii?Q?SVQZucNqi4YFLP0S1QJhjdGJ6BA1+GQ+pzm1zb1W7bwta/azLc/+7tM8U2Wc?=
 =?us-ascii?Q?ltRIbb4LJ5LMTIPFG+fg3qfadEWyBS4xhadwetPib2K5lXe1769CoUUz0qG4?=
 =?us-ascii?Q?G7QeIT6t432eWoC/sAtbZ32ujuXNOG49W7wsG6ki0Fm00Sr1D4ABuiJrA1sT?=
 =?us-ascii?Q?ldIhXxnyY3Zdu18Tt9CgbLPCWvkviHWzECmE48T1iGarZpGmYFsubXnw/4LN?=
 =?us-ascii?Q?gjtFdA9rGQdbAOmpLmtpPWwntQPp2khbPducq7d3wYI2UQvzUm1Er+eUCx5P?=
 =?us-ascii?Q?VAcDhQ/MMt0E+EeLgJINQcwVwYiQ0TKnaB5/HlU4yRCyqXRWfm+9k+cn279u?=
 =?us-ascii?Q?GqwdQ+VS9fGp5QvU/Aimy1urnKb0P0WjWCL3RYJwuK+6eLjYoh4HeWufC2F8?=
 =?us-ascii?Q?MC4aN5x/NZKcIm+e/pQjXQf9VfZVpFYcanTvKLw45oNY6EdwW4VQWBxfkPGP?=
 =?us-ascii?Q?JSwcaofZ0HNHohv3h4F/0/SWpS1gQmg2XMdkB4UqOstdSrNjfT8YkOlPJia2?=
 =?us-ascii?Q?FIhOS8pzIHC8z4fx0amjFjWZwQiWLqux8npuB1H+GF43ZJzOzFqD6QS0zLgR?=
 =?us-ascii?Q?NejUE+I+ZhK4akDgvCIANXZEs3s5wwz4Wl1PnWUUS0hrJWjeg0/eAwIlMMEs?=
 =?us-ascii?Q?TmIGHsO35SkH7eXGvWYKKMn8SRFkNZ+b1kh2x7cniAPBM9DkjJG/Et/hlqd1?=
 =?us-ascii?Q?3QmhKoafi/F1KFy8na8pp3mAOcvi+TLuCN1vfERNWaM/LAmJLkh+2lVn8nc5?=
 =?us-ascii?Q?BnqTlJpgAcko0zMjJdS4URj+UvZW/c0FzWRcANbkI6u23J8bB8dvxF6m5EVg?=
 =?us-ascii?Q?5ElIl9iBa3rzA71VRAmkW2resI71m8Zc9My+nmPJzGYRjJvU9D2UOL4frdqT?=
 =?us-ascii?Q?FavvFcQg5QPUEVGe0mcI48CXyYz+l4a71RlcIehOELqY9l8iWB1F+/I9Kt3R?=
 =?us-ascii?Q?BUZEtIE0Uq5znc6ajgBN6xJ2BsEbk+7nRHS7xVwH+oJvePG3zT4m/PvvkCyp?=
 =?us-ascii?Q?9wpQlh2uGuNCCcYr9ZB4lPNDo3pIjtgH+jy6+AgD0SgL1SeLcBdQaiU8EGtX?=
 =?us-ascii?Q?VogFPLpvxl2XtTj8Nl+qQEcV3bYFTy7OFPJudSMBDs4/1jzqzaCbnMkeA1kw?=
 =?us-ascii?Q?BJuRv9a1z3SmTmXy+c9hR+p39TufUowClA65tjnFNFWbscaSDFJki+3qc3Wb?=
 =?us-ascii?Q?hXKTOSzt7FU+lMwNClE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2fe04-3690-4d9f-76a2-08dab2b4e41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:05:21.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqnZTXgB/skCR2d384l0brJW0/x6S1mV5qKdkX80HBz0YRRpvcEu+aflRrqbcN6evsHhIMNFHF5jIolzkBThIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Thursday, October 20, 2022 11:01
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> [AMD Official Use Only - General]
>=20
> Hi Ray.
>=20
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Monday, October 17, 2022 5:57 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> > AMD CPPC boost state
> >
> > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > This MSR can be used to check whether the CPU frequency boost state i=
s
> > > enabled in the hardware control. User can change the boost state in
> > > the BIOS setting,amd_pstate driver will update the boost state
> > > according to this msr value.
> > >
> > > AMD Processor Programming Reference (PPR)
> > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> > > [p162]
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > ---
> > >  arch/x86/include/asm/msr-index.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/msr-index.h
> > > b/arch/x86/include/asm/msr-index.h
> > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > --- a/arch/x86/include/asm/msr-index.h
> > > +++ b/arch/x86/include/asm/msr-index.h
> > > @@ -569,6 +569,7 @@
> > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > >
> > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > @@ -579,6 +580,8 @@
> > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> >
> > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > MSR_K7_HWCR
> >
> > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> >
> > Could you please make sure address the commments?
> >
> > Thanks,
> > Ray
>=20
> If I rename that the MSR definition string, that will cause lots of drive=
r file
> change.
> So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR is
> mismatching in the CPPC Pstate driver.
> If you refuse to use this new one, I will reuse that old one.

To avoid changing too much stuff at once how about if you give an alias?
IE something like:

#define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR

>=20
> Perry.
