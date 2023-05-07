Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D977E6F9C91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjEGWtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjEGWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:49:44 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A711550;
        Sun,  7 May 2023 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683499779; x=1715035779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yqIZllN8exSyriR+J3anUGTU4lr/A8InA14cBLqVP6w=;
  b=JjvkPZWrxO5deveHDzh2FJAp7XPgkZim2FGywe5cd3o+lmZb8NISDkXF
   YOlqYCUlIdfSTOw5eyP5neW8zCodSzzLNSOfo9t2PbvWfen/5uOR5pL3Y
   5dYT9RJw9NlaIUoDdmntmtVlo1RBk78yWmwTMA0KmA22NfLWIyPkmY5Lg
   mP7LikXdZWd5hEAtxNon65Cyz33Wmu8M2RnMuFXUyphqLxDmF5UvDLsZ0
   OuNCymRvDzX/b2/xkbHJFk0sq8pKhdfuUW3AH0gSmNZUuWUm8N9HaNc3Q
   IEUL6VLQYi4Gh40TE7qBSthfFFTQRYjSeQlqQiFY+EYnIB3jPVV2p1ULE
   g==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="230130534"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 06:49:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAPuO4YMb0IWU6a+LNgwoR3KupaoZBhSHIPdXi/qlL2+ZI5FdcEQ2N1Rg1T3J4H+fhnfTS/Tj4FUbO+uuS+/GJ7++VpSN+P8lZ4NEG+jHPe7nH2y0VeXkAFJIMeCPuXyYAwa0Y8USpV+x3zUF3F/htoWn1R24RYjj2tZH3kEJDMVWIbCj7UI/wMP78Tg1ZBc5cBErK2WxUPvJv4yLjqgPQTX5aO/ROxTAUKVSQbOCK5vkIlREIgbGxO7GvRBjVBzn5UTTwVrXG3iXdCD7516VqABMA9dKIniEE0qIYtanbtHlyaDMaQpMuhFIB5EH7Y6OBxEswfTXNn6F1bxhoAf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA1Bds0HywsVSg9boZ5EAVZplziWkkl2N3Q1Dh9uFjA=;
 b=XBDvAY6GikE73bilG7e1IvBsBN4SwepZlc7WEU49/rP8mb2ZA2P1nu/dIzJg1f74a+KqQ6S0gPhhADZhXKOlHJAY9jDy3TGibecpxE4XU3fgUs9rWMtiMPLahsZ8+67nuaLgqzh+bhFqLOEP0XpjBNmCaVv21qq7lZxkuSddrUBUuPUZRij4RIZbLgPkdZR7S2MYlZdxIiZJzn2NHzVSGokGYNfiKpcy/vOVoHt0QUxGi7julcPL6BIqeyosUI063fk7sVmfUlTUWG8vbjM0FzTpslEtfdWqSbPfZsOTN/1EQ9e2O6FqzVlcJnf68Q0stIQrNzXe576dL5XtV1tMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA1Bds0HywsVSg9boZ5EAVZplziWkkl2N3Q1Dh9uFjA=;
 b=nse1v2uiCZHojtr5EnDURrXkilAVCzRVDKDe0LTWX72Mxd8/IrclFqvWbQuSwlUxbFqom5Luq31pUW9FRd8gQbnDrtd6gMHvQWd3h71ldXZUKP6TDJqMKeu+yIwz4GBvvCy7dQFd1+CPv4AInfYpFAN4rSnkhHy+2OoIeYvf1VI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7561.namprd04.prod.outlook.com (2603:10b6:806:14e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 22:49:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 22:49:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Thread-Topic: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Thread-Index: AQHZgTYxLd3TVfPtPU6X2GSB8ju+gQ==
Date:   Sun, 7 May 2023 22:49:34 +0000
Message-ID: <6bu6fbyvltx74goc6ul5ao6srvcl44wwq5c4v5trk6ioj2nwhj@cbhod6tkucex>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-2-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7561:EE_
x-ms-office365-filtering-correlation-id: ee5a1dd9-b6ac-45fb-0943-08db4f4d544e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz+w7Noefqw+DhEWORuKYRhGp1pEP2Rokt1srQOu4n8GCsERXjmeKzbG4l3g57H0OhrYIN1Un1v1/SCGxzi9OKjFXlNJXl4cf+DSpL1+qIWorgu4pIDVQ7erSlNWrb9mTDbtinFmFcxXpwwzv4kEvxEhbn7pQL1/+7HC6aLbUnFYpGY5k1vi8HqSHTJfDg1q21fEPsO8UeFlDRbCHSlpoyU6z/vNGzGmRXBGv2Ax2mkouAvER5OBEXTSwgaVTFpfHtKFtCuKnLYvu40cAEulNTF9RwgvnozzRZIURIIXNihWHvPc/at5yM7D33WXeFAlvSQ32FfTV9XkIcRHEepws7ykEmK/NExe5ppVqnqZ/jsK3nhzgOKO5c/q0f/M3bDWBushPz5Zf6oJAp6PS9V2Hb81OjzFvhG9u78CPTvwTXle9IfoyILwcwIeb2vJWS+KfPfzJcTtP2BBCqnnH/FABMKdfmRq4HczHsMcyEiB4bkbo5fHEv53SFTlmPEwbtPk/eE1wjPucfIZxTkagTXx/anw/alv2OAdBna28onDRzRrgj+6eGt9BvzAYowsi3YPVlkTq4Gg05+oYvTV2QOwApqFtPQXAEKKkaW+uCWHr6Lf2x2aEQUve8QT/aQqubTb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(122000001)(38100700002)(86362001)(38070700005)(33716001)(82960400001)(186003)(478600001)(4744005)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(91956017)(44832011)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UsoMtsIne/6Q2sHMyGsxIZYlGALcX1lD/Brx+6CBmVJk+8hT1Lf1zr1bVDsS?=
 =?us-ascii?Q?d8WCeXg9aPUL3sbS0NMZETc7Rh3kv3uttch4iZGoL22nV22oZBe7ViF8OHcb?=
 =?us-ascii?Q?VZcJZ9E1y1YcTsNl9FuPm8OsiwUS5/ol0QBOTt2JPHyXMAI1UHNw2ByFwCOU?=
 =?us-ascii?Q?nQvt2PXHcZ/jFf+6U0CJKuTQCfpzlw7mw1szoea/EUAP3jQ2B7E44bgFEJx4?=
 =?us-ascii?Q?hRPNgepSpuTbjh88TPVgVcoEfmXuK24athYNcCNjp6ZUeKm0nLD9fOboZF9A?=
 =?us-ascii?Q?WvJRe9kgBlDXbLDdI9Yzx3KKfQzG02Q3A41MCegXnvzFh1N/zA85rJ32mJ2H?=
 =?us-ascii?Q?dkksNSdb8pfI0kl5YdDVxCh/MdV6JnKCULmX8TsJdY+fRGGR11CtgyGymNZu?=
 =?us-ascii?Q?NbXXdm0F2d5QZVDuxOZMVC6QMsF3B0loYvqKkETBqWKgGFiJuF5fazrBWH70?=
 =?us-ascii?Q?tqA5yK4GJlDa9u0g1ChxqlWurw5b3NaF19M8GEHM5ZdYgcPPIhP0x+8cRkgJ?=
 =?us-ascii?Q?ow1yyQX8iuKBVa3iN8qrR2E0bBZVCOn4GAd7YR5jNK2Xak1BBdLaQgG+j7zc?=
 =?us-ascii?Q?YIPT3ZFd1OAbb+eGzFSzwUKs8b+wVd4DkUczyultYtE48yQRJWWZmJPx5TJt?=
 =?us-ascii?Q?VnS9ZMQBWyA+eJPxoP0cFZJfjoGDfUNtYx/OnNjJw2DqlZJk46/CBM8exPi9?=
 =?us-ascii?Q?YO+Vq2K0Jg+sM/U5qq/xG3C7Y9UDJ1fUsdWTloKGW9Fu9nrqJE+ZSTR54Fzm?=
 =?us-ascii?Q?rCE1mlc7mKbd1nf62d9hdQFr/pnfVJCwBE2eIEHHwoGRjajGj/EzC/rhZxbx?=
 =?us-ascii?Q?bwfxRpgA4JG3e4OrRa9iCMScTOzCTitNszJj1vVjsiP9cVde6y1kzyw0Mahn?=
 =?us-ascii?Q?VCq9eZSyr4hXPdPzFsppzjpiiP4iO3OZkRfaoSJmxC1D0D212k0Wosx3BokT?=
 =?us-ascii?Q?sNUayNGl3GmY+Paue2sWgxvIeAPgI8TMJu3nh4dB+3sVls8CHVASiUeIbw2R?=
 =?us-ascii?Q?eNMGtf4h/i8poyOeWFp32G2b8FgT1F3olZPoHs3R6Al4x/sctERPcAcmz81N?=
 =?us-ascii?Q?KhIVI4biePEUo7F3jyHYHrJJ7NpSAZ94QEAu6X6rdfKn0xvF0/WGNqFUQnpq?=
 =?us-ascii?Q?nc76/kcfbBhExJDi+gXFO9g2EzqzvBfk3lyxY7UMjUPD6TrpSDh7FP2nN0XT?=
 =?us-ascii?Q?5OuE+gDznc5Edg4QInNVFY5PTsMAC0w4cAeg+rZdn3MBo8eO5f9EtJVOYXGo?=
 =?us-ascii?Q?VmmBeuciv6LjHw/VTe3EkA/yMcoMMyCAqABI4yq/FcSsZzzlN/oAflpQ88U0?=
 =?us-ascii?Q?l0vcfhnUCJrKctKJ4soAphv5UpIyVd3f7iZVGgAdLLMseJAeJhB7wzEhCawf?=
 =?us-ascii?Q?pnib98x/HEp4IMJd2V2Nl69wgT1p2qw1eJnIxRHo76ra+VxE20Ym2+8Bizhf?=
 =?us-ascii?Q?md36m+YemuSiwF0WFFRy7pb4w+xIp5HO88wzpdeY/AOCJTl6GwkOBBk1qbKq?=
 =?us-ascii?Q?sZYZ45UPKSkfSe+gCcZOiFtQVXs8sLhOn+eeOmHTDqAs3rukHuCbTJJYmyDI?=
 =?us-ascii?Q?pGkQirkqLklod0sr11B4bwNeAP4G0iGwQpXkqPoo8c339n2sUfa4bjXSqDME?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CFF6B9743663B429BE30F754B85D894@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m0135vr1Uv0ytM/Mu/xhspoJy/CeoibZZRgfQOVWDseW7Lkc60UY6Nbh2wr9mLqCbyomCdJ9REZaWvi6rK6qYuXdMzEQSW5iqb/2a/ZzcrZ2Gt+Jg6oXk1hrTDBqj6KHPJc5xE2HJtTjciIlmzl+Ul3P/5sV/WqipKw85dRk4Yl3cWNkb+e11dfJElFM/yAq18aUBCQ5NdF0AK1mnJaB5iu+6jOoz5R40Wch/rHX1ZjteQ7pIheh395t4xeFHBOL5yuhxnHX4aLlAw5Nm/+myKhzFIIrVtj2Kbnm5bkY6oLq8E5x4hZVDNmFO+ZSk7MQyKNoTb2MHNbq0PcVreVXZ/zkFBixsGaij/f5+UZhp0GIMzoAIfv+ZePYZl80UogHDBteGQYEzOYR88PeRPNT6DIr3f9wMxFDCLtPF1YqBb9AmJAkqfEPpUuAT43GskY8SQkJv4SUh4t77bH/CV8seGZK9Y8qIpEFLwsz9rY2zmFAscmsfB97tUqhQoFsNVVmZOaK3PK5qJg5c0WDq+9S7NQRhse4oUA4lGfzJOky7J8Xo3k1nIkn4HRMnM3cXTOSDJeNFjlKvpWMys+XPASoT+bKk8cxmltW9wtmzMiAPzxJxtLzrFxAUiod47l9XB3Yy8tX3qblIuHTLS3OuNpyKte1y4wXssVzDoSoQ6/pfRjVuyTlMS8F3sHmx/GdtKOT6dqAzOKEuCJiXkZ2y7TVnDtts0dieHBPCMOwUCU1zHlpNF9xUbqNcZp8cTlrbvtCgxVIE+TVi9ZiYe3z98vaMdHAHbnHCvU1NeeSBFRrgswp2FKE4sqH36yawMesqCY4coBocqMbx2qdabx2UXhZ+3ukPHw6BXyZf2pnWOeEbGzEV0kP3HRSjZW9kTbB7KTJb8Bse+lxQCWtS/O4YJgGABkHPink1f29HU22VnVsR5g=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5a1dd9-b6ac-45fb-0943-08db4f4d544e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 22:49:34.8245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBstwYXr4+Soq8Xz18FZVzoExi6/7DSENjy/jwzKmN/KQPtKFbnv0GsBhCbFpctabRg4P/swqP3GikYpxTNMLf8wRZFnGO2ubQqk2pHgWf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7561
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
[...]
> +convert_to_mb()
> +{
> +	local str=3D$1
> +	local res
> +
> +	res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)$/\1/p')
> +	if [[ -n "${res}" ]]; then
> +		echo "$((res / 1024 / 1024))"
> +	fi
> +
> +	res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)[mM]$/\1/p')
> +	if [[ -n "${res}" ]]; then
> +		echo "$((res))"
> +	fi
> +
> +	res=3D$(echo "${str}" | sed -n 's/^\([0-9]\+\)[gG]$/\1/p')
> +	if [[ -n "${res}" ]]; then
> +        	echo "$((res * 1024))"

Here are some spaces still  left.

> +	fi
> +}=
