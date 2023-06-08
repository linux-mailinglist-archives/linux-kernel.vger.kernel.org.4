Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB77277E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjFHG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFHG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:57:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA732694;
        Wed,  7 Jun 2023 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686207431; x=1717743431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YvNzLKpIivw7H0+/f/yfZy/wbrdTOzBWT6fqIdNr5jI=;
  b=FiXlS/JhHFIMmEl8450EVjllcnhBJonbZbkrwHvlGOW3eFmdM6pfDS7p
   Am1JgnOrFVgBnJScCz0kZqxMDE82OYLuQWvd6/ahi1ZlOQBQ1NhXi8rQM
   uf3TL4jbHSp+78/iwUzHJbCWh7TuUzyTbLRnie2PySISEHw5bH64ZlyVu
   hCNGS8xC45i3FmQv0V/83UFCFtTUbi+rmbH/PZ51jCBSSrwxoduIdkl3i
   wDDfCCVF1tim8Ru+JSgF3YuIVQkMpiztbuhQImUxZT55IHrhcs8w0ZGgU
   LGdVb6HtPuJpJZbaFqbbZSH63EK3cuksM2Zt7+b5LC9S29TK88VHEY1T8
   A==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="215149681"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2023 23:57:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 7 Jun 2023 23:57:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 7 Jun 2023 23:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv97eTFO4qmaKkfeEAA/bjY4GJamOtqdG+oIw04yntQH6KBs6GR93UGtKpnwskHhibT/R1fFVCo1fQdDhwq5HJfg/G2UeZdl8f/ksIq6aT05/F0YP0RQ42QgJA2lWkfzyFDmLBTQ0d6kazL3nIXQZyYAOEQ1GduFASUzjCS2Og3YXqT72riuWu65UYrHB74Eb9aWPz9NQ+WuIqu6dnMnn8IzxqRoXIwgGIux5MoucpopSWLAkpEHTJYAVFPQ8i9NqPtS6s8/uOA+Xa47V7Wy9u4b6S939sCXQtYRlNjzXvlL9lPlW3xEepu/8pZsGEnsfrlsZBEfO3QDtZFJQivLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS814nM6RTFsITjMNIry7yE/U1Rb1h3i4OU9k/qB8JU=;
 b=jtN5stVEhBotRpmR2ag9NZ0B/L6SgGHV3BaqOx5c5t6pbaASMXvBwcDUsDGsda/6SLT1JAkJuEpJRTW7O0twcbkE2Q9XD4+qVOXipoZp6BSOkc6blgX0Q6GJMtrUaNxbPHLb6ZGHh72O+CXurfxBaK06LQiARgq9c56WM+QrT5bqDzVnRD5wvSa3yYB4mS/cnLLsACtcAPoHi1XoTxjrB+pRkqI+z5FCbWrABk66ZkFAjPe7nj4/WQVdGF+CVOY127bifJQbHcOj1sRJ6aLWAk3REt18RumAOWh1wcrW2+0UgMHa0SiwLiI8mCL0EP1C1/oHp1Wa4iREQAKhFakP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS814nM6RTFsITjMNIry7yE/U1Rb1h3i4OU9k/qB8JU=;
 b=BZ3X42bR9s71ccHYFQdankQbqaGUGwmHyljTaeN9RCekFRa5IyP9DyZ7jLbjqnLZRBVy37cykmneOtnaCiK2mP1WAwJm95E58jdklTzRuIq2hmtft1OeY3hklGSlk7qx/Nxr4NCZO339wPTrwaaP1aZgqSO+U+qVHY3sHvBtfCk=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 06:57:01 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::1706:e90d:6498:57af]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::1706:e90d:6498:57af%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:57:03 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <harshit.m.mogalapalli@oracle.com>
CC:     <error27@gmail.com>, <dan.carpenter@linaro.org>,
        <kernel-janitors@vger.kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <VaibhaavRam.TL@microchip.com>,
        <Jegadheesan.GopalManoharan@microchip.com>
Subject: RE: [PATCH] misc: microchip: pci1xxxx: Fix error handling in
 gp_aux_bus_probe()
Thread-Topic: [PATCH] misc: microchip: pci1xxxx: Fix error handling in
 gp_aux_bus_probe()
Thread-Index: AQHZiaaShOw8rdGJgk+41GVNKCKV4q9xD/ZggA+HExA=
Date:   Thu, 8 Jun 2023 06:57:03 +0000
Message-ID: <BN8PR11MB3668990F7108B177420FA3F2E950A@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230518163333.1355445-1-harshit.m.mogalapalli@oracle.com>
 <BN8PR11MB366842432B7B3564E491AFC2E94A9@BN8PR11MB3668.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB366842432B7B3564E491AFC2E94A9@BN8PR11MB3668.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|DM4PR11MB5389:EE_
x-ms-office365-filtering-correlation-id: 57072c2b-0f76-47ed-bbbc-08db67ed906b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udsJbNS5NK6ugSEsKzJUgnFj8+vkN4owV91SvdUVNERcg2xFdpVWh7mxJyqOLPv1qKUPkmQy+cYzlXujyaam8m8CLFKa6rEW/hNmG0zf3f9okWez0UUIBXNXX0EU1jN2d5T8eKRkbKixRVFh+5gOORr8z46FLTtJ2Lt1y3EioBd4tfUoAeSm7zgOxNZ9d0MteMG2QtUozskf1I5RQxQ08PnR/GR307shvXcZ9s+4CDMc+fHe1al+zbT2hO/vlgFfYfMHLkkHJbknI0jy58edW4w0rmRoWFdxsrHTDtUA4L2OtrGQ4T+mZB4tcBagCPFlS6y15g8EvdL0WS91ARCP9CWyqmoUvca1qudJ/81KJ7YOpkJ9W0beAdr+uOGWnCbyj3URwei/aN3ZIDyfrB3uKjriCtvkNpmSqS3IBc7f4dVAK67UEt/atbHb9sBkiZ7u5XeTrFBYLlOuzBc3U3piD2b/svgSfgZPTolafSpRDPDWbyMHjdTMiNMTdj+/4CN0Rn1mCTrJMGxxxj/HijmUr5lKpItPs5PEoQwLtJPfuaTJcILzaeftxOBGqCxptt4C1C1jDpoi/BUZ0zZjOcx0XUiC7rrNsD2mTowz2lED35UkHkai3nXLdUrzeKbfXBosLeCCYXSH9CzIZ6t7DNbJoQwHAr3QLm5gnUq4RcyZKDTZmhXlXIOOSfGlAkD6bKK4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(38070700005)(2906002)(86362001)(66476007)(76116006)(64756008)(6916009)(66446008)(66556008)(66946007)(71200400001)(4326008)(122000001)(83380400001)(9686003)(6506007)(53546011)(26005)(107886003)(52536014)(8936002)(8676002)(33656002)(5660300002)(41300700001)(966005)(7696005)(55016003)(38100700002)(316002)(478600001)(54906003)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZs4PhgWmOY2KsrHvVD/472HBNzsloiFlkdUPoPLBhQzKWi1UnB+QfldcpDp?=
 =?us-ascii?Q?l7t1CxUaKfLfJDC45RaXcGAEyJJOUUolFvVI+vgd+A03tkvF4RT0hkqyujZi?=
 =?us-ascii?Q?RkLgTqawL0gTRy9iRl/dRqCuLMTsBmHB1Hpol2+vKAnrvqxDXon2Kvj1Uhxc?=
 =?us-ascii?Q?WJwiN6CKHhzCop2R4N5HHDdldGFkzJaV8y8tgeYlhLsQvosesdBcdsr/SgsK?=
 =?us-ascii?Q?JrtLtM80YpCPLYC/OEks72hfPAwhJvi1cUkXf+sMuNgS9gl07JHiycLB9C/y?=
 =?us-ascii?Q?Y+USWnEClkIuAhnAMi8/ir1zGPjIL7TguaF1IpULMUmawgfdYTe4oFTFiowq?=
 =?us-ascii?Q?HEzg1iR6BzP4AxZe5sYSwEMvUUuLKHv1vhnNX+WU1FhTq38T5LTzmrmdqJik?=
 =?us-ascii?Q?zZPdoc9mK8aYncKEj/PAau6ItaaPYRr+g9IdLt6/bIsuCEvGkMy00oBGk352?=
 =?us-ascii?Q?koTYCVIx2wIuQbO8axpK1wWhbroxqjRb3TzZ+CvxlSROq8TT3G/E1OPbBgho?=
 =?us-ascii?Q?Qu0QkrRRuv8x2OX3FUX4/Or9SY9WlOUR6KiDfDL4rQJg+prmTlRatP3FT3//?=
 =?us-ascii?Q?WHtlIRvBDWYuGIqsyw/5J5dxet7NlwoTjeHThr3yRxh+5JBa+rCwEQdoOq8p?=
 =?us-ascii?Q?RAW96+9+mzUv0uDKIOFdakT7GeIHf3K2AyHA2Brbug5Vbvu5MPh+PrcuXqcE?=
 =?us-ascii?Q?pHehsU+AVqFda42f7FcDrnD7U42b1ObHZO6mpL5WTs4hbAvnP73VBjTF3ioc?=
 =?us-ascii?Q?2VhT7v0DaeTtybCA/xbYWYoQJhyIMez+prx0c8FaOzDq1URxYfLvVaIIED/j?=
 =?us-ascii?Q?sacmND0VAWoZEJRhKI8XNnR2qmPBPNl2Ldo4vA1qV5NmNWUCBAR8XMj4R55y?=
 =?us-ascii?Q?01mwUIEnsiUoDrN3Mt8bs4gFoIAirbudjPKZw8RNJyWIJWXYcdkaqD68M3qr?=
 =?us-ascii?Q?Q3MER7rcO3qoUvLViZVD1DOfvhTiWYNqAElXDcRbWort88KJ4pYsbJx/2AZo?=
 =?us-ascii?Q?tZZnP3OYQFyDG7fEoh+cjLlTay0q+CZ6iA1y3XRVFqBLiRjl+a/AZd5m5ntH?=
 =?us-ascii?Q?zLO3mcXcODA+r7JznhZ3TAbqpKtUUm0TQabOBKYHngBzPUrL7MOTDcalnNZ5?=
 =?us-ascii?Q?Z0KCxs8k0Zxmy2S8w2iUcdfCA/ynMhoxaGMFA/AjqpHC+YvhuTZMmoAF/vG4?=
 =?us-ascii?Q?qS/mjVwe0dU/OVxP+jJjmQYBSbX35JSRn3G0/y0kWdbyDl/GB2rOZA55Oh96?=
 =?us-ascii?Q?eKXBICsYABeQNcokwDNjCmaW4MhdPW6EltbDXajS//Yb3l/iLIqoixle1qlK?=
 =?us-ascii?Q?rhO9Ghl4d/NJ17TM9YzAO3+kZ97GUJRqFbcueTiYEVwiK5mzuMnfACBo1ZLh?=
 =?us-ascii?Q?q58xoYW7X+Btfb7NUEYGsiD7IcDaDA6TGUUVw+wuhOtOFQZi4OsvYqgZEZgR?=
 =?us-ascii?Q?08hOuaqWZO3nc1UHJNU+5A6lYmL2AGdYWb4kGcSojjkR0+SMZ2psoYNqKVqV?=
 =?us-ascii?Q?iQkPdB/TtmJf5+WBZ3BZ0gDgN2JyUujTBxy5uWjIYxCjlYN46+jKGepnyCB0?=
 =?us-ascii?Q?1RLjlI/dM2ZpDWsm9IDypd4XKF79uJVa6rMRpVNQ/spox+monA2zXAU9SgBn?=
 =?us-ascii?Q?dg3nlqCeZ5EdcaYGKQe7Yc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57072c2b-0f76-47ed-bbbc-08db67ed906b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 06:57:03.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQuieTibQNCw4BDnZEyW4N1rKQcbsMv5lcb9yBRmaDcSxG+BGZ/QUolNcA0rjtKj7kOaluG1AC44w6lzPHsaf7fc5urcbIF8UMQa2+Ro0Mv8G92kIyBkyo7ix2JpPnuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kumaravel Thiagarajan - I21417
> Sent: Monday, May 29, 2023 3:17 PM
> To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Subject: RE: [PATCH] misc: microchip: pci1xxxx: Fix error handling in
> gp_aux_bus_probe()
>=20
> >
> > Smatch warns:
> >         drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73
> >         gp_aux_bus_probe() warn: missing unwind goto?
> >
> > Apart from above warning that smatch warns, we have other issues with
> > this function.
> >
> > 1. The call to auxiliary_device_add() needs a matching call to
> >    auxiliary_device_delete(). When memory allocation for
> >    "aux_bus->aux_device_wrapper[1]" fails we should also delete
> >    auxiliary device for "aux_device_wrapper[0]".
> > 2. In the error path when auxiliary_device_uninit() is called, it
> >    does trigger the release function --> gp_auxiliary_device_release(),
> >    this release function has the following:
> >
> >         ida_free(&gp_client_ida, aux_device_wrapper->aux_dev.id);
> >         kfree(aux_device_wrapper);
> >
> >    so few error paths have double frees. Eg: The goto label
> >    "err_aux_dev_add_0" first calls auxiliary_device_uninit() which also
> >    does an ida_free(), so when the control reaches "err_aux_dev_init_0"
> >    it will be a double free there.
> >
> > Re-write the error handling code. Clean up manually before the
> > auxiliary_device_init() calls succeed and use gotos to clean up after
> > they succeed. Also change the goto label names to follow freeing the
> > last thing to make it more readable.
> Thank You Harshit ! I reviewed your changes.
> But I need some time to apply the changes and test them.
> I will let you know as soon as we make progress.
> >
> > Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus
> > driver for the PIO function in the multi-function endpoint of pci1xxxx
> > device.")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > Only compile tested, from static analysis.

Jegadheesan,

Please apply and test this patch - https://lore.kernel.org/all/202305181633=
33.1355445-1-harshit.m.mogalapalli@oracle.com/
It would fix some bugs in the pci1xxxx'x auxiliary bus driver's error handl=
ing path in the probe function.

Thank You.

Regards,
Kumar



