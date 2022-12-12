Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F164A3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiLLPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiLLPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:14:41 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C29B864;
        Mon, 12 Dec 2022 07:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB4E0yLRIqjc3vUAT46Npx9xF8PCwTIJIehYa8/mvq1YNP1Ds6RPVeqgjNFn1wU8lCXN01ucFMIxZ53wwUM6GNply2MZDoWwhkR+m3TQ9oZ/MYGH9K2kFJUfRmCvQ/Wdx8N11w+dSRuAK2omsV88TtO1+0CjlSRNa2hG51/Nd2ZR6qjdWwe62NODAJ+L0jYv3dOl+Bbkiszz/+kexpYwPhRy3e/+bHhazjzjz5IYEmnwbu60eyznHV1HHTGu9GxUikhOf54MFSBc75ODULcU806JV89Okwf9U6octNrDKlDxcWONGqtoFGziAAk2yDceg+CLFk2fnF6KvaFOSxcpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZieZHH5/U+lU9QN+ih8+Kg/t5M2El/9uiUx1I99jgwM=;
 b=NcCy2sCil0oltcz3TdS0Eps+IUQHJ7MeVoriC0agH+T3UWHu5nEhZ2iJsVBS94ImGTPZ2M/Sa20GXtKW5aFHKTg/AnFfv0TdIRDUt03keXn1pHDyyOPzfv5ZLdBrLM3mUj1NmbYSw7d1RkfW1hP1s3lb0lX30kFLrDVK1IGmWx4jfmBmwMYu6E70IoKyJdTBkjcfkOjXjy/o2Y2Dkpn+eoEfss2Yi0pQ9GdAhWvDNnKuOwqV9wAP6zj5ew5yEcWXGRAWPN1dcg2SRFOwk/NvcTuAcrY32boqhx974OGmeg1gabIfPnBr0VGQC9k/o0EIqzdf34qsZQM8IOqtaCtZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZieZHH5/U+lU9QN+ih8+Kg/t5M2El/9uiUx1I99jgwM=;
 b=T6VlmOfqECEQKq3e1Et7ZoMSUHfXfV3UQrCBUGtrP5MI2rc7DAVQ1ewH811FR5N/taxyz8HQI8JpwwKM0RaUBH1vppjErW3d8pVfE0PNL1dbdchK+HFQs8SdpLwWFPoZ7MmEKLCuWAOKrlMl2+uZwQpnGidaR0euzYROz7ZyWi4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 15:14:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 15:14:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
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
Subject: RE: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Topic: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Index: AQHZCvb+7vkyuCUfSkufu6UrBHaND65p+6gAgABnJIA=
Date:   Mon, 12 Dec 2022 15:14:37 +0000
Message-ID: <MN0PR12MB6101C86765969ACBDF23BF99E2E29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-8-perry.yuan@amd.com> <Y5butE2biSRddti+@amd.com>
In-Reply-To: <Y5butE2biSRddti+@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-12T15:14:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b51c720a-9ce0-4b49-b938-e15c0df74bf8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-12T15:14:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0be3134f-7797-480d-a3a4-e3b0448a5e61
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB6811:EE_
x-ms-office365-filtering-correlation-id: c067e633-9002-4bf1-b094-08dadc5395a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KR1LCxMbjbSQPnRQcyTOBpQ7POGGQd1+R5eAX2S58GZvHmSqhHvAp2BVoGIZoP6bvIbBYD4DrRbUEzHnKMLFh4Yt1u06aJel5fxA0HPs4pRilOdPKPf0yq36BJr0e3lcS2CFo8kHPWUZPEgfjuLVYBgxUUoZWO2hH28DZKgeI+fYTDvWdjaBdEjnpBtSiiDuxveQuB9hE9T7YQTApxPA5hJd8UDA9b5qYwXDO5WoHFhP283afe7BQNy3e1thtNsTGBpmrJhokCJRdDL/dhJR7cSAPuEnmk4k064Fjb1wfufcc2vdg9C8A7tb4hGXW5xUBSFyDFSwayt7+B25aJLQSRnY0WaKnkWrvKcTUg9/GtEIhGLpBgxBtzVUHWI/4eRN8eiYesYzGsRid7xRKWb7xMZ0JiosjLoT9DWzOeTJQzMlOcNBpoo/YcKe09UP4pysPCG6zc9GjXvAUg8JJLV0IhEPefate7rXzuSN2mZbWwAll7fAyiWNw3kane7ceqTU7kRdleeortjeT2hlwd5jCmBk6HPG3ihbcoZ7i1kWVGH5ldW/eEw3EPCDLVppG6ghHqIohe8w618k3wIHBCNXsSv9Fs9A2BulM6E56h5lfRihm1KK+DxRQ/mejCeRSSFr1y4+pz2JMp+PhCmkBQ4H3wVbIbHvCBv6fV5nDiULkE9t8H1vy2gsp/XnY0zDwzJgVptoOEvzjVR6+BC2TGApvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(38100700002)(5660300002)(86362001)(122000001)(478600001)(2906002)(55016003)(71200400001)(41300700001)(66946007)(66446008)(54906003)(64756008)(4326008)(66556008)(76116006)(316002)(6636002)(110136005)(8676002)(9686003)(6506007)(7696005)(26005)(186003)(8936002)(83380400001)(52536014)(53546011)(66476007)(15650500001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ivLAIxghRTS7HlKbaa/r4WaUOIVMy8RIIbrL+hOjI3JHlaCAN3uqocx6nS+z?=
 =?us-ascii?Q?8Kf+v97cymNvj85+Lqo9Uv+z/8rtcQRZd8aS/9YhDOBON6oQRJdPmHxmzO1V?=
 =?us-ascii?Q?q6Ab+NbHtYTbfszVeD+yHmMuyo6wAxJzr+WkPuSLuU3oldphg/eMXXT+xOo8?=
 =?us-ascii?Q?ze1gJFdFqqyH+r908NCtWbxhy1VNa4ugn56fo3sJZUL5qe8pLQLN6Ev7BlG0?=
 =?us-ascii?Q?C7KsSD45nTulBwu/cznM8H0sQpYfSrK/YumHLRdl7SjEMOO+YK5j9LZlPMUM?=
 =?us-ascii?Q?t6Jvla0eH2+Kj1fPWuxoiYkFvAgFeGp+8BIx4UGkVkUhORZl9ykK76Xc1JtG?=
 =?us-ascii?Q?PXf0PaOScig5FdGoTgt7qTpmqsiVNg+RbMBcbOyzW/hQx3ZxrGg4LXbDHUgc?=
 =?us-ascii?Q?JveWP9BCeHRvAplj4cnqxX0R4c7/Xxl6F5JaeH4gnaLgHslNlw+a0WjwStbc?=
 =?us-ascii?Q?TxT9Bktm36EPw3M1Du22Mcj+Bp3VZwPD1Spq2ApLhRr1LUh9gMcl8AIbxHjJ?=
 =?us-ascii?Q?QaWXCBJdJA3VKC2gEXHh0bqn7Csc0yLXodrqAMA4AN8VZ+jrt2uNuhZ/RTMI?=
 =?us-ascii?Q?pq/z2MVTV1DnkDY5kdbrXgETgy5HmfZc5dPbzrtLPqCaN0gaohb6vB20latL?=
 =?us-ascii?Q?QckAxfywutqQoFGoZIDlWeqnnxlRbi5l27E+YcZRI32YYzxnbRP8TGMEvGJu?=
 =?us-ascii?Q?BD6UUD7WxZArtzEymOUY7MkgvkPvYWFWE2u4ANebs+UyPqU9xxUbuQYnTQIR?=
 =?us-ascii?Q?+WMDNdWueFEQ7/hrm+t0rvC4uPynh0RNjdY8L1fdPMDrq3yKOi3HcHnXXFaZ?=
 =?us-ascii?Q?UMDhJBgyxLd4oiHvSIaQFQc/KeTMHE4jnDQsSwKAanCaWqhvOtpAdcDVzB0W?=
 =?us-ascii?Q?Sb8gbakZxfrNv8Zb41vdv+LqdcwucbEpyP81iS38zYHJvdZ1CENzGTaTOIh+?=
 =?us-ascii?Q?uGUNAPm8yikbSIQ7r+MP/S3i81DSzZ5dtuV3HY2/yXoDM3ceNbklTv7KaeLK?=
 =?us-ascii?Q?lgP94f9ot63gfdXpXIbikRv8vaFtn0/XlMRuqZQB3LdxKPpmKwFXloi2k8/4?=
 =?us-ascii?Q?hS4yUS5ZmpupF2nfJ158itOtc1WsIKsy1RiC04yQALFoG+jBwE4Y1Qqyw47m?=
 =?us-ascii?Q?mAMzjzesUHNuhh7J2+sqYvU1QRF4AJDyPN4JBikPp3SXgUo7pptMa2Q2mCBh?=
 =?us-ascii?Q?KM2VeBEZK5rASejhC1rAOR3Bs3OA4A1PWXHwtv/7v5i9VZr7AqMQa1tTzA4M?=
 =?us-ascii?Q?cVD1ko3hNBTKdzTqBPRZgYs/dv0MhfR6DF6d+a0HW0S1/AFHbPlRvAi3ColI?=
 =?us-ascii?Q?n5LwDPo+GuZqhPiOtmu7vIU+Nug19gAInnu4vLnW+deNcO2oeFj/2POz1Was?=
 =?us-ascii?Q?bQ0zlBdVAp2wQuqCO+fMGF7klPIj1CJXi/oQQWtbX2h5oE7F7nxeXEZ4PpWb?=
 =?us-ascii?Q?eCXBYCZBNQmUoGCTyHtOskngHaW7Je3ln5Ns3ZHegU7L6DboM5wUqtG97GOS?=
 =?us-ascii?Q?BfpkNjaoItiCT1hM0vK1cKIGeGBJj5MoDcNhvxZGpfvlFnMAj7l0b0vBRSeu?=
 =?us-ascii?Q?rfNH9yEXRhlgRw2bpDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c067e633-9002-4bf1-b094-08dadc5395a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 15:14:37.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEJ+r1jjZTiHjj5DFAgY9tx+P3YGwIYGJO5GiJHnM86m5REUeI02hUCTDZw0rCMkknDgfpdgm4udRu9SQLavuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, December 12, 2022 03:05
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
> resume callbacks
>=20
> On Thu, Dec 08, 2022 at 07:18:46PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > add suspend and resume support for the AMD processors by
> amd_pstate_epp
> > driver instance.
> >
> > When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> > profile and set max/min perf to lowest perf value.
> > When resume happens, it will restore the MSR registers with
> > previous cached value.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 40
> ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 412accab7bda..ea9255bdc9ac 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1273,6 +1273,44 @@ static int amd_pstate_epp_cpu_offline(struct
> cpufreq_policy *policy)
> >  	return amd_pstate_cpu_offline(policy);
> >  }
> >
> > +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> > +{
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > +	int ret;
> > +
> > +	/* avoid suspending when EPP is not enabled */
> > +	if (!cppc_active)
> > +		return 0;
> > +
> > +	/* set this flag to avoid setting core offline*/
> > +	cpudata->suspended =3D true;
> > +
> > +	/* disable CPPC in lowlevel firmware */
> > +	ret =3D amd_pstate_enable(false);
> > +	if (ret)
> > +		pr_err("failed to suspend, return %d\n", ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> > +{
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > +
> > +	if (cpudata->suspended) {
> > +		mutex_lock(&amd_pstate_limits_lock);
> > +
> > +		/* enable amd pstate from suspend state*/
> > +		amd_pstate_epp_reenable(cpudata);
>=20
> The same comment, could you please double confirm whether the
> perfo_ctrls
> registers will be cleared while we execute a round of S3 suspend/resume?

And if they are; identify what is clearing them.  It might not be the same =
for s0i3
and S3.

>=20
> > +
> > +		mutex_unlock(&amd_pstate_limits_lock);
> > +
> > +		cpudata->suspended =3D false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> >  					   struct cpufreq_policy_data *policy)
> >  {
> > @@ -1309,6 +1347,8 @@ static struct cpufreq_driver
> amd_pstate_epp_driver =3D {
> >  	.update_limits	=3D amd_pstate_epp_update_limits,
> >  	.offline	=3D amd_pstate_epp_cpu_offline,
> >  	.online		=3D amd_pstate_epp_cpu_online,
> > +	.suspend	=3D amd_pstate_epp_suspend,
> > +	.resume		=3D amd_pstate_epp_resume,
> >  	.name		=3D "amd_pstate_epp",
> >  	.attr		=3D amd_pstate_epp_attr,
> >  };
> > --
> > 2.34.1
> >
