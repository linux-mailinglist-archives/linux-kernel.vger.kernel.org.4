Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06F5B57BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiILKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiILKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:03:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21A24080;
        Mon, 12 Sep 2022 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662976999; x=1694512999;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=pNq33LYvDe19Wx/nF7GT2B3dihxil2FaXHF/nYmZU/C8rBiBKtk3CBh2
   9XqMht42JApt7De5vnicp3Z/YlowPQdjz9VCQCb1/6jDuPejtkREEy46h
   p5vNv8mGyNBT492/Rz6VGQR8IpK1pMX7jtk8Jgo9soqrTEXwXTzCngi8l
   HAiHm8zhU7iwLX9jFjFvSeuSbtxZ9d4UVZYVYwru5brQtiqWKzsa7Jxvp
   9Yhw0DXNwNpPi/1x+nkpkdMVN1AE6PuLKEaoFlri9RZGH8+eu1loGdik2
   Fgl5+04q6/BGB1Ro2eqnHB283EUPOPRI+LugCOqmcvm+ee6hrvMrIr/bP
   g==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315397059"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:03:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9bZjWuM8hVraMGfmYNPg6PVVqweSrY0rJKs29W9nyECsXIaw9YTaF2U7zcIay7dx/7XKVvEzSyS0leIh0nnIx8+tB6rKaVsvpsZIA5shM7r+DhJUG/RvgW8zbIVhHf+ch+bl5eD1xbsydPj5+iIUQQpd1mXcOUz4XcPxssqfhR5Q3iUdK0S6YZL6mSv/lpLXSxSSRoZfgsAqfRJYMR5lhotxDxRKl4iE50O40c5PxNi8/aIhg4bv3/vsLkGLzDcZ5efiAdzKKsx2qw/+A+qCm2vHwpJieRLLsSLXRd81gbEKDK4cyVKbV06Trz4d4wW909eAorum1XUVPHNL0o7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FsQkxhdAAH24w+3Ehhh5MnAjfE6jMESivkWNyHfTJnZTXTQQ5XVVsTZjHeCm9WLmr1kafIqsAK6dzagoeu3Z7ajCmHxSJelkWLEi25MlFFy3zHHhH/DDDBnUYtRh+UawYgfIIwlPA+IYoQut6n5zmOrXbnRJJr54CDNF9NAa6NkEIWw/Ojm4ZZhmBYeCiefCbmCixq8WMmiFyj1f6+08CtHLbHihHVwyoro8xcIH+M7B7tDd9i739rj+XKV/7iuq+UkZnOsXg1WswKjT/hSRJWjgSlDvOtBOHRwH2Fe+ZQKwaTF1Db2mkfc1nCQjAzJ5BGOq4+vssPGOVUJ1cGCBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QpH7UvYW/ryRb/boDdB7QW84XkmGXo18AAm8ACUfUjDc7CZjFtwJ02VXloqWHs3Vx8UGWFocx8+0tZBz54eagBoOKsHiHgeRfesEsg6SlmUG7dP8dptJ5uHkoTgAjz9kbG/ExzxBYueJDkqM5MiT6Exu1CTB+Q8ZaFuHNhZBa70=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4067.namprd04.prod.outlook.com (2603:10b6:406:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:03:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:03:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v13 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Thread-Topic: [PATCH v13 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Thread-Index: AQHYxoDXfMeyNZSHw0ik/YfXawI+PA==
Date:   Mon, 12 Sep 2022 10:03:01 +0000
Message-ID: <PH0PR04MB7416EFB3C180859AD88028FD9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082206eucas1p25336d07279850f7009be6b5d1fccf558@eucas1p2.samsung.com>
 <20220912082204.51189-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4067:EE_
x-ms-office365-filtering-correlation-id: 74628f40-a7ee-44a5-e28e-08da94a5fa23
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxridRCG8xjfWHKZWVxwDSlYQC5jMAho3cm5xuYQGqagDNBJhRxTARlp9vQfu/6sqeHc8oCwnm6Q4gOprWCdKuI5OM3tyzUBR8u8LUevqR0blSUXlTOXoP+gQRH1/g/YyLdH+T+aGPBgCDiRDaEbqbWIFHq9e3vaBU9OVQt8aD5NiGzNM1sKQVpw9MMe+hlK6KVWQqvgsBEyWaoyoEC91rrwxwTcGgdLiviYpVXU0nqdGU82N3y0oMv7mPHPnWRPTPnoqfynHu6+OWuylNfeQBZkGFSHYF9XeHcv2AaZ2lIP1cG9BZZigsbNDqCt5KSOValUK+1Cn/uLwlwZwADs9YCoOTurUe5oIzfTu95j4bbZYB8TsSNbLFdFGiP8D+BPoyHgHiRui9Og1R5irOUPALlc07EAdoak2x2mwHgVW3VdaQAi2cOhgM4lXxICHp1ldyQGH+FIbOkItgT4YjNFQvgCZLvcqTlXsajU3wK/cFmtp+m5Lla+cQ1mxcPPXAgNLT5289Mn351XfUFO49tfhscO/jgfny2rrUyLfeEYP3wNvSLLdHmzQf7RLtaqCu955w35NQ18M4n92nps7gimWyhk+nuesO/EAoQ94noe5z9E/muAksQr9GhAex4LT2mUX5HxBMOQuds0kYiFFSZlp02y/M2jRQanUpZ1244iRxhtzd0686kt2QgLAfDJsFAf9RThSj83CDSX0EmvxyfGVJfoG6NgY2jqsBb0JS5XdPlWZQa9ks/pRkhKWNTO3aWGJ9WO7QCmoUy/H0HlNQRtSGAkVrV6T4HiFFVz2g16hUFKR7C/4FJbYYw2pfdqV2UDbXam1h673OZa2g1Aqt0F9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(38100700002)(8676002)(86362001)(122000001)(82960400001)(66556008)(66446008)(66476007)(76116006)(64756008)(91956017)(66946007)(558084003)(38070700005)(33656002)(71200400001)(41300700001)(7696005)(6506007)(478600001)(9686003)(4270600006)(316002)(110136005)(8936002)(54906003)(19618925003)(2906002)(4326008)(55016003)(186003)(7416002)(5660300002)(52536014)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pcruk9z3WqXw+gFXqcJmTTA/9hYwD8x1huC7MKnK5/wtJpXajZBZptJnMc?=
 =?iso-8859-1?Q?djLpC0hIbx4tv8bJ8UQpsntKp0GPZqNDaIqUALr1dOk88BHvKjE+xiMn25?=
 =?iso-8859-1?Q?eyyW/4hou14GARdiQrzNRoW0jOowj0YJtEZDwOyWX0Bm4fasyZntTxJELi?=
 =?iso-8859-1?Q?8Ne+JrkuoVn9/D7KgB6w3Jf7Cjw2OZMEfruJ+RhY0mjab8yW7rAd80LO20?=
 =?iso-8859-1?Q?+7VjV8TynYYab7C7+T8WLOSsm4+ZJ8S5RVwlVwQ6I7El0MmtpbZr1XI+ML?=
 =?iso-8859-1?Q?DX75pApKvK9koWy+5nUK0sgNAww0W4RWFPV3CZbdHm3pCrP1YLOrOQURyp?=
 =?iso-8859-1?Q?nf2L/foxWuPAM1UzTC0jkqYqJi44Z5Kt1FekyNSy3kQ5okTUbwy3iSh29A?=
 =?iso-8859-1?Q?Rln+HcwFlFdwX+S5yryueODt/bjOvN6f/vnQcLij1fBOrSsENEveVZYXq8?=
 =?iso-8859-1?Q?K4T8qoL/eF1Nt/5YkxhZZXsVXTuV4UsQutrRRA3Rj5tiVD/y/P+XGcPtIe?=
 =?iso-8859-1?Q?pHTGvRrVbtSiOSA4ZQQzgKIyAMQ2tMyo8fdO5H2qYrdKmfJLfra84NbRpP?=
 =?iso-8859-1?Q?NQCMfyDH2reqq0JjU/L+4qM211R52cjmbkzy5H29uIDmU0fFfFxADYQRe0?=
 =?iso-8859-1?Q?lCbTw9eQXJk74exP0pHeLHbqOFp2vSdsefscqu/lo5jyVaMz7E3D6kn9wg?=
 =?iso-8859-1?Q?ZBk5v1xnmN4IalWzGLfJKMYpjaV3F8jJ15YwtoT6sHseMDHAcgr1ogno8I?=
 =?iso-8859-1?Q?esHvK+PavKsTXoxZBNv21tvZBvxKH0gnMDFW03D0Hcx1H4ByLxV0mz+eIO?=
 =?iso-8859-1?Q?ajkhuTYkO3hDTh2mSTedyqpEyH7vH4i0TdJ5ncrj/0Z3mESpswPvnED4fC?=
 =?iso-8859-1?Q?zoEOZJTLSHo87aUroNy3VosL9fmXZ9zs+eRWSh5IvWO9kTV6CBGlEODO43?=
 =?iso-8859-1?Q?c2kTUFpAqcOFPUJF/tIk80eLzprTu81/djvKZLmrEW0yKIc4zRFYDiwtI/?=
 =?iso-8859-1?Q?HPbD9z9HmGO1nI6KMcuOqI3m0Uuzr51Xzz0nz5yIXzNikvA5XXxvJiNJn/?=
 =?iso-8859-1?Q?fq9OD3ONFwbKmo0M5/KRh+mSGBi41aqQGZwKa5Opi7+tISwa8zY19fC7pc?=
 =?iso-8859-1?Q?zkDOqgGIf/scTWAD28s+6/fjl+uWRNtWDQAOqvi+wWlRMR1QRHdgV953JA?=
 =?iso-8859-1?Q?W6IllDK3mtg6U8slTXdZLTuRI51buybJXC1f87+wpUl21nVNDIWiRqL5Q8?=
 =?iso-8859-1?Q?EOcIFmh+Vsi1nXNIYp0eQ3ql4rmwSY7QvZRsX9M7kVQxGjuOMdavFSJFDI?=
 =?iso-8859-1?Q?L+92FgKqOjaRkez4ehveVhct25vzKKKBioma/l2/wtnKsZIJx2hvwkSsLm?=
 =?iso-8859-1?Q?ICFLohqX+s8AJdvYlOfyUGHQzCsMME3+CuQfOSgXgOV3yr/LB48JfvMbRb?=
 =?iso-8859-1?Q?Iamtx1gCROqpUmOPjfZCnymxkrZcWJ+hFRpBT+cCROFSzi/u6oHSW+GpjI?=
 =?iso-8859-1?Q?DDpEgDSqSUytt+eIiQBbkkvFOikq9yWdQN4z9M7or6SZXxccA/EOZNPTw2?=
 =?iso-8859-1?Q?Yo4tlZZsIVeADMt9u0oO3wu0OTqi4N2Js+9hWnwzD4OFLXtwcVMHSdC8ms?=
 =?iso-8859-1?Q?FSCmJ8fYz6Mji9Jq/bjPb03BkJgKlC8gfxI87Rw5iCUBczkTf4ZWD9tQbe?=
 =?iso-8859-1?Q?9nJgCrls/r9hUJlRotruWPqBy2BDTVvjwMpx88UYSCRc+m6iCeWX1k1ThI?=
 =?iso-8859-1?Q?zxww5EQ0HXD0O6bCwe2uATPwY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74628f40-a7ee-44a5-e28e-08da94a5fa23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:03:01.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1REMzYDpXjOZVh5i37Fuo+TW6pvjnQGbV1zjV24ovAGN138XPy7Z6ug5COSZVOJp88yU89nDKsHveNYFAYMbjorwi7vySKggmOtHxgA75+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4067
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
