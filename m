Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88C6BABA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjCOJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjCOJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:07:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3915222E2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678871234; x=1710407234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+64Pbwg+dueYKYKTjRv9DneOZXvE+3mxcrECkzO6zX4=;
  b=0gePOP2I3XZQ126aEItH23hlyYwY77xMK8hqchuDcA8m/RbNgppPRLKM
   Ih+kG64I1nm3Uo5jfsl9egohawY2dvSNqQa1uPQ68zh7Cb7oK7E5Dxcwd
   DBXxlP9Yxd0gqI6Ag5hEWPpWMeqnjA+gXeIT3P5XooT2v0lYXiRK2ffeP
   pYlChElQUWcztRmKMXx+rBGLk4xaZuzTieb1XbSJqqOQ1qQOGl/jxZwpa
   hAmi9t+D0WMLsXbFxBOhUYF099yOlVbUxBBf5Ni47vjk7qypPQHvQE/+V
   meKVV5srnV2B1qBi1yIWwcI1PhT3tL7foUFIGqq31Aorery13meznEHT0
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673938800"; 
   d="scan'208";a="216402397"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2023 02:07:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 02:07:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 02:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC7AALmhf0MKs9hw545U7TodN0rgE6WQpo+0lZ5UelQnBUaN4qlegyB0NNnyMicd2sPCFczKsLaLQUK6BamVrl/7JE1cQzl9rksrfo3iOcASDDmA+UllH/ki420gFwrjLmGgzv2T7oDMxjcZX49gn5PFaA0Crtwoa4jUKx3gHQ6TgguOe4Sp9d69a5RLETpnisolmDrUIQI/GaYQ+wK+fc1h1TzobeRc3MSk12wNjIQu+guc846tetC+lsnGXjTOIgx4mWtK7WD/GBX9l6LcklQCET5mkCdYJ5Sl8cKH4wDNUp81irfN7MydP2AZKoCYE/e0/kXNzOqRbklajtb+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o8D2ZfpkxMEeaEK5AB/1HjdWvGOrcG25HsbJVSAckQ=;
 b=BAbrUGbK/GZwDZRjtK3rNsyUNAOaD3Fl61+HsnBVgxjs07KVYFQ2nFXQfn7JgMO3OMnTAsWom4jDDrY0ecxg7d0W2vUpBiiKyDSbjKzlLwkxdXHDLd9oIDhtkHX15c1XACDAWenkEZuOSO5laLbn3/lW7ax4e7JR3tz2nx3EHG8xrrDu2e1xWRAcDUbg8hXLlC0vmoc/IW0mJxDqaKKuDWFMAlUXkq3Mf6B9vJBRkCSE4ByYFRzXR9zUvRnbqaqtq/eJ6FLXho1R8VbYltCplllsPKs/qcI7icFExc+Lp/G36A7Qf1Ndfd2TTw/dO5X2jwkwSao6gYNlP/olu4QtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o8D2ZfpkxMEeaEK5AB/1HjdWvGOrcG25HsbJVSAckQ=;
 b=bTivhHfBT1z1aH1eygFPM6TX6R2vr7VXAll2bGsEwjDmJfD+k+t+GRaqnC4ckmU1aRniY4jpZuMmt7vrcuy+H8ttfDmLEJ1j5r8rPcBFY40D1fRueTfadwjpjVaPbYPSkoEriuDo7CgLTJ5mXgq+qUFLkXoBG2wL9P2ft/ZAE+k=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:388::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 09:07:12 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::b9d7:a5b9:e603:53a6]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::b9d7:a5b9:e603:53a6%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 09:07:12 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: RE: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZTfJPZe6eTNovTEKQ1bRHyBB32q7yT44AgAZ9oqCAACVkgIABebMg
Date:   Wed, 15 Mar 2023 09:07:12 +0000
Message-ID: <DM4PR11MB6238653CE39A429E4B10B9C497BF9@DM4PR11MB6238.namprd11.prod.outlook.com>
References: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
 <ZAm7PDSIUN5HMxUu@kroah.com>
 <DM4PR11MB62385D0541F7AF8EC7E9F6CE97B99@DM4PR11MB6238.namprd11.prod.outlook.com>
 <ZA9Me2d9IsoYGifp@kroah.com>
In-Reply-To: <ZA9Me2d9IsoYGifp@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|DM4PR11MB5568:EE_
x-ms-office365-filtering-correlation-id: 1de035a9-fdfe-45c3-311e-08db2534aa0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2GyPV1bU9FbLi6vcTT7Fk7uREigM5mSti/zyCVpGp+TQPmplr3p5+V9batZ5TAej9Xecmt0BT2S716obpuD6kqErG5lMOMCFxDv3ui+VWvJaXMvkYpI3MmxBeAPlzm/98OMPMgPJE2fAQTtIDf5DG9YDDz6u4z67K4yJNfiqHPBwDXYL3ykejp8fHiZjRWRwglKr5NXH8i6/u+IWD245s/keng4WrvJ5C3cUg1VUNY8l93Ey8bWKYPPzkhnsbvI7OA14vHciSFILumKAGNTCRAVh6hF8E9HAtaErGIr+OYdxRyoAgwjo5+QqN0zxBJPPI4o32h1IgJmwfSG/bmLvjGZ+qNckVcFzpxSDGEfNunaz+uWQ3fLYkUneJY46lEdccp9rMyCnw1GQ/lBnMbFLzN1S3EECTwbK6z6+wAlHyNlLPKnbfCBMtNRmCeZ80Z+LqbCGIE8Rk1lkgfD95S1XDiUjl/KdT9ZuxoaHjT1+qoYcgt7d7AL0e3CAfZMb4Yhs/kOifSZ76PR64Z403ATpAcswCunBrk873xnCiccpyyDdy5N93kbUdN7guPfteu5aq05BRD9m05B+c1Dxu8OlxhbjDJVoO0F/TVOm1rbFsAWEKRoNKuC9UCnt/zdRpwGVV+msEMoVeR86GjZCRxgr015CQflRxRyWGe03aiK9SJHRsmR8Yj3xSZbHaFILjlY/yNEeBFvDHYnMyjAMmv32c4UzcJdDHoUifYqA+32RCFWZdS6h511nPVJ/GNqFGdZ0LZ8d+JtBp+Y81BsmJppMig9EV/5KBy+b7oXwQn8ERY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(8936002)(5660300002)(41300700001)(6916009)(4326008)(52536014)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(2906002)(53546011)(6506007)(9686003)(478600001)(83380400001)(186003)(107886003)(8676002)(71200400001)(26005)(7696005)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(54906003)(316002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1m1H45mszHRNuKmB9PP6qGRdRwc0rBwKJzyzAXRmUNaRLCIBC6xiXaWUBSX2?=
 =?us-ascii?Q?Dlqjhd3z4cL/6qRELqXRKn/67CK80RDNzNQNfoh0qwGur3ny6k7eWpHBGpZ9?=
 =?us-ascii?Q?31lVy5nzbeUxqQ7OJcDRIk/i5vHpY7V9M5PmvZ+aZcxRWRa+Ydq0esT0e5z8?=
 =?us-ascii?Q?GNy85BWcy0bbY4dcnKSnDPa/5MtzYasczx8sFReb+JDof8y2tB4NrUrbszrs?=
 =?us-ascii?Q?UZpm6IUKEBFHxrGZ0/TJEGP6F4WxLURq/iUj1DmORfDnn/vZc2WNO5oJQcuc?=
 =?us-ascii?Q?Ev3dvN5oetUhAooHQ7wutnXQf5CMadJ4DSZL+7ShPk+rC7rUtaf2jmbT453f?=
 =?us-ascii?Q?eBF/r/cH4nyMTLGuHPB5JSpElybJXoOcT3F2V+mvn9FtEnno32HdaisAp429?=
 =?us-ascii?Q?ITp7kv9gwjeN+NmRVm6MH7n1v0oGa8KaFVDOjcJW4CNmW1sr1ViML08V08Ma?=
 =?us-ascii?Q?dZIaG18IbYSV+sB6uebIP6ryKDUxw9qw9wN1+WxK87+yFbmDQYlNdAcjg5RF?=
 =?us-ascii?Q?e/fcaSL2BlIN2JhxvqBTztQbcFfuYwhZyc1jUFNqQoganvBg5UVGvZUTlrPu?=
 =?us-ascii?Q?Oz6dzfxYnMoe7mIdwdk2QV4vOmJgIk308cv2PVIA67JOszlxVhBJJjfWIhET?=
 =?us-ascii?Q?fNvY8ej0xo6L72/rDP78AGWBHRZkmxEo0oqxom8isksDiyaIAoZfYVrMSB+C?=
 =?us-ascii?Q?9UzTguyWoBkbR9mxDq5e3/LtYoyCFy4FbKbEd3nGQrCRcekS2S81/Lri22Hk?=
 =?us-ascii?Q?YM+NH3cs+Xz1WbYLAgbNo/SImqnU+OBNL90PWQU/Ps83S7/pYxOVA4THQ3Wl?=
 =?us-ascii?Q?k+fzRVRe8ccNPU+SSjTCgpF7mRc34AiEh5Wh0PXukhYLciaonw3odiIdrHsZ?=
 =?us-ascii?Q?G70KhGJzauHvbPEjdBJdiTl7js/Ag6kt7shVdSW2wT6vNU9UQU6PpwUDKjOH?=
 =?us-ascii?Q?r+eQD0xQKiZAxWzx9JNawYs1lcE8Uqma19GpK2dH4lvrp1gu5ANm4uyf0cTO?=
 =?us-ascii?Q?bOfIW1DqZ68m+6fsIdDPYbPHT454bo3Cqv/CcXpAG6r/Xh/YAbnuwbAtgHKV?=
 =?us-ascii?Q?3+TDEhd2rh0HUMXJ5p/Rr2ReK/wfFpAttLcYbPBudOEiO4hobOHxPQYm4yC7?=
 =?us-ascii?Q?3i5RTvsVxRUb2+lqdnMTlFMxkYeNW1AygoKv52/cTp03GfBTQfOYFdelDDC8?=
 =?us-ascii?Q?J6AA+zjYSpG2C4KNBP+hIfAw0VWII7LdBYAJQuGpQyCsuH3sSu4vo6YolJiw?=
 =?us-ascii?Q?pvkKO+qB9H2EA5ibPuasjb1c8SbkWIJv8neCV/q+ayVQd9rT/TY4ij2hURr+?=
 =?us-ascii?Q?13UbX6Gud2TAjKtbToDC6tvzkv2HIBjMmA/WSvfFLERJIxnmZrFU/gJmSl2k?=
 =?us-ascii?Q?/U80L72SMloNO/sBps3k8F3MWsQi1ucQfQ6qfCboKKufCdnz/ajxnVPWAJrP?=
 =?us-ascii?Q?Wt2AKyXmH4+s33Yu31FsIhyzMZ8lLPT3fqUdjJ/h5vlS/Sg3haSi3P2zK4l7?=
 =?us-ascii?Q?cHWjonAqonHAIIiwm8QtXqQvNxOdMB2aH1chlvIcFMIkR4WVwykZRYOVSe/6?=
 =?us-ascii?Q?GIw6FZSJ/oi2GHoLvmUxQBLYT9RFuGBx759lY6M1EDOyzH+3yIWdQVgGMVO8?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de035a9-fdfe-45c3-311e-08db2534aa0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 09:07:12.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdG68rp0nYnJJuopB6ieLk2zz4VatQZ5gWl7SQRIJR9djr/i2dj97hD6kArn/CePeeEg61LEgzH+NpJaJrN1Ahn1X3rHW1Vz5usGt9Xe2dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Monday, March 13, 2023 9:47 PM
To: VaibhaavRam TL - I69105 <VaibhaavRam.TL@microchip.com>
Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add OTP/E=
EPROM driver for the pci1xxxx switch


On Mon, Mar 13, 2023 at 04:01:15PM +0000, VaibhaavRam.TL@microchip.com wrot=
e:
> > > Again, default group will handle this automatically, you should=20
> > > never need to call a sysfs_*() call from a driver.  Otherwise somethi=
ng is usually very wrong.
> >
> > Are you recommending similar to this snippet?
> >
> > static struct bin_attribute *pci1xxxx_bin_attributes[] =3D {
> >       &pci1xxxx_otp_attr,
> >       &pci1xxxx_eeprom_attr
> >       NULL,
> > };
> >
> > static const struct attribute_group pci1xxxx_bin_attributes_group =3D {
> >       .bin_attrs =3D pci1xxxx_bin_attributes, }; ..
> > ..
> > auxiliary_device.device.attribute_group =3D=20
> > pci1xxxx_bin_attributes_group
>
> Yes.
>
> > This creates sysfs for both EEPROM and OTP at once and handles for its =
removal, right?
> > But, In this case, I have to check whether EEPROM is responsive and onl=
y then create sysfs for it.
> >
> > Can you please provide some guidance, on how to handle this situation w=
ithout using sysfs_*().
>
> Use the "is_visible" callback in your group to tell the driver core if th=
e specific attribute needs to be created or not.

I have added "is_bin_visible" callback and it is working fine. Sysfs for EE=
PROM and OTP is created inside drivers folder

But I have used attribute group inside device_driver under auxiliary_driver=
 structure.
as opposed to what I have mentioned previously because , struct device_driv=
er is exposed to me instead of struct device.
Since there can be only one instance of driver for multiple devices, I cann=
ot account for multiple instances of EEPROM/OTPs present in those devices.

Is it possible to use sysfs_create_group in this situation?

Thanks
Vaibhaav Ram
