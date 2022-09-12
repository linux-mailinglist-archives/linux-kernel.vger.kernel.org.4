Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFA5B57DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiILKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiILKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:07:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3F1A045;
        Mon, 12 Sep 2022 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977244; x=1694513244;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XmKZ5DBgP1k8DlbQZdtR01KZpT5gbRgofgASrdtoCgfKuRWMa7Zee1q8
   3TYcey+oOh6RWdz0FSeQwzsNzIDMw+IOKWbytFfQBQQgy9ZfCruLAQaW9
   DXYKQ7hNlZx3qpvnPNA1Bv2bpDy5r92FqcVHuneDgSJ8ZXxA7K8ouYl4o
   77b3KgnckyQrM1kmXZBQpPxcZHWUBe+kJTr+7fBOD6pO0OKQxrBVtpF+7
   xRbhwOpAJTaTG/SEduL070zdBavODsF0/sOC8myPVh2Z1Z/61WxVS9Tu8
   2XeU/m21S7bbstA6q+Kdw/6pdW5lxhLr9fc4y7OcIcV5JMwPd3YizH8iz
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315397324"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:07:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prjf7bKh7G4nmZT3gI7mfMOHw5ozvTSnMwrncioYmtwc6hCLzvjyzOcKoJaSkp8pHD1ZJwzjMz3HFAZJFwIANl2mqdiHiD3c97M+p0tVA0bCY53wY/jazSwmmS9cmM10xYPDwWtOKqgIXSI9/GFKQV2ioii+MqtLqA6O/wNXPFuLrj6hFIU1DEjRTI70zCYtJZmK8ufPtxskUhME9Cb8GD4uXKOrcwsziLZDsSr9iKQl98JlmyznwIanZm0BUV6y3rPxw6pctRNlSuUOjrrO2y5n7MqgtSnIjrq9oY9YWn9J5ITpmaHJm7dXWzUDG6r5BJ8w6oUE72cO/i0AavHWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WVobDgj887Ez/l9KPJh277gj/ChMYXt5lBaw4+c0MEVy8+K7bw0JrJofweJyf3+g4cu/qExd1WrqvwDuHNLWJUJ/HDxh/PYRWDIhzp8gg8l6RVGO0T8s4/t+aJNtJVAQS1OPcVES6iaLib88QEIJg3M0g9xQEoXKgKMSzK12EYsx0Q8g8WS5OGgylIEfipSgy5Xy46vgdvFm+TGoHSoIoxZ+EVnnGmEkLSq4eIJJ2LdWWcdk5Nxt74EFoxp+64IM9CfTvfN8Fo3zgOP7HoQ/DNz9OUKegK2S6vwHBtltBPw4MJBQKmCiAXX4Jpu0AXvUBCv8uH0qhwDkk/1scgCmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Jf3+yYoSK51/FHvVoqHywcPyu+QScqVe8nn80L53bNz1ofOCVDmOhppjgKHDFBYBbNe2qhdExCVkfOl3HhghON2VxF3fQtegG6KuqS3XpHaL0tnLYmdzwTuLZ0a9QntMo99FkQoij0hUGfhmKCyMsM/LeattGqLtLiZpZ+jXrbY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:07:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:07:16 +0000
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
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 07/13] zonefs: allow non power of 2 zoned devices
Thread-Topic: [PATCH v13 07/13] zonefs: allow non power of 2 zoned devices
Thread-Index: AQHYxoDnaNrn4mY9t0ukwL0Kst8xTA==
Date:   Mon, 12 Sep 2022 10:07:16 +0000
Message-ID: <PH0PR04MB741654A684770934E6E533759B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082213eucas1p239d6095dab9b042f05efd3a6e82bac9c@eucas1p2.samsung.com>
 <20220912082204.51189-8-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4740:EE_
x-ms-office365-filtering-correlation-id: dae4e84e-bdba-4e95-3095-08da94a6922d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzaLZ7KoNsNsrT3QBeEJiEdkJISCj0tV8/QEWNLgK4AhKm+BdqytBSrjNNyLR4VGDZwyFmLNMeswS/rlFW5a/CGIWwgVcfYC3f3YvRSdK42WpXnB+bpDd5eRuxt3dvq8D7vbK+oLdKvWPDCtS53IsmJg7EIrcCyCVTUIi0hOrCU3MaqIyc5856z6ZEKBzDofejQkWyrMd7YD+caI272G21Kw8z6pZL7vWO4aLSmZ+Fahg9As3Xv9NB9dXZuL1w0kJAFS9OoZlnHj5ODMmi9P2rYx91+nCDullwU19O18SSH/WLWNGQW8laYHR9rmutRNAkEfKJJswa53dszBJKdyS2o1Mu5NHtFp6nfroZGWs2KTg+no2Ewl7Fv3FtXqlXGSvFZ/G2JBHcAj5ePi9NOeyTI6mn03rD/fmPMr/xL8+3KagXaQP/3ANEEn0/5pb2YRGYMepoiINiW5ENLD08o4Cg3hyQE8WAplJeM6gJqlPX+NYqMywn4WrmD77Xypgtlz8FotcYFSd4mMtJyZ21otIvL+fKNaCpzqw5EoGUML47dlPRlZoXWUG57OdgcHT7vmwigGfaTL1e8fpZJVHRqfpzsdUkH85gOZHOdwZG3cSHS78YUXWSWOt3nDLYpNr5Xi22cMLRvoU/bvgFpJjvrVqi2xGJQnfcMFQzcp0AcfnBQB+3Vc1Y8Oys+3eMpISQTy7WC5zTNymAZmxWH2Bwe9fPyg0I87aHbDjsM2xOeZ6H99ruMp7rC1vMVGzgwTOn/ci41/A2EjKXuNVnFXXyUz4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(33656002)(5660300002)(186003)(4270600006)(52536014)(2906002)(8936002)(19618925003)(7696005)(6506007)(9686003)(7416002)(41300700001)(54906003)(38070700005)(55016003)(64756008)(122000001)(76116006)(478600001)(91956017)(66446008)(66556008)(4326008)(110136005)(66476007)(66946007)(8676002)(558084003)(86362001)(316002)(82960400001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KCsEk7odCjfEqwcAWs2yRb1dNFrpcoKU4FGhJG2xvbiGDPSyOEK3SPOJCX?=
 =?iso-8859-1?Q?URXNj0RjAAT2DbaIkRXK1hk1S1gDPSu2a6gF4uxB+sgxzx3ZDnVHwHQ0aO?=
 =?iso-8859-1?Q?F96DKDYFnTvIvxOcm87R3IqCydrlptj/uG+bCm4O7gF3h5kJ8D4dNotxtJ?=
 =?iso-8859-1?Q?Lg7qIWCyn0XZsibpiCoNYmX2wgKqOWDpu+gWxOHr/3GXlIx1W7wlzAH6T9?=
 =?iso-8859-1?Q?BU/KCTT+tKYFpDEwBFvv1pez0bsFh4rCSyuwcZDgZshGlPiw4iLlVsgQzK?=
 =?iso-8859-1?Q?hMe5yHxNpIQAnQxupTGDFjGdLi2BWN+yOIGzfnEc9rF+tWoWE3a90GHczT?=
 =?iso-8859-1?Q?fckJdP/4rqNhcdLw5JcNy6NC5bcjIElAVhBkGqzFLc3SGHlwwQ6TFeq4Wq?=
 =?iso-8859-1?Q?pixUuuiy76laV3X+lgKi2ujqF3RosqHdhARy5KaTkkIl76egweOb4FIU1A?=
 =?iso-8859-1?Q?F9uQ0lOhNqgRgridPdZoFcbIv1uO36oS+tcKqk63cXXdRt+vWpbDMq3tFe?=
 =?iso-8859-1?Q?fFlJ7HIOtFu/dQy5yvwwD3U8kV4Amo51w4ZgOl0Yozf2lxkO+fTli1sL/j?=
 =?iso-8859-1?Q?nw1vUeGKbV6vso8Jc0xVedI8XFAODYZ3XJTmoG3zWdnJ17/I7ejd3pFmuW?=
 =?iso-8859-1?Q?a9uz15OeIwImkAp1xFT7a79nk8y43gk1XWqfWGSNxEbcMIBPc0XF88F21E?=
 =?iso-8859-1?Q?z9K6qubSA5X7r5iVutEU9vShJtvzc2f11WoTijTeUHu2C+etFsHT0C+Isc?=
 =?iso-8859-1?Q?QsHbL+nc0bNb1uVL+CXUfR8vS6NuuANdyNykf1Tj7YmkErpIPsrr0jEBQO?=
 =?iso-8859-1?Q?KRQp/VID9zZ4Uo9DKcmZrAXw5sJralFvu0D1VImEvtiiW0F4ZLUHqMLyi4?=
 =?iso-8859-1?Q?4u2xdKRoRYr0XMkcvw5JieQ7T6Az0qihCme5Sz6A3h903Unl0/0jD3rXBx?=
 =?iso-8859-1?Q?r+j7rkcPnkxXiX4ceJJHHeKByR91IjeQ71ckWatwoKVa4CA2w3D5GPhSPo?=
 =?iso-8859-1?Q?fGWG/EPqtzmTdTaqwjb+/tOwfUMUH5HmQgxWD25HYBqwu9NZHoLBhv8mKu?=
 =?iso-8859-1?Q?57r9nwUbmpydzQSLsNXz4MVFK0Dam+kt7X3Nis8Sy7iNMm53SywpdeNCYG?=
 =?iso-8859-1?Q?pffOUX1zlTqUntx6dUf6ouHNmwOFqqmbUJgPCCWDjDIF1SWFMDw9UuUFS6?=
 =?iso-8859-1?Q?31PfTtXg48Zd04x8hBGZ9h7kTsaKE+KMPFhphmig+kCoeJU0aBUFwAFkjE?=
 =?iso-8859-1?Q?kC3wymktr+1emxVw1Wns4sbvaNyHtGRqxdIMZuIaR5SofCsIKaMN/o0Xa1?=
 =?iso-8859-1?Q?PR2B/BQ98Wrd+Yj28G0j0zZzlt7QM5ckraOg8Eq67ZMpoOCv+QTjkHKbOx?=
 =?iso-8859-1?Q?QU0k9vhGx/nii1X6mK4S2/sgGDx0pjJ5ZODZHWcyrhEVT6skvm8hGheiYF?=
 =?iso-8859-1?Q?nZPxMO8ZxqAiWk+Bz254/h0j1ih5HWsAM+x8wCeYoVegKvw2sJUrgimqss?=
 =?iso-8859-1?Q?FC2yhNsKMd8AV7GDLpzdjSGUjX+Acr0y9uMXoce+Q9XevyM8cVva5AN2lY?=
 =?iso-8859-1?Q?ZIQv9/S9Ea9+OnHJVrj6DfJ3lqydmef9d+v34vYfqPR0GJ119ISZ4MRxlI?=
 =?iso-8859-1?Q?PYlVK7NurPYvlb3ItS0cGlkFqch9uqJ9Ljx3daKuIvEuyg8w4ndDrPUPbs?=
 =?iso-8859-1?Q?vw2Zl6cVW7JEGm5q2jK83HCfLGQDCEorElz9kzfnF070MD0tZ/j25ylKjB?=
 =?iso-8859-1?Q?x3B/+D7Iz7bIKrCb3okWorVao=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae4e84e-bdba-4e95-3095-08da94a6922d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:07:16.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndEWTXlMNECEiLY8GXuUBH1970H/I8xzWyqInAU1xtJOpdw+hZRO4BofMl4BqZM3SfDrW7NUZgaDxKvCFnBfIJcNXhNHzY/MDUJqbDlPhaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
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
