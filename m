Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070FC671E04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjARNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjARNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:35:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6359549;
        Wed, 18 Jan 2023 05:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnBKneuxj8HCpu65RGSq/vfrm9xezonKUAGf6hy1/m8nzFgMdEhLaMxWNNDYeYsfWxKb5n72ZenAeuO/LsSoIlycrKt4S1dm4VkVhfKKcp803DvJw3k/agJyFCKT1xza2qr1pcyNxTGvmyvb9L7zFmVtDAJMu4jTPO800EtR6evXgb4ApT9DcrqEozq0CxOmgfpcNkbOPxH7r1eWX0m20tryEONYoKHJUMjwtWeYhKJQ9QiYHQ33IhxWgQp5mLGbUBlCFyv9nEH2wsKNwClr8xrC3yiTQQ+ebwmd5Lni2Lz0EC4zQ2riyPhne6P1MSg5vgfAusmK6t7sMZO8XKnk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzxk5FqP28j1XEJkxwNwgkECo197bNV9d+FtVepEiUY=;
 b=OSPW8wc7r0P8Oew2Npmz8Cl0nhhAl6RTgQZsxTXzctgnB5j9wfStgZvD1iiKlMz4bqKTiP5SdekWzC7ccFM19EAd+0qg5stGpqfjR/2dp0ahjnieUEU7S59XVAUUK18i5kaIlaXSlDKMPXM/9EztbhfCYGzXN31g+rqTiIOe6VAk5vAVo5FS5To2h1Y/cZ06Its7IxF+1dW81rVM8v/Y+74Ab/ovb0HSCN+K3x/JHTSHKrtJHUEuHF9hGsGuzJZCwA35cKswuAbub5LY3ISXOt3FHGYkf5XRd2MrGFaPzRMxgzTNvQpR2Qnil3f8017w+oEaQmi5rhVw8nt6w/qC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzxk5FqP28j1XEJkxwNwgkECo197bNV9d+FtVepEiUY=;
 b=iJ0CPHUPgZNu1WfaYKZ4pYpCg6rQd65M2xpTnkRlkXKqy8CMb+hFwu6OoTBeR21K6oGyYVWto08Q6gZeMpLuW+/qxJrl9vQRRN5ZMBcgF4taOuBtEUC6InEBtpVI5AeA9ptSWYDaAb4ixJGUPyZfQjXyj7msTCHb9G9PzstUAg4=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 13:03:01 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 13:03:01 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 07/19] bus/cdx: add device attributes
Thread-Topic: [PATCH 07/19] bus/cdx: add device attributes
Thread-Index: AQHZKnmeb/f5vw/DuUy//UpATu+MA66ipt0AgAEMcEA=
Date:   Wed, 18 Jan 2023 13:03:00 +0000
Message-ID: <DM6PR12MB30827B678C2D89FC68ABE84DE8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-8-nipun.gupta@amd.com> <Y8atGJV6yY4mXD+W@kroah.com>
In-Reply-To: <Y8atGJV6yY4mXD+W@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T13:02:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3bb5db04-68ed-4f5a-814b-dd1a83127577;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|DM6PR12MB4235:EE_
x-ms-office365-filtering-correlation-id: c9be4ecd-5a4c-4af0-9d96-08daf9545412
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCrj9V7X5h+gHdyRDSUtoxH/DB4ogKgfQwYu1w8H3SYQGkLMOOWEjLVajz5vUHQm3GQjFo9mjYqVxQnjWI6Zsc2/Vzmz5oVyv9N0qhQGTrR1T79aRApPKZGSbE2tRjkrEORpBx7NywAOsFNrgsQIVRaOIZ4EedVM/uqqph3s7NfAPhM68Sz2ZARsqk0Gj2gjiWveV6ppshsX7m89TRWlT05NLiX2in5II8PkaOuSqBfxxW+4RTGp1UNeuXKCGqf3dzGQEZN+StbyvaJij8BPr0POFsh/zYjBFpUm5hygwPUYpQ95qwMgJGvoXyH/CvyB9IGteFHOGiQpj9DD65W+62Gc8jBXiIbwWcIyQmVceax6TITyWMpRlv2q3PNcZZYGIUmfuKCu1KV0EaeAzCvqNs+lLXlmK75x17lsL1aF/rdSJWvEJn1qHUd/Sivm6AfsZ9xGny/DyOdDqFwd4kqBCPpI8FBcM5xszlKFdfDp8JNNDp5Q/La6isvpKzNLKEBgtFmXW/668maE49AZWy42sXVNUv2pEHBkGw77w6PUJ1W8qdI1J73irHGZdraysJv8fC3suUGnSqByDrIiEW+KkF9/dmG81/Tzs37t/NTtZvL8G/2rdiL2fvWdnuCWrVuIO7cg9sn9vkwtbMlPWD1eoEz3deej51V5HScSzfjBxx39fBAbBW7C2fed9lBp2e8DiLnY3pMUL5xjHJlSMWMQ3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(86362001)(66476007)(66946007)(33656002)(8676002)(9686003)(6916009)(64756008)(26005)(41300700001)(66556008)(4326008)(186003)(76116006)(66446008)(83380400001)(71200400001)(55016003)(316002)(6506007)(7416002)(478600001)(54906003)(122000001)(38070700005)(2906002)(52536014)(38100700002)(8936002)(53546011)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sdlm7EF3eUvcS2oMRhAlYJ+doheL5ALOwDefOO2nAXlTlDfu1YLHDAL5JS2d?=
 =?us-ascii?Q?LGgcnTw3+rf4t16LgNMwYpiSnQ/AcJ4kSW1LaXUErMVXwPreZr2aULkEczAd?=
 =?us-ascii?Q?DITBhXDgEnZeKRCuXb0bKprHuK7Z82rACmvGxCFf6jYm0vIQrYbDsMMqUQh0?=
 =?us-ascii?Q?b8nKCiofGXZ1UGUAgV1Pz3kuVZACJRKKR+PRozi9SO0y2kpm7xmOrpcCGMmu?=
 =?us-ascii?Q?BImN+Q6Ff5g2OwRWm9zk82AMgMx/XFeBjdXXyrh/s59hUeuwL9mMt604JMCG?=
 =?us-ascii?Q?ErIU/9EtVTf8F+BIkkA8y9xXQsxd5Eo6OnKY4lAFGQ9R+Rb3Zo/exKptYp+c?=
 =?us-ascii?Q?skT/br0Zz2tQzgUXadkBHRVSlZJ9ll8/KLTrMGP+nUJuPv7eGRqIFSjGYEC1?=
 =?us-ascii?Q?lYaktzLUGvhoZ78PH7TTBO1KVSvySbuTkcAr6SP8x757w7FcqURRCVm7ZmVM?=
 =?us-ascii?Q?6MlVeW9A31bqwr+gLJCh21yxsbLbkweJDZRYIctFG5pfjuEsp3oeNLVkJSda?=
 =?us-ascii?Q?Wb2qbHlAW7qAU+jig3OXitFO+FTW6R3ZiTt15NGNnAAQXaAcZx2LTIT3fSYo?=
 =?us-ascii?Q?taP5qUat6sc9q8UakYS6HuQ5e9nUVmycSkef19VdSizDzr7gfb+pLgfrhRNS?=
 =?us-ascii?Q?9mUe83dALWaouZGPKG8Af/JFaDrCOyqEgmCNq5ZvMrfPCJUT4JXnYDoWRHyE?=
 =?us-ascii?Q?vhAj02tt2Tc+gDxTVA5m/s2WNPoo/mBtW88WilEzuka9l2cpjdUkAhzpQmNg?=
 =?us-ascii?Q?+DIyQ4xZlj2jFC9L+EzHHDwC0eHXdY4jXqPp2ZnScWHu2UL3Qdn/kg7GJL+a?=
 =?us-ascii?Q?y5ohQMGmzoSnbfk+1VmBed9USZS1OO7/A2aoTkvkYq8WRut3sDPfOwx8Gsjh?=
 =?us-ascii?Q?yQQARPtiZe8G6IZE0evwUkA1jINsMbatTY7hTkqt+mJqKSsq9qf5mjiR8rC5?=
 =?us-ascii?Q?DeE+igWrgwHTUxDQRY9nG8mcQZx9VPNUj3oF5eSH7EEn2QFsR9s+wQK8eWDD?=
 =?us-ascii?Q?udndHyQ1eMSNenB0JQ1BZhd3NwtAu4wb1Klg/Nt5ygauh7jyfNXXwWG8mFQ7?=
 =?us-ascii?Q?KYOezMaRsubr201YXXgTfCnehwRWV8bQ+RL5nnWvf0x3UhEX+gGY1AGK+xiy?=
 =?us-ascii?Q?lGMoBgC9zQUfloBbNGVjw+yPp+e8eoVbFbBTMre7c/Zjbs4iJOFXdylFLz2M?=
 =?us-ascii?Q?HqCgUu0GCvyLJbXzIjPz7PP758vaElDcb6yIrT3wC9DPePitpoIACOBiw/Vp?=
 =?us-ascii?Q?vxsqMGA3C7GYBtOyB5QagE3cS8h2SThzr27SCt187jxmB73QQoXAAa5VD49W?=
 =?us-ascii?Q?XGFvfkPm+U7422aNJ+e5iavVl68Nutquuwgvb0ZulhaEQk2Fsx/soXfXyVYG?=
 =?us-ascii?Q?M+M/trzpnUzvTF3tV7jRiZr+/LM53SedeTeyvkO9a0kpiJsC+sOY2bonl5vK?=
 =?us-ascii?Q?pG2NCRh85ZUAIFZSUTzIRldoWFaqiQ9x3HUTL2kzT2pYi2XMlH4EP+46Kbo6?=
 =?us-ascii?Q?ccm2gKHP3fLZ284wjXL7ocTiI+C6/MBA46WDS/KhCbxEP+gz8VOexwO2o90u?=
 =?us-ascii?Q?swkU/G02tPgDBomiBsM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9be4ecd-5a4c-4af0-9d96-08daf9545412
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 13:03:00.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONbD1GGS3ejmWOcx1g6A1gnNLv3VRLgPhIPPnLaKmBNM3Jst4UOlRN3Pl/a3Zfmw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 17, 2023 7:44 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; rafael@kernel.=
org;
> eric.auger@redhat.com; alex.williamson@redhat.com; cohuck@redhat.com;
> song.bao.hua@hisilicon.com; mchehab+huawei@kernel.org; maz@kernel.org;
> f.fainelli@gmail.com; jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com; linux-arm=
-
> kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 07/19] bus/cdx: add device attributes
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Tue, Jan 17, 2023 at 07:11:39PM +0530, Nipun Gupta wrote:
> > Create sysfs entry for CDX devices.
> >
> > Sysfs entries provided in each of the CDX device detected by
> > the CDX controller
> >  - vendor id
> >  - device id
> >  - remove
> >  - reset of the device.
> >  - driver override
> >
> > Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cdx     |  34 +++++
> >  drivers/bus/cdx/cdx.c                       | 144 ++++++++++++++++++++
> >  drivers/bus/cdx/controller/cdx_controller.c |  19 +++
> >  drivers/bus/cdx/controller/mcdi_functions.c |  14 ++
> >  drivers/bus/cdx/controller/mcdi_functions.h |  11 ++
> >  include/linux/cdx/cdx_bus.h                 |  23 ++++
> >  6 files changed, 245 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index 8c2425fdb6d9..1e0fdce18cde 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -10,3 +10,37 @@ Description:
> >                  For example::
> >
> >                 # echo 1 > /sys/bus/cdx/rescan
> > +
> > +What:                /sys/bus/cdx/devices/.../vendor
> > +Date:                January 2023
> > +Contact:     nipun.gupta@amd.com
> > +Description:
> > +             Vendor ID for this CDX device
>=20
> What format is this in?  How big is it?  Examples?

This is 16 bits. Agree need to add more info on this and other params.
Will update in next version.

>=20
> > +
> > +What:                /sys/bus/cdx/devices/.../device
> > +Date:                January 2023
> > +Contact:     nipun.gupta@amd.com
> > +Description:
> > +             Device ID for this CDX device
>=20
> Same here, be specific.
>=20
> > +
> > +What:                /sys/bus/cdx/devices/.../reset
> > +Date:                January 2023
> > +Contact:     nipun.gupta@amd.com
> > +Description:
> > +             Writing a non-zero value to this file would reset the
> > +             CDX device
> > +
> > +                For example::
> > +
> > +               # echo 1 > /sys/bus/cdx/.../reset
>=20
> Will that remove the device from the driver too?

No, it will not remove the device from the driver. We would
Introduce reset_done and reset_prepare callbacks which would
inform the device driver about reset in next spin.

>=20
> Again, more documentation please.

Sure.

>=20
> > +
> > +What:                /sys/bus/cdx/devices/.../remove
> > +Date:                January 2023
> > +Contact:     tarak.reddy@amd.com
> > +Description:
> > +             Writing a non-zero value to this file would remove the
> > +             corrosponding device from the CDX bus
> > +
> > +             For example::
> > +
> > +             # echo 1 > /sys/bus/cdx/devices/.../remove
>=20
> Why would you want to remove a device from the bus like this?

This is required to prepare the bus for applying new fabric
configuration (pseudo hot plug). So that driver does not access the
device while it is being reconfigured.

>=20
> > diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
> > index 2737470f08d3..1372d8dcaa4c 100644
> > --- a/drivers/bus/cdx/cdx.c
> > +++ b/drivers/bus/cdx/cdx.c
> > @@ -72,6 +72,38 @@ static DECLARE_BITMAP(cdx_controller_id_map,
> MAX_CDX_CONTROLLERS);
> >  /* List of CDX controllers registered with the CDX bus */
> >  static LIST_HEAD(cdx_controllers);
> >
> > +/**
> > + * reset_cdx_device - Reset a CDX device
> > + * @dev: CDX device
> > + * @data: This is always passed as NULL, and is not used in this API,
> > + *     but is required here as the bus_for_each_dev() API expects
> > + *     the passed function (reset_cdx_device) to have this
> > + *     as an argument.
> > + *
> > + * @return: -errno on failure, 0 on success.
>=20
> I recommend this function actually be the one without the data pointer,
> that way you don't get confused here.

Agree will update this.

>=20
> > + */
> > +static int reset_cdx_device(struct device *dev, void *data)
> > +{
> > +     struct cdx_device *cdx_dev =3D to_cdx_device(dev);
> > +     struct cdx_controller *cdx =3D cdx_dev->cdx;
> > +     struct cdx_device_config dev_config;
> > +     int ret;
> > +
> > +     dev_config.type =3D CDX_DEV_RESET_CONF;
> > +     ret =3D cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> > +                                   cdx_dev->dev_num, &dev_config);
> > +     if (ret)
> > +             dev_err(dev, "cdx device reset failed\n");
> > +
> > +     return ret;
> > +}
> > +
> > +int cdx_dev_reset(struct device *dev)
> > +{
> > +     return reset_cdx_device(dev, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(cdx_dev_reset);
>=20
> Remove the indirection as mentioned above please.
>=20
> Otherwise, very minor comments, nice work.
>=20
> greg k-h
