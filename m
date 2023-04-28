Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2D6F10FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbjD1EXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjD1EXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:23:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4282728;
        Thu, 27 Apr 2023 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682655810; x=1714191810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L5MD88DJYJtdLhcaPi3S2dh6wXnAhzJcOr2FiYw+38g=;
  b=onlz58UsB8mgBbE9I+HfHuNv3Sc7yyKI/I6k0vUYM33HDVQuXgAm6xA+
   UR95++LICvIHRX7h98UEDmH8rlxQVEmSARyIMx8wf/7t455i+BGIzvOkN
   2F+uF+Nj3g4xMTapoxI5qRaC6obvuE798/evhg8KY+1jzD4//+JLqxNkI
   TOI0mFpKVmvHCDY+E++tyijeif0LGjEEkE/70Z5Nfazj0S6rw8dpB0liU
   ULK4RIgDbjDykP3YhgJnt7tgm2gEF9MNYO55dlB1kZKOCWpr2way0SKCZ
   Zcb4zXxT6HEQGW73S9VO8RAaqEb5G0Y4JPd0GIUb/TkPvKgim4TB0gesy
   g==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="229510762"
Received: from mail-mw2nam04lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 12:23:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuI9a321y5gl/B8eMBc251MLUARnXKwTZJcU74kXRFFTaSODHq8UtmBKwiL1swabjFePEVWGklKn4OLehpHvhs5phuhVBjQws0DF3MXKR1T27rPgQXsalpkQeHuBKT3pWi2AVh/vjP7DF6w2uTxunMUabVSemkkJ2qKrfSAn1mNqVCjcrW9M9gxQkKzuOceEQV5KGON11fdxRelaBBuVlk6NnOdFhsd+UmxrAl6SN3TedoPkbhSRbFOAMy4hTNFu2AsV54W+GpV5mkLAo/BBYJB29pcPYPKSvD2/cInsexMfDKEf/CKPKHtFhjuLC3JNO8XjEyo+B0gBbfIdh97etA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5MD88DJYJtdLhcaPi3S2dh6wXnAhzJcOr2FiYw+38g=;
 b=LNhExbrHAzZqwBSUrd/DDSQVG4LkICtkikzMJus5rDTY3/86DG2S+rYFba8AKzV5dJC4I8+oJKWpTFAN2Nz+P0/cIrhHtuEP4ZNFDZe9jU/AOnc5hP94OtHekfePPZ+F23egxrjVYgTbWRCaCkt2aECQaLoCU0b1TBdzurhuXwKns3K2cbtnoO+d6FOGeNGyade+BU8vxMO3GDnviVIyBlILOAEp3w4xHYjXc8pXnCKWvr72zTlYsz/tUh9I62BU7hj3xRPswRZqlcBymXuB6Voj+N66/+dbrbEIku6ywc8oZr57k6pYarqCDh+0CtgFqFB82JFwCJ5ki2qvoPem9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5MD88DJYJtdLhcaPi3S2dh6wXnAhzJcOr2FiYw+38g=;
 b=yxS6NENt2pXJUJ7noyRNZHN6aPhgweIlLajv0lpLNHjmS5fvMKto2KQDK2ojAfRC6Yad1xGkQpLEBEmJ5eemmiSrsPcRQfyiPBvsfkLxN1WgOpln4GExTyKqfRDs2ghwNxpubn1NiqzGfNyB/4lISyYnSPBoqacNrd5hsUtRY+A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 04:23:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:23:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery generation
 counter code to rc
Thread-Topic: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery
 generation counter code to rc
Thread-Index: AQHZeYktixpAexx2ZUyKnK0fVymnFA==
Date:   Fri, 28 Apr 2023 04:23:27 +0000
Message-ID: <2nqdgwhiuvjsupuunxzzcoeumxqz3cosx52nhgtrv35u7nqsiq@2is3qc5gftl6>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-9-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-9-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6479:EE_
x-ms-office365-filtering-correlation-id: 1ce1bc1a-7154-4303-4cbb-08db47a05052
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wya6jeEbnG/fa40w8e1acPq68jLwvsoDoageFyQ0gHDgB5gzStMIwzIz/4fBNIQN/Wb+HylpkSDo380m+DCgHkFTDw4sCIOrm54ZLVaGndLMwNA1R+Uk0KAGlEqrOo2Bbxvj3sji7CduuAHpc/1ATQEYlo2J9thqNVxiwmsF0vGdWxNuuzvyJRRWt491aRd5kDKt9PNuPxopaVcja/74Jcj+itQijW2LjVZviUFBPE+/hM9aX2J/pUeaCa5N1FEFHTL+wnkdWQ4H6J8RYK+5qsuHesqG/2wvRS2hACladg6qHivqN0pdy1zX0H1zzCwxJ/Et+CcP3EG/CP+Nz/sW/UNtjodfktENpSDpKieHMaCYq0l+t9BEu/4Pe7WHAaHpw2fKGazZrRucjI0UNmZR8vPlEZ5vqUBqugkh8yDj3SOAmRppHa4M+dVAbTf/Vs3Kw9zqD+9PlxwNHlwlXJWT2yxS6oVqdtULl4+/BwAc5f6K+CSW1GU/ul6R7DClEtCcO9p1ZUUD5bTu9wD7w6y/d4lnWJcE5wiY2lcjcs+QHWOqj+/dX6JaW5EmbO09wvjGn3vc456hnbGoVI+V+OzjqxwnD6NS7pFz4wtJB+Z/ha8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(9686003)(186003)(6506007)(6512007)(26005)(83380400001)(38070700005)(64756008)(76116006)(6916009)(44832011)(66946007)(66446008)(66476007)(66556008)(122000001)(82960400001)(38100700002)(41300700001)(316002)(5660300002)(4326008)(2906002)(4744005)(91956017)(86362001)(54906003)(478600001)(71200400001)(8936002)(8676002)(6486002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?60cyMXNejbxLoPytmoLA9iWPfQ2ub/QB/xdIY/jU3GCGuvLFQ8GBMvEb2Eke?=
 =?us-ascii?Q?8MK9SMRSLOM4XD0UFfonjMYP/lxd8xnr9/V0SBNTXcBR4bwidHEPpewelLbN?=
 =?us-ascii?Q?ylpmmukVo8VYuBm87BVmGteBB1bROB2NltNNo09zL+XxtCURvyULod02clEY?=
 =?us-ascii?Q?4kXQ8qSfiwsCS+EnxnGoc59STCTwZSK/w0KL7EOddlWHmsSyChc9cshr5l99?=
 =?us-ascii?Q?s5UH14CR6hyySK68bKGOjum6c4UbUXhqgbdEqTWlFIiE0ZMfOUBCI3KbQW1T?=
 =?us-ascii?Q?Hs7JhbFRz2I9HXZV+aNakyAdvRDQafwCTv4aoh7l5KNwIEOlaZyMyQtIjKxN?=
 =?us-ascii?Q?mSOq+c9wLAU7druz90YXgq3vf+RVDdCYUZ5PCqaQI63gIK41TNRa/0IlViMg?=
 =?us-ascii?Q?8v+XKzYPttPbopdh4tqzv7UpGK6WiV7xAd8f2+wIDIcfu8UmUwoSr94J8Gn/?=
 =?us-ascii?Q?qKntif0JYAUSrwl7SA2Fmy/LdukYX75nRBzLBiGKK/PzevsXdIw4RJMWrJ+E?=
 =?us-ascii?Q?tlbb2qv1mUsFyfBNFlKk7TmP5zxQWLcBZnvploCB4xTRl18KmBrwDQ7h+FHf?=
 =?us-ascii?Q?oLFALvItCEYGArbI9c6OUSe7+YxGKaRZ1RZhec3KwQ/hmpihxRkBDYT9sYAj?=
 =?us-ascii?Q?7WojZtiH1iRTFHMotFEo+I+F7fxj9mnTdyxA558G3/NLylXQO7n/FaigLEwa?=
 =?us-ascii?Q?aVzrLdWO80Rj5iowRhDbW0bNX3trMH7LCv0gEtJ+7BrvgI84SA3rfoZdlh4b?=
 =?us-ascii?Q?UZ/K81ZsNyohbiKJp5LdGNDLaU3UHHBY2upm58t6FRk2op4f6pujS8B5oZND?=
 =?us-ascii?Q?dJpFkGDDppFA/2RiIg3vs/aIOLbO8MzSw6KfBGkid/I8N6bJaOztvvPiIV52?=
 =?us-ascii?Q?BQmXNj0JrlhwhxwShitl8n5nKBVX2Ncbl6RDpBo3JzzP9Sh0INDSTGPMpio1?=
 =?us-ascii?Q?soBpxvtWAaADmmr0Ju/YCcfD4Kzr25YU7FA++P91fUQi7yGi/alD8qYhqTtz?=
 =?us-ascii?Q?8Cj6WdwkoMtzQrg/a5AdCJgblh9fixPwR5jgfy/7Jlef2XbesgL/0fl9qKWE?=
 =?us-ascii?Q?ca9AOvkoZxjOVAK6aYn8MQf2XQRCcGF1V2JxYzHWnxATRqL8DgaheHRCHyjM?=
 =?us-ascii?Q?B99vHNFEAo1hSeW/Agw2IBt+ZafmimsohQ7NKCz4oT9Fb6GcVuYOiElvN3to?=
 =?us-ascii?Q?Nc57kvacQXqvGXOO9pzjh5JnSgkLyAUwQK51F/V5HsIG2ryO3gwuv7Rg0BFZ?=
 =?us-ascii?Q?B1R+BJ10kLDGBV/J2NY7wc/8p0IH1/tYHoRrHmnkEleJXnbHi3NVQjcs8b1g?=
 =?us-ascii?Q?4Uit6EdRo25A66M09GvgPV43DneE9VEDCImBWczy+HLmnR2J9GZ+o+faQ2pI?=
 =?us-ascii?Q?Yib4FxsG+TwES0ErRW9HUm/e39GggR3ZRegthvKit4CAwo5p+CQMzQHVGdfT?=
 =?us-ascii?Q?TXIzAkGBqy8WbQWQoGrFf+jhEPW6sF3yEdiupOKW21KjMIxtFzr190IyxYo4?=
 =?us-ascii?Q?fkcNO9d7AdCi4qlup/qQ/Hd8ZrkZZHjSIk6Kz827zqUlJKCPiKF8a6Kh1r6Y?=
 =?us-ascii?Q?n8DlwXYtW78z8G8GrHZ1ANK7wokgb38Q1UwMHRCpOtCS0FKLMu8fvL8DBylP?=
 =?us-ascii?Q?qIBP7pg+Uz4PsVTQS6iYlok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93E983362F350747828E13A7A41D06E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DYpnOONo5HODNyzswpr1V8uEcciN1zvxLuzsCtVxz+cyl3CNUbi3zZdV4LvuSlEmZ3vsVSeacYn4Dfx8L6Abe1Y/xXLEZHBba6U8ilfPEJxgF7aszQ+BJKJ5Z751SPnZwvt2L4sYdlETTWbixr0xhFI8eVrWrbN1tn9H8wB3w1btoOg1OywnTOtwufoW2ZTOX/2s8wAKIsdJ8yBEtTJaneqGYLjDziVZWbKZH/ulkj7ql6Ca4q70MiWx56TSRF1w+Uu0BNi57AFr9vPV2+BYK35aI+/smA9v1M1oAqn4R85TRdY3NQUrt0NNSiSwFNUJWcnYr3e3tLIRV5xFl7gprMQC5YEE4AfqQlAlvMZo+t/SOsvmC8rC6gHNN31hNciL0Aapd9VEW4qzI1T9mrk+EhgYkdUiKKuKZPIZKJeQXrezAdSAPRokqcQX/0g1en/zPksW8BP4ekW8QQvSY/v2tMIubn5VN2//fRjPBqO4aoUNytTL4natx23awGbLxPiM5lc4mFIi/P7kLueHKqu5VHO5hHuABlWztl+FlNTRnDpVqr6laVOKUMFidK6caeaKyj/x+2+pkTqs+lZu03FRbcTJqOEP4auWnQGYDEnrytoArAEJj8mrUaplWN33uotx36wNHWfb7QaZ/c3GfvSTNHYnuAgG3oP11rT/yxwuHEXLEJcrG6D0rRSCk2KvLnFJiX6DKTu1DHcPeQdljfPQ8gEcwIzr9D2TUKqKFnGb1vZG9e9mTrA0jg1WxXAm87Ln43HwLjz9A9t8GNm/Q90hPZ46NS7aHA39ChjLIkRamQ8jsVHTduIjLryoKhm5FSW8tnNQIOcnMcnF6TOlM6qLxric1Hh6EkO8F8DU8PO4jROc+IooYv+WJmIblVP02ynlLaGeSQNNy2hQh/LTLfb70WSzejoxSlnfHVTnfLUq6/I=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce1bc1a-7154-4303-4cbb-08db47a05052
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:23:27.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/dJ0VLnO0q/9568RVBlZrqaunHlt1qV9hgsLP/C3F4WQRzJVzSt+GgsyJX4dj+ymzFKlhCDf2ZC3Pt2m9yLeavzF2sLXK+P4gMjhO7OpeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Let me repost this message, since vger.kernel.org declined it due to too l=
ong message).

On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> Move the discovery generation counter code to rc so that we can reuse
> it in 002.

I think the core change in this commit is the removal of discovery related
messages from tests/nvme/002.out. It removes the dependency to the iteratio=
n
number constant 1000 in tests/nvme/002, and prepares for the next commit.
If this understanding is correct, I suggest to note it in the commit messag=
e.=
