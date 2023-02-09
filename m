Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101AC68FD8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjBIC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBIC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:58:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3EB5FC5;
        Wed,  8 Feb 2023 18:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqvwgFteqTsrT7hjFlJEiH2aoKa1o3EoY/xH2AVnDLTOUs2DgtkNtdEdwdUKvET/uad0VBzSClto0AArd6Sh0hLR2/rUy6HkrBtJk/i1eJY6a/WT986UL74GKABZ/13LYb85q3Vy5fYuehZ92YVq8nzUcpvQ0HMdwRoSlsIjHuj8B2lGhucejC5CtISsXpi4M3Y3acgJhkpCLesCaK657gsnb/l15BBw8WZFR9D/b0n2PwSTyBBXczpUiki8he35Vq1iGQOreUs5MININK//GwIUq6hW55xW6zQ5/5z5uL/Uznsz4A1Nh7DZEZXm4qI8wvI8XrkepY2SUqGfQUVAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBpIFgA13eOlz18P+RWkeh6slWc4sJjwbtFMtWOwKG4=;
 b=Ok4NYeLo2dLEeh1oQFYHuk6TBWpgUi5LmesJROHHX3lbwciNfxy5E5Tuml6nE1BS2QMn8GEvOripm8i9VAItSSc97wd2smL6mDUNyxKl1yefBAEsnNqovFruv0CKjhzb9V7xsO6tgOPCFOpcXBNyViuLxtXzpwL4O+ZYffL3+bytskuLlvPwPHmIQ9TosCDHRUuLfnqvEmcZw17w8RT2TsjBh7N0/xaNEEC89wLMpSaEqyg8gORk+BgaCaI4IX8jD8nwUOq5XqD0uekuiGOwpNlLSH/L9gsMo/BhMeKouGFk6sukeOasWEzvTo8fHtdjwuSikQBF4T2XL4WnEf3ZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBpIFgA13eOlz18P+RWkeh6slWc4sJjwbtFMtWOwKG4=;
 b=dB0L059Hp5HxrO617fgpRi2iWtKjgqC7Rq6amlVCa2pNgJv6YXKP22SyTGJOySMJAnbwJ83l7V8XpCp8V4B5hGObIoEB+92Zgayx5pU10p7XMIBkXFOKNAth8ZY/0zLQyKJLijtRVm2F308IQewMkfRmlkR7R/WMv/7tI7dnrAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH2PR10MB4391.namprd10.prod.outlook.com
 (2603:10b6:610:7d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:55:39 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 02:55:38 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/2] add support for Phytec PCM-049 and PCM-959
Date:   Wed,  8 Feb 2023 18:55:23 -0800
Message-Id: <20230209025525.148872-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cedd749-7fab-4eb9-444b-08db0a491fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZhhB6deO2bqiddAyWDvGLhoQAhvsbyIi3JUI214vJ/b8H1yb5OhaUA4TIs7seIWQwseXiaTHxcCIJtRiUQclOqHauzSr5G7RWgIekN64CZ1tPydrHSysrO0k4xCrVII9rUpC9sWhM9+5xa5wMtodiZeBJ8qKo1T4oOufeyXleL/EzGk1XOEF5Tx2Pz2vQL57Se1FYeV23dJlL3BTgVhfBWsa7wosm2kpZ8LWgcOF17SMO2gA++/jhKa5o++UTkAiYBqYfxXtc50Cpf2TUXB4DW9vDxF+1trLwZnwguj52Vc9tQ/O3MG1qCw5Nyrp4hCsbqZac1SMrGoMZhTx48/GCWhOWeX0lz/ZhWNG3wxmqyS6R24CWXf9mlhNbSXdbZywcGPaRLHKfBxbbE0yf6QYjjYYOM4QPOhO+g9aMr4UOmmhCr/ICf0e99Yxzvh13iIdDz1IHN5AWIxGrLbXHPULxvwNZEOVlYe8kufQjA9vbnq9FiblTVM2u8gzYak1RHR4BrJGcMI9UG/E0qkpf5XQYKAjEy8ecWscrwW6BI+aJ3E5UzV5cOvisNq/Z47hlxPBaZB78ZYNTj1/7vjsgVBiimTnTYsjBiAA18a498c3EJvVxrPCU8CWJZg7Vq3Pks3JLWOX1H37Bjc6g3UzJ+F4Oxox7NpLZOF2LhxVPcMXLYM7dsGcGp2rnNKHNYRpfYd7EUEuAYFM+P6voAmUxFJDI36dQaXsgQrkkyic4Keo3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(396003)(346002)(376002)(136003)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(66899018)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(1076003)(6506007)(6512007)(6666004)(86362001)(478600001)(966005)(6486002)(5660300002)(52116002)(54906003)(83380400001)(7416002)(44832011)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?356gvC19D3Xn/ec4Tn00btJR81dNtnGHprTYhAIHALd6KuuGz9GIlwYyhVAv?=
 =?us-ascii?Q?UrO9V2QJwwxFdGSD6eTxrac84fehydc0jC1ehF5wtmOAJcDQT2DQPURNrCZW?=
 =?us-ascii?Q?1i+CAflVDdfaJXpKEYNErXNJcDhzQunUlHx6Hd0oufIzlDLfxuJrSAe+F8y7?=
 =?us-ascii?Q?Xx2PdAgXBkQbrHttCd1FhkCoYM3cnKfgJgD/f0G1XkEGEEGR8PwCxerjkveP?=
 =?us-ascii?Q?YWTNPp3PCy8T/Rg7NknrH2gfjr5qVJ+q+v7aa0COaeLymh5f4Tq+26UlnqJj?=
 =?us-ascii?Q?TMS2CpgDUzWvpK9ttf7U6rySNNc1FynzqupuzqNaBooo+M/wvyvqHf3kWSAN?=
 =?us-ascii?Q?KqYs1n+fbmwSkJlV5d89muzSNsQ0JjuVy4rmlXVYaxcEMEAteA6Lyr/u2Kxs?=
 =?us-ascii?Q?QqV2wx+MKxNql4ZxZ8c6YujgcXpiatdZin2JlICBV8YeI2kdotkp4nhVMkq8?=
 =?us-ascii?Q?DPrfrBm0YEEbqD6DruSkdEpXZmapgQl9eYkHfdRykWjDCOCDaqG2jArJBR6h?=
 =?us-ascii?Q?p8vAcZw5IqS7qpv8zLMCkmmC2wFVPGg0PLfDm3biBQ7SNzlPKbY4sg6UGmVm?=
 =?us-ascii?Q?jSDfpGGTa3N9HCoXwiBvYQpk0IIUxgukvuAzf85jqqVrPp0jh4fNZrUVxyJ2?=
 =?us-ascii?Q?sxZw8qhu36jpwGrriLoYSOvZ5ct189HHEcfuXPEp+Fi+w/RWAC0E0WjznYbj?=
 =?us-ascii?Q?ZbKLe0qeghTb0+dZnbPVNMTG5JGT8TcgafRkpl7LvHqCQzUzx17o3e71OPtP?=
 =?us-ascii?Q?hqyipiMGuueT0e3X7OuV9MQWHoEWNweclJ/9fMAGhr4klbN3Lgi87tU9/pH2?=
 =?us-ascii?Q?5322I26XWdQILVuVpAYA3U4UeYa8Q0P68sbmecjHEYZ30208WSCGOV6p00gq?=
 =?us-ascii?Q?DCdNtXbv4XrDhiyMum0M1rhckoQkzloljMXfM5v/P9V55xK2V8+Fd4WB+f0i?=
 =?us-ascii?Q?hL+AaGIuQjbgm5h8PFywadaRg1VsEA0g+/WjEPQDYL5yAQzBqfNYUcUvXRxp?=
 =?us-ascii?Q?gcTq/V/SBoa30S/ApgUq5jIh8rGYcz2wbEZqUblLdUF0MEjGJ/RJWXMN9GlO?=
 =?us-ascii?Q?5yOiCPSq3DBH4TLI9IozxNOk4qysjypTzkhDVT9FbYZTGzBGYzcoBV1bkWWA?=
 =?us-ascii?Q?d0MDs6NdFft7DfVe7Igalv6Cj2Gz/fIfQFO7lc7KkVpIu/zGqVjLDpFq4OAF?=
 =?us-ascii?Q?QGIHcGy8TzSRBvQ2HLvs8OMuz5V4LmHME9kxhCzbZzct1rS38QiMujj/FtTo?=
 =?us-ascii?Q?xqPpuoHSTA7zAngOKOPLWtrykBoQPwJ2TsNUm2a92A9Wu9df4x1BbUMMidEG?=
 =?us-ascii?Q?rrinwyQ/UQePfO+nGs95iUPfEBpeiUv0path9t0FG4ADu2yZYSxaDb1VD+sp?=
 =?us-ascii?Q?n9t3IQxj23X0TxtHv01t5ONGYlKboQYc1PzznZK3mO0KR0048bK23mVuTc98?=
 =?us-ascii?Q?nik5Ssr1sJfob4xVj/C5muAQmObzMuOCHdE8aj4dPyE8ntq8TdlC9BiouLJM?=
 =?us-ascii?Q?PzDRUUjPRyz8ZfekYOpcP05HP7wyLhHa2SmqynQHtbJikEELpX7sw+QDNCpr?=
 =?us-ascii?Q?MMU00w2u8qxUW0LaHK6ArHrAeHTZJoa7S+W47u6wj7D4M9FoGi/oi3r7V3t0?=
 =?us-ascii?Q?5sxu0/24Z9//CU8BUOTTdcE=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cedd749-7fab-4eb9-444b-08db0a491fb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 02:55:38.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV/lOyTwf9ijaEJgWJ02LY7WbxNUZhQmgAaiF6vEba6vMcAcyJXpnmwJV/VrJuWV5MFwb3XQCr29CuA1/Pf1ciWyJtpS7QOUl2dKuCBsTPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
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

My development bootloader has moved to U-Boot, but I have verified
Barebox works in the past. When booting from SD card, either bootloader
should work. When booting from Barebox, the NAND OOB layout is
incompatible between the bootloader and the kernel.

I haven't had any OOB / ECC errors in the NAND at all, which was my
main concern. Due to that, I'm submitting this as a patch instead of
an RFC. Hardware ECC correction seems to be fully functional.



v2->v3
    * Acked-by on patch 1
    * Code review changes (see patch 2 for details)
    * Fix intermittent NAND failures (patch 2)

v1->v2
    * Almost everything moved into the SOM (PCM-049) .dtsi. Only the
      LED chip is dev-board specific.
    * Fix pinmux associations (*pmx_core was applying *pmx_wkup
      entries... I'm surprised that didn't cause more issues)
    * Documentation added

    * Updates from review:
    *   Board compatible strings added
    *   Hyphen / underscore changes
    *   Remove unnecessary status="okay" entries
    *   Generic names used (regulator, led-1, etc.)


Colin Foster (2):
  dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
  arm: dts: omap4: pcm959: add initial support for phytec pcm959

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi   | 400 ++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts    |  48 +++
 4 files changed, 452 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

-- 
2.25.1

