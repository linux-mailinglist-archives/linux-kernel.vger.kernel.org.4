Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29569FEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjBVWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjBVWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:40:59 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9C43930;
        Wed, 22 Feb 2023 14:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaRJOhXGjHkPABsJwwBs8C/ZG8vtU2cEbHMU6/NqhJ39nL2PyCVJfBBFVGxfxGioh7+l7L9PTn3po0ksg0kqUXH8JnxTvvgHha1PW5aSxz0rJVJgRmZAJIe9bQ0hJaII/shFM5jaReKZxaV8jAFaqRouzwPRKeDxl4unDVajLR/opZXc1cjnweJsc7aoNEQakUJHu51wSO9wz3xhAPq3uT5NifV2AkmVj2fuh55w0N+lo0jI4ETe0fBw3/5Vkl0Z96xoxTd8h6D/0WpnmAPFLCp+8d2n1UDi7RxKyFSDW2ueqNIno5cVr2fwas+FpJ0DqGPiTgylatGuI/nP/umzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q92Ik3LebLrMkO8JLUWuBFwdXGrIEAa5SkKsPOgp+4w=;
 b=Eilo3orMI2ow2gSyjmtSCxCtAR0N2zpoaZf8yDezqSd9Cr98bZYYkZZ9xmAsxJhH9nbRovRPKyZeG1jIZBlmXK9jiTK0a+NNdk/F5e2S+iVDINY284nV52Skk61eFAdw00uSg6mdKNnLOxwGE2D6LaXnh6Y+N++Gp0n8JJZjkxjXwsVcvMSYadbFny/054hvMTaYPlHwURHMyytJaNYJbdErV/qD3I0oe+d+WsTraqbg5tObyc7sf03M41Zx7iQeY97m33Fu8GiRDlHdn+JRfLRp03xYBJM16D0uKIrRap8fhWjpeYFagvrl/lU+KR6OBFNsWMK2ZS5ppe36O0fSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q92Ik3LebLrMkO8JLUWuBFwdXGrIEAa5SkKsPOgp+4w=;
 b=T12dCpIM4u86DFTiv2RyV6+p7zsmV7C0QIJRJakBNo07EMJpGyM/TE+G77CgfmOs5jxF8Iwa4QDiL74SAeW4l0Jjlz1tWe/oUDJvL839vbfyC44c6N7XfeXzLL4L/sn2/Vy+wAJ11dTr2wyneX2fgwgFoYobaGhw91nz4vGthbE=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by OS0PR01MB5906.jpnprd01.prod.outlook.com (2603:1096:604:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 22 Feb
 2023 22:38:00 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%5]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 22:38:00 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Nick Alcock <nick.alcock@oracle.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>
Subject: RE: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Thread-Topic: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Thread-Index: AQHZRreG6t0UP/1OKUiYOQvTbD/Rt67bi/Bw
Date:   Wed, 22 Feb 2023 22:38:00 +0000
Message-ID: <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-19-nick.alcock@oracle.com>
In-Reply-To: <20230222121453.91915-19-nick.alcock@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|OS0PR01MB5906:EE_
x-ms-office365-filtering-correlation-id: 2c951b5d-f9a2-407b-ad73-08db152573f4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgVLNNGFhUomnhSM1FDZF/os48Sbc73m/3XOYpRH8MS8/Citt7tRq40FU9ibZBy5rp20ufT5ZdRaJBHj9w+64Qb48h3IVbicNxyQIReFcE3PjsHmqMCBQrJs1kQ/x4P9xKjifOPc6Uk/orYmgN32texObRNXCsyBfOQD00PWLkbl42pN78tFpwuaJukBnNztPKkA96qD2PfQY6UuYn3iU82H+Jjm8ppvkQR2wJZKHsjLlVscFqdL8IWX4ghEDejpllgxcfIk6BKCkk6PDDOo45mmS2hqErEOqq3uqEefRUjr+GdFQUWw0b7zVcSXeUo4mL0kpSQhzsdwktGv87KNIrQQRXrfOsu8CYqxS4LNtNirYGO1Dtqc8mEXR+9wJPhLUBmMcltwfXMtEtoIadc8MnvIcyB7FC3KIbsBctugFbiWyCUH1E51VbSU99jElMGmeB5HPW2GAThxtUTdUPWDLSxD/mUTX/P3QnLeebjooyGHkJSZTjGJtGTT5mkNhG7eeWBuD/e0ooqxZbhon3ZcOg6mTh9ACnzTmro6sEpf/z+ufJMD3urNl3eThIHSnoCcbHnf7aRQzigd0Lzk+b2YCHWehG48NCZSFM5j6pk12C4OM5b2LVMy2EAzmx/NBGDXxiEGh/8yYNk/CLZix4w6VwPJwwKeZ6X+ocZlR11g7Q1NGVqkOXi9TbHWiDLOx8S3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(316002)(54906003)(4744005)(8936002)(2906002)(38070700005)(38100700002)(71200400001)(122000001)(9686003)(33656002)(53546011)(55236004)(6506007)(186003)(26005)(110136005)(478600001)(7696005)(966005)(86362001)(83380400001)(55016003)(41300700001)(4326008)(64756008)(66446008)(66476007)(8676002)(76116006)(66946007)(66556008)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dQoruAV6UYvDzDgWy+FpTSyXcVYtoYhEPWnVPryI3Cx4UB7JQNvc9FNHJrEZ?=
 =?us-ascii?Q?c/JjYVgoQSZNuNyiXdM0kvAi16AGMLD8jaPvsenPFI2ZedjSb6gBGVGaLlUy?=
 =?us-ascii?Q?mQbaM5NW1V1uR2cDZsfrp+cBgvErgSYCTY/hDmpmMSGGRBjLqpd4sUwwQdRl?=
 =?us-ascii?Q?/2XNbbtCqhTsOtVdCs2v2Rdko292y9s76MlBz/sE7shP5yk7G//IjUQaFWIx?=
 =?us-ascii?Q?kUkHa6D/sVbEBDSMwLdH64iOLObyA+sgqVnu2BAbUkPknZOXQ+NwzmtTVvnc?=
 =?us-ascii?Q?v24cJ7nk7rLlNJKzxPW8IR8QGy8K7qhsOycVzYLexL+DzATi7KCZi/8b9tTH?=
 =?us-ascii?Q?uw6Fn4s+akHofmp2JR89ydVqPVsewYFrRgunHstHtD8b+mj5pmD9LIVZ9NSh?=
 =?us-ascii?Q?BGLRglDhI/lEg2SzsJOxKDVX8kEUc7DTRVwNC69tLyz9WMlObcuPxDnqn5pM?=
 =?us-ascii?Q?M0XkD/1kZvcuOysGEz/mVlAFUcnAe+cSnHDHUVB8y34nlxOW5Nea/+iqONAP?=
 =?us-ascii?Q?RrEyvRw1VFHvmg7qOysRA0DPkRu8vzcXn/DfMzXy92olJ9W7lnFU0jujd7np?=
 =?us-ascii?Q?dBOUvmRhfk8LhcqlyTsIWWbBh+2rs8tVqxejgXoRQu9oCWMwrA23T4VLXij0?=
 =?us-ascii?Q?SvVLLyYmhlAoVAA0YusV8RL/9A6hZYn3kzDchVzLVvuWhIucjIk24BM5O7mL?=
 =?us-ascii?Q?CfpiPzHi9Gwsfoeom+exv7Z2nQNYNFpxV9Byj4cuLAqHC/S/ueNY3A6LKwDp?=
 =?us-ascii?Q?/s2EPBtMuLoE46B24TkULkvNoUHjSaeXdQmKnNETPjUJmsmKpxf6XajmjV61?=
 =?us-ascii?Q?OddkKonjhDsMCfkZ5O9YtOit05LsO0AoHUzC1HRLNTFt48aV72+5XTqzBRb5?=
 =?us-ascii?Q?cy//pXj9vdsPnAKBIJV4eur+VNV3oUL1rsFvU0LY3ljnzgLL6n/Q7RXgVuzZ?=
 =?us-ascii?Q?fj3na96fzHJBUnt/R8h2Hi7bOEy9R4Ak2x/74Q1cJdqdNtI3ze0mtb0pbCGk?=
 =?us-ascii?Q?qRCTubqyUhDaqK2AzVhW/MqTqtcH5yhDvdAMr6ou/3ss0naLWY3iHyj8nomg?=
 =?us-ascii?Q?fpDIKNOttHdA8x/pxywIFjY0UCsMMCg10thOIOKU1SBurkTNYrZyXEdp8WQb?=
 =?us-ascii?Q?+lR1OOieSjuQoEbAmd/afvryR6XxipCE0DIWJNDvxKYEDdI6IEgMXAD81Lq8?=
 =?us-ascii?Q?2O16FW+ez51ka1vm3/J0+I5IgQeF7gJw2ehD7AtK7JgFrEMwHFXKXXwyQoP+?=
 =?us-ascii?Q?y1wR6bC0bP8p6aZZzirBl1re4AKkoL6hX1pULqtg1KPYTeXsEhnbfAaS5NYS?=
 =?us-ascii?Q?pKDFfzAOLdEpY2FqYKMFAtxX4Sf/kzrOlZPfBaR9PAR3pzeqRmLyZlJAznRD?=
 =?us-ascii?Q?vsYhe6KjKEk+kZRuSpHqxIAcnDZ6ul9VzxFWzfp+Ej/ITbMtRM66EtxfZypL?=
 =?us-ascii?Q?EGV4xyGNrM411nOhwAR+2arCETYRguY+MC5/wTkpvIMBMvg0R1q3NPC27eq8?=
 =?us-ascii?Q?EotlJ5Kjs2VrgVL4G7i4zW0PIWDIKpI//O1wNT1AIiqCh1sNCi7N6Q/+yQgc?=
 =?us-ascii?Q?8GHVjioqg7IAi2uJ7de0vtFdd5YB55roIUXl+L0B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c951b5d-f9a2-407b-ad73-08db152573f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 22:38:00.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mR2QbAoz/UrifmeI7NBL3xng4uy9rwaP+PTLeac/A4wYlRuMyNVUIbFYcnrDq70yvHI/bILH4WyODjerM8OqcS9i0lR2ntRREA3EF5z/uCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5906
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 12:15, Nick Alcock wrote:
>Since commit 8b41fc4454e ("kbuild: create modules.builtin without Makefile=
.modbuiltin or tristate.conf"), MODULE_LICENSE declarations are used to ide=
ntify modules. As a consequence, uses of the macro in non-modules will caus=
e modprobe to misidentify their containing object file as a module when it =
is not (false positives), and modprobe might succeed rather than failing wi=
th a suitable error message.
>
>So remove it in the files in this commit, none of which can be built as mo=
dules.

Makes sense - but if you need to do a V2, would you mind removing the erron=
eous claim on DA9055 at the same time?
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/Kconfig#L364=20
Strangely, seems it was always there, yet always bool...

Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

