Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A45BD40A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiISRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001B3DBCD;
        Mon, 19 Sep 2022 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663609661; x=1695145661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBOnBFmku9NHR0hIUvhdFrjMQPQsey3PYA2SrMTd0k8=;
  b=gkJszdq3iiOSS4857NhC2JKVVkmT5GfZFUl9oubZAzJ9kCxCPCg3hwsS
   IwkQVQxxZqIUJiileFKpBuljjB9sZHIHQkPEbYR0Y9zUCSH7wapnl+A/n
   lhiNeqsiaT7wXj7o7fbZnq7i5UMWpjUDLq+VuzKO++ajxrDGdXgoZB8Ve
   hb+sW6MRLQjFMwG6x3ay7YwHpvzZfYh6OcT06UK2RmJJ8qLaz4EXMKe/h
   gVEzHxQ3ECKav/mr1zMMDog3iKNIByN6Gwgf7g2YUTU3kLtUssc0TvX5o
   zeqy1zqITrrb0ZuJzDq9/lD+/1fkrEhsIKfssBtpPwEzX96QrgjtQpl4U
   w==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="114395647"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 10:47:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 10:47:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 19 Sep 2022 10:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbGQFofnXse15bfpLv9mV3e2Q+eiDpiYeD9nr/RR6BOjd1AR1DJ9D3CWSBHKC52Aiiw2dzvTnvUaXmKJBwvohJRG+pyIupjXiPmf05+/Op2TCiF0TdQ1eNaI1UMA66IxF5hQkeY7cT6TqgLzVKPguDcJrAkfnm/3tx7wQpx2Wvh/zPc5RghVcoxVtfmMIAQB6nhv6ovW1vLX274Jm4ks3q44M/PjRRdK7RVN/4N7ZYs33F363oGhsUtBH2CgEBEtjIivm25raZY2/REzLa/kVD1Ihk8vSUD5XahT5AOVz+n4VPxG3oEvAhx3UvdniB7JzDHY6ETCwKjT17+ofHPKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBblZngKt69mi3oXOeBjyEKwA/8J+/bmCGy27wahsXA=;
 b=AnuzVL+EtG+d3n4Erv0JTIuzVfyp6X+fML1bwwQxfyOlhTjBF4L5X9SY/lB4S3HuxFZoRjKoxpIZR434RW605mJ420dJPGZYl+CLx02USwFfVvuhDZaK339hkS3+SFl/zIfU0bBREiUaBg3LipWx9joJG8RL5EGSnrgfmKjIInd6OoNkRQeuRYTyJXE7i8P85nW2BBh40fhF83xPlsQIWSLjgYZLlBf7r0vlQmf91aRkXDFFanQ2yjJzxKVg8Dl5/6aaVO1JdG69gLnnd+rgqFp0BtWdfKWbUKl0YvGjzcv+2OlX6IZmXk8TprEVjh7eLprUhkun7d1dXSrefmds1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBblZngKt69mi3oXOeBjyEKwA/8J+/bmCGy27wahsXA=;
 b=tfrUBD3iQZ+i1COAld+Wp2329XKT1r0dAdomP/PqsLsNJW3TPFRNsalwOR3zkCvf672AzdIPEjHhgms1rf6kDruNrHLIJfhVsymmu9VE9uUeycKUn7k/AZYU5Zp6CnIcVRMs+KfQPnDk3gY8jMPpRJdJPktPu2x1+9bCGPCzUZo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 17:47:32 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 17:47:32 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 3/3] misc: microchip: pci1xxxx: Fix the error handling
 paths of gp_aux_bus_probe()
Thread-Topic: [PATCH 3/3] misc: microchip: pci1xxxx: Fix the error handling
 paths of gp_aux_bus_probe()
Thread-Index: AQHYyyfVbIzjIzDakEyLcYGvw1j8Vq3nBpAg
Date:   Mon, 19 Sep 2022 17:47:32 +0000
Message-ID: <BN8PR11MB3668AE58BC463106D4BE57EFE94D9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
 <1b41531de02ee029628d9b0ec2cf1ee7f180fe10.1663482259.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1b41531de02ee029628d9b0ec2cf1ee7f180fe10.1663482259.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH0PR11MB5952:EE_
x-ms-office365-filtering-correlation-id: 5c56e038-b6a0-4e5b-0b94-08da9a670793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ir6/BnT67BUPiPRYIhzOtfdpMf0g2cvN92SfzUmLCSRKGOEdRPVI7Oncb6DKWY16wHdI/GGX8/goNPOAo5I/EyFvFA4mpW3JnOYHqgnRXxRzgd4AIN+mVoSjr3ICZLaZ0MUaGAJWEbs7V7albqTbK4HpHFDz2pGDGlS4kYmeFxNIRvNW9oVR6y6rtACdT+7TeKgh/oLO1Q/ggwhOCDfeh+xy0OVU2xigufiYl7/+9T+PMzyYwskjGhqdG9NBrWSUVVYm/kVaSRfRuIBNfDrgQUE/ufeSF/zf0t75SzjjWZQgKuexICcYRtnBAZjQoh/iICtPjIHqt+ya3ofji/jj7QoLSSUdCIF/mBL/KvQ1cIg94gY2F31N7wJ826mHfLgVu8V6oyyt6p+AVdti+DpjEP0SX/5vZepDECxODLTuPWLiaUFXW7AVLP4FYm5LcYZ3Rl7PJWBxl5ax6kfSbjYQdxX3SJUSNEyN7Wk0dF9TTBm/XMDpN2D0yM1HXZGz5E+C4lAfkuhH2PrMm/uNwb0lE5DWBzHceUm1ZbahOZ4GhsN3sfPC5sdJvGn5RAeoI30eQ1TCcQ2WFu9QLFbOzYzVp11QrqtlyjGpePKS+QaVm17N7d8walL4hiva37OCED4FHu6krq0G/sugI/mPmkWOOyInsUCFkZ7P9TrVerXsExjqqU8bH0f3NztXy9yLV7lrnAsQdpT6s6nX9qs7ncmi7xSvUMmop2jMTACsY3Rfp1N5OH45HHkQQcrRUkMQO94v6Tjy9EhPRDWCZzHBFp7ajC7/d8p2DJ6imF47Dc5wyEevs0kZv3C2Lkz49ibcu5O8DxqVgNs/edtMKrfUyZy9ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(9686003)(7696005)(26005)(6506007)(53546011)(38070700005)(38100700002)(478600001)(2906002)(5660300002)(66446008)(122000001)(86362001)(33656002)(186003)(71200400001)(55016003)(83380400001)(41300700001)(4326008)(66476007)(64756008)(66946007)(66556008)(54906003)(316002)(52536014)(8676002)(76116006)(8936002)(110136005)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGptpTZ8U+a/k6Apq9taWwRyD1GNrRFmZ1GJUqv9ikJAoLPQKu3E4eEWSvWH?=
 =?us-ascii?Q?kYKGw0gi7oPBtiqZbEVV5vWTgQNOsWBlkiXeRibvhFiaj5CPPPEKLb8J7nii?=
 =?us-ascii?Q?m+sqkcjqMGGzuDxT2lt+nirEuHDt2+v1O2rr6wDeqTI+dAU1hih2+WnSKdut?=
 =?us-ascii?Q?o0r4KvsVHc6XQOOl73iutMiW7nstd3nnbY7ICO9rnWVwRzUvNL0ASuq6RM0d?=
 =?us-ascii?Q?42VZW0kEdMiD6bEbBybG/Mudg1CZFJrNJzCHuHBHFGFqFDrrBlkXUIB1E2oU?=
 =?us-ascii?Q?ygjulxSlRkJwdnye3H8JVHJyBvvjzo8yTry8JxmWP0k5frj7JqyLeB5rKVHo?=
 =?us-ascii?Q?kHOhLqJoo9bHNY7UD3fgFszp83yrcOLb8KBqymPVcDKxnTIUWQSImYKEi1iL?=
 =?us-ascii?Q?p8NPFnxUZu7IWohGegEsyi/HemRoW7vBIgAon9cv7cowZNJ0pNPfJG8sUME9?=
 =?us-ascii?Q?jlktLuYnWKFjzSOn+B9yP3hqt14u/eFSmnTafWQULbMyA7Lo+KXZg+2DXeYu?=
 =?us-ascii?Q?SEsbEU7zwAEy0inJe+pd3fG9v4zdK1iWakgqumAHM/iz4igqag2NS1q245Eh?=
 =?us-ascii?Q?HqMufeaHko1Ja7sESPohC/C5h3D790wnGJunCSrHvWAARiwKLSRItLA8l0va?=
 =?us-ascii?Q?6wTC5NXI4NIW2sNtZ3zZ/PCzGEs8M1rF0E1iJaKgQ0C7kpmHtNhN1JoZDTVU?=
 =?us-ascii?Q?09Lf1+QnSb6XIL+YqykzIPP970EBXnKbfmapKFOPDOiHvY9BBXTmlweUzSt0?=
 =?us-ascii?Q?BuWkjZEdZE0RI68oJRzlsrA+8XjAjz+D8hqAgoT6y1AB6Qs7erNacWajPWgH?=
 =?us-ascii?Q?YZwVEnGtbJF1ZySZtjY+JjgNsnmk4gTMcfKb8fJ+6LAWmoM/zPwNND/tY+M7?=
 =?us-ascii?Q?6/EnKdrUnVdybu8X1APCAwWSAUZoxduYMORa7/BV26X72ACaCM6QYuuPUAx9?=
 =?us-ascii?Q?Ulv6l02vmH0XjvKddlojljkvWhHUQTv/f8baR+WICA8HYbjelp5oNtDY9+3o?=
 =?us-ascii?Q?d8k9g1Vk/YLaUEWmAv+xA7ywPGxEEDft+WbUxM9Q+En2zkzadVqQacxQXV38?=
 =?us-ascii?Q?Zp4aaQ96ACAF54PPu+IRnPODrz9epnrsEB+KMDqIkWFP+dMo2EMDUW0ojtHc?=
 =?us-ascii?Q?nqoglgcblVnrgOvMQ6I2LjUVyWdRGL/DIw06WnCSwoNgbQuL0leD5ZOPZs0w?=
 =?us-ascii?Q?MXizsQH3KUptPCjInYTaU4UHVIqeyNTEnju+zN0o6REPaLDIO+hjyWvPDSkJ?=
 =?us-ascii?Q?DdApOHy415uwj5zmKG7s/3jJqtcViYXDQkt0xSKIkY+jhq703JdE+NSojX1D?=
 =?us-ascii?Q?BUZA7a2FaWp4A6Vh3+v3423qE3BjFcjCL5EvTdKwurdV7WSmygXGupwtm0kd?=
 =?us-ascii?Q?WDE6kNRtbFMjQXConz5rGeRo/dgnRporjDzS+vuMQuxXFtCRI7Fg23By6WDM?=
 =?us-ascii?Q?k7Pjsx/+uBGsICQF0spRn7ZKlsP1MY7DZOT/j9Acy+L0pPS0nwsYfSO30vGT?=
 =?us-ascii?Q?Bb5pFOvXVySdI4vuODzLcOcqaUuXNQ+VA9cuOnAPDwn3jnxymuoEx10GVZac?=
 =?us-ascii?Q?o0OhJeCOEajSe8tHAs5y7anqqtSlK33jZ9beqYnagj39Y3pOxKbMjic5OEHN?=
 =?us-ascii?Q?QEgJS3mTTmYg6aK7FthriPY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56e038-b6a0-4e5b-0b94-08da9a670793
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 17:47:32.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAG0jPvEKTC6xBfMp/0p2WV/R2oTNlVywILs3AJ9TOCStUAqjJrE/I7axCUoqczUi2jE2dFh/0pF23vq80tlnw8/Pt9LfdV2jqlhs0/PxNoQfMjLZ2dljbBjbdeFrSGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Sunday, September 18, 2022 11:58 AM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org;
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>; linux-
> gpio@vger.kernel.org
> Subject: [PATCH 3/3] misc: microchip: pci1xxxx: Fix the error handling pa=
ths
> of gp_aux_bus_probe()
>=20
> There are several issues related to the error handling paths of
> gp_aux_bus_probe():
>    - some resources may be released twice. Once explicitly in the error
>      handling path, and once via the release() function
>    - auxiliary_device_delete() should be called after the first successfu=
l
>      auxiliary_device_add()
Thanks for your patch. I had noticed this after one of the reviewers had on=
ly partially fixed them
up. I need some time to review and test your patch with the hardware before=
 approving them.

>=20
> To fix them, reorder the code:
>    - move the place where we get the irq for the 2nd wrapper.
>    - call kfree() and ida_free() after error checks, rather then in the
>      error handling path.
>    - have the error handling path look like the remove function
>=20
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for
> the PIO function in the multi-function endpoint of pci1xxxx device.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative and untested, review with care.
>=20
> Other solutions are possible.
> For example, we could use devm_kzalloc() to simplify the error handling p=
ath
> and the release function.
I thought about this but had some doubts whether it will work with the auxi=
liary bus
architecture as the memory allocated will get tagged with the same device p=
ointer.
I need to do some experiments before taking up this path.

Thank You.

Regards,
Kumar
