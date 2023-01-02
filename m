Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934065B35F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjABOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjABOeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:34:25 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2068.outbound.protection.outlook.com [40.92.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6162C4;
        Mon,  2 Jan 2023 06:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeEz4jlEA7Q1aK6xOBwFwnaWzSGYp5EPTY9EqjpGFo3PpetAxsqDCtJ9WLlZ/nlLm08Vpnxk+p1hLC/rdFP/Isri5kBG1q0KvIF3JFMB7mGrhXcRC1+THg/Saym1X4R4hiVkxzg6TXs7nVsog/kVntdpOpLqD1DKFD8Sitd58hBNxGUWuWXw4jUV/AK1d26D+I07u1AsG3ljBxQxaiT4GsN8l11aL16TVIKKlRSfcNGFcY6/fMWd28+2+msp+ROlkowSdmpXsNwCqFG2up3j8QK08vQyoM2S6N9XPpfTF/uIrVihGwhgxXNadcbj/E9Wa2FxlG9pzN3VhWJ4EP7UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPBwa7fNZnuX9AB7sLhynGkKj7iGvZ3nipo+pWbXmGs=;
 b=Vb79kup/VG13fkJv75up9hT3Y7uPL3z925ul9r8w/RrJGNlNOjdFXuQfHMbsgvcFLmP+z3li9IzitjaDBTinC3IedpBD93fOwIOa8IQnLoDne/Bb52OxbqQbR+9gFriGZkfgFwu3euvOn4qN2XbfMFKnJY/NF54sObVePq5LFwrH8ml3qPTI7dRE2O22zSOkQbMQQrKQxFyT3yD4O2bDG/ThxeQ7GTMjKJYU/ZQGk1VEzVhLy8qst5FA2XGCIZc5OONKIym+sgaMdE9vv5k+HyHlROzLJ3K6RyAE5O9t35l92veVFMclO3gZDI7vXzlTp8hx1IxGqE/E1uKZIG83AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPBwa7fNZnuX9AB7sLhynGkKj7iGvZ3nipo+pWbXmGs=;
 b=hZjW8bWqaiSO6t3JAqmQhrtuKdIXja5jrFJ6mjrotWUbmibeVov3H+V74G7S9W5C8MJ/sFfp1LoJTwDipuCQmfdKjax+AZcPC9wjFMJzgpNBgJU8NHXOyRV7x43c7gUF3bvGVQ0sVNrbQqjOm6AXmbEfdbiZpNgsGLnDRQ/K20NwVNcBv2Jb//u2263sO4fxr3KWf7AOoJkj2wMmv3jpzeB7yj8Fbmi1Fz7Fl9xAOE0H5M6+gTHFwcSR+HSB1wNecuVSt0WLmTQjp0q13BtknY8wb87TKSsIn6JIvBWr60dbUTbU0qgTDBC2L4Ujj6OIIgZYHsxj7f45bzp5wapftg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB6609.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:34:17 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:34:17 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Ian Lin <ian.lin@infineon.com>,
        "alep@cypress.com" <alep@cypress.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "Double.Lo@infineon.com" <Double.Lo@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
Thread-Topic: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
Thread-Index: AQHZHo718NMBa+5HNU60gzVi1Spvqa6LJ2UAgAAA0gCAAAkygA==
Date:   Mon, 2 Jan 2023 14:34:17 +0000
Message-ID: <BA494267-7B5A-4042-BD33-44F62837C8DB@live.com>
References: <20220922104140.11889-1-ian.lin@infineon.com>
 <20220922104140.11889-3-ian.lin@infineon.com>
 <3eb9cc12-db75-8042-4106-fa6521c684a7@marcan.st>
 <6D6035D7-894B-44F6-B35A-3EC9C57029B5@live.com>
 <91c8fc96-083d-74b7-3015-e76f1ab59cec@broadcom.com>
 <6e204026-d102-6d81-f58b-f4340e7d07ac@marcan.st>
In-Reply-To: <6e204026-d102-6d81-f58b-f4340e7d07ac@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5XsElTdK+5CFBK2m8CM/133hQGklwSZJaGCJSUNo9jWtfr0eGsISymOfuSkbof0q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB6609:EE_
x-ms-office365-filtering-correlation-id: 7972c0e9-7187-49db-a12e-08daecce6ded
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/xWC5hW0xzD/UiB32JkMPPO57QsVQ47gDAWBDKeHahVJb4VzZUE+AQwCvx266QMiwCTOCYSwHiQFubv6PZiFnSLjMlfE2uGyrm9DXt1dade+q8IkrpYaEFjBS4uc6hoWU/ZyoeYoCjnhEhn5AW0bM4DOxm46jBg68ywsBnWBh713KwU6XOuimYqE/866UeFcVN/Z7G5KreVFfuD+fM2KmJaHxeqgnMLRJHVty7zEYtnCfyejHjwA5zU3c1rJCx6xgZEr6THjhezsT44ISjsB0Ccj/WPuI134UDxnvrBByjjxq9yvhO4+1XvpEKdc7/rc2EEsld/a/mPehbGssPa4NbLABR56BpFsEuvxjGVz0kVJvLAy1cKL6O25C/OW2j+jNsf+HYTLd6O+2EXNRnJL6w4adz/vgHnr7pyPexFJDaaKKKlvwreeBwP1TmbS1RkAMcmGy4/wi7dPGScXCrQsojSM+CeKia5T86uCHjCP0fl5B1S38nrH/DzNbp4qJ4zDq339CAgbJBbvmNIgH8DChNnmMsCbPSN5RuCrdrzGcaM+WIB65o3K3O+I0LLzS04a5IGX5yhYaUcRPw+sR6PuAziSn6cJvACZztx6/CJrEPUeofQvNoEmcWFs5zggZ3frwVDnOOIPYRlZQ8yqaCD0g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRCqQaOlkf/T0vG7yhYtStVTqpFSujxIOB5O/gp3ipz0fAeWb0/vku7pRefB?=
 =?us-ascii?Q?rtOU5TofyoF6ck26wrJ+gIaShgPDxjCDxy4IMLLBgdqrR0bw7OPAgbFzfWTr?=
 =?us-ascii?Q?/2U7yu7e4+5I7+JSGYVAwljwgpZITGblGoRjhBH2s5qTLpeR3gAJ3f/T5XeW?=
 =?us-ascii?Q?kHdyBwItnrI/zrqpEDVhZMVvwMIGfFZjPgeiU7PJM6yqBtAsypDOR/AxHGKl?=
 =?us-ascii?Q?G7ABxmoz8uKDUstaBSknyxOvMv9nMBe1YtAc1zJAbfng8/D/3Q0SolnJGR4x?=
 =?us-ascii?Q?vrP29ydkD7CVqlUW4SIhk1GT+r5hdygDXFmJ6ieEKkmVrKX/GoOmU3ogLl18?=
 =?us-ascii?Q?9ddwSpYVXstqVtBoidCqrjgw5yOwUElogN/4blYxgfcp4w0gL0Se2a/fU00j?=
 =?us-ascii?Q?ii37idvyhpAzuA4U8XqYw5rffd1yupWzbNeom7OuccHBiRpdKPv085pdJOgA?=
 =?us-ascii?Q?Wud3234mNuxHqFlXQiPW/2m07VUFkpE3YrYVd4vqIEz73CBv3OiUBClxETyp?=
 =?us-ascii?Q?I92BeO78FxORkdyWJPaK4FvJZP1/jMzQtv64NXvVCi5xyqtkChufv/2FU6sL?=
 =?us-ascii?Q?Lhv6V9BvNaJFoIiXLlNHLGd0HJUGs+Mk5ndQwH8YnEod2qXAuuMecgt9ZLV9?=
 =?us-ascii?Q?XXKcDc5kC+9fAMRQrHW8TH5hB7rjAtyyOnMliZXk62UGZQUxkezaRHipBptx?=
 =?us-ascii?Q?zkx/IGMK5GIdE4mWHyiIy6XD7JqkW8EcDLvAPqquNOnVweH52nkZ80/hzniU?=
 =?us-ascii?Q?SzxclDmrJqPWlj+QQl5o6YsVK0LqbzJbg9Jpn6iCmNVyPj76KMXOyYsD04oM?=
 =?us-ascii?Q?Q/0VT6zqiJ+UJAIwMlfWhD+IfvaQonXoev9meKRp6TG3wUXzEZWZ7YbsND/g?=
 =?us-ascii?Q?69l7r3krpsO77Dp6fJl3HzcRIzgAV9MgN6Ix9473YNcuoJ2sJaUWl1pnppvx?=
 =?us-ascii?Q?s2E+rXdY6Rj30gXQeupmPBbtp5etVamFwFntHyrje9594ZvHQuULLk4+MHtp?=
 =?us-ascii?Q?7CcqdoklwB0zUunlyRnVqJ7KzI0X6Cm6CbOz6Dh2umJQzMFBwknEBp9peIk7?=
 =?us-ascii?Q?9SaeqMhzuUM7U9eAst3npmmWnpcVShoThpEGrOJom6YePCm5s/6s5fZyVRod?=
 =?us-ascii?Q?3R5pcVkdpMCiJnJrz1B9QWjJPz8gYrkHymMsJinOCtvaQHro4VlPQ5YdjIgP?=
 =?us-ascii?Q?xgJUAFcgvnwzj4DfNI5fFXgSlqwFE1UpGq59b6/hE+tI//gi4jlc6sXe3Fio?=
 =?us-ascii?Q?xTB0Rl2orAJEUodYrc9knv6huvOgNyyCSOIwNZlVWsGkl31U6AF3rsTV4t6e?=
 =?us-ascii?Q?X2g/MuXYVm671vAhMCOIcpuA3jbRPjHeGnIVQz+4vPecvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5222CA80F583B4DBEC100A09E97CD7F@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7972c0e9-7187-49db-a12e-08daecce6ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:34:17.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6609
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I think he's proposing we special-case Apple chips into their own
> firmware table just to avoid colliding with non-Apple firmware usage,
> which is honestly kind of tempting as the safe option if nobody from the
> Broadcom/Cypress side is willing to clarify what, exactly, is the
> relationship between these chips and what their respective revision
> numbers are so we can *correctly* represent them and avoid further
> confusion and problems down the line.

Exactly

>=20
> You might be able to help with that ;)

I am sending the patch.

>=20
> - Hector


