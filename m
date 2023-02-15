Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BFB697575
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBOEhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOEha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:37:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AA1F5FB;
        Tue, 14 Feb 2023 20:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676435846; x=1707971846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/l6BjCBPG52XOgrG48eb4JuLkQiOvlbmd20iRMdOFUo=;
  b=Lg8Xx1VwnpFD1xEsdW8XQDvi3HcyHbYVzYbOaKZ+qFfBIeqdUO5XzIHJ
   NDum3sBCRy9sg0excRSuKrnspifnxWuOVfUTDVLrl7t2GBzmzX+EMZfAR
   ebl3+fv0UNN4O5it7UavwK9+EGvukQWYuFkduVQTUAdJeIJ1t8WlIG+un
   ay77qcX64ImDaN22Tply0biDTnhw0vGA+jnTTpz7apHn6WP37LVaugPL/
   D26VHNLJcQ+o2F5Qz73I+53m3wAl35c8DQrAgcP6tFQ60p2k2bIQJHlo5
   aUJn7m0EB4rFAE657ygW6shrhfpxRhYBL5hl/ru9Cy7OESOZ/b9s8ieRe
   A==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669100400"; 
   d="scan'208";a="200597712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 21:37:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 21:37:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 21:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3UWqLB6dpz3EhAogjII/58K+E1oQIMaunJii6tW2B6ElMaFFNJltj3TlYOhWSuR7PPuwF8YSs+CTbswjcIF+VfIlqLt6m7kOB1VxZpDpp3qZddgZu/+SOt5k7cyu+ML/lt+QO0Deul3hRe1lFxbMOS6Wa6juTKXLz0RIPCqWKAsSK+/eewDcITdknDfudSPGqsdbogiWy6uHwjtexfD2tAGNnEKEMy4tUlsSKugp31CrKg1KyP7ymtdtwi5SqBkav8ZVL5BuvcnIb4jAmlTehS3Lmg6RFq8AOs1eb4D1a1quiwRf4YblLOjHwzPtBUQ1xIGg2JnsF8cfd7CwBP6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l6BjCBPG52XOgrG48eb4JuLkQiOvlbmd20iRMdOFUo=;
 b=A+8hlCuKU+bbUJuHjY6vr4xKh7UP/hhXKs25LnBGN4rl3iPC90dfD3F4E7R4A3Z8BWWTLy9yV/6IB8IMN68cRJ7mKGzsZfYDYogEsyMZ6aO+E+Nkl7Je1Y0nsYOsoxdbTMcNiZKvSVM+8zpu3A1rHPgO9mUDKETrGErpPsG40A/Qd5WCzxr21vxl3C5JUbw/FjMOyROCsS4C9Ugx9k8N2JctS6bh2d4QBsxlSPQRfwAW1Ttc/5+i/iIBFjI3TCaKY1OTWlL099Db6ZtHAMpZeG3hYT25sWyjwYhNY+9n2MVEEv6GxV7+SJ8CudrR+5WI7Qz/xZk6kHu5vcIyR769eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l6BjCBPG52XOgrG48eb4JuLkQiOvlbmd20iRMdOFUo=;
 b=fTagU7Un7JR6Ij3MQQLs2NETUXVGjWis2ph964vtTIUgZOe7HeWxKAAjK0lFAjfQfk11mDwSc5tfBycSf9xDGMx4DK7/hy2IFmgW4YGtQN5Z5Cpord9+3mukUSgbSUUTmD1oZ+nrMMTGOtLTjy73lWYOV6uut6EvirW6+FAOIpo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 04:37:22 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 04:37:21 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <michael@walle.cc>, <Tharunkumar.Pasumarthi@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaA=
Date:   Wed, 15 Feb 2023 04:37:21 +0000
Message-ID: <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
In-Reply-To: <20230214082804.2761756-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|SA1PR11MB6783:EE_
x-ms-office365-filtering-correlation-id: 6512be58-97cb-412c-9c9d-08db0f0e5415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBJiMBcbAcdM69B8zd4r5xNO0aYvjcvnLGPpvFDIA/q5599GTsiTG0LSX8efvdtXfRzSB6Zl10Y22jPTkRIJDAFnN3rtuKRZHYaTJzQchmzc2jk0SQGeKOhIk4W75K+P3kNagW3hWljPjvot5JRmimGPxkTuiVFKB4JjJUkApysO0QpiXhK+q0B2nBYh2aG9UZ8nBixZCkt5wwXFnh1XNJ8cJJJQAAuCkXcGSO8QJbSYYxzJ5RDxTjcXFpKjrOfO0ATfdgV5hwMhAX7CvGbnRfyDI6qHCi+QB0nTEDhG5tPftNN+ocQj72L7jlyVzg7+JPLtva1N/YS/Eiiox9JFHaPZqruU4UOUXvmZ82KgqCPN5AlZHl/ukF9W2d/08euQHJlN/7KM70pFnvkT8ZR0HW67nIDhzQ8QnirSL8oyN9RfG+qw7EzYUOK1m1r9v5052SfKI1I+Ku1kAi+gVk5bUwi1jdaVq8F/O7vmsYbN/8opE46Clc1C8MPkQ7Ecna78YtkwivArb3Z9F0Akj82zwzNEidTT21NVOXTAuFj3Cpz7Hc7Vem9EdE+OPAUhIVBFEm+jMk9I1SzUV3tZ5yGTIRkEQ6XzpymBMzzzqoBMn6n0uy2tYsZlbz5hn/hh2a5hfUmAKwexxYXwQfEVGZ0G5+mvaHDJazoWfbr/48Vc2hG3QDoDjtFdAVLvMZGUiVBX0lbO0Nlk7nMBaDyfyWX+X2XQriVO1x80US7NOGuomNzK6FIUy8W5DaYxGJh8P/0SZriAJLMhXtY1e/7KkjM8i0URToZ/LNZ5oZAeQ3CSrcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199018)(122000001)(38100700002)(8936002)(52536014)(5660300002)(33656002)(478600001)(41300700001)(9686003)(2906002)(55016003)(6506007)(38070700005)(26005)(186003)(53546011)(4326008)(66556008)(316002)(86362001)(64756008)(66946007)(66446008)(76116006)(83380400001)(71200400001)(7696005)(66476007)(8676002)(6636002)(110136005)(54906003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DTb6ZAjOx46b0tAqxZJubvrF7knMM/KfwWwAZL3LNnw5lWd05zWwqw3PvSwJ?=
 =?us-ascii?Q?NaIAsYReXVGqSigMkE11HTYU9hLG4HjbArdIf2SZ4R93EVk/4aNVsKgSTOMj?=
 =?us-ascii?Q?1Ulez5lul/xSnX3dsAcQSR/bnZSPZgTEQPUIZ5h8Xta665KzEcBWlnExJnRc?=
 =?us-ascii?Q?GcHPem4a2eWhw0CPHDgGEdqK9JdxEhItLjybjC+OVDYYWaO1Z5u04SUk0fn4?=
 =?us-ascii?Q?WckHaF1FxCL1BtQ6nNaiROflDBa7oSdiUd10QMbDVZurRZ+dRhwiRyb/CXHR?=
 =?us-ascii?Q?TNm9oywXyp0H9+dgl+r2kFbW+FE2lvrKYjHaEag7wRRtscLV618cqV+eTWD3?=
 =?us-ascii?Q?eKpP+7kpi47sJt+QqlUDk4XpfjlcwxFyvtLicz0mcYHAyiKRpO768TzFL8FL?=
 =?us-ascii?Q?P/EVWy59n8MWw1bO7rqD1Vo5JGS0OcI5sUvwj66FiDg/pCRPgWrzjuzql221?=
 =?us-ascii?Q?+YmQfSHtbFRqXQRzit04l96m3rHJzZngW9bAeCQKu7j3SkxdXiogj8Q8UvYv?=
 =?us-ascii?Q?lzpC92glFFfUc4Su7lh+AevHtNjygZ1F4Mz2JOIGmOlDzVSn5VlQEK19A1IU?=
 =?us-ascii?Q?C321mSoGHhKr/jKCM0yxSH1Ef9jRu4ofL4vhwyNwQS8cZ7sotBafJlasibMz?=
 =?us-ascii?Q?F2NE/eFs4sIX96fl9XWwZWLxfQ3sTAN2q3J+j0iQdyi+80gsXEnVVb5Kqv/3?=
 =?us-ascii?Q?vNu/miHzSJHrzn3Xa6bqS0N+ysvIqDJFd9MnHC8/kEY1BqR/4fClHeG90eMc?=
 =?us-ascii?Q?8RuHWEd+dh0gqRgQ/+vw0gCVk9SyQDg5FqObmgqud/x6gkPqFHDGosDIziCB?=
 =?us-ascii?Q?elbdxJ77LhXk4GFKXXhC553t6y3oirNiHicoPdxp4TPwK8xuHFNQp/FM9Tb2?=
 =?us-ascii?Q?o2cgW28Krd2Yph4dhUGqrAh22G3vtKUk391il5GAhR/YK1UiST0BTLBSOvgm?=
 =?us-ascii?Q?xMQv6Q6UG5W/tGiJfG4wgNS7O3hQRsC/eKMkssCyMWWtAIZc30IHYM3akXnO?=
 =?us-ascii?Q?m3yq7HumsCpv/tKHX50Em4BgO95cVk0dSVhOogUyHrpXLTgcoKZMdn4q/Kxu?=
 =?us-ascii?Q?TWez3clue139CBPtb2eTYOcfR+taWFawzL9mYUYmqabBEkAeCGWfOuqC8TsO?=
 =?us-ascii?Q?R643KoDHzsHz5jTX8y8kwPAolvUH8zWTNlaIN6yCJZLKMei/QCeolpnQWXdp?=
 =?us-ascii?Q?964sj0kedxgg0NZhvuHoBuOWjwYQTm/f3IBfaWSh7v4aLR4wFUKs2NJ7QehR?=
 =?us-ascii?Q?j6v0OeyA6+SVk6cms1eg+5bbtyShxCz9NDRByVxUJ5VB4qYeAWhsYrCJ5z9u?=
 =?us-ascii?Q?yp0ZNecEgG/broctMiqkRh+wp0uTfOdzxtf0s4nPLAvUoqZpRqqwH9veYNHy?=
 =?us-ascii?Q?Rx18HSztGqlnPiCNxgBq556gpeBydsdmeMT8M0qOOmFFRbCCC2YwP7EXLsJT?=
 =?us-ascii?Q?10pg4HuC9BzM56mKraqAgK2xS7eVe+VA6dF3kS0AdSPd1Zm3yZftDlUy6do7?=
 =?us-ascii?Q?wgEgvwbOX6BzpkRh1xoDK/cUt0Tnx3twLkSC+StjgQglKqE6yGrkDI2UybcX?=
 =?us-ascii?Q?IzGm7qOCXCFyMDIPymeeRtBFYMF3Ya5E6EPb6gmv0lCCXaSZGHFbDHyHFmS/?=
 =?us-ascii?Q?Tj0hXxWislIN10ZhwrFFDq4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512be58-97cb-412c-9c9d-08db0f0e5415
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 04:37:21.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTscNX9PkvN357dQ1YTyccZgLVRFHYv5nraqM3Ehw5ULmWx2NojYvOOYF6YKVjMna+r2sSZ6AOQgw25a+HQiACAPiZQ7/JIQTVOFZ4H7s2WVOhK26QStynOCVydacgBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, February 14, 2023 1:58 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> > industrial, and automotive applications. This switch integrates OTP
> > and EEPROM to enable customization of the part in the field. This
> > patch provides the OTP/EEPROM driver to support the same.
>=20
> Why isn't this driver using the nvmem subsystem which is usually used for
> OTP and EEPROM?
Michael, these OTP and EEPROM memories do not have any fixed location regis=
ters which
store values (Eg. mac address, config parameters, etc) at fixed offsets.
It stores a bunch of records, each of which has some data to be written int=
o the device's
hardware registers at different locations. These records are directly consu=
med by the hardware
and interpreted without the involvement of the software.
Therefore, we don't require any OTP / EEPROM register map to be input to th=
e OS / driver through
device tree or board files.
I only had to enumerate two separate block devices using the driver so that=
 the config binary files can be=20
overlayed using the dd command.
Since this is not fitting like a conventional nvme device, I didn't choose =
the nvme subsystem.
Please let me know your thoughts / comments if any.

Thank You.

Regards,
Kumar
