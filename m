Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D216B7CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCMQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCMQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:01:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C5A76F5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678723286; x=1710259286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wcw+pvTJHsyAr62kibuSM7zv6wwOVgcUWXgB3ZehnXM=;
  b=T3PFEY7b/aF/HUJl6WzYWenwO9fImckwP5Um/Btai5PcAQl/wZvzUWOW
   GKRerHidwXg4BUWyKQ5U4iQuUrNyIUjqS36rbJTuRMYqAAJQclhN881cx
   jwlrIt2sDVgSEOpatQV2URklFdb9Gyl2gp+9twZolXFWHCp4I4zSzqKkT
   hkIIPN8Y8Vbd/Om0LLoVfcURqGXFjrn22loVBeEXkOd/CpiPsWcpbLq+l
   pQd/7uoEez6hdGpudhoqCkywCbziem1Fj/XnSk78VCU/Pt5W6ae0U3wqU
   4SsRAee1bwNUlLo9WWna6S9SxCr5w+1ox6jNmN8DcxFqCbE1CsIj2yqjN
   A==;
X-IronPort-AV: E=Sophos;i="5.98,257,1673938800"; 
   d="scan'208";a="204538751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Mar 2023 09:01:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:01:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 09:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V04UxKxmoCQhEtT5aTi3WKXLbPGf6jvPq4CHJG0pCKn40DUmJi0OrUXBa7c5MwSWF+Sf7zdQliFrdvb9DRwiQ3mTz2ZnzvsVvudzg/cbdUZ0pyD0cCFpIsa7SsrzTDctZGR9VnYPjf2R0GlFgXezkdlXPoskDTpyZMlMJNB3xuX/LNXX81SIIHG+sN1nLBUiYQy2Ck7IFsAXP36v+JRrGTWHDfd/+WJjJk7bai7scYUO4kDeT+DFESpU08SIZ7KZO+ymEGrC2o4l/QlaBA3h53/Z+WR2UcNXnXcNNtArJjL0WiYupKVLITzJdFMmBFKhxHp0MVjWMFITqBhrKINvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3y48Z/xUl/OeRXbgo0tEjbMFNAOw0KkORGTIgR5Kgs=;
 b=HmLavkFIQqH9ogQfs8nZwdNYHByYdp8d7bYO65WIjp6Y5d08BWI4pfsg4gNxev0leMbg/Qwff99sqO3JSgZSMDI1xZX4dzrBUVdyZ846Q3YnFEF9TkZ0IcZB+18/JU6A67lPi0qjCxvdfCLwNCxoLfS+ZHQFncRghp9C1Bj+kU6VgAGfrRKdpDEt55H+8CtUDKFjWZyTA2+iLBGqCvUh3GdKzbcbawYD5cLAzUIXIFaKwhbAyrGr9dwEYRMm0xVUUwRoEDV50z/UtJwLqG8F4vYDyMrJzXWJTs+cDHkd3bR1Ov0nQRR8n1KEtWCprGF5CRy7Q+YMarhahSlLw5m4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3y48Z/xUl/OeRXbgo0tEjbMFNAOw0KkORGTIgR5Kgs=;
 b=G4tr4jBN3P8BapunadZxUOvVUrxHTJ9q0tWAHHiCkyytppwq0KTdv8YwzNzjMpaYYSXiiYnwHSL4XEgxgMj1wWDPQJ84TZnzxW8X7Mwofd17c6ozrUp433cZzATWHx07kQI/eKNN9dtMdAZAmkQG11+AovaqM4foTDlmIzfmSbk=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Mon, 13 Mar 2023 16:01:15 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::b9d7:a5b9:e603:53a6]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::b9d7:a5b9:e603:53a6%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:01:15 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: RE: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZTfJPZe6eTNovTEKQ1bRHyBB32q7yT44AgAZ9oqA=
Date:   Mon, 13 Mar 2023 16:01:15 +0000
Message-ID: <DM4PR11MB62385D0541F7AF8EC7E9F6CE97B99@DM4PR11MB6238.namprd11.prod.outlook.com>
References: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
 <ZAm7PDSIUN5HMxUu@kroah.com>
In-Reply-To: <ZAm7PDSIUN5HMxUu@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|CO1PR11MB4771:EE_
x-ms-office365-filtering-correlation-id: 49936da1-e2a4-4833-faaf-08db23dc2ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7j/6kOHFlGI/kkdoVxAP5w+p75Ip05X5PBkjtqZ+AY2dchhFfUvXXjFzl1e0kRAhqRG+OYGQUQ58kRaMKAiUATqnf+fMI3R+0A2F6dObMgp7NaemQz5RUXiX/13MhJLCfmrqMflAl4oh4lH2xiEWN/YAA1Pk6YJuHd1pK0KrhLk0n3mC11DrVwndxgGOktjccmyslU02dRxhLkefvvbjFHvK9TjwiCW4yI7N3tZLK6TfiniYjSO+K900Yw/hkBkVDWV/axyMlXncf3PH/vkuXmtdEyujb14N8MA1sSnKTLvr8QbO8RBU2SXIGhMbc2mTkYJXKhL0ggP1q4AhEFyVDV5377qsyA0L7oqk2iPNcN+oP4gpI+pfFKgcjwiifH3qW0mraMo5ZSOzmHSHuv8yq5aNsRinHXeRavll7QGErkrg4kEpd7dApIrjJxPYmcfTkkxO2zmFiwqxNuYe6TP8Gny0bh9AfpzSRZzctWg8HOIzGMutjVr+r6gID/hTV1JDDyhwbiKX85E79REwA0C5BmxWVeYwby+yOINm1qDh336LegR4X1mBsBI2+dgJSIdbDlN4T3HHI70H3GbAtgRFD7Mx+5RCrSLO+i3xzGz/0+x696nQK4dZIOG3m9vKg+mF8Eql8lQKj2k7niRU/8BoMYaDxvecchle48dovebHdA7Y3OCWnM69bax2nneGv8Bkk+gyLr5kPHvBqPfcShKLHDJ9w1gC5YXidmALqh+uuUnLw3vxsJab1WKLxn6tN2cZJw5Q9Q/ZWLLEM4aF4r4rJnMgB0Pe1x4YgO1OSWcP9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(346002)(396003)(366004)(376002)(136003)(451199018)(186003)(9686003)(53546011)(6506007)(26005)(8936002)(83380400001)(52536014)(107886003)(38100700002)(38070700005)(5660300002)(66556008)(64756008)(55016003)(66476007)(33656002)(66446008)(4326008)(76116006)(2906002)(7696005)(71200400001)(8676002)(41300700001)(122000001)(316002)(478600001)(66946007)(54906003)(86362001)(6916009)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1yozrZhCNh5yhVTbyuXGDRPD2KlyForHOuPU2yiYstElta5P7urJAlDeW+FK?=
 =?us-ascii?Q?4tZLZ4Mc4PjTyZReh5eZeH+FypTBmVVOrqzTn4oYlS3Y9pWpgKOPR/KLdhLZ?=
 =?us-ascii?Q?Hm7aqydNz+kVHx8/b+2VdG1x9HQenJbbwlb4rIYWwL1RDRm5t0YvNj4WpisE?=
 =?us-ascii?Q?NJjNCk0gTnqAoAuV9XPTkZwfe/z2tqCPtDYjkNYM8jN+LzxCViZINIr6RxCK?=
 =?us-ascii?Q?2QWl3TZt44eZIDyrETIDQauNjAo7evaQZAhfauf+VIHGFwT8eDQCUxfH4TYb?=
 =?us-ascii?Q?2o7irMDFq4xkQNilTdgi5P/Zvb1q1V5D9FViQnUvQPF/pfPf6Oe+0oExjuPY?=
 =?us-ascii?Q?zYGoev5ZmhF2oKePXnZ8LQgZ6aStg4t9PeAd+bpBfGhIzQQjX6O4qBmKZVQs?=
 =?us-ascii?Q?k+KDmbeXJbWm9m+ZZbDsUPuDtIzqnBBWpOOw6JCw9XiJLhgpmJALAKaiQwHK?=
 =?us-ascii?Q?Aknkqp0D6THbePUQgJjs0xlgqTOYN3U/DR/mzDkamzPnYrOqlrP6GgTvx4LZ?=
 =?us-ascii?Q?oO0z78obE7A7wNs2mvrD9d0Z3C4tAsPIiVYnxyi2SNUS6o5sDe0veL2BmnGp?=
 =?us-ascii?Q?vN+Wd9/BOSoJe1vb4S/A4dA39JLoDofolDG32WFMeUySq2Lmm/co2n8c8Ulx?=
 =?us-ascii?Q?Q3/xgXhqm50UE+XCHUzodJ+gk23gvP/EufQz9Gw8hgN/KWVEyiOqfy6HC7Pu?=
 =?us-ascii?Q?VSJ5tts2o8b5WiB+tCUHEXCu+IJgNdP+yYIfjBxSeCz3Uww0rLzKzpAj6a3o?=
 =?us-ascii?Q?NlSJcwzZ1uTWNQDMkAqIJdz3+iY6RlOIulcZjf/WwN6rBPIDLYPEIycZ4sPq?=
 =?us-ascii?Q?JGLavYPs+25G1J12Qf6NwL5W1R/Z1uwAiwPZeUuxCIV3GZF+Vf+h5Z5cWHkc?=
 =?us-ascii?Q?2cxDn6CJnfnS+Yvvvw7HPkb8s1owb6hFe3X/DY89RsdFdkvR0+QxTig82LPX?=
 =?us-ascii?Q?9OOmRwiIxjk7MugjkL5PYsGfhjDToMeeP44KGvO99HWHJZ8CZohazu4ksuuL?=
 =?us-ascii?Q?K9gbs/4HWBAEwW+67DJloQG/MN3PrI2cyIGxpsByu3RSA2EFL3ynEO6FT2Do?=
 =?us-ascii?Q?gcZzizdonpOKQgST2j8vJN9/zP+MmFsXaE0W4dBhT6fsmql1g8WoxP5Hs4UV?=
 =?us-ascii?Q?I832LJ9eAPVbfb+CrLQYuz1TyTb5fJ+Q4cdsvig72XVGpMq/7iEDlm13WQF0?=
 =?us-ascii?Q?7OfBkkyb7svp6zpEnS2ASdLnpUNNU6DQQDibDJ+8ya6zB1sx8YQPbEIFxYPI?=
 =?us-ascii?Q?bdqIYY8k2T+ABsPuj62asqqL5irmJooYNyAB0NVR/SBmt4HUX53ACukba/Vx?=
 =?us-ascii?Q?NXQvFgHdlcqtHAZ7t+XS1NGNZYc1AtUOE+OqolLnXKVvOi/x2Er4ZRM15vy4?=
 =?us-ascii?Q?g98soa6c7Nf8IQfXPIvHnNORYZlh3/e0G/wYQhufVji4YWSdz6djLCpWvxYb?=
 =?us-ascii?Q?Sgy+HohFaKMShEYp+aRZUs/gl8rFXfvYp36/ETeqXBAYhLk1IjvVy9vndtSp?=
 =?us-ascii?Q?C4xez3mWMv/JzoepA+R1GbYI0GgQ6eoZ+flu/AP5jR9Lhm8vQL1tmSM8/AM4?=
 =?us-ascii?Q?+FlWfMmhpU99ddw2a3AhPnOneI2uKvtrV5RIYoa9quV2y8HO0N2Xy7qVpgRK?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49936da1-e2a4-4833-faaf-08db23dc2ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 16:01:15.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94FnX1PPb3PqqPzmSHqOij05FjGZvXL6ii9WQC0AEMb18UfFq03V1zDYKE8HVK+2Noq9Bz4Y47N95i7mlSCk6gL4qxor1TlXB5bagLz4JtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
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
> Sent: Thursday, March 9, 2023 4:26 PM
> To: VaibhaavRam TL - I69105 <VaibhaavRam.TL@microchip.com>
> Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add=20
> OTP/EEPROM driver for the pci1xxxx switch
>=20
> On Fri, Mar 03, 2023 at 10:34:26PM +0530, Vaibhaav Ram T.L wrote:
> > +#define MMAP_EEPROM_OFFSET(x)                (EEPROM_REG_ADDR_BASE
> + x)
> > +#define MMAP_CFG_OFFSET(x)           (CONFIG_REG_ADDR_BASE + x)
> > +#define MMAP_OTP_OFFSET(x)              (OTP_REG_ADDR_BASE + x)
>=20
> No tabs?

Ok, I will correct this in next version of patch

>=20
> > +static int set_sys_lock(struct pci1xxxx_otp_eeprom_device *priv) {
> > +     void __iomem *sys_lock =3D priv->reg_base +
> > +                              MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
>=20
> Why not do the dev_err() call here instead of having to do it=20
> everywhere you call it and check for an error?

Ok.=20

>=20
> Also, why tell userspace about this, what can they do about it?
>=20

I will remove the debug print.

>=20
> > +static void get_pointers_from_kobj(struct kobject *kobj, struct=20
> > +device
> **p_dev,
> > +                                struct pci1xxxx_otp_eeprom_device **p_=
priv,
> > +                                void __iomem **p_rb) {
> > +     *p_dev =3D container_of(kobj, struct device, kobj);
> > +     *p_priv =3D dev_get_drvdata(*p_dev);
> > +     *p_rb =3D (*p_priv)->reg_base;
>=20
> Ick, no, sorry, just open-code this whenever you need it, as sometimes=20
> you do not need all of these, right?
>

This snippets of code is repeated multiple times. So I made into a function=
.
I am using all the arguments further in the functions.
Do you suggest modifying this?

> Also, any need to verify that p_priv is not NULL?  Can that happen=20
> when the device is removed and the file is still open?

Ok, I will include a condition to check that

> > +             if (ret < 0 || (!ret && (regval &
> EEPROM_CMD_EPC_TIMEOUT_BIT)))
> > +                     return -EBUSY;
>=20
> Shouldn't you return a short read if you do not read the full amount?
> That tells userspace they need to resubmit the rest, otherwise they=20
> have no idea how many bytes were successfully read.
>

Ok.
=20
>=20
> > +     ret =3D release_sys_lock(priv);
> > +     if (ret)
> > +             dev_err(dev, "SYS_LOCK_NOT_RELEASED\n");
>=20
> No error return value?
>=20

Ok, I will correct this in next version of patch

> > +             if (ret < 0 || (!ret && (regval &
> EEPROM_CMD_EPC_TIMEOUT_BIT)))
> > +                     return -EBUSY;
>=20
> Same as above, return a short write, otherwise userspace can never=20
> recover properly.
>=20

Ok.

> > +static const struct bin_attribute pci1xxxx_otp_attr =3D {
> > +     .attr =3D {
> > +             .name =3D OTP_NAME,
> > +             .mode =3D 0777,
> > +     },
> > +     .size =3D OTP_SIZE_BYTES,
> > +     .read =3D pci1xxxx_otp_read,
> > +     .write =3D pci1xxxx_otp_write,
>=20
> You have new sysfs binary attributes, where are they documented?
>=20

Ok, I will document in Documentation/ABI

>=20
> > +     ret =3D sysfs_create_bin_file(&aux_dev->dev.kobj,
> > + &pci1xxxx_otp_attr);
>=20
> You just raced with userspace and lost.  Please never do that, use a=20
> default group instead.
>=20
> AND you totally ignored the return value here, that's obviously wrong.

Return value is handled after next few lines. My bad, the two statements sh=
ould have been kept closer.

>=20
> > +
> > +     /* Set OTP_PWR_DN to 0 to make OTP Operational */
> > +     data =3D readl(priv->reg_base +
> MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> > +     writel(data & ~OTP_PWR_DN_BIT,
> > +            priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> > +     if (ret) {
> > +             writel(OTP_PWR_DN_BIT,
> > +                    priv->reg_base +
> MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> > +             return dev_err_probe(&aux_dev->dev, ret,
> > +                                  "sysfs_create_bin_file otp failed\n"=
);
> > +     }
> > +
> > +     if (is_eeprom_responsive(priv)) {
> > +             ret =3D sysfs_create_bin_file(&aux_dev->dev.kobj,
> > +                                         &pci1xxxx_eeprom_attr);
>=20
> Again, default group will handle this automatically, you should never=20
> need to call a sysfs_*() call from a driver.  Otherwise something is usua=
lly very wrong.

Are you recommending similar to this snippet?

static struct bin_attribute *pci1xxxx_bin_attributes[] =3D {
	&pci1xxxx_otp_attr,
	&pci1xxxx_eeprom_attr
	NULL,
};

static const struct attribute_group pci1xxxx_bin_attributes_group =3D {
	.bin_attrs =3D pci1xxxx_bin_attributes,
};
..
..
auxiliary_device.device.attribute_group =3D pci1xxxx_bin_attributes_group

This creates sysfs for both EEPROM and OTP at once and handles for its remo=
val, right?
But, In this case, I have to check whether EEPROM is responsive and only th=
en create sysfs for it.

Can you please provide some guidance, on how to handle this situation witho=
ut using sysfs_*().

Thanks,
Vaibhaav Ram
