Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33726151EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKATKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKATKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2118.outbound.protection.outlook.com [40.107.94.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9811C416
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZwaWQbR49fy3jv2DlkUDyhG3dbax/vXIBEmpwEIdsWMzeQ9glWyrZ/54bue093uNPoWsQBM7m+m3nLebzSp5wzYa5BW0WTWHHUjJgw7GkUHTQ8mHue5JVO+EvvenTLvHA0fWI2psvEMP1hOvkJr+qXkwuEQIESZ+grhdcVVzB3592Und845sI2MA/c8TygH3tcseEB7BhJe0/YJJw23NPPhN8oocwH4pZ29rOxC4Ep2Nc5a0UDn5QaUfpNbQOjxzWyBpPRARckkC4bx8Oefhf+fORYa8tOpdRUQdG6dFYSKHth6WBbfuSBCEWif71ZUVYstrIlrZmOVSTmDoObjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee9IGk5emo+uBw3wyBp/cnsODjfpxM9zdY6GsmDDlRA=;
 b=nd6TzY3uiNx3rXZY8+Tec/Jh5QqTRaMjRleTaraM2hUaT/H+C5jwTvSPmQC8Vv9bs24wVbhfuDrygLIsfKPLcId3luKBJR5KKxEWFS9/AHUE6kh+QsWvdEKvLluTLlECjuUuRgVfUDl10tExk2kx9KyKt/1qhD089COZlX+Hn+VQ3Ckf3Viis5DOElM+IlVy/gZlt0bwxIG+OOVt1WQx4lHlagSTMNzaiBru0WIEqnMaHVZpjRAWKYKr1j4u17W7YlfNGbymnzy8G8n/TPN40h/NCatQDkw5VFAu3epYOBJ4dXfwICveUfaX+h+eLwrxezTPL/UYhI0+32kK+vBlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee9IGk5emo+uBw3wyBp/cnsODjfpxM9zdY6GsmDDlRA=;
 b=iaN1YqF7GC/rdNAkJkjXfaHOMY1Fx7EDUXvtQaz4zFJlJwiJoYDbdlY3ARsgB/tht8TWp2sj+5U/PZSWcwUhGNHKhDCrKN3QfODftBcpMOKyyagwaKxOJrQpu/uMmSNA0TJPUbi9iDN8HdaNaBViMngfTANddTfNmHVtike/adk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MN2PR10MB4319.namprd10.prod.outlook.com
 (2603:10b6:208:1d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 19:10:07 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::a8ed:4de9:679e:9d36]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::a8ed:4de9:679e:9d36%4]) with mapi id 15.20.5769.016; Tue, 1 Nov 2022
 19:10:07 +0000
Date:   Tue, 1 Nov 2022 12:09:59 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Barebox / Kernel Omap ECC inconsistency?
Message-ID: <Y2FvB5D0K4MBii8N@COLIN-DESKTOP1.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: e906f42e-3c8b-4554-ef51-08dabc3cb0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhW2tSDw6kVHEvUsXItqSBE/0xYKDhXigaHgEbAKlUSKENGC9wUfYx9YFlsvIzLQoDT37b8Lqk4bbnLEBZ3B4ANpOL3UTQRjkb/Df84WHy5uu50sAnr0Lar29F/Twm+0IWiPLcmcuYobjF9Gj2aGkE7qS/BiEgZbEJFe21N+9OBUwD0IrenBMcAg9/zPIjCwE+kj1ITDMr7H/6+RInl7OhGuScpIFr1zyDVcicAlQDUs6cSdpn/YekzRLF9iqM5cSOycC6u6P1eo/JwrPwYYZLQ55zmv49kvJ7b4XUE8ueJQBeG1PSS4Fjf2ROXPQMbjNmgYnwdWM6j4BGoi78+S/JcE5bo/o5FZ0aYAWb6UZTAT8zdLIyNrYhg6hW5lZV4r2e69pkmZgmGyiP0u13PRxZt+cCeQUJdSrM678slBwGE1Fb8/Zmaq1VxvpXG4FDAcJldX0V3I1Zj4x8yAlyzMnoHgEZ8ewxbTWag2OfG2JOfxlpqaMPCf3+vpnnTLJI8KTOj+2bjFBnTnTKZfLPFrR0zhZPB9x61rrI2VDso4Swl/ryuvJIAxKPxKv8IoD7BmODt8qlH1XweFGAg4fQxj3yHnqF5XoYSZ1ov9OAT9J1AGxXH/ZHftfrhegVSpNNYUsLJ84Nqwu7EU6k3U7rTDjSzIppJYVGyTK+Wmx2XAgWcfkv/GPRPnz5ZAzwolEt5wAWqC2nuBmHuk6IhWOOC9SpR2sIcncRQZhm4yJND5ZWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(396003)(366004)(376002)(136003)(346002)(451199015)(6486002)(966005)(478600001)(54906003)(66556008)(316002)(6666004)(66946007)(86362001)(66476007)(6506007)(4326008)(8676002)(26005)(2906002)(41300700001)(9686003)(6512007)(44832011)(186003)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EuxNI/sh9pOhgyZRTnE6m651p0qosFZ+YgUht5KMsHJqvO/kvjulH19L5RAX?=
 =?us-ascii?Q?PHEZ1IKDFUDF2PGeqe05x+b4ueJrydmZDiircehIAxXDo30GYKEzFI1Y764o?=
 =?us-ascii?Q?EFKDPJc/nBaJ4t3scrvajAXOTmKZJ3JiuBCsLqmkHFozvZBYxpNButLJszuW?=
 =?us-ascii?Q?X76+eP1oUM1UkwpZp8swzZhVF9OR3s6kSC2EYIBjZCv6iv2HZH1JMirWNVSH?=
 =?us-ascii?Q?CAEQ5p3k51D/odcSSDDslROPXFLKifm1cfLYVTYFW18rRv1+Xyy/EhgYLrRp?=
 =?us-ascii?Q?/TE3XQyZej1PCnA3q7Oe3sj+P2BEG0tsMDJIKG/FYkYTl9wcu0XoDf3upPFr?=
 =?us-ascii?Q?0VRO3zSpHrdRgOFmIU3T8vQdvIL0s80qfQ534n+4gxgD2JSFwT/tQzm5yiQA?=
 =?us-ascii?Q?okfz7ZKT5HE8mSDSxdkcx/LJJ3WDfKzsLIhYWB8vFkW3DyFgcbBftWwk5ZPK?=
 =?us-ascii?Q?oZ5auSCqPFbupQ7jBLPqkkxexzQQVYn+KuWfx+PXK8vGfuoncTPtKINQakeS?=
 =?us-ascii?Q?1CSmFbC9dzK9TiWB/tmOqQI6OZIdg1wmqWYiiq1nR8EF+zK4JGUrZE/umcgV?=
 =?us-ascii?Q?lwtQAKuep/iEcpce9cx/TXHBAIHOOwLG34KEZNU0cmFSMN0HfVz/3lyxFjdb?=
 =?us-ascii?Q?Gcx9BUxFkKbYdxndIREM1AdhsLWQGWs3jlNLgqbrsN2rsJFtgMvpaVrKmf7b?=
 =?us-ascii?Q?YHfmwadflY28KFwZBOKfiRbpl0pcHTjbCfwgzLpeucWjFu/O7T2Q9FmZlyh+?=
 =?us-ascii?Q?74y5gyGoPJexqbbn16zppW3gKWr1wTQHRMEw3l04oBTVpuIuFsXIw3aX4BJy?=
 =?us-ascii?Q?XT7d4fjWhkMZOAvK2BbIQeT5pPNGwmrteRkzC0zc8GH/v37ZmJrjlqfUpdgx?=
 =?us-ascii?Q?oqwp/3zX8HZd4hBFlsLf8Zv2JruAJRDliNT7XTrHzYENYGqR5rg9mldlRQ/j?=
 =?us-ascii?Q?RfIvPwTIRHx0CwC9rcB8yeOLH7iAW83Ku4jUxL6hx+zTY1AFLgpYCyHe3vBr?=
 =?us-ascii?Q?DanwMQnLIcaPVJR7ZceSJ1XdbyTzQWlwMGzspZ0EOFkl2QoBaMrNPLkmFoX4?=
 =?us-ascii?Q?cWlMUWbQs/+ixuMGEGcOU1x1HX4gDfUecTwatMqRjq9pToDahatFxww3IgtF?=
 =?us-ascii?Q?h9G8g5kEO6C8OCz/LLTUOc4EMFjEnqyA1LsaRsS+I98o0iYamrFPuHSrRNZH?=
 =?us-ascii?Q?I6hNmDExfGEcsHShaKo+Ep+0B/mUShXGJUMerVHH7gJbVY896BoHXyM6zGzu?=
 =?us-ascii?Q?a9iaGekvD9JEKkQIe8+Nb489jAs8dGgLa39UxzwOzFKViUoe9je108hg/gOh?=
 =?us-ascii?Q?NAKcdHGoUVdi0mUtZvijUzHk/9H7tF9F6fYqcF+4ZuyxR1O6XBqXSfKvpd91?=
 =?us-ascii?Q?OwlXw0p0Ti6tmynSAAb+dXNv29vDUGWN/kz3XnRAijdLA7hWSIFmW8Uq9nTp?=
 =?us-ascii?Q?fZYm6VbmaNIuC+NuMvSmYwugODJWJ5Z0b7NTu9XyN6RYG9+Ijt1rlcYBVWdl?=
 =?us-ascii?Q?yLVRoEZNL+X7Uj8ZngRBJYwR2LVstDPjZxcloSC9UNmPFPtG4KBOmT8L1LIy?=
 =?us-ascii?Q?cGshu75XawXvHGTRRnQNii8Ay2FHS33SjdwBjzPxk10sRLSn98QVxjTEv9AN?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e906f42e-3c8b-4554-ef51-08dabc3cb0b8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:10:07.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw/6wk+hJXChy0DrqlJEScc/1Er7jk4YJu4obTivTC/0KofmJzTCNw5i2yaiKlpnW9JSvX1zoSYOaGmx0qZRnFpMgQSLsuROXJB2+KyDrHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to revive a product that runs on a Phytec OMAP 4460 SOM. I
submitted a .dts RFC a month or so ago, and plan to perform the
suggestions and resubmit, but I'm up against one main hurdle that seems
to be related to flash OOB/ECC. (get_maintainers on
drivers/mtd/nand/raw/omap2.c is how I got this email list)

Barebox has "native" support for the Phytec SOM:
https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/phytec-phycore-omap4460

It seems like Barebox is writing and expecting ECC bits to start at an
offset of 12 bytes, while the kernel (and Barebox comments suggest) the
ECC bytes should start at 2. I'm seeing this with
`nanddump -n -o -l 0x41000 -f mtdxnanddump /dev/mtdx`

Barebox created partition with UBI (mtd3)
...
00000800  ff ff ff ff ff ff ff ff  ff ff ff ff 56 49 fd 17
00000810  b2 25 60 1a 42 1d eb 56  5d ff ff ff ff ff ff ff
...

Kernel created partition with UBI (mtd4)
...
00000800  ff ff 07 73 04 ac 57 6b  9b 1f 92 49 ab e0 b9 ff
00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
...


My question: 

Am I right to assume this is an issue in Barebox? Perhaps this is just a
bug that has been fairly dormant for 15 years. If that is the case, I
assume there's probably no hope in getting this mainlined, and "native"
barebox support is just a ruse.

If that isn't the case, is there a hidden "shift OOB by 10" config
option that I'm missing? Or am I interpreting this data incorrectly?


Any suggestions would be greatly appreciated.

Thanks,

Colin Foster
