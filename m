Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9346874AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBBErx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjBBErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:47:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213382402
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:45:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3z2w2GS7pmbXSBGiB91Zbut3jfLjIravLE9X0MqFGnV5sbEkOuNHQfnQEhLS3zavTLMNMH/2YWh5uOof4scbhxUkZp4BYvvtsT9ygri+Y29FkM4Huf1ccfOymjWLN2UIc2DL0J5/Jtulx4gA2yB1TImoDhfx8blXr2lYGacL+WlRBXtc5swBztprAg37oU3aPuzpgWgSWSaTwTBIGmaC9TJ6truMyFgAoUiFW99BVRIZj6qYExhWhI1PIS3wCVXuGfBn/CDGzMY8XQCZ/GDHFXp2B+eDChuUFArdYTLr7XgttEzyaH0LAjf/5Fu6gTnnXu3xXcVjiK7sxab1VuZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h9tyzyL96qm+NDl6Ty48O0Fogxc74NWN223rx8RHMM=;
 b=kkL0svd30+PelTooj7zv/cD81nkwuW8YFFvGckzGqUpuxP+6tWWJF3UxDuOItVmBwAbIvx9IN3i6OPqYHA+XUjJuHsvxlw1askXbtSqkX5/jksQGlLmbtatbbuFkme6BDdrTZVcJZi7/9ycdxPIpRQfV66aaG3V+n+h8gKSX68Z2HXvu8MSgNewld9UvXgTh9VzJB9myGRDTqZ7dwwRUw9QpXt4lNYcnD6Bn3XcnZ0pJGoHcKLFUSZM3dzszRnV2WvUN6NV9omFXhtz1AiUYgYF+ujlVY4/a1QNxTeol1KuGpQrF1Zwpx3MHV9YYDdfrE/w/w0NbpDFB80Tz5KbbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h9tyzyL96qm+NDl6Ty48O0Fogxc74NWN223rx8RHMM=;
 b=tbeJacjj07I8KNh5oKtks4zqn9MxRS4BkP6Nigl6lBqZd+jX6xNMjqNbr2mPEYIa1Tk6hMjYw8laGUBDWGgG/7Rm7nDyz0Pk9184KrKdVo1PHLe7cy7hL0sB7boxUDa4AdgE17xYOFAaF+Wq+ke2T2ylV38If5rvsWbV/BFllj+Sl5kexabbNIp1DL6pv3znN/vNi9zM/Ls55zL9KnY0fR8GYPglE0VvAQJqFPfznx8M6JHdSubxaG8AGDCY/z5J9QDS+OiMRolidGg2AvtYgUwucxZEk4/dgjR1TQChi53S/16pBwB81tVxDZ+WuzsRdCLL8CVCLBYhY6BSPpXbxg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 04:45:24 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%4]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 04:45:23 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/7] vdpa: fix improper error message when adding vdpa
 dev
Thread-Topic: [PATCH v2 1/7] vdpa: fix improper error message when adding vdpa
 dev
Thread-Index: AQHZNcrtYY1KrfDk7UG+prT+QyItbq67FgIA
Date:   Thu, 2 Feb 2023 04:45:23 +0000
Message-ID: <PH0PR12MB5481DFAE7928CDCB5E189C97DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1675207345-22328-2-git-send-email-si-wei.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: 69ccc2f7-7ebe-4824-04e6-08db04d84b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKk/Bg5z9dF8Ika42KTO1K5A0yOjNtveo8XN22wkVzLxuEG4/2eqv7335O+4rtOpa7hwMrBrqAilr8iO3kszwsP1EPcKYw/w++eoJk6+UcmvsiC2Xa6cy59f/SSAdyfgrC3rZteb2ocJaMWHQMEwrqxDjtsNgumjgw82c0ia9aatxr5E4cyM3jJ5GbmQDT+e5QQedF4b/1Zzm6b902ls4meL570SN3LfEZB120g2J/uDbhuJarkFGi3TlIWQcfR6VuJRo8qITYc5dGgezO2jPFuYcDoSEuYMWSW/fqhIlhLdei0wJvtIwI//UaLvNhmqDAXEhBvSeku1pQWsko8ZoWImBqO8L6NMgO7PuMBVnuEDfjVcbght8Y3HgYeV3hnmKr76nPyaKx2eFjA/OeV7i/48gaHT4zQ+kcYqokoL1xvyu55oeYptqa1YQCP5Nsotbej8JO5Ch3DdpNrI3VYCaaX9MhiDMupBL7mBFGq52aXb1BYXVasba3c+KwnJiYJMC9nCZgCLH7+Dlsv0VaaDJ7bBEWiUfx0rHFR4VfnRPjM3OOKtFbRPB1MQ5vkajcUzhT+v3S7Yt8NLRQ3fEwi/bsCj0ms8/z72sUUuu0ljsMRxdJq7CnYKm0UB4DcSWtZhVd5ze4qYqiRX0LYsBp+EyrVZ7tMm2+cLngkAcklS6D7rYVYUJZTX2O5cHPy/+IXIw7AfGJAVUrW73QFs2TtNFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(55016003)(64756008)(54906003)(6636002)(66476007)(8936002)(41300700001)(52536014)(4326008)(66946007)(316002)(110136005)(8676002)(66446008)(76116006)(186003)(9686003)(6506007)(71200400001)(26005)(38070700005)(478600001)(83380400001)(86362001)(66556008)(15650500001)(5660300002)(2906002)(38100700002)(122000001)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCU4Y4jrULn6nQ9G2jnoz7rjRKcyeWf/yYdnJ6ZTtb20davuXilxBqOTALyu?=
 =?us-ascii?Q?N4UHe0/Cgbc2Ck+aEGsj0KiIYrMoyiSKHuLOaLsVjAK8C/FlNCUBb3Q0YtyZ?=
 =?us-ascii?Q?behqGwC2NcS92dmhwRg6EhQhkt7LjXht9uEFi8VMoLcdketA+vkZ2bWWD0dm?=
 =?us-ascii?Q?YlG0c6LvwWmZeY+m4Qm6/c6Z9m0rCYobA1p7umV8m0H0CbJ2xJykL5E/RJtd?=
 =?us-ascii?Q?jfj4IXiOtNAfAU5bCjZA9kOQcXChom1J/bjHRjBI4iqP2w7i/IkNgwgxjLhK?=
 =?us-ascii?Q?Eqb74Au0e/uI4QYMQXinRGUJCGtgExtETrT96k5bRlmmSyjherBf55QP5hps?=
 =?us-ascii?Q?Hdzbprn5+ZNwpESXuIDwkG+V311rTRcEimco4QBrf/ccpRBGNQYkzxUA2US3?=
 =?us-ascii?Q?hnb38uiWhzevSTH9PhNIZn1DdxGJElsXOCvGpiat2cPcG++esjPSl07UoabH?=
 =?us-ascii?Q?ZjwbvXPqfTFsHCWI4FK0qqPzV9oRq5AmPNsxpOq8R7pEytsCeMazwgnfhfo8?=
 =?us-ascii?Q?zgAx799d5wrTipTQ/Nym0gRM0yVRVULBCaII98CP4RYmJj+s2DDhsjKvzAnh?=
 =?us-ascii?Q?1SCf3qiOhTB/VuKc7vN+QgldKmIRWaNbpXUronY+qNs7AkiFKTiwFHgaeWUw?=
 =?us-ascii?Q?MQ72VbSiSXHyAbcltAvfDye0u27xFSNVbGDayC8WbdqT32GQ+mq2n0OkkCv8?=
 =?us-ascii?Q?MoKrokcbtB4VvoEG273tpCahQieLMVG5VgO1PACiR4m+rbJ1A05uX1u88yDJ?=
 =?us-ascii?Q?Lcn+8ljYMjyaeDfr/mg+5Af96C2g5tA3u9lcBZRIB1QtVYt/RzyYFPrR58FI?=
 =?us-ascii?Q?5a3aVUrdgeQV55wk9nzlgZLdSzHroEX1Tz7IN6jAnbQsjoj85PnfyhetIYfB?=
 =?us-ascii?Q?SCHtx4nwQh6bywbN+j5bOuTpjYJtzm8lZaNSySW4/Ob/l87aNl7NEytM2Rlp?=
 =?us-ascii?Q?tjAfdX79hjaUDR4x+2craVmqiAP6clP1mciL2HgG2XPVWVbTE8VWfqwL7fid?=
 =?us-ascii?Q?XGLh29glqsXrdsnDOkutlXsHl75/Rlj0uCGB+hAGRNEGoQmeBXBDjnOfaDCf?=
 =?us-ascii?Q?4+A7yfDRQYg/NKooaFSPiC5cuQiqHTU7jRxyTWkxr7RhaKL950wG1cMzpqF5?=
 =?us-ascii?Q?jD7+zL31gyfn/1+b6HzYR/2OyZO63qeb44SUg+w3mNJynpOyExaN2qG1rQgc?=
 =?us-ascii?Q?jR72rHxkIl4GME31QIs7wTluuiB6mSH+wWTvGVpDF2qTiabkquUPfgJj3iCR?=
 =?us-ascii?Q?6ZOP6q4dsHpzU0KcAfvpvCVEar5NhM7D3ujcBQRaYdiVBuoCEkuovzcMVw95?=
 =?us-ascii?Q?szSebptLU/Q+/K5EqBAg58T2KGOFksHUJpLgNS6asyu02DjInjXRu4bAqANm?=
 =?us-ascii?Q?TzVzL0VSOYwrXktNUNr9muYjYzQMt/p2ESAd75vY57GJu2J4waJWgq1efb+w?=
 =?us-ascii?Q?RqhXUqX8ZUAqwZtOw9wRn26QMKUZkywew2YJK522Q3ZV3pkZ00yYoNd9uruJ?=
 =?us-ascii?Q?BCZi67okTnkzo22TMTaBwhc8jZHbh+3HdpefvIgQL3/ZIQCrbB8IdXcFlS+3?=
 =?us-ascii?Q?6XLkbInRjGvIBkI+7kk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ccc2f7-7ebe-4824-04e6-08db04d84b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 04:45:23.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKOjFpNL/C6TSBVs+7WF+QMBH6DN+JgydbkL2QjU+bTGgXDJErbjzXwcxu/OqLJeUvVWDCnpGO15CLFRmcjnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Tuesday, January 31, 2023 6:22 PM
>=20
> In below example, before the fix, mtu attribute is supported by the paren=
t
> mgmtdev, but the error message showing "All provided are not supported" i=
s
> just misleading.
>=20
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
>   max_supported_vqs 3
>   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1
> ACCESS_PLATFORM
>=20
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>=20
> After fix, the relevant error message will be like:
>=20
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: Some provided attributes are not supported: 0x1000.
> kernel answers: Operation not supported
>=20
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Please add fixes tag so that older kernel gets this fix.
With that change,
Reviewed-by: Parav Pandit <parav@nvidia.com>

> ---
>  drivers/vdpa/vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index 8ef7aa1..3a8=
2ca78
> 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -622,9 +622,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> sk_buff *skb, struct genl_info *i
>  		err =3D PTR_ERR(mdev);
>  		goto err;
>  	}
> +
>  	if ((config.mask & mdev->config_attr_mask) !=3D config.mask) {
> -		NL_SET_ERR_MSG_MOD(info->extack,
> -				   "All provided attributes are not supported");
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "Some provided attributes are not
> supported: 0x%llx",
> +				       config.mask & ~mdev->config_attr_mask);
>  		err =3D -EOPNOTSUPP;
>  		goto err;
>  	}
> --
> 1.8.3.1

