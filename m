Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5771B60F798
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiJ0MkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiJ0MkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:40:15 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019E2183D;
        Thu, 27 Oct 2022 05:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESfjNXoHzmFddnDTq973OTv2OmXJomDF59RQ8Z+HGTrktf6UHr39dfV+h97wi2GuE97SCzA3Gx4rT4lPRWapcdG9yLO6kphvQUu2mtO735O7hR5o4H2EpdkeIQIX4kydbYWy7b+GPoGVEJh8eZHUwVUONs2gEbKyENnXDTWibJTOQI8Lu843r6GK5065mwrG5Ds4/AvnQbed9QtmnvD+pjbCdijIr4yh4f8ZE/g6ELh8nNMYTURH4e3LH9HRydRyWnGWGyUq8CbF3Fh1dtwf4eQPUD259Ce8tNTKnyAoRR20auKlVvnezDxeBuNNHI12LCmoY9Xb4uSRaC6I3LLeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa8XgLI+lLEpAb8C6JNKFI5kgQ+TYWHW0iKsvVwKX3o=;
 b=bdUfeUG9rP5CqoeCbENQ6SwZuNS9IQQ9MTU2IueVgkY3iUd2FYy7aejMIcpTpKulaP6CeRW/cPo+GGx2Zi3Z+OTiwGPbBY913cuPAdAJ0RrM6sB7f3hfAVwatIuuKDXtI6dF1dWJZDggpMbilb/GzMP5v2aKoAHyTGn1UjdqPP6gPlR6zEvyNNWK+5Pd4lbSuEn6/KEI3C7EKsDfd2pxWBqVsr5RNeDhyxl0mk4n2TPO6BVlqKf9pjp3JOIP3mqjp3P951wh1jdkRzoBWl61/YY2jlsH1rqx7Z0B5BBoUGb7OBJdOhKh+C+B1a338O5lv4oxKDyOdfRKtyyh15jNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa8XgLI+lLEpAb8C6JNKFI5kgQ+TYWHW0iKsvVwKX3o=;
 b=HUOW+uVHmmO028PEl6qT/YMePjg8Rs4KmrkD+ibRZXcMzBu5dlSECt+bfBPhIUs35FaxlkcjPBGEkvP0GQdIxn4S4lPyzlIFGcuQUM9M5NyzDBCEPn/EzCHMeZ0mkMvOtlIsazFHl84clT6EJ3uHN935yTeQ1FMoItKq/fb/vvo=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 12:40:09 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 12:40:09 +0000
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
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOAgAAGMICAAAOMgA==
Date:   Thu, 27 Oct 2022 12:40:09 +0000
Message-ID: <20221027124009.mxfcyuayfv2snqf5@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
In-Reply-To: <20221027122727.fhs35eqtzmeen6x4@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|PAXPR04MB9400:EE_
x-ms-office365-filtering-correlation-id: b49a7f1f-30db-490f-053b-08dab818627b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3NHdmOhD60TUnbhD5+bmhAc86Y3c9mVARvtBrLk5lYfsKf5/K5PbxoVaP/C31u1VVyCOxW98ogjZ94ONdEqTBxXJkxCLi1ehJKnQ2KZ6uGm7qDFN63P7TFdOXlC2nxac3PIiKY96EwD2GtqDHxMHJlirhK5KPTdNMV2pMque0v1XbJ1dEdWew/4QNPm7DzR2/uY60JCXWmHT7RufnMCsyvdvqOJmXXyLqmt4Q1/U4xQt82pVaDFFje1XYM++/eLxFFpFZEgnUMMGaHKp2uYQ/tSDOYV3wFFnQAbw0Xa/WPUJPtXYAwGk2BytcRzXfYpKgpw5V72wPj0Io2iAiEAhcucIGDQgBP5FyzXABctfbex1EbwebZ9Cy6MryMgc9jvMTRb4LU6X7ngknBUvOkkGBwpvI1jiO31c3Nv4LVU57g9PQemWF6yFRopet+FpaceGI9G8JeABgcUT5VGxtSasNELHcLytp233yLUCssUmE2VSK5/AQitfHJZcJonxu20t9xaPP+2adseN7bw/4+bHWBo1Ao+Yed1V0jWFe9zTwnNmDujRm4ll7GAOMu+Ln/NdEDtM35NhtCmw638z93RLo499C8vhuWMeJ9tSggNG33s6YKKB8a1i5k6fLXCSPP0CoeDuM7qtCnmSe9nrc0UxugkOLCZp7wl17DTHbkFR9djfzAGaNApqejN3edwAQS1+W7CfjTN9Z43CysKRwR8zWM4FJrM5GScM069xo4hLq3hXgu28bg4/9d623VFpQEW15+6hqAOP4JNRmNtNmZBgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(66899015)(6916009)(4326008)(8936002)(478600001)(54906003)(44832011)(38100700002)(66446008)(38070700005)(66946007)(7416002)(2906002)(76116006)(66556008)(64756008)(5660300002)(66476007)(71200400001)(8676002)(316002)(6486002)(6512007)(186003)(9686003)(41300700001)(1076003)(6506007)(26005)(33716001)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hno4tj8wSUa98lpN4Q/186dWaOLmyy1+Q/3th1UTe0focea/Yl2SapNFKVcz?=
 =?us-ascii?Q?4ipGvOE+nRgL3f1n+HEvtxucKW4ZxiMoWsLfdxxOAur1wM2xEYVp+sN/Twea?=
 =?us-ascii?Q?rrO0mifkQD40R4m7C21/KpXb0YFcd3wkqaDPl3e7E741S/Cd+JeTS6tZ5IDk?=
 =?us-ascii?Q?SG2yDYEoXNTT4o0SISWl1CeogNRkW3mEVV0oZ13kgE/CHc01BtVSKaNom2az?=
 =?us-ascii?Q?HWBQswa+Yp6Asc8+DkXJ4ZOjZO22jxqy/EWzjpMkxhXagDzAoWU8e3UcEUIg?=
 =?us-ascii?Q?eT/hORn0yxrg8JiFQDoIUmCGV0jUD7qL11kp1WobHUnjtW7FRSrQ88CIOFyI?=
 =?us-ascii?Q?WcuYDeaS67x6lMvZvZP0OFobrcFWJN0kphro/WoZkGKKfAjNFU9HwzWL3ze9?=
 =?us-ascii?Q?nQgr6vf+7PDvJYoFD5pHSSVfMT6+sckQT2Vp+MhnXt6eEGsW12yinYNcqLlG?=
 =?us-ascii?Q?J0FS5Yyo1M8GkE8PULv9f5xYvZt3Cck8736gi8CSv+J3Xu9iZjzLtQ/+YjS0?=
 =?us-ascii?Q?sDwm0WIBedJ9UFhqjOZhPuETZnYsHdSuQ9EMsEciJW4+YqTmoEX6GQUMy+c9?=
 =?us-ascii?Q?jNZE5wZ3Q6bIuIfrfPTraxP8Tcs5nth3SOy6RHCqtqdDJh2BU+rqN1wvnWT2?=
 =?us-ascii?Q?jb4ONIrBz4KVeN0K3tPGmFpVhE2blmCXRkOGQX/WzOR0zL9dPQyd/CSExW+X?=
 =?us-ascii?Q?PwopK6LSGP4gsThLRP0QI46G3RnmZmSiCIOR9U1pnWOFOZtwBm+JYETXpYCt?=
 =?us-ascii?Q?9rJ8GcrYDkbFp6FlFj6bZFefyqU14Elo5jYtbBf30Cvb1t6+NR/NqjnnrYBB?=
 =?us-ascii?Q?qmiKH6bdLhW1wkkwYNgen9fuFoq85tS78nTQ94tt2QXwsDt4gDdJW4vgFVy3?=
 =?us-ascii?Q?dGIr1J9/t9YcUE/VwQdhQ2BIHfPzrV8j+Oiwg02s10KvwEbVuvVIFcg9XoWK?=
 =?us-ascii?Q?kKBSOrPoNhMO/5G/pvQFR5GSZ5APuSTGyY5X8GAeB73aAK5/HjDh9dSR0Zp3?=
 =?us-ascii?Q?D2RcP6IC5bUB+8gVczqSnAkrJLtfMUHytMEQPkThErF0f/GKrxjesQfwR0uw?=
 =?us-ascii?Q?059uUEqgKrTzcKYnHl5saytEHyMDATW+7+x6G7bTzMxWyNTj0nyV+enKTxZ1?=
 =?us-ascii?Q?TMFfZzrpGRthBa+SdRWgrkSUa36tlJ/08dFQw/UqBzSrimBs04JoyS9grMTS?=
 =?us-ascii?Q?rokwBxEx8hRpRlRT5WYbcrlVQdMPxOrYl9dvZwxnndkEDqvTv3l661Uj5EAo?=
 =?us-ascii?Q?ZUa6oA7n0nYdf2XR2R6yBeux4q7yvHxOunIWuT4OQkGZeJKoRL6zcywpZvBX?=
 =?us-ascii?Q?fqMGK/sDh2q3ughAkd8F+zFR3qhbgYbOjRMl8jb2PpYwJsuyNikwzWELjuhi?=
 =?us-ascii?Q?ZCxuE3QaD8U2mCuPasZRn/wlsAJUbTMh6mzlhbkV0ViVAZRY2nyUiHO9Jslm?=
 =?us-ascii?Q?p940ajcYm0SmladH5WJ7ryw5rS+8VZVA/8UrJcA3uf6KHF0ww1KTyPrLYLNB?=
 =?us-ascii?Q?vb0050O9hO5/ipDZB++6Xrv4eBMioHdPby9gCWrvyzaLYZmmiH+ViX2hF24O?=
 =?us-ascii?Q?OE/2yjVxnMTZrU+ulXE72UTFudkfM2tQDUN0ITVp85FahPGWA/JuXWSmij2+?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F1EE8B1A8079D4FAEE34596FCCD5638@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49a7f1f-30db-490f-053b-08dab818627b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 12:40:09.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCtx3zAe+61ED7hJQ2Gp9Oh7J0DrNtMsX7BRp5ugnGVUPMjQcFaTTs9KbRUckqER2xGAr8MDrdTu+FMUzB15Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:27:27PM +0300, Vladimir Oltean wrote:
> I think we should treat what we committed to in terms of dt-bindings
> with utmost respect, so I would consider your proposed revert as the
> absolute last option. Reverting a device tree change doesn't mean that
> the device trees without the revert will disappear from circulation.
>=20
> So far we have 3 options for fixing this within the kernel
>=20
> - make tag_ocelot.o and tag_ocelot_8021q.o link into the same
>   tag_ocelot.ko
>=20
> - change the MODULE_ALIAS() of all tagging protocol driver modules from
>   "dsa_tag-<number" to something containing their string name - what you
>   proposed. I don't know why the current MODULE_ALIAS() is formatted the
>   way it is. Maybe Andrew can comment on whether this is feasible.
>   I think there isn't any backwards compatibility concern, since only
>   modules compiled for a certain kernel version are expected to be
>   loaded.
>=20
> - put a translation table between string and MODULE_ALIAS() inside
>   dsa_core.ko, which potentially duplicates code. Maybe if we
>   auto-generate it somehow?

Sorry for sending so many emails. I think the problem we should fix
first and foremost is that, if there's a user protocol specified in the
device tree but the kernel fails to load it, it should simply stick with
the default tagging protocol, instead of failing to probe. Everything
else can be dealt with as a future refinement.=
