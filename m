Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31741699CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBPT0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBPT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:26:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455C47411;
        Thu, 16 Feb 2023 11:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUXYONqr9sZdnW6qkU0kFPs4V1CuCZp0D7neEBoRVvteBN/OfsimR+gVbCAlGNAdjaN+anmEu2etfcq7j7X8VDFIWVzQ603J7XuhF+n/9yYfJnQw81mgKVgXwCo3thtouh9zDPdbqpoFefFINxjFjFfinVx6hpDgAALLnyQ1QIIxWdj8fLyBFvbkVLvbYQw0dRDaKMA6MgPbPMSH5OGXihGM0HtzhLLfMfvEtY57am7jccBucfGfD51X/xZ2ukZnN+vg8k4X3tdbzpJDLlfXwUGmluzqHFqg307MbRWZ/bte+/b/HFYcpyPLVyamdfRiWqqtDNMD2s7U81g8LqRHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvqSjGKaiRwzxs7z0HajeEdrsr8uxbduH6pAnWvSN2s=;
 b=d4wJOln0zf4twXMfsqTptnz0tFQWrC/9vpSaKy4etbmi2eXm6bbEel/ujlZ9Lkfovnc3Pk9+1MKMhM97QC5uc6wDkUiAF4Sk4Eaxh2K9IzVsQTsYNLZDxxZOOm4Ow9h6aW2UZJXb4pguYx+7TaGBxQLI6yzBqOYcK4gAUpFscnMEXRtKm8jD/M+9xxvPt2HjL26FoRG/pBWHr6VMp+2XrBSN9T1WWIAmshgM35w4EXimp2dr8fHM6eoAGlgigqvlc+TY1xUYkh48vPc3MyPVj8EcNCNNa6aa+Qu6J18koExqQ0+6y3Qafbh9EbbOckqw++ZbTLT670g20NVBtFX5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvqSjGKaiRwzxs7z0HajeEdrsr8uxbduH6pAnWvSN2s=;
 b=OT57qOAbp/69BYI7Cdqa0Oxlemd9Fby/jZZKAMwbeP54mXOrlqTDZcza3Z6YuummjvLoJnvnjy//I8dBOd5tcMyhSjvilWNc4eoePqxZrO3MqXZKtUMBkO+z/piH017xbXI97+FwhxRL+0vlCaR58mxTVLMmQsMVPUD89DIZUppjZQvAamA29qrad69UiAJGtJ1LRDvW1RPYpf3bPyQEatvyz7HK+uLsIzTUvKCBWMhngBu/eE1yZOOSdmH7NmZHXorfuN0fB6/fzHsoEPASZT7h7TphEKV7H+SCE76Dzyxk7RoNSFh49ROx/l4t9H96kTqs6RD7OKKomQUx6fkSjA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 19:26:47 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 19:26:47 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Topic: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Index: AQHZPWNgHTU9nf1rdE+MpmBAnswWQK7JpLUAgAg7eVCAABDiAIAAAPSAgAADPICAAAkIwA==
Date:   Thu, 16 Feb 2023 19:26:47 +0000
Message-ID: <CH2PR12MB3895B9BC684751BFA25B4B08D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
 <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
 <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
 <Y+54Prj3YiPex5lw@smile.fi.intel.com>
 <CH2PR12MB3895DCD7B2D54B2228CA8F24D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
 <Y+57wasEo/CLHakK@smile.fi.intel.com>
In-Reply-To: <Y+57wasEo/CLHakK@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB5759:EE_
x-ms-office365-filtering-correlation-id: 6257b6bd-bf9f-438e-1fd1-08db1053bf26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPN2lRhpe3tadWjmXAPcpb805tpb+yWL+YItR8NXq+HuW15wF8zuipG09oEYygccAD6vCvaIig3B3/GUS5sVVFuJlPQzjN3+BHSDUV3HankeiAbw2VF9AJRtk/OUdA7RQCcnhIhSjbKG4d8t8o8qtMG9hul812LSrmFwaisVSbPTpEdm8Sls47u9Qm0xtq0YMbRJEKifqf0cN1aaovoLx2SpgOhBXJ2oBvO+4BfP9Tn4fN8m1dMCtCw4uAOFcbhrlkfa3qsHFYFhnRs8y/xmL09I9/u840yQ5PJqUyZz5nSNLEsAyFt20Nbv2bqIuRWKeSXqe3Ca3TTRjtLBXwlPUMgFE4FLmQVUoQWKmIALLHzzTH/EtOY6wPiuJOzg/1bb6VhvoE2b+9kKtsXLuuGDxXIwN51yX5bA3WCTGJPMbctHCnRgNi5p60WGSv5dnZ3b8/uw99Rp9eSRuM7woiHAic9hXeQkKojpMUipjdHWRAxzcdafrgr7kSZYJYlF+JugZyVoWkelaNTQ7t95Fc5D2FtiSOwKCbbeQzcfVxfv0vK5fqSXiRI6GoIS61isQg2Q7qP2GBu7cGRkF39ESMsW6UJOfZF5HAHOSh4Eu1kG7KQ5HkojifSgDqyK1GLnB6adatWY+QdT6vGjzN/boRk505dUcMc1KRQ7lla06s1IowkxBwWNlXE49yuo2HpvIYs7r22MIH8KIiBolgkEdMXS3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199018)(55016003)(83380400001)(86362001)(2906002)(478600001)(33656002)(71200400001)(7696005)(6506007)(53546011)(26005)(9686003)(186003)(38070700005)(122000001)(38100700002)(5660300002)(8936002)(6916009)(41300700001)(4326008)(52536014)(8676002)(64756008)(66946007)(66446008)(76116006)(66476007)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O2juYvIjtDMirS9O6c6VQtdZkrdmwHI4Jwdo/VN5c5KDueMm0Or2pHROq22n?=
 =?us-ascii?Q?bZCb+bpR8dU0P9lzBLHKI8iCm3FGZSlqgi3g1jk94cgM+YhxC3lh8OVN7+XY?=
 =?us-ascii?Q?Cc6oowojBzaR4o1/3v/Q+CFg/2LIeDtJq3RQM7PvEQNwHgYIcwHuQwju6yr4?=
 =?us-ascii?Q?c4sO7t2Ar6H1W99pLjLpEhp9o1NJ6/WnizuwTLfzAegl/k4MEzxy+ge4ZozI?=
 =?us-ascii?Q?YFkTVvMCrsQ55lrRuTmN8v3pwCJ/+ZXJ+IJgp+AgJ9Ay3ouv+e0hf+TwzPxT?=
 =?us-ascii?Q?/ReBuUNFY/8PwLonU9ggSx57TNReN5Z79/BYfJWJoCuK96vZW85NMDZ0uWZH?=
 =?us-ascii?Q?GA974zBDZahHDDZoXMCpEQ6tkvsxDmQT4WM+lBtT9thwdh0rRha2ZqdRZ9QX?=
 =?us-ascii?Q?iRW70+uTozTJ4wM7f5iSOZzDp4DIvQQTRrnw3AJIVP3sQ9T2bzmfTKFyfmlO?=
 =?us-ascii?Q?RxEIYgbq/DyEdjlV8OXC6xIUXqdm5CH8WsB7BNoT2eU4LRKFkTpmd1zhfj0f?=
 =?us-ascii?Q?geaqPoOB/6gg77A+GoTJFnyUrWPgX4lWJMlbrB7TMnIrgZBkHjhY/DBlLrsK?=
 =?us-ascii?Q?WMGwW1IyBG3CJ5B7q0ORYk1QXpzCU9i2SyUG8xz2niOpDQlaVWZpyciMEd+M?=
 =?us-ascii?Q?5M4/vW1btjywyK7e3LxK7DHC1n3B4a4pNM/INgiG/BBBr5NDq729gpzms6M8?=
 =?us-ascii?Q?kQ8mR+uYB91w242EXnYJxTA+Sm0meUFpYN/2D1U0QZM0hGcWVTj13W693XtV?=
 =?us-ascii?Q?eTrdd2Xj3hFWcFc3QszrTvLty+vc8aG9OALo+E9EFvNMa/Xjp0bdKzp5FW1z?=
 =?us-ascii?Q?3/Nfb61fuSLIyybLwmiItUSSp4KIjlfcmHe5lmkIyMMRTrKAuj7N1S4PN+ve?=
 =?us-ascii?Q?avozZTbv76oQQEI3Gwf93DgT+MenWwCtwy3uuZ/b/Il5y5FXmkk5xkfO2WYt?=
 =?us-ascii?Q?HqXoXHqDYmTTUkxBZFK6e2r1xDQn3hJurWxoh5IhdSO95NSTfMgbrq8MvCYO?=
 =?us-ascii?Q?VbYvg0C0qYL1EaObwM2Yh2x03SfckhA0xvedFrgwt9R3eOIpmtNWXBAq9Wyk?=
 =?us-ascii?Q?Ca0LscLs68T1wzAJnHOp8hGln5jkJ0YmWQZtHkIeDAKHWSz+B+ZruhEGmYCP?=
 =?us-ascii?Q?l4/5nE7e8bNeEp5+F5s98hQaxkzl22rEUH7UHQcRedcEQwKBRLx80dTgmRmW?=
 =?us-ascii?Q?fmeo0h9yGcF6iAfl2+4GOl5wItUSWVT3v7Vavjre0T0CqIqtWGd7okqZ2grK?=
 =?us-ascii?Q?8fNhYiqYpn+HQFg069402gQkhxtRwGN54EMwOYygAw1gr30Ka6ins57d2Wf5?=
 =?us-ascii?Q?ycnb8iRwL8TuPGi0tfi5CsNDIdC7EUev5kl9S5pnlWqQYJJB+CD+NgLOZEnm?=
 =?us-ascii?Q?qYIIq65D0AOGbt2YSQ481qAdKbVamGkP0h181dOqPDiAYYKAl2Gu/abhJb83?=
 =?us-ascii?Q?E3uPcXwatR/22wgP7kn/1joCsYYR5k09NJojP/XD2YFEt8I8lEgjRIkQlPWZ?=
 =?us-ascii?Q?NEjOteOUZFFtD2mPhAERbJ2cDR5dkQhMnQ4jIFVA7XSyZbonMCH92eoZ6o7H?=
 =?us-ascii?Q?q5i86AihkPWXu41bA2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6257b6bd-bf9f-438e-1fd1-08db1053bf26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 19:26:47.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSATyDcAq5O4+wSCP4DG7odmBPZ1+ZGD3jnmBcOh29EdGNVYGmTGayQM4QTqLIo2Nw/zkX9N2ZsG8k/uYYbA3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@intel.com>=20
Sent: Thursday, February 16, 2023 1:54 PM
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org; linux-acpi@vg=
er.kernel.org
Subject: Re: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Importance: High

On Thu, Feb 16, 2023 at 06:44:58PM +0000, Asmaa Mnebhi wrote:
> > > +config PINCTRL_MLXBF
> > > +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> > > +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
> >=20
> > This is wrong.
> > Please make sure you cover more testing.
> > Also, do you really need an ACPI dependency?
> >=20
> > Could you please provide more details on why this is wrong? All our=20
> > upstreamed drivers use the same "depends on" Our pinctrl driver only=20
> > applies to Mellanox platforms, ARM64 and use ACPI tables.
>=20
> This is wrong because it narrows down testing coverage.
>=20
> Besides that you need to define functional and build dependencies separat=
ely.
>=20
> ACPI probably is not what you are using in the driver. I do not=20
> believe you have at all dependency on it.
>=20
> Noted, I will define function and build dependencies separately.
> We have our own custom UEFI for BlueField SoCs so ACPI tables are our=20
> only options (for users/customer etc... as well)

I understand that, but I'm pretty sure that driver can be compiled with ACP=
I=3Dn which is good for testing coverage.

Ah! OK, understood. Will remove it then.


