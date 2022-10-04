Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED85F3B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJDCks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDCko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:40:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76190205DE;
        Mon,  3 Oct 2022 19:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHe7pGqofZlO9QaKg8iP3Tlk7od9tLFypft2ZM/lnh1e78q2FtvHgoxkl0fI6JR7ly4ixxjmyeqnhRautY9WMO/GucNbTxxQVd7pz4FP8mjuiWXOSGrzRUoz+uCAsi25xx1s0UTDwZ7A3fhIplmYrU8eoW9nbatNhOm8MmlO653FViYxDFlQKT0K0mx2H013jhjTOIHB2PAg73v0IsLsffUeyMveHASdrH7iopoqnwnYNJreprOAIL1gp1Lf5rSiBPjZeoVajKFMwcQkZ7xUBX+r0LKQmOP3nndIJbESup41tGw3PZnI9p8OUfZaP5Fx5JdmPGSLn6RPi2SLAX5fTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCT+LscCuj3wVlkUtuEJf2sd8P5iKQQffnWstdmoYm4=;
 b=MfY+00TtW2lTsyJ8wuNQyeJaGXZQmxvyBGD2D0CaN4DEg2pRFk4YT8SODvF+u7+Bx80j+XaZvizh8bL+YZ77THP9k3YCHZUDBJ4mcA77YGhtGGVkwdR8LDZYxvPgwUt243Z1EmaRWgDEpCyXULcViLaAOZ7jk/P/ji7xN/RZifScLLj5gLhNdb3tO8NUfnR19e+7kYmdIGiphc+svD4GHa/PZFT5PdhPk1dDANS3AQHV+f0b/AKS1aH0lBq8AH/js2TKVkdIONbh/oe9KIzw4LAM0UAM2irnmuJp07nE8jhZ6dEmNDljIoWHCfij7AmOfD93M8S2AHQ4lJrQaKZQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCT+LscCuj3wVlkUtuEJf2sd8P5iKQQffnWstdmoYm4=;
 b=aWncP1IyZbQ0V9EQnhdwHGounTrvOLXzk6tIDrKoGfdIxws26Z5y/4FLoq0Lo0xTQkUGRProEpUHh8u2u2jH/YvWuzqNRFuN6KtDbsdOUJ4fBaWBZ19FG5YpMorCenHSXxX+2EV05ZYSTEvKzGPRVUbHa94YvZDhCpH6eS2gAHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY8PR10MB6802.namprd10.prod.outlook.com
 (2603:10b6:930:99::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 02:40:36 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f%7]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 02:40:36 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFC v1 0/1] add support for Phytec PCM-049 and PCM-959
Date:   Mon,  3 Oct 2022 19:40:11 -0700
Message-Id: <20221004024012.1386218-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c0ded8-e4b1-429b-c9cb-08daa5b1d0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+wvhCLvF1yQRpVAIgN7LRQ1dmisWGCsAT49cKl3TPWbN7jPsPlpl53xG7K3duJpe26ddYrRaYxFcjINviEsw8BM10kOSiHvl/ZM8EfdcNxRl7+zIve32nlxX3nLh0zat1Df8Vthq3U4Z9TrfwofKiYZzevjeDgTdYgbpAvv5AZcpwLX2aZwmDKqaTxq0r+v79fVW0vQLTPMYDX9bhvl8R+nMe5xcJlTDOXwtWQ62O79tGVwb4ZQIgKRdMiAms5SvjTygM8MltdOC1AXzC/TJ8orgUuqHPlnfZlXCbxvZv4xrhJt5P0TasUpIlUdYD/T8TKIczTP6dwOXv6LRwQX2U6u++GQ74koAWgtroJ6e3dWLlS7Wrww4PBPBhE8fhKYTCtdvmvoIk3xJlzgdTpDIZYP+X5YKSVUNRHJnMnpTUucpsmWun6WTx88zLcwxHOBzk/Gg/vgy2EdH5MNNGz5nQmguVVgXTaPuB7cbXPggAOoEbXVuL9Is3OsoQBAIeM2f+1ws0ioRvVMcwIRWapG+GlfvOWxWywczitSH3gX4v/GvXmNzJsKDU1CiAJm6Z4r71V/82WwABTtELA877Q9eq5p0ZPi691aL5HJU0fqKPJ4GTW/BwyYpM5JF3pv1WFDBUWd0mUzFk8KuyvsQfTw68fDaTgCsafA5OH6OvMJ8NsAeQiGreuXBL7ef/IsidMjC/56//dWSy2fPesYrmJuny0rELFkM50DqzaeL5MkclVTpGjddN0omfW48i4hxzohtr+skXa8ZI6f1VlTwzc4H/AXXL/7ToFL8eLHjg5jOiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(366004)(39840400004)(451199015)(66899015)(2906002)(316002)(5660300002)(44832011)(66946007)(8676002)(66476007)(66556008)(4326008)(7416002)(86362001)(6666004)(54906003)(966005)(6486002)(8936002)(36756003)(41300700001)(6506007)(478600001)(2616005)(52116002)(26005)(6512007)(186003)(1076003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pK9q9GVGbJ21gsDzJNcHPCwg1aQVGMRGQr4XNqqq1DYILMjIoyuLsNZVMD8?=
 =?us-ascii?Q?f5iTufRsN3fM32ewaeDKJ+rgum7CWxX3gp1Bbc2ZStgs/MIgIfnqn4lemr6Y?=
 =?us-ascii?Q?G34/XT2bdKeIm+KoC0eBPJIr1s3FdzOdRVb7SSueK7QXgnlQ8+iELeKANT+Q?=
 =?us-ascii?Q?LbDoyYKTsvh0M5YV0VGHQyXTpYluTP+F6g+Es1+UaUI6VrFmy9z5xCAUVbcb?=
 =?us-ascii?Q?DkqpfVzqzPM2kqgwfOcrfpGmL/WWMvnYKFZ3IcCqsKxTKphO6b15x+ZUvOLN?=
 =?us-ascii?Q?NBriid6eB9FPCmE9jB0R5duxVJWUAMzOw6/Ys/ghRPdzv2X01436CJObFENm?=
 =?us-ascii?Q?dRd9P5m6Cgf53Rl3zJayfPu0z2J3PpczLMwKIbly2NlHQNJP9M4opqDCI55K?=
 =?us-ascii?Q?INAQBRS3Yn3BEWBKvU11j/AOU/r7b39zG8AYME0oacY3jO5kq8n9zRjqXupx?=
 =?us-ascii?Q?xH+K3SlhernONcyqOXkwohmK3ns8XgE63s4bwqCKznO4Jg5pnUFBIt0IFYhC?=
 =?us-ascii?Q?ViUsLVv91oYIhtgIbuFmX+miWFh1sXf+3LmqF/TMAlDEB52uO6kVlNAfgZoB?=
 =?us-ascii?Q?zPYCXh1rv2+OrDOhn173EYxWcfETZVCSZIH8BHspXb8HoAYUcpwVW/Z7IF/V?=
 =?us-ascii?Q?VXRM9DfExV7FKGFW68JAxR9f9rK2aPtkRM2hfPS5XQ7Mr2YsGwNgRd0TYDYq?=
 =?us-ascii?Q?TeKqJqj1r2rsEm5KJzHjCdAi6Wg8wIqftgDPHqTZNjumYh0NwgGHY6UK9ymw?=
 =?us-ascii?Q?RufMoycIYT31nNfqeNy6aZZTp/STszynfXIZsilF6eglT3MUT9bkqyN2EqBi?=
 =?us-ascii?Q?8E4phTFS2/rx4G5+RkGHQNbRmwGF3uNffnNpMbbEcaw1IUWvdKvcbwv8cHwD?=
 =?us-ascii?Q?wnTAXHRNu3ldlkiNJJqxITbiJfYtou+ITHA/niCvJd4RkGJ8y46Y80tFquE5?=
 =?us-ascii?Q?hPWb/LnWPc9Xy43He0oR2ZwsjCs6nAERN/H6qZ2MYLOn/0rlI8/hil7Ysp+v?=
 =?us-ascii?Q?HKsk8Chw33wuWu2jJQl9CgWxXvyB5SwNxVGJVSG2Dg7ZQaO8/Fv6kqzOmYbD?=
 =?us-ascii?Q?4ELUJeQ0I2Puqn1BnnD9OcRS1LzrBjSp5iJVc6w2a4Umq0cWgWpQVvsjWHPv?=
 =?us-ascii?Q?FvEg+4/bzfcgjmGRbavjxOcr4ZFMWrp4A1ytK+RXQQtMGAstDVKPn4MYGgJk?=
 =?us-ascii?Q?pYpGVYPXGPd85xk9ZFbM81KzyyRSOQd0GXugyML84le+DWPCVOV1uwOBqt/g?=
 =?us-ascii?Q?ELS02X0vVvqNoC8IpxBR4F0BBKBaI5qtejSTjgFtVZcv8agtxNGAMuaXDuK2?=
 =?us-ascii?Q?c2Gc2rXUvbvoHdnId0C3F519bH8Nc6e0K0yV3LbEd4cb+Jgv37nTlb/olufG?=
 =?us-ascii?Q?3Ig+UcCBwhKmxlu9zoULbadOz3EivQMtY/RKKnNpi8j8oQLz2FdyFuv06bvs?=
 =?us-ascii?Q?5JBHil00XqWXG7i/Ig9Vb3Ik44tGJP/Z0NOm5nsz4q/q2ZY2uF9sXI7iWJsQ?=
 =?us-ascii?Q?jqPos/bBwcz3kar8FJjVP0v4D1y1iBxC9VWfpezjfgm7X1oVeYigVB0ZymSi?=
 =?us-ascii?Q?5QEO+LRIIXUC1VjG/eQgcLE/Fe/YxIgrP6XkDUWxtOAfVZwdcvL7BEYEGB5U?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c0ded8-e4b1-429b-c9cb-08daa5b1d0db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:40:36.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wWEoYXTEF2k7sxRDdF8JcK6Y+4kb8RchgZVb9CLm4czlzHJSRD9DbuNJuPv92Bw3iser9FAUtENaD5vEu/z+03gLaz0MpgmyslioWi96ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As should be clear for the title and patch title, this is adding initial
support for the OMAP 4460 SOM and dev kit for Phytec's PCM959 evaluation
kit.

The PCM049 is a legacy SOM offered by Phytec:
https://www.phytec.com/legacy-soms/
There was a vendor BSP offered by Phytec, but that never entered the
Device Tree era. This patch is meant to change that.

This devicetree boots into a stable state from mainline Barebox, where
the devices are supported. I used the Pandaboard as my Buildroot
template to make a bootable SD card. MDEV loads all modules. I'm doing
verification with omap2plus_defconfig.


I'm submitting this as an RFC for two reasons. First, because we're now
in the 6.1 window, but second because there are some uncertainties that
came up while upgrading everything. Particularly around GPMC.

As far as I can tell, the flash and ethernet both work as expected. The
timings from omap-gpmc-smsc9221.dtsi are what is needed (even though
they don't match Barebox). I also used the timings from omap3-ldp.dts as
my guide for the flash timings, as it seemed to be the only OMAP2+ GPMC
device that has Micron NAND.

The main difference that I came across was NAND Flash ECC settings.
Initially I could run `dd if=/dev/mtd0 of=foo count=1` and read the
flash, but see ECC errors. It wasn't until I added
ti,elm-id = <&elm>;
that I saw these errors go away. Seemingly none of this code existed at
the time of the last vendor BSP update (3.4.41) so I'm hopeful that this
is correct - or at least not a "red flag, you're doing it completely
wrong and your flash is going to corrupt itself tomorrow" scenario.



Colin Foster (1):
  arm: dts: omap4: pcm959: add initial support for phytec pcm959

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 352 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts  | 130 ++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

-- 
2.25.1

