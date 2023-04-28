Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AE6F1076
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjD1Cj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjD1CjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:39:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AC26A6;
        Thu, 27 Apr 2023 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682649563; x=1714185563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j+4PyECKRjUOvEw8PVFkJ5FKrEWq0GsW5WjltHz0FTw=;
  b=GMShfBIMnRH6rU3JINGJD75wfjBVtQeLHKt71jAwEj2+mOV8xu+Y0FjR
   bUCv9P5wPUm0azD7JlVsEO/6h+F4/8dQfg5NTY/CJtQS+PPBI2K+9YpKb
   IglXd+ocJanm5+IQGBw2i00j+HsTZc5nJCvrt38waaOM0AmeC/kYTtju5
   hHyS2Sw5qeVglMrKG2J+yroyoepM1HSgOB8XDD8MR+nO3hlCuYk3Pdf3j
   wcFICEkTOGDEfpKlq5He5hk7QadroVMZ/eva2uQuqjddx7+ZkUxtU8m2V
   mVujuUBlVuiROhNKWHr/iJ1jNfM7OrLryYtUS+/bOdVVcg9pcs4ishgt5
   A==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="341509067"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 10:39:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsJ1fEG3heFzv67excy4X/DZmFt+q/GlmdlP9J1Zev3qqp3WLvPXv2T7IpNp5I/yOhmfz5MtWaMunISlybB3C2zcyMLliMFIIxc7PSDJePESz8N5Bug9X9zYERY5qUOEUel7k2jdZNoOcFaC2qaB4Yzv3g2E0Gpy5IKpTKPQaHaHqsreOm5qdTcMwHmC2P34J3KxgSjRx4MMOsyrhIC202bW+Jze+vob1pZlTmyBmWYxEFwoggCS54JLUqtqMb9Hl9LzdyQvqD5PSZ6Tuzp85sn6y0z+mvRBOY13NA1HXVeD/4ihknIg2w6XphVzyEWovHCyew8iJx8GWxPk2hL7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6MOzrHBj+6zXknsGl1WhY93PPzHB9lUZXXNk2RlGxQ=;
 b=RK06eHDtHMXZYIefYtoSNk2ET41Mhvw/1pQt+DTVoJFY4HEk60ZfrxTos80KGrdsm74xx60zIg2YWgkEseHpbB1wLi1B8hD/BbdJoiV8Yz3Ksflx6dOhAlywwYsaEX5+Bh0w+7cUhkmD6wC57qbTZzbB26yWVFdXZsKOGWh5Cu9NZXmQSsDsxLG5TqzhMUiw1mbrwpjNBu94fVeDdxtn6hoWZS6Ix2Og4VJ+971ihg0KAoAvu5LGY+V0v83WHB4DcrXMfpg0HIo5H6wg5gUis4tIk9ui558s5a3FT7GwDYgjVHjuLd49tMPdA8hmv9vuD2ElGk0ZXV8rVXnl8e3gVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6MOzrHBj+6zXknsGl1WhY93PPzHB9lUZXXNk2RlGxQ=;
 b=fKs17G0LeIHRyFd8rPFyaAyR+tKO9UQgdstMcN4VefX53TPsxLqytUzci0sSuHPICenENzsPKlnDR4duSzD8+rfSVJwBETj0i3lkTwjo8i9DM7MlTKe6HeanuDJSLY8F4UuUK/yddSrjkwAJfGEShP8P+iEyIdaQD+j31NoUjzA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7249.namprd04.prod.outlook.com (2603:10b6:303:78::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 02:39:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 02:39:19 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 1/9] nvme-rc: Auto convert test device
 size info
Thread-Topic: [PATCH REPOST blktests v2 1/9] nvme-rc: Auto convert test device
 size info
Thread-Index: AQHZeXqhST9UKxztu0+ifyt72RDzlQ==
Date:   Fri, 28 Apr 2023 02:39:19 +0000
Message-ID: <v6uhud65uqyuoeerp2ncqurvo47ret6zotk4lyj2zeqke6nn5k@2y3xhfa7huf4>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-2-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: eddeb794-d025-482d-f311-08db4791c4b3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3TAtj+BIMl9m+asSELwznUoiUfTZXptObXby7LY+DDr8Y0cRlYDTHe8xscji5mbs49il1sK36QtYltSg93PkU3jr7XcXgCsfLlNIdYMCNE9InHKhrvZJgjiWyqadC86PQ5u+IPlhuzd9gnDwjViUPTem+FVBGOGF2OkQxxMmUWJOAWYiWJw2nIxM+yQ5wp7r6MNcAgeaK0ZcpXUzFndMmhX8pjlfQBRnisbUdEU27tCL4m4k2Iy2rNLZrf77Y/P7G+5TcLy5BjxnIFSp/IADqXFKl3SLp2JA1F9hM9sbn5WLbfm7llzUIVjp6AWtGBSf9NzfAWMEv/zY7Hn5WMd88xWzpo/nEy/aYmxRM/alYkpguvXUjQnHLsTcDkI2eYHAqr0g+Nt6o0HAhYbtsJeFv8G50gI3CuEAbTJQNRLTqv7yR31X/rvzj2fqnekQ+fIaJfvdDyixCVN9ShrpG1g54S9ifWisWM9Lb1zNA4kWc3eE1fFvp2blljYIr6Oeh4mp/hc1RgGSlfBdn17997/nQlso+U6bsl8k6jwf4fBOfqD/7VO6CtnB5dSmu4icOwXl6lja6nuCQEespj4s0H/JIuCy66HjvZ8cyG1kjWWg/XB4k9+Gstu/PSTXnKxl9N8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(83380400001)(38100700002)(38070700005)(82960400001)(86362001)(122000001)(33716001)(54906003)(66946007)(76116006)(91956017)(71200400001)(6486002)(478600001)(66556008)(66446008)(8936002)(5660300002)(44832011)(8676002)(2906002)(4326008)(6916009)(66476007)(316002)(64756008)(41300700001)(6512007)(6506007)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5wqChIK/GPOETECj/gjb1kqwAAWs0Uaucs7aJsVJyOPkVZC8AlT49RbgYF6?=
 =?us-ascii?Q?XUBDWudYl6UQ0sZCPsTvyfbzMps+fmQkMc3L7f5JiI65hDfz2xsaptA/Jje1?=
 =?us-ascii?Q?GeWumvhUZHkIi3vZh9gtK05+hx9jpDe+aEmyM/EnCaJhMJCPpZx33HMbkllo?=
 =?us-ascii?Q?+sB8k0wfrugj7XTDosMshNgdFZjRY3KCYSyYFSzd3LLUTg8z7cmrOd23UUxG?=
 =?us-ascii?Q?n846aROYVogUIVwnyDtXkXFpPZf6dcvCWR/GrP6sZVPeQJ8F4iCcYE1gckzu?=
 =?us-ascii?Q?GNzy2J49NYiDgfL1p9nY7R6+uo6Qtazeqv/eNg4JfymF+q55B5/coHqh2Air?=
 =?us-ascii?Q?ZsrGS9xcGLB48NY1x7PTihDmp0YlTaeKbwYE/Q8RxqHwf400/5JBL6AC17nB?=
 =?us-ascii?Q?shqwsohCCHpInkjwwxgNzZkIKJNvB5SBTRJfC+PcUqqdo4wWDqNb/eWUA5Uk?=
 =?us-ascii?Q?LtN/Q+IF9NpmiHJ7oMH5GUpnRN3oD/9wo3z2m5HADmtFSoa2AcWUQt3+bL/J?=
 =?us-ascii?Q?PhE+Ij4c2oRbygfHLBfwtwC0IFclIa00xhDR/ln2YOxxA5r3qTnrA1PkjKLE?=
 =?us-ascii?Q?otx5B0A0FA78huN4u7GjM01PIFwrtw0fgx7ApgDhV9VoaXbYEJUG1YhY0gM/?=
 =?us-ascii?Q?BpxwDuq5MNCMae1iX9rMtCt8DoenNeHBbeSK48Mzg5vUsbfjdBZSX6kG0Lg0?=
 =?us-ascii?Q?8dV9CEEVbe2WRHzQdngFaQnfe48ea8D8ulq9MCbdjPFZySyiflInQMW6Kgjd?=
 =?us-ascii?Q?0AW1jNMU3zB57qKU4qFusrCjqNdzZjnTlbdR9klZoIFAmckHe3m1EofXDK3x?=
 =?us-ascii?Q?c3ZZaQqoOv+A9CQ10WtC8UlSN3EzWbzAiop7MFH1uTqG/0EJKTQ7bXDZIx7p?=
 =?us-ascii?Q?VWUBPGhpFr+WRcLyxkAA7DqTYLKa6OKzwvfEX1F//t/pOYPlqoqNSoN/UEHG?=
 =?us-ascii?Q?Wz5RaBqKCSoTNt23KLJZ8OtfuPdDWsWkWmmLg4WN30ozsoZn69KfWipkOnhN?=
 =?us-ascii?Q?S4USmwfCeaCxmoE2XPuUKDK9k/LojN+41kkKISX3PmOELyo6B2mF5NRe8XnM?=
 =?us-ascii?Q?z5oI2DO1gtj3RYWi+d6jpp3G2trhcxR/xpKVWfaWJzjrM48jJ3B1m1uUMGqL?=
 =?us-ascii?Q?vYP8/aO/M8wCH5V1PWRAokTCBD6dUXycU5Ho4YNdlNZiZYOMoIhpqUeRaVZi?=
 =?us-ascii?Q?sqB8WItyOVQXzxgoyx6BN2Cc/ut2jjO/vUmIShm2BekqtfSJeDkqGmbPH4O+?=
 =?us-ascii?Q?GLCsSgIVFwIXM4rblGB2cqe+eqb7yVlg62Ad0Fu7KUIcbm/ZHyq6tbnZydsk?=
 =?us-ascii?Q?iWd8MxE3iqPvEpRpOCxHzIVwZkctBCiZXu4t6JBOaXdGZYBjKjec4tx2ZmdO?=
 =?us-ascii?Q?EClrh6K+SNsyYZK8kQ2K4CWgDGIhXJmbKHEY33SFi3UCb5xgfnNMJFBoFz/6?=
 =?us-ascii?Q?mYC4EL70lp74+UatHbkiFgUz6xU2/oqqY6tYwB+RZ6oLRLVZoeZQ3veHUgqC?=
 =?us-ascii?Q?MMMiiAJHd8QDRYrnOT7qiWubh3XL+IC6IrSTHKV3vyOQk08aUuKgdbSArpsm?=
 =?us-ascii?Q?CeAfFz45IMOlIvsA7dNtoNr1fFpIhzLbZzPL6JISKPONwbulVxECN8L01EXU?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49931FFD9109864A98CFE3C198B504D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wbNClEBFu2fdxigDvN8QM54uVrBM+dfh1XFmzKKhPilVbyrCGL7Wmn093Ix8hJrzgKB+YYysvcRYeX0+Bx9zaQoeY7H4iqLUtjKa9Z5RgTDv6arMh/vh36HdmHD1uvY69FNj3naJAG8927m7Tosf44VwP8xv6Mim42bfC+V7YjPrLu2logTLSH8mojPTsJw5VO6PCRktlQ4AjZeGQOolCgRc/VSvTmT5fnHqL2Ygs9C8uD+RWf/EWi+52KIl83AcHf+AeGUNmOTVRzz6zPFlJPy9rfvQvC3xanKso4hakdlPuW9nueWzcjXChu/wOhQuWfR7RdMEt6h5DfpYOFmgV4aDcWIgUv4bpVV45gAES7WK6CAKZQYZqIzdVX7SA1iDNvSqfRI/AQs72VCBi5jR3OUioJvBOh0+qK9vZt21x1LMPA0PJz6D0SPd0JlV3xkae35K3lvHe1qKs4PGAbYXWFrVd/vAzEREcfYcDzYwsBu8/x4sRdWHcCPOocJjw8PPfHD3AZ6LwW7ufsu1LtZvCK55raADtGreQhZp4Ug8ZW19TpRin/PeHC8YJLTgtu6mdjGJQ96Afs/kRsgKDH7F2m6FafKSDCrFQgb4nV44+0TPqETbSj/6DopM0Y0IGNWSaeer+s0TYVD0MmwtwkaoGCbVG+CIqHoBH4gszYXo5OGaoEsW8Ae6tFahCNk1/j9gT+BL8kCToGXrefVkR5X0vBoqERnEt8MCS86ULTU4vV8v+ZLZH3P71eaS5H1WJfHAihUt9Qw3r9f0yd8KPzGOVW5O93RxRXGXgT2HaUzvE+Wq98lYkQyKyrScI+DTWx0Jov/qAHUZAvrBQ+kyA7Ho4eGAakTLQl2VBj9ptcWDknMK1uNeRr53JkEkyVLTeV0msLKr3X9qtH7RSc/41qlESZdkStSf+sfP4DvS98Cwfzw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddeb794-d025-482d-f311-08db4791c4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 02:39:19.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye3YcpzDclIy8rZFQKHmBhwNVHlppT0tfVnIT0OXvrX+wpJqjZu7hDReBx9fb7pK8D+9lkqD7gyRqhK0cBVOiHwLkNIyz3Q0kZ1g92uvCng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7249
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch looks good to me. One nit in the commit title is the prefix
"nvme-rc" which is new. How about "nvme" or "nvme/rc"?

Please find one more nit comment in line.

On Apr 21, 2023 / 08:04, Daniel Wagner wrote:
> Introduce a convert_to_mb() helper which converts the size argument
> to MBytes and use in test device require function. This makes it
> possible to use user input strings in future.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  common/rc      | 30 +++++++++++++++++++++++++++---
>  tests/nvme/035 |  2 +-
>  2 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index af4c0b1cab22..dd0afda3d821 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -324,9 +324,12 @@ _get_pci_parent_from_blkdev() {
>  		tail -2 | head -1
>  }
> =20
> -_require_test_dev_size_mb() {
> -	local require_sz_mb=3D$1
> -	local test_dev_sz_mb=3D$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024=
))
> +_require_test_dev_size() {
> +	local require_sz_mb
> +	local test_dev_sz_mb
> +
> +	require_sz_mb=3D"$(convert_to_mb "$1")"
> +	test_dev_sz_mb=3D"$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))"
> =20
>  	if (( "$test_dev_sz_mb" < "$require_sz_mb" )); then
>  		SKIP_REASONS+=3D("${TEST_DEV} required at least ${require_sz_mb}m")
> @@ -422,3 +425,24 @@ _have_writeable_kmsg() {
>  _run_user() {
>  	su "$NORMAL_USER" -c "$1"
>  }
> +
> +convert_to_mb()
> +{
> +    local str=3D$1
> +    local res
> +
> +    res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)$/\1/p')
> +    if [[ -n "${res}" ]]; then
> +        echo "$((res / 1024 / 1024))"
> +    fi
> +
> +    res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)[mM]$/\1/p')
> +    if [[ -n "${res}" ]]; then
> +        echo "$((res))"
> +    fi
> +
> +    res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)[gG]$/\1/p')
> +    if [[ -n "${res}" ]]; then
> +        echo "$((res * 1024))"
> +    fi
> +}

Nit: this function uses not tabs but spaces for indent.

> diff --git a/tests/nvme/035 b/tests/nvme/035
> index d169e351e3d0..eb1024edddbf 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -17,7 +17,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_require_test_dev_size_mb 1024
> +	_require_test_dev_size 1024m
>  }
> =20
>  test_device() {
> --=20
> 2.40.0
> =
