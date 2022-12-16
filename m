Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31A464E89F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLPJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:30:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFBF167F5;
        Fri, 16 Dec 2022 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671183049; x=1702719049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMK4Fyw7sBei8npoYEDZdSsbTluCmo2Sj3FHJCw1DiY=;
  b=uThJkOExSejrPJpoIA1ykRXa1auL/cKMwv7wQLU/A1IrP0frDzydxssU
   XFyP8U3F4vgdWwb2f1hiNW727Cnv+/62dpnb66gnQ/wLhcGNWTgsSm8rg
   FPkIbCNIEv7EpjYq/cbcgWLIOqfNvxfyGSe+96Hh7ILYeQpnIhpWYkrU1
   Fic7hlNkGs8mz2VlmBKOnFWOgFsiRcS90llMUrki3mfarjG0mSkb3T86z
   FWu4mzF+xlKBd3dhxaIh0JJYRh904dxcXlhCHuPUU/M5eX2wGk3xTrKab
   OddgKFKt2s4VSYC4HSD0GANeGLDkoW+6Kxetfic92Qpp3HMmeKMX74B8r
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="193326897"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 02:30:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 02:30:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 16 Dec 2022 02:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMYlHhegwNioxd+/8BA08P61Cfl5gvfe7FCd1mpGt1HiHeGQXwpohrzrUl+6APC0nct0FG7jmlHZQ3XZY8QYoHHX8BHi/IOj9/e41+hUvXEqWTiS4SgmADol0haLt1/TFF9Q9PnsGRgRmcBjckRSbik7W5mJ1+83ihuB3+j4bHF9xLsupCect1Wz9KtdN+fcioD1QqEa1YBX5SUe08iv2NBIp4OYJO9G9kPoU1KC5Ptk9aB9pYsTLifYzcWZawuJ2FdzfXiwrRi0elFzncDfpKnyfgzT530HUjxhirz+r3Iisbh8aaqYbUrDy7JpDret6v47dB0KS6XL6ySTFEE7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+Pf4gXV9XYVop/aErTZEIKRArFwWKHRm+u1qMnpmzU=;
 b=jsBIJCkVxswbUl0sOjiI6BbXRBhCrcMjclbPdQabJyFeyTfroPii7sHvE7MycAru90r6MuF2cVp1b0HcXzG0UwOXnBJ3i45UymmBiR5FM3yKeWwOP+D67TJ2JsAM5uGtIU1Lw5D9ctcQ04HJKjzQuRvyzwdAGLj+ky3ubtGH7uEikI2fdw3GiR0BkCUqNWlm9CulHg/HqJd3N3yX6kUwY1fLS+xahkUE4bBc9R9GhqLq5xpUg1b1eIm/9ZC3IGvapnsjbpAnhgtk+mgn/r6qJ/WoAg+Xp2Als0L40hn5POFiTDem5N5RBJlLTl3GBudzqb0pmP6jFfjxqzooz+1/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+Pf4gXV9XYVop/aErTZEIKRArFwWKHRm+u1qMnpmzU=;
 b=eGvwvf8zXOR/NNu2osrTKJQWAx8v910/Y7JikM86UOZrMJbccLxvV/7t27qyZqZ4hnaNjLA7eYXchR9pxMowjMcuHMlMgFoRxTBeXhQsR8ibAp513uLmA2OBXt3jL3qfO/WmANEuZl6dCm4/BC3AHwIO57WrR/zgyYS4RdM2X98=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by BL1PR11MB5542.namprd11.prod.outlook.com (2603:10b6:208:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 09:30:43 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 09:30:42 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZEKWxJyYrAeLM7kuV3hibr7zg+q5vN+wAgADGUpCAADCNgIAAEWGg
Date:   Fri, 16 Dec 2022 09:30:42 +0000
Message-ID: <PH7PR11MB5958956CB3DFD8E9B4A122379BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
 <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
In-Reply-To: <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|BL1PR11MB5542:EE_
x-ms-office365-filtering-correlation-id: e89e2a68-cc81-4395-a5b8-08dadf4833f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etU8/J8sKODN1JrEsztMecKeIWiUOOfH1wR+nYT22Tl9CWPi+gYzy+MegF9XwXiKfk8WP72NWECbpGP8LBM5HzNAsASAEv1T0u9Q1XVEYKkHvWwnRqekkcp2sBioqf0tcOoF7j3ezUvc/Ra1m77ficCWJGOLVWzmYEmanLzjMW8j02WQgvIJEkLMZabbj4Cajz9GBtu1MqVLbZuwY/pwk2FPRFpr0/T62SeqBeAvo/IgKCwFxMfq7ceEzBb6c2YrHta8S8KtntSLueB7rGarc8uW6v588k4MHs6JXRBVH9VT5ULS5/77gcTQFUnFqweivHbFd1V/XhSYHw7Im7GM30EDuBL74idb64TRLeCz6y0b4E0hW0tmfAMhDQDpjVeki7h+wzDU7qw3bZn4sm6T5gXfQb9kr9zvNwP4g2dfK/AxkLL82TkgmhXBEPYigWhiVZW3rzMCM9P3b5lyE1y6+NgLRPLwKmw4jK+sWMeRR1DMmpENnIdTyBugJ+OHYk9y5JGVClB35eAKwbwPQBXfuy09NnJC5hqP0bzkSnnQh4+kk/Xl+f5LpXTSVzOSz1sQG5m//BPjU/UfTDPFKoenSr7ow/wTtFM5EJvDOk55UBU9y8uyyRiixq72jrWJEGy0BASK22zANDNwWOQZG5mv1VY9AnGkCnssJWUk43AhF8RSY7oSfaSKDpkJvDn6pxSo8ZvOvbg/HguNdSornS4vgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(478600001)(71200400001)(186003)(26005)(53546011)(9686003)(107886003)(7696005)(6506007)(38070700005)(86362001)(122000001)(38100700002)(55016003)(76116006)(66946007)(4326008)(8936002)(64756008)(66446008)(66476007)(8676002)(66556008)(41300700001)(5660300002)(52536014)(316002)(6916009)(54906003)(2906002)(7416002)(66899015)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EI46fkD0tK1ASz0VbBQf0AwQbmIgiuEUez7u2hTQ3h0Kp+ehNgC2jdgWfpbv?=
 =?us-ascii?Q?3yGEBSacjlMquNYBLqxQp0OTGBFtyk3ZCOXGdpm/yiLPBu5/gi8XaI+1bwev?=
 =?us-ascii?Q?EHt4p5ZvID+yTs7DLK3I5uvpRoADTv0HFrGil6Ktb6gDn0AQxpuXQyvYXQN0?=
 =?us-ascii?Q?SE0c405qVFlSFOgEcJfcyk3ORC1O7/5bpUiK+7hXbqviZ5mtBlr8bBahjQXa?=
 =?us-ascii?Q?BGI5I1AXKPNLLB147OZkHf4tDaZU6ERwkmWlVPjdXvhitvn295ewCzfVVT58?=
 =?us-ascii?Q?kuQDiw99jrtpiPAKaQrRrgqA0xbvb4lr+5ReOnlEDAuGtCf+RnP7OhdE6S2t?=
 =?us-ascii?Q?GeuPEb9CJpTqubLJ691du5LE3M5kcwQhA4Y59H0eRLQ/MxY5068cqgTV+qNu?=
 =?us-ascii?Q?EgH/YRtqarE7QP9qFCaLyojZQSmE0q+TDlmj1hCO/ULupYSgGoqXoiQmnvgU?=
 =?us-ascii?Q?VU201XqOXW3+omBhiQV4yz3CpY5FJkRLPu5LTup/mBJmb3YUqR/hoYpvfrnf?=
 =?us-ascii?Q?wlyFrPtWU92ft4MjlxgxOjMvb/FBfqJlVAyDi0PCgNGxG6EKJCupzbhh271i?=
 =?us-ascii?Q?SBwydv88Cs+hySvlcu5vji3coNSs9KZ6PI76PRwN4sBIBl0mNxTlWxjPxtFP?=
 =?us-ascii?Q?kNEQgdyHU7pYwufyCfqZaXS/TqCMomhGk/9tfk2zE4TKvu5F1Ygc26WRzpLN?=
 =?us-ascii?Q?itYUYOYOpHvyJ78jZen3/YZDJwilP9SHX6TXKPb5oXWmLcRpwB+haiBdmdvF?=
 =?us-ascii?Q?SIU3DYMh/KBlGpyl2is/r687Od9J59N4TnsipyjYg5n0SnoX2MBlHFysFKs4?=
 =?us-ascii?Q?qxZEvryARuDUz4fLjyej/KU+qKw4ZMn1ytokWY7EPTIoREtsXBz9a+GoHj9o?=
 =?us-ascii?Q?gGUoFPhW5YbdvtGevVpCd5kmTVka+VCAd1iG4XFcXCVoDDz2GD/8ZidEiyGS?=
 =?us-ascii?Q?+fElneMFDW9mvnJhF9YH3WnLTIwO8p8wAT2w5m0hkURwYajOu1DKr9aBNZgg?=
 =?us-ascii?Q?Xmip2OMdDoangVaH1uyqsBmETjECsQ8dNpQO6rqoNRVIjhRNmarycfO+UV0A?=
 =?us-ascii?Q?NpdFNb7sC7UL9PfhoxJz70Titps/CdJ26UeackEtnES01eedIDeA0rVwAP0h?=
 =?us-ascii?Q?waKvCAzHfs7KhNmR+/V+UYQpMCeZWt8bPrA4za0PH3BtMOHSajEgeR/59+/3?=
 =?us-ascii?Q?bbqE0OsQo7WAPE0r3EpiCdkfT8zAqe/xXj7jrhXVHlKJVFJ8Zu4Q3cRU4wjM?=
 =?us-ascii?Q?OzUhZYJQxl1Jiog9GOLfuaFdwBJk8HYOFS8sAj6m4MIryCE4l4RT56AANfDn?=
 =?us-ascii?Q?Kik981WyfnFX2T+sMaQHq4kJGSG1ZbgVbPjV5l5qRZ8Vlhg09ixIZKyOV47o?=
 =?us-ascii?Q?Uz8c/icxPIgffETbGOBK6NTPvk8gibxuMEGGg9gxyucjxSgelqf20V9r+ZHY?=
 =?us-ascii?Q?IluGCxDbxmAMSQ/fK4SzD1P10iXhOZRauRLKkIgljFMIkohGfLKfJRyZdV71?=
 =?us-ascii?Q?nCqI/OzTTGKN0ADi9OvJJGnla+ML17RXDDL1kLvY7SayuTL8F6j+PV1bRQMa?=
 =?us-ascii?Q?y4R0KZrKX7knJl5VUeqUmg5nHiLqHrgHph9aX9Va+U/lAWN46jm4qepsTUPG?=
 =?us-ascii?Q?8RSxRRnFo/AvNeNqHABzB/A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89e2a68-cc81-4395-a5b8-08dadf4833f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 09:30:42.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmawf8ycRdaBehKiYtpnF9H/eQVIQP3HgsEQkZgXp8eYPB4HsdcORUgLWF4oxMOH+v0MulPUpOnU6SDAAxlMrGdOtFVzypitMUxyXT+ANAvwTXheIrfLKkb7qhRjmDd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5542
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
> Sent: Friday, December 16, 2022 1:56 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support
>=20
> > > > +             pci_iounmap(pdev, priv->membase);
> > >
> > > Here is inconsistency on how you interpret pci_*() calls when
> > > pcim_enable_device() has been used. I.e. for IRQ you don't
> > > deallocate resources explicitly (yes, it's done automatically
> > > anyway), but you explicitly call pci_iounmap(). Choose a single appro=
ach
> for all of them.
> >
> > AFAIK call to pci_iounmap cannot be avoided since pci_ioremap_bar is no=
t
> 'managed' API.
> > You suggest calling pci_free_irq_vectors (even though it is not mandato=
ry)?
>=20
> Why is it not mandatory?

Hi Andy,

Following is the reason why I felt calling pci_free_irq_vectors is not mand=
atory.
Correct me if my understanding is wrong.

Following is the Callback Sequence (from 6.1 kernel) that gets executed upo=
n calling pci_alloc_irq_vectors:
pci_alloc_irq_vectors =3D>
 pci_alloc_irq_vectors_affinity =3D>
__pci_enable_msi_range =3D>
 pci_setup_msi_context =3D>
 pcim_setup_msi_release =3D>

devm_add_action(&dev->dev, pcim_msi_release, dev);

Inside pcim_msi_release: (called since pcim_enable_device is used)
pci_free_irq_vectors(dev);

From this sequence, it seemed like, kernel takes care of freeing irq and ca=
lling pci_free_irq_vectors is not required.=20

Thanks,
Tharun Kumar P=20

