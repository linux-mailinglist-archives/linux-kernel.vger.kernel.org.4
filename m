Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806465FC96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAFITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAFITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:19:50 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6444419C1D;
        Fri,  6 Jan 2023 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672993189; x=1704529189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfB3Wk1e3aV90p64Y12eHY5tZP+NSwW47hHcSstoauc=;
  b=Kfz7aTYhSy0EsAtjinCHxkD5pySRIcZvx7mRmc9ZWsF92NCERcBn4fow
   pUE26sISecYgkxoeU8lpRWJlG8bno4/1PX+qd5tDsWLmdTWCD+pH+kzAu
   M1CVGqJ5FwQAz578GVaOTtV+M3FRdlijOqzuCGbqBk3jqvyyNV8Ec6E2Q
   +ag4HbFEcdStIx1OnnuS5kmIwEdzTzbPnCTl7VDwwuWW8UADovKbqZJgS
   gVCOdH2iwWjpO2BRCIA57j/ZbPeIwmosLMoywxlbMipdEJDoLPHUdl4C9
   2G8enAvDVjEQH7ettdX+ki+EljAxnCXs54Z/OKZ2b6K9LhgtS9AXyBJJ5
   w==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665417600"; 
   d="scan'208";a="225215868"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 16:19:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2fgm8eM7EfGq5uNT4MmZSiXyW2dZ4JyHMTH3g0NwFoF2Ug/TcjPpwUFmAmJa79OPerGhPp2DR5XluyO2Hs4lo4W4AQRQNBYFamZP3Yrff9ZD2PX0D4IezoswtZzMNyIo/r5RjflB5AU28Ps1VXePMoK3qoZH2+OGUrc8mByFl1u1K6vWiScnqtxiyXr+mdxzGTxW9Hn7Kwk8hn7PmVgTsu6nM6GDzUehnpHXBdqKa7BkHcHHphMSp+dxJu/hB56F6I4BFtkyDXfIYHCAaeV4uZp9DXbMOw5YAkpsOjtZzKIzZH9QUIo5nYQRxrfW6ufqX4qkG7aeh8gRTq6Ws/xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtE7qi3UkdJsvDnm21phjxBEif44PP3oAvs1u8vyhCE=;
 b=jjjjxEzoRUs3hD7AOdteSq1ffwGkajXfeKudzXJV9c8JMfCQB+ZagSkkVT3/ElwELhTbJXKVBeEbZ7o+GSnyz2RCqpJgTRLnMsIZr8E2Acpsasmys4fmqz9GPB395oYf1vhSspRexME7xFpiVl/PGr5DBYB5YsrFo3dQhxMsO3ck7CjO+GfxBgCo39F/aQN06dGOzruzGNEJyM6MTjMTprZnZWCqEj5dI4DUBEsdhhYIqgc6OJyg+iW8XuF05MgL80KxWRLBxt2QNtslMfyOCYIgieva8Kb4ryqexGEpXa8Vi2DKvCf9VCHqdma30jXgMFV96BohbQmrfNKKI3U+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtE7qi3UkdJsvDnm21phjxBEif44PP3oAvs1u8vyhCE=;
 b=ZDgRO2Eyvns4Qfmc+5gF8fFeKLb0ioTeoe6k+fLlNBYjQBLifSaD60JSNu20+awcSlgHL8ToQrgxgkatsMI9dpRGYh/wlSxJfDZMbIAcsQtYQ8YoMmRYLGieLZW0vl2EnNGvdSiXOuu9fzfmejiFQn3MwnIOYzGFelDzNR3OIAQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA0PR04MB7337.namprd04.prod.outlook.com (2603:10b6:806:db::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 08:19:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 08:19:44 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Tom Rix <trix@redhat.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] scsi: ufs: core: initialize sg_cnt, sg_list
Thread-Topic: [PATCH] scsi: ufs: core: initialize sg_cnt, sg_list
Thread-Index: AQHZIU83ZSgdo4iBMUWhjrgAbgC0V66RDGHQ
Date:   Fri, 6 Jan 2023 08:19:44 +0000
Message-ID: <DM6PR04MB6575FDCA528AE6263537A27BFCFB9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230105214635.874609-1-trix@redhat.com>
In-Reply-To: <20230105214635.874609-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA0PR04MB7337:EE_
x-ms-office365-filtering-correlation-id: d3c54f18-17fe-4bf0-cf40-08daefbec498
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zID8/CFJgcfChtMCPB4VARn10hFMwFIzT6iO+ittSBVOJ1gljDjkG5q4MF05s2Y06T32JX9qh1lNbXyFWRePdylZ3o4gfMhSVxy8SkPAC2/+Q3acJ/mVPTeajjUVphQXUx2eDtvCz8eF6tybJZRULsmIYiC2WP4AzSXINdcwPQCORixFPasISUIm/82GpXZTPXb6MnXu/Qgr2a7S931wJMEh6vNc9rSvyf99F557Bw1tWJPzC0S+Kb72wgQIRhP2uYVM1VKLYlOwH/1nP1Tzv4KY5EVE8kh8pifby6S5Pbg4gIkXlfV5BT5gOW2oyDwaEusrwAl06FEuMkJxIaZSF2T4NfFrhUqyeh+UuNic5caMSq0dAARibD3DT286h+aaqlNIomoEiIZaNvib4NybUR1kfFIJL9JEFJLShuB1c/kSuGpOHLxyVwSTRNzYuJ/dnGj7FznJHZuw9Ne66PAoLufHCmrI3/8TOoRfl/q1uMv7fgfv9fLpWbDB2gr41vDYdoqwd8sTwyLc0vgYbjE1kMs8plGRURVw864uoa4Enz4ayqWreJrEbWicGDtZYdt+A1/cOtTTnuhyF50azx+ncmloLGLrcmvP+y9FfJXjik2WybTcWx5rO9yCWTzi6p1BP4IglXWcRCad8puzJA7sPcMAo1C3ZEYZsHc1APeuxiNHiRCISBv9TrCLjxI/dNgRcEZG4mxB9xXYXNceoVj7Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(33656002)(66556008)(66476007)(64756008)(66446008)(66946007)(76116006)(4326008)(8676002)(4744005)(5660300002)(41300700001)(52536014)(8936002)(921005)(71200400001)(478600001)(55016003)(110136005)(38070700005)(6506007)(54906003)(38100700002)(122000001)(82960400001)(316002)(86362001)(186003)(26005)(9686003)(7696005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ra/+hcLx2+VFN42tQf5Ehun5k3aauKqQfO87z6YOkw/cnMyuDG/SgPNDzXhM?=
 =?us-ascii?Q?5hcRWlST4aJlt9/IvmV6bp6LWhBywXYfq3rQ19wqwuqJy5ZimAzWfeewxNk3?=
 =?us-ascii?Q?RvJ6SIsIhOfTUG4MqlUSFSojk3NPIDrYC/fYBIi3oa3RfQHS7Dj3S755YACE?=
 =?us-ascii?Q?O1k77fmc3PRSOXgNXXvZoA21zjlXfbfqT9tAzBZdqCibio1E0dONxmIj+Icg?=
 =?us-ascii?Q?aeBGTeYxQKsVVgmMi0av86iAh/lcnnyen1ANJdyAQgjGZhhkAJQKKJq5yfCs?=
 =?us-ascii?Q?q0ObI3MJkZ6wAQUexYaMCsUvggv1ngJqsuPtapCR5VGvAA5rfubbLrQezsT7?=
 =?us-ascii?Q?uwNhSsOaCsH8t/zj1aewocJzlFJ/SYWZCReJ7wqoky2YFeCatao/kASBAI/v?=
 =?us-ascii?Q?pU4ngiH49WjLbyjKvCxozp6l7KWOof2A1vFarvac5Stlob+Hxz3tTLPYqCxC?=
 =?us-ascii?Q?/7bBz5zaDXzEWc0Jirti5kTOxn8hFLFP//W/6iof8urCLWp4sxzIGg/Szd17?=
 =?us-ascii?Q?+4Hi+RffuNQ8bdyZFMtNak/7KH5fta0ywndg58SeYuGeJbY3SWy1duchCq2a?=
 =?us-ascii?Q?aKNnmYnWbJo/kqglwRPzomCwhjPvINsntiDsAKjBs4vXdE6zAn97SR7wKxIh?=
 =?us-ascii?Q?IT6wrtfuHfsZ3E5QKvQT5l3TeH7eElR5EAzCZ56d9i1p8FI0FqaXXPFDob5N?=
 =?us-ascii?Q?H8EcoBUeas2RFDa23nN7hLxiLgpDTeRdVG1FmQkjhNG9WqjF0uJuOT50CQbT?=
 =?us-ascii?Q?ZGOJE6lNMhDZLmMg3UCNWyAKRF63GAuqVD749UR/aQZVSeRD2O4vlp3o458y?=
 =?us-ascii?Q?c+jOgn8wKmsys6Xvf2sgCYifbRmtGyDiK+YJIfx1bmspsHvZhshphQwegmXa?=
 =?us-ascii?Q?867KzbBG5k6BdpJUS9aWs4NORPwqzn1aSYnlofaykdBWA/EdYBZKWgSdVBcl?=
 =?us-ascii?Q?bs87x5GHAdFExwhSnUhTzKNjWdMr0VehXzF/3HEFJgWhZExTABlhv2KHFv6y?=
 =?us-ascii?Q?R6ItSIkLQoE7gW9loll4eCjWKR+ZmjihmfNeEdHRHv5gSccZ4SzncFzU0g65?=
 =?us-ascii?Q?G26M2nV8coJSqaPekYkPPLvAzO6wnQa45i+ztatgiBFozlKfxWxwc9DYg148?=
 =?us-ascii?Q?NIAym/cfJksrFRri0CMWmMv/zlqmwwYDmZf+2Ey0GtFZtAvl3ckCw+km7zuR?=
 =?us-ascii?Q?ZXdLN3fR2/OAfvVaUc0PjGgo6L+Jg8INCvgX8XqYKNUBGLHBzApN84OTlwAZ?=
 =?us-ascii?Q?zHy8Rto6fCMaAWutS3Ld/1SJX05JVWb0EpcIa/hbh9TMjnKeGllVJp53Gfn4?=
 =?us-ascii?Q?g5Y5ioKrhc0crHh0GfN2WmOZzK6wSBI48JiuWb8Z7MCIUAu0BOs/vMOgip6N?=
 =?us-ascii?Q?e31bi9E38GaeyKMXX1E97ST8APIYf0tjCZgg4ADdGm1RCVl8HltGZOvMLRqh?=
 =?us-ascii?Q?mO9EAyvLphmse80/swWZbhT4/ZS44dDveu6qHsNEOyvgYFXC31tbDEgoTFba?=
 =?us-ascii?Q?4k8sZAzAgQhinbGYMdPVSRqYJP7jziPDe/XC8/4RUAXXJLUlj2UDdtpPXZdA?=
 =?us-ascii?Q?uNTelvIlP6dJwiGXDJaVhJvJeOcSOsK76AsBZWSB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZO5PVOqHbowvbCmRHaGV2rPlJR/goF9q2nOOWRJQ2W0lEAPrO8i1+1ZDPAX6?=
 =?us-ascii?Q?93i0HhZS06dQ6RxvoWvQs1XHMcXAkMJewYCfBb+Fq45CwemgIauz/xJsa9O3?=
 =?us-ascii?Q?LwKoJh7w/A0zzvA/ca3HnsERtNypCkpOiiHgTrnQWXElrwY9zvYI17NToRPo?=
 =?us-ascii?Q?y8QK5B5DUlMlIK7Vy5adIKvi96n+VD0pOofSYwtUO9HCyUp86KW+OiCZU4eJ?=
 =?us-ascii?Q?KPOcydQFL0FjbGBd7Y1o2Ie1q7ze3gJ17+2CGFPCVfF/56Rd24CeeFrrtJd4?=
 =?us-ascii?Q?RC33o5JGTX4wSB2PGt/ZfptpNzXpbHZMxcsqDeApDSCeIfJWGlTBi3loMqhr?=
 =?us-ascii?Q?2DdN/6JPmiQx1Rf9fAsAUOW9Mr92s5SOBko/UZoZUGssy+4I621VvggksveB?=
 =?us-ascii?Q?2uTtzPzQFMGaVjiVCVT/LwhYmCWr0qE/sZVxG4TWhJGWsdvdC9oa3dA6WMUQ?=
 =?us-ascii?Q?hTglbPKgmpFQybVdLzN3YImZRNZKMrw6ov6ybCpVNZ6S5K7qZceYBs8FKdnT?=
 =?us-ascii?Q?8UohWQUrAYr31B5AjQx2aAr86Wly4JIrh53deQc//i+CfAfZ4LZvxuf1YN7N?=
 =?us-ascii?Q?473AfQVD5bjTQlZAyf+M4cS0ujAG7EgTzYzGToml6gd1pGOmanxF1BcszLdE?=
 =?us-ascii?Q?RsUV5SWLXqvJkSRAEeluRRZG8kt9zuw8qGIVeNTHoH66CJo+bkaz6OrPKLmd?=
 =?us-ascii?Q?sGFo8OnDq7nEL4pGQASSLp+6HMt86Hk4CaG6gBCjfruJxU0oMhOpe3/1O6hc?=
 =?us-ascii?Q?1vN3qfH/r6f4eZL94lm1G6LTKCrgU82L6WOYmgM1SnndDCDHs0juTHjJKan3?=
 =?us-ascii?Q?odzy5VJhLFAOmecSOrEL/ZlwftYRnUh7I0yblekTaeqkRHy9uoArH0UKU264?=
 =?us-ascii?Q?1b7iXvBkc+fgK7AbTFvdRGs921Kc4LM2aRKDDuYb8GXS3D7onVFInI4k0yjR?=
 =?us-ascii?Q?/lXJ0tgYnjiGIgAreAzQRvGtZcn3aW30cGNGHqoH3CuqlcqnMIGNF/hvPDYH?=
 =?us-ascii?Q?jXYj4Hgun3mxeERliwTgGk+7Ri29ot/BwXeY4fXodROc/3wqIqo/xefGWT0/?=
 =?us-ascii?Q?ixCdKcWeyPOlShQIg8jGZV7Qy5qHY5cK2MXtL/xs9QIWDHys0eD/2Spo/bdw?=
 =?us-ascii?Q?okg5h/wh1ct3CFUfmGzliLdVOz9Y3jmtjpaqi4wWg8oC5/r52yFule6o1WxE?=
 =?us-ascii?Q?+1iSi+C7GBz8u5td?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c54f18-17fe-4bf0-cf40-08daefbec498
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 08:19:44.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DD1sdcwQ5/Hc2fpmODrOgTnHj03DoPsRFGKunVqADI2pCw/wVDneh8jwnKp5ac+cNUUa6DMmcUHcyhEhksTrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7337
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The clang build fails with
> drivers/ufs/core/ufs_bsg.c:107:6: error: variable 'sg_cnt' is used
>   uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-
> uninitialized]
>         if (dir !=3D DMA_NONE) {
>             ^~~~~~~~~~~~~~~
> Similar for sg_list.
>=20
> This is not an error because ufshcd_advanced_rpmb_req_handler() does a
> similar check, but that check can be reduced if sg_list is initialized to=
 NULL.
> Initialize sg_cnt to silence its error.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
I think that Bean already submitted a fix for that.

Thanks,
Avri
