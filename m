Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF96C6B76
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCWOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjCWOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:48:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C76DBE2;
        Thu, 23 Mar 2023 07:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyRHzyTFyguNzEbcBFDTu1FRrMp/UBZ3hlpOJgAV3jTBTy0dvDfWKSS7oe8e6s8VzOqL61OmgdsmgDZusc+b425jl8U0upvW74ZnYJaGs8J1JLJpA+If6Xy+5bUAoNSw0Pxkr8y65spbLncgcQcEM77ski3299nIKf+Q0ldIfnyzWX18GZuafzwaBKAklcx50ku879vvP+/twXzPaA5vBqMpfLwI0G5q/qMhBcpn47SXsusI3kZoKJYYl4qXqsGJnPXFG3dIxLr72LhdktPKaq5pCkEo4APRbT4KQelsnNBmV4Oa3JAptWlxyVqORSGjv47OsLX0cMMOAV7tXhM0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONxBXzYSKhJZx9Ho9Xid5B5uYxCM5h2uY3sKR0qXBuE=;
 b=d6/JxVVoztT4nm+YPPUorAVRnKd0XvHSbict7GDz2P/pkfd/LrWI+VD9Ae03xGuE+WAM1s6XnCzXGiN3yuxyp2SRk8nEGJJFl4Vs3buBTYQDhGXkzrdMd7oDvTWUxVCWscIPyyFMEqE3zpTpN7mTEP4hyis3YsGb3RDIvRiGcMEtmo1lOn+8KNPDFRYypwx3AnsIQsi8a8JrDMF33heBdZ1CyF80gNp2R9P+x7QDoJk4q4mT+foOLYmGOzjVewoz8/onuFp4kDPJoM61zfSPb5etTnYrfxuo0Rpc3JkjwFq+dqowsvuK7nhg5+zIm5z68+Coa9pJkwfeGDtRHlAuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONxBXzYSKhJZx9Ho9Xid5B5uYxCM5h2uY3sKR0qXBuE=;
 b=JqTCbQTEV2h1L/e8dVX/8Fnwr/I+OMVoy3CtiF7DVASoTO4InBm7xW2DcFc64Fjz4v1gQZsSnRK3C7zFBuQi84Z/aSnIi6vhDTBWvLMVicpMnkXQOS0cSMuq1mryfZiR1RJXoMUDGskrMUfErjD9Ejs5mXJEViK3UzZkZbuVewz8WNXSbzUdbj8c/WTrG7GyRD7OmRxDbl9SoTlZOazj23/1kbFmHR+zN6nGOODDpXK+pEkn4wSL9bcdlCbypbGoWwzz9i8fyKso74qP/VE+QiKhGRo1ajufyymDHRJc33scPLy0QDrux8HGybgqBhCijIunDz8RdW4BUrS2u9xqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 14:48:49 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:48:49 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v3 0/6] pinctrl: s32: driver improvements and generic struct use
Date:   Thu, 23 Mar 2023 22:48:27 +0800
Message-Id: <20230323144833.28562-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: df97d9b9-e997-4521-f21d-08db2badb604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUYIKTcZg0zjwyuvGd+6owERxIR1K4mVlBKNhcbTGgkt1G2JavgTQf6Zfz2dRLEsKKfECPGuC83GXYpMtg7nkjGdLHEDqxSW9DWceHjl4FSiE8ZYWHZmBIsyDBDEm2tJP6FIWEoNfH6fRpGg4ak4aFoyw1vW4I0ZuHOMsZRN1tdS6T2cqYkpQ46AdxxQHFnTu4wXhQ/GSLY9E1texrIZmECqke0W6vR1zCDpbpEhTIr2RBKcuFUV7C2L/stXXoM6mjDo8D/M47uEpBuVbPqi/4g4Fx1iz1gGV3zkrBHOuKWJPYTOB6wg6QG1kitXvxZ2Q1wmkZZX8lEZ4dSc1WC9pq1GnfKJ5Bb0JImiK4T4gsj8yQ2jLiUcnPemoJyQajtYP6F32n/ydWVtc7d2L+EBUJ0e232IifilOhbpDpgu4rPbDth5cnJf5kUvsqzeaamRMaKve4PkvMuwpuuw3vcjA//fHcKjPC/OgLoZXd/IZ8Fki45QTLA45yfpoZfBmg/GjQV/zw7onr/YTYhLJJdWSp0HsclI+CXqz2avWptpUoh3tzuwr3XjumGENPBGhWTiERYWa3M9nNZHBdq9zNg/SAe6UgwtYPc6Ln6EIwMyYq9ZKuCgKx+eAhwqUjGGlZIIMBC7HPTZQSOed//a4R92vzPWR6rQlsjkc9VEX5Ta0DsCZW5MRmbpsRwcxYBj0fjJwj749XfWMiHXJCW79lROGByYi5NStnWwo754f4+DTBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(4326008)(66556008)(66946007)(66476007)(8676002)(110136005)(316002)(54906003)(5660300002)(7416002)(41300700001)(8936002)(1076003)(26005)(6512007)(6506007)(107886003)(6666004)(2616005)(186003)(478600001)(83380400001)(6486002)(966005)(86362001)(36756003)(38100700002)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xeseklTYpvDya3Sd4QUyMVUAwD/eI02h+34I+v0CaEpoon7Y9hxu5snM4ab?=
 =?us-ascii?Q?AiqRgleBAPAqOawFKxPjhzySW4WBzK6nlzaAyjly/Y1R8SdOLpwA9Yjvnlc+?=
 =?us-ascii?Q?8n19CSel6kscqIOzK7SD+rGiF9nfI96Uwr8T2GxWB0rxWD03xrfBSDckwAcq?=
 =?us-ascii?Q?1FsHsxeH70bU3JPXPG//9h+YBBYKaRo81s3TwZDRivUah9IuoZG0nWUfj1bj?=
 =?us-ascii?Q?8lWQVqEaJOcI0FvIm4fP5sUEQRBnmuyuBy+BuftL6da9lIPfBxWLq97s3h1h?=
 =?us-ascii?Q?V3ySBW5cK+gBVUpJ5jyrKNktOY4DbNphOxvemidCj0rK+aPWMuiIV7fF3dBX?=
 =?us-ascii?Q?B1FwYg2XsSXiop4RnVmMyBo4eGWqvOC7OYrTJPUNun5uakvucsFpFMlnSu7M?=
 =?us-ascii?Q?fQDlDZETwMj/tKNNpkUPBCpJjbgz4WIDFHUbKYIXOHjr3SiBoaz6u1pGqkrJ?=
 =?us-ascii?Q?OSc3I6vu3cktX+wCGCMZ+5QmPhn4W6TYokrAy571bxvdbUisXfMMutCGrkKq?=
 =?us-ascii?Q?0FXjjD2wEEROhEM2si1O3eIQOtJDrSqMLWhUojQHvGynWHkKad2a6Lilo8N5?=
 =?us-ascii?Q?1cHcmLHegUIe8lVfGYsv1+hlofzgki5YYKjcu25CcLPmFQQASyLSNb1gz/en?=
 =?us-ascii?Q?c9GLHmAMNB4emvt0xzGkXdTgAUrbW4ZbN79p+HyLxhRtw2WtcXXjVSZUlp8h?=
 =?us-ascii?Q?TX/TW7d3NC8dmwaRDeyqY62VjFUHRPGuGcUbeuHG0dJeI2eM47yl8lxfzbl6?=
 =?us-ascii?Q?HuuFG9S2DPmkMpA+JnN7QsAllSlqb/1qUSfmtLR2/zFe7/mMZ7YSKkxVPjM8?=
 =?us-ascii?Q?wkgq9+QrOr3d7PB4HXLZZVxCl2nwOZATAaRORNHGuxlZSBjB9adS4w9Fz8iU?=
 =?us-ascii?Q?vuSrZ39rlpBWeY6hq9+fHBKSPmX+QkGvxazLSaPhAyf6B0yuenpOXtNZumK5?=
 =?us-ascii?Q?FDCFm1XsKTabqhap6oOKdTl7q5uhIypHi2/ZGEPPCosjJExAL5bzlmAAYMtI?=
 =?us-ascii?Q?8WMmknGwo6Ec4r/BtoIW/ndcEdY27mntOsjYKNgW34PFj3hnMxvTr1YAp6yE?=
 =?us-ascii?Q?ubiqls9VOvc1hqBuYXwp3MFf0k5vYjveNAT7vFqcoVSQE9nTFaHi77YhOy13?=
 =?us-ascii?Q?whrQVB07CwuU1N8PhTpPzILLkUWMx++kNIHdYZUEKUves60sZIzeedYe2vWA?=
 =?us-ascii?Q?vcTM3huEjQTrovt6uewUOZ2NwAtzWrEW7r4inMhlfRmZp9ujMeVQo+9e6hkq?=
 =?us-ascii?Q?7OACBtCPNpP9QUl2l5oZCRLLylwT/MUOhlcRqBTczVxmT8qFF7AHKmVfpFAQ?=
 =?us-ascii?Q?7S1h3u0fkBpaD+hc+R9D3zW2hmW6L6ORETWvHsyFkzUQv+j7e/NJ01fTpPis?=
 =?us-ascii?Q?TxuPiSD4+AtxFUGa6nJhawpR+nvPJOb/u9k2S4ghH9NWBwZO7yzN8F5RO7Ca?=
 =?us-ascii?Q?HHE2MyZ1CKNKuG/kiH7cLVd6rAUrSEsATMuyj3FVq7PIR82pmS9poQNxoXc2?=
 =?us-ascii?Q?qjVI0C8DcdNPtaGGEmiIYjgOUP7zOs5OQL2xQx7oAbOhOhmMm7k2D95ur+me?=
 =?us-ascii?Q?lNPFPxBg4T5Y8ZeJBaE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df97d9b9-e997-4521-f21d-08db2badb604
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:48:48.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s+KOkTjCi2pufwGdHdOWqhaM1Aame6AZXoc+UJcmnMTrzwK1fgDL7r2XZh3MxlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series contains some improvements for s32 pinctrl drivers suggested
by upstream[1], such as
  - Fix error shadowings and improve return value handlings.
  - Fix print format.
  - Remove unnecessary blanks.
  - Use proper macros and helpers to simplify codes.
  - Refactor config param parsing and remove config arguments that are never used.
  - Use generic struct pingroup and struct pinfunction to describe pin data.

Regards,
Chester

[1] https://lore.kernel.org/all/20230220023320.3499-1-clin@suse.com/

Changes in v3:
- Remove unnecessary type casting and correct type qualifiers.
- Split the previous generic-struct patch [v2 4/4] into two separate patches.
- Add a new patch [v3 6/6] to attach a real const .data with of_device_id.

Changes in v2:
- Link: https://lore.kernel.org/lkml/20230320163823.886-1-clin@suse.com/
- Use of_device_get_match_data() to get matched of_device_id data.
- Enhance sizeof() arguments.
- Fix blanks and remove unnecessary parentheses.
- Drop unnecessary marcos and s32_pin_config() implemented in v1 and set/clear
  mask/config values transparently.
- Put pull-function related cases together in s32_pin_set_pull().
- Simply use generic 'struct pinfunction' rather than having extra 'struct
  s32_pmx_func'.

Chester Lin (6):
  pinctrl: s32g2: use of_device_get_match_data() to get device data
  pinctrl: s32: refine error/return/config checks and simplify driver
    codes
  pinctrl: s32cc: refactor pin config parsing
  pinctrl: s32cc: embed generic struct pingroup
  pinctrl: s32cc: Use generic struct data to describe pin function
  pinctrl: s32: separate const device data from struct
    s32_pinctrl_soc_info

 drivers/pinctrl/nxp/pinctrl-s32.h   |  40 ++--
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 282 ++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c |  17 +-
 3 files changed, 178 insertions(+), 161 deletions(-)

-- 
2.37.3

