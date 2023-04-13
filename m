Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D96E0617
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDMEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDMEnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:43:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C859D2;
        Wed, 12 Apr 2023 21:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681360992; x=1712896992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rAJcYsrAOEHHrSmK/p7h3kPuQc/hw9TU9B1Ifm3EHrg=;
  b=HZBhmdaEPsmyI8qJ+m3geSL3CaBSSCd8MEUyLk/426ztQRx7winthdaX
   VE7dXgxPzlg8d44j5vjkHjRAUYBpZrO8MRN/d1zIx5ZDcIgyNs/egB1Zz
   DeIko5cAVGUBgxIED7Zdvr3MOj4wn6nhMXiDx/PQmSo8bNDcC/XhmAx5v
   8xtDslEN4qxNCGeRrRTmG2F9cNjJD3aAqCy81QfX9gl4cMOuhl28YB3Hj
   bDP6UfTYkks3XwJZ00gd0TQNUMHGbl9UQqKLkQpL8UV0Bq8Znh5/EbjFP
   ZoZq9yEejzEWJ7u879zQit5Ak6i5HFwCRWmIsQguQ8Q0zS5+aT+9nk0rQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="scan'208";a="220669133"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 21:43:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 21:43:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 12 Apr 2023 21:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1trmuqv6pqIu0v4RdKojZGVllhLXagpJ3xmTIr10tdjmrCZ0xNJpvFdvH4dUn00X460aynvoV+uCYOKzBafyZ59e3Rd/skCU/4UsYUPSCD90Yc5CogZ2WA+Qt/Md/ok77P5MScGcu56MrChf5txBqEVIfbPoH/csZkD//aCs1uxDHQakLOslxAG90p56upk6JWcG4VQoVUaOazcHkVHKiBVyXnlM63cu3fRFTaj7mkkD1ltSjGsfR1vpyEkSAyrCNYe3Tv4nhel84tqewDxcq5kY7uSf66jQ1XvsMFe4ub6Q/LIO8BkrZJj09eJqHYi+sN56EMZG2yF2AuM9jsDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JDElgdvIdSwSObr5iM5XeGLAP/DzoM6EAOiPMI+yZY=;
 b=N2DfG2po/SSmzD3FRL86Eb5pK9RJsW23B1yGNiz1il8YQszJY1ISavatyiFhTaUGVK80+JEFzkSLQ2aj5rbb2irNGDuXd+GV5CjifLY70iQh/sjdhvp/zBOkV13mT26c8IPwUJSg3nwC2F8D8ShEB+9Ou/rc6RUrjlaXPf8l1Xrdz1FXYckiGzVSS3fUYQYezGMZeiC9xMJMOUMm2pftzSJDrCvzoOBZDsMY+VzGuielEkSNEKliCDaBZzD7nNLYW7tXlreDHWI7LxtQlrtqMP56cE9kvn4oq61ifRZ0YSWQu8OtEFzs2ukmXGMqrZb1wOOwkoL55FFeqWN60t++Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JDElgdvIdSwSObr5iM5XeGLAP/DzoM6EAOiPMI+yZY=;
 b=SOOH1pYjtaxRDYIzn0trh6V/lGIX83aBIDLmhjWn0YfUoWUCFSySofq4LCB1eSIjJzbqAPbJZRkRsxYgCyCyo8PdF2fuQdxG9d8q/sXZJzwzBR60nUdFc6F8e9K+C6e9qe5Yl8bw/ogrRPwVVsYep5/jCCtDmgH1FhFry42XtEc=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BL3PR11MB5697.namprd11.prod.outlook.com (2603:10b6:208:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 13 Apr
 2023 04:43:10 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::84c1:659f:bf4:2328]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::84c1:659f:bf4:2328%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 04:43:10 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <Y_Ashley@163.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <dzm91@hust.edu.cn>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: mchp_pci1xxxx: mchp_pci1xxxx_gp: add unwind goto
Thread-Topic: [PATCH] misc: mchp_pci1xxxx: mchp_pci1xxxx_gp: add unwind goto
Thread-Index: AQHZauGuhYFnOhukmEeia3xqTdT61q8orhlw
Date:   Thu, 13 Apr 2023 04:43:10 +0000
Message-ID: <BN8PR11MB3668BB25DB6028404F423086E9989@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230409124816.36137-1-Y_Ashley@163.com>
In-Reply-To: <20230409124816.36137-1-Y_Ashley@163.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BL3PR11MB5697:EE_
x-ms-office365-filtering-correlation-id: 04a16417-5cca-4a5f-70e9-08db3bd99551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfealMfIH3MqshVJRUM+o/VnN1lx4fdNI7kIOn19yV9LDONdNeXV/b6JsAHSH/nit2rdNLT8M+HpClQpXq6WrNH2fBfmap168rCxf1NIhjjeuO0ejyBXB+JOIGQ7FGXThoxwiUWnyeftiaikJlrnnWwGS2GPtlT9+DDFQL3C4jA3u+bhzfj0rNUvDonI4J2lKrB6OQlNVJmXjbNeBJLkoLiV1T6kD7AQOsJL20eE8DS6qDCtfZO0tcljAsm7+xlW3bRkKf2TTYlJFiiYutu+l0kbyNNwDm+QtBzHinjmEQqe88xdhgZNMXqMqziCxwrWV/7S8ao920gJb/D3JrsLqEoU2VNI96s025XJPMKaDy015dtzMHJSJNWJ3RMBquNzS8XrcoSwlE4DHyj2KXHr1uV9aDC1QjL0jaT/TF/ayzraibKrWzUwlL/1Xg7EYFoZrte02DzoLmEvvr+E0k7fzS2Icn10Z3X58dxxZeI/a7nzk9A/wIuHcb2WK+HYMCHFDyN1881D/tHz6KVnDVUlZSU89D+XDBfIXxCxIiGrQ8U+GPt+E47pWfHN0bavFbJEvXuRq0+E7pqQxo9OLEMK2a1MK+GxhVgbnT551xcDzXj6spTSXUNAbMF1vjB95r7HXmO7ENpXg3NmnWfdViRr5y1MprV5p5Q57DfILmU2/Q4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(478600001)(7696005)(71200400001)(83380400001)(55016003)(122000001)(33656002)(38070700005)(86362001)(38100700002)(2906002)(53546011)(316002)(6506007)(9686003)(26005)(110136005)(186003)(66446008)(54906003)(5660300002)(64756008)(66946007)(66476007)(52536014)(8936002)(41300700001)(66556008)(8676002)(4326008)(76116006)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?weOWT/zLQov1NH+dvgeAK84WKuIfAgBIZ0Hx9s7L2daAEHbJ/mCTmDmPFMuY?=
 =?us-ascii?Q?k/fBzFEK5S6R6CmQeKzYUHEwkvedKWInTwlxkVYqbw7K/lfaLhcEKKm80jgV?=
 =?us-ascii?Q?96PSG6c9jiAY9fsmEGr/W75SghdGCHu3g1CNeQpUN24eEnQKhI/5gQgNWrLN?=
 =?us-ascii?Q?4W3bCJijrUZAMWeWUMwcSzt6sIFNc6VYya992TkUJaL9VINO9V1P+0aIGhhy?=
 =?us-ascii?Q?Gxxx0bd275gnunHDJnkVJFxYcSHJwpBrRDDGhiOW6y8/ClGgX/fQSv62dzHs?=
 =?us-ascii?Q?cT57kwGtMPv8aWA9oLbWkVjcmNgIRU72N0Mm1DJlNqKV0M/YbDzSV9vhMp0J?=
 =?us-ascii?Q?G6xNqlBd+L1Di08d3+aSbBZC3XqDKveg3O8Y/a2xjKCQtl8ZpDB6cwHk9Y8D?=
 =?us-ascii?Q?WyXyqR8uFOXrJWdegGq3nKgNDUWM1KVw6fXsUbU+NAHmwSPP5Zp70Ka2z3YL?=
 =?us-ascii?Q?dwB68UQ2zBT4x2oWdL1gQMeEidHd4qUHyD0wEWtUCTdPWsY9RSW8na734dEC?=
 =?us-ascii?Q?eItZHa/SW/oNVgWCtXT6aJ3hqQbE0hB9A8Ajf6zlyxEt5oUz3LlNin+HmjTm?=
 =?us-ascii?Q?nGsoTvpXZD0AsHCyx0MS+WIeSK/G3v/FL9RfKhXlWqkWl/5RL648tVjeV/2o?=
 =?us-ascii?Q?qlJ5MOD7zPPwcSQgHAt6eYMzg9ImrxHbJXoLK3GgApg2EJ2GZgs1moxtIoTj?=
 =?us-ascii?Q?bQ+3comZ4dtiN5/6YDbVqFVcr9hcsxR4W4UEOyC8rcUGN2todS8xAXqFfcjc?=
 =?us-ascii?Q?//2nn0XmA+jRzqFxU93EGvRg6dHHORXUI1t59GzA0hBNh01aNqRnNMewdIqm?=
 =?us-ascii?Q?U7W6KIQ5qQsd1fp2yuyADSUGD42PLEw98MtUpzHGAS6Re23jP2eNo8MpK3Gx?=
 =?us-ascii?Q?qqykoRXIbtiZ+eYG3UEJm4EGA5lqVOBkqTk47TcXoka3DjhVh2DcS8jjnNK9?=
 =?us-ascii?Q?q662NXnwT/ZN70OQKomrSJRdp8zi7+hT566PnPN4AHbcqcNwYd+pbz/gHfQ2?=
 =?us-ascii?Q?8jJjm1kPSQbTjSfe/294FzkGdA+x7mw6xL5+IKJ8h50dh+mMAbIs+3laDx2j?=
 =?us-ascii?Q?IN4jolTroxb1I9rPi2kgEshkvvVo+ARSj/ERrXb9wT3c3j1hK2HMtXvvWiww?=
 =?us-ascii?Q?XvK3CMcsxyUXUpvQjQ0dBrh37JdJGHokcjUHTf8rrseYrFxSUbTSQfNiMe+B?=
 =?us-ascii?Q?RuIH3merqOue1TpRAr6TbHIrPpxo/g1JT9oqmTsMmk96AbzPPYPSFXHu0Y3w?=
 =?us-ascii?Q?PliQIjqMvTTfAhCkPKY46a1pP+b/trJPTwWDhGOQP/TQSieIe02egGovkVmx?=
 =?us-ascii?Q?08e8qsAxvczUdyXWb+O04P39B6+gAmNKDcq8CUk/XOVUpYdiBck7Kg8fAWYF?=
 =?us-ascii?Q?7C+9g1+KQEx13w0Lh69tdHRnepaeyzmvJbx4PiIitVHtC+wqaULacTkwOsA/?=
 =?us-ascii?Q?i+OWVH3Br0BfEip7o38Zewr0YJGMLF8Cyu/YChD0PGLHxLJjUoiMSehRkCzl?=
 =?us-ascii?Q?pTGTp96AcgfOmPo9uUq7HK1bdzPvQrQchjdCSB/OnYqrh6TPaXg8yPIfxQR7?=
 =?us-ascii?Q?v/6wCgHlg0RNNhO8x96jHlKf4UJemGFTP2nWIBBGPwfbd560tok+exTE6v66?=
 =?us-ascii?Q?yMz4vMRVQ3b6e6h4wikcd2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a16417-5cca-4a5f-70e9-08db3bd99551
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 04:43:10.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urDFFDX7k3mGOeY/uNVVO4UpupHlal8LOsrhHFCuTFCSsoUiIVcFMIXiEqZxMWkcLX55qsGbJwXdvsywYEC7oK50VCyE721dnuiq1GK9FHgYPfSMHqdqSHy57OAqwIId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5697
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Xinyi Hou <Y_Ashley@163.com>
> Sent: Sunday, April 9, 2023 6:18 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> Smatch reported:
>=20
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73 gp_aux_bus_probe()
> warn:
> missing unwind goto?
>=20
> In gp_aux_bus_probe(), when the allocation of aux_bus-
> >aux_device_wrapper[1] fails, it needs to clean up the allocated resource=
s.
>=20
> Fix this by revising the return statement to a goto statement.
>=20
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for
> the PIO function in the multi-function endpoint of pci1xxxx device.")
> Signed-off-by: Xinyi Hou <Y_Ashley@163.com>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> The issue is found by static analysis, and the patch remains untest.
> ---
>=20
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> index 32af2b14ff34..2c64b6b3cd9c 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> @@ -69,8 +69,10 @@ static int gp_aux_bus_probe(struct pci_dev *pdev,
> const struct pci_device_id *id
>=20
>         aux_bus->aux_device_wrapper[1] =3D kzalloc(sizeof(*aux_bus-
> >aux_device_wrapper[1]),
>                                                  GFP_KERNEL);
> -       if (!aux_bus->aux_device_wrapper[1])
> -               return -ENOMEM;
> +       if (!aux_bus->aux_device_wrapper[1]) {
> +               retval =3D -ENOMEM;
> +               goto err_aux_dev_add_0;
> +       }
>=20
>         retval =3D ida_alloc(&gp_client_ida, GFP_KERNEL);
>         if (retval < 0)
> --
> 2.25.1

