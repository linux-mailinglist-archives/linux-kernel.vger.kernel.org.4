Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B666F9C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjEGW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGW4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:56:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9714A131;
        Sun,  7 May 2023 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683500194; x=1715036194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=36G/LgQ6uqebz6+VfxKI1dcSjp+hkdz7iN8cPyyIbFk=;
  b=d0ZyToYmN4hbaXROU2sS9wVQUoctPiqT0Lmizj9454bMnDQJYN6w44jX
   wJzepx0xlRF24/aliZTM7UqGKoaRe1I7WmxYqQhSZQz3gJ/mT+jyJ3OPz
   GEU5oLUsiegvPjcvBL4w4hUjji24zEYp6I3UIY7B045AxhepoSFTJ+5a4
   wmtXXqSiHVsV8Li9sKTmgCk78+bA7PbCzKeIHj3oBxVIsH383QnT3Jzgf
   QRqkIOtjs77cW1Iyinw+QBt+/T7v+vYfXUibYxlocKlvGACvz/KHDeqSo
   tZc/rHvT3WrDJtZFVasi3l5K1Mw0P85wsxAhcUI07cSzk/N/9v4p8vJ97
   w==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="342148049"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 06:56:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiK/c6E4Bc5GtGkpgIkRpLzGbcVwwS1uetDFyG6U+PNqwimxr6DgTw6/Wduo7cQ3XlqElw+UH3zUO/qaTyr9QB82qU45SetgNceNv3AaR7CEPov4ifsR1MWvvt7U8MsHhpUeWXpX64p1j5Lk+BnvrpxmSy9/Mv32rR0F6Rr7llpfrzU3Ee6eOuX31OmRZymSc0dcg+1hvK/jWLaV2KNkPM6u61IJmH+bqej1todnO4IdB6FLsuxGrxKZ52NYc3prP/98hKqq0n5j4LrZzqemSCqRwTc2k2T8v0RT1qEMJpOdMqd2azkgX4IhXaGdIL6glV1qOuuhPRmkGxwD3VTOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTaU+jlMImpecfT1iE4rFly2KqXsfhXFTacE3nMyjL8=;
 b=Lgsl/OHZ+twdrhQMkRNdnxyJcn2UGnGnRcBHPKW0E4Kxn/vRVfNixLMbX4+82mljnp+S31DfI+2+7aNIs43qoJREOzPBeK0eEMHVeih7et66iO5l5mmmeHyj3zmclteR0RxMFEQLluwBmDUWifV96JW4rqJXfzfZ58i+qriyFot5YSdOpORIY3RoPh7L/cumnKqtSCvuqGFwJ6s2W+KFtxpK4kECNx+lPNVKOSQhENeXntO3FMey7WQAapnscAJqMrfUVIQqH1DMxzAVrU2jPVl0EIowSh9CVHwVKfYG7mjaLRCgezr2zw6BOPrEjiwJpv6JvAI8FI9meDggRt0WIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTaU+jlMImpecfT1iE4rFly2KqXsfhXFTacE3nMyjL8=;
 b=UbI1KJeydmiHyTf06+NKaXciTiNf+BaqE3hRLxDKCTKhYsGY8aV1RzJtlb2Iz0NJLEMzGWMJFUkY0VBTCIcUBTcB82WI2tHw6VXkGNIP9X8z/2CJyIj+GJzEX4/CJJuoPIkxfJZ9BgTNWChpQZ6UEwHyW3hfOarlQetOV4g58fA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB7068.namprd04.prod.outlook.com (2603:10b6:5:244::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 22:56:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 22:56:31 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 05/12] nvme: Use runtime fio background jobs
Thread-Topic: [PATCH blktests v3 05/12] nvme: Use runtime fio background jobs
Thread-Index: AQHZgTcpBaWOIz93fkSAayVQIvsI1A==
Date:   Sun, 7 May 2023 22:56:31 +0000
Message-ID: <ka6mem7j3psreez3ey3auyupelicekyaxj3mttofdjf43o34oq@fzqe3arzbbl2>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-6-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB7068:EE_
x-ms-office365-filtering-correlation-id: cb83be37-0399-4bcc-dd23-08db4f4e4c88
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KucSt4sxicJnNsn1CmxYAB3mnH7nNtZhKDklYtTT1U/iBzIk/A87TJpqvtMmtgynCH8w7gNsLEF27mz91ONcs/bEX3IKUZ8DiWvmTEjqZrf1LRdMrbuXKWGrYwkkCFIevtv+b7k+wEiK11nha2oaahOJ2oE082d7Rl7+8bo2PLWwjd5hD7ApWyZbUS4xpXgB1jmHXbak/y+of+GhGWjM0bM/S2TUhChxoVv9Xz95PCvOxDTEZctfSfYsGfr6B1OBNs3H1xB0zX84H5MutYOZCpluYuYm3KDHAcX+g69NerL08Ig2xGonWF7193f3X8JtNvS45tT5L8noOdSrifrxHG3xC/SSf0jkaa35vU4/RuGl0gH+qr7k/Tcyv4ics+IuFs/ZUnfYJ6LGTgl1Dwuk2fVDfXFhYA/hrpDV1i++QS/j+cZWu5or+7SO2sQoSCpYEc/OFH1FPsMeFp5YXiM9o+/XHg0y5IsivatUGT2BLB+HAV9MyDr33N8+DbjVLZjWR/ZXhMvjyM0qRCPvDaDQNHv6zKyUbia+EqRjIbWyQ6Zq5ARn6+08Rk+Ov8FVbouqPlQxR9gNyMRIPO3rwZeXQVPWujMgl3isXs4fzDSCiTuR839+1yhCjuWCF4ln3hXx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(33716001)(82960400001)(186003)(478600001)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(91956017)(44832011)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9eYi1SvVGzMnyryUCPGa4HvtfW6K4KRDQWY1ACJdhJAABJqSBbogCqvgWkXR?=
 =?us-ascii?Q?ui1hRIqC970kXQrCmkpqbZ+T9XH2juDK2gC8W6loiw6MBu03FJbTJGnI2Nfb?=
 =?us-ascii?Q?Cu+sNb2k3J5vmiYPk1noUgqWbhWiTnwhF4YyfjO+K2YHykIYA89FEG8EEt64?=
 =?us-ascii?Q?9Ae/wTPiOABKGMYuo/u8Lofg7S4f+9pnnR3LOEtZeGv81JN4yvItCw9EhAmO?=
 =?us-ascii?Q?0zXLjmfOAGbaaGuBBwxaW/9wg7E4r2tjBSqEj9gZDYqfIyHm1jw2n742Y6UN?=
 =?us-ascii?Q?Wa4izWXvKER1QWgXkItotbJwY3ao9PpnhRGiig7cpno5Qb1Ixp+CpdlqrpMz?=
 =?us-ascii?Q?3ro0dPTkfKG3vsyUaaVH9fi0LdcmHn7adhcdfUZSP71sL6UgE36it2vn8mjC?=
 =?us-ascii?Q?Prmi/QyJB5Z+wqpD8or6fDh+vHih2GTBUT6NbJSxM0S9AAD1ybXhXv28eadK?=
 =?us-ascii?Q?AEOIoviVYwoylH8WuD9xkQworO5v5GmPq6H8Cc0bfMPhdmaFpYY4u6FrcTyw?=
 =?us-ascii?Q?6RSJChpmXypyne0U6xRdlFbZjXT9tZZKu0HBBKZ6sHCYgf/bXXf97Zn0MgbW?=
 =?us-ascii?Q?0MwnXozEMLAsahjhLSs9bomylRSTXlMS3hDHGAB/b+iCdanK8BPne9CzHIRf?=
 =?us-ascii?Q?ig62GQlIrWNLBLKhlpCVQXIBH6HAfe2LqArvjCNiQSchsDHG9OizwNNwG0Eu?=
 =?us-ascii?Q?RGxZC2uVesr9HMuoMC0x8IdXt4hMxYfN3CN/eZlVZOrFCbnmsLegOV1hj9KE?=
 =?us-ascii?Q?aNu8fW0Vk4jX0RLxWaTu8jySs8P74wYvK/uMBEsGGN+4Aks70E05f4iDTgQt?=
 =?us-ascii?Q?N0rICquFGzXN+6bL4HFo7ZA+xb6OMUUV8V4GDX7yoaCmkXbZ6PuNnCZnn7Xj?=
 =?us-ascii?Q?eYqjfvxjmPLI6EwKPdifr8wMtfFG3wTAMr93nfTXYytZjUeukpJhAh8K6TIU?=
 =?us-ascii?Q?FmMgmL1tuGkQr3/1rAXpNpfBemO6qIP/hd/5JPW7oExJh6UuzetnTtZDfjZK?=
 =?us-ascii?Q?kBKwNTveGyd8zFABRZ2RTUC2/uBpc0AgHutygI7prH4hQMXsNdRb6yGjaaib?=
 =?us-ascii?Q?2h+AX990vOHy/pz3ZQ96pH4INCiJ/wvj2i+BurCh3c3n9d5qwIflmvg16hES?=
 =?us-ascii?Q?b5LkA5bBOcBbeJCuu569ll3VSetnW+JR0NhAruqgKD3/N3TH+OSM0cRMKV1t?=
 =?us-ascii?Q?7DxparVqAzpxWTyvmbGrRptDWWLv620OZRhYJ+vZ7uQfVX/aphhMc3KDBZEL?=
 =?us-ascii?Q?jO0yF5P7E3zSsXbXjgPqA8zVvu5+Bbyn4FyyT3GOU9CwTUagJkCIG3mT8QOy?=
 =?us-ascii?Q?d9DeFIDcP91leaBdUCCF5jmlavOj0fI68An3GQS2Dmc2TBPV8+FaCKuqbpLw?=
 =?us-ascii?Q?ubJSRmhgiJcghVa5kfsfEiiuwKSg1YY4OzgVoP+pi9ze8nE0n9UjTC4IlFzV?=
 =?us-ascii?Q?rW4mDGuKGinfTVbsSR585d+rTC4vi/wneDp1EeUqVMligcTdw7SyvBGyr9PA?=
 =?us-ascii?Q?nMqh54r5g44o7ZfitPt6xV/KSmaL81q00OITIcAfk3F9VICk5XyaTIk5ZJZJ?=
 =?us-ascii?Q?13It0xHLspOjhlDfWHSJDzaH7E/S14ws1TUOBTxgzDDtPrF22R4WGuJhG35K?=
 =?us-ascii?Q?gsKT4KuK6XkV1vEGMsnDmps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F00702BCDEC4DB438CD6B18107D3DBCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4lELx83hLV61hWacirL4kvolkh+EVOGw2NZOdlohX4ygmQGHWOqcES63Ia69B6cdqQwAE2mmlnIGpdoWyCgvdPRgnxTVBl3jfq0pJoRJZ4dO7sHWi0o+bm38pXX+UPN9vpSKpoHdHRCUaJsrvYyXJJb1fLeA0EiDJt+eynyYjkALu5Kj8QaB4ySVJWV8cJTeWeMDOR9KmirfjkTRgI69dA78cCYEacuDukdzNY4cz3hXNd21GjUbXxovcMeQwJTW77JWAWJrzy71r9y6cRBA4rPAsvhd0Y5iCteURbUDPxUNgkkl/q/zF/du2A2jD3WXLlZ0dAClGjT3DQY0/jhWusT59W0YWQzmNaInU5ZduBtjJnssoayfn+K988YQ8B7zXGVSbm5x+LXohkEw9eLprPc24pFloYL8dsWOAmLGavWGb/nYscwYGDdLlqOlvD16c3LuDgRQuL1w0dMOM4AkrvM5zcsL8c4W+VCRmYCTPwAOHtWM1Gr6WJEUTMsR/k+PdLcrr2tSxlqF1MnZ6p+C4t9l5uAogixV/5+ABVHaIvpK1QYK4/9VzsP2ReeVnGCnrXRAi1Qs9AX2D+c13ULhWfq+xOFcx7AQyiKiovRDDHCTx7MTnDK17SOYYmUNsNyh1v1cG2gBwankXH6tNM/HmtNDBLQOSVayc3Puq+AhFovwOYd/jz8Z/QR1kiT7A+dCiSzWgSKf3USDQsNBg3vkhCB5Amc0wwXtknWOZow2wOnDxM3j6ZO9tUsJeBAr1eMooEAliz6TglsuuEcQpJ+R/9tsnZDnvyeAnbVFuUjulq6MTBDTdbwLsG6khLACaICXCgTb25my8+yZUqaOXhpXja/IhAlPxKalnoTDvj+I9ZJ7sUKhdAX9wxx64A7W2tvjq1YI9bV62kLE4PsMAiZeizanME7SV775qw02spKCGYA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83be37-0399-4bcc-dd23-08db4f4e4c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 22:56:31.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3UnrR9AiJIQdL/C9UgZc9NFJgYf/gMeD8Sp4q3k79bt3qtUHAfMCMUgY0XnGgtnpVPSzriT9OP9D5X2ggHYkeJ/sPSNMWHBlInAPztj4gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7068
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> The fio jobs are supposed to run long in background during the test.
> Instead relying on a job size use explicit runtime for this.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/032 | 4 ++--
>  tests/nvme/040 | 9 +++++++--

Nit: I suggest "nvme/{032,040}" as the commit title prefix.

>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 017d4a339971..2e4b7f0760c7 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -38,8 +38,8 @@ test_device() {
>  	sysfs=3D"/sys/bus/pci/devices/${pdev}"
> =20
>  	# start fio job
> -	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D1g \
> -		--group_reporting  &> /dev/null &
> +	_run_fio_rand_io --filename=3D"$TEST_DEV" \
> +		--group_reporting --time_based --runtime=3D-1 &> /dev/null &

Nit: I checked fio man page, and did not find meaning of negative value for=
 the
--runtime option. I also checked fio code, it looks that -1 is handled as
ULONG_MAX by type cast from singed long long to unsigned long long. Assumin=
g
such negative values for the options are not well defined, --runtime=3D1d o=
r
--runtime=3D365d would be the better to mean 'infinite runtime'.

> =20
>  	sleep 5
> =20
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index 04bd726cd309..05b4f5472ef5 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -21,6 +21,7 @@ test() {
>  	local port
>  	local loop_dev
>  	local nvmedev
> +	local fio_pid
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> @@ -37,8 +38,10 @@ test() {
> =20
>  	# start fio job
>  	echo "starting background fio"
> -	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D1g \
> -		--group_reporting --ramp_time=3D5  &> /dev/null &
> +	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" \
> +		--group_reporting --ramp_time=3D5 \
> +		--time_based --runtime=3D-1 &> /dev/null &

Same as above.

> +	fio_pid=3D$!
>  	sleep 5
> =20
>  	# do reset/remove operation
> @@ -48,6 +51,8 @@ test() {
>  	echo "deleting controller"
>  	_nvme_delete_ctrl "${nvmedev}"
> =20
> +	{ kill "${fio_pid}"; wait; } &> /dev/null
> +
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
>  	_remove_nvmet_subsystem "${subsys}"
>  	_remove_nvmet_port "${port}"
> --=20
> 2.40.0
> =
