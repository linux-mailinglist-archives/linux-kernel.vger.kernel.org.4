Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7C6508E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiLSIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiLSIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:52:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6185DEB2;
        Mon, 19 Dec 2022 00:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrwfoUfCbD1wVQSNZ/8Qv/46lq7yjoVWmz9Th+YgPgXsh1CTPhklmcZn3qZMjN51FIGNsH6tnSmwBKFCSgJUe1QZifgvBzM8902wH4FIkicBNhBEE7n4UB22aZm5wB+vMlOQO0HDyXF7mgvxDVRE7RknnkXdoHSP4nBN2ZUoyFNl2dLh7DoikvgDcxQz0cP02AMq/XTPk78k/OgShmrE6kZV+jBepjuWnApr1ZS1svtP61gqN54Axb7mSz1N8Zdc0Pp1FS2NzbmeN5OHiKwn7eGN/a/GjiFpzUiwVtOGgb1YFYEYNpaZAxfahAjdsCwuKr5lbkqB1Qsk0OEkioFCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpWBi926Vp8eSlJMGeYcautkWVygSIY0cR10LjIuQK8=;
 b=Pa3fmAccALyYkFubM8AEyDHrdlUWnxwFfHRYApwdcOLJDAd7dYO65mgQrqykSI7C7NFcmhkrrLYXhVEF7qC8Kh1qLVWVFVtJ716s0ztVCYE3+bNHtpCa3hfiysTy55Vl2n2Th7HeGOOuDAD7m+9CbGxoBmvMYmj3z7Q44DgFsKEbPsY3Vsc27ugzJKn27CchXvlnnnaCfspl7+dMp7xwqqffXy+HdvNlGFm4KlpYTkK0/zhdbXdmqoSs6Mq8jm4kYv/c5Ox0r+q6AYnNE2p+vi+PPv5zBBUuVbcnqBMCE3IJPPSvkIbZnHSmEp/YqtZxBpliT7Jd6N8wTX2GvdgVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpWBi926Vp8eSlJMGeYcautkWVygSIY0cR10LjIuQK8=;
 b=WIJ2MYp8WQGRx6KVr+JAndfs2q3SGy3a1qvheJ4sxB+9n8VKyuUNyRxqvSwrPwZkiGFOyS0yv38iiOX8ajQjZvK1IfHfybbfI4bvxS8ntttxYQFZ+s7LHzwyeEdw5cz096U0hMx8FfJjckrbPotJSvS/Avg8o8qS8tEEy/1UPCg=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 08:51:32 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 08:51:32 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
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
Subject: RE: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZCvcVwY+lM4LD2E6Oda1tHNhqUK5lMu+AgAAOkBCABDrDgIALezGA
Date:   Mon, 19 Dec 2022 08:51:32 +0000
Message-ID: <DM4PR12MB52783387CE8EDFDF927AD3799CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-4-perry.yuan@amd.com> <Y5LrVdS9oFKIvC70@amd.com>
 <DM4PR12MB527803DBD30226646B81A7E39C1C9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <Y5aD1YZtDhQcm3H4@amd.com>
In-Reply-To: <Y5aD1YZtDhQcm3H4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T08:48:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8ac109a-b3f3-4552-8f1b-6c774797f4f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T08:51:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 2c267c7f-cb20-47df-9a74-f9fac0f256d8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM6PR12MB4057:EE_
x-ms-office365-filtering-correlation-id: 70a7c713-3e95-4168-7bda-08dae19e3a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sD59OyB9JkOg5VtvMKV9Bl38bIbZqIsQ7TzVXYjkTYAym4Ik0cuYO62I5i6K7v8NtYjQBWr9BKDzmUckegT2xILpI27eoatdrmdCDX76Gd5B0RLnEGXwPWZWgC0KVL0l53DDKnIkMX3iafPpMFq57jgzJyqA3mGECYxHM1Vb5In4cwk7n/OMhQYJCVWonvvWZGvzUelIna1u9agHCXZSz/U21BFD1pmzGN04Ws44wzmQfy2tjwqwDZNwvIC+ZC8Jvu0Lztz7+tk+oriHA2rWC6wSkjzlYhwU1IBYcaJnlANwtrpsnNMFDS9wWEcTWX3dydT7s3m/oUOpAM4+ctgxbkBTT4ZpyqbSQQqxcIXwQa7gBLGkP2Teojguyq8+SyOa7TKuBvmFxtaEavZR9Mhouvs0SwaUKzyDtbxTOsMGJ2aku62QhzZHiKYCtORSLt2uFTbFZPhUtRvD0eUv+TSb2p7HDNro+EPhUKxK8X9yoyyFhaccDxr5z2AiBoy5YwXGJzEIawW1coA8vS+fltxMR+jylJ/P6c4SAeuQEi+YniaZ9edWT08ly0O+s4flW3EIy3U9RV7t3PDQ+u1JOc0+vuakppGAjUCN1xCUqBOjKif2GChvcHGTvdXD2AcKpoNulzdQwjOURzD84rZ+0EVpkvb9gAFY8oF5++F3L/BCn+PSJTlNicktStx6nIcgQJH7ki9Bj3SeQv4saP6h4k8xY4TCkKIQyQt1qAVjx9jZzMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(478600001)(966005)(33656002)(71200400001)(7696005)(6506007)(55016003)(86362001)(186003)(9686003)(66556008)(6636002)(26005)(316002)(66476007)(66946007)(66446008)(64756008)(54906003)(76116006)(38100700002)(41300700001)(8676002)(4326008)(83380400001)(2906002)(52536014)(53546011)(122000001)(8936002)(6862004)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eMnO+6A9lJRprk29hkttNXkY2GIRectjyM0F8RotAn522d9U2+mTbkx5pPVs?=
 =?us-ascii?Q?7hZ3xgG2CKtv+ypbS2btzXvTqNfjZUFeBbuhMGCAT7tYbdL27GOA8bGMtRnE?=
 =?us-ascii?Q?Y4CUbwLQwFTV188OldOHIT1Rwrb9HzDdKT8x9W7n2NMcTwbtuieqJze+McJE?=
 =?us-ascii?Q?kmyRBXiLyN5lllA1uwhWBJw5HzS0nnRRSgi5ErGh1XI7EQg1Qrtr0VJlRYqi?=
 =?us-ascii?Q?bW4WVqlaw61o30h4D6K472n0F3NWAyzGbKwzJUs5BEigfFGc0yPsScIBzLDd?=
 =?us-ascii?Q?OEwBT0OfFCfNhJNTKYWvn5TmKHin6mpHTgoF85js8ItL/KIT/QyS6V5zwjez?=
 =?us-ascii?Q?AesyJ171ZVt5Pr/zt7e5TuDuO/mcki3Ud6c5fHxrUebOyyhaD+6W1JPCb4EP?=
 =?us-ascii?Q?VKe8lZ/HKXyQEJKnM9uyJedCQcewt0SMwlE79R0Ied4cydSIKeQP54VNSySq?=
 =?us-ascii?Q?yu6GvyMsGdJgLPgmXLMhpqFpMKgQJ7EKM4KuFngamGAAVX0Fpkib4PnzoOfo?=
 =?us-ascii?Q?X8uhRhaVE5bxaNwa2b7cagxpZySLjLoIfIVzb2jmuVGnOdTilYZiIQNXVXtG?=
 =?us-ascii?Q?/5XJ1BVIyyLjoCZtQBqNVK5+ZuOh6zAH8+PS7Rl5jPQlqntd2ElTr2Tzhzid?=
 =?us-ascii?Q?f+A8ajOPX9owSuT5PFKTt6LV6SIR7hHGFRYCg7Q/H25a4DcXGrQ4eq6MFRwq?=
 =?us-ascii?Q?v4TCmDuztvb30SDM+KCka8b2pHYNR7pKMot3bgd7dvqpgvT8ZsY/1YYNcxyV?=
 =?us-ascii?Q?TNrlpyFrq3+poM4DUXQbdRrk0x81zixz2DM6Pd9u1nSET0dO7eCKkNnYz+Wk?=
 =?us-ascii?Q?u3ZCzUuSVTY02BU1F0THt6Pas43aLhCYPSE5wh8zJm8cCCcuIdLqbVi5f4y7?=
 =?us-ascii?Q?/Yupy9T0rcZFwuOQDWfoY1no75McpxgrWXSbB+jPeWxE2Wb7cgz7i0WmUrOm?=
 =?us-ascii?Q?EK1DaVrbJF4fe4oOgREKv48SMg83pI+eov4eC7UNPIddHXWh0bRUJjXrv/D5?=
 =?us-ascii?Q?5UrvA4mwkSQKQKAh23zAaIgGKWnHq72VkfTPvVvRoKfm74WZsjW5ekOEf8mt?=
 =?us-ascii?Q?haBMIZR1N5ch6r/Gmmt8L7uvlzNuP5ZEGZSSiemqq/5eLgp5MLqW2s2dEImy?=
 =?us-ascii?Q?MjmNav0utzBItY9EfpcTdgVk/5KTBNjSbjmiGQ50w44olgXMkDBbSBXZQIZR?=
 =?us-ascii?Q?AkbJkj3vgIV6cdJXAxOKKSFq2yhySne+tUxuIWRX5TqlXi39ItxoYPkiddwH?=
 =?us-ascii?Q?kAbxlagZCnYSLGCDavRgf8pjngHTE9wp20OieiokIdxF6Sa543/nqskdw7xF?=
 =?us-ascii?Q?XHDEMmyU9GmadF1Oizs20FsC9L1sTxvz5sd7221aOU/arNBmy6gsuL5VzMSP?=
 =?us-ascii?Q?AZV1OS0VUDv/a52ejHZIbCshHrmiDX2eiXYrIMAt6erVzr21urrmD+xDElD8?=
 =?us-ascii?Q?dgxmN8Rgh6G+IpUKWU4XKT3jPWo6cuSkGiEQ1GSHlQT8fXE9dvWMWPKPYQaJ?=
 =?us-ascii?Q?Ue0iyJaZ8vwS836QUTDTkXzsni0kAydvjYyFGZ34Dzx3eDMbuWNyDcCQt3vq?=
 =?us-ascii?Q?8i/q+uBnhZr+6vqYlEm7rYHD2lVf/6V1Pwl4lV6D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a7c713-3e95-4168-7bda-08dae19e3a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 08:51:32.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGAOPfNB6T5hTtam3fohawmBGpcMh37GXdbDRu23SqFBSh1VGhtQoJWaSobqcaPLkmCHFKeJ1aoUZ9sH0tdQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, December 12, 2022 9:29 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
> definition for Energy Preference Performance(EPP)
>=20
> On Fri, Dec 09, 2022 at 04:54:54PM +0800, Yuan, Perry wrote:
> > [AMD Official Use Only - General]
> >
> >
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Friday, December 9, 2022 4:01 PM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> Deepak
> > > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common
> > > macro definition for Energy Preference Performance(EPP)
> > >
> > > On Thu, Dec 08, 2022 at 07:18:42PM +0800, Yuan, Perry wrote:
> > > > make the energy preference performance strings and profiles using
> > > > one common header for intel_pstate driver, then the amd_pstate epp
> > > > driver can use the common header as well. This will simpify the
> > > > intel_pstate and amd_pstate driver.
> > > >
> > > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > >
> > > Please address the comment in V6:
> > >
> > > https://lore.kernel.org/linux-
> > >
> pm/Y43aq2gMKnFRIhxh@amd.com/T/#md503ee2fa32858e6cc9ab4da9ec1b
> 8
> > > 9a6bae6058
> > >
> > > Thanks,
> > > Ray
> >
> > Talked with Mario as well, will fix the build failure and get this chan=
ged in
> V8.
> > Thanks for reviewing.
> >
>=20
> Please make sure you addressed all comment, then send the new version of
> series.

The common code  change was made in v8 series, Please take a look if.
Thanks.
