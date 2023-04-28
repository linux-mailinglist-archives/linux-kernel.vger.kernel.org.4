Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1803B6F107F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjD1Coz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjD1Cov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:44:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588E26A6;
        Thu, 27 Apr 2023 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682649889; x=1714185889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=clet2xTYEDpvlTUG2zPKaT9zUsdpv2vHUkSz9vAXSts=;
  b=piDnszNFw74OfuReTlvSXU6GkKhdC+Itx8cqFOY6AfVFXnYlL4ZSLcbI
   NUPwuVWWmOhGL2du8ARptCLNqRs7vFKs5syFlHp5AyK9xDwMsftwzchj9
   3mjHdG9IpfjTg126b+iAyuyJLkc1bmmJLjz9i5jYOwJ5E/CcAlv59mwWj
   mMKo104SpFkL7IqPm6Qd4UZ3kDENpi19LRRP6s2qU6NlZB8aDp7ZpkuVn
   FaWR+EzW6UNF7VD7UTsIOHX3MR12ldUUapHmMGewccvr/qdQJeWdhxDga
   wpaD+dXYGgRIwU2Wt3w8LRhYnCHpvKDUvgunkmgEQeUQZ/qZPfpON5qWZ
   g==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="333891764"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 10:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ8ZWdT5drhxzn5OEk/hRneSGSpkqtvTsJFkBjWjmDTTWtpYAumOpD+Fpr+VQb6MITMHlixF+kEDZseRsSXDsmZZOzFJgDH8oVQzuiDltxOFq6ZwAWU6pxqpJkmwbJS+Y1kCYwROVZE86AVQ9e+XSCBVvNfJLD6WcmNDplvMryij6OBcImwwOkYQjsXV6gXcNuMm86nJnx2DclMhiZaM4SnxSImJKdcM4dFWhynjTerqsLFhJ6/JdbQubGiEdJ21M199o7RogIiDua/RfzX3fXZvzrrVSRe3u+KYv67pczfiRjeBc9nG8fqoDakoXkyjjQlSCnK05JI8pPZZoLRrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8TruTWn7wBMfmy2nRjrUdsmOOvbotIXQp7OI6aoFQI=;
 b=V+Ok53aBglWLkPuvtaBJXBfQ80LJ9tt/Qn/Ie9Xvyaq9RAFsBGe+pDs/Mqu8TWFNQGqh21GSAlRQG2qwBtnZ/07ZgrJSaQKuyb5yHjCpKMmEXIKfZXyE/QV7WbZsdWcXKCBDfFs4qzovaswaPj/+thEkE0O3rqIW8++NsFu69uCKXTDdJOaQ+q5TmweYWG3EFgtiKQqTG+81qBe6Ec/zncw4DdSKUo6ee0Tsp4gOua47HL6dr5DVPWHCi9N1P/TOEq6xMa8Jx8sGA6XYFn3t4mHPg9HjzNcz7t8hpaWKFynHTO1yLQtQH0SNYO4Ol9O2JXCte+UhLvtwtqX7HEpgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8TruTWn7wBMfmy2nRjrUdsmOOvbotIXQp7OI6aoFQI=;
 b=HlxJVXwgLNKTt0PNZs/9wjL/z9F6cS17ZQSA12/+j+eaQrKL64RW4tsxNnKIPqOrKVqC7fSWGA+/z6oif0ofmlKRp2JcaOR7Hxu53qCQpdzUtwkFV8gpDtTC5CWsdnEAwn9oL2b4dg0sGFxifrN57F2kSsL7HFF+Vb3KqBDZSFc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB7085.namprd04.prod.outlook.com (2603:10b6:208:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 02:44:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 02:44:44 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device size
 for dd test
Thread-Topic: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device
 size for dd test
Thread-Index: AQHZeXtj0ucpszBCTUighHxPq+oc+g==
Date:   Fri, 28 Apr 2023 02:44:44 +0000
Message-ID: <z3lbxnnewuwnozrme27okchaxytt7zegj4emgpt4gmewsvcr5k@aordfdu7tai4>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-3-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB7085:EE_
x-ms-office365-filtering-correlation-id: 29a77779-a67d-4542-c093-08db47928664
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HKMrJD89avFjBHJn0YEK00RFV4ffbz6EyxKThk2O/S8ds5KeMaaFiP6Cr1b7ceib4EQevL8RfBYPSBlg4IlJF3DvNK/EL92QN0elfZRnqGQEbSx/9yj7pGoHg6bL3R7G836/GVyOLGGkdzmbPV6xQj05al7l6fpxudHF8HMg+biZC+hMd4SC9tfXb1pNmK47i1E1xXhKoFb8kdiGHemgdsahYsQkv3MtievGuw09lB7uGyiwclS9kV75e4jKcoLP/UXAGFbrIUubxb+kX+ZYtFfY0IjqFtdLUhgFpl3GDGhzLOEZyrGkXtYnq8cTZFm2W5WHh0fmMysXyfENfLXqYGdHWWO4E3kIHHlQ4eQoOip9jHOYBCEHqsabekYVHxpER+JHS+zPuopeGUs8eSGBFdthm91Vh/G3wD6Dmq4fhRz4cuetZINDCc9OBKR096YkxwgYZ+fjf68RWaYT4Pi/jd67c0+meH39L9ysDxDMrW1aD1GGLpIL6eAu5KoIuBqzSMgIJfxrNkRcEdM9wZuCz5Pt24bVn+846rH+J0KyU1s+s97tg0rB2eyQQ9EWaOKlRwiVsIZYC5i2Nj6l8/qYkz4JCpQj1YNjH/CeLsFeZNGSya/zPfF4l2CJ8bRBMWN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(316002)(4326008)(54906003)(6916009)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(186003)(6506007)(9686003)(6512007)(26005)(122000001)(38100700002)(83380400001)(86362001)(5660300002)(8676002)(8936002)(41300700001)(478600001)(33716001)(6486002)(71200400001)(38070700005)(2906002)(82960400001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pIL1mTc37EcsYUUNUkbBKX0vPY2Niism9dP2ftx/NzRQvaKgQVAxhFJ9bbyg?=
 =?us-ascii?Q?QZ0TDixTJI7jqJA5gvtJGSW6wk6QHreIJK21RwE/YVbOL6RfYjRUooVtcoao?=
 =?us-ascii?Q?BxGiDL8l9af6ZyiBOsLfUGtk4alPdEM3ZCjfhQPeHg7QSbgt4trJACB0u9Y3?=
 =?us-ascii?Q?YVLez2i+Emvugzbqk2OxWpkCHjf90LAIqB9MFmBJlxhZXQzGY7o8XK407xSn?=
 =?us-ascii?Q?+pdiFv5ixHO5/GCZXOoZ6buM7TFPBhdFrd1nuZQCz0SvZDufZYuOct5E3KoU?=
 =?us-ascii?Q?FxvpCDCajV285HldBOqRJin9LfGVDMxJPw3SwBXSr87RKxJkuN/OPq5qeljN?=
 =?us-ascii?Q?kEp8haPxp5iOLy6E8/kJNOjtyTQ8xBc9tjN0MKD90HyFfV3jYPnDCBD9AxD9?=
 =?us-ascii?Q?Aq6g0fZHm8TVDZJh83tXv2iOXegaROcFYVpxl/+xAr9EGb+jwXwqw6TM2O9C?=
 =?us-ascii?Q?vj59txY34yDsgoKJbCfzATtzV89phP8NMff42Erk0nKOQZ280VVjewaAeBgP?=
 =?us-ascii?Q?dlcVg70i9illS3+bnTMvT2zfxWqiWwc+UFwRTCS7oXe5NEQLWvM8qU68jAa+?=
 =?us-ascii?Q?GuAs1ama2SR/SAEFqNxOX4dAFgrOEmOWB7sn4STPQbSxr5G3+pL51x9xmhDw?=
 =?us-ascii?Q?yLykhJNGkqVp8nC58kWOBwV3Vs304oeLrzp+vP9n25g6XHtJAeM4rJ3J5fu7?=
 =?us-ascii?Q?C7+V85BjKAxXYnXO1w7vy0P+etTA02gfykf++zumf9H3yclDPGFsSb+M+7ai?=
 =?us-ascii?Q?xtU0tafJpMnVzNrBwLvew6WoV+RwCdWIajIUSbqIc/6VWfTyfrOn2olnlThe?=
 =?us-ascii?Q?LNboFJqHoa0zUWCF2S/SUUy59EXe4jiCWL/Y6CyzdKoodAUsstwIax13GAE+?=
 =?us-ascii?Q?DVbn4RBRxBwL/gYCxw3Dk3OgL6ZcBDDuv8hkEv1JhTx1BoHh6dwiIB3cihMo?=
 =?us-ascii?Q?gvMjT3oVSD4dteDb7JlMTrsBlaX79EBN+jiLEoJeSOhSBESCwJ95vChaq4B/?=
 =?us-ascii?Q?45FPnItSap+E/gC13NBFDp7+vqVqnGsRWP+0IipDyrR6Fi/5d0N3wWWi21tI?=
 =?us-ascii?Q?IAm5NRIjtW503NieNuh8VDxzoDtKEQFg36A6yfoslKilsYGAMMFTyBM28Y15?=
 =?us-ascii?Q?ABjH1O+93yWKuFWdNn6TgJVL3DJ2Tx28/XM0jHGPWeZGHx0fIGzY4w9xVouR?=
 =?us-ascii?Q?713c7kpAIvhpXDwakELuvGienVoNHxO0DSv37U0IbhA1PfJzliRaw9RoQakX?=
 =?us-ascii?Q?SwFaVYbx8sYvcD2C5dtkDmpX8HmnRqFjpH/DDydVuTq9gBA8YaUCika2XNYZ?=
 =?us-ascii?Q?alrcFspjRJNgysWsbdVC+IeBiSkXBybD58v+mqW4PdQtJdCTHPPk17lg+5KD?=
 =?us-ascii?Q?RA8pV+OfmV8PrURRMRvLctVJZmYzd8Q9tYCrfi/Da29c4SKP8XpzOkxyhDL7?=
 =?us-ascii?Q?KLUZzhi4sfR0RHYhvJVLm4a4H7aEXNs8M0NqhW4wnKzXG3oLDwxcRP6/2BwX?=
 =?us-ascii?Q?oRFb4U6VZwjEA0SEKceS/4JV7P4PzNpEHLXN7BArqdZHtfjZD5irVtTY2tPh?=
 =?us-ascii?Q?oHacxLGpxjgY03wYQeTfMhsZtcSGsdq+zPqtdJdxh9pLaIFgBmqDICjaMSlc?=
 =?us-ascii?Q?1FtoFDEnZH4DV74CsxFw/LE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE8A500D00366E4A8EE5C93DF3C147D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1u39ZYHd3lAxlkFfXx+J89zO06ns2dsf4p1g+noL+k5YO2juuQyiL98TzAfr/SKNR79eUbTkINBG8YJ4L5CEQ9+h1c8zPgxoSlLvhZmEMz6795kuwqCrmakkMrM1yvqJ6vVKuX3qMVmbMX0hu9pcHNrBgWaGH8Vuyd5S+dT/oYZ7DMYBXOcDaxOXwGWmL5c/4TmJyzEQajkv13G9/8PXYhHGINpC+OOnJc08yySw3dywPg1v6NdFqiYOZRx1eFTZzizHYvUt4K2z/Pw/aI8T0rU3wLroIvlyEo47lSiR3wTSe1Pz/0LYsytRUOTCFbnR41b9Cb8Rw8KF2/D+Y1VSXPMSSD46MRyXD9c/CJm3wYVy/3U/XaKUwlN1B/+gmg5IrjB3vm2BHegzrMugGuEQmDPJoheLjPklb0vpdVw1iVXv5cV5Du6Ume4+xIsXFQiUvtMtTiN5XiOpLcZQncg6nllkhPPV9UVkn1ENL5GkUNBlLlp9eS8yqgAb79NpUl+cRC3Ez7tDcbw1A5vt/MxEiBStvtFBpA8Irh9NiSV/amPBCTB8ag7K2fIRriFRQ2Ym0z7L2T1Ctaj15RGjCS3J0m4VeWbdMvJdI9AjdztDUW27LmYtwmVbxG0+TNIjg9Ztl45tAVYn3HySK70V+jXiWgshaAqpZbzdd9QCOqZYz5ieMZ5fxbH3bUagU/K6jZP68WGPTxYDKPC8OUdZ4p7o97X6vDHQrkvOBGIUnKZVZeSexpSxacHoLT+qTO+x9ZFdDRxtm4sTkwMxffwYeaVMFfGWkS9ZZHuwx2nd6mGqJovPgoIcKx/zwexrErr8VVY4nTUb+SfxVyJjioBuWWT89go12QyoLf1bZTZsbSIZ63ySeLn5CcR8nITP7E0bsp7J+QMA4UZVZgDqar/+pXuvj3ugSiaXqwMeSsao0d/TQLM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a77779-a67d-4542-c093-08db47928664
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 02:44:44.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5dwsjCarSvt5Vd5yuRDFtMtCS4OMwCHqrAzpZz15qYU6AFBsp/qT0LTQNCi7DV6c8vwe4UVTmJHYEDPyCfu62Ry0bUj6zH1QOX6Z2JNrP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7085
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
> Read the block device sizes instead hard coding them.

I suggest to add this to clarify the purpose of this commit:
  ".., so that the device size can be configurable in future."

>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/014 | 10 +++++++++-
>  tests/nvme/015 | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/014 b/tests/nvme/014
> index d13cff7921da..28913641ae40 100755
> --- a/tests/nvme/014
> +++ b/tests/nvme/014
> @@ -23,6 +23,9 @@ test() {
>  	local port
>  	local nvmedev
>  	local loop_dev
> +	local size
> +	local bs
> +	local count
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> @@ -41,7 +44,12 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	dd if=3D/dev/urandom of=3D"/dev/${nvmedev}n1" count=3D128000 bs=3D4k st=
atus=3Dnone
> +	size=3D"$(blockdev --getsize64 "/dev/${nvmedev}n1")"
> +	bs=3D"$(blockdev --getbsz "/dev/${nvmedev}n1")"
> +	count=3D$((size / bs - 1))

Do we need -1?

> +
> +	dd if=3D/dev/urandom of=3D"/dev/${nvmedev}n1" \
> +		count=3D"${count}" bs=3D"${bs}" status=3Dnone
> =20
>  	nvme flush "/dev/${nvmedev}" -n 1
> =20
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index bb52ba2598db..2f7957caac88 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -22,6 +22,9 @@ test() {
> =20
>  	local port
>  	local nvmedev
> +	local size
> +	local bs
> +	local count
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> @@ -38,7 +41,12 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	dd if=3D/dev/urandom of=3D"/dev/${nvmedev}n1" count=3D128000 bs=3D4k st=
atus=3Dnone
> +	size=3D"$(blockdev --getsize64 "/dev/${nvmedev}n1")"
> +	bs=3D"$(blockdev --getbsz "/dev/${nvmedev}n1")"
> +	count=3D$((size / bs - 1))

Same here.

> +
> +	dd if=3D/dev/urandom of=3D"/dev/${nvmedev}n1" \
> +		count=3D"${count}" bs=3D"${bs}" status=3Dnone
> =20
>  	nvme flush "/dev/${nvmedev}n1" -n 1
> =20
> --=20
> 2.40.0
> =
