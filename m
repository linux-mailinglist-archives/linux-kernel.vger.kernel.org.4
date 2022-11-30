Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E148763D6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiK3NiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiK3NiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:07 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4427CC7;
        Wed, 30 Nov 2022 05:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHxVoatZw7PVqM1OkualR/FSjyz+wcVfCf2xqUGySZiqjnSn5TiTJrgoM940KZhZ0zwelB9WWUqOCVpTUB0/3QgrHsmlM9JXlhXz8u4IZj2IND8+Xj90y9wKZYcGgzvUrnSjNMBIHCzn+JKJzCoNBjqH2Wwn/C7BwwvIwIwfk1sI5ZU1cz0BIMKzQKozW0C3Cvw6sFdsQKYJSXN7G/XneM9T9Xbf2Hfnt/6FKvs/At8w+sLLJxfsgYwsYJ14oBCPzj2NO6A4Oyz1d0ELZt8eJ4C7wf9ZMObvOnzVTLZO6AbM358T0Ifck3lf1rUm0IT5e59IOkA8TDv0yfap9iWRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V00ZojqKGKV5lUPHyiivCPJtFg0c7Fpn2Oh53Dup+XI=;
 b=KbR6iwHG+FIYagtRTOt5OM8jRymUhHeh3N6KHEYnqhXN/R8inRQDRy1fGmcA3o8oX7kdGw3Ef3Gxs2fVi4Gjpsu2g/sXOHMDHKBLcGW2s5+Q+DhOoy3ZIeDpG34udSfZNaAKBoxo7+aMVw3vi4V/S34Vy5tQBfZ8dtv5Nk0WvnwA2rgzSGBCGIs6CIfza6RcmG1qyPcFQVBM5Wa4TJHFk9JzhpTmYtAnqPcBimsbzYXIjUSp/HSzbmVlWHydcN+cLcLv0eiEX5QVQQXT1oTu0qd7hvE9ZdZIabbAPMvmIUaszByLQgiqNzlgbiPipdS+rcFScc3rlYWtUzov4EKMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V00ZojqKGKV5lUPHyiivCPJtFg0c7Fpn2Oh53Dup+XI=;
 b=Fy6DROpSQw/5hzm9uNger6UuP9dfTBPqeNefC/ky3ty9TVWhYISEYwBbMn28BQSvO80vi5egCHowc/oMVpGzwqLjWbm6Pe76f7Oj+4vj2qVwaAGhEEWvUcfOsHAn/YRdC+fBhJyCMltarQ3V3FXe9dQBbSfLArJKKWnA9a8CWcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PR3P190MB0858.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 13:38:04 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 13:38:04 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 0/3] mmc: xenon: Fix 2G DMA limitation on AC5 SoC
Date:   Wed, 30 Nov 2022 15:37:44 +0200
Message-Id: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PR3P190MB0858:EE_
X-MS-Office365-Filtering-Correlation-Id: 953feae1-8304-4d2d-4ea5-08dad2d81b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDvIlLTRQmrVqZMp13yfCAqQHvc5kUe0vNiTCbeZGWiXnHu86pNeGmlgJN11G0Fqw5MC/pnL8tZ17ge0CX0dl4EulwUeHpTwLFOXoL+kcuoOFIzS0iGvqf/vDdL468it5kzQIWPCMM8xaz4eqMTUVFiuwvoxFVh3SHAr4vJANEkA7789OQG/eofXSFoX9cVI+2HxMGTgJ2aetkMff2bxU7ItQrcjhX6Tgp5StnD9LbxFAIOXVruFFvlePxwDpfx2OIL2qsfhSQNr7q8iVPKIU8GPdcZD76+1zLKLaaB+VIZimeU/f3OJqPYKZLlhUmdQEROQ0YV/+rAceM1VNWaojlOM/wPKhbmR879DqdkGOU8w8HsH5LNfhNGJyosVmLpgxXwC0DKaozBsDQWNMXU4yEnb18RgNEyB/Yif6M8ImPWh7YjQmtpX4wqSkSLIa9RdrWwj79N7ARj4ONr25tuAt4suCfbUBwshYLPVMZKSYLQmp+zLCMMfdftq8nNjhAIOAYfsgH6SOC8cykvcS6juqVWHRLCvdQ/bC35uooDAXyPzQYsQ9OWKWr8ODlDmUhjMWy00Oo1mhYq+A30/xK3fSaKCJFbwhnQ/IMfEbnJW3lh+BNOUcD3I+YLd3Z3VqcZR5WFF4XFrrav/IsvBzsXJUWfFwxivmwYRwzohgVjrOpPlbrJbfWC7v4YPsKqoH3FY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39830400003)(376002)(136003)(346002)(451199015)(8936002)(110136005)(5660300002)(54906003)(186003)(36756003)(41300700001)(66476007)(4326008)(66556008)(316002)(8676002)(38100700002)(83380400001)(107886003)(6486002)(2616005)(6512007)(26005)(86362001)(478600001)(7416002)(66946007)(52116002)(6666004)(1076003)(38350700002)(6506007)(2906002)(44832011)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOuLbYl7whVGRIAVSP4m9IELH2dE8q8d0S8xiI3Jl9FGkXiZfWA3Izf7Yq0j?=
 =?us-ascii?Q?qMKDSARkBi/a6ELWiHcBv2iOw7J1XlP+BJpwDyuqrnIPmUt5diUE1RT3nFtq?=
 =?us-ascii?Q?Y92zEog40Xzh0ShFcwQxInksRUygZ/TR7MA7EqQ//XQ84N8TeOPfrZ1Okg8d?=
 =?us-ascii?Q?lxzQtjhSMOs+5x76EuKuz9BbwCRe/Aal82gWIQmbubiiJp/eOc1lt4sBvCGw?=
 =?us-ascii?Q?JSybguYvDVnI9A0xC+aSK9WWy3V7IJdMEmgHnc1AxjJS9Ud5z3LRwmUl+IOI?=
 =?us-ascii?Q?560eBwK5ziapIjWPGmd5qfL7eDu/E0sVpSc5UTUsr8XUDqAernJER9zptw5X?=
 =?us-ascii?Q?DPSqXina+KRHorVeA/Gl1PyMxMRue9cNlWRrwd6R7LzIIICPK2rGCh8yLWjd?=
 =?us-ascii?Q?seVYr+8droev2bCfQrCRBSF2GxJbRGoJiJXuNqJqWAYtT43qoFcpfHInLIyx?=
 =?us-ascii?Q?dHqdi6zjzFmPqfpTX+KZXfun+id9tKwU3B3tHTw4coZ//5BST5NFJ2qXddcL?=
 =?us-ascii?Q?mnUyQaMzvwX9AcIAmnLH+LBJjovEZsv+sfCDlRGETD/K4oQbm1cvUyM/7u80?=
 =?us-ascii?Q?Hz0GpLfKL057vXEQ4afgXPFimIP04+C5FP+IPNtaQa+QbtT342ZBwA+0ts3f?=
 =?us-ascii?Q?lltbWHmnNCmOoPOVl/eFelhtVfBA94xU+dTA/q1JRBKtn1W/UxHhTRqk561K?=
 =?us-ascii?Q?wf35cCjfBeJ0tSsjppdnb9Du5sdj7gzie0TzrF4woxMBVVnwNNJzfJ9fCLgE?=
 =?us-ascii?Q?TqAOgkJUS7ZoJkvwqxTExoL+a9EXRk8Dw57cil/kk//H2Q88Q91SK0EpNVLY?=
 =?us-ascii?Q?YIbIh0OqCmM5aV78meXWDANvAnDlBSI5YNNTHBXDKT7vDp6pRtJH5/C8hTZs?=
 =?us-ascii?Q?5XDQwB/EiyteD5/vm28CQoTfWHWxfSiJdKDK2AQlRGhFYGWc1q4zBAJ7ky8d?=
 =?us-ascii?Q?EGPfiuELbx2kOlxdhgG83+dmZ7o7VZMUb8vPbd1S63MZ/s/BPmIWzsgjapNd?=
 =?us-ascii?Q?ICGm8WqI/YeA3JO2wv1B+035zE9+tGMx3ykjrc0ox0I2X6VbQHahBnR0a9j4?=
 =?us-ascii?Q?jsdzZcMce4sthtm/GQA87nGn49KPXiWHrXgdsePdF+haoVjUHS0BU7eNLDJ0?=
 =?us-ascii?Q?/z648NueOw3hm7apq6YYeA4EBRuRD5zsmjHQflr6bcOAfiE+jY10Pi1XS/2f?=
 =?us-ascii?Q?DNaFYsYYwANFC8NvSgHygLTKfTmzCT6gtxGy3pQciaFnIzd/QZT0nRnYhR7o?=
 =?us-ascii?Q?DKjjVLMrtplju2yaDOzG0tpSuHNoVjk0FPffKyh/18d27V+fJayVgt7JyHlA?=
 =?us-ascii?Q?7WFClrNAuEotwESKqL4BRRanvX+rVOzD1YGGFzz6XZ5k2ZqSqMI98G3fOteA?=
 =?us-ascii?Q?zYzQEpxe95irdCwDANu/FJca7MpJ6Kvk5Xk5vPYXOAO2DyUWh2FCJ/B4R1Mk?=
 =?us-ascii?Q?fNZbfa5PQxBJQkdCfm9VNCvMpqc6oALpO/+YQPBdWZvkrwChBZ6qM54pOnHR?=
 =?us-ascii?Q?FMU7TGQ6wSy4XDNiaHZp8LDimcKfdLwPYt+rPyB5wtB8ibUEq4GHx/SkKzc6?=
 =?us-ascii?Q?hlC8Q1L/T6RIPqE2JZHvjQ8PbATXeOC04xgVGjxVfqRaungz1pnROA0CGHYJ?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 953feae1-8304-4d2d-4ea5-08dad2d81b38
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 13:38:03.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0yTl9mpZ/sXhMq5yzYjz1rG508Yo9gT2XMi10Jc75EIWX8rYYZv6d8BmpTFTUQGlvhz6hSB2pPmdAkmJ3mkIk8616XaLolW/V3y7dvUFdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation on AC5 SoC that mmc controller
can't have DMA access over 2G memory, so use SDMA with
a bounce buffer. Swiotlb can't help because on arm64 arch
it reserves memblock's at the end of the memory.

Additionally set mask to 34 bit since on AC5 SoC RAM starts
at 0x2_00000000.

Also add compatible string for AC5 SoC.

v2:
   #1 Add compatible string for dt-bindings

   #2 Use SDMA with a bounce buffer instead of PIO.

Vadym Kochan (3):
  dt-bindings: mmc: xenon: Add compatible string for AC5 SoC
  mmc: sdhci: Export sdhci_set_dma_mask to be used by the drivers
  mmc: xenon: Fix 2G limitation on AC5 SoC

 .../bindings/mmc/marvell,xenon-sdhci.yaml     |  1 +
 drivers/mmc/host/sdhci-xenon.c                | 38 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.h                |  3 +-
 drivers/mmc/host/sdhci.c                      |  2 +-
 drivers/mmc/host/sdhci.h                      |  2 +
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.25.1

