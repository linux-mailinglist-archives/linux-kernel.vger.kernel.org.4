Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEF70236A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjEOFo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEOFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:44:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C1110E3;
        Sun, 14 May 2023 22:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF1nAn2S+gyVkcJji9ydbsQjP+70iBiZGFQcw7kRXuNglepdaQe6MJTYgxaW0rePWRSc9lOTksDf4xdS3meqW8sqfW72hKMmctqUAQEM9Aki5biWMWbzlHhqOfY8E1lAyW7xXzN97DiL/SYhMF0DgP9uZ/JEpt/nNug436r18R3mS+NCc/KEtwSBSn6oU3TVke1CJRoCH3h0wMgKd/sgy4IfnmszdR875LIxLwjUNTpMEWAD8ePdDdZ3uZouL/jA8GzpEAUcqboOFDiT4sofxhYcjV/vrpZSczudPANJr+uuoz47jT+bAtg7LRwiMElsLth7K2VFPl5ayuADSncfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o7tmJHmmFhvUG70KdMYT50HyZV2hyvHQ944xzvH7SA=;
 b=ZTv/PfOr9Fj1ppFY5W19khBj7fDlXlYIa0AE6VvstXQ/TJR24fY5g1YvBM/00C/MoD7NgVyHBmnBsPiGhqfz80otsPV6g3opwFGH6u8OsHTkU0qWYGQU5vaMeBzBOZEIvImRjHbrnGxVvJU6gm8A4KG/1RjunrLrHspuQ71FS9bnIZvwWafzM37IIiQpW75jGYIVRE2EAfDdjX/fQGC39pjsWzX/llLMHOE/1PwYpQ8iF9r/HzgdwUrw+HeAYHufQeWrLB78Za1+osdli4oJmn5/ZrBT+me1a9+FyeocgBnmteenKp/qNRQdw8BjDW4G2QI7F5YrThoSWTssoQxuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o7tmJHmmFhvUG70KdMYT50HyZV2hyvHQ944xzvH7SA=;
 b=iKBmS3RP4ZNl345o2PhLIH9e088vo+BHK8hSij8q9y8+Zr3uPbw9sLv4U9noTqpY2BpN7K06V94rctAosbQ1+dYHpNHeIWeyq045uz3IBsrwW+ozMswqfD+dKin0G3jpd7sangnlRHfrie0H7xz32GJjlw4cw57ACTljg5n6ZiaeIsRPsHo5Fqae6hUwOboUj9e7AXtYiDfoi8QPvggqqrbOXAyv77DN1rCCJO1cAhqSQfaaQqrVfQ1Fb+K3B7e1g/FixStTwlH5iZdHAYNEWVfC2cEmnTePvx4bOENlAby277CCKqEJQgI14TL+Ztb6+kOi4HygCsdzf4sw3zRVGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6571.apcprd06.prod.outlook.com (2603:1096:101:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 05:44:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 05:44:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 0/3] Add T-HEAD th1520 soc clock support
Date:   Mon, 15 May 2023 13:43:58 +0800
Message-Id: <20230515054402.27633-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677b084-436f-446c-61cc-08db5507693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyCtES4w0Eu/7QnIiTHfpYXn47HDzoy+1NFmFaaoZuHtgbSsElk1YlKfFJRqmX1ZCQ0rycMPmPkwm3lh+I5DMmpscw15XJVi4IvQJ9Ln0tDUbj/9502RBb9RfiiX8+64xoJkCCQO/LmIvA4ZhijvDUzur/wN5CCspTp39diJ8Vl5EaWBwaut4t6isNucFDRqxhZszY87gmwah8UB6P8onAi0wL8ockRaMvEkRNnROpLOvTOY5yvw6yDxPR92kyGDtzKQblnRnlcUc5sSCkGabg+uQ+nCW++N7z6ugy3F0JdK2OpOoqrbAMBOwIQcudyKFXCWulJ0d68/TQxPRIO7SBobHWuk4XAxQIubOiE47PpWeBkm7CJiCg9ESsec6kc+7jCPBRzhQscRfkAh2Gq7ehfCnL4j/m0fBtpXrx/MKiZJMt52QwOTpmsSbCYMczXpKR6Yr7zZEK1C6eAKrcRlWG8g85mvUzhrs+Z2QhsbHDCuNDd+UDxooEUuZTAxxCd6nPh/8Gi27QTNnbs2VMC0CqX6bu8pIhJ/CWj/uWa4dQGbrfI/wB8P0/4s2t5i/h8DyWP4zidhtTab8Dt2cMlIeTi0q4VEGKs29IHxV/kwSUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(966005)(52116002)(66556008)(66946007)(66476007)(4326008)(478600001)(6486002)(86362001)(316002)(36756003)(83380400001)(6512007)(26005)(107886003)(1076003)(186003)(2616005)(6506007)(41300700001)(8936002)(8676002)(5660300002)(6666004)(2906002)(4744005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TukjampMehJVO8Mj39BeT3+0El/SS4pkth5S2svqkg6fUIESVbEAu/iPmvsw?=
 =?us-ascii?Q?0LYK3/lTtt0UzkepOnGkoRVP/gGjra3YLMBbVrv1R9eqvcn8YyQOI9MNr4h0?=
 =?us-ascii?Q?6FUJnjxKEafFxBcArw28z8KdfTj878JdvxlIjb+RhvTqfaAT3ByLj5fKi6Zc?=
 =?us-ascii?Q?cr/BliHm5HDEVZxCETMBis6ZmMNtIZ2YaLeNMXiRHgz3GS4MHnDwW/uYRVCC?=
 =?us-ascii?Q?22xpL0cVIQa0AyEsDMp5pHoutYxeZ1Gc3ZbAUnY7CIM+4jrS0wLLOX+eaQeu?=
 =?us-ascii?Q?GZ2CWVhPFlCpuOPI4xLn/tJW0lYw7YupwsbRuwmkNB5TgTjtE8kNN5UFnwh2?=
 =?us-ascii?Q?Y6P7kPS83PmMQ/wuY/YZojjXBwqUQB6z0L+MDB9gtvzv3607YR/rNGWUb+Zn?=
 =?us-ascii?Q?d59i3KL0W/2+p5MVQUV/fU12h5w7beYz3rSCE0kPfdmlri/vJVfuOWFhvGkC?=
 =?us-ascii?Q?hj45mJFA93ot5cL3klzoONTqHszeMnK7x9kAb8VEkOxKNFDzhg5oS6j+zeU/?=
 =?us-ascii?Q?LScQhlcxgx5BkRyBMgifntLddzbFNf76JFWfgtRJhk82IRrtOhhtx3OU64/W?=
 =?us-ascii?Q?6p6/fp7m91Yi/R7egzlxRimRxoiY53sE9HURG7ntdpNzhlCizbaHTAquRVLn?=
 =?us-ascii?Q?90g7BO05PdexqWDiRvqkKltdpFz3XSeHn7RPAcsNMBRghpkPzSSgbwOMUuoV?=
 =?us-ascii?Q?zYYrWLTp5nFzmhlG4kDZWTXeVEVOoJzPxkDbrluxezib5NsQDGokXTty9D1+?=
 =?us-ascii?Q?vLYDt4bECs2Hy4Ltrw4TxxmmjCV3yhHarsItelovRrYLQzJXFXG/YWDfQFMl?=
 =?us-ascii?Q?qpdH9rhFu/OlGXiTSiYJNRug8IFcD9iaxf6DRJAq+raf1soYlm9FOygfgm5s?=
 =?us-ascii?Q?Hg/93wtyGN5mIp0lP/f00sCZVTBkjD8oqkMOC1QwGMo7atw+oLVzTOgp5OKf?=
 =?us-ascii?Q?ZkMWpyMa0Rn+eMM4pznu7BgM2dADCp0zZiDHSvvWjFDKYX328SzFinum17Ls?=
 =?us-ascii?Q?vpS5RApffMalejk00rOVXrAnRsLr1m9h+UQWgk3xwwaAHBkt2lqqN2ebcZK9?=
 =?us-ascii?Q?GJo54EsEfkYBSH4APh1oZln/l6uGmd1oyvV0DOOlwFlzb0XBhERoXIBgaP42?=
 =?us-ascii?Q?AwfzQgpNmgdOtCuaE6XyOcGA5Z6BwzyM8uruO+Usq+HMvPCqQDIGxoTloi7i?=
 =?us-ascii?Q?CU2d9cAR39i9VvC8V/aCPBeeIdtvl1IdFd5nTMcSgB/sP7PdmYE8jJTlcwjC?=
 =?us-ascii?Q?wxCD0ZWobG6tPOwblgEzd+qxgEv43M4SehlxlVeMF5WvHrXrzQskDRRQxbGp?=
 =?us-ascii?Q?OGbeg6wQxK4a0aMwg44BAxHm/XRqylIFya9yLq5hWTtBHCpGnjligfWs0pD7?=
 =?us-ascii?Q?Xt2US1JEhPB1VZSofk4NwpQiut572YvTlDKDaYGDRw9K5J5IX8GeJs/LaY4R?=
 =?us-ascii?Q?KXpd69ZiUjbRTjk/Ty+Fj9pbqSndPAy871VIcchgFfJ3dk0nX/ELH2dmYV8F?=
 =?us-ascii?Q?sK4aPFBtX4DecZZIxP0MwgvyLbOwU9PHhy0X+UO0Q/zAjx9X5WsvkxTcLTU8?=
 =?us-ascii?Q?bHMrX/FDif5xj8CO2eIGjkhLXwbUFtxr1CuK3xE6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677b084-436f-446c-61cc-08db5507693c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 05:44:12.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKJsUVty5jU185lkGPaQFUE/jwJXijTe/iCargHUYd42WF1iwYzBo8x9kYeWbEoAE098lb0DMhcxAb0URIlxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is planned to support th1520 soc from T-HEAD in Linux, which is the clock part.

BTW, we are already in the shell console, and some modules are already available.
This patchset depends on some of the patches in the link below:
https://www.spinics.net/lists/kernel/msg4780793.html

Yangtao Li (3):
  dt-bindings: clock: Add thead th1520 clock
  clk: thead: add support for the T-HEAD TH1520 CCU
  MAINTAINERS: update entry for T-HEAD RISC-V SoC

 .../bindings/clock/thead,th1520-ccu.yaml      |  60 ++
 MAINTAINERS                                   |   6 +-
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-th1520.c                      | 999 ++++++++++++++++++
 include/dt-bindings/clock/th1520-clock.h      |  92 ++
 6 files changed, 1163 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/thead,th1520-ccu.yaml
 create mode 100644 drivers/clk/clk-th1520.c
 create mode 100644 include/dt-bindings/clock/th1520-clock.h

-- 
2.39.0

