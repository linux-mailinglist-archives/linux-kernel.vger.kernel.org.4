Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52060FFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiJ0SFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiJ0SEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:04:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BB27171;
        Thu, 27 Oct 2022 11:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhFly83mUKg7kzR/kn9LpPmLtYb3LfJ52lP5KsY9TPd8BuK6EAfRI22ZhP5Zv+QWBYSCaG/yQrOecWmjxZn2kB66QAFuvZzcNRARC5B+5XzYZb2hzXpnP0CBFIswk8gTlHEFkZyJ5LHt/Lvsr8A0J+ef0WRAblRMnyZLvkUdtDI0fHoxwxpjrWV8D7hDmcxsZptXmi5MpEod+p/0YwTMMuju2T+Ps9gxsnXFYVIMQb0umUKgJu5RY576g2AcSaUlHIwZIeJJWOz7DyC5SCMI5tJINwS9Yz+sT2T/jbZVfJQgRaO9rls6RuDAqhKN0RvRs4hxYbgflW7kPm0NKlbKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEHmhYRMp1R2Nc9FAR5x9XJ1K3FXKuW//79QreFFZho=;
 b=a8CHjWZHF9Owsae96mZksmyuIUpfG0trY9fJZ5gbgahlyCMyzva4C0dA8MUf0WYU8Brmf8eavT8klHROqk8ZgAePZicBFLymIoZSafPk34ftpIQqu3xchpC5dTKUgtXz2YGJeKfmeyL/zwsGrjlgmZJhDF4Vq+xHbI5ew+Ay8+bcgYNwxk01PevaWky1YjytobBVXu38L2nsDXLyF0vSSuILmzzPtjXcb41AgPLf1tMHtL/jbmNOth0IlzpQTAEf5LwfqPGnwLlOwPfshuYi4vGtSVv62zVeOH0XaE+Lu7U9PKLByqIAj1FOS12yplIqZf1GrhrP4b3k1tzqy/im8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEHmhYRMp1R2Nc9FAR5x9XJ1K3FXKuW//79QreFFZho=;
 b=kGohN4lx4ck9PHSFcWDfo5bG4hE0NcMlO7QxT90DyByw7vEmbkwtIrFwk/rpokjEtjJXk7s/2+eRjNqHw6SPVGE2qz9gIMQbs2wyhFXWhXM6KnXvT3WCEAgjqu6l80hr2PZcypXy6B3IrU7IDbD6WLBm5h0kVlU3p8lLPnUrJ2U=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:04:46 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 18:04:46 +0000
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
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOAgAAGMICAADtnAIAAItaA
Date:   Thu, 27 Oct 2022 18:04:46 +0000
Message-ID: <20221027180445.74btifpmfhkt74zy@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
 <84c5e0a041909615a1ba8a4508131206@walle.cc>
In-Reply-To: <84c5e0a041909615a1ba8a4508131206@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|DU2PR04MB8648:EE_
x-ms-office365-filtering-correlation-id: 984cff9a-692a-4375-30f2-08dab845bb47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFyop19LbCfodzOqjTcDSm6qPWGZMKCfQ8q/M/OfNeGRjSizsrlY8FYbJpZmiQMZoGC/qJw3sPG1RUpXBSiZtJL6QoOGIN9SVOKdLsFL6ZQXYn5ZcfARRezltOCvOaa1vrgP1KEc5VOBGPWwY0b3mHQZXVvYjtxFOErwSq6bBwoluHcdK/nXeyVTfxGnOkG98282Abof7cuERWlpQdeaBlIXRUgpbqXZZHnAFVAT3/SAulxPA1E6+MsS0vbTVdsBOK23Rbj2GH9oOl3r8SRVt+5DGZ4+HHJs6AQa6/qrBUlfEOGCUr8MTTcPPKE/cdP791uARpT8LHurr4su8wmdT/JIQzvrCVklI6O+0Zor5CLQCuvoLzujBlAoGMRuv4MkoNywjOQ/17L3AtmWS/gP8lyPD0OZIFhBzTtI2uSvd62wtoaCVqQplrZ18XSI52Oq6lQPTkZrrzUeWVBKaZrxfX0GnYmtFpzc1XFTtV/iJy8GZ8T/urk8NeLb7el+E31vcahWRuofa9Fr4lKBVj+G11idhRj8VNxJQlkM5Gfx2Vkcgu7x/YqGp2z0bdpugk6Y4hcH5KueL9YWsOpY8UNfl5Kys8+VZJV6YxXJrXiML9H5BtcE2dCoviyOeeM41SqNtnMA7r/K7zLVhYVX90w//208e3TQE29xw012qMSHQ8RgYhdGK81N4nk6bxhJ32qJTIZQ3GmYSi8Gog4RD0ZchvNWHUokhV0NhDiF+QvqUX2lQpe8qwt0f3+lCiYURR6RhRJ2yvEhfOcL+kcX9f4VfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(66946007)(66446008)(8936002)(8676002)(4326008)(6506007)(76116006)(66476007)(66556008)(64756008)(26005)(9686003)(6512007)(41300700001)(1076003)(83380400001)(86362001)(33716001)(186003)(2906002)(7416002)(5660300002)(44832011)(38100700002)(122000001)(38070700005)(71200400001)(478600001)(6486002)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1SGZF3mDQQ+gdvXpS8V9x+lcq078OGJGBHgeJk1WU5ZvPzBoKCR3ZxxyfEY+?=
 =?us-ascii?Q?YcCAkRdbni1BnwKMwZdJWWj9ayFSRyE6E24iJ+R4qSTkwPFgaBTD3V0hMlpt?=
 =?us-ascii?Q?uaDDUjOE56CrolTx6CNHTzMp403w0YR4+MxEGpkEgeVpobJwvdIhQ7q+4jig?=
 =?us-ascii?Q?/rDTjwUhV/iZ5or9XKIlkK2+0CGEzF6NinpmKUpAb4Godh4U5tA1pDhA2ZC3?=
 =?us-ascii?Q?HvVt2/px7vbDGqI7bUd6I8bnHEOCGlDz1Cv0iLQmbBwK0whLpDy0VrdpH+bU?=
 =?us-ascii?Q?eAoUxykGwRsvHFBuEVDFQw0L6bXj3Q88dkO9Q9k6nIAq5nA0PvWxQy4rlZFg?=
 =?us-ascii?Q?bzb3X8y4v6jvvPdu8MTtOahMqi6P7udahIzdM/FFRKnCxwayh5tNDDbinmK/?=
 =?us-ascii?Q?zoa+OcqZBfquoQoFAO/UP5CGGk8TcdFYAPhtJd9dxvAQyJkSnsBJlvSZMKUz?=
 =?us-ascii?Q?d6dm8uwgnLxETIEYs3ZQ8Ln3vg9IbWjicCGF+pG3KMijCaESKOcVVDJHsSPH?=
 =?us-ascii?Q?0i5JvaGN/73NDkjmcr8jP297G0D6YDMLCBHQnCAWtLoOHR94J94YEhEnB9lt?=
 =?us-ascii?Q?SgGGkqbCsiy2AiDTKaTImPh1dxpToeUXY/s9VmlzXWqeVuG/6tBrom7loK1N?=
 =?us-ascii?Q?MlyWch8OlW3zFReuT5IIZPPCTelc2xS0PDcItgxzdNjjU5flAA+3V+u/r3rh?=
 =?us-ascii?Q?vfcCH8oBtnX+aiGkM8x9H5WDkCUFI/1ODFi+SfrtGq+hqcwRUPM3guP1n/eV?=
 =?us-ascii?Q?f1wjUNW+Y/ZbxaMTT0fpJ5UzMFrWK8UvVGe4lc4YbxPNk2fy+CoGQQKGp1+Z?=
 =?us-ascii?Q?tgg3y/Y7rxp9IOlZo11qW5mzMz1tox/cTM2dR8wyFxXx6OuATZr7La5W4PWK?=
 =?us-ascii?Q?QtGuCLSf7fTd2sFPawEIEt/WQnk3d7MxH0G1kMH7P98H+esBPsFE1qVK5w49?=
 =?us-ascii?Q?8NiVW6VmUkP59yHC3J9qFd9tIMlTQ/fab7K0McgWvzh0Y6o/5sySfKMKayIW?=
 =?us-ascii?Q?1bbj7hu1w4xVNGl0ePE0xKM8TixL94ydaM5zYzw3Sc9JaCIAnpSzLAtkpIXn?=
 =?us-ascii?Q?+7ZwTOXG7Qv/CrwcHU2LZJpWjIdsVKbW+yDgYVJn3B78dp8NVyisvkbZgx3A?=
 =?us-ascii?Q?Aov35HWrvYd5Qt9oMGPBAWAz+EDBE4LcKpcmfGsoOJlA5CvsZN0sF4JZ3RR1?=
 =?us-ascii?Q?/biFj9o0oKrJFnNqSWDdCsxoqn8xwhiaV8hjy2LO9izUL0gX/V/3AtcoQ9oe?=
 =?us-ascii?Q?xTCORXzi4LvcdSxe7uy8C5tc7+/TrvMIea7i3SujzzxOS7bbREsjdhXYkq69?=
 =?us-ascii?Q?kD78GIHqNlwhC8SJUA90xAedXVAUFlHAfbSAcAqQdG3qGE43u+ACy5PZEWfY?=
 =?us-ascii?Q?dySuT6v3xVk1pPvk/GJfYJMWJY2G6akUzyDzZdLXRUSHS7QNjplrJ2r8hHdZ?=
 =?us-ascii?Q?2CdSgTF6roFw9haLgwB273gm7vjul3mZrPdyTQy9GPfkxabmC7BSwrqyaN4x?=
 =?us-ascii?Q?5Tl0LnaZ+JvKXzNDb0iAZXMZXYbbgd2Llrz2V0xXh2sYgJToymXVdUwnmqTd?=
 =?us-ascii?Q?1ysv2glGoYLqudGsWeG183HyuKA3SK1Tr2QdTAPraLIKwouRRJMR0XKwDK/z?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44B95F967C1FF34AA7BF1E51D9F6A24D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984cff9a-692a-4375-30f2-08dab845bb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 18:04:46.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ7WybP9MJ6ee30RBWt3VZsjiJTYX7LTVPS1PAEmJoQP+AQgVOaOPnALTmadxvCBCPPi42cOXhAiEa64i0abdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:00:04PM +0200, Michael Walle wrote:
> > - change the MODULE_ALIAS() of all tagging protocol driver modules from
> >   "dsa_tag-<number" to something containing their string name - what yo=
u
> >   proposed. I don't know why the current MODULE_ALIAS() is formatted th=
e
> >   way it is. Maybe Andrew can comment on whether this is feasible.
> >   I think there isn't any backwards compatibility concern, since only
> >   modules compiled for a certain kernel version are expected to be
> >   loaded.
>=20
> FWIW, you can have multiple aliases if we somehow need to keep the IDs,
> too.

Yeah, that's worth exploring, but it means that we have 2 code paths for
request_module() with different string formats. To me this is slightly
undesirable, we should try to consolidate the mechanisms in the core.

> > - put a translation table between string and MODULE_ALIAS() inside
> >   dsa_core.ko, which potentially duplicates code. Maybe if we
> >   auto-generate it somehow?
>=20
> Yeah, I also thought of a table with of name to module alias mapping.
> But then you'd have two places to keep in sync (of not autogenerated).

Well, to be fair, this is not exactly true. As far as I could find
(grep for "ops->name" in net/dsa), there are only 3 instances of reading
the "name" field of struct dsa_device_ops, and none of them are from a
fast path.

I can imagine a table along the lines of:

static const char * const dsa_tag_proto_names[] =3D {
	[DSA_TAG_PROTO_NONE] =3D "none",
	[DSA_TAG_PROTO_BRCM] =3D "brcm",
	....
};

which is then used to directly replace ops->name
(becomes dsa_tag_proto_names[ops->proto]).

Then, we could add a new function "dsa_tag_protocol_name_to_id()" or
something along those lines, and construct the modalias string based on
that.

No duplication necessary, since we would remove dsa_device_ops :: name.=
