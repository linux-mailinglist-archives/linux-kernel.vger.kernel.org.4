Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA35740A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjF1H5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:57:51 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:49505
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231485AbjF1Hzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1FTpoqS/Hx0zlTkTki9bVCzdE5AU4OXC7oLf3XNuPbIfnXNcYSytZXY9VMwW/OeHpi7losnnL9mADlF1D81JsuNUL+IhGGjvLR8lEOXqF5ti4pEuDk/lxbCP8QSNM2jNboicL/TCLFijnmtoQ11Lpx+4XfrFqeMpLPACe6lbUVeee2EKrvcrSXT3c8JmSsWZA1smnz30VEVR0PB/+V1TVo/A9rzC4DLxefCtzXc05rAr9kHIqYOT/koC1LjGbyqW/xI5PCpvv2HdWonq3gZmHsIM25tMDCbsXmCYikFJduZtdrlYikvxbAkpEsJx1HFyMIhT2GQ2TyKxjNhQcZc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+7s/nILWP6Zuygg10i3Yq+A9xqqtXEbHkPkUSIqA90=;
 b=TEwwc0BaTSyPMcGhx7dcru0XDmhKcXXGumQYnIHe9vDrQZFqcus0AOSw7XwDeJh/HzQE7G5dPcATWs9iNUStZ+6LD0HAgrztLUKPh33pGoVSDk/+vUk7d1wAuxr7jxnju+YVo0VXjTJVn5crLQ6kKOapOGMp6iAn2SBZ/YsUawoE2nYzZ70omBE95bUxxWzgTQCzb7Kdh/088gfQmdZT/hvTTOgtpLZ9g2QfRnV2e3TTZzFz5K8aKtYy/+5gDZfoM/3+JtQrmGog5wI3wh46m/fnEeCRLkfoqDBPagW0i6eTDTiBGkoTj5NS6Il9lsa3Vvl9kns1Eo/jHinxX4GbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+7s/nILWP6Zuygg10i3Yq+A9xqqtXEbHkPkUSIqA90=;
 b=XLa/pLI9tQVf+XDj8glhAHuEm0BuOjWth/H9npnv37TQflc99jhwvbcQylPawgaI5myW97KtXqHHTM6LsEvTH/yVrJ9L9sndAgmucGLCikEjAzZNozo+mve1PK5XIj+w6QwdECH3pnrD/b/WrpnCLBUcBuvFM2R8nMlsFqfsDjo=
Received: from MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 07:38:56 +0000
Received: from MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::c77:1e5c:8fc2:e312]) by MW5PR12MB5598.namprd12.prod.outlook.com
 ([fe80::c77:1e5c:8fc2:e312%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 07:38:56 +0000
From:   "Gaddam, Sarath Babu Naidu" <sarath.babu.naidu.gaddam@amd.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.cheng.xh@renesas.com" <vincent.cheng.xh@renesas.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware load
 fails
Thread-Topic: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware load
 fails
Thread-Index: AQHZnn7SnE0MZjPu20aK+BkJgO+ed6+MTF0AgBOcpnA=
Date:   Wed, 28 Jun 2023 07:38:56 +0000
Message-ID: <MW5PR12MB55988C5FD23FB2380AF100168724A@MW5PR12MB5598.namprd12.prod.outlook.com>
References: <20230614051204.1614722-1-sarath.babu.naidu.gaddam@amd.com>
 <20230615130506.3efb333c@kernel.org>
In-Reply-To: <20230615130506.3efb333c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5598:EE_|DM8PR12MB5429:EE_
x-ms-office365-filtering-correlation-id: 192f6874-78e6-4d12-13d8-08db77aaba9c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYV6SsGQ50BtkNoE1c9jP0BrXX6yhbIe9+twCxJbIzAizx/g3lJ2l16+xR5LvFA0G7v29L2cqr5r/yTdGKOKZYtLoUneA+NndexdLPV11ajo5IACypZnd/FHOBqWYIDkFL3Sm6NHcqj0vu2m0SKLXsT/eWjxsCMrn4fwqY5sLQGVl/5LS6xQUEQm86zY/wCyBOOkpZC0YyB3twMVFq0PrEQz3OZum9h/78IfmA9ElFWynsNe078CP5r/scNBFC1cIoh4w3G6r5ZtPxutww2hxlm5D1k6aSqOJu9esbR6Tq0rwhlrzTxEZ1X8qxWcaXxVRUzfOdc26h/E2BczAWcwikpvtu/cPJk565VEshE/UrC/9UH+BhUaLkuSz76VTL0lTSYD92hyqxMX9WJixF6M67es6rm+Bh5Kg1ljUJOgi1+u9XRUiZY6MHvdA+JWOGcUeliB/BWyd5xH/0FG7SpC2tZv9KiySdcnGLxSMbcMThFiSEnI29ZMtfELHvp6DNlFyZDIy/4L+bdBtWXwQlcvx7vGFYch4AA7nUDnYTo4es5VvutOFW+31E+GMoax2iZZPjqF/UEZA1WzNnFAODZa0njTq6IFVC/3Lz7LjGwxUo96vR3nuxA+3XSVXnfsJh8G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR12MB5598.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(33656002)(66556008)(66446008)(4326008)(316002)(76116006)(6916009)(66476007)(478600001)(38070700005)(64756008)(8936002)(66946007)(52536014)(8676002)(5660300002)(2906002)(54906003)(86362001)(55016003)(41300700001)(7696005)(6506007)(186003)(26005)(53546011)(71200400001)(9686003)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BhMtpTYgKJnEGPPO3smcZqJBJbJadoJShirtIIMA/WONvKmRrxtvG4EGUPh/?=
 =?us-ascii?Q?a+E4SyAjfoAmiB/Mu6U/K4yam/gtlpXm7s3DaUyutLryfobVIM9WShXPO2lX?=
 =?us-ascii?Q?1pf72h+IvdLNcQY0EnBtZxZTQGYqZS6ObEY7URzBygsbYbDeRO65kcH7VGPY?=
 =?us-ascii?Q?vqAhLNpON5PxJkp9X/V5+00pcW4amvsgcVYf815C4MbutNcTvWf6srfcND9X?=
 =?us-ascii?Q?pK/1g6d+F92UWhrbOrEpNKM1pczZm6shDTkEDrBgt7y3RmyWEcn8msagLfJv?=
 =?us-ascii?Q?VOQ2bN9su1LsbtYuaePivGbKyP2F9ZOyb3QCU4R9d4xTkBwbauuaD6LBbTG5?=
 =?us-ascii?Q?VKDngNOzYXPgg0uAenhPF9aLUidcav1+H2UGQXZMSkN6mOKo2V9INNCeSTuM?=
 =?us-ascii?Q?VkUWVFKK1xoD511kz68ZsyGU7Ek9PWDlsbQbtpe36vfqm1wQP9NbB1mZCuY/?=
 =?us-ascii?Q?s2PLNBeaqPmWl04+E98QUW1zLQbM0dqVoH/5euLXRl0pBLqUUwPWeUIoaUem?=
 =?us-ascii?Q?qa7jB7mRwjIBE9hlEh2AqTeckbkKJVeufLUE66/ua06+EAQ8+nWnqHQhtN1G?=
 =?us-ascii?Q?BI+pppQpRoWbm8DD5gC9h7pD7bFDILEVt7RYd5Eagtb9uKRAp9E3qFoirukR?=
 =?us-ascii?Q?YjS/AIFm78ScPcS9ODUBIOcJBqqlrZTVptshJav8EZ/rwTrKZ+yrocwoSGkR?=
 =?us-ascii?Q?qiajVmzjIQ54EEtRtStVHnfTR2xJ1GJWMiKBYxDbalPAyfIUlke1m8dQDudz?=
 =?us-ascii?Q?cCCyWDMjQEwm2d3eYXJuKfvfKQnEuPFTAyeSfcIv7G0q86D5ATO6GmwgXiO5?=
 =?us-ascii?Q?Qau86VjpB+m5oKIBvCCkC9BK5uJXVnSum+xKi4I4B+EcfCXHkrPuGG/h/5aH?=
 =?us-ascii?Q?rfyUw9/hyqIePEzrdM9tT7mIM1iDFxwddvq4rEkWnRnBYlEffyuPHnI8Y4d2?=
 =?us-ascii?Q?tnu/sQfboZC1IZq6w5vTBCwnNud01AApp4HbiE5bhwKFx7ByBz8fajxrhyUX?=
 =?us-ascii?Q?V6b7rr7sozO2nCepfxEIq4mycAeJXY+VDsIN0DTWRj+Mm07O/goEhcPfFTYj?=
 =?us-ascii?Q?x0SrpvMfhwmg8RvyFYNjNls765/wMjjRmZcxX09OPWp8YSnk1rn2p4jGZwEI?=
 =?us-ascii?Q?Q4BbUxZqvA4rsUHE5ueVeV5653LoU4LsTYmacKPZ5bLFg++HF0c6SMlt2BcY?=
 =?us-ascii?Q?izapcrjPUWp2re94iGxTAvL4CBy2vOHx8O18sZsR2lJohCSVggR5AYpGqStS?=
 =?us-ascii?Q?ifMPlEr+/Ni2zI8jsx9ZUcC77HS3UDdKk2qdk929HSkDnhMS5LlWqITrYKnY?=
 =?us-ascii?Q?tN7AkVTq7fp2d7qEMixFeGbtU/NSCwLmui6km3Ami3PHBS9NQPT7SVQcNj3Y?=
 =?us-ascii?Q?9CJYhCS65aFUy9oJmWOXQxCNyns9wiCyEXfgjWid28H1UPvGbNTat4CYw3FB?=
 =?us-ascii?Q?h2qyYMUL2vB2NVEMYB2CVxorjKMxInAryqcrgp+OPxCvwKXJekQt5uHxN75U?=
 =?us-ascii?Q?GTXEpMagwuJ0I9jlrMOXqrdMvzntSaUDaiLRFQvupVCVh4d3K8n/9niAaa4i?=
 =?us-ascii?Q?J4NI8oXiNZxolsaiwzI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192f6874-78e6-4d12-13d8-08db77aaba9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 07:38:56.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtBCJINkP0rTifT836bH+u0OPhA3P0aM8yiIRoEXc12yT59OZQXb84lyFhbbYTKJT0pLzkDlpnk/iRtjXlkqLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, June 16, 2023 1:35 AM
> To: Gaddam, Sarath Babu Naidu <sarath.babu.naidu.gaddam@amd.com>
> Cc: richardcochran@gmail.com; netdev@vger.kernel.org;
> simon.horman@corigine.com; andrew@lunn.ch; linux-
> kernel@vger.kernel.org; vincent.cheng.xh@renesas.com; Katakam, Harini
> <harini.katakam@amd.com>; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware
> load fails
>=20
> On Wed, 14 Jun 2023 10:42:04 +0530 Sarath Babu Naidu Gaddam wrote:
> > Clock matrix driver can be probed before the rootfs containing
> > firmware/initialization .bin is available. The current driver throws a
> > warning and proceeds to execute probe even when firmware is not
> ready.
> > Instead, defer probe and wait for the .bin file to be available.
>=20
> The first-step fix should be to try to get the FW into initramfs.
> For that driver should specify MODULE_FIRMWARE(), which I don't see
> here.

Thanks for the review. We will take MODULE_FIRMWARE as a separate patch.
We want defer probe to go first.

Thanks,
Sarath
