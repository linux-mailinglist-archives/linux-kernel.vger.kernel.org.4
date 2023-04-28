Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F616F109E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjD1C7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1C7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:59:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717D2703;
        Thu, 27 Apr 2023 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682650746; x=1714186746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zd5P1262aFscnwKM9EX8uzW3GyP276vMqUHk4F7bppM=;
  b=ZXKgL/Gyw1bXhDEsK9TDhOocXcaJmtPyBtpMmBjJZLxjNivkqxyGPbnn
   BlQ4I1D9uEqtCUUCI0R0kr+s9tX7xkTtf9Z/ptbfd+zTJoWPYZGarByZt
   RpOuWfOPEb+FztoOtN+1MHWS1U0+VdHzyTL5pnz+hWveDBk0suVDxr7tw
   nloLYwIBW7+4fC60jUCMxw+NlUHCCbYc82y4ZIkFrAvqrY4yuCYH2eSiK
   k+MwU2rv9XQPgJbcPt1LearbNbhXhf9jOUimVWHvM4MbDOSrWjI0QHv5B
   3Rjag8ey1gTQvrj62N2lQrMMyH12zL10vTu6fINaL+siAq4JpyXHWMMfc
   g==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="229362350"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 10:59:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocuEQ7LgT03NSSwgUl0YMuYL35y/Earm9EQeCCOJq+KkppQbyqNyH6x+cP1DP8ZyM78QTn3QJAw0/P2QWJH+kNns8ygllhn2pjJESew8jBLTRpwNaGpV2g62tYdbyon3MpagKwQDmrw5WuvSNcIB1r2LbxSzvCC/ynK3HXQEJ4NwMQy6ngYUSQgtCJ9bF05YKnMpjklEyOcjG+JMwtos9VIBUw68u2V/Y5qgbrlHhtdo3gYeOHjC3uFan4iiD8j77AfEWU9hFajFMHfhnBQj2MT022UQ4XJXXa5ZzZi41fVy6Zh7DTPGCIJQyCuHx8WcvHmWCrQb2F4+hvThn9FSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63oPQ8ci3M75rCTDztYSaccc84JiOTlDxFoKhgn7mZM=;
 b=D6RP9JjV4o5tnXMVCKLxMglqhxeGM3RswOw9Z1yWdHtrRYZ1xH0HQwPgn+C3QMYmEB1qYxs99BjkZrXomj9vpyclfNSdLztIEVb7KzFWSA4171nLS2E3B9jF+oqZgK8gdGxC5g2G+z9m+ws8k+u43co12CZX/wBr/pVdZLtq2qwxjVfd6ZpyNSJhOXK2xqLmCHJl+tGvnNvO2DWf3D8Pp/B/8MBfm5k5KCIDAv7/wE3xyd73upEHhaQbNgXRijeHMWy+0iNDT9JmVhy2e21vX4PgvzkuRJDg9ry94eygE0Ey+eMW2E2Rmo4UzvIt49liP8lChJoCv3Vxz3n9e3u0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63oPQ8ci3M75rCTDztYSaccc84JiOTlDxFoKhgn7mZM=;
 b=v7J4Ck14bbCXBiU21bFNtzVr8OurwG30ZNMXM7f2qGvZMsbfVQd/UuYJYDM7cNQcTebMnQHUvtjW/KaDHobMAPZN8+Z3qAnTmWyl9OgLyImQTrTE/RIMLV2pMYQT/Es8A+3KaPHvX1I9kAqIeiVEfIod0gdSqdB+g9B5bn3qM3I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7949.namprd04.prod.outlook.com (2603:10b6:408:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 02:59:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 02:59:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Topic: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Index: AQHZeX1i8rG2HytVkkq4pAqFsLjcxA==
Date:   Fri, 28 Apr 2023 02:59:02 +0000
Message-ID: <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7949:EE_
x-ms-office365-filtering-correlation-id: 9289a538-6ed2-4138-b90c-08db479485d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwsjLM+6ctV0i+GR3yFYkUolgaL30MhjtuVQRIDyrQShRlZ/15giLe0LavSqVrpy6FecY7cGlNMdT8rN0jVEpCafoxLk+JGhYC+nPyrZuarGv7j6OZ6O/TiOy5ZhCQPznlgEV3dm68G/VKM/gM0lwdfyzwHWJ86HvjSuHSMowTi1g3ISPZesNRIh+b2RpNEwCLA5QEVY8kbTOJ6aEJ0AncaOsqXcLgIKWRcbWhhx8XhGaHGPQqXHLR9LA24Kdo4d0SwssuEyo2L4C0Alg/xuL8CYLpEIUkR3RaSgi96kcfDYxDbvRNnEafDZiXUfYydT3F/bbtrcT5+7l2XGmfVJzfFke5ZmJrqwHp0as25BM24FBesrNKBczgZMPkuGiw1ote72syIa9WGsx5+D02urzLqV+53Z0Q0hsPC7g53AcPy1lB3HUIXZhNuwdwrk8xRTlS0ddH3zvlHgczaTZNfgD/0lki4IutaNVlxmy+OFA888AsudM70aQ5/E55QuFG8a7YlRAHRWsMfpOSXgfaM7lKsMFd5j7OUFMSbPnARidgqRlb3A1KhRxGu0acRVlEOqp6iAAM4DpG/KHHzIurUi8tHJodo0E9VhV+D9fwTSXwmBs8/b906GkUJGW24IIsEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(8936002)(8676002)(44832011)(41300700001)(4326008)(316002)(91956017)(6916009)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(2906002)(54906003)(5660300002)(6486002)(478600001)(71200400001)(6506007)(9686003)(6512007)(26005)(83380400001)(186003)(122000001)(33716001)(38070700005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QZB7VQkZZE5rYqZuOqeHAXUNnnxPLsyH4j9sPxqiGpgJwNaWx2pG7gGw4T27?=
 =?us-ascii?Q?m38FIf+KvpaF46f9aUCuJQV0101R9zNhg2sZPM7JdoxdGOwrv5jKPLA/0G2P?=
 =?us-ascii?Q?08KRRttunaMLDYMVEI0qqCbuBoUxBbyMf1Fl2rpOAhrUzbHej99+0LmyBcvO?=
 =?us-ascii?Q?M/J+Z69hFxQHL0bwNtqew8/nZ/LFqB8mebpv5FcGN7auNFDSwBnBmnJzphXZ?=
 =?us-ascii?Q?WAI2u4RwaxxzT64BlJ1PaKSAX0QiH1yRZ9wBndfQ6BlgRakf9CEMfVcjajac?=
 =?us-ascii?Q?U1Ga8KtCWY6n8Q9Xpf30gW2ZLt98YU3jZ/13ezsQOMYeur3hr3Y/PqykK13V?=
 =?us-ascii?Q?woMGHOcKoGIp/+qDZNRnSDz/us32Ma4WG7+aNbQfzw1Nz3Fc1RmmsrnNljKS?=
 =?us-ascii?Q?Kr+RZBZI4MzjmJNW2AbvBNqytPaYnZUPbKxtQZN0J/xl5bcKpVoZtk/5rCTp?=
 =?us-ascii?Q?veang15LYTVIt2n1CDNEfLfbaLJ/cIzWmMK23ypgiw9yEDUQ5SjqJ8Giqd7B?=
 =?us-ascii?Q?BnqtSsNQWkTlls51IjenZCrF83HS1eHK06+xHNFYfRfPY8wcRuslZ4/VBykT?=
 =?us-ascii?Q?zkkjHVGUIxlp6NM8e0NgHAFR4gVu/OOYBUiZt03yTMmu0MuopUlLPiRbEaLZ?=
 =?us-ascii?Q?xq8DgIUR4rAFx6N+nRCCJovZoGWSoLHPOE9C3Y295pSxzIDzvK4uAQNaXm9y?=
 =?us-ascii?Q?Q8kznHynOTIKTpPGeJ8zzqZBae6qajVYSbSoEeynFJpsdY8DLVJXV1/3z3ky?=
 =?us-ascii?Q?mbrD3iCcOQ21b/0nZj+hcKlkuC0PxsijChcyKm5hK+p+fR4yFLyYuDW+WokD?=
 =?us-ascii?Q?ZMzPtAyQK0mt8lzYnWTXrnhQxCb5lT3XcyZ32xrIKPnMLq3pgj8oJzIoJv39?=
 =?us-ascii?Q?/H+mQOg5JPzdlAYyfBCoXl9dL8ltGBYmScipmTRbHIjyBXRQSRTu5Zltge0i?=
 =?us-ascii?Q?sRtk6J+gfNbOL9QT4Vcm/v/2UkRIXEmv59JBAzDurvRq1VNSAfdOjHI3jzy1?=
 =?us-ascii?Q?Am5Wjs+aEjJawmDIZ9ItK/oifjsXNLYJ40X0hyWgUno9uHzRcWMxtxBcjvfV?=
 =?us-ascii?Q?EFIRi55y+k8eT1q8BM5b+sV3IjoP6w5p33dREN0HXJ0W4Yzxw1OF6k0PX6xK?=
 =?us-ascii?Q?ndqVMxowWG9l2YVf+x05+NfrI63Lszw8RxKJjBOkgvkM+IHx9T8H6zRsELN1?=
 =?us-ascii?Q?xtP8PJLRD5FHRzUVPVH9ZwM+jsmWnoT+bVJATypHLx6FELz2s9gkcJhOKvMM?=
 =?us-ascii?Q?yIC0056kMewhekxAnyiIh71hLE0o++jLFJO5skh11+8pJs3u37eDY5vpA39i?=
 =?us-ascii?Q?e4RFyFn9ROdcYdJBCi6bd93DizZl6CQ9CW5pumHPTpNiEI1Bf6NFonqrtyrg?=
 =?us-ascii?Q?Es1/Ze43LeIt24qQk+62Mw7CebJIw4Jvh9Stl0vgQIfMlhXucGqKQiGYD4w5?=
 =?us-ascii?Q?wEdWnOFLZSB/6kVaJI+CHBL/9MbhQTzZvVbXKOjsLCRRuDf2OJiUqxouQtad?=
 =?us-ascii?Q?g7mj7mSCDXMq28eJdNJ5NrTzDltKFEOI5eERHxNTiQyVmuQdzNHjL7/i8PpZ?=
 =?us-ascii?Q?2dJntbmZMLnUmR9fTQI6AaOo9znYgPqZxxuhzuWrgJm3IpcOIB73AWVUN1gE?=
 =?us-ascii?Q?fpCBxlWOCFuHgEf/klmBKG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B966ED1A4E698D40B54CA8DC8853AA46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IyfeStA59d1HgX1z+5SnFtxIoy1Yl5STVDsZ8Lv1olAdvJDLaVzuccHZmMZZ+MmwjqrRal7449D3lVNpyzVPPO1wUEDmXXXjbWHLTX96ufkfGzson/A14By6r5CK8pNPpYkQe1EzU7AnIzSz+bB8+1r7suegugw0joLUNKKyMpBu5NoHsSeIDmUhCNGU6UudXFNea2R148PYWo/TepkOo03qCcFERdTPWepSxkSVKkgngxtYk3ryXff7CmVk9n93rqjTKdbmojSz8P2rA0FXYOqYjJ2lWDPzQYdtDSycPa6J2CHLTWqDorF3ZZ4fNJtmqojkxAJUDfFceeLuyKh+NRgCzTriUbSMnj14S9d36zw4bPisMWTO/U4PvQWj68R8qhp34X833fq4FN+HSNloOEdthr8exb/UW5HvOHX6IJOWVnT05PcgQQLnjLhx+YL4v9Gpq+z1GKVfsRGQ9A5UMprOXzrNhT5rN0++lZmtdMcRirhUmlcYLklKLrpHPQz/CdwHhAsRwX2JPymh1JtEWX5NCBbplObqePfHcO70okUY1kNavSCNqENaFJrL6V/P5JCMledTiXjGiisCMdASR1L+9HAJfytIvDzr119XQ6V3Qy13fmFXpDqxysQZdgXuSU/raUgsUJ0KfKZfvirWzDukYw/ViTbtTJKhoUEArYMilA3ovT4u3/46RlW1sRePvWlTdw1jIxL9qsPSbIapnAgxhrk8ZIxbcdlWSBW3gSR6Ki5ZHPfgn2+h+OlhxbXIDfLrPYX6AyVREae3dIkNb/XlBDLiu0wJbJH1W6da+pVS6GbR3alxSME9P46NyNqHxW8B4y89urpFIo3ZUTGX9GTwIenWzroPQNVXTtJuMoAnO8Vk53vsiax+nSAeMfQEJxL00q1t7awQN6G0pJuu0Ogh4BZ5plRIqdrCRrTHlpw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9289a538-6ed2-4138-b90c-08db479485d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 02:59:02.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLH8wZVwZqwP1u2DxjfAwujvEu4qgNUU0IPREv4uPAx0MrjMe3nxIWe+med8CZMJlkNT2VIJAt2SImEApRxWAa20etFB99VXUC9Gb6FaM3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7949
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:04, Daniel Wagner wrote:
> Make the size argument optional by reading the filesystem info. The
> caller doesn't have to guess (or calculate) how big the max IO size.
> The log data structure of XFS is reducing the capacity.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  common/xfs     | 6 ++++++
>  tests/nvme/012 | 2 +-
>  tests/nvme/013 | 2 +-
>  tests/nvme/035 | 2 +-
>  4 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/common/xfs b/common/xfs
> index 2c5d96164ac1..ec35599e017b 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
> =20
>  	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> =20
> +	if [[ -z "${sz}" ]]; then
> +		local avail
> +		avail=3D"$(df --output=3Davail "${mount_dir}" | awk 'NR=3D=3D2 {print =
$1}')"
> +		sz=3D"$(printf "%d" $((avail / 1024 - 1 )))m"
> +	fi
> +
>  	_run_fio_verify_io --size=3D"$sz" --directory=3D"${mount_dir}/"
> =20
>  	umount "${mount_dir}" >> "${FULL}" 2>&1
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index e60082c2e751..c9d24388306d 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -44,7 +44,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 9d60a7df4577..265b6968fd34 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -41,7 +41,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
>

As for nvme/012 and nvme/013, I observed the I/O size changes from 900m to =
920m
with this patch. This condition looks better for testing point of view. Goo=
d.

> diff --git a/tests/nvme/035 b/tests/nvme/035
> index eb1024edddbf..8b485bc8e682 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -32,7 +32,7 @@ test_device() {
>  	port=3D$(_nvmet_passthru_target_setup "${subsys}")
>  	nsdev=3D$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> =20
> -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> +	_xfs_run_fio_verify_io "${nsdev}"

On the other hand, this change for nvme/035 does not look good. It runs the
test on TEST_DEV, which may take very long time without TIMEOUT config.

> =20
>  	_nvme_disconnect_subsys "${subsys}"
>  	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
> --=20
> 2.40.0
> =
