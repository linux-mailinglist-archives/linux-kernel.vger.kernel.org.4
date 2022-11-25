Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB858638D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKYPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:45:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B724F2F;
        Fri, 25 Nov 2022 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669391106; x=1700927106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UglMO9Nu7GLIF9cgRt3jyFBHlJqQItEqeUZ3jb30Nm8=;
  b=CJAzm0KeKwUwM2nz/A8aRKHkPUa9bWptpRZ2XZXUSmiagNu7bCbB0ZSs
   GHb7rfl6AI5fmIPjbSGeyiCXzaqZ4PvmySykWGRWhfgltf9AIgosg4Ng2
   HPZ9CLkBknH+lXx4m2ElQV1d+EFgRqCX7WulMgSJR4bk3lmRB0bw4B7pL
   PM9hDpeIuD4Cf6fVFOzlxFivUUIqH3+VhVoZzyAWLozgOwVqLfV/NfA1M
   MGx/N6xv8FJrL9M9V/qdarnGwkOlpZn529A4hb9Ean4POq+PjOIC/zGGi
   En/fIhIshvXfSwEm1iHxlV6iTE8zCo0vcmB7XVkgQwIwJI0MBBfxKnC/J
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="125123506"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 08:45:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 08:45:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 08:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+HUTrDoXrJNQ6mdFCGjfg8W+Gb6g/5Er9/uzwIq4pLLoDG6l4iw7ezVOKNanCRZuwaX8+MnAwprv5nDa3RuZX2oqdT7Tw130kVoR2NEGLNUW/Df2IPj0TYqY4K4A+LILUB80+mzQFzmx0RQDY43IzCb15nLWB834JuFsWREmpAMvY6Ahj8zmscGmsUpV3kLd0pB8jGOI5aMaVAq8sy8RVcqHYLPbc1587HFKt9o2YleNyLTHCVPuPiOgv1/b0dBUCeXOmna6hVyIAV3inOdmxKXc1Gutqzx4mSglDlTKKVlLe8aWnrTkQdWfWw9fFjcZnUC5x2Sn2Tc1CUXWi9i9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLF9Pt8oRJE8n66wi6xO6VpmVgHzzaSQPDvHvqItBU8=;
 b=dnH5fV1dmMRC1qUFwu4qQn8QDB+01lltV/ID7XXfnp2OgWsE4EAH90qF6jVogRXvNIHBk/evJ7qaqQAf8PDx1JaSXVNDA5GAnqpq04CFjDeIulaL/fHQJeQ0oXs1Zwdwdm7PnqQ/Ld3xHxTh4lApbbKApTVsHhdU4tvGvA5cOPEjLlZhr5qSdKCFEtFE2mY3/y7DcCG5VrNdUeUiSDkrlP1WzoNvAzOn7X/imb75mNTHluwPndu9Txg9/qTYuYwEXrwbKo+reYR7Nr+FoEGIAVho2DQSkCIk0xAEd2je3HEcFbW8Jb/kIVpwY2P65x6ZMQ/uey2qPpIFEK20hlFRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLF9Pt8oRJE8n66wi6xO6VpmVgHzzaSQPDvHvqItBU8=;
 b=lXzP5nkrAvMtC1KXpnjuKlGT7u1EN0z0Fgom2I7DOvsyaPFHB4StyXIi/qNbU4pyeNPEbR1GBfu68rBrGerNwnN3O8Ia3s1ekZkBj78bf3uGUfiw3J9BTzs2gF0YbZQfOKvSmRurum9tFOZL6I7GLvAHNUiAvUqo2SB6HYGUWow=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by BN9PR11MB5436.namprd11.prod.outlook.com (2603:10b6:408:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 15:45:02 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%5]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 15:45:01 +0000
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
Thread-Index: AQHY+kGw646UxkiGXUmyIL2ickY+t65Cx7aAgA0MWhA=
Date:   Fri, 25 Nov 2022 15:45:01 +0000
Message-ID: <PH7PR11MB595813B2AB661CD50517DEB89B0E9@PH7PR11MB5958.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|BN9PR11MB5436:EE_
x-ms-office365-filtering-correlation-id: bad5a328-7054-4e96-5fcc-08dacefc03e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIu00+o+KAe0Y/vTS20id6aNO/LS7p9AxMUjwZ8E9YKUbKCOdIzcGDwUyGJTL6zR5GRVyuybWDtVA06IrslHmw6usP7OMdbxCuo+1dBTtoX/hMLFI7iS0lEK8P1LctyOGN+5vY6+fJfb3Ic0s+V5up/vbwI9ywOIKlZQCBa/fhwegqEPbMSQHatTh4YoLo2rUQGjkI3L6neefZnQQajU1x4QZ2YmqXzAZmUYoVxxFN9/cEY6dyArWP45K71UAU/wOS4wdko4/eg0PV2dXznKStb9vPsocjeHkgUT05HS2kQNv/Ci/Ytouu7TFBLTfYforN7+rqjw2OdDKX+yl19YitaU17VYoB9mtA+P4VWEbeC04Jvl4fISi6XhPAIvwj0OjdrqdYVJh/oFgy0WqzLJTI24OmK+MCiV57c+IkEQ5asZmjatsTA03SI/9r6phucmHtXVEbLoDhIcdj/anl7LbiVqLX3LEbVkFVn/fJ3GKAu+iTDY/ekgsUVJJUlFkBLIAjAzDes8c9sy1LkzltvBi7z2OQBk48fCbhN5eATOTdb9D2qRL8/bl075+zX6F5du28RtJSPLKLpeQSeS5CWsrv8LJVuVrgIQ9rAo87bJ075NKttaSqwjDUP87LFq3WMJICzXUQq8Zxp0l55vl2sL/qIzrbEoiH/Suv1gWUOjx1Bpy4N3ay9JnL7R+fiicjxW4m4HOpQeZiJQDNDhGWEuqajZLwieNegg538/RJ65JpvN7UxnqBSmgG3d87uykcuyPjNxTZEXDPuGO8t/Mugy3BPLyYQyL0nj+uUiECHm778=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(33656002)(55016003)(478600001)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008)(122000001)(8676002)(4326008)(41300700001)(4744005)(186003)(8936002)(83380400001)(5660300002)(52536014)(7416002)(2906002)(6636002)(316002)(9686003)(110136005)(54906003)(26005)(86362001)(6506007)(7696005)(53546011)(38070700005)(38100700002)(71200400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1wtU75B9NgRnr/9bGa03bEEMa2AauanYX9TcK4POFHrRVuQj8nrnDyIYuUT?=
 =?us-ascii?Q?+BSeOOK+9OJ//b927vS+nuaRi/3Z/vkA52TLT8Mcugr8g9OK0MwN6gPPKAGH?=
 =?us-ascii?Q?Twwx5z0xHpZa3O68UsMwWO6vCLgqcLYLt/wYluSWLTfW91vNNw9Z4R/MlCoA?=
 =?us-ascii?Q?ES2hmcmKOqYHrwKfGrgkaAyeeWebyDELDb4AeE42v4u6c/FPQ/IrIsjZj6MR?=
 =?us-ascii?Q?CgzC+6+a+3eTyu8lYBeZBbOdze9gzhYFcRNt54GrXHfnmGBlSXBunmcgNshQ?=
 =?us-ascii?Q?Z5foaKajviJDATjZ75uFCKINiJr6BpQ4juUSLTKqWPdedtZ33TtYEDIfOkcV?=
 =?us-ascii?Q?xnYMgkbaLCEKhk9nsGDiMmRimun6fr3zyRORV8VFm9DDstBfh/qDMEJjVqGV?=
 =?us-ascii?Q?DzdUyTKhYdb85I/qZ7ix1I/ygJzvZKYz+JJVBL6nso1BOAvdpcoePz9AqLz3?=
 =?us-ascii?Q?xS+jvh+nbVRMp5/3Z5IAYpWaBeG/qWUVmhxzFU7lSqSgLr3fDvOG24Zo4KxX?=
 =?us-ascii?Q?Ufp5x+KwpKskh3IUm9VfcvYEmfV6EPV7kl23Gqgcr98OzWmYFLcSLWB2xGaN?=
 =?us-ascii?Q?LplrWj3CdmQrgzcqaV1eDT7pIRb091qDFS0wjepu+o8JyzXrQVu9d21uuyBc?=
 =?us-ascii?Q?Qbj006t3r5HMs73F6n2mE9RkfMnI5BHYVAb/kA4WjhqgbWzz99c97O6gBNAW?=
 =?us-ascii?Q?XYLZNndQPKqiwM0EzVfFpTWCVfH6PtfAzt/Umogkux2aG5OAg7D6KGMgYnII?=
 =?us-ascii?Q?vbc1lqgA9y8hPjhJfQdphNMwBaSs/cYdNZdyyZFMOxx4+1kqETxeQ7XVtOva?=
 =?us-ascii?Q?YMB3V6WJW+grRvBvsBQDPtaNgnXS1ZQ6iCCx/hz1Yvnkg91hNKvUIok26NTo?=
 =?us-ascii?Q?9QgjJVi7hcfhx0/y659ZlK4qBpSk81ER3H/gqy4hENaimAm/eMfucPXRrcpD?=
 =?us-ascii?Q?LcfLxXhXDf8IYxKtdthImzvM9xMYqV2E84OjxKOiq2LqKx7r8cwXORqdJGBM?=
 =?us-ascii?Q?ZErVpZzjN80wEBTySZAvZsJM4a62X67VcybE60KDS27tirSG5hxObd8GGSHe?=
 =?us-ascii?Q?p9Uu6Hln5fL2JGTPdzHNchoc0E7Z2GF5P9R+c/gyRzqMxFrLbE72ah/unrdn?=
 =?us-ascii?Q?f8l/31VGJ9UopGGVS8FNFaRL9ZM/bTJQvbkyKRBrJk/VwbFiO97/kn2F4Bk+?=
 =?us-ascii?Q?tWvuCTxrm0GHI4gwxLTeMK5JJz2jCgHUGQiGz5PCzkbKy+Vr5sSdF++84IpK?=
 =?us-ascii?Q?omu9KoqFYEqSOVTzoMdX98DX4t9Im8pcQX/guIOOAzztwQ43H3FHpJ6d14HI?=
 =?us-ascii?Q?JBBurHrx03v2/nB30FjpFqHbLh/6uuSiA00tGmxP0e4pcQskaGsVx87QmvQ4?=
 =?us-ascii?Q?bQgSUj+JQoLbaNfTIddoxxpULAGmwNoak4aoQqdiazDBKyWvZAYp6PKAsmpX?=
 =?us-ascii?Q?s22jkmjgBjVTRhlYxHmuLlBOJW6W2dQ8OG7HdhOUzfZPQjAVVrQd3VEstSfc?=
 =?us-ascii?Q?kvQcJiQHAnp5tESbmwL5fsayJ2cyEc+MBTYQAlDXC+o04D/yl4eCcEiThvhJ?=
 =?us-ascii?Q?Dgvo1pUNEoerMpMV96//JP3zChr8H63C64TqY6XPJmnxrKcCDktaqpGKUT5M?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad5a328-7054-4e96-5fcc-08dacefc03e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 15:45:01.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WubmPmdQOoQLJMkbTLB5Ar2hBExTE2WmYAQ/EHrVLVpB5cQqx9n4Li0f4dbZIwI2tJFmotoYoMpxCl3D5boksJ3YxksVYSydwDtkY/oX4XaKIOCtiBBJHI9xv69+0vfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5436
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> > +     case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> > +             irq_idx =3D idx;
> > +             break;
>=20
> Try to make this entire switch-case more compact. It's possible.

Hi Andy,
I am planning to use look-up table for this in-order to avoid computation w=
ithin switch case. Does this approach sound good?

Thanks,
Tharun Kumar P
