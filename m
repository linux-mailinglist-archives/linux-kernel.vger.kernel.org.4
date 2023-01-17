Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC266E59E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAQSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjAQSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:01:29 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0C53FA1;
        Tue, 17 Jan 2023 09:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiHBswHjqWPfhZr4nOrWgtq7l7V9/TePO+ZF9u2EO4GsyLLRM598aTOV3cAkL/a+gycO49S2+3xY6fJ98a6a4tUmg1DGhoFmnU36wZjfW2DEaoOGHietGu34k8vBXQOGtqvpCLDcoMv1Etxh3X50FsS1EmF8phRGN0M5m5BavpxaHinwktuoqZ7TwzL4NOgaPM1qRtgS+/dIsu53mL+c723RLtiTcuujsWllqvUxOtn0W0d+doLvtRGR2ijWuQqIhgIQttozxeJ2ZKPQY98OLwWrZGRZUZlWwfh0zO1YaaTcdxwSCz6vNnbQI0yBxbQsU9jJM+tkSaiTQXTjPHgrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlpSHyw46qYypYiqeD9fqTGGY/yxljk2QspmXyh4744=;
 b=TPOb2B7r7AIEZbGpATDtYLdVZo3j4hpddNvufg4HQPz7SzkGEqFDpDDN9HFm09jjDFAvSWsVGwpWxGa5RJZkkbzLjsP6oqeoCzzll5Dju34oZbtrDeaz3B5p6bZ4i7Q5mYMZPWvcTa6Fx2CunO7s96qJTT+YJfH6KAHnz8lEaBV7kTyzzTDVt4PIyZHPU3MaL6pMRtxKAHBPK1vY3lKwd3PJO/zWBMJDRcJmhTioPCM3fIz6lKHjxZu3qnJOpYlIWu/DneoF8aCyKUNjX34ktI5lrFvzFpdrLreuVwiKHBMR8gVh25xeOkjqwx819d2vu0TCNKyH4cUbsEH9BngD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlpSHyw46qYypYiqeD9fqTGGY/yxljk2QspmXyh4744=;
 b=e6BmJJZrJLXOHkNDL3k7yqQ9o9m43kXQL0KZQ41w0RlsfA6Q65vCxy+82KQ82/MULfz3DmV2sGpPUbzA9JY1NeHShNr0MWLFZ/j614RsSLVCW5WWlhDsDIBTmAQixiRP26s/PoA4ItbehpcKxy+/J2GYokyOVKJ5si2ZHMOG1SU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TY3PR01MB10015.jpnprd01.prod.outlook.com (2603:1096:400:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:48:26 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 17:48:25 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Wolfram Sang <wsa@kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Topic: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Thread-Index: AQHY8skVBomaV6jUGEK4jsDHAveVPa4zyxuAgG3aDjCAAFvEgIABUOnQ
Date:   Tue, 17 Jan 2023 17:48:25 +0000
Message-ID: <TYWPR01MB87751E0577DBD4163909E499C2C69@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
 <20221107165027.54150-2-fabrizio.castro.jz@renesas.com>
 <b5f881b7-1f59-623a-a126-d7827dec85fe@linaro.org>
 <TYWPR01MB8775AA3197A830F8769C01F4C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y8XEd6v++lTSeCYn@shikoro>
In-Reply-To: <Y8XEd6v++lTSeCYn@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TY3PR01MB10015:EE_
x-ms-office365-filtering-correlation-id: e7d11cb7-4d03-404d-74ca-08daf8b308fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ob39EQF8rF/c2M986OcQuZR/xmDrNhYRFo9FUvABd4ZvbayuNHjF/8xuOXulJhN/YF4zpQeLx1f3312ETHeqOMnKF90vwYgBGf2Xj5tYHvsVmrdJkLBq9xYgSR586BkE7X8wc+ocJm1PGqU74K8IQwsUAVdN5zklYZesHbTqyFjzIDd1jkQ5CpuGtKMUDVloOaT8x4YmUqLoqAnQE0dx8PuAFtOZRznt7VOIKYYLR2L81ueOe7vNgguswQbuFV6wuS7WcGKf7Omcr29SzNHL3qX7HS+EXEkeZnhsgbdO9++XE0zrswZNBP/EGylXG1QyMWs4czXben01o7I/5olQnI7gR08WI0+kiGMJvzirxCCRF++mJwyDc2nOTPZuwd/tcK0+crFzIWPZZf3sQ05WhJ4+eVVH71p62OLvdF1ANyKB4RrLnZ6tlJ52xn0tAlCiw8/4H5JspGz0yMgI3v44kafvv5E6BO2PXZ6iRvsOdimWdHZZVebyxCvIWF+kg1jnR65w7ijsrM6wIJJzzM9Vp/K/WG5umnTcE67LdLNBsjoUuZCJMcSQxDvGJBjqE+pCH92x8Y51rtBWu/CQsRbfo7vbLrDg7WxoEnsreK6wh8HjMjUcXFFRN8/y+D93mRn4Eaj87LdGk/24NGLVUGJP5BIE12qkHdUDWNdI7SWi+yMAPl50YV8UrXQMbnPLDusV1psmVMFhq4N+FGYqFahyFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(55016003)(478600001)(33656002)(7696005)(71200400001)(54906003)(9686003)(6506007)(26005)(52536014)(41300700001)(2906002)(4744005)(7416002)(316002)(5660300002)(66446008)(76116006)(6916009)(8936002)(66556008)(64756008)(8676002)(4326008)(66946007)(66476007)(122000001)(186003)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yd17O3pWnkdI6mloNPlLtftLsr6DoF4Qvs+PHiQF+qaGjOB6KyJB3A2x4fc1?=
 =?us-ascii?Q?zft6jeqg90cGfaihHnvv0GxtJydhRBiIQYq2X8fQnxcb1QcaD3HscvKH+N7h?=
 =?us-ascii?Q?UtBApT8Jk4+gef4zfOSjzC+IS0Xwp/uCYEY5jU+dKsAL26yTfkd0km2a2bLc?=
 =?us-ascii?Q?UDs2HEEtDO+DijIll6dJquPKM4o0UrqZmu0/I1M74r2NCNlu9E/RqYTrFCLe?=
 =?us-ascii?Q?ZvwcBGT4Q/d5XxfRXGFJuQyqxDpjGHz6GEYrlDhJWCFg//+qIcsVouiHXvWy?=
 =?us-ascii?Q?QAXBBUs+jHUcArhBLv4NuLz2odALxZfBsjMDHaTC2gWMSII5+VWuJRv8aLSn?=
 =?us-ascii?Q?Lx1y/hQ9LiXkUKHLhrMbT63NKrs97edS7xjl3ersvHNq/BoPtDp2qynKPj7E?=
 =?us-ascii?Q?PIdWBNWott7Y1GUpiwoq4I0jHw79kZzIxuNUECotmI0FYC5T7BEI6wBYlc84?=
 =?us-ascii?Q?aP3uv+hLUtxXXlyl8TWxtePIxTqEbJyqy53pMvpoP3lQorYIkm1LmKZpbIiR?=
 =?us-ascii?Q?Tm7aUC3f4H0PPjsPObPv7HYOHKSJrCUtg/J1QjDIUD+qGmDRjVvN2VaJQvWC?=
 =?us-ascii?Q?jnrJK9y2HgXF8KQLpfeVOSXljPZt5/UMQ7UsxVw5jLKic6ppd5p5WBv/syvk?=
 =?us-ascii?Q?mX4ohpTX7EfrSAQXi4Bave8zCkQzLo/dAISYKMIFdGHeEhWJ3EKaCBjqug/J?=
 =?us-ascii?Q?HJgHHQKIWlQPv6YueNQwY3MV+OALbXuwUH3DyI2Vxa+gVx6530VWexqcmMTH?=
 =?us-ascii?Q?jA2HWcPBs0isPHb7XhHOpiK87jzvopNlBdWFi/vhfDHayoN+UTpaqjjA80xY?=
 =?us-ascii?Q?p6Ft52zzl2kGb3nvuogsg4PomU+V3lI8nPxwPjmaHYB0/DxFLb46ososYbe5?=
 =?us-ascii?Q?6VmkA+orth2MqrcLNi2WXkA7UimK6tuVWlRbb9+cEb4Twx5He15nw2FesgRd?=
 =?us-ascii?Q?F8eI6a+4YYT/2zlxja/urwkT2V16xBfRoshHlj6nohfrhpZPoTweYUL64RXr?=
 =?us-ascii?Q?OxJY7U1ZDjbwBBygZsA6KqKsPKiU7ZB6t0ErOcMfNCdl09Aw6AWiexMBZLuy?=
 =?us-ascii?Q?1zIaFfkVJ6ZOR2kFvBDtPLxPrLSgl61NupBkv0xCL4fIxB3HxZmNYbagAVTj?=
 =?us-ascii?Q?Zm2VWP6bXpkYl29duagkXD6rf4h0NgGIXGQdbbJ0xa0GfQGFbgLFWvHjRv5/?=
 =?us-ascii?Q?T3YNbmFXSNH0jsIV6ElxYEAuho9f1uP37crUoj+zimzU3I3IUZ0c3YXIy3xK?=
 =?us-ascii?Q?s3VkcpZ1gKdgjPbFgCH31UQQeM4YWphWl3Rz6FhYcafWWeEzZ5HrOR/EfObU?=
 =?us-ascii?Q?S05cm9g6EBl3feVUzRi9GFrEGi4fmc+70yQ1qw64l/nmak+xCtvR+OmXUGmf?=
 =?us-ascii?Q?6LlqjKz6WsbA/1/y2USvBEnwH4P2JYfkskHLUCdO8ONwZsTraA75OZtSX2sw?=
 =?us-ascii?Q?m5z+dNNQ0vHSuCmGu6/jONW5fkS+qe20RfJmjmPmtoYiwC6oPwb1X/xxL44C?=
 =?us-ascii?Q?Xp9ETBnLnRbtIK0T7+WpDnjkEOtzYmYDnsPH1juMo8vD8aSBjLHWY5ifr7xl?=
 =?us-ascii?Q?XfMlMRVpXTfY7nu8AzyyV0futsV7L3jFGQcwchkn1PaVAeINQb1xKm+1kOXF?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d11cb7-4d03-404d-74ca-08daf8b308fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 17:48:25.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85TGy3JoVT1yGmQP1gQ0I+/bMlmMYucsJ5XWwdpH2SJCl3V3LLK8BDhgTbs/mje6wMIBtgBjbeMUXpmFNToD718wap1KIHSzXmp4EUWKslk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for your reply.

>=20
>=20
> > This patch has been reviewed by both Geert Uytterhoeven and
> Krzysztof
> > Kozlowski. The corresponding device tree patch has already been
> > taken, I was hoping this patch could be applied to v6.3?
>=20
> linux-i2c was not on CC, so the patch was not in I2C patchwork. Thus,
> it
> was not on my list.

Apologies for that, I'll resend it with linux-i2c in copy this time.

Thanks,
Fab

