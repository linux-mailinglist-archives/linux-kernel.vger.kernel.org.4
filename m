Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66946241F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKJMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKJMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:09:49 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153185F49;
        Thu, 10 Nov 2022 04:09:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeGcPJInn9utrrG7WNbUM95WlpL6bTr4lCCG25v9ld+ze+6lgWogQPz2FPBQMb13aaP4wgg4/PdXzb/kLWFjmVa17ti7BZJ/jKbztpMGfF5ZpRqhA45cGpHF7TBNC/0kPX7UZLLL1dFUYtGTqXLK4FiSNWP0tacsO0E6NGzB51yGtoQ1yRUqzoXmUZ6QSuhCU6sZf+Lz4F+UTMSaiY64oOgqgoCgKj2nhSjxvNp08/KPwetVtSE1cOlqmGSC+2Fmks8dP+V0J+7PMF54qPjzAtoXAKnF7GgE5V/ujODuHnqDeXhDwgip83Tgx+ocE68cn+zu5GS+XnBPDETaYPBhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4/5DLBuq6jwOzQrAcYGB78uHC7egeUttgFzRe8wTT8=;
 b=RVzuPgozN8YOFFejVNR4oYX7YzcMv2HxgfUvCWXnHjNNGSisTOLC7I0dCND0Y0kcQVmxbTHVlLqJB5M+QYWqMka4cboRTP8mkQD2iiHHKgSgNvRdZyfrOI1iOlwgvWlFoqIiseb2ezUZJe5JdcgJ4KVxkrw8IrBbmm9gqMZWFPs2DS0WB7Y5Iw2xJ58IBEqtVC59TnLs/djj8xXA6bS3133TSZS0jMuCFBrBb5xbQdO3erNHH3hkJ3C5dZUTm/6t5gaQrz6JGEtuUWFXpvRYuJ86mb+y7njT4mXVZqe/wrMhAIShwn1QYzMndV4kuVC/iFrDGeug2awsQvdN/pkUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4/5DLBuq6jwOzQrAcYGB78uHC7egeUttgFzRe8wTT8=;
 b=fEWaVUG9Wx0VI6wO3YP+bDbyLSFz5OQbdYSrsO4erSDLTqBuXZmVZKXWRMooxNe3NjrOOhmQ67qjckMBNxWRXTFX9GObW3hk3yyZC/cDTUHXs122mDmwPGVmB5HzIDbc96pVE46Wu0B1wy9TgUlc6+W66ThoIl2sb+T3ePbFxD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 12:09:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 12:09:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 0/3] fsl_lpuart: add some new features for lpuart driver
Date:   Thu, 10 Nov 2022 19:38:56 +0800
Message-Id: <20221110113859.8485-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bbc089-3ff5-4a6d-2432-08dac3147476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApN5Da14Kh2AiIsMznZojWDZEbBR/KNWXYE5MaaspDbgSBr495sOvFgtR5hy/YinELllqEmnPNPmgcCb8ISopG0B7aw8Tscez6L7Fl84jOWgiVKG8IDZk8yhauMwlPhpIyGCw9ucBLJzzDPzM7XbwiRC/dah4wbImd3EawPkQaQvZ8C/sr3S5ETR0VBb5wJS+S+qY4RXk3RFvE5LLKN7Ag0YNBdaD4EFM6qZWI1+TgewY7Ddnnd9Th51KzJkIU+t8hEuvuCGO9RIOOGnCUQrK2Pg5qzUQfRgOFopiy5h8CBYf3ALUqCECCWDPes4+wVc9416cPbIb0LeF8sklv1DRL0bD8q2IIeevWcBsFNjmrrLeLhzmeJyejjZre9e+L31Fbc6p+qXw5LB6SKkPZMgPZ9bKqZM4P1YZkGDq76O1jpU2iu+UDGeppna8YppQxz0Af948pJUHH8hL7VpIHglV7BX9Xj1AxURyVpZY3lacjt+5JQnOePv1wCtWJOx27wr6NtAxTjy3FjfvMWR+b3zsyFruLjcJZJyZrcgDlNKYXKbsqks3InKRsqqkis4v00kMqYRmbQ7qqw474Pdr0Vaho0PlQ8TF7TMvTLX+GK5WaGLno6MgaI9sxuI7sEkPTKbvWwCf1OZOPsNeGiYJvY7hhRHUBQZjmPbTBCPDlU2ezSECFI8f3KTwzSIHjxJtQkNFEA2Mo6oCOazU25oSpsK5ixCKh+lQD6aqlMTz9cn3Ik+/1GQBKImcbSGZffJqqYljQaxhwKsvWdZJYIzXvDrhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(38350700002)(6486002)(478600001)(6666004)(4744005)(8936002)(2616005)(316002)(52116002)(6506007)(66476007)(6512007)(41300700001)(66556008)(66946007)(86362001)(36756003)(26005)(83380400001)(44832011)(8676002)(4326008)(186003)(1076003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3syPSZ5yticaiJMZUu5yhA2D4HUz7/zM9Sg4tJtqewoL9DfqUUAV4x2fbCy?=
 =?us-ascii?Q?1TE6SeIpwGvU6C+yvYjnDEBrK7eL7vKa5zUzPm4JyW2ZdnY4KoFAy7VeSH4b?=
 =?us-ascii?Q?NEUcOSCNVFi+h/KNvarR4paSDM9dDYE8wF106MqcfJEkiV8AH6pnZHZkNsU2?=
 =?us-ascii?Q?tf9yFyr72wjv9GFegE6ts4f0xr+6UvOA0KpRZOlfkWgw5IgH/FRIXS6R+Yqa?=
 =?us-ascii?Q?SyBZoPDtCl2rOFCMSI9Gn4DvcLQCdmstm5Me4OWM+FhPJfuCPLfuYzBOTDH7?=
 =?us-ascii?Q?W7db4U3n47nakDP5lof0f/EWHlnxJ7Q0d3woMTtrAVcofkcgPetggjVjKp94?=
 =?us-ascii?Q?c0HVAbMRbABnlqIURVfK1vikTeihrRIlahBq+Zq1cP4a3TX8n8BcEkkDloQs?=
 =?us-ascii?Q?fHHYS/yTMnKUccc+Zbtr3M1HbQvIg8727aj772/2AN8PhitggFDNU8Gq8l2L?=
 =?us-ascii?Q?NkuG9Bz1yivm9qieSoMCa1TBPdv/yYO+qdkzY3qX7no88gKPb35+kGbmeskh?=
 =?us-ascii?Q?+vvruy0R7ILAuZpjVDGgiKhPazqbKZDIyYcmmYRi3L6pj1DHvpsQREUkF9Fx?=
 =?us-ascii?Q?Pm4LQa1w82h87pUhfoSnCOVav6xkDgdTBoPAZ11iO+mw1GLkU6pv9cQKXuLn?=
 =?us-ascii?Q?L6nF83mNrnWDht4zO3N/pMLtKkhPMAzhKO9bBwcoyFpEW6d+r0B7GK5XikSN?=
 =?us-ascii?Q?TJEElI4wVB5SLzdgE0dqOuE2zmowp1fnMtawchnldwyM1IfW++G85m5zOCvm?=
 =?us-ascii?Q?7wfjbgvB5AxJFrQEIjHWHMbG3ZHgBu7dxU+CltCYBLcCUXC87ANmmfHcF416?=
 =?us-ascii?Q?j73hUTwWxe5UcXxoCHgFt+FtZloLFf6/gYGj7enGzqdPXLaTnQXcsquDh9tE?=
 =?us-ascii?Q?RT7xxN8x6/aEMGvsqJFdrKpfaFjuCcrsk7gqO/87LnvXv5LD6vcxfmK5QNQo?=
 =?us-ascii?Q?LgfSWaJlgYuhFfA7AUawouZ+zG+TBtMj2h7fMEQznjWkHpysF3wTSz4yYzb6?=
 =?us-ascii?Q?O/3ThbnRg6XvMNQ4xiZi6rhh2GqxhdI9O6APYMnwGxy3GD+bizSS6BRjeUhi?=
 =?us-ascii?Q?cjSDPXPmh9U+SMrTwUvhDTUOcUEVsad953FNPalesalwHnVZWFB+C3fbDqtN?=
 =?us-ascii?Q?ZfZSh/j814NhoD9AtUV6e38CBabaFsYeEbC+YBjHvIMZt/LygfOI/Knqmmbo?=
 =?us-ascii?Q?pUEYWFHC9njKh3FbT+NKt+Vlo30nFqrATDf73wjL1vF8xoFhGY6RtxSg0eJz?=
 =?us-ascii?Q?NsoybaS9CrhS590xMm2AAj85bAUVoPMhYZ7MEMQDUSl5bQujSA0ZcpjGNKj6?=
 =?us-ascii?Q?OkdPMWeyMazDPo6+PxID7o+gMWwwiFml9ejJpIvWa0asmYvwAjiRxtiZ3FhW?=
 =?us-ascii?Q?+lQRRTcGeNlduDQHmHjRZA8/IQElEYAz6y+S1ks/a76MsaRCHfsvVppVblU9?=
 =?us-ascii?Q?eElUma6wowZrSliIa/OySlkDJVcPCMjvuIcBbwvHhkYmuqlkgdHOEa1O01X7?=
 =?us-ascii?Q?5qtjM/dF0nbpnpYhUAJKgX6yaXLn/b+4uce0EZO+fwuSDn42AFv4jSrBcfS4?=
 =?us-ascii?Q?oxYVkP8UXQxfSb2lwQ6TLgUTTfREiYKTjyHiU1/f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bbc089-3ff5-4a6d-2432-08dac3147476
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 12:09:45.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRISWV9KDWWKqMTNlG8cqOI8Y+gEiB0K0GFUWpPz5gaQzuXDG5v0p/GEXJ6dVbGLc2zrHueVctfvztTwT0oVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches have added the wakeup source support for lpuart, and enable the
runtime pm for lpuart driver. Also use pm_ptr() to avoid need to make pm
__maybe_unused.

It has been tested on imx8ulp-evk board, and the two new features can work well.

Sherry Sun (3):
  tty: serial: fsl_lpuart: enable wakeup source for lpuart
  tty: serial: fsl_lpuart: Add runtime pm support
  tty: serial: fsl_lpuart: Use pm_ptr() to avoid need to make pm
    __maybe_unused

 drivers/tty/serial/fsl_lpuart.c | 343 ++++++++++++++++++++++++--------
 1 file changed, 261 insertions(+), 82 deletions(-)

-- 
2.17.1

