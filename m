Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CE697957
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjBOJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjBOJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:56:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94356BB9C;
        Wed, 15 Feb 2023 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676455011; x=1707991011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8Rib+EYs3Z1sg+hMMamhwwXtsJFejFCZ9KRwW1tBq0=;
  b=v4+Rf/UbsJ4V0zt3UtDUGaghLa+3/keSaBZUvj9RK9eAJ68JUTphXjxs
   RREAbJSta+ad7S7/qw0WukDWTUun/dURlV453lXBTNbZCjQ0X4MXKzKnT
   gHo7VPvM8rAXe4PAFHfHc+V6GxgWQCq23dEKAFTvf8bJev1qmCY8AcEnZ
   MBSVPyeWT/8Sq0x1XCKwhKDkaAZy3J6MUFqwMruGiSm4CVGF+vpfecfzS
   Z0rE5xVa6t+JdT0IxmH3OI4O3c9idi99Ipo8ySnFj/iKxf3Vt6RbCSn3Y
   bspeK3fL0QTbEouNiq92czTCb5zzJkz2Dfa4+A3pCDlvztF9/OV1lYLR0
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669100400"; 
   d="scan'208";a="212093202"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2023 02:56:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 02:56:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 02:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctuCniFoYrGAtVirSJdn7zHFxIG64xMQIVWHBkXtvTY4I472FQyPppd8yQbQRBu6QMcWzHSERgDyFCz2A/XsQa048hL75I2apsWRqVwsDWHjJQ+R68B29MpsYTslv6uI3sqS+rXo0od0DdOMNoWeP/YNqQkGkfLjI/l9j6UYmtaIFKXOUOaHGr99q0/YZkJEa74QobYVC4r6K3PuW/YTFGG8IB20gcc55H/UVugCa4QjzvCUsW/3qSiLF6wZq4wVrcZCsHmsfXN1cJ2S5Fcb0YaM1+NxkfK8dt5W1rP/KefX76hWn6sshzKpF8kZBsIbK9DNPmYGyOJWfdC5Qk2TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8Rib+EYs3Z1sg+hMMamhwwXtsJFejFCZ9KRwW1tBq0=;
 b=dtRGO1jiOzQJwIEd37ViiR/mH3OgOPtkkLG4u+ejWtvE2JtLkNV0CJn1zxWnR0t8qe9iYFqSDSwE+016C40jbcS/q3n6ZdUsUmvZnZsHEB7KzIzEugeb2JaAYdgYHdrW5nOl4ZHp7++70bTAlybhCRgKwS+PkUGvEhjhwJDLLqv3YVrBSKPhQocxX+X6dKRtbFaU/E7EwMk+9Qkc8xuTuXTF+ri6wg3YC4+yHsg1FZZD/s9HE+5XckBbjCElL7s2+yIbwWRarQYPY6JOrLSnAASUWQsGY4h14y8sbkiTr7ThsIc63u1/u2Pp08zUCES3yIVmIoXcR3Px7IQjngoKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Rib+EYs3Z1sg+hMMamhwwXtsJFejFCZ9KRwW1tBq0=;
 b=H7hFEzPhOs2jJMM5kOnGvmwQd6UV2/6xeVYxcLCkA5FTRCvrEPMo/DIIraHRTLiIrw5DJ89B+wJb4980OWHRYimvyc/DMRLijbKQOlpThNvc1dZq7mX82r05fpGL8r5QiNFNg4ZvTQ8micTNG0TN3CkPHj+Z44+0yDdvTnRK9wo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 09:56:46 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 09:56:46 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <michael@walle.cc>
CC:     <Tharunkumar.Pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaCAAEoeAIAACswAgAAHKBCAAAiScA==
Date:   Wed, 15 Feb 2023 09:56:46 +0000
Message-ID: <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH7PR11MB7497:EE_
x-ms-office365-filtering-correlation-id: a1d818db-028f-4601-1504-08db0f3af31b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIQZk6LY08VzKh/kvW72zbamc93zzaSu1pBDbTj2ppTLHuXZOGJE7SSi1Sn9VQKSH4i/UvhVhxC2M4M8nfE0xAriSTrVuOIkzFb8dHLFTX0a2IbckdMq4qorxW1fzZPYj5uv3hllYFYeM6iRpLbZIi78NsQa/aLJ/bZ6nBbCW8AubqM0yQYy0AZwaqG/VyJpNC9bYxlUGwl+aPLXYbBhMdNxBRzENN31I0BlPJbRqA+d4Z3p6eBvyfZMcn7SkR6N2/ldYT5vDXSrCXnwlmlSf3Je+O4IwHpYogjzW68Xy/T+jeYURoW5NEpfrZ9rnFtEJkhfYoj/ArJ9X6qhSlTBDQ6+x4oNTcZAl7iulBz0alYQu61ZGb+OsWij/eAQS03XvDF9Oksh6SSZjMuFv4hmkRSlbtl1dPXsKkHgQf3dyPq4jBnMrqcE0enUmRn6Ncuz94MesjbPKO8vcRVMfyww6KWRsBAGqodOQDKW/zJVuTN3bXBHBbIHbQrhM0FfOmQg0/rnsVcU97QTIXq9wgsVfoX0Vf6XJMNJnNcBkg2aJyM+mc6YK06kJ+6xtZwjxcmSCluIn/NHyW62E7acdT4XDxIBFtPF9Xo7gcekcreGYwEJi4YRMoXmLg9A0Jwgl270gz5c1qlXtmfJx5xYNr7hvlDYIj/U+EmJYPYcp3G1kWkchJVIvxwnYgvpfXYDIgMfS0tQv5TD+avmSdB4pqsmLzmF8S35ApmcG27Yt4zgEKsup8aaCRul3qshY1bu8zU8T5mDTMdv6l4yNMtNEZpEkDCgLA7rZCY1/sYwinbKNKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(2940100002)(2906002)(33656002)(86362001)(122000001)(76116006)(41300700001)(52536014)(5660300002)(38100700002)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(478600001)(7696005)(110136005)(83380400001)(54906003)(4326008)(38070700005)(8936002)(9686003)(6506007)(55016003)(53546011)(186003)(26005)(316002)(71200400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LtHoQdwE07XsA9bsEmfL3MWgZp4V14vQ15+Pl+S7kLkJ8YRVbab0wa+j9E5e?=
 =?us-ascii?Q?5TpuFDyi6+/ttCfAQeb96QTFS3E0S1IGLqDLYFJlpDw+5xyXwEEoNz8/K01q?=
 =?us-ascii?Q?IlIcTP28x9GgbG7DjFBcuBZEnDWB8q4NgNNxBmXAQ8VveGxjkxjn3pqYY7vN?=
 =?us-ascii?Q?agavBvgfyQxfuSNwkB3xUhTACOnFaieDHacqkXCUI2uCTqGncNO23w4cbX3w?=
 =?us-ascii?Q?zw/32/a2EnTUZdFWtQ6VIwG5iOezDIlZt5Z3O2sFVXBH4HTyKDcsNO8PQNwf?=
 =?us-ascii?Q?eBf2isOAbSCdegaSmTDmBSgbmb7rVnxeKqifa9DpeevefQMe7LZ538EYY0KX?=
 =?us-ascii?Q?vIkqjSzne5/yWY6JpnTdR+vqXQDjxXr7gObd66ybGtmsx7bINmm8/eKGvWUq?=
 =?us-ascii?Q?y+q3/U3RoegT4Sx9efjBue12zLwk9YlCsF0vJJ0vOnGmqO++CPkC9hn6JCSx?=
 =?us-ascii?Q?JU4imk2dUpanvhvcmyWOJ10WEAPwkWWV64zqpBwQoVLJZoLdIgZbuGKIGy0p?=
 =?us-ascii?Q?AM+5xxWfjDttVvW0ONQgEF7s9cowhG+VgxtbFYzBbRlILCElPeCrRwHzItsB?=
 =?us-ascii?Q?DUjPiJZOq9iIh51bc9iNv/ieAAIFkoOj5mjpWSM1BWCFtp3zv3tayWgUXfcM?=
 =?us-ascii?Q?4FkzBJOtJwSp2bwZVSs+YExVZnVWCfm9LgTbl8dliI6roHMTtUgtcvFurKXO?=
 =?us-ascii?Q?NAC2NY8dc+nj9rRkL8wQiqoxSF5r2aD3BnlmmYhTMWeIsmBJQOOj9T4QeoLU?=
 =?us-ascii?Q?nkc3Z2ee5jB33mV8x1WBgAFeikI/ae1+eBWGeybntHu8dCCxKMI3fV8JCmTB?=
 =?us-ascii?Q?QsPM2SJb/BCZVVWNeVHVU6b7w7K6edq5B11Xyb3R9EukGWLE7eF1Zk8E/pqq?=
 =?us-ascii?Q?TnadTY9r9YadlGfilO4eAIi2WjMKEM95rPQxr+7g2oVR92uG25d94ncvlXjF?=
 =?us-ascii?Q?nLRt6yLJ1+bOb5fEO+IWE2PnlI56mrlzYxQBmrgD1uZXltovPe1HgL+fH6zj?=
 =?us-ascii?Q?wZk3IgWwFWhaPcsK6EiIUVqSBfSSqISxPEYAzrEq4TD+uP1sl161Xddy5Qhv?=
 =?us-ascii?Q?yNkeVhqUhtf895QGSDiu4WOK9lkKAcva6d9vR1Dk1hCnURE7NMGwQv+YBodY?=
 =?us-ascii?Q?3y6em6fnfXbGD6k9st4sIi6Il6myVfOJx3WFCUJJ6qpwkLSU9egybNk8swrJ?=
 =?us-ascii?Q?9E5qPoSt4dhxweXJZdwKhuj053VqR1uqLmZUW9DDIGSc92xnzVouoXdz5Rlu?=
 =?us-ascii?Q?nqxf6qXp0RfXIY6EdfB6LgNzuwUuLgdUpiDvwuldp94so/KWNcbkx/zKsLtv?=
 =?us-ascii?Q?sn/tT3Y/a7v71ADDwf5hi1tjX7dZCo/oWywe6BwKdJOuuWoxaEYlMPgdZBGm?=
 =?us-ascii?Q?GF4i820ZWhWcBXqaJHvNnQkSvW61CzrSxen9fsadd2gB1c2HrZ7sOjNnfkc6?=
 =?us-ascii?Q?cOPIDPbWoyPKn5GmXOMoik7/0vTgr7eNV8Ik+lCFNR219FOEZOL6JkZ3kuni?=
 =?us-ascii?Q?U1TCnQDlUSQ4JGnGxi1MVq1WL9rZI5MiKcoBFach+St5vBNwk3gpz3vgQ5IH?=
 =?us-ascii?Q?ga4I8nIbqOttCj1ibz4oZBjj/xMQNr+Jx6ot1yUP0Y5Q1O70/Jo5vyzSgwhd?=
 =?us-ascii?Q?3SngTtTJO1npXSj8ptkxbNA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d818db-028f-4601-1504-08db0f3af31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 09:56:46.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XCP8Pa/O0mLa9hGJSRxPJXw0CCRUCqIKwBEy1BlcX9R8y3Fgyg7BMkXmUAI9Qkpcf1dNwGuVvNvGaWr4OZt/xGa5Ja98Qc4A43dDhTujmDjWvvIukad/kPOB06D+Qdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> Sent: Wednesday, February 15, 2023 3:18 PM
> To: Greg KH <gregkh@linuxfoundation.org>; Michael Walle=20
> <michael@walle.cc>
> Cc: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>; UNGLinuxDriver=20
> <UNGLinuxDriver@microchip.com>; arnd@arndb.de; linux-=20
> gpio@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> srinivas.kandagatla@linaro.org
> Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add=20
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> >
> > On Wed, Feb 15, 2023 at 09:20:10AM +0100, Michael Walle wrote:
> > > Hi,
> > >
> > > > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for=20
> > > > > > consumer, industrial, and automotive applications. This=20
> > > > > > switch integrates OTP and EEPROM to enable customization of=20
> > > > > > the part in the field. This patch provides the OTP/EEPROM=20
> > > > > > driver to support the
> > same.
> > > > >
> > > > > Why isn't this driver using the nvmem subsystem which is=20
> > > > > usually used for OTP and EEPROM?
> > > > Michael, these OTP and EEPROM memories do not have any fixed=20
> > > > location registers which store values (Eg. mac address, config=20
> > > > parameters, etc) at fixed offsets.
> > > > It stores a bunch of records, each of which has some data to be=20
> > > > written into the device's hardware registers at different locations=
.
> > > > These records are directly consumed by the hardware and=20
> > > > interpreted without the involvement of the software.
> > > > Therefore, we don't require any OTP / EEPROM register map to be=20
> > > > input to the OS / driver through device tree or board files.
> > > > I only had to enumerate two separate block devices using the=20
> > > > driver so that the config binary files can be overlayed using=20
> > > > the dd command.
> > > > Since this is not fitting like a conventional nvme device, I=20
> > > > didn't choose the nvme subsystem.
> > > > Please let me know your thoughts / comments if any.
> > >
> > > So this is only for provisioning. i.e. during manufacturing a=20
> > > board which uses this PCI bridge? There are no kernel users, nor=20
> > > is there a common interface towards user-space. But just some=20
> > > block device (why not a char device?) exposed to userspace. I=20
> > > presume there is a companion userspace application for it? Why do=20
> > > you take the extra step and have a (random) kernel interface, you=20
> > > could also just access the PCI device directly from userspace=20
> > > within your companion application, e.g. through libpci.
> >
> > Yeah, why not just use userspace, I missed that, thanks!
> Greg & Michael, I do not want to expose the entire or even partial set=20
> of device registers to the user space access directly for safety reasons.
> I think hardware registers shall be accessible only through safe and=20
> robust kernel mode components and that the user space shall only be=20
> able to access the device through the kernel mode services.
> I want the user to use the hardware only in those ways designated by=20
> the driver.
> We were using the "busybox devmem" to access the hardware registers=20
> directly and to program the EEPROM / OTP.
> But we understood that it cannot be an end user solution in all cases=20
> and based on some of the operating environments, there can be some=20
> restrictions in opening the direct hardware access to the user space.
> Please let me know your thoughts / comments if any.

I missed one more important point. This driver is targeted not just for the=
 manufacturing environment.
we want to be able to update the OTP / EEPROM when the device is in the fie=
ld also.

Thank You.

Regards,
Kumar
