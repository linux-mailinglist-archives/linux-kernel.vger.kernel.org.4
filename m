Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A97278A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjFHHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjFHHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:21:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE242D41;
        Thu,  8 Jun 2023 00:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/eVa532Fv0G1TuBE1eLmFJnRyMTzRIUcSm73u+UPEPjY23faWBhMuY+Dz+49X5uooySOmB2hwFPhf4VfcCERyNOVktXF+uhJhVnupkjvY+QqB7t2CNaAgaMATTqm+7OdyFVyibHlFEMTpfJft+dGWOJwd2voL0jFJ8WGiYWzkjj9rkHmlNmayfaP/FULsdWwjnobGKGZ7VoY7zMo6vRovhEsl9tCTu5Bwaz1tN9G7+9lcK0jyjGw4vfq295ZTZ5kidonL1URNpUmetNACd0GjYcchYak+OUibbfzAbNk+CJjnreVAkG0AUN6oo7ko8Es6cNBAddlMoUp3lWut0Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0SjTs+Md7h3iUT221XjlgHI+NLrtkFvo1iikCIzzcM=;
 b=JLeLVc2fzV+hIVMvURALr8+LjtvllAuFMa3KG53zUFhvIQi3UtYqSESiZeHy18lotDDaiu5unCT1scnUxHZ5JexunvSUMnCt2N8Ca8WadT83xYGsuUaLGwrAEWgmZZUnJebOQX2vgW4Z94zmgJX8147r8KsIPm4R/bl9LyYOdBRivnd+QvYi9gkbP8+Jt3a4KwN0Lo28jSoc81FUi3kZu8fu1eyqNdrJ3r7kQ0xgjudInUIdJfqUJSoJrnWl8q0R5X+Zw0B/n0Hyxe2UbzWtWpaqaPpf4mPXNuZuqMJKPceVlAPWVAYl9JnpfRrL8nWByirTuCC0ApvDqHWxw4g1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0SjTs+Md7h3iUT221XjlgHI+NLrtkFvo1iikCIzzcM=;
 b=TtWGIK6BuyZHbOWBrrIVk93943Bi8wnIok2+ITI68Fmv53B1xgaTGfjdVpiq6llpIoQGzMRV/hylQh2+gUPQb+wB2lPBG75ochur508WxQjV3s53mXwnlSdz0E/hoMNnjXr6A38BBnE01YckNkAsUAOgMX5nb+xconCz3ybJJxQ=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9662.jpnprd01.prod.outlook.com (2603:1096:400:230::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 07:20:53 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:20:53 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 5.4 00/99] 5.4.246-rc1 review
Thread-Topic: [PATCH 5.4 00/99] 5.4.246-rc1 review
Thread-Index: AQHZmYIMGSha5+A69Uiq7zdC9KWupq+AaZfg
Date:   Thu, 8 Jun 2023 07:20:53 +0000
Message-ID: <TY2PR01MB3788DF0241939043625338A2B750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200900.195572674@linuxfoundation.org>
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9662:EE_
x-ms-office365-filtering-correlation-id: e633e188-d544-406a-429a-08db67f0e52f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsV0R1+0Db8utyrUWyz0JC3jq5tgmv/G+n7PCtZnK2mw1Q4ozbQQMI6Lj/4gTgJqgTVbirDIjnzj22MnlvfNR1Ot88xmThNDGQAJk37Ja65NNKHZwphvS8tzmv5+yJtj8zZ3m/63Rx59t/DRkOAuMeHaLM4vlbiieDMHx35wrEdZ5p96JMEWyFVSuOsDK4e0LXudGZjYdIiW84lGAF8sTW+rSig+5LY28now6rUYaOUUzljkpWsAQ6rYZXub3r71wSHCLmfJlce6ZZ1KGUqFAYrzbSGznCs4/1oYkqLFC0tR+b/kjx5GPu2ffJwk2s1h91drrTCrgEHgosTn8N4EVdEB1so7xrTA1N7IjtxeT0ct3tpPzhE53jLwOdd74MX8M0K9MAAauJRFkXVJUyWlN4DGBKgW9XEn9X1wVbowyiJn3uiJqqtbIrcnPhH8sYirvj/o/Ft9C0s4gp0r4U25iqr34ctYzh2ejidHnIp8ntOTXqBnj2D6f/Zac/n6jOF6YgauU9jYzgFg1ovnN8rdlyXNU1XsyXDPgGKN920xnI+MjjyyKqGWjuplnDHgWJucBVjWsSGECYx2st0GwCNHvEUaG8OSQTy5Lt1oPwfEUORpHDu7h04kcjIF6wVXfL6JYwfZlOTtxgqB8/KkNFIIZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(186003)(478600001)(6506007)(26005)(316002)(966005)(9686003)(52536014)(7696005)(55016003)(8676002)(38070700005)(86362001)(41300700001)(38100700002)(71200400001)(8936002)(64756008)(66556008)(66946007)(66476007)(122000001)(76116006)(33656002)(54906003)(4744005)(4326008)(5660300002)(7416002)(2906002)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Cr2S7E0KUenClRsMz7zCz/stFGQ2t6q26NWmRzO//Y9r71F4WUL99mn7hD?=
 =?iso-8859-2?Q?Bo6jCNOz+hER9rE4H3dcY2Hbw+iTOZUWSVTbUSMYgqmBZjQ6pKhUTbdtIk?=
 =?iso-8859-2?Q?zPKZqnPbL/X77X/7NX/U5i8WfGt3Si7jRYGP+IrwCd3XLYeFWAXSa14oHJ?=
 =?iso-8859-2?Q?j8J+Scm2ROqMheeb++NA7x5eWGQJctxwJbQw2nVhwohGhWtf3J0miEG8/A?=
 =?iso-8859-2?Q?qEyJ0fdDN0HIkVWv0fmZ1Hq+iP/BcrvY3thpAXpHxtyVAjqoRPBtQVLSjH?=
 =?iso-8859-2?Q?1KhZ3+JLD4fjyw+dV4+yqMYx/LfTe0XYzWCFO9qS2w3pGLIumkgLyqDiXe?=
 =?iso-8859-2?Q?BsWhkKvexdzt1IZeYrVoRz9aDMWyKeA9XlyJ2N70uUTZ5mAaDVMS6CB9P/?=
 =?iso-8859-2?Q?LFk46nXR6+xm/Yab8hDL1RqTdzjQIu1oUDg9IhsJXv9/abd0b9et/KHGJg?=
 =?iso-8859-2?Q?32hMzf0ksH2DWsCM/1aNfCDEqc9ZhkwkcG4dBbMlW9hG4DsqWhgKrPvwge?=
 =?iso-8859-2?Q?W2ps3asMovBalwS4Fzp2XQxzt3FKmc05mtGjKDp47goozyjqYER0W/CQMy?=
 =?iso-8859-2?Q?wxuHSlKqQVzoisKYslk4RmTOnG+d95CsTospyVGqgYRM2d97HriI8L3+gL?=
 =?iso-8859-2?Q?rghA3GsV+3kRKjC8GrHhCDGbiUZOia33j61SNjKPC5yuiGAdnJ2bCvuqjk?=
 =?iso-8859-2?Q?GyGhKBVKVJDP0DTDtA4xPb1zho2NI6q0mbuLqCawhDMOYBj+71ZWBnZGZY?=
 =?iso-8859-2?Q?h7JXIGYYAUeP1BjyplvxHQEhHluFpZ2KLUj99dv7I4+tgH9gtdXeMZ4Uv6?=
 =?iso-8859-2?Q?yJGGf8Y2aGZA3Xc0WAeW0d/vaDqrDHtC6G42xRmKwFSCWaWqZ3/1o01/Fc?=
 =?iso-8859-2?Q?HcNfXFfaKg7yDNPDlLJKLjs5CAi09zfSciqqo88EfudpwvHChJlMKq14Cy?=
 =?iso-8859-2?Q?eQdeRtc9qy027PfTjGIK0b9bt/Njz6yahuKbgC/OUVZ17/sPBSR52IKZf6?=
 =?iso-8859-2?Q?GMNf4Fn/5QVvD5rok/V40GfIbeGbaZ+vQPtXTMyTNiG8m9C5dsBt54wUXP?=
 =?iso-8859-2?Q?VZitf/u3bI3QrBtyHLdmUZrqS5PFPuTHf3xgaci0zQFDoLL3topXQMF7R7?=
 =?iso-8859-2?Q?AkaEk266SHgNKv/rhBRjEZGf3oMdGASMEBylOixuMTR8DCrbL6eTzvZ+CQ?=
 =?iso-8859-2?Q?N5tXNlG9yvlmPUJbcilJiOz9+ZqLUVdq4CNvD0iVlgxrjOQ4+NTttutSHP?=
 =?iso-8859-2?Q?9VkcfgDYf21yLkWaD2tUi3FlyjEo3VjNpG6hEsqor8LbZNTqRutybDNfpD?=
 =?iso-8859-2?Q?zoxwFx6L7FwSmInPsL6PDk3bUNgoiSMs03cV6JoMsfSpQsyizlHxTxr2+3?=
 =?iso-8859-2?Q?gskEDzhdtVL2PgSIxqN4zXoUXTjQP8JRyGN+5pePetiNz/wlPhmvSkZrGO?=
 =?iso-8859-2?Q?S7bx9gGGG50wzMjHjQ3FPKP3y95j2v9mxCq/PSc7jHRgk63qApOKsyu00H?=
 =?iso-8859-2?Q?R5h+rPpw+y0ZQ3eGXxzgk018Ct3MZMUnk1D5IiQTEXpYibwJ5QPXhbUmfN?=
 =?iso-8859-2?Q?40/CcH1KXxQAYG3H4++D2E6mwupc3kPo4ZvE36a4T/3AZ1Bf6DG82wXLxl?=
 =?iso-8859-2?Q?011gPh58+tLA1IllK1oMBOPRBgvJYBTo3WysvvfMar7onVm4pyylhFfw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e633e188-d544-406a-429a-08db67f0e52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:20:53.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb5T+JgP3IEdvyp29EQz7xg1W3oe2yc1A3I93lRyfSyZUp8EEkPG4CAtRwfyMGepPLGde0mdXmBirlC/dkoxWMjNQ4ArokwVhocKVS4x0/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 7, 2023 9:16 PM
>=20
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 5.4.246-rc1 (21d8ae1f2a=
a0):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93073933
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
