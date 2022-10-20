Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33E60656A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJTQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJTQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:08:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481D1213EE;
        Thu, 20 Oct 2022 09:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI8wKSRocMqmxMQPRsVvaxeOIyQZwF0sLjXiocmCnKfnt5uoVFo9XxCFeVc4tUOVPW+BP4wdC37wuhz/kD7n3K+9Zn/XNI8Ujooh2c5hJO6HfWvJH34pvR/M88Uz9YP3EBfWJHLYZPH5fvEDQhCQZll+rKVLNrNrSDdvHTEVlAE3ABvyuO2g2EMNjilUCRG5fwEthmXMKjJnyy1DYqLt9St/wOUKrSZXTlbXpr2Gbk4X5RZDSWJUH4Y+Jwzkx0jHzw0E4Y5LydVtmfQQnKGJM4OHpUh1j1dc8CZw3Aw2nudpDiSeKGR+hZ9gV7OFQAVkLYGPog1LejA4l/3OBwPMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJc+SS0ygQiJ0K7Lmy9fKIctHkvEMeEA/ZQxfccpIno=;
 b=iKF2aQSrz4mnjwDpmU6Tx5031e2sOsZnDkSNK0IbFqecvkHHOAsZd9DwlISgPWb8oXuZkEmsYq/KT85X6vWyu1nMrC0KDtySc3aSEcse+iHLdsoJNaLAxCkslkOKHERODz/quC2WC1o1LwLo8kJFE1e4BRgDgpG3yrJQGYKgZavaV1+Xwsv5VPnsXMb5F3AXgb7hXwfQ/x9/cFcaNtNVIQdxB2r2wf3l5CYiBOjPNLuw7FHbEurIXv+o0oC2nwNHa+llrYCOaIlQdNvv75iRLNgf6mGG6aSt48lyd5XeMnJKqE9W7zw5IEQw8x62jfGreSEpg2zhuxAOgxuwpDLBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJc+SS0ygQiJ0K7Lmy9fKIctHkvEMeEA/ZQxfccpIno=;
 b=cWtt312WW3RhPzXLEc2oRE+/eOA3EWKDK2DSlye9xfJkByreULlgY2aRZLQh1FbP4Qr22zWfp9hpL1nHD8BKsndxTAA7R3igr+BS0PhqJmHR9r560liAyAQLHp0WNRWMYC4eIctE1Himsf+kUqppeA5MJXnLyoG0RB7+ydNgD4U=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 16:08:30 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:08:30 +0000
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MSt/PlF0KNBQ02nB5ERDMK6Va4SZAsAgAUbdVCAAAJ5gIAAAERA
Date:   Thu, 20 Oct 2022 16:08:30 +0000
Message-ID: <DM4PR12MB527859232006A7EA78C01F8A9C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-20T16:08:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 41b5ff48-7e59-479a-8d90-c2774bc66f65
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7492:EE_
x-ms-office365-filtering-correlation-id: 4d8e6652-0799-45bc-99bf-08dab2b554ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/HyQhdQ6rp71I2mkQOHB78YemZvN4KUErxFDLXe5fzAVATWWLjqjxsaKF5Nac9O8tb8Sxj20Txn1kTPiKJGt2ERcT5H8WP+qmpvkTNKuqAn4RoKIOKiFWrMXLs3A4uoAnmsxwUp4rxfDZwKmg8qRu8ef+YSU7c8nx5JfAaqDKf5nLkrxFM7//TIaJtqVKa0DcAJcAaxuuzLGr8Wb4O60ai4TDXugDdoJQpeSxCHjTIB1Yj+OWCzt1grLT4KoHudtzHeqPpw9NBsvls7tdaNZKbUynapfkUteo6tEcB1f5oghKPTdOGN088hsYO+SJaxww3BIAI5CqgzhF6d5BeAeQHtAV33NhjaN99wQyCMb2/VmSqfnCH9JEm7EwJo68X0xf01UmafFI9WXgD7f8v2iOcKfVoSOzEI0uywebMfe0u4/sCuiGxS1PWeP9L1dRCzrZiBSu+IUMf7tZtgB/OOppIgo+z4gZLjzcKV7x03gzluNFILdHaVuBERNlf5Dc4rsNyXd42vbDYWBb3iiLmqg6bqfTMbvBCv7ZMxxJIiufvEspEYP7/x2TAQJc+bmzmXC5pq1QxbRlOvrqBBDvzmWKQM1jBSoCwgmd+gB1XVAxoB4LxjLtfAe15gu8t7vcXZd2o2sIVRbZ9Zdq2/EdblW4+RWPzPgLGcCkplNylUv1lGMcS8S/lOYgeO/vk+AOqSG//ST8bePXn+0rmrhhScz4JDVmu/KX6GKiHNb+6lKHJvAmINK1liItZ1y0bqIjeljHpithDI6/UUY7+sDh0hVOs9IqOT/GSv0gY6gKhYhxQNhLcYxRUiG/wRGR50ly3FCJ9/mdul9Nz9wlf+0scJYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(71200400001)(186003)(6636002)(5660300002)(52536014)(86362001)(8936002)(66476007)(41300700001)(64756008)(66946007)(38070700005)(4326008)(66446008)(66556008)(110136005)(33656002)(316002)(966005)(6506007)(38100700002)(26005)(55016003)(122000001)(54906003)(7696005)(9686003)(53546011)(83380400001)(76116006)(2906002)(8676002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02aaaVasVQVXDErlYqc2gaR9GjT9NgRPPY3/7+oiDYl8HPoa0MRtXMvYKlfi?=
 =?us-ascii?Q?888ME7tOMaXTlTEYQWqdW0qQShNKCg1mD7FY/qhj6SYHUbqQUoreJJCev97c?=
 =?us-ascii?Q?ylOfTzUzfqOqdJ86Hnn4fGeKZxm4jxFrZOdYH2F2ktpox4UOjxIWLqdzFKY4?=
 =?us-ascii?Q?J8ork36ehLWuWGEP3wDUBCLwneItKmszMH4I1fEr8F7vbai/dfR+MnwpWIgk?=
 =?us-ascii?Q?zIqJ2xvdE9Sts/wVRrqAlvd4XaZWaXg7LaWTnGDIPdlE++TreqsvE9r+8RTq?=
 =?us-ascii?Q?WgoO5yJTjphiO/2P/+MsPxHZx2ZaJpSaFGG2U8zA+a+9V9SSVXSGxwqJo3cB?=
 =?us-ascii?Q?cY1wLSt1tmgSd1Zrcy96/B1ByejGO35TwHKGjxHr98UwfTRkTDiwHRM+Twfw?=
 =?us-ascii?Q?NnYe1dNm1OuRmUecnL6jIiVxQi8wPnt6rNWPusCWAeUgPI3+UTuhPLwjxIRl?=
 =?us-ascii?Q?U7x6RIu7UeRuiZGt/7ee9JurK623vEyKYX/99RqfMzrJarZmFH6bY/O1fFKM?=
 =?us-ascii?Q?QJO4Zy7a0ssrQA2hV1PA7eJjqAFDRIoablqbQxUsObIHIuWmkWXw1xjpIwjZ?=
 =?us-ascii?Q?096wr5v84W965fSkI9hrfgGZub4rs3bZN5O8Z77Qp0hyuOn3akWMNjsooW2c?=
 =?us-ascii?Q?Z0zWl6YFH0c2rT7XNhwD3fd3DqL4HPgvkKy/6bjiBKWYMEZwYrvAIBDIoe3Z?=
 =?us-ascii?Q?V5+FR5Zqq5/VK8CQoO1g9XSEP0HdQuXis8ZRynDo76zP18g3qIpXWijoJ51n?=
 =?us-ascii?Q?WgZRhtVJT2OJqLjCp5XH8f0U4QXTpt5smsDhP+kk0FPLjG6x3xUlYNz9l6ES?=
 =?us-ascii?Q?6PLbxOMhVPJjEIfIrpk/ejuU2OdWKSUdWV1yjfwkQr4jcCvf84dnCx1KUPHV?=
 =?us-ascii?Q?2/8qQxd7OX4EvAWKSmk5PlX2N8uGJYnaH3AyOfM3COH7Rr18WwRYa60Z46P3?=
 =?us-ascii?Q?e2vAa3BaoIKNoWnIlKLD0a6r0aKwt3pW/zbQaebTs5vtTpkb+CKtd4q4J5JV?=
 =?us-ascii?Q?e1esaKO62LxquZHoqw8Ia7PG3O3OJ07llE7Sn5y9ssZJGb57ai1vjjJN43ES?=
 =?us-ascii?Q?Kz2cFSdD0D0SfVIlrhoItvvGdI1B1lzCjCv4mIYBJkW59AGh5CHF991y2Umf?=
 =?us-ascii?Q?025LFN43Rt8zBHIjy/gOIKGGxjOOqYrEYeunKO5dCCo5zGlpbUL2+RwygmfS?=
 =?us-ascii?Q?7ww1d0n64TYdblhnefjJeb+5hx4UrdACbfGAR6nUVZaGIkQrRmtd1FHsNTto?=
 =?us-ascii?Q?fgKrowJV+0SQ7tiDmq8uUtMS/9+6hxbXfRr7m4QFuLSR62CR7sHUgM6g2sm/?=
 =?us-ascii?Q?4KWsHeGUWut1bfngR+GWw9W0Gu2Fequ9nslCFbH/+PkzUVVjetNYbhiUh2PX?=
 =?us-ascii?Q?4E32AJ0iym13AfJsr3PCJNhM57VpYuxAQOBKWp9EDfZlzYFbDqr99ohd3Zn+?=
 =?us-ascii?Q?IQM80hs65pS3FhFVcykQ83Lcf84yTo4C9gejCgKcwA5UTqur34UXpdl6kDcs?=
 =?us-ascii?Q?DKt2YPyG38APpwP1/XAfUPRKdRiLmw8x9b1xmHNuEfwOxCWgNbx89G1iZCaW?=
 =?us-ascii?Q?Vf4I2/noZxVoj7+Qbvso1XCpAYYcIweFWbsAsCfu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e6652-0799-45bc-99bf-08dab2b554ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:08:30.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ge9KR9k929prLxSb6I1M0M34tHvYIhnLncbbcQzzinpa72hdlPiEu6v8Y98wVB4pEwldtesOkhNHBSxyhzeugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, October 21, 2022 12:05 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Yuan, Perry <Perry.Yuan@amd.com>
> > Sent: Thursday, October 20, 2022 11:01
> > To: Huang, Ray <Ray.Huang@amd.com>
> > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>;
> > Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> > <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> > AMD CPPC boost state
> >
> > [AMD Official Use Only - General]
> >
> > Hi Ray.
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Monday, October 17, 2022 5:57 PM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>;
> > > Du, Xiaojian <Xiaojian.Du@amd.com>;
> > Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > for AMD CPPC boost state
> > >
> > > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > > This MSR can be used to check whether the CPU frequency boost
> > > > state is enabled in the hardware control. User can change the
> > > > boost state in the BIOS setting,amd_pstate driver will update the
> > > > boost state according to this msr value.
> > > >
> > > > AMD Processor Programming Reference (PPR)
> > > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> > > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> > > > [p162]
> > > >
> > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > ---
> > > >  arch/x86/include/asm/msr-index.h | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > b/arch/x86/include/asm/msr-index.h
> > > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > > --- a/arch/x86/include/asm/msr-index.h
> > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > @@ -569,6 +569,7 @@
> > > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > > >
> > > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > > @@ -579,6 +580,8 @@
> > > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> > >
> > > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > > MSR_K7_HWCR
> > >
> > > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> > >
> > > Could you please make sure address the commments?
> > >
> > > Thanks,
> > > Ray
> >
> > If I rename that the MSR definition string, that will cause lots of
> > driver file change.
> > So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR is
> > mismatching in the CPPC Pstate driver.
> > If you refuse to use this new one, I will reuse that old one.
>=20
> To avoid changing too much stuff at once how about if you give an alias?
> IE something like:
>=20
> #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR

I prefer this code suggestion.=20
Then the new name string can be matched with CPPC/Pstate driver.=20


>=20
> >
> > Perry.
