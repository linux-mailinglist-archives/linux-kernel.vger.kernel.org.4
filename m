Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B9260615A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJTNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiJTNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:18:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0705.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04501B2326;
        Thu, 20 Oct 2022 06:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixzl0OXFLN30HItqEOZIJB+QFY9K9E2b79Ex0mA3w8eHAtsj6c3/p/cV4gPZ82revovlQky2pf4OJ7jVXQyg9146lCjz0Tz0UUEXZEAes+i9uk5AToqM9QfqjX5Qg1m6K6SWcxk1mFaPa0D+eCJxCanGDtIKST4sxnn3CrYfWR+yiWGr1tbl6bN6VTqXgdQdiwQ8jtUg3fNpy/cuipRhi1GOjh38iJdTuBgEfpVEzlsb9E4gsXEBUg6IYloFXCCg8bmKPZYeTbS8hTfib/i5JoICc1+edZqfbSRDgSbAOdPKL7qPbGvloq0LK2+XFDQBDZ1QUJv2bu4ZARQ+xYD5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjAnBXhLkwQpLKBKKEGG5Sf1u8GNrCyjp7MjS6rgmmg=;
 b=iDDotWyrQJfGqxiWfDlyVoVanXW3+MOExNXnrV1opz+TK3hFWRY1NMw+e5sLGwZh9Cmuj4Ha2XCxJkmfciv+xd3jkWCQ5nliN20boENt5H4LUM1nlvDWEW4H3ba7kU/NKd1cyD+Ldr64QNx7P08X24xB06aFnhrRrvcNg/6LsQIphMNofk7wl5dY/weO0ueTwpd3jzkdxstLqnkZ5bJvvMwlZ0PbelW6BJIMkFH1GHBSCoEgsIOcNzRdReETC6e7zqZ+1iDsvTuZp5Bp8Z418dG8+K9moBKZkio+H6b1fCfi5c0JQaVevOTWUY11/S/QVR+KPqAvzBqlNGxuIIZ+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjAnBXhLkwQpLKBKKEGG5Sf1u8GNrCyjp7MjS6rgmmg=;
 b=MdjRSicbXX7p+QOZhzecLlr0U3J+fendMEsXFwiaxpUKldpm+RUodaXnGAmdGm2OoCLNesw0N4bCxpdoQjQEj6yIoVVyIz8P/fw8xeSPW9zXT8X6PEYU3hiyXPDPn6yg1U6USWEKrYGKpGplZFZ03LHJ+dYO9RCG1D2+TL/iNEI=
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS4P190MB2022.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:51a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 13:14:45 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 13:14:44 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Topic: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Index: AQHY45PTPI7TLc+fQEC4CnOCf8ArC64VZ4UAgAHcf2s=
Date:   Thu, 20 Oct 2022 13:14:44 +0000
Message-ID: <VI1P190MB0317826F688A57D3FBBB16BB952A9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
        <20221019082046.30160-3-vadym.kochan@plvision.eu>
 <20221019104654.7ee35744@xps-13>
In-Reply-To: <20221019104654.7ee35744@xps-13>
Accept-Language: uk-UA, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P190MB0317:EE_|AS4P190MB2022:EE_
x-ms-office365-filtering-correlation-id: d940a562-14fc-4892-51ab-08dab29d0e36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJQBKQl2P7z+zqP7NehqvHrPkQikPW9d1uxubHIb8knOMMcHVgE/CzUe9DSAUV7D1oxo5SWLq4POHLe5Z5ZNHjTNPnGdVVBB6R3CqD5SDa8lamUtCAGevHqPE+aAp8Zjkv0U7gfXb62bPIcfgus49dm1lK9N/AGxEezOiOsJKPFy4n0ur9oo+kjGy/uQy+Vem4xvFm2+WvWDDBmpNWhAhxZCGoqWypcMftzy6xpBoeSivWHLXNKOsELbzVJzFph8Ebm50DJxLc5OvGJobbfKKEId9vGAV8y1rjnmntywafIE4SH1/7mkpRigEcroAal6YkE5UEHzTcQQ5QbixPQAzGWRl/jWpN7LJ2kQ+I9GDXrPrIxozsUwAB/9lyRaO6hhRFBOirQdzjf//RLKAtHZEYVoCe8+p+un4gOjVXvHqoEslwqqs5M3Z+jVAI3C4Jci5H1IDG1QOKwAFtxnTgKRrlmNayVTWX6aLS6FMMudGLUCOTpeaFStvSYg1NBBoH3SAXbCJ8MntmRT0R4VmsDPsahxmUQZFWpbBlYam6HUsVTtcLiybN+S/leDcImIxt/HyTbLnKBqGYUnUS/vA5n9KLWCSGXoVBTz6NWtV66lW5/o5x68iRQz2Qj9HYWadyoU0qq8Oy9tGoOihu7U6SgtDrrKDsgN6Hgux+B7uSw6SY8Q5Ygx+K04x9A3Rwn/5NjB7JY4aYonSKg+YhkAnquPzzzfrHfMoCNs5He0pKnM+n3eU2REKytQq2pynLPuajkJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39830400003)(366004)(346002)(34036004)(376002)(136003)(451199015)(66946007)(66556008)(91956017)(71200400001)(5660300002)(66476007)(76116006)(54906003)(6916009)(4326008)(66446008)(316002)(38070700005)(33656002)(2906002)(7416002)(64756008)(7696005)(6506007)(122000001)(8676002)(55016003)(38100700002)(8936002)(52536014)(558084003)(186003)(41300700001)(26005)(9686003)(86362001)(508600001)(44832011)(41320700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-u?Q?NMGZsprsStyvdz0aU7C9MehjfwVXP18eZlRtEyr955veWg/XBQQW3T5Gm6qbzk?=
 =?koi8-u?Q?vhxpG4GZ5O8q2SF7wLHN1CioMTIgXiIlAi9OZkGEndelxE+p5oE3KM8xeNfrZO?=
 =?koi8-u?Q?Em9A9L2MdiTaB6xfJ/AHGnTE8smikNp2EolXvaQLKiCk+k6m4k4zkY9FOLE23V?=
 =?koi8-u?Q?QFK5QfeszpMX+M4xvA897Oz0KNb2oP3JBz8UI8alx5s8hrdedgJ3V5kb2SCn9g?=
 =?koi8-u?Q?Kr21DPavUlboCv/zwhqlAQ3k2l5my9/srDAmKFZKXeMASeEzefuE2RwEiR07a7?=
 =?koi8-u?Q?s9U9UMdSciHiyURhmT1ihdiAKShQ8kWMDHyQoQgpLYFxcD64caSeomUqBHCuUH?=
 =?koi8-u?Q?uNOHEdHHRZW+DN1fEOcunORFYTNnp9UKYeFbW4XybIj7eVmQm/bZ/oR0P/uQhO?=
 =?koi8-u?Q?cSN/X1khrHwDWjKvdPa69uk9NB84qpiZym/LXFC0sXTVXhxrikjT2C4m4ZkT9+?=
 =?koi8-u?Q?/THjf/OVjg+KuNvqsp/kqJRLgBdZ1krGDxqVqUtYfsCmO7dFND82l3ayPZinid?=
 =?koi8-u?Q?iCVQvIa38/6IbRBeN8I4uQ6kUX4wzcFrOgUBGDzNhP4UxicHz34XuWp9rrm4DL?=
 =?koi8-u?Q?JD0yxa2loCU8yX9aH+KwBP3U0XQcjWeZxff3LaGWVtH7d9pSu3jauiWcQUeuvd?=
 =?koi8-u?Q?pmYLxbl9zyR9asl4GIFiqjmop/zYSf2owV0xh8xa8fnt+TYmLBgO+W1cM3PQUF?=
 =?koi8-u?Q?SROetX4JRNoKcaFojgwxnOJ+NkflmE9I/LTpjIpbDamGetUT/o93kZhlByfEBw?=
 =?koi8-u?Q?E0K8asDW+GYABue9c5cSwl64Snt++dRrRBbYxn4wL79A9GsmFry54r2h+KRNtd?=
 =?koi8-u?Q?euczc5dCBm/cH7kWqwiocXeLv1wm5lpJ5CtQyxG4KeFsfzyIS7I5oJLPszzw+l?=
 =?koi8-u?Q?eNLVmAntAfmI4LJhyDqq6604OJixOM3kE7yRGXx7TC4rA0LPw9xJdeyw8TmzSY?=
 =?koi8-u?Q?bg32JaeaPtpta41gDsqkXJfNeNEnjQD1OaEFNkxApoJRrMmfwLaZNOiKSrKAif?=
 =?koi8-u?Q?KiMfhLDrKR9b+r8Ud1qVe/Xer2P7HBJK3moxZDFH+oPp9VCU/+kwAZwifM1vXa?=
 =?koi8-u?Q?3jDGcXtVhyAj6mVPbe2g4fp0OMXAKm3mj5DrICwpfsScynkWRQr0+TT6bAzkYg?=
 =?koi8-u?Q?xYGdP/9Z462Yct8qJYkuvpkSaKliYihy1izC9xz1z9WlzMvEansaRwjeuWe/dU?=
 =?koi8-u?Q?qpj59gIpBMgZ75A2sm7gp13/2fQl5FQAbp0tlTPy5E4YnoZh2T3RN4sIgK6tk4?=
 =?koi8-u?Q?EPaz4z6OfYALr6GsfSFtC3Tu1AQc8vU8c+sxfOidsogSv919lgYwP2Q3SGtaJR?=
 =?koi8-u?Q?UkJGLG5KbpzTvlYdh5ghxXE99+WmHq4M0pa8h6sj4mM4+gEB9+/bBeF6LKhHbR?=
 =?koi8-u?Q?/kVMBuOCMh07FJ4fSi7kFKJBd9mdjl4DuV7RDskUmwNZKkGdZ4kOEiqUxfTnAG?=
 =?koi8-u?Q?D1R2CMi2hUxnAl7sH5XqZ2NGG+GX1H6CqqFD616IzM9grFn6+yABAQR9zJovsB?=
 =?koi8-u?Q?dkf/jmyDuCKDUtMkDV1XPSyo5LYbtuY1qMexhG7oUZ7aFpopAu?=
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d940a562-14fc-4892-51ab-08dab29d0e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 13:14:44.3928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEFzugzvd5IuqVtxn9TOIDOh/n1HKbBFm9FQGPyg9b+WNqw7iqPeLchc2yUuZh5B42ucxpyiOvd0JMXSoZi0B7u2WudcRMTwlH7aipj7YME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB2022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,=0A=
=0A=
> Could you please do the yaml conversion first?=0A=
=0A=
Sure, will try.=0A=
=0A=
Thanks,=0A=
Vadym=0A=
