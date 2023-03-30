Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F56CFA38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC3EeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3EeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:34:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB531FF0;
        Wed, 29 Mar 2023 21:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKYBZzYnFuZGMzyW6tnZDDIcdyPY8F2UUavnlUvOcBA3bGPO41x9ZfZuqNec9CbOmmjP70pH8p1LUvRt+TmgfsdQar/IWlVuEdkoSXhR9EuGP8aGBKV0Qt1Bjc7XDOd/4bDqA9llfoilEAaA01ETUOa+eO1yWbpyHADEaXBvV/9sUBWgSI1VgYqEZz4F/ZglDYwVAqk5/wzJSXo/ocmwZvzjwJ6Xe34llQkZ9klLydfUIoGeXBxFIvJPGu/KvKf8DAhPWtSx0GiXGwGKAvl/NDHjtK053OBugT/rabbAuJfHd6x9xf4GyRFc3U2B2u3V4YD8r2VHUbo82sziS3M7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8CILBHzkkxr67ZIABQgyclgTamCC61w0QQghFp26U8=;
 b=mVKtP/77XYlu7ocdoO914n9GQjsCOIpndXeinO1v9CAss93S6DWLcr+NtgKpIM+5i7KeGUM44ncFiOD/pp1/SVuX2Wg1DaEE5IbyJCIv3cuikWn91VObKux+S032AD3eo2Qavp+/Y+AnMRmzdivLPUS1822ewEXDtIFcdwWtYJBnOxRlKdANZZK79ewzyI/IJ5mFSv76HPDDnQKtTZJ79eeV7bpKFTUFSYNGfzAJuXf5TXxah2xXJMQVCr2ro8f117lQr1qTqkTo1J3xv2aksomMhBiXHAswdKWnGEsPu83MmEs4RGGgmiw+c/Bfgyen7CIQnERXt48x0sA52ZV8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8CILBHzkkxr67ZIABQgyclgTamCC61w0QQghFp26U8=;
 b=OEv83ik0zyFsE9Sat0AqX2KAfqh0/l09UaVUc7rLrvt23/gVmGWbE5FFBrkRMRFyvlK4z+lh2mFb2BjHNfJhdzYOInkPIPUlLQ/UMMTSmSc/FplHtIenrL22vTsCYv/HIJyra1YU7rWRxloFpho2itDDaOnC/bfUVLiN9F/vubc=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 04:34:03 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1%7]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 04:34:03 +0000
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v10 2/7] iommu: Add iommu probe for CDX bus
Thread-Topic: [PATCH v10 2/7] iommu: Add iommu probe for CDX bus
Thread-Index: AQHZVa+GCjncBc+ZC0CHdbkvy/BocK8RpkEAgAEuTQA=
Date:   Thu, 30 Mar 2023 04:34:02 +0000
Message-ID: <DM6PR12MB30823A9CA118E1890BAC2260E88E9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
 <20230313132636.31850-3-nipun.gupta@amd.com> <ZCQSJmcb7W4dT2yS@kroah.com>
In-Reply-To: <ZCQSJmcb7W4dT2yS@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T04:33:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cce45402-1a1f-4c6d-a2bd-7f68d62186b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|PH7PR12MB5950:EE_
x-ms-office365-filtering-correlation-id: a7325343-9568-435a-5f67-08db30d7fd33
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yk3qMJjkU1fufdieKBrc/hfILSY0bauIEy9iO/Fog7TCVJ6ScsqDz6XHkikNeL/biUn6vEKLHrELNkmZmuzUEnjfFT2Wl6QVCkgAWbFRRWe+GiBYYgXKM4p4n9CppO/D+h1I/gfHqk1ABwpGYE/l7gwsxiDJRhPtV73s7c8URh9sUc5pWxWEkfogmIQgpKrZLhTn6yxo+9G2ferie8CdcOxg0kxqc97jiB1k/nrN2Ou4JWSa4VaHaAWnNHMSUpH2Aa6WDNT49/zlhj8lMtShh1M8N/DxymuWBDxbeMA2NVIR6z6OGOaHmJOVzDXn2/Lx6JGBDn0kflAhZmRcT769x8Z4lwn0BW2WiXlLFWHdFl8JYOk7N2QxlVAN2cxi594J1lGV+S7OP2feeA0x9GWV3LrxEK3d+Zt/ZhuQVEwvr9W08+1pNBOrqvCYFP0T8s2266YDgTQLC5YGUeFDflVP1dF6l8mtzEfEROqBgP5+gl03/SaWYFTuFU9jVqNZuFoR09G9pWoYTpmcmloDGI1oQIFkR/oVlnz97SzzInqDvHKrep+jED0tTwC0yigLjw8gWbkQJjrul+YDeI4tp5Pn47MK6KAWz5P+6pf6LHTbVFfszxW7AYrQKNelmtGZMCvH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(52536014)(5660300002)(186003)(55016003)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(4326008)(6916009)(33656002)(71200400001)(7696005)(122000001)(38070700005)(38100700002)(86362001)(9686003)(53546011)(316002)(83380400001)(26005)(6506007)(7416002)(7406005)(2906002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fHOGZGtAi7DlTwGScX4DRHjrJGsLe8ZYpc/x+Am43r472x+MxX56k2MrvwBO?=
 =?us-ascii?Q?zR1dxAPVdHxZhDoyKgfWQv5RQxrmzGFhSZKdXkCZU25yLLRPrjAmG84bOH4D?=
 =?us-ascii?Q?YsFUVpt8wFZsctOtFx/EBWMF2FB0btkFJ8qu1mJEEL0SiqKwlw/4MVWR7bVw?=
 =?us-ascii?Q?n6wEjmCYOlpVyzm6Rtuj9QSVQafvRUi/PC/2tZjK8QwGYyOVanL/GPupUmxL?=
 =?us-ascii?Q?JCCgqR16ttAzJOCKLcZWcyh0pbAeR3V10C9U5o7m6lZASkKyF1l/xNKNW1YP?=
 =?us-ascii?Q?UPdOBncGT/M4lvB2GLm/xOV8a0c6bktT8mSmG9HvQJSXvhnQGSlE8lvpegdC?=
 =?us-ascii?Q?qwNPQy/9+4vYNrGvfSQiQIRIXrUqmWoWPK5VpLz5cIRLi3VZzeoCtDW7P4kq?=
 =?us-ascii?Q?gVeeFhhFJFg38Ce1JBuFzcZ5/UydL17YEGCfpqBFQWj/v5XWg+u9hWZazyqy?=
 =?us-ascii?Q?/+i1V+9YSo9uNdH1rGvDrFpkB/gfBrjyv8nBqvPq7axCryKVMQdRYbC1MiBA?=
 =?us-ascii?Q?fGmlLgsWgfp261aMuCFMmou955WqviuHLm4MNpOUqAqus/GL13Qh4h4a0qpw?=
 =?us-ascii?Q?cxdsicqGUpbZAyqZA6wlQ+8PTzG7wJ+fq/wEk0TWsKSF+/DcR1/9XR8zCieA?=
 =?us-ascii?Q?XDeymk4g1CAFdZ0Gcw7mBuiq375wvyx8aS2cW2nv7RNvfvaGpEEahNDPxRY4?=
 =?us-ascii?Q?0RL6ejGB8gPFPyKaokInkVZE3yzDgfLiiz6PACDBE/HNp18Ea/B1VfU9+sXT?=
 =?us-ascii?Q?77b5C79rcxz2skkGK4kUSfga+Swd66Ab7LP9JrhKECJDcjBOnbPHd8CgVCSw?=
 =?us-ascii?Q?ghmGyzctH4hQclhHYnXfnrO+g5SoNZ6umi4M3e2jeFWctIWLS87XzN3vJOmZ?=
 =?us-ascii?Q?jxqvJnJvFuL11fn6dGplX3IkmZtOwEXuBi//NBymSvrBzfPg3T/vj0J2IsLw?=
 =?us-ascii?Q?6IBSncZpaXC5r1dVYEniWTinFSwcyZme6j7U1pbuPWLy8heKfxfZFlTjsIJU?=
 =?us-ascii?Q?RRKlQNTKHCSqjqxbiOn/EuAiqF17tNcNNEPwQSNg4So3XkXAs0fxFg24bxIu?=
 =?us-ascii?Q?p/IEJecr9A7F8TTJiszdWKw6Vx25ZfJrKCfarEi8Fo3jWTbAWB4di6LUBi9t?=
 =?us-ascii?Q?tQ1qHTGHxuYitf8yDm7JW/BUEJrHnid6tfmdjVdrM3fbU/AVqP7xEemTVd1T?=
 =?us-ascii?Q?frNqm4o22YDq5Gnhnu9VMgaArAcRdUP3DDXkzWkh4QnS4sCowB2F3BcuoM9G?=
 =?us-ascii?Q?OVaoF0IfLsxiUuxUxkZUnLuCUm6FYmGvR7N9lk2b7TnL5ESjkJfH6DPqZa2F?=
 =?us-ascii?Q?hgiEJiNtrpAyNTUPyRlXNesp3IFi2IZs4GjFAFTpJGX4st0pBO2SXk6sLAyB?=
 =?us-ascii?Q?fJqIVnQLweAEfaQWFd2Nc8WDrJMx4IUzqOc7yli+Hk2RDOCsjovOKxweHsLE?=
 =?us-ascii?Q?r+zNYLQot8DOD+VwGSIXOlKp3/q3g++KkyVFp014rzv6VjAvxWy786AWoClJ?=
 =?us-ascii?Q?grYgOSLb6xDxoQjHPQRzHPOZ3kP1rBYKZqah5CITFv48d5+KpFyXJcWm2045?=
 =?us-ascii?Q?9zvdfWtLYzPyrPxOtDo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7325343-9568-435a-5f67-08db30d7fd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 04:34:02.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSL2+CH3+IB488B6VLuUzcnXVNxZ/0PkUDxoZQncaxZMcjUGY75ZHfil6e8BMIP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]


> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, March 29, 2023 3:56 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> rafael@kernel.org; eric.auger@redhat.com; alex.williamson@redhat.com;
> cohuck@redhat.com; song.bao.hua@hisilicon.com;
> mchehab+huawei@kernel.org; maz@kernel.org; f.fainelli@gmail.com;
> jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com;
> rdunlap@infradead.org; baolu.lu@linux.intel.com; linux-arm-
> kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>;
> Jansen Van Vuuren, Pieter <pieter.jansen-van-vuuren@amd.com>; Cascon,
> Pablo <pablo.cascon@amd.com>; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v10 2/7] iommu: Add iommu probe for CDX bus
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On Mon, Mar 13, 2023 at 06:56:31PM +0530, Nipun Gupta wrote:
> > Add CDX bus to iommu_buses so that IOMMU probe is called
> > for it.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> vuuren@amd.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> >  drivers/iommu/iommu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 10db680acaed..0025a631b8e1 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/fsl/mc.h>
> >  #include <linux/module.h>
> >  #include <linux/cc_platform.h>
> > +#include <linux/cdx/cdx_bus.h>
> >  #include <trace/events/iommu.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/msi.h>
> > @@ -129,6 +130,9 @@ static struct bus_type * const iommu_buses[] =3D {
> >  #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
> >       &host1x_context_device_bus_type,
> >  #endif
> > +#ifdef CONFIG_CDX_BUS
> > +     &cdx_bus_type,
> > +#endif
> >  };
>=20
> Note, this prevents the ability for this struct bus_type from being
> moved into read-only memory in the future.  But hopefully that will be
> fixed up eventually, you are in good company with some other busses
> here...
>=20
> Other than that, this series looks good, I'll queue this up through my
> tree for now as I seem to collect new subsystems.  Feel free to send
> future patches through me as well until you get tired of that and want
> to send stuff to Linus directly.

Thanks, Greg, for the review and helping get the series in : )

Regards,
Nipun

>=20
> thanks,
>=20
> greg k-h
