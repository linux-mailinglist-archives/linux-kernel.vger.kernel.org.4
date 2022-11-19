Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83530630B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKSDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKSDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:55:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB77C5602;
        Fri, 18 Nov 2022 19:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668829861; x=1700365861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ITmrco+Ys/XRhNTeYzxPzZnkDf4okqKddDtMlpMyHjA=;
  b=zONnPztJZZVQBqpyU7/R6qq5P3/UIhljtn0PP8gblNW/idsbe81sDuMa
   b2jwR78IohPb2+a71ML/+SFx6WdHX3P+VMqtBqtLZVW1kfHXqTLlqiAnl
   WWgFFDhrprPkFUdEGixpKqrEbrpIO2lsD9AYII/aSWjDXj21IGk7B7Nz+
   O2sMMPdLWf9I7PbQPRPFRNgPVf3FVjhFlQwR2L/3y+Ah2znwvq0HmYlN+
   +LZPtT9qn5JhGgOJ+Pa9jiVBak/nIpkvyTVkjeVgMC1hUGuo8EHZ3YjL2
   EfuosD03czW8WCyqaGyOyLpsZ3h3xTDumHDpxZe//7gyk/grUSLGgtmTn
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="124185682"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2022 20:50:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 18 Nov 2022 20:50:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 18 Nov 2022 20:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWSL3gqIsc4oSuNAbRh88VmLb3V7ThNbsuHq1YzI0l9EheiR0PxDAcBQrkYV2UvmxebJLEh6IySMMN6/lnDwD8GnHPud0fS4Tp1wpJhOumMw1v2cwAIe52vZruTY8wXWtERZBqYy1pjZyStSDNUo7uYYCyBKnd7E1Skh4G5C4CSkv+ZPn38oyDEpUOO91LdQBjoyhF1EHC9/kmJ22F3w/yCx0mkt7ORfrcLx5+ryNJZILUd+OGeuiqfhL81dLROPV8nTfj5stkNqQqdgV4D4RT473gywMvAWe50z/TAP5BLrD8o1FCFkIWDMP3EDXLlNi3Cs/kYuXK3R4DqBSVEsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITmrco+Ys/XRhNTeYzxPzZnkDf4okqKddDtMlpMyHjA=;
 b=jtdJbxVZr2yO/1CHLiu0SvCuYR5ezp+C2AnU8DxjfjDhxN9xf1I0JJYeZOB0r+G/LaKggsnmHj9rtVI3t3Gy4iMI43SFIulK9+e6/zscTDEXhWnBxrUeW6Ow6DVlewauzuhUScc9d4MTcGDmIw/PgUnSFGnBKtGD3Npu+6682PlLtTDG4nq2a+cTvl6MxSqP4QvsZ25edgEUfZgr0zhMkfjQb1i2xCQzAnzeav8KF6gdZ1tHISwU3l64AjZgFA/+bBCkbbV5x0xzVF1PDUZXb8w0rrztiCAivCpuO0rtQ5L5lVyWoWniz5Du/JQn3GqX5GFwy9HMss6hrCPILakhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITmrco+Ys/XRhNTeYzxPzZnkDf4okqKddDtMlpMyHjA=;
 b=HlQqcUkFlNcYNQT4DLvY8nPmXbC+qZWeqz2xe3WYRsSCcjagZRlylDKqiB60eRMMyWigsYr+kwuDVXxAEcfwDM43KU5qQmCPexXLGfEYDjdZkm/iRAJIxKVE2RbCCCDNBanLeCRCJyo8GmFVWICRVcg3flvjGUlL2atxbqktTHY=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 03:50:03 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%4]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 03:50:03 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: RE: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Topic: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Index: AQHY+kGgCkN3Fu7q/kCCsjfnk+kA+a5CrryAgAG/arCAABKagIABHb0Q
Date:   Sat, 19 Nov 2022 03:50:02 +0000
Message-ID: <PH7PR11MB595845BBDBD65FB114018C339B089@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
 <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
 <PH7PR11MB59582CE57CE17F20A041157F9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y3dh4UlWKP2FzTpq@smile.fi.intel.com>
In-Reply-To: <Y3dh4UlWKP2FzTpq@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CO1PR11MB4993:EE_
x-ms-office365-filtering-correlation-id: 076bf558-01e3-4317-8b3e-08dac9e123bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S04FYX0c8mwEHgBgwbhwXGN7Kqhb0SVz+lBoR5EmqSo3bW/sLfD80rQ9hXPuhMh6JuRYh8k9Dwzl3c6TigqZHm/3m6JvNaOzB44sGJ0Li6Dy9h284/L1/4IVxcibZJdIr8awX2O0Zp+vizTosehR8aiRldRZF7Z4IBTTSyeEzSu8nzog6ZSVOk8xImq/PaIcqwB3jkLpjdtK5iNvh95A62sjHmDFSlqBqsWxKmPGYG3TNg7XwOLKG+WTPBgGFw1unP/4fQK7it+KWCAOYtZHJ7GXLeEtAcgt6ut0wmf2JflFVETi7wqNL+dV79GH0+APpr6E/UE/+We+5P16KL9hjPEMNFiwVQovWdxrVKpc9n9QWMI4SdlUgawF1eGVZyEh84dDTApOICBq/74e+78Sz72DgenvXdpsfToNTKVLFzEg0NIv8aIzhAYo0CgAqiFDFmceuAmvkNx3a7tHgpv4GtaNu4aP0DBh0dMHxktLpdL5LMhFCKjOeBTgf+OBWQD2QMeFNpANizKKHknKXGwzc4g5W+EbFWXC413iI1Zhoh3lvzdhe9pF9ZXleD6eNpwxaR19QEZyGIMuKjX8f0fGXoMoPGOXWkp8gJ2PyX/LB/p0Lh9i1nwpCnSBEuQl7kcNX32k6WUqH7AtMZBZmAiubDZiZb8G666ayNKv+/b6ZCCpRPEMXbP5OdXkxoyW0HjNN3P3GZX8+RKesaSf/FO24IDrCXdVI6nSehFHArcfv8zWkj7VoT8KnZzyD5yXRVWvyYQsUPU8aTeTuTujx+acCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(71200400001)(7416002)(5660300002)(4744005)(478600001)(6916009)(316002)(52536014)(33656002)(66476007)(41300700001)(4326008)(66556008)(66946007)(64756008)(76116006)(66446008)(8676002)(8936002)(186003)(83380400001)(2906002)(9686003)(26005)(6506007)(53546011)(7696005)(54906003)(38070700005)(55016003)(122000001)(38100700002)(86362001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JUXt3sjP/AjA2KLsYpaaJ9YhErJFV0c9cYl974K2r+qyXtqq2FOZ9Fwi/O2w?=
 =?us-ascii?Q?/0m93iDn/tQMi+XdTg/VN+jvpgdrSYbWoKuqr6+vfDJ5m+EMssClN12w4vwF?=
 =?us-ascii?Q?m+26rAfBeC/AybfXtpwzeFZuyQ+ENqrSHj/EJKHppMot/q3P/gDGT8A8l6nf?=
 =?us-ascii?Q?/zrt00w0ek7dF5C+lgUejWrbEfLwmREL0UXeidpryQ2AF+g64b42VQ/oiBSk?=
 =?us-ascii?Q?Z+VwSd1FM6GkZUwb+KlCxmHkwbraFPclsDcVZKxY0a0CuFHeaOKaQXx3GyEF?=
 =?us-ascii?Q?uBMBo2+nkPzeu8OKHtXcke8do+nMlQY2s4VCP9D4v8Mi4IcXZVncT6dNMezh?=
 =?us-ascii?Q?N3bjRhVo8zuby77q09uTYs3m44ckFuzYmSUqWyLoi6oC8mozbJEdpSq0nD5H?=
 =?us-ascii?Q?aHmW43sdDy8equs+yW/0Gyz8Ojdlop5izN/YnqWZRrnMfpleEmfhHn0ktU5n?=
 =?us-ascii?Q?Kpy7FyyibnglXxZTlHIpFUY0DWxsjyR36gGjTSn0ghp2xhe27I/OGzhUrrV+?=
 =?us-ascii?Q?08KoKbb7Igf263nUmJLbgGCgF6GpatmKM/PmiWELws/6fNNYN/uuozeUuuq6?=
 =?us-ascii?Q?zq0TBP3wlUlu+nQvQSY/h60qbjYhRaOdBixajH7mtF9ZrInCbx9fyVSy2vFB?=
 =?us-ascii?Q?+Tek8mGoe3HWadoTPzDCVuG5H5xoZbUiKmU2JYc6i7k2E+usoHAvPbAWHjMb?=
 =?us-ascii?Q?2PPFXpQ3jn8foXtqkHM79RQTkDzk/YRxwOo+KewCFCJffOfFnMQPe1CSDjfd?=
 =?us-ascii?Q?NGhnIlU9gue/6xvNAvHh9a/pZVx+TP6aWDEM9jpqA6iJ/htNe0SG0xDnKY4+?=
 =?us-ascii?Q?nFXTRDEJLZf+Ra8+lWZXRS2JL/upZkw688JYWslFvbUL4XolATgIYkakjypa?=
 =?us-ascii?Q?kYB1iVeSjznP4VEaV/TpznFdMwVPnhKSNM6fo5OYCFlVsEC+v/YYXkACeJiS?=
 =?us-ascii?Q?fXpsE/WLR2dikTKhMWMtNnWwMaE34fA9T4aWfMpe6k+LbxDj45wBNRuIYxZg?=
 =?us-ascii?Q?yYTOQ6Fja4sNhJvDOmzUBVH5DW5mz+d9vJVddjGZgTAfEFKRveeeqIZSlzyu?=
 =?us-ascii?Q?CyWI3cQCJOWoSUqx26kg+nPPn/CrgLOIJRmD5t2fCcbHmnR/HDbFCbt4bfK/?=
 =?us-ascii?Q?sTfpvyYOVW6FTPw1LQu6E9MHvf7e85Z6MgvAZGvkHpJGKxiXWQ44FzhL98a+?=
 =?us-ascii?Q?6OrGlD4tySbVuN9EdTLv4QBPRIGfzM3EsQC2I43UkhgcAUmW0TSRXtwsD3Oo?=
 =?us-ascii?Q?MTUAq87d5yGoQI6+J3uNTiVcyELNWoUOhu8iEjuwTcxyy7oNpbHCeHxkDRzp?=
 =?us-ascii?Q?DsrpuBI/bC3MHIcQkqbJ3zqzonrUh/rU8rmCeLkBh4P27PeCp8t405NvUitu?=
 =?us-ascii?Q?ObpDSl6oIyMCVO9oGWeFVoE8IkH2TdQ00c+uY31OoQH9TUppu1gCiwLkCYda?=
 =?us-ascii?Q?o+08Ptu8Cojz/w+3w05N1aq17TQ8r3OKdT1LtSdE0bGgv3HahlpNKIfZ5tPd?=
 =?us-ascii?Q?p+9eKsi3U5rAQ9ogu35eC2AwBb75oeNyf73X2rN3rpnRH5xRS/VoGYhlxX2i?=
 =?us-ascii?Q?gjAFnoOHM5xsM3Jg4FZjAfiEFtEyQ9WpEqbygwK+YSoR6xLhvkLtnjDXd4Fh?=
 =?us-ascii?Q?gQQDAwIL/igpDx51W+dAZk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076bf558-01e3-4317-8b3e-08dac9e123bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 03:50:03.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyH+0Pey/FwV68cioDpYhMoBoX50IM6HRImZxoTbd7iwyDhUwWfW5vAH50+wd3x01r3CGoAg8kPLicj/cvYSNlQl8u1/DclO6g0NLy+PhcVpZxor+KF7aeA2SVQrlwud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, November 18, 2022 4:14 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
> serial8250_pci_setup_port definition in 8250_pcilib.c
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> > > Don't you have a dependency issue here?
> >
> > Okay, I will explain the need for the changes done in commit descriptio=
n.
>=20
> What I meant is that the 8250_pci patch should be _prerequisite_ to your
> stuff and not otherwise.

Hi Andy,
So, do you suggest having these changes done as first patch of the patchset=
 prior to patches
specific for our driver?

Thanks,
Tharun Kumar P
