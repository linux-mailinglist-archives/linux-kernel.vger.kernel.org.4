Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03360CD58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiJYNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiJYNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:23:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E917F29C;
        Tue, 25 Oct 2022 06:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy+Ba4tIQcnijkpIv6JrvkV+guNa0Ws+Zn0aGlZTGqCLjTfDKoLKMzCQWPc+QkoW9aUpBcOcNd8pXBiXAOYcm7aV6sDL1mpHc5KrlpkoPdK/5YM61I6PZglHi82RwyxxNd3f9fFDPABeL/mkdbeTty/E+k/GAEqs3G79u0nyvDMg7QL1rjw4eDDafe3kVQUNFY1wRqt/fnR+ULg9pANHuwP9cW791yumd0KDSKLzPWFJ0adecKigsJ21ahMFeBs1uo5vXb2dfh2sRSQ2OFVm45N7n0T7QnwZV2HvJ+DTvgtotsZzSNfAXpwT6OnQw/34cVFw95jc1n4DJ41efk14Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3zgoG+QLAyHS7CVp2l8LlVXV6nu0cxbeKwWVur1Wak=;
 b=oKYhUIaTL3r94X7nFyk1dQSNHSe4NzFQKRJdLbPVOWuBM74e9XdidaGEDj/Dpa/nzKst+lcGemdXeVlTB6hGA/IB7gSedrvnQfwBhrHmwLcB8ieDzkG5Jf99E9IYp3CSw/nGQC9+9Zz+5be6S4eNTuFENmZPbsMXazL/xWELOY8GGjBW4zSqoNA6XPFsOyfs+QNgEIPT2f1cBj8Irh5PcbugoqtjKUumPfKxEETPKoOFg+oZjGZEV27Ejy/3KzSN60KGoAHzSxyC3Sy5hSFZO29tRrlLcGQUGmTD4MJkgv0OPnruwQUGMsL52u2QLP+b5wufvBo2Z44NZoGV//rL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3zgoG+QLAyHS7CVp2l8LlVXV6nu0cxbeKwWVur1Wak=;
 b=CWCah2eUhmXF2Wcpt2OKxCATwfdIPvnUHdP8q8m0TZIjOmSqQUztGw3MWFxa9i5ch9s7ZZdH/lAR231Bexala4fnDQde9CDa6o3YXlIGqk2vLZwP3YzYFwn3+sDJ5mx0bCa/zc5ipchZgGwDLMEus8tcGAXNGAWSTXP/PBtEc/w=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 13:23:29 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 13:23:29 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Topic: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Thread-Index: AQHY3MSt/PlF0KNBQ02nB5ERDMK6Va4SZAsAgAUbdVCAAAJ5gIAA3qKAgASNm4CAAWq8AIAA1zgA
Date:   Tue, 25 Oct 2022 13:23:28 +0000
Message-ID: <DM4PR12MB52786D0A987CCB9CCB091F5E9C319@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com> <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y1Isg4q9Vsl8zNPe@amd.com>
 <DM4PR12MB527822E265E6D6C747C5709F9C2E9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <Y1culOyu6phXn0pR@amd.com>
In-Reply-To: <Y1culOyu6phXn0pR@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-25T13:23:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f92ea863-f9ca-4c31-b088-d5a84c3b202f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-25T13:23:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6cfc19c7-0e37-47a5-93bd-da420cf2a951
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SJ1PR12MB6243:EE_
x-ms-office365-filtering-correlation-id: c6308e3a-3c87-43be-a370-08dab68c1af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/WWcbwZA85QvBI5R/K9m7573YbVtxucJtF+LDA9XEaZW3FZTrxfaLys7++OhJhrnD5g5SyDJTPflmz/Y09F0Ny7i8DVPjFEACWYx2mLP8KzvK1jU2zvADbRkLEbf4J1x3unDxivlrp+Z6xxikmq4gybZEmH8WGfGP+ShYd0hvXvyndW2xg0uAMmqMaBkdfQ4gKklQPRfJrk5OcY8s6nJ4vxWqiuk/Cv4rzIYhzCVEfXAS2T+eBsW16G6t4f2RRbm1RVWRZtFIQmf3sb08UROQTgkLmIvjve5hQAc2WRoDt4IbPYujQ5oq3oFfjV9vSBZIZ2NkYbwftuj6mVpXOXR05EzD60p4si0d4Ry+35LZKWTrGkGhUhXvd/7/W76nZvgfj4VqM+cjvKOYXs+CQjb4Lqfq/bgtRJPjORlVHQg1gfl1t37dJ3bSGj9+7qhPxglwU8IlnRX/08E+rrb3oeDs0cu0gW8nx59wvpEjTpjb+2ht578Sc1pyVOE/LYYXTi+kgcspyJHanQygnqD1O4FwZnfFLs8x4O34O6NqiO9SzPRQaNJC0+ZISYmJh7U3BtWSNL8yAnq63VTR/4qzfABQK8UJygp2MVEA9CFTKi7TLCp9G8IVq1JPJtksm+10jcFAmrZA8x0oI2hSE/gKcFctsVdv3UFeBbcHmjYB7PaE7CjGf2mz9QIN9rToRDjykO11earyV+WjrDgztKra2da3qY+mwRAyhkLJAhz3HWZu2+sl1i5w1onirZRVWRInqvUjS2VMobMxfw/kh52TcSh0aWOBDBtFCYZDx8+dCUAujb9dCP/k7o7ym8ugFgUyPRDuE4spL2J40RLrbFKV85DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(26005)(41300700001)(6862004)(8936002)(9686003)(6636002)(64756008)(52536014)(5660300002)(66946007)(66446008)(53546011)(7696005)(66556008)(8676002)(54906003)(4326008)(6506007)(66476007)(316002)(38070700005)(122000001)(33656002)(55016003)(2906002)(38100700002)(186003)(76116006)(83380400001)(86362001)(966005)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3b/xYjDS/1+N01grRCv8WNjLxgv0cJDZNf1st/cW1osPl2asy1cmRHcShLp3?=
 =?us-ascii?Q?wCvktdWoUt8QVDyHEquH/isuV/TxDNR/x0jo+rCEKj8+pBYLXhWNGLVo7ZO8?=
 =?us-ascii?Q?eDkLZF9dmti2Q5abuFRBT4LCRWscOVF0gkcXOG5G6IAedPwEB4XNSux8Un5Q?=
 =?us-ascii?Q?Cv4BkvteceT1yvUsH+yM7Zv5ZDZeVqnl3rPRwPmpC/Fvy+ZYlv0uSr7iUy88?=
 =?us-ascii?Q?35tVuEsaNBm53yHrG8EML+5Y5w1AtbK+1MGkldIYTm4LExH5fSZy2+hXZ3K1?=
 =?us-ascii?Q?XJOyf7qi32XqlpEDsFqa3T10ZbQmMK4WLl+zPS0jUMx0chbtMbm7Y1US34kI?=
 =?us-ascii?Q?LaICITwSOod2lBVb47evzJIHF88/UvG+Ex0WvLQGe0HN5T0aP+B73dWEV5Bv?=
 =?us-ascii?Q?mJJmmRJ2V/rFsXRNJwli/xUl0KgiYeTQ/6UYej29RU6eyQaa/iRsZSGG/i9S?=
 =?us-ascii?Q?isoX8RWpWRBNOyT+iIhwc/fCFvdWXLkOL4qm1bbIB7EuY7uJmGgOsOOZZrR5?=
 =?us-ascii?Q?Uq9nQAVvgaooE5shk+Fo/gASD1+oDSKCOsrbLhN71B6m4VvXJ34U2i5utWzl?=
 =?us-ascii?Q?zgzaF6bPvgf2jUYHBMIXijq/0T/RhJ1DovNg8/jjOcgZaJoXfOl82COlVADP?=
 =?us-ascii?Q?XSCtXmFMe43rsZ5wyxKg0TN46qiMmSNVkw5nJje4LpqCJTvSN1ZZUOUalVSU?=
 =?us-ascii?Q?reGupvz1UOMOtrS0rg2cEEpXyMTmlzNeu9l7MbJqmGZNq1UQHqurn+VoXhiI?=
 =?us-ascii?Q?yLQgNP874R8eaM2EkmZpWXILQpDAQdgXMuGdCdiWaHXX/BCKCgHG5V9U3UZ8?=
 =?us-ascii?Q?w/Gl6Abm5/9VVlCWJ7PCulbj/yB80jAvgTLJ5V+1uAJQI/we8yfI1qErhqxB?=
 =?us-ascii?Q?BGd9dPsd8VYdrxTnngBlM6JdMeZmi3DZjR7FA4M+RFsnEEhA7VzyF8Nyj+nl?=
 =?us-ascii?Q?bx7rTfD/mJwiIz9jRxN4Wai+bL2ilppeH1tr8Kw/trFFZXpCFf/J6WjcENvi?=
 =?us-ascii?Q?qm1IJPxaGuDcQphQ5JYjFX61wKQ/dslEJVlF91kCXmYsY5RMwm8oFkZHOZwC?=
 =?us-ascii?Q?c82NbuDyPWpPJmKeZovIyh1Y4FhBDwnz1+DJQMspTKDcBTYWXbfJ0q6x2y9j?=
 =?us-ascii?Q?e4zbx5NpWIOk8azTA7F+JxNIfkqPh6gpWCAyrDtqkR7znWZ5WJ0EJH4b5Y9Q?=
 =?us-ascii?Q?nXv5+I+iMe+qWfPm0i6uUBxBCbejQa2V+hIVCALBvawRG1ShPlZNFrmiqzF8?=
 =?us-ascii?Q?GsuQaMOmAP4ESuW2JCMBwSVk66NmMc0ViQtN2CuLA81FyHmD1LcvwgvaPN+f?=
 =?us-ascii?Q?m0Hu9/XzXdc+sY5dPvHIHhAdL2BC+I5zXHkRBg3rVL9JPEqY9/g/K4IHklCS?=
 =?us-ascii?Q?e7QEYqfphhdDcuxOg0U7dz0jpiHlUXVR2m4BMEgoHSTxWH3/j13geJZA7UyL?=
 =?us-ascii?Q?iZAq4mFuQneld6AZujMPy481rCKaxE9gbCt+2pgjqmJi4BZ7xIz3WEEy818q?=
 =?us-ascii?Q?xe6UushJeyrykUfP8kHkLzit/S5EjDPARoPlqjU4wHxF/L7QEcF4kc1XNvQU?=
 =?us-ascii?Q?TakcyO2HiucTb4BjYes=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6308e3a-3c87-43be-a370-08dab68c1af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 13:23:28.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObHp0TZqo3KF4vZ2FEP+rQddLxSFQ6QGj5UH4EztuBHWZp8Mdi2yx2tpFEY/WjNWvcOD8AdH9IrdzqKWw+5oXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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
> Sent: Tuesday, October 25, 2022 8:32 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Borislav Petkov <bp@alien8.de>
> Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> AMD CPPC boost state
>=20
> On Mon, Oct 24, 2022 at 10:56:50AM +0800, Yuan, Perry wrote:
> > [AMD Official Use Only - General]
> >
> > Hi Ray.
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Friday, October 21, 2022 1:22 PM
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> > > viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> > > Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>;
> > > Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> > > <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Borislav Petkov <bp@alien8.de>
> > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition
> > > for AMD CPPC boost state
> > >
> > > + Boris,
> > >
> > > On Fri, Oct 21, 2022 at 12:05:21AM +0800, Limonciello, Mario wrote:
> > > > [Public]
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Yuan, Perry <Perry.Yuan@amd.com>
> > > > > Sent: Thursday, October 20, 2022 11:01
> > > > > To: Huang, Ray <Ray.Huang@amd.com>
> > > > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma,
> > > > > Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>;
> > > > > Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li (Jassmine)
> > > > > <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org
> > > > > Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR
> > > > > definition for AMD CPPC boost state
> > > > >
> > > > > [AMD Official Use Only - General]
> > > > >
> > > > > Hi Ray.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > > > Sent: Monday, October 17, 2022 5:57 PM
> > > > > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > > > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org;
> > > > > > Sharma, Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > > > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > > > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > > > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > > > > <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>;
> > > > > Meng,
> > > > > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org;
> > > > > > linux- kernel@vger.kernel.org
> > > > > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR
> > > > > > definition for AMD CPPC boost state
> > > > > >
> > > > > > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > > > > > This MSR can be used to check whether the CPU frequency
> > > > > > > boost state is enabled in the hardware control. User can
> > > > > > > change the boost state in the BIOS setting,amd_pstate driver
> > > > > > > will update the boost state according to this msr value.
> > > > > > >
> > > > > > > AMD Processor Programming Reference (PPR)
> > > > > > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf
> > > > > > > [p1095]
> > > > > > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-
> > > PUB.zip
> > > > > > > [p162]
> > > > > > >
> > > > > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > > > > ---
> > > > > > >  arch/x86/include/asm/msr-index.h | 3 +++
> > > > > > >  1 file changed, 3 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > > > > b/arch/x86/include/asm/msr-index.h
> > > > > > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > > > > > --- a/arch/x86/include/asm/msr-index.h
> > > > > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > > > > @@ -569,6 +569,7 @@
> > > > > > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > > > > > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > > > > > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > > > > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > > > > > >
> > > > > > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) &
> 0xff)
> > > > > > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > > > > > @@ -579,6 +580,8 @@
> > > > > > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > > > > > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > > > > > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff)
> << 24)
> > > > > > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > > > > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > > > > > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> > > > > >
> > > > > > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > > > > > MSR_K7_HWCR
> > > > > >
> > > > > > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > > > > > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> > > > > >
> > > > > > Could you please make sure address the commments?
> > > > > >
> > > > > > Thanks,
> > > > > > Ray
> > > > >
> > > > > If I rename that the MSR definition string, that will cause lots
> > > > > of driver file change.
> > > > > So I suggest to add one new MSR macro for the CPPC, the
> > > > > MSR_K7_HWCR is mismatching in the CPPC Pstate driver.
> > > > > If you refuse to use this new one, I will reuse that old one.
> > > >
> > > > To avoid changing too much stuff at once how about if you give an a=
lias?
> > > > IE something like:
> > > >
> > > > #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR
> > > >
> > >
> > > The mainly concern is that HWCR is for legacy ACPI P-State control
> > > not for CPPC. I talked with hardware guys before, it's not suggested
> > > to mix them up together. This register has been defined for a long
> > > time even before Zen processor.
> > >
> > > Thanks,
> > > Ray
> >
> > I have removed the code not to write boost state to that MSR, just chec=
k
> the boost state from the MSR bit value.
> > It will not cause any problems, I have tested and confirmed that the BI=
T
> value will be changed after BOOST ON/OFF switched in BIOS setting.
> > So we can just check the boost state here for pstate driver notificatio=
n.
> >
>=20
> If we found MSR_K7_HWCR would impact the max frequency in CPPC, we
> should report a defect or issue to firmware team. (Then we can add a quir=
k
> function to workaround this in amd-pstate)
>=20
> Thanks,
> Ray

Sure , I will revise the patch and still using the MSR_K7_HWCR to check fre=
q boost state in pstate driver.=20
Thanks for the feedback.

Perry.
