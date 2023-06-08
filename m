Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA9727627
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjFHEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjFHEhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:37:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA701988
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei1/dsiVuzomTCb+zkwfdDOmwpNpzfMjlgsV8akEDQzDrKuDPQ+svnoCA5JG363Chb0/tmOuTROo5HUdtdqzLLsuW/qsxB+Z1EOWvI5ZGSCTngDmkvcaTYjm/HEptsv8kraAxkP/PSknYeasV3zyDBZ9gOLYYrCRygrpY2H5kPrgcXPcVtYKJcdLzk8207xKc20jwIqJr9P9Mdq8ULbikoDXmLlHfKOTA5CsZfeznnMqYh0lSNWH6QQ70GI9J0sFYu7lWMY3GSsHHlYcNa0pGrowLGgpyrnzA+A6Pgoq7kD4XVcZd7/r1Wn7M5Hg0guwJip5HkZrR7XRT+DGuxMyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFC2J/Ysxvu7/bSxN1LtBG3vC73dPX4R5ZPYdT2qnkU=;
 b=SxJqbqTu0AT7TjOZh8e9QI9S51eaRZlMy0U3ZzL328SfjDlEmaBh2V4db6/1M2xIuZUUKyjOnsGjdCDEp7icaHGPcdqVOQQKwllFBWtMROL+fliNLBVRfB7Nx1+lnWxhsG75IV8DFE94fyiVlQROpsxc6HSpJz/h/K0NCD2Sb4YIyuCisAC9d88SyaC4bkQ6Hncex4/ysOVau2ezS25io1jqdR9Oa9i1moeJPnRfVjHyElTyoTrLPM5qGHD42uLV300oWgDgXzXVyzKHEmNtVlQh8+RITM7uBBWIJLrDRdZthYO5LfPmvIWpN3LFLwl76kGimS0TQDA9LlsqslJCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFC2J/Ysxvu7/bSxN1LtBG3vC73dPX4R5ZPYdT2qnkU=;
 b=1j3Ko/mvvyh1k+Zih41bL9CfEGSmscCGf41CuagXFPK7wkfGjU1EnzxHOtml4cBUpwy1TZxAtzFyHKi7R5qDLwqo9fX+/kq9SiqBNRlCm/qGtcQUCHsjt1iExDJ1jVeBQSRJIpQvVAuv0ac+iQwTneZhkIpcIzQqZU6rRzJALrc=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:37:08 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::364f:71ca:b414:d5f9]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::364f:71ca:b414:d5f9%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:37:07 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [RESEND PATCH] cdx: fix driver managed dma support
Thread-Topic: [RESEND PATCH] cdx: fix driver managed dma support
Thread-Index: AQHZl68tY7N16WlOHkydIw8tcIYLZK+AVL7Q
Date:   Thu, 8 Jun 2023 04:37:07 +0000
Message-ID: <BL1PR12MB53336A08EF8D7770B8558B6E9D50A@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20230605131009.6869-1-nipun.gupta@amd.com>
In-Reply-To: <20230605131009.6869-1-nipun.gupta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=2a61cd1d-a799-497b-9878-1f768520c9c8;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-06-08T04:32:31Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|IA0PR12MB7626:EE_
x-ms-office365-filtering-correlation-id: 16baa0d9-f433-47ee-2b8e-08db67da0424
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JDijvoSRgyYS4lSgmtbeqA+8vSM/kQubRUB8rNxjJQKDkGq2uaZk5dzxkOk+8PvxuSkn5ilQiJhWHoBcKZtd/CeeqMfTzsl9sIz3Lose85Dp/OS22nBRztefwLzCtoTDt4IJHUiOeqgehXTImrjpK5DPmfur63pF6zSNBPlY1vbgUtyPdEs2jOHezOa08+0UmOUWeGrjD1FgfttZhDglBaQ99JdtpmyOK2Tt8GJUr6JLj76ww8nJ92npil1Hi3ciZw/+0n4p/10hL82O5IZAOE28cnoJhViSszggV0XsdUSkO8OkuAP0WYKst+JFVTGmlbTxTeAh49InkFrWJjLC5PwbW2pCM6ZbhrHQZiIZFdxgPhyEuO4ahl6ZTkrBxkFXLN+w1xe6kZHezuXQsLSvMLWy7nTSLT5y+fEWhiOLRTaam9Mgp1Jts7A0aZ3QI8O6UoyOUVJQlBvdklTcQZn8C+ZZFaZuz2weLhe7ayC4U3y6tr4ootcGBCnv9ChgzvHNm4rSPWKgo29uhlBSB7uUMWazkcd79n6Z7UMVMjq9zEgRuZW9dptANV9Gst+PbdXsvloZZXZnHDR4OejkiVuHG+HvvkXOuwbN7NkJpukXQdTz4Bjf1a7s7p5luv1/KUpE2BBGcIsZ+V55uw0CXnmEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(9686003)(53546011)(38100700002)(6506007)(41300700001)(7696005)(26005)(186003)(83380400001)(966005)(71200400001)(478600001)(110136005)(54906003)(64756008)(66476007)(122000001)(66446008)(4326008)(55016003)(316002)(66946007)(76116006)(8676002)(66556008)(52536014)(8936002)(2906002)(5660300002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cyCQafATuMv94Sx0rI24XCrFDiYfvWWj7SHdG2HdsBmT02j4GqMQOsi8qSeU?=
 =?us-ascii?Q?7xQyez4MtWtDZYMF/uVNqQxLuuu+D1X7ltajqCjcgb/g5U/FTPnoDBJDuxZ4?=
 =?us-ascii?Q?SUInoGJScPXkDssz6AJbogVheKtjJ2XQsIiPWqw2l7jLgI4CKojIu8VWDEWb?=
 =?us-ascii?Q?o4DV4ZQ+4M7QxfASit3guTnVaXm3khQSe9hAji5DBUYR22IcmB2Rj9/I8blJ?=
 =?us-ascii?Q?7ypDn/im0KQwY2oOILOSrBJmBMSXg+iyIp6IZIo2IlqZLeD5FvagKvsAc2ZW?=
 =?us-ascii?Q?8JhD4m9l3HtaECmGXoLHjXqYk6ge1VuXj/1hQIuLT4+6CFcoN7s/makSXUeI?=
 =?us-ascii?Q?LQuYcBNQxvhy2o+ffKr6sLgUAG30k6yw+h5JWM7eKWj8xXJXbSSJHCMS1lJ1?=
 =?us-ascii?Q?ewllUl5mRFjcOwoLcu7NXwf3q/aHJaDhNyX6asXMjbjoimyM3AEOFoVB4Mv9?=
 =?us-ascii?Q?i+rYCPTox0P79+M5tEWmVGrMQAe+2xn/SwLXY8rDcOHJq67A4WLOq/N3vujh?=
 =?us-ascii?Q?z8gL24iIgKTkCqCuUvK0euS+Auiu4gdDQzd9nh8sTvdiVwoA1HG9q+aERxIW?=
 =?us-ascii?Q?jNHOn80swA74fSa1Ke9tEHmb7lcDedON2VaY+bDw13sqGTHWKZF6evvLwny7?=
 =?us-ascii?Q?N0UOSqBCSZdYO201CcLoLUdZS/TTTS+H+bILCmEdXzHZAQ3tuBO9PaasffB5?=
 =?us-ascii?Q?TU4Ae6qm12Uxj1ztIwE5ise73IdBiQB++yflo5JEwpD67JXPBq34vFh6pqjd?=
 =?us-ascii?Q?nF5/7VZCtV37OJedCUhhn49tjWVaIqUdW7J591vINT45rF2WmPhlAGNiHIcM?=
 =?us-ascii?Q?xVmzyHGuPGNMmuOwmtau6/DbBYpOmJUxwEHNV30mFXiQCcILevsNp6hJ9xSv?=
 =?us-ascii?Q?ZzMW2DYzHMhH/h96UKtECQkW3J+ZyzcpSau9VCmweJAqWAqcV5Ty3nVj2Eoh?=
 =?us-ascii?Q?LAIVZPL39VJ49bgtlzqc1sWeT+bBmDxocQFcBd997Rhmxeg+FUTmpc2qCpaO?=
 =?us-ascii?Q?lWddcuIgfgIn7pKoxvCqcp0FS7w+GHIuvRnfno9Dr6PlsJvxcIaL4xrG6jKl?=
 =?us-ascii?Q?oEwVgQhuAyxDS/NoU3HivQ59M00dWY0hLHLscE3emEKM2gJ7EJkKJulN37sG?=
 =?us-ascii?Q?hPFAhMKqwyMondKD6oIEhoZqmxp5LFWCNgBaFH7OzCkyeoSOtuUrpQITspBO?=
 =?us-ascii?Q?K+dT9psXmzD+FA7jgYGJrWN+dEKH2L1ik25WnhAys8eGgG5cNO8ixCrLQxdV?=
 =?us-ascii?Q?+0LZqe9S/ZaYsYg2F6T7sDkkEcxDD1zz30RTyYDh0RuN5SBvtXeTLeDa1J1N?=
 =?us-ascii?Q?te71pGFWNXlZaG89ZxwZ2z0jwCB98Gg2BZJU4FSQkAYQU8CGb2f0snb4X7ih?=
 =?us-ascii?Q?IOyKfuXtvv9QOLRFykxGrKZ014SYwhDlg7NwvvMQpCY35tlTk3chLU7jsUF+?=
 =?us-ascii?Q?QIpmE88Y6oK9fzt3vhnMZJT84WEurxzuh0cftUbRYeIkCeR3NPsrBA8j2Oo6?=
 =?us-ascii?Q?Nxs2EBQ/s+1kDMoqXxeR7aI6V58qbhQUjr8bOi3t7OMywEV7px0OOzgZxUhS?=
 =?us-ascii?Q?DYj3PmuxSJOmIZ7x+S4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16baa0d9-f433-47ee-2b8e-08db67da0424
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 04:37:07.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP0MpRu8iJIIM28r7m4ohsMFzi+4C9vYcQ7QPLA27t2mBSkrNj9N7Fa9mB4OI8Pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

> -----Original Message-----
> From: Nipun Gupta <nipun.gupta@amd.com>
> Sent: Monday, June 5, 2023 6:40 PM
> To: gregkh@linuxfoundation.org; alex.williamson@redhat.com; jgg@ziepe.ca;
> linux-kernel@vger.kernel.org
> Cc: git (AMD-Xilinx) <git@amd.com>; Anand, Harpreet
> <harpreet.anand@amd.com>; Jansen Van Vuuren, Pieter <pieter.jansen-van-
> vuuren@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>; Simek,
> Michal <michal.simek@amd.com>; Gupta, Nipun <Nipun.Gupta@amd.com>
> Subject: [RESEND PATCH] cdx: fix driver managed dma support
>=20
> The devices on cdx could be bound to drivers with the device DMA managed
> by kernel drivers or user-space applications.
> As multiple devices can be placed in the same IOMMU group, the DMA on
> these devices must either be entirely under kernel control or userspace
> control. Fix the CDX bus driver to acknowlege the driver_managed_dma flag
> and call the appropriate iommu APIs.
>=20
> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes:
> https://lore.kernel.org/lkml/20230524134831.28dc97e2.alex.williamson@re
> dhat.com/
> ---
>=20
> I have resend this patch to include fixes, closes and reported by tags. W=
e
> request that this fix be incorporated into the 6.4 release, along with th=
e
> inclusion of CDX bus driver support.
> Original patch was sent at:
> https://lore.kernel.org/lkml/20230531114759.6173-1-
> nipun.gupta@amd.com/
>=20
>  drivers/cdx/cdx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c index
> dc74fae02a78..42bbe5ed370d 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -63,6 +63,8 @@
>  #include <linux/mm.h>
>  #include <linux/xarray.h>
>  #include <linux/cdx/cdx_bus.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-map-ops.h>
>  #include "cdx.h"
>=20
>  /* Default DMA mask for devices on a CDX bus */ @@ -267,6 +269,7 @@
> static void cdx_shutdown(struct device *dev)
>=20
>  static int cdx_dma_configure(struct device *dev)  {
> +	struct cdx_driver *cdx_drv =3D to_cdx_driver(dev->driver);
>  	struct cdx_device *cdx_dev =3D to_cdx_device(dev);
>  	u32 input_id =3D cdx_dev->req_id;
>  	int ret;
> @@ -277,9 +280,23 @@ static int cdx_dma_configure(struct device *dev)
>  		return ret;
>  	}
>=20
> +	if (!ret && !cdx_drv->driver_managed_dma) {
> +		ret =3D iommu_device_use_default_domain(dev);
> +		if (ret)
> +			arch_teardown_dma_ops(dev);
> +	}
> +
>  	return 0;
>  }
>=20
> +static void cdx_dma_cleanup(struct device *dev) {
> +	struct cdx_driver *cdx_drv =3D to_cdx_driver(dev->driver);
> +
> +	if (!cdx_drv->driver_managed_dma)
> +		iommu_device_unuse_default_domain(dev);
> +}
> +
>  /* show configuration fields */
>  #define cdx_config_attr(field, format_string)	\
>  static ssize_t	\
> @@ -503,6 +520,7 @@ struct bus_type cdx_bus_type =3D {
>  	.remove		=3D cdx_remove,
>  	.shutdown	=3D cdx_shutdown,
>  	.dma_configure	=3D cdx_dma_configure,
> +	.dma_cleanup	=3D cdx_dma_cleanup,
>  	.bus_groups	=3D cdx_bus_groups,
>  	.dev_groups	=3D cdx_dev_groups,
>  };
> --
> 2.17.1

