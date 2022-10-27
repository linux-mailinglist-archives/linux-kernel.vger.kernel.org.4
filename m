Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068316102CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiJ0UgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiJ0UgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:36:16 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F096792EB;
        Thu, 27 Oct 2022 13:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg/3NGlakkBgxyycONxnjApHuRJAkhqPYjg8vriA3pIRr46cnRjJsnGjlAFxiux16FMhU2pOgfMiOQrE3p9tZGrK6xV1Zb0t5fYEkTBAWcUQGTjbxEIhFjNnchVIa19RHZ5Ns90x1ya8eaR+9TuB5wJACQJPQtOaBvfFNyoE7lO+T9IuChGHjrcVzgHieU5fbVVS4DRrVFe9DF/cQZVxtSsN0EGiSIgv5QNeHFnvNLAo1VBliza/MytyYpkvhIhw1Jy2AHeEHSRz6ZSRwq7y3JQon19/0Upi3gLB5RAvTGiqjQDfMuN0gIse9YNm/zOSU3aUBB8P8W2YQ/m2Axzkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpDble0rtrDC8cHuoHHWsUxrFTqHvb1net4wVelj+tw=;
 b=C7uzaD//y+of/WCkPgxRh15FdiRgRynLcRHg6jTN3stgwUwWnD90CPVUMNXW1GjV02JldartH7fDF9BOHpPc+wxO5M2yFj6stvYgplri2eEvVYBkZV0COs8LM35yAUFTyenAOpItfmu8AKAeeHQiqJwrN+mupKi8VMS4X2CeZoHNNO0HhSS+/6GGJwUFK4XUhhqe5LRKbqH5l1YGpMGqvcUS73jc68NCQG0LmMAUzwjylDvQve+jPVojdlZDN1PFV9dVct7XoUg7bsNVtjcAeJv6v4VXZFNJhVEVbDL4HPNRiEK7YQAvgu23jOgNLbEYZMEHleajVXpYmkHJyx8M3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpDble0rtrDC8cHuoHHWsUxrFTqHvb1net4wVelj+tw=;
 b=iuys4Tr3AoquCpY4dyGCo2lwxcdWU1QGeaVrW5ULCz0HrQK9lQ42f2Bv0gRhKfMY3I3MLuqtTy8uPBvBYlIbO7KV9DcY05jl/iSA3epfXbh56r35YHX4oz0BngRh9OtlXMQF5eXn+jQXo/Plr7WzeRnAt1pI9fCIWL2WjsY9KeE=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PAXPR04MB8334.eurprd04.prod.outlook.com (2603:10a6:102:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 20:36:12 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 20:36:12 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Topic: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOAgAAGMICAADtnAIAAItaAgAASUwCAABf8gA==
Date:   Thu, 27 Oct 2022 20:36:12 +0000
Message-ID: <20221027203611.e4spuamslzv7ph3n@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
 <84c5e0a041909615a1ba8a4508131206@walle.cc>
 <20221027180445.74btifpmfhkt74zy@skbuf>
 <3ea25819670c088df0cc6f483ab4fe01@walle.cc>
In-Reply-To: <3ea25819670c088df0cc6f483ab4fe01@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|PAXPR04MB8334:EE_
x-ms-office365-filtering-correlation-id: 20b938a0-246e-49a2-89fc-08dab85ae341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Q8X+tLXMvqoTsbgtrnVzVZpYh6B9Tpx4MdQM+fmjouY2avksV8nkF0JV4ksQpdV3x4801Iu1XvsV0TgiYH8wZmrhAzRBue1sqrWJnls81tK11UMpeNkHtqbOTPjbUIIM9pxuCJ2mKzJyrNnHMWuF9oJncEstbdk2qOXf9HDn//aW1POqxwyg89SXzwwJ3RtM3xDJaeGV0CfjcFkRxJdcdZWue6vz0e/8PQatbG1L7/25JaCgx0bC8vWpr7Lv/RAADRUuUMbG09MuR922BfaHwZSOK+LD5Mo/Gj/2RX5EfBjQ8LC5nUVIJdyjU5YAsjPe40GqO3TSExJ5dB862CZUPb5pnWm5yVUn7lO+i7JftJCEmnScJOeQ5BhtRU4ZiIZK5nhMxEMAGfhrtBI/eDQAVQhsVVvW8D11yW0C0rYOnb8K5JDk+XfSSHp7nzIN7+cQOKY/nhqi7axyuv1ZzgecVqNzKxmlNyp8ziVVUzBdmfHrCd43NtQhaAvt6cgK+vDPyhCG71x7qOR/XtgxvuCg5hz8hL1RcxBel+1lHOxou8F0N6YCodSMB03YddPxm3oT/i/vcnNAFL9cM5AANJLryATGMSIuEbRVOu4wjf/PI38JZSW1zCW26tJz0Oror0gdZrIW5L+UwnuoaIbwpVCFcHv8QKxAJnEikUdJrt+XXoiUUn5NNdoS7e2B+6eVduVq3sYlIuRbcC9nWopJaierbotQfWBV6ejzDWzBWOU4N1RQZDqR+sEHRGZSh/Vu7KhrnfbRi3UWMQT3/U2ij18RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(1076003)(4326008)(38100700002)(41300700001)(66476007)(86362001)(8676002)(71200400001)(8936002)(76116006)(186003)(66556008)(64756008)(122000001)(38070700005)(7416002)(66446008)(66946007)(44832011)(6916009)(2906002)(4744005)(83380400001)(316002)(54906003)(5660300002)(91956017)(478600001)(6486002)(26005)(6506007)(6512007)(9686003)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wf5W2bw0EnbUbbJGyJ8UmEwYtByAxm+dNwxHFDO4/xwiOxHkfVsbXpEPil/9?=
 =?us-ascii?Q?8ecH1l0SEpfTgGDiE2DA4nIsKQfDQjLgnQ5FvyHMcCzaFJUYAZkMrRffn1MW?=
 =?us-ascii?Q?4Y2BGNB18SwzHOjtQwT44z6I0Xwhc/Uz4xThofvsE9W1hfz73BfpELR0VacZ?=
 =?us-ascii?Q?jH4zMIbSCNLRaxXbp09Dw9hyDUz0V7LSLqCWmjHPvkXXlpHy6JcsPtnU5Lf9?=
 =?us-ascii?Q?ccWcEpT3mJzmykGMEOHZfrYQe79TaENe2G9Vo79HleU86eTeu5KQ1uXACFYC?=
 =?us-ascii?Q?Q0npML9pfddHtHXPyBg9CZuBEDgR3xvZNqBICFCuyXRK/KdWHw4+kGOY3Rfu?=
 =?us-ascii?Q?K5TZry5ce5kJ/IYZwWpfDJi4NnLvbMn/BjkQE13cvrZyXtmNpHd4HkYmnf37?=
 =?us-ascii?Q?K4MahR/Xe8rIO4nLUsn5nDrQavd5qd5D+Zux0435ZPGMYpRXA/5fN+fDOXww?=
 =?us-ascii?Q?Q0iRjKVpMmcjPJZSBZ5txNI8ZCezEqjZA1LfMz28heK4yPbHggwso9jyqPWI?=
 =?us-ascii?Q?115zgGswNHYb40vRJdfSgqSXffpzSxrbSYcJef7fgfqaZYSkEO0ko8SfAzjA?=
 =?us-ascii?Q?rEFpdU6tylQrS++kXeLiZEGLujxiccnqhWuJQFGwlTSZf6tSGjzWHDHM1EKj?=
 =?us-ascii?Q?HiRiDXgCnTpXvze6AaVM9bk2HJiIlBj4+YziAF3O8SKaEsSe8pCR6nXgL2xs?=
 =?us-ascii?Q?3wcXGTq25ddMT8Bc3joid4pS3vuGSSacifcX70wOpT6BMctmRm3/oHDeQ1rJ?=
 =?us-ascii?Q?1YmyU0z0RUjpsGCJB0cNaU5hBB+7p2CUkUmRj0fK4OWucs2SHhu7nvkZLlCX?=
 =?us-ascii?Q?hSj38NZB/k5NQPRRK7Mo/0Jz+8GOskuS2z4Fp3QDINEZpfYbOGUHrYu7L3Hn?=
 =?us-ascii?Q?H9ha0sKYahwZAV/PYTlk9B+FlIqntwwCsayC973Sw0yiElp31/z/7/3cWHhr?=
 =?us-ascii?Q?HB3ktaYi3ab8wI4OouwnoG+QlbOcbmNrM8qH/FG2Pq4p5WQU3pAtQtyAxfjG?=
 =?us-ascii?Q?y8lJzcsqvuzop21TZamjmwFRSVbtVhHkhj88GJWXEL6a8zjNrmAzp7ujA7l2?=
 =?us-ascii?Q?ETTu9kdhtAcK9dz5Yc+oaouQXJmLqgg76fTpnHiA9shOgGLQdRhAg5B848td?=
 =?us-ascii?Q?hiVWYwWgof7FxATrEO5vNKEucc0hYJeNZLDSysyu1rP5jXFLADign6REOyWU?=
 =?us-ascii?Q?UZ9eD0rvkE+Ggu/BNK1hdH19ZCES0vLRmukCa3DH45FgEfi4K7rHqldoSxqk?=
 =?us-ascii?Q?OuO2clGmfoPL9OvLul29wKaLHR78fowfCNe2ERQVjl+yxnRFNBHCYBCRQi9d?=
 =?us-ascii?Q?YuOC6DY+1wRH3qr/Jujbdp1xWUeGGZH5/yb3xtF1OkDLy3fzg6nsPzjDs7LN?=
 =?us-ascii?Q?e/el8VmgKZm5i5X79hrCC9oh7GZJBjsChEPpeLTzApRrOnuYJfq/AIO/+6T8?=
 =?us-ascii?Q?ZXB2jgn1PzGgDbUejuQrNQHKVD5s57HMHn/KMqjboMPVBq4IYFhSgTrRAzEI?=
 =?us-ascii?Q?4H3h0jkU//bohGFh+Xazl/AaOOGiHer0gbPMvRHSPQzZ81VMyVJPiRRHO53T?=
 =?us-ascii?Q?tEpV1MHCA5wFKKnVJ91YS48U1MyYAs2HL0kURTywE6+kz22+6SVXLNmaFRyi?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F2FCDC1326C774FBD80B33CB437BE4A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b938a0-246e-49a2-89fc-08dab85ae341
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 20:36:12.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUDlNl42mxvzHM2D8G2OVFF08wEKVHvu3cgssLyuUAF+cMBcDt31LvU5xebEet4NE9ixIC2m5BVnWA5lGGQe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:10:20PM +0200, Michael Walle wrote:
> If one would a new tagger you'd need to add it to
> dsa_tag_proto_names[] as well as adding the tagger source file. Thus,
> two places to keep in sync. And you don't have all the information in
> one place, e.g. the tagger module. The name of the tagger as used in
> sysfs or device tree is then in the core. Just wanted to point that out.
> After all it's up to you as the maintainer to decide ;)

True, there are already 2 places you need to keep in sync, you already
need to add the tagger id to include/net/dsa.h (twice). The header is
shared between taggers, the DSA core and device drivers. A third place
would indeed be a bit too much.

Actually I came to like your idea with 2 modaliases. I prepared a patch
set and I'm in the process of testing it (need to rebuild everything
with modules, which I usually skip). If it works, I'll post it as an RFC
soon.=
