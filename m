Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031A5F5865
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJEQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJEQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:34:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266C2733;
        Wed,  5 Oct 2022 09:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpVOB1l5wUdX2sKAoaaiiJW6f8IaIPcq/sYrtdj/1BehIsO7NMn5fOf5uGeKNjRidg0Dkh0c4mit2rUhqizw/6OrSeiT8cpuqVYWGrPfvbvw57X7BU2pKOuyn5gLW7qaX0AcmPE8V6lPx6AvZcG9Z1eMxNNwswJ6Q9zVHvkPshjK0qSfiAd9y5eFHKTBavx7l6KPmLFZxGaQwkbiFcKnIZ/JwYqnRb/S0oqnIiMgsVHMm/k8HohkmOkSN6suAaztRhoj3XSCjeJ6ShvKcjpY9NWE2o6p7hZe2T81Bg5RGJLqb+Z42hsD2HeV+m9wLh03dWVNMdyvrj2dl3T1ztyyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIGVIeHfLfLRb86aot1fNd3UIuGETXWCypufcigfPjI=;
 b=N6g/nji2NCIe1yokVsThZd5KSZqF9GNysa1d1ZjqVXs7ID4Tdy153rIRwRSySos+770Vo4NJ9oWvZBY3WubbKLv0m4AHDcu52xoPI0j6PTAOOOZONMLmFDgFqyIFwD0rJPzi80RvOZKfWXswFtddoC4SxahqT/1STf7UGME/mv3EhUN3zR/8mnjQFUzuhP0nPSvVWt4ArAmEMnBh88q0SLddLkMHowBnuS23+jXWws8raCIDSWBtSk+OfljByqiFTjCE5pGqOuEVuA/E9Kq5wW02vidHqNMO2vKhXzMDn9vtdnKFw+Vw66Gf6jfw1QnjNRN+e82IKnmlmSJUkA8rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIGVIeHfLfLRb86aot1fNd3UIuGETXWCypufcigfPjI=;
 b=z+v2b039jIQY4oD+G90r9TebBjjYI5wMC+xu1tb3h+2gZwweQ2wv1Ai/0kkc2UChwMDF9BU44hiQUB0UphhNJAusW87p28yqmZEOLstIbcCYmMsVAlQyHYTgJyJa0jT3Ha7RBL473y8GszgIAvg8U7ZcTWsK8f8l5D64WVC0PBA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 16:34:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Wed, 5 Oct 2022
 16:34:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Chuanhong Guo <gch981213@gmail.com>
CC:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Fridrich Strba <fstrba@suse.com>
Subject: RE: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
Thread-Topic: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
Thread-Index: AQHY19zK9aCnRiLTCEuUjrBkMq19Y63+uELggAB2fQCAANHrsA==
Date:   Wed, 5 Oct 2022 16:34:37 +0000
Message-ID: <MN0PR12MB6101BF3E9F579B8AA23954BCE25D9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221004103341.12646-1-jirislaby@kernel.org>
 <MN0PR12MB610136EC41E0D00F0BA7280FE25A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJsYDVJsuYvAyFWwoW9=K_9otJR9Y61Wfk_w2e_K7WiyWf3Xjw@mail.gmail.com>
In-Reply-To: <CAJsYDVJsuYvAyFWwoW9=K_9otJR9Y61Wfk_w2e_K7WiyWf3Xjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-05T16:33:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ad17c1a9-c168-464e-8ef4-cc499a7eefea;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-05T16:34:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6394ac7b-5732-4772-b612-024f35a509b1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW5PR12MB5650:EE_
x-ms-office365-filtering-correlation-id: 0612a6e9-5b4e-4eef-a10f-08daa6ef7e41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KusTmc9xPHyYZFdk5VoM+DkzSTm29CLIuBLcV70Fi8M4uldC73HWFe/DBWDeggb3XEN7Rq/PmrVx9jqXzaKJBRhtvISgFk2RwMVYgeXEBLG/tUGkRat5hwqF0ISYrXkQflc/yrVyCg73RLGjjxpAe4MzPLbY2kdJp5UCUL/MuAQxJitJgPTmV4fNwx+mIvFEX2uw/IN3xrL8WakVdeCxz80PRuNjVSO6CYmkBwTEo7igdGUYhn5KqelUS1XdsB90QvTnL2up9bDvz4rN76nU9hpJV4Xpc80QMet0OzFHHUkQ48SlIsDeL4pzepRv0nsaObJXzz2RFbbV0bnHd6rSRfthEX/Am+YHBzb20I+Ta/H9GYoLnqerJ8zgDoaaNIlTLq3AL1OdSenNzrgVdc1GM3VWoKQ4xQzrcqxTmSHY45cQiOpla7/wWCZb6qDRG9ij24qE9pSQRn3rplNuE+a6GBSnsq+lmhg1S3HNScFQfhiNAE7jvsjnpHt7mHEqeFt3Bl5ErDVIkOt/+vDkFYtJqeyGqWxMLjzzcv/c7J+Dr8k8u/BVzkeiTWfjjAo+ZBsDLcRSr/eFt9GaRUwYABJY+XDOJnj4flzk3TTLPm42zZYD4cUEhUaYj7bmmh4wZ5pwqWaBUENB8z/hQtJNON9ctq5rRvKs/ajFQP/rvvFZqaWhs8EYJI86s6Jl1ND8ihTe9p5iGpuHL6nEef5c489C+sZhsKlUaLoanBKpa4KGjuzE0hOOuIOqBrPWMoxtCzzu+2xg+wbGyq5FQAmWHgMwhdXRjSNmnu9FiQLk+Xftu9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(966005)(55016003)(53546011)(6506007)(122000001)(38100700002)(7696005)(9686003)(26005)(83380400001)(186003)(52536014)(5660300002)(41300700001)(8936002)(2906002)(86362001)(71200400001)(4326008)(8676002)(45080400002)(316002)(6916009)(54906003)(76116006)(66446008)(38070700005)(66476007)(66556008)(64756008)(66946007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5u3T/c+8z+kbJlJnYylwowCv0pWCSriCJyfoVPPIkWw/FkAFO2Chhni7WSP3?=
 =?us-ascii?Q?dc1vmkfbhR82Cnk4FT6J0qfZ1GsqiKaLr7t6juTYxwjcYgZav21yCHcFU/Ho?=
 =?us-ascii?Q?5xPDngcq2anfhJP5FwQdcv/LWWgPmBEPCkEBI4diq5UGxF2NwIHwL5mDkISS?=
 =?us-ascii?Q?1MfMLKVzcoBnJ/bpAxQzuITHwjN0bGWnf8DZtByTNoFitS9ZxZZwePZbVU48?=
 =?us-ascii?Q?qyE1Kx2hVygdQjjjc99FgsDcdsIYtpsAzvvkfZI1p9lnP0bBPAg1g8W+h5N3?=
 =?us-ascii?Q?gVHV2FYCeCrMV5nnaIPdtcf5LuTTlm9btjwWRasi8nVQMvnVw1GRbeYKoDbT?=
 =?us-ascii?Q?Rj/wQgi4gk5cs0HTD4xd0eowqBcOXcSJHWzfDdhEmd+shI9+esOOn9NPID0R?=
 =?us-ascii?Q?K9OHZVztinLDCpH0k/qfRlZV9EoWZQ9TSkWoOXAhEMhBOuNBCjFsiDCXAz2s?=
 =?us-ascii?Q?1zuVR4UJMJHtl9brdE3qJ2R8S6EuI0EypQzda+u5IYDVRH7LT6P3DFTnTyg4?=
 =?us-ascii?Q?Psssjdj/CQjiNBfyNy83PYuUPJ4W8Edfxybe3Fo/36IVHa3uJmqc9txxATAe?=
 =?us-ascii?Q?Fkvfgx+J15xr0n7UL4387exD/EemLq/8qezwfK53nOcHqDzdYuR4zkQQa5Dc?=
 =?us-ascii?Q?gQlzamprAPAIGBlj38Hbjqc/SawvDWZWBep4HeHyJieWuELEjUiYx5T/+Wq8?=
 =?us-ascii?Q?kIvTbuYYgZg1WVd4LduYz8RZbWsHUnRFocldUck+19Mrh+eW+k4bxrFrohjz?=
 =?us-ascii?Q?4byD/0/P66xezZg32jkPHHGD72MzX/Ru26yzQ2NWQZKIMx2luU4vvvvdR43a?=
 =?us-ascii?Q?b6+h6fieS90/Ukn0L34nTCLYJKZA0xNjHNMgpV4OGORvD6KuXw49cx0AGUAY?=
 =?us-ascii?Q?EBomTc8x2v/LK0d6rDg+34ezWx7jQRdnMHEsj+AVIpRl3zgtl0KGzoCeVwXy?=
 =?us-ascii?Q?K3fRpx+xHF84UvNwKR8TRYHDXS4iKfZ8GyoUoYp5Er2OIyV/sgjF1y+hR7AM?=
 =?us-ascii?Q?ZzqveCmsXsz6NE7fpnPsEOMEMl+eE0kLpW4GgHn9zNMhezwmwOd3czO5voEP?=
 =?us-ascii?Q?pfeY14kEKQmKUoQY1WTnBrc6/jLwJ149c3UH4fDCpml5taWl+7J3UY0iJrp5?=
 =?us-ascii?Q?kkucV44XuFsbj2A5dFdfynrFfc8mAC+B6cXTeiJ5vdPEHOoBPzuwCFrCycKB?=
 =?us-ascii?Q?YzXzytwZcyGdZPIk2jngVdXWpjFWqHGSfFDsIEI7tGgL47+C9xofEnzgmIWC?=
 =?us-ascii?Q?/KrzqXaoEz4lR4hwM8T6iQfCJzrioS8qcm39ag+W6F3/1IdfnzgZtqA1dyx9?=
 =?us-ascii?Q?5tVkS8jbNrdi8ajG38G/ppAMx9jCCgq9W0sR+eLu43wrBvCJe2peFmK4z0MQ?=
 =?us-ascii?Q?979K8cpUVwut1vzsvOM0PaXfUqkbthyxHTta3J70rSlJGzcIx4z2lZVTcZwu?=
 =?us-ascii?Q?sz8DyKBAsLGKAyMKZKA56gXZRSICqJ3B+jBjgr7Gmmq7zRx+GS5FiYgl90cv?=
 =?us-ascii?Q?UoYSDGZu92dro+DTNWrxuC1s2jy60VVoUNTGKvao287Ka3ySqSPteuHK1OC5?=
 =?us-ascii?Q?NuiqrEybCvBNoFXRPPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0612a6e9-5b4e-4eef-a10f-08daa6ef7e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 16:34:37.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BLDs32kjCWbxP98DotIrJ2cUrdWqP4F+c0Ud5ekHGSGyNAyS7q0tJFb7V/LGM3tq258yDUQfvMvlH0F+0J/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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
> From: Chuanhong Guo <gch981213@gmail.com>
> Sent: Tuesday, October 4, 2022 23:02
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Jiri Slaby (SUSE) <jirislaby@kernel.org>; rafael.j.wysocki@intel.com;=
 linux-
> kernel@vger.kernel.org; Rafael J. Wysocki <rafael@kernel.org>; Len Brown
> <lenb@kernel.org>; linux-acpi@vger.kernel.org; Tighe Donnelly
> <tighe.donnelly@protonmail.com>; Fridrich Strba <fstrba@suse.com>
> Subject: Re: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO
> IdeaPad
>=20
> Hi!
>=20
> On Wed, Oct 5, 2022 at 5:02 AM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> > [...]
> > >
> > > White-list this specific model in the override_table.
> > >
> > > For this to work, the ZEN test needs to be put below the table walk.
> >
> > Unfortunately this is the second case that popped up very recently.
> > Another one is listed here:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216552&amp;data=3D05%7C01%7CM
> ario.Limonciello%40amd.com%7C27a32c2395ed4d2a85e208daa68666bb%7C3
> dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638005393451041667%7C
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DiLj95fy44%
> 2BT2KCahzTD8HP2bl2dD6gXVOcVnHylPWJc%3D&amp;reserved=3D0
>=20
> Now I'm really curious how Windows is able to handle all these vendor cra=
p...
>=20
> > I don't think we have a good solution to cover the intersection of thes=
e
> bugs.  The
> > existing heuristic to look at legacy syntax and the IOAPIC doesn't work
> properly
> > on all the Lenovo and ASUS Ryzen 6000 systems, but it does on these oth=
er
> two.
>=20
> These legacy IRQ declarations are obsolete, but they aren't really wrong.
> Meanwhile the two devices popped up until now both got IRQ declarations
> which
> don't match the actual device configuration.

You're right; both of these are technically BIOS DSDT bugs if you had assum=
ed that this
workaround wasn't in place.

>=20
> > We're going to be adding more to this table either way.  I /suspect/ th=
e
> better solution
> > is to revert 37c81d9f1d1b and add to the table all those that are broke=
n.
>=20
> I think we should have a list of only the wrong IRQ declaration and
> apply the fix
> just for them, instead of applying the fix to all devices and skip it
> for selected
> devices the fix breaks.

OK.  In that case Jiri I think your patch series makes sense.

>=20
> --
> Regards,
> Chuanhong Guo
