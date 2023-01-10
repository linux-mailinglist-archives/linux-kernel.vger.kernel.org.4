Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05688663ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAJIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjAJIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:22:24 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889043E79;
        Tue, 10 Jan 2023 00:22:22 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A756ip028593;
        Tue, 10 Jan 2023 09:22:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=qEdGqh3OuqClwLvPjdgyiJH8HXbLWvIVxb3A8jmn6Zs=;
 b=Wb4gxhyakxJam65cS1cXLr1KbJjxk4Usy0jmaQIcUIgAHYJKB2oNeKRE7KEpFTuEmIJd
 pffMbakqDZGMe3os9KsqOs5uLVVAcvroBC1o6H+wbmCAbsH3YAVh35ACrgSY2QJvlx+J
 i5xeE7y0fBRNWptZ9EMTAAxZqMGXEeZUkmbBX65gKBh0WuyjUabw1/QB5LFPlHdUGclR
 kQb0VGXC/kb3lYwySK67QFJu8IjlBvtO8U3aicJpPJYHhmu2JdPqCM4Mq3qAAEThdmWu
 1Wcgu3sTRYGZCnGZvMNMeIzTz4/gFunezfTiOXvl33tVQIs1YP9l6o8UO8ChyxPCrPAZ 1Q== 
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n0ppnbjav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 09:22:09 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3OgXyDSs/xvxROgZuk4zSwQ1iuOmwxmj3wBbdkTgTd5bVDsLNhwkTdwlJOpDDRpuoxbnkpAhSodsUPCuEN3t9Llr1y421QBhlqQhgDrGJVlCwbG+l1djnJXDE21EsAcDw7x3cy6aTrH/H5qEr2emI2ywqAvE9Ku9tNDADS3pdcUNBjjIda6MmxU7sQJ6d/WzrTD8Tbyh+TrV6hc/9t+fI91iqpXqhFIA+cPwosyaHjqQ8tkmcOhHIyJ3WkCvrUwVugTLht7H85nDKsdMi4FbeTiwLqWledrQXb5X8K/ZwAsREKWXNy1ttP6juyw6nFy4KJkDu2vMHicdHceGX1Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEdGqh3OuqClwLvPjdgyiJH8HXbLWvIVxb3A8jmn6Zs=;
 b=n0xdd2F5j+U4eF9MhCeGdETn1m/eBClEKyiOlmMBum6Cf+dq0adSB4T/uCTsd3FT9TgH9Qmrqj++/ZK6CVj1bhtMOM7Sp1s9f6VhrieGqVWvoTNjegnEuFF2pG4ekZdFd7QgxGCGIXweoM5URqfyh8DsOGSWrDyv0Br3Vo0MI07E6RRtUoB7DjKGEtibQIxIyEXeMfrh2t5UtBJ/7VlLypZXAFXG1mmQfBWwVx1hwbaxMA2lPdy1zAbBV5VLWfbS8YsHvJzFDKkBCCm7MrcX6vx5LU3PZIYHZkHf0UgjFkhuFystYFxakJB05q32ttRfL/X2hrgpDIebU3+3nVDfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31d::16)
 by GV1PR10MB5793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:22:06 +0000
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::796b:bdc3:fb1:fe93]) by AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::796b:bdc3:fb1:fe93%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:22:06 +0000
From:   Alexandre TORGUE <alexandre.torgue@st.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Patrice CHOTARD - foss <patrice.chotard@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tags need some work in the stm32 tree
Thread-Topic: linux-next: Fixes tags need some work in the stm32 tree
Thread-Index: AQHZJHM7W/isgOlr7U2dMteeXS5GaK6XT78A
Date:   Tue, 10 Jan 2023 08:22:06 +0000
Message-ID: <AS8PR10MB47121F3C3C9148E48748ACBFEEFF9@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <20230110084159.7d20dd38@canb.auug.org.au>
In-Reply-To: <20230110084159.7d20dd38@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-01-10T08:22:04Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=1f76047c-b3dc-4f48-8253-ba2fc6f2583d;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB4712:EE_|GV1PR10MB5793:EE_
x-ms-office365-filtering-correlation-id: 6d40f705-1864-4983-ac20-08daf2e3c2e9
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZXr+iicyQYF+xdiu5IrXyqdA8p0RXrEYb6FCF/ypy1ThAh5/TMlv1YBZXohb8br3ZHNTgOsfAq2Pwr7LYoES7hb7MiiDuQzNvD03mNLLwBVNQY9FPqp7pGq4xJ+vVtm8GD3W7AFzE+/e8IUoiZgP4mYmuv8VoHjTZOIsGNxNZufTN/CHPt7sf6TYOIooqxzPQA86kmNykYLyQMtETReYqRfBUc0zF7jJeyVAqazkfiksCS1/9A7ir8wW8/15zZVUoVQeUSAHoi60+YkEFb4fZbjfERQLPK7jhXbi7FraiM7RhYBcQL8xRJtghBT0Y3h8u+x7an30yjAlj6ThGu3wX/4278EcMO5MbeU/CfAuqlz2z8vmvbjyPQMdp7JRdDGBFn02QJA9vA6idClsfdwyKf3WL7felsRNLUokOgq/zX97Umj/d4uLLUA9aBtwHJPz7p7dTJthjl3B2bqpU3lBSw4fB/SJOqtUKgiZ5snpgKf2IRpm/2GvZbiZE40InKRxO6tlAzOh9LR4Co0aisyKsSwQ73OyKsYgC32fg75cuUn/3Mt0doR4BQr2lA6ZvRMPmQedbml/d0OZH5/gY89GoNe3PSFCN6Wvg84qLcBT/Qo269bIlKnwu6OdWJkVwLVLy0BG6VrNt7UQk76nVMZ5eU9DMXg9ugZGWtmQj9hnV2i2RcmDZDFq60yhkMZejAZe7UuTBAWMo6OFakR6gbz8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(53546011)(2906002)(71200400001)(6506007)(7696005)(9686003)(26005)(186003)(478600001)(55236004)(55016003)(316002)(76116006)(8676002)(66446008)(66556008)(66946007)(66476007)(64756008)(54906003)(6916009)(4326008)(41300700001)(5660300002)(83380400001)(33656002)(122000001)(38100700002)(52536014)(38070700005)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QlQEBz7eAlq4IfDp97nn2JvkOHdqsFK9dw1OSFvx8o9UL0v/LgDykoWacHCA?=
 =?us-ascii?Q?fzOACTDAwBe+skArCsZ5ZHX2Ear8rOBI6+fOzQboZNPSBjPtwUhrw1tqNyHJ?=
 =?us-ascii?Q?t5KSZ36ssLwQLDtyTjHNvxCegbeildMmOKjhlb52l4EsaE45E57jCFMxS77z?=
 =?us-ascii?Q?ogHIM8yU8B7/7UROmDDZep9PAu1ZEE9ZUcVR0qD3WzyA3Hbnmp12lJ4a7fnA?=
 =?us-ascii?Q?WJifv2SwghR/qSeHs0GdkdzinTZbLXMVkY4iABKx3/cOwJlAiehhzzDpCfao?=
 =?us-ascii?Q?yiKhPIVY9SBbtwq1cFWlGOI0SJP2a3qPALDpNY6GxykVA9uPtrqg2JZmIBb6?=
 =?us-ascii?Q?/XI2miDiOOF4faXpPg1LWKntpoexVoQNaC0VmOVeXqg/W06ELUiaEAH5MKgl?=
 =?us-ascii?Q?eJwRPBTadrCaqvDKzbQ0qedWcF3RnI0Ofm6dX95T/Jo5awfP1gL/LN7/qtvV?=
 =?us-ascii?Q?FB0EqFMwgVdhEicoNMUS8lh4VhnUVJ7xPbEPHqq+s2lNhMk2gQ8ClB4JlI/T?=
 =?us-ascii?Q?OJ8+Gdv89nUAft8gYQG1nTrwbynHXS2SIDic7t7SB9wiiWA11MBpG/hGGaQS?=
 =?us-ascii?Q?zYQamzMsmNPNKWbqPmEhNZERwpZoMLnYwPc6gxLwagCJiSyfRsiBmzyX339y?=
 =?us-ascii?Q?m+OZNtAjHptZHng8Qz+WoHtbVgKQcDvla0WBRYQlQEWqLdDX/Y5Pz58JJOJu?=
 =?us-ascii?Q?qq0dgdVNCkerntuLs7rs0yoMnvJdy1cPmOfu3u8aA7dSRYYhnbSNHQgiTmPT?=
 =?us-ascii?Q?5arFFBZVRfgFmhe7O2tgsYgbD5spKMfyalAdljdqoStSp/xYN9tl2O7ab4R5?=
 =?us-ascii?Q?Ms9xJTVIOKvzZ+URS5FaJOSE4hVewpG5APU9FJ2yHfigMOAt+RpoFJQJB88O?=
 =?us-ascii?Q?H+9e2YZ018vaG01F40KmZX/YK52rYenranC61/eVq6xbP+AFONqccXhhZdBE?=
 =?us-ascii?Q?Y5MVFdAfFuwTEVNoVcnvwu1nRzz2CNwCxRkZU3H9QJCURePbkWZIvahdGTZz?=
 =?us-ascii?Q?xxDhbzDW4wMYbwFFfEFgHLygWH6V0xFg5g51EaqGLsJiUKLgzM2XTfDiq0UU?=
 =?us-ascii?Q?LOoJ2x2dzD+waZe6GqyW+1grrBisuU40cuXqJD/ke1mba3gGXj70tU5wD9zS?=
 =?us-ascii?Q?nogA4eh2t1qNbrUa7RITWvyT9fWuZc7yyxoXpheXlVyGFXdxLHoG3cXAezkm?=
 =?us-ascii?Q?/g3onEX2Vs2/3yvYc47iYcPPiqfOcdJgv1pcJQfNuGAOggItequq/gZmlepz?=
 =?us-ascii?Q?TZ9NY9luG0IqVgh+DNnWZDGengiSOLM6jv1UO3BRWM5fwJuTAcsgy5bYqOoy?=
 =?us-ascii?Q?/d4LC1wzGI6hcefKE8KM6HlB1oiNbX2okUZKVIORc6BFK8a14xBaG/Ro/E3H?=
 =?us-ascii?Q?6a1tlepar4bMp5KQ9LuuO0ISZ7qCoPIjgmgvB5K3IsUBWQs7IisjooN6T8uH?=
 =?us-ascii?Q?z4P/lpx/f9brXu5kZO6zNQnBwC5ExvGQ5sSnXeV0ZwDoXOr5NJ+iXcyscBjv?=
 =?us-ascii?Q?er6obd82f2yWiSyLHz8IaQNmw8iDwWeYxi9YNbz4m3xSpDTAoz4wovwi7LPv?=
 =?us-ascii?Q?/l7faov8thTylDJRhWdoZPWcUyCZkRry5Lyv8Ii1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d40f705-1864-4983-ac20-08daf2e3c2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:22:06.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LR8d0W1kCulhP118yHQEwwmTXPNHIS0h1N1ppRgQZcehNvMYRtOcp4ZilxbRkD4KadUWQvj7Cw1xBY3ZaA+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5793
X-Proofpoint-ORIG-GUID: jzQiks86K6WZVKui2Z_FlzRcooB_sqe0
X-Proofpoint-GUID: jzQiks86K6WZVKui2Z_FlzRcooB_sqe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen


ST Restricted

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Monday, January 9, 2023 10:42 PM
> To: Alexandre TORGUE <alexandre.torgue@st.com>
> Cc: Patrice CHOTARD - foss <patrice.chotard@foss.st.com>; Linux Kernel=20
> Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing List=20
> <linux- next@vger.kernel.org>
> Subject: linux-next: Fixes tags need some work in the stm32 tree
>=20
> Hi all,
>=20
> In commits
>=20
>   731c05eb8ec3 ("ARM: dts: stm32: Fix qspi pinctrl phandle for=20
> stm32mp151a-
> prtt1l")
>   1bfe5bf6a0ab ("ARM: dts: stm32: Fix qspi pinctrl phandle for=20
> stm32mp157c-
> emstamp-argon")
>   b8deada61dd2 ("ARM: dts: stm32: Fix qspi pinctrl phandle for=20
> stm32mp15xx-
> dhcom-som")
>   4beb2a5e840a ("ARM: dts: stm32: Fix qspi pinctrl phandle for=20
> stm32mp15xx-
> dhcor-som")
>=20
> Fixes tag
>=20
>   Fixes: ea99a5a02ebc ("ARM: dts: stm32: Create separate pinmux for=20
> qspi cs pin in stm32mp15-pinctrl.dtsi)
>=20
> has these problem(s):
>=20
>   - Subject has leading but no trailing quotes
>=20
> Also, please keep all the commit message tags together at the end of=20
> the commit message.  And I don't see any point in the "To:" tag.

I just updated the branch. Sorry to have missed it.

Cheers
Alex


>=20
> --
> Cheers,
> Stephen Rothwell
