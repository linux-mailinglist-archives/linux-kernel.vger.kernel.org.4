Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43562F156
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiKRJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiKRJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:37:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C092B55;
        Fri, 18 Nov 2022 01:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668764230; x=1700300230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34ybLTUTlbcNPcz9UCizodUBEjHRWdjeo4Ca24QQARo=;
  b=XrwgauFoadlSAG5f9pkb3g6+0EOnxVQso+XlpNOVDf68/Jseuiy9E9Yy
   VghSnSJrLzNAVlaCuRajRXk/S0/80qufaRWF/x6CkbO4DQXEFzeneprHZ
   bw5HyjwNk/Nxja+tZjn+URvBTTfaFQkjulSqxYN+Cu+8R/wXTpMagbXhm
   TNKYRS8EXg1HVBWJ3xF1y/PQPpWj5cui8dKiCZdft4/OL6X/ISy7jcYpU
   wjW2mC8kYOz2MCgoZOEBB3wFB6620RkOr0xSBU6RmZLj0+fBE4Rp5LK61
   D13Vn9mAXoKXecGAPnhXRZFHXPgNMbi+HT+iL45Jtatv2SksyzIi+ZKno
   A==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="200359848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2022 02:37:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 18 Nov 2022 02:37:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 18 Nov 2022 02:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoRPoLzz6G7PTxnxp14d4lY8WUipbBddG2Q74fFhLNdx0BOAig0B+qcZ+CXIcs8kbaQzMAhbcaEoNt26G6OhL21RdEsDtYzKS9aGZ57xdvWDGof61hkXhhKZJ6ztWKrqubm/3zRB2LrABM1oNM2NidZZ+GFqgeV/eHwvbSd3KSKJEuVyb31+hC3rSV0fby71ZrKUubyrpP3RyIYssjKzCiomp2yartZMuAu2K8lO+zZ/c4EnavdtIwIzWTssu8GdBk4DRIMiShRnmKOSr8AWBNEgjL2BfIsW4z0IAh05if3hgGBMD5aSJYxneXrlo9h0NE3u2a4UNI+LbIQPtIczvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYOtmPQoejzyNeWO7QlOEj4zDckQd30GqrsoXkLtQo4=;
 b=lvnVRx8RH0PB7k65posjVRDBPpNTrDEU2EYE4s8YTrcPIk3Y1/xD2ON9QLFF9z6AI7SBLNedI+ap/thUUDwDCUaa0PFGL2RR6sKRfFN3L3yfjskM4hN8mMN4pj0C6ud/xYTQSZE4tp7vTVKRKdDMJQnSz+QC1wiklJ7GAFu6hUYLDL/Jfux7j03DTquDsykW8xbkoFKwZqaUW8YfkiyzRooC9OWOuWqWwbqUw3LWK0xm9LH0+n/7yb/wzuklievQXKson1+28YNGvKB8eOZcDPTerk0jf5yhWMTKx595kon7LEo8q2FfQoCSMqefqi/wXtaYtpUasR4BuT1Y6nq5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYOtmPQoejzyNeWO7QlOEj4zDckQd30GqrsoXkLtQo4=;
 b=SPH1wvW9NUcEmRfHxM4uJWMLnLH5M6LxF4W7hLmEAvwPASa4unCzHkKli5VeIRjpllbyJzHqsDrszk9Q7ryEGraeqzVtvfET+hQzSSsk7f9cITS5VAzWA+IyV2hToJWOR7YKuGYf4zkeF9NzuvN+rhKxaiOcaQt4nop92CsqSl4=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 09:37:02 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::d8b1:41fd:186:5cea%4]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 09:37:02 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: RE: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY+kGw646UxkiGXUmyIL2ickY+t65Cx7aAgAGlSDA=
Date:   Fri, 18 Nov 2022 09:37:02 +0000
Message-ID: <PH7PR11MB5958D56C366F39F5F044E11B9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
 <Y3Xv6XOwddNq6Gmr@smile.fi.intel.com>
In-Reply-To: <Y3Xv6XOwddNq6Gmr@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: f2943b96-e858-4350-f1fc-08dac94872a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXDzeuQ4TGpRFCIWsL6w025Z4enNm6ADhTcGMEc4N9N+gbeg/qTTDZtynCRjA7b/SxabzqC29k3aCyE2gtStoIKrVkXs7H1iuz8qOFsGcJbKqMjedhzWtoZdVJBlGpo36pwJFwxnTQABhAaq3jpp2Xaow9E3IW4WMmdqbLboPU9B24W2eTqIoKvwlFHhOupBckZ0kioT4/npr0nV2yikyGMY8klfnsEm2/5c7+EBSV6RHnPGy/N+L2kKfwsD32E7tk9/3PKC+UBzs4qnsRTiCJDbibeZNKHjiHsGYjumTVMQh3DcyzDPIJd7rLcXjAcogylyzwBVpu12SBEBbc4YYjyy0Rh/72lhjSluUWriaHowUMAax8ldfTbd0/5dNTyYYd9vR6HVEAtBDWgAFB9uTj3bdhHzwzBiDfKKbObX17K+crWueVOdLMumPe7f0u9YzinYarzJcxRPU/lP57/UdzHNLHywqPx0oelrGPJ4e72OtSK2fbnn0nBKM4LC8CBFqm20pzQsP5ONxNhWpMftzWa1OP53ii5oBncZHnBNB+9TLz90mPtUKzsEh6buzNvd4KJt+coyaNRz/Geji4mE1qtgZoBaBS37RUs2s0tUzab94SrjNuMi350lNu9gJ7JkoZ6Q62eIhvoNkw7umMsOuoWJheyrLSL0w+Vuo0I4byrRaH0VA5+s+gSnI/o7be13JJAXXxBJGgrF3Gn9DQKbwcD2Uvu4fq3ubDJMeQPG8uecbjwqUWBIdNt50Jow91CbfVb9zgJ6g6plt16HdAK7TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(9686003)(7696005)(6506007)(53546011)(186003)(26005)(86362001)(55016003)(38070700005)(33656002)(122000001)(38100700002)(110136005)(2906002)(316002)(6636002)(54906003)(8676002)(4326008)(5660300002)(66446008)(66476007)(66556008)(64756008)(41300700001)(4744005)(8936002)(7416002)(76116006)(66946007)(52536014)(478600001)(71200400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bi8pK3quSaAfLb8uaXXS7DytnuS47yqmC5dUmIASvUIG/0GNL8nvsl2G5k0T?=
 =?us-ascii?Q?pIvSm2MxuF7vg9jibPCGgxhkq5gEoqXIfUBxFxJpUTMMcbNP4MLDrcabubHr?=
 =?us-ascii?Q?nednHQTewyVKvqbStO7mv+laYENRWYy39sE8k35th0HpLQCV5K9D0m2Lgbox?=
 =?us-ascii?Q?N4R/hwGdj3e1FnjPzoiA1w0tFklagsFCqUOWImFgRZQSvXNgGzL5cj6Set1I?=
 =?us-ascii?Q?h3BX1USWwZKAaO7jz65xp0A/slbzEzVU4BuVS9EPyvs/fb8gVdGQgooLoR9Z?=
 =?us-ascii?Q?B0OQWJQHwJFqcSytBiaM5ni9+zeA8y/8wNRClp3KsxLuIcga1IWQQAzR9TcQ?=
 =?us-ascii?Q?rax4jJyJacptLxtDxJgrexMRwaOuKGKJD6RMW6e1K4YG38PZCgtjEJ+MwiEh?=
 =?us-ascii?Q?qWBq/iX8P93HSEVdwPLfNX81cTc6zinaOWnO8WYw5+skj5uRmly7GzCpGx4j?=
 =?us-ascii?Q?6R2qXHDJjXq5BiE+kAhJwNciVsXTuQbWZ6H0Ux4iUkmPFDhVifKMCOmF/vyc?=
 =?us-ascii?Q?QlKoQTfLUEsMLZt0XDlVYXoSK90GNq0EQ/FhVaQ6hQxJbAytTD8UiCwUxUz+?=
 =?us-ascii?Q?7Zm7W2aizvcdNuQApKgBuBrkVm5U75O5lkiK0xvUfTSfVtgGAodljdr+fHhM?=
 =?us-ascii?Q?na+/i2hM2bkvNkA7P4zCESvmY0+73RNWAZQuiaSCPMeL6xvf3GoWCIem2BCp?=
 =?us-ascii?Q?yIYOpKtQnA32y9s16wROhZHsR1hUQBaAs51tCL3ivAkd3b8+E5yGwqnhfhcf?=
 =?us-ascii?Q?VcEAGjZrgzEcpo7IXHkCUO7FzlO7gGTe7BiKPcf2ShsgiOJaQ1UQO5cnLqu5?=
 =?us-ascii?Q?m1yoYfzMglhfK1wWrf2PVivzD6nAMyS6zTp9dJjY9NBW+yfejz+DeYBpfgIj?=
 =?us-ascii?Q?zb3RSqrmlebM7zi+VU0qsM6YOBfEeX0Mrp/LHe5qZ3U7CoQlpjHkmUZtAPov?=
 =?us-ascii?Q?LQRrHuWvwOyJlqZlqgIyueQm8lE1Y/mmyNsW9YlX3zzPoUo88jWBT2SRQCKJ?=
 =?us-ascii?Q?sk1tyquKFHLWenSsUYXmtafrzLnZx+HDh+KQU9cXOBvf0peVqondu0mE2BNf?=
 =?us-ascii?Q?44jMYsx7SRrQpTH96yo+NhGSun9g3sgovHa+ZyUGX+IPzBnbsLLkiK5M1hFQ?=
 =?us-ascii?Q?bysERmmmsx/n1SH1tjI1XyrEYJDF5eZMO+FfXh2/WzGYH8M/iLrFF+zM0BZq?=
 =?us-ascii?Q?fbGD0ZaoqyU5JqaAqozdBETmqLOZKZVRZnZqmvNgsLLrCZGxQs6B6Ve7IPUG?=
 =?us-ascii?Q?CvvDehurTAu02N0HntLlTRSnvHD+gXXdILjID7VooZBjLAK0EIadFqqbG48t?=
 =?us-ascii?Q?FCHMdzKAaNHEddhGj5rr5E9IT4WAO9dU/KKFP600jdE2wdpwh4ejkbr1nRMS?=
 =?us-ascii?Q?UmkiYq27xt7U5oCyRwEs+zo8LU/5bvymjRSyg7Jup5S3ZA0Tt8OqE/GE/RQA?=
 =?us-ascii?Q?3nyl0FtRAxX8o//RSpZIjAjZHnWtgOYWL6kMaHy1TyxchSC58mLAk+0m8MRx?=
 =?us-ascii?Q?U2mZEolkuFLhQTCpD0vGtIJkKiEtfsDViGTEWqK/SV4bebL9IPsU7DihIU62?=
 =?us-ascii?Q?Md0dw29qUC2b2itwlGl4P1xiOV+AUhXvpsUTzNL74xInC8L6ISOUAdX9DqQt?=
 =?us-ascii?Q?rbbiCc1+5iPjWPXRKFqRZ4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2943b96-e858-4350-f1fc-08dac94872a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 09:37:02.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tc7hnU1faUWnNyiSSVWJRMaPtiMgxyMIkX/++lONnBVSWKKha/mZ3X50i+6wau4IX6MosHX6tKrF/jkkytRlV8H0LIDmJmvIWPZkCsmbTAC1HZrA3eEoWR3Z0oURAqPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, November 17, 2022 1:55 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add drive=
r for
> quad-uart support.
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +                     idx++;
> > +             break;
>=20
> default?

Do you suggest using default case even if nothing needs to be done there?

Thanks,
Tharun Kumar P
