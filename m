Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8C6EE4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjDYP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:26:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6FA5F5;
        Tue, 25 Apr 2023 08:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abyR0C0RYPnsPJG2SLrUNFkme6qxpZsr/eMNndBPbZ2F/nooOB7mHtVP6rPZVg5mF+df57qNjkBMtExo34WqBl9T+yHF8JfsRuG1dOUZplUHB847lGVHH0maTr4v+S6Fra1qmJbKAlqyCQoQm1gCV1ZOWfzqYpiJlHEkG4aNZOO3hv20KfdGEx189XwF8IPBbHitNQF8v6wEs6+DZ362uMKSS75uan70RdE1XTXVaHVpm5jndgTHME3la9PG2OfRnuc7TzU/Uq45pbMPlSKZbX8lW2EVcAoNROaQHq9KJoFqLd80jWB63wcDJPykQ2jfaY6ozXFFXzJOFnfHdD6Gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJLh+kKNMvKhdnlSAme4gsxPK4oxkY3OO+sWTCH7NsE=;
 b=I1INucdXVoWTRTwor6SBUGktFdcURw+4w+h/5ceMCpzasCNuMX9KkE1h+A3vWQpqqqvSJ35oEMPlgSfaCvpEXRzWhCJg97Owl7s5fmGWb1GsTiJufeeCrH3OEXHfRWU1XzR5of58bdhqkg0BhSbCptM6KjmEf8yC/kxVZASp3yFo1JeeV6dbrw+c9h6JncSBgi1zh1w84lkBvbkAoXbytmc6jvz2ngYmixuhhF55AqX0vTLowOyDjFVtjik7MfFZfSjrs/sZaoe5m95Y2TmAfqPruKt0cqeBmTOL+0YP1zPgaQ4OgTdnbstiRvYiZk63yZZFusNAuWRw5HGdGkKb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SG2PR06MB5154.apcprd06.prod.outlook.com (2603:1096:4:1cd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.29; Tue, 25 Apr 2023 15:26:05 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::71f2:cae4:d8b8:8ea4%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 15:26:05 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [RFC RESEND 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Tue, 25 Apr 2023 23:21:32 +0800
Message-Id: <20230425152135.30745-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0342.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::8) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SG2PR06MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: e582b9ab-24c5-449a-6e6e-08db45a162e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4T6wmVM15ijfHza4Rq1KNJaHDMRVerJU9yZwW0/KigK4om8lNZDP3q68XZYtUoVaOv2tNAGBl+77m5wEutU9j48dysNMzbTWJSCx1R5GuA8uQlkaytrt0cneaGLRsf5B72L/KjxCjUT1PDhK2kRZc5VXOGwuyfWWlDcvBDeGusMvcBxo8GhigeIHt28sEALBJfJQv1IGoswdK+DK8SRZ4n7nEXCCp1zog3IFkjyD9y/vHDugjx5tSQi5/XgcaFHqbvBctilcmt/sJvALx/a031AMkVpuc5D6rG69Ggk3addChorQ0giNGEBfXd+UNwV5sOLZ008Alkg0uP5Bvn71Lj/3YtCQVINva7dfQqgp5OXeO8eZ1oZHCeJeoT9r/DV/92C128ywSVMCZ4caHEtHkgCTI1TDLePpcnUuZw9x+BaWobDH7Tf7CJvhRSHeMqNhUWvAl4pYLhT1cnE+aCvZZopuUoEn4YoBAxcnmlX2x55Zt5Jy/n5iXmB+EdBOTv17WGQVf2GlpEWF7ET71Ek81wyeEeRt2c454gwxaT5EZJjmngN9eacfLoC0aiAi+vx+/87yLG92uGYLZoJ10y4zrEx1khUZ7yQ0zRs3AT/P06E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39830400003)(396003)(451199021)(2616005)(83380400001)(2906002)(5660300002)(38350700002)(8676002)(186003)(1076003)(26005)(6506007)(6512007)(8936002)(38100700002)(107886003)(41300700001)(66946007)(86362001)(6486002)(36756003)(52116002)(6666004)(478600001)(4326008)(66556008)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ad+dqtQDigWqQrN2hZBXn+wxUA9ufs4wn2kzzI9Uy0+aexlKwUuJtYJXd0V2?=
 =?us-ascii?Q?iZd8lnH1uwIBMijLIKGU9iEsIukwlvuTdjz2DaAXjx7R7LzRzbl85Uz2UvOo?=
 =?us-ascii?Q?WeW77YaEp3rq+/2ZD1T6jCIVx81l2TtwuF+tc8sKiOGdvwm6sDOlqksYILzU?=
 =?us-ascii?Q?CxhHrXx3BrMgj5F4DhxjuTil2+6+oXO64IEZwN5+Au+wdUxMIEctckIar7LF?=
 =?us-ascii?Q?5wSjM9iGumGAJMExYuXkKE8CMWbXUDqzdtzMa3+eJfQAe0LQIwaT2Jwt8P/u?=
 =?us-ascii?Q?I58iazsQLhiOPZrr0Kkb35Nc7XdV24V17/SRnBJgsIrE0rQRcxIXnNC9ug3y?=
 =?us-ascii?Q?/CCo7U3Nf/3wDXP4MPOOh4JmNQThe/4ipm1PqzovnIie3U62rm9m+yAQ9HY9?=
 =?us-ascii?Q?KPP8upt1CTU00yhiJj2OE3WzcK1p4P6YF70DOtfTeaw2c94SrhsSIp46BtJq?=
 =?us-ascii?Q?zXmvoAu9Mh/lHOchYighLZdvElo94DcdHfDgXpxosjDs7F//yqEU04PMpxi9?=
 =?us-ascii?Q?qYQJF9EFrOOloqW54vzgVlZ3YFJrL+k9eeBzmBmUyFqBRWfBFL8wol1sFPEY?=
 =?us-ascii?Q?bG7PkrBM8pQ0+v1q4WBQ/jDDmkUuRc6nbqejD6RzzDGwOtMQbdjuMw8maKN7?=
 =?us-ascii?Q?Ojr36jMf1v3RfSTdbAYyzlWfYiAfDLbGSVf9u1jrHP8BPCtO0UD+dCp36seD?=
 =?us-ascii?Q?czOp9rRhJHkEkUVKHEnSYFJ1MORm+/PrhwHEGvU23m9mU7cmLOsOaZ3Rpyg7?=
 =?us-ascii?Q?cUnxfWWU7DQh+k014vaPiaFqqBySig7sOlJIJSvzAqrLv1ZkxTr+6V043fdH?=
 =?us-ascii?Q?OngtP3RSaxrIGTLv4warRL21T96ZpsPVrMcElNkG9wn4MoUebeMmb88tURKA?=
 =?us-ascii?Q?sFZP+Vxpmd7aMKcvv8OlI5BcZRShnw6ZrlrItANAMY44pEUoFb6CRIZ4KWum?=
 =?us-ascii?Q?JYOEmfHCtjbM90YK2XLo8/W6hTb16rtoXqQVVamOxph+POxRncs6cOWPwgj8?=
 =?us-ascii?Q?K31wejTm7OHadErxDoB/bbX4HjBg/cyztxXcT2hQDv2JR5mlicVwg7/MQvL2?=
 =?us-ascii?Q?B2uGhSp/uuyarSw+qyVch77fPvGWD0EaSGcRfrNORHiUUgIFPg87vEdND+0j?=
 =?us-ascii?Q?vmpseMXrmFVuLafsOj+zsOsdVm5KxJ3+3+oWnG7jj3TeG90dUmFubqr6wrkT?=
 =?us-ascii?Q?oe1QQqj2W2KO35sKTkRAvu6MdBrQoz9xRF9ZC1L77NVh1v3Po9W5lAtZJR1B?=
 =?us-ascii?Q?gnPgu2S5sfeNEDPYT3vMe6lTOsi6VJD9IcOA9qT4Au3wQD1aFREygSmO9aDW?=
 =?us-ascii?Q?k+xouQr3kUn1UGoiWcaRchWCN4zoEVGnPaUoDEK+/T8e7hJQq9yQhjDBFun9?=
 =?us-ascii?Q?kClcgXzH8kg8RbRKPC0B47H5QB6zAwx5NQjRV4S2YSy1S+AUCnUw2bwRmB8Y?=
 =?us-ascii?Q?YUNtTO9qiZxCLBqnLs3IVmhSxFKiw7g4vP+H/d0E++IAOwNbmxRcZy6F5CoA?=
 =?us-ascii?Q?gwipa6OT6mstP79n3Y+MyEvgF5E1EnvBl5v6oMeuaoLdZFlkAQrsjxb16q0y?=
 =?us-ascii?Q?ehn1OrsKYM5LBXEpjKIGFKplSaDHxbr6PLjChW8vf0Kdhp5msynJN62E07yu?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e582b9ab-24c5-449a-6e6e-08db45a162e0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:26:05.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faixb5kKd9waG6KPH7hN6XBAWzdNMuntkAHwMNlY/Ujvj9sdXZeD4jkZ3ua+UHD00ccSB9IlEt4cZl/Lz/5yA6EGnjvwWfecDHVAosLJpIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <https://up-board.org/> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

This is the RFC PATCH resend and fixed some of the review issues from 
Andy Shevchenko, Lee Jones reviewed on 2022/12/08.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   79 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  527 ++++++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1281 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   61 ++
 10 files changed, 1987 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

