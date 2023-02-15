Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB622697949
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjBOJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjBOJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:48:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343B21A3D;
        Wed, 15 Feb 2023 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676454496; x=1707990496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ah7kga9tMpmKSWfmwG2m4mkYUHWOoRKWNNkHL8UktwE=;
  b=rx0OYGh8X5EZFrhjexz0KX9pvxqrw3CSq2tC5z8HpL+BnCdnyiV5nUwu
   2lvHJ+97CysXbDEFar7wUDdrL/FlGspsgZ3ZSyVcsAnf1LYQwbrzDrPTx
   7bfFmmaUz2RLZXWoTxmFsWwd9hQrM4mI30mrvSFfSh+VMyL68EC2TZ/1B
   xUoFauXT4IGQsxjPa+z4VBTxe2RWdAhDo+GBZmtS5mRw7PjOMlx/2UYgv
   5ki2WN+sZPIa7qPcy+LGuKS+bxtm0n3CIFTQVwMlHZHdy/q1CCQqIOAd8
   EhdCSc7uGcIockB/TQj+Aq6pAIPLHo/J5rd7mrMffCtS+hF7BTkfkbjC7
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669100400"; 
   d="scan'208";a="200772216"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2023 02:48:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 02:48:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 15 Feb 2023 02:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mScKInJ6gq4941OpVkRTFCCo/l6n1SLxJ9iCVxvebzLMBcVsrFIyy1mGFHccfczi2PrOYzXXh/+NAJufpCKu4OIGpd2I+QVygrPP5PvUqifqU/Ddkkz5GySmGo82psqSk0BjKPMPfBhlL2ZjC0d8vu1u/y/6td0PAyLoQKS2lZ6fpypSPTBz3q2/NPlCdpYoZhfGXrqMttOfjkbrVpgu3wNdkEpK18oMfvBIDdYZC7VURb2e/S9aoRzOVBSNFqUocuMjM265r61/rJKWrV9+Q/V3NtQjAdILmjhuvWzvQO99FsQcRJEWxu5mAl1p7VWVCQw32zJiCkxYMg5+kbXc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah7kga9tMpmKSWfmwG2m4mkYUHWOoRKWNNkHL8UktwE=;
 b=oQZXm999duzAcjLov5+Y8De24XbiMO1eS8j0n3GGQClavFSbrNopYeKdlemFny/jcxdwUck69cu92UWXWdepMzZrtOfqVmn/1pvf9g2/pXM8sYPcv+2N+2S6v3mowFLG7JHM/E5SAvWhE81JvSeMg67pLuzrQ94hvtHxxQqC2hmAlMZY6YcMmcjry0e+Z2zuSx02bm8Fo7IwE33LZmcSDJLb+eqHQhJPAhkLxEeO8IFE0Cu9KS2DrdbPn4zNhfrFPkzXCkIJDLIkehN5KrGDrLL36rVDY1RVsmrZXfJj1EJwLadBcSgoy4TlZkIal3ryqxDfgT8LvEokyItP0LrPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah7kga9tMpmKSWfmwG2m4mkYUHWOoRKWNNkHL8UktwE=;
 b=bSlb+5OVA73Vm2GujNSydopKTujpe6XZFTs5Ze1O//+m+x/fGDmO2N0qQrSZJFtxBjzT+0uDT6OyugK9IsuZBBQNIgFCXnDUiRK8tjhty+pL4HJo1lda/FsSy/o7Ye9B4ehQO0JIxNQ5uVLgMj8/UhbWDB3mIcU3+XaKyLqmH6s=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 09:48:12 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 09:48:12 +0000
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
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaCAAEoeAIAACswAgAAHKBA=
Date:   Wed, 15 Feb 2023 09:48:12 +0000
Message-ID: <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
In-Reply-To: <Y+yeyNCA48IbKOKC@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH7PR11MB7497:EE_
x-ms-office365-filtering-correlation-id: 2dc54145-9152-4bc5-5ed4-08db0f39c0c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: do3YHs1TP7COOQ77LpjD9p7yhbHpnAwJlUpFTwTG+5cpvVVlS3YhabyipC5BdmGHqSLgj2peqHWR/+r7gn+8JPfLNpcOgr5GAEN1jzuaM7COQ2mrQOr+DMOjRFaJoGdPhIN9y0mweP6AjBJu0j+VqcWSDi/8Kj19fREGw7nH9RldLSWsfbvxTvcEBcksLHbmizaOM2Oq1c72JsCULXdUC3MfGl93EqpfVMhJQdDldPrlmolOZalXt2JqALAMICH7MoWkEKw5om0RO19YHa4YdFg/rgjZGjmhCkn205ajfOMlALy84Paem3z9UYn1SOyD6xdHCsuSvIO7XjfIIuNlqIHhPlJF5nzsKs5uKF01/bwMlT80ChXT8NvZ3sC2y0vj9lK/tuWCh45lW/bZdYbpw8xgQXryYZTo0n1ZlFFXFY76K+Zslmo9h5jgOQntmS6BH+qztik97U+wfWbnTwgqJcEoTca4pDqNzjv/oCEIbYcgSz3AYSUGt7BZ4C2VXXVGE3OTYvB6zLOFHkqQed3bElKa9iN0vD9oGYm3djXmJZ/qurBI1oPE0aHF2W6oYMm0y+PvuTPpffDKNsyMmQaIpjURTIfelK24AP40YiLzrf379jsSapgTz7/l1t98h3tQO7TJ9FoDbmxH1UXl0z/4+FIboV7qGCd+ftwsAZtIjqq7WwZZglc+MJlz3UwPIyPNbhs4GjAEQrHISGAIGyUCkf40JVFnz0mXbd8RuOdeRXXoVqKsnAhFCsXgooag1Lnwp4ZZ29NKdkwUf/0DDXhm2VetGA/WFKkvWWTfrM7WAvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(2906002)(33656002)(86362001)(122000001)(76116006)(41300700001)(52536014)(5660300002)(38100700002)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(478600001)(7696005)(110136005)(83380400001)(54906003)(4326008)(38070700005)(8936002)(9686003)(6506007)(55016003)(53546011)(186003)(26005)(316002)(71200400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1idWJnl85zOSahWaudNIrN1wtMcXnuY3s7ixQSxIsUh9P4IJT0eovgRVAERr?=
 =?us-ascii?Q?wtPOICkFCEewWa1DQdbMnm5PSu6ZeGcZ8CjDE+1SkXTmm0Hd5tbEp03k5/xE?=
 =?us-ascii?Q?3sUj3q/6yT5lZfvTl27XyyL/ac+ruwJKY6nSFbsxiuAQGHrX2wZ6lHQg7Qr2?=
 =?us-ascii?Q?3Z1pia4t235F/H6XgIfhEFdu0qcKFadANa02KkNNCV+MZK+tu54qDHpItWKs?=
 =?us-ascii?Q?/X+k9cgiOy5j32Dnq+hpaUvhdeNqv4cgzP5LX6JnbKn0SQnolYVjjzECtyJS?=
 =?us-ascii?Q?NTc5Wh7Gk82iDQMSVOf+/nH0YFMRj6gnHb8HU9ywCtBc/dGWvT1ZyFuXqSWY?=
 =?us-ascii?Q?CPA7nNiTCC5i1C8H05LcvYA7abpKZbMVQHLNjurV4mHhgjLIXDoWX0Y6lj6l?=
 =?us-ascii?Q?cJUZEsxIx9aF8mkCVvtfaVY3KK/PnyQgGpKRTKQWpYNDFoiR5iy9C4NzEFhS?=
 =?us-ascii?Q?boVdBKg1KHMdc/OMnKJ9ew1HSl5I3rDLJo3e3sqzelf9fG/OUxZK8g9c+rQg?=
 =?us-ascii?Q?B+oFp84fwawaRt4SElQzqygiXBQ11CMSNMva8mmA60IxEkTo01y0jAQQT/5k?=
 =?us-ascii?Q?DfE5Hqs34BBRaaluHQ/3XVPp4veH5/Jzzmgh3Q2noNalgSEK+HMSqFN5QIZ+?=
 =?us-ascii?Q?IH4YfSB5cjsHQxHTLMSXjwc74g18kwhC1Bsu7TNSTFLMwxkLmHYPRFuavDXZ?=
 =?us-ascii?Q?Z4qOkD5caMzulwoeDQYblIqeHbNnKV0FRfIcBqH/f/Mp9Wmnzr9u4/JweMUe?=
 =?us-ascii?Q?kitDEqjvtNpP4HGic0ZaoRIqp7LDnWAXTReruNmemFrRLLr7nJl7SZebs77Z?=
 =?us-ascii?Q?atLOMeR6F37RbS7DGFGQZR2PMxS7AOwhfL3Gm+h6K7YcyI93e7l7MIDnT7bm?=
 =?us-ascii?Q?EDbTKJ6gpXuYPqa7V1OAnwtO9lTeSti/JUL59rbkPwQUkJzU2mFZaLBPViFr?=
 =?us-ascii?Q?LvlIR4hVaCgztNyimX6Qw9H3G2zxA3eHWvjouSV26Rny0otYlvmc2BzcwntY?=
 =?us-ascii?Q?RvP5L2iX6dVKRS6/rqlLhWuQT+9lF/xnNxLE27Win4RauyhOc+niDTLTaVCP?=
 =?us-ascii?Q?lQa3VdslFyaIQMoue/eY1uJ+2qktm3Tboqmw6R5bCTUg8XWfaO8wkPim8a5F?=
 =?us-ascii?Q?gRgF21XslbfrkZCP+KSJfIRXnPPm04ZX+ycIzSAVajbgs0hCLZm6dPwSKP4h?=
 =?us-ascii?Q?QJvm9G+KqdLrB3Z9SILiApVJHUY/Qt9c7AXiTZgK4D6HAWhBbS/0aFjWUuwp?=
 =?us-ascii?Q?vtJDxe85+z9dWtozPRtECRwJWbs1dXE78IXr1PBoqugDF71JRo0rXMKc+Fd0?=
 =?us-ascii?Q?PwXGPsYsDRj3Z/Bvp7Mqdkl2mx/XfetJetqtxKCaiMviaU+B3gobUbgB6up8?=
 =?us-ascii?Q?Hoyzotorb848G68/iSWhx1eAUZOWVlnng9Mia5Ia+yrXLYgLWU1siNkwWcwp?=
 =?us-ascii?Q?FpkLEe7s358CrOBhBVJOR006u72TQ2PnHQaUNjujiYQow5x9eovVSkU3Qnps?=
 =?us-ascii?Q?wyeELMAnKlTd3sqAr0+ezLs/UlVts95qtJBirxTZ+mHcgKHbAv/RUle6+5bV?=
 =?us-ascii?Q?mGpSY548+yAKKYCy/6IbicBS1nEEf19MpsJtEMGjtcdtw4h64l6fALDxqnRs?=
 =?us-ascii?Q?WxPX3gOS0SQULJtpQKl2FFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc54145-9152-4bc5-5ed4-08db0f39c0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 09:48:12.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faK4C+vk/Wok2duq/pjDZxJZ21o89xDEIfiQbc2INDuvC72WXCHTOARJ09PnI2vttdAWgrAIgaP64M8gvu/LCC1+xXACHLor7FNapY2vS7A7zamSWJC/SLjlyE6MUBm8
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

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, February 15, 2023 2:29 PM
> To: Michael Walle <michael@walle.cc>
> Cc: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Tharunkumar Pasumarthi -
> I67821 <Tharunkumar.Pasumarthi@microchip.com>; UNGLinuxDriver=20
> <UNGLinuxDriver@microchip.com>; arnd@arndb.de; linux-=20
> gpio@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> srinivas.kandagatla@linaro.org
> Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add=20
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know=20
> the content is safe
>=20
> On Wed, Feb 15, 2023 at 09:20:10AM +0100, Michael Walle wrote:
> > Hi,
> >
> > > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for=20
> > > > > consumer, industrial, and automotive applications. This switch=20
> > > > > integrates OTP and EEPROM to enable customization of the part=20
> > > > > in the field. This patch provides the OTP/EEPROM driver to=20
> > > > > support the
> same.
> > > >
> > > > Why isn't this driver using the nvmem subsystem which is usually=20
> > > > used for OTP and EEPROM?
> > > Michael, these OTP and EEPROM memories do not have any fixed=20
> > > location registers which store values (Eg. mac address, config=20
> > > parameters, etc) at fixed offsets.
> > > It stores a bunch of records, each of which has some data to be=20
> > > written into the device's hardware registers at different locations.
> > > These records are directly consumed by the hardware and=20
> > > interpreted without the involvement of the software.
> > > Therefore, we don't require any OTP / EEPROM register map to be=20
> > > input to the OS / driver through device tree or board files.
> > > I only had to enumerate two separate block devices using the=20
> > > driver so that the config binary files can be overlayed using the=20
> > > dd command.
> > > Since this is not fitting like a conventional nvme device, I=20
> > > didn't choose the nvme subsystem.
> > > Please let me know your thoughts / comments if any.
> >
> > So this is only for provisioning. i.e. during manufacturing a board=20
> > which uses this PCI bridge? There are no kernel users, nor is there=20
> > a common interface towards user-space. But just some block device=20
> > (why not a char device?) exposed to userspace. I presume there is a=20
> > companion userspace application for it? Why do you take the extra=20
> > step and have a (random) kernel interface, you could also just=20
> > access the PCI device directly from userspace within your companion=20
> > application, e.g. through libpci.
>=20
> Yeah, why not just use userspace, I missed that, thanks!
Greg & Michael, I do not want to expose the entire or even partial set of d=
evice
registers to the user space access directly for safety reasons.
I think hardware registers shall be accessible only through safe and robust=
 kernel
mode components and that the user space shall only be able to access the de=
vice
through the kernel mode services.
I want the user to use the hardware only in those ways designated by the dr=
iver.
We were using the "busybox devmem" to access the hardware registers directl=
y and to program the EEPROM / OTP.
But we understood that it cannot be an end user solution in all cases and b=
ased on some of the operating
environments, there can be some restrictions in opening the direct hardware=
 access to the user space.
Please let me know your thoughts / comments if any.

Thank You.

Regards,
Kumar

