Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39EB6FC13D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjEIIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjEIIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:06:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB7DDA6;
        Tue,  9 May 2023 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683619556; x=1715155556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1F+3V7Oo+XEnvvJw2fbZ3HcvUa9Ims+PsdKfeoFPdwQ=;
  b=oYdMU5WRbIHGEAKsBj+jW/dfF09050HI+DUs0xyCLlXmLjxdpnyoQj/p
   s/SYhCMZtBS48uyam8FuMvukFDLiWqgrZjCaxtozHoU9fUzX6zkUsAStb
   7tUtjwYQytas1milOf8biBLBHINLOZiw4pgo/vGkhSKKgOfOpevkxvMPv
   GDFTE1gKP82p9rzBQJ9jpmF2htKh7jlpa5jJZrmI4WuUGlCBSlSYLNCbu
   MpfwDInB65V3o8fmxdAX65skrfvsrWLQVHjYmMqOnej9OG890tY2QnFoy
   Gut8oUV/ImQaixoF/oqzovgedd3S2OycGLDdYKJGHrd6wTuMCvxFa2q0X
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,261,1677513600"; 
   d="scan'208";a="230110995"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 16:03:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFA7WlDx88oR4ff9kueypynnCZRzjRddMMtCdW3avUCMehloveyBb+rctm98KmKWvSRgX7dXBld9wK/GZaczmMgumGGCUWdgTvOS662LA+WQzRDIFz1Wq7c+mDqfLWOCTsxerahEtKpkEPAFReVGNKeUPQJgCSPi5nshowTiNJ9VHE8LLbLTb2AidNa//TDXuOJ3wDVDtidSsVyAb9C9bGbOh1coy1aS6F/FYI7PHeBltjEBT1Ad9AHxV9Uqq/si74MZtzKpIRclxIt04YdJmStdCDsI7sRhErU3hx8KN8TEKYbGBVgizSSlNe0SEv4uKIgH/ksRmxnp3FXVREPtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUCkXeN8p7yYb8SF1Y3Ok4fcxqBHPLQxvMlXN+XNgNU=;
 b=n9rbibhRiowZWW0Q3JfF3aa2leBSiq9l1/PvGNUlYoVdxcha5h79ptPVWkAm0hE9F4IBKr8AmPJBOdI2lhnJtL3MLNNBfaQZsH2/9R7tfwX70x2XCpQNphJ/CAdnuENxV46WDcQH8j5RgEpBb/RQ/Rwo1zwQT79TX1Nhmhcq1JwduFUoKGq2YZeRg0c4d2rSPBDgdwUvqnJbdT55zjEXL20Im6HdFZsnBDnCWrnoy67fN0rp998bg19nVUv3e+T6tWq8/XFoVxta397Ha3aDc4zj78vD9QLqWf1LZPi6C872TKjjEq1cKCAO2ppCeUQtCeuRCqiF5JHPc7PuSx0VzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUCkXeN8p7yYb8SF1Y3Ok4fcxqBHPLQxvMlXN+XNgNU=;
 b=mb8A5tNocfClRYhre52TQ+j2I9GY9GL3FdIwElzBzve7dMkHt0gGeLXz3q9tMVPlNYEPqZDae8gWIA6U5VE1mbduT+Lpn37lfiIpt6Xew4PUhrgeEmUgWHAn5l6J711LMukCxGUz81CismkN+VPGLCdQ+Wy2wtTeQgeWZqP6Wws=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6712.namprd04.prod.outlook.com (2603:10b6:610:9e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 08:03:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 08:03:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ed Tsai <ed.tsai@mediatek.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "alice.chao@mediatek.com" <alice.chao@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "naomi.chu@mediatek.com" <naomi.chu@mediatek.com>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Topic: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Index: AQHZgkMMEfz/mkmxPE2tTXnep9Miz69RlGFw
Date:   Tue, 9 May 2023 08:03:01 +0000
Message-ID: <DM6PR04MB6575753742F933DE192E7325FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
In-Reply-To: <20230509065230.32552-3-ed.tsai@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6712:EE_
x-ms-office365-filtering-correlation-id: c30b4ddc-9040-46fd-d14b-08db5063cfa7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3WEA/w1rDcehC8pM84i6vPfvbv6qM+Fpi3OiYqZd/f3Cnw/LDe4IoPQeDvKku6PM3+a5jtJHENtlqisr5v5mkTQoSO462R0TtqbvCMUrV3Zkd86u3zKFP4IxwJyeCbZK/Q4qFN20NBva9FvANMLAlqhNyhdYwbxVfBCgYiZ8gmXyvZmPNvbOfZTzRQUx7M5c+QkqJWyyluVR6pL3XdKf4BDdwhHm5NcRbIOq3xl6Rrb3ZCSevpb3Iy/MsINinHg9UkgDhxzWXpWMOCc97qA4SOJpdpeUrISCgHD8X0j966LA23FcKyE8NiHKGPXR+aE7oW86FEYyWTlYlyRMSB66sH9eMJSbdzti8eu6tYCcm3SQxjHG55Aro8L1bG5jqwMKmJQ7cpu54f9j0vqRDCYh96fkubRnbxb3Xs89ZCXcG7plbJTQd8EWV5XofEulg0qOqoix6CnnhpYEbHXp4KB+r8pZYHYoocVbrIN/3MoD+pMbebCAScht9zfvcP8tyJqUKxVLpapJH41PThv9vzUTqhp2WyhndQRX//qhYOUPenrZzCeeXqZ9x8mRkMBROGxKCIDbtbj2b369dQRfBzeuNnNN+JV1XA9LqgMp1Qagb+zsxL/rlYSFmzhaaNkkORI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(83380400001)(122000001)(110136005)(66556008)(66946007)(76116006)(64756008)(66446008)(4326008)(66476007)(54906003)(55016003)(7416002)(86362001)(478600001)(5660300002)(52536014)(38070700005)(71200400001)(316002)(82960400001)(8676002)(6506007)(38100700002)(26005)(8936002)(9686003)(33656002)(41300700001)(7696005)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcYLBqJTdSQ9DexCgznbmUTxeYi1/WmuYtZDTDQ/u4K3G1RFZcRozorIH0FL?=
 =?us-ascii?Q?7yutg5RCyJME/dCySNUfqRfBTGRBAtCwNtD9nph24MeMXDta9+GM4k0PChz1?=
 =?us-ascii?Q?4NmjTt2whiCNnTnWbl2YgYKTQQDO07Aq33jF/KB8K3XVXi3esMP88a4wgEWh?=
 =?us-ascii?Q?dCPTvMmokNrlwbxj4d7P/jwTol/dKO3uPyiRnnMHt7wiWg3sr52gtIv+LQZR?=
 =?us-ascii?Q?6dA8+94rc+IW1EayjzjCRnfItlQmeFrNPXQFBtWYhkX31QvGamnTbx0WDqzO?=
 =?us-ascii?Q?9GSWlg9Cy1YtvXItS3q3XRRiidvzlos/VJsZ0Lk2UeyN0vhQSy4NFWSnsvdV?=
 =?us-ascii?Q?bU76iaCI7cUZTetXwfIjvzJ12QwhrH4W3bAuADuShGczUL7zS5kU5ygiBU/s?=
 =?us-ascii?Q?fzKGQ0z3XSdsTUcxI6rMcyXzo8Fv5uLohFGIyFeML88MbidmDpk1BacKCBP/?=
 =?us-ascii?Q?+p1v0Q0ZzWAT7xwaro+3MrPqB7GOQo+mKkLje2Y2B8nWl6iQbtD4AecggrRp?=
 =?us-ascii?Q?WS92buvorSEJf/9PyR/bR5FpDYolLtjbOAvOhBxlEO2jhwq76/0rBZMZQysd?=
 =?us-ascii?Q?jjbSXaX/MzHMn/NTShdLATChjuCJ5/lmZRuGFzS0A+4kuwhHxH91l55D+lQt?=
 =?us-ascii?Q?zY3XXiURPFVe1KpA/cZTL1wcaUGxm8U+Afp8C1hRuTbyUZB3haMnXbWIAF04?=
 =?us-ascii?Q?uwNxAXBVlzhlCZV9U8wnqgz9C4K0RXClXVaSJ6qD5yNGJqHAEGbr16yRGi1A?=
 =?us-ascii?Q?szUDdFapYSR7LWlwdB0rUxCyD1C72mSg5cGbOdjQE6e+RxBZ8rebZcDCknaK?=
 =?us-ascii?Q?g/lr2a41UpatCnbiB8p3R1TFANZ1GUqsGdpASFc+6jyY5vfHvS8MRkPDT4Ou?=
 =?us-ascii?Q?Mr79gJcGoguE7MFPiwHDKBtXLIyPSadbirczeqyYlvaKKpRAJN6lDlJWq0Vt?=
 =?us-ascii?Q?5q1z/HAiThA6m9uxMZLdgb99JBJo15GF9gDSwmzQ5gDmw4/eE7qsloTzeqKs?=
 =?us-ascii?Q?Z7yGwYYsjI3TmbalGStt4WQKr1QLosrZF8FhClxTxbkimheiaqUntTBjg+Ud?=
 =?us-ascii?Q?4de3V7dA4o0Oe2PRA5S5+yHVLXbjRspKjkNGXms5lWCuT1LXpQZYuENgjduq?=
 =?us-ascii?Q?ETB+2c+b7f2Fi4PStIgHO4ki1ctQNa41rWfDTo0Gnh7IVNXH8gXnRCNG/q/x?=
 =?us-ascii?Q?KUipbcQXiNmCX9grboXxw19i5Svev7z5McL+0v14F2IQtARq9kR5XYN5VgVY?=
 =?us-ascii?Q?kCbBD4VCnJcnSza6t4Dl4DX3+gplypez+AsQCTknG9b1eIZWvbG3iFxNe0Fd?=
 =?us-ascii?Q?F7LtoDZ2abSnCohgvrmHCg/kMU5SHZbDGbLqqeaqRBj1Pt3GeIMh88Y6Ei2x?=
 =?us-ascii?Q?vwbfBUEgvTeJAWVUUVsCClWk/YznvB3BGbreDJSZr/QZ6Ugx4HvqlRcQbQuY?=
 =?us-ascii?Q?gTZ0V9hA0EWR/GZHFNbMbbJYsWdR1D7LAj3H/ArTf72RDv94MmFY4Eo9XsaK?=
 =?us-ascii?Q?Am8VItVcZSx6hJ/3+TmXESYgGS6Hre9O+ZOc3QoRm1Y0i3C26acjQSayzhAl?=
 =?us-ascii?Q?3dfCOvn+rWPx1orsFZOwbSg5PaIcQmwO+oEuxrum?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /OXmC2BCxaslQPuxJJUNOQX4hiGFSkrW1JTQkZhp291pUpqF/EbEKLKBVjxG2IVwuRWb6D96mZUwldSOhj8CqIrk/60T6w0ypS6qsz3M22LZSJV0NN9xCfXoCV7ezyN3OeLWFqS4QLO5j9n3mkXL2GpWbFZwYhWwIxq/GE+OWwKZssx5NbY3FatQFTpmj3znYEziCnMa3UkxUIpPF5bFLf11S/tSVBNk000JvNSUH6Sgo/rLlsX+uejEJ/lntcWANDTztaTmz8j5jJbZhmvXL3LCaE0jb6p7BfuPGfG+wFHSxXw7gxlM6rwuWr+G/Xx8OVkr/M68wsNi2FMCxbarYsaGEE52n19D8dBSnJNDyR0EQVAJZX/hb6cRnp+6+Q4oTRSXNue0cZIrX1rPpfP5YHPI3CfmsK8wvecf3MG7XLbBIv/bdrckQz+0hQ49D0aQGrkPyCknphaRdwP68l+NdHBhPG3wQMSvvAbmlPDy1tVWRTcZSwAEBnk0nmIdU0mv4K8cslQpFFH3bBPMlcssdI/CkBip9m5nmS7wLzPDA2OO54/i86nveOf+8Am5dKps+e15wVFtmeTT7t1z5y21R+lo746m6lfCXig01RBGSi9q0H8M9UHTG776DP1JO9F+q7TwNP798kbuYE75oiX/9ENFe5KSkt1qr9YGpFzVz/jJwwCU9TykXJBzNYxim6ynphspO2eY0H1Dj+HJl4jwuONwln0fMV51gf1cDZXt3BuT+hxa5MslZkskVkjoaai5mPQhyfahpRTobIyPHdAQMleFPLPHPPVx6bx0F+2pkAn2XovunALc8g6ruqR9Gr4t6xgX+ZqHlrflf5EIu6s9Zt1csUrjp71zOHT6+IG/1QetjGqIpqB1Jd3/AeRoO4rt+t9OfrJ7VClZDE3JAdqofA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30b4ddc-9040-46fd-d14b-08db5063cfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 08:03:01.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hngDijn53kwavg7Qf31j9JJ+A7s0hRDvtMXO8bB9fTQMyZiszm/cGOuxuYEndVhm+v4hNEdGNI3p5wUOTnN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6712
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> The tags allocation is limited by the fair sharing algorithm. It hurts
> the performance for UFS devices, because the queue depth of general I/O
> is reduced by half once the UFS send a control command.
Ack.

However, I think the decision of that should be of the platform owner,
And not in the core driver.

Thanks,
Avri

>=20
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> ---
>  drivers/ufs/core/ufshcd.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 17d7bb875fee..e96a50265285 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5149,6 +5149,9 @@ static int ufshcd_slave_configure(struct scsi_devic=
e
> *sdev)
>         blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>         if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
>                 blk_queue_update_dma_alignment(q, 4096 - 1);
> +
> +       blk_queue_flag_clear(QUEUE_FLAG_FAIR_TAG_SHARING, q);
> +
>         /*
>          * Block runtime-pm until all consumers are added.
>          * Refer ufshcd_setup_links().
> --
> 2.18.0

