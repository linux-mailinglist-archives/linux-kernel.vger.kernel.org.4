Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0B62266D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiKIJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiKIJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:12:35 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0041A6566;
        Wed,  9 Nov 2022 01:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRtGPTxuz7NVXcRb+DLg3Xue/VcF8MHM9+ttcbTBTZhc8ka3iV3bujDlvmBnBzmj5S9xlEV8GARd/zA8aDtIXgv6gx3qnfIoEtd+AD2B25nSTorI/aXRebfI+vDRozqOjVNNp/ZrZZBkNJarsGod2XnzMAM7CHZ/wFXlDfZ159KYt76609sXtuJkY90vHwx0PyLpBAizlN8RrXZNsor+4QpyiC/pB87z0TmMBNNfbJmvANKtxl3hCyeP+wauOBR2ZFq7+xo+xMmM8UoT2ObgkOtx8FMyc8dSChbsZXEWg7Y3QHAZ/I80ta0kAlFepMrgJb5lWpK85h5CgOk0xH7LTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dy9JCm7qgnCyY2uSYMnC4r/SPqMXymyLgcMtbuBASs=;
 b=Lb8rzKr6zKDdpNJYbW/NEbNCcVnHF0EoB+2WS4+/6XqZkj1lXRpA+98JNwe9h8Bm9UXfOEbeGxgK+UD73GkdhyhsTi/UH2/ip66MaQ+HVCXpOZLQMdrG7bBdICSU0EWx4NKV2Euz7mUdtou+XsDY4uzO4BY/IPGzbse9S6V6C3JiPjHBHGeNfskcNYBneKuEIsVe20f9QJlFMD+vLJjbhQ56tDW17byXCLB3X4N8coX6Al8WtYTcZApXeJkCDLwnbquTohJK7BclWkdnkLr+bUiOpGSZM8T4f/yJ0gdzBypxbdPe2LAQT1gMGiHhEDgEWXW0WGQjAQZPUw66ZDzukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 SEYPR06MB5964.apcprd06.prod.outlook.com (2603:1096:101:d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 09:11:42 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 09:11:41 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH V3 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Wed,  9 Nov 2022 17:09:54 +0800
Message-Id: <20221109090957.13167-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|SEYPR06MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 9382ba8b-2465-470e-df67-08dac2326a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgNu63iNb2nSiFHsMJKx4Svjufzh/FJt+MRANKcht4Z6duRyn1mSgHOt1ZBkLvFnZ2NTgkhVS6EVv31qCWQz4CCVzUUcfL7NRQRli/fwyx/ynPCXTLYqsHIfjnZzBg8id2lk98Fwt8CiVljv3RONqcOuPGupmop8HaGEnZRB9MMKuXRYzq0fhJyCcNoZbJEp1dsDxob3/FGlzBE7OZawwYxkMKsC5VB8va1UyIKDFnOVSISE4K4kwrsVtZkoPQ+qwXXNcYz918YNAxAZe2JpQr7jd7zOWicwXs/cWof26qOIuHfVit0lvuSN01LCgfUP5qCqpYbur789tIenkGGrmk+z4QPMAeXXXhHuylS3ANnGgu8LJFId5mN8U35EkK16zieKmEucipaz/+dF7zZuJZHhWjJ7Di36E6P20oyXnytdwxKNTI5ANy6pyqE+mVzV0lOCQCOKodj7XIG9UL+0cJ+ImUF3LH85A+QEDddc+Di5/mpZRZuXh36eRVf1ADRTrXVxRcl7ogv/5PJfvjMQ+JtpJN+e1AH0gUKPdYWmaA546AABeQD9Gk1rMe6UvQ8KtRV5MlScmoCM7fi7KaOSokd0TWxOuiIn5rbAKZIh1A8wfF2QzUol6hbanJFloyAvp6zd6CsUT0eAbRB4os0AxZDU1zx4Ad5k3wSnZRfJwxPFS4F73Bt5QQx+BNVQ4LVYeyd0rps1ecdhvIPJVIKYdQDHeh18vNL7fOAc/L1ywdJxxj4CAcUkGA8Ky5s/nMesvjxjNpC8V9nkbCx8P+KVvydQqwuDbIOsbF3XvFKx1z9Ophvk27xJY9mNA1GpDcId
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(376002)(39830400003)(451199015)(41300700001)(5660300002)(8936002)(6486002)(2906002)(6506007)(26005)(1076003)(83380400001)(478600001)(52116002)(38350700002)(2616005)(6666004)(38100700002)(107886003)(66476007)(66556008)(66946007)(4326008)(186003)(6512007)(316002)(86362001)(8676002)(36756003)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnFkJ4wjTJ1BCmtmSDUy7IDC59/8hMSXUYeLfzJWODSIGQ273BXOCcX9Vxbu?=
 =?us-ascii?Q?gI8i7XJ8JEm81LkunHIBTF9jEUeJCyWW20PGvpja2x/RzRc4uIdWEn6w9XD6?=
 =?us-ascii?Q?jKe3hRTrtGZxfOswXtFpoLMItjJW2cGlfbtRe0/c9//CVdLYHavrBAZFslmZ?=
 =?us-ascii?Q?UVVxv01LuPWGIUGf24Ju1tejXAnYjkaXPCvZbdALdzEbDOcaiDzghPXEOONy?=
 =?us-ascii?Q?krb7DRwXoaXmpGYTwcb38WKSaikSPG6RzmqbWdE/CSNgoR3CQIB4KRxH0sOw?=
 =?us-ascii?Q?rmSGGomGGRQ1L30nvAujUS68H+UvrlIosS0eW++R2A0nKKWXyD+Pgalo2oMt?=
 =?us-ascii?Q?FKV3Kwa9BL1XbHGy0DgGHbnnDRby5U9rdDPNAVApRI7LspsMR18/+tIr+bTr?=
 =?us-ascii?Q?C71/nZteterPzlQWfrojUwAkwLSNCkRMkbsc2N69nvb0Sx17qdarZF83ciQ7?=
 =?us-ascii?Q?NsrFOMHszyqzQw/c1nFt1aww3rBEQPNNVIySdznK/78uqmDamtUOjVVuQdz+?=
 =?us-ascii?Q?h57S0cSj/U+xTV5Va/g0U7cFaYuDS0pje3gS6XhnnzVnQsWa255K2xuHuj/a?=
 =?us-ascii?Q?sXDzkfU8fHRlqa4w2XJ5nyaStPqBYg9v4WcFgIh1XE5aufwD4SnRGwm/pzk5?=
 =?us-ascii?Q?eNaveVRNU0QqHiy499xE9UVC0NmKZ3kRqe6hilYjR392cOqWcTu8A1nJSP6M?=
 =?us-ascii?Q?jyJi1QGzk2GLJkRYBy9wrHOyY0jWLuBoWG+jGyAosK0BH5YHSTK3lP6BAMH1?=
 =?us-ascii?Q?26v4Z8O8pep9GxUhdRlq5s3OXVttHCnj90+zVzik4A7L3O+Ct3dpwLIqPfiv?=
 =?us-ascii?Q?S6oqZaeRgItug8OIk0xmLrOz0Bq5TjNOlsuHu+E20k8bsHvcpRZeDe03+eHQ?=
 =?us-ascii?Q?Rhv6BUhrYDuwaP/hlFA7Sixp+3fMvWwSWbycNYZz4Wh8xIlQ3f/DCXPml5If?=
 =?us-ascii?Q?6q52qM5TfCXydvEfZcl/dwL61n0gWBI3YpBdQwE+gEvhosXZEIObXk2f0oDK?=
 =?us-ascii?Q?A70tgWK7xxOHuYqVyd4d8CXEQUhasY1hI7LuB6QtrukzPn9qCA8vDlIszMoT?=
 =?us-ascii?Q?Q6GftoZoKS8gKlJfD6kVPFIQw9/1TiWis1TU0o3tHjpUFSAcpWaQDuXvUXxs?=
 =?us-ascii?Q?30/9rbfnf1GMgX8f/LKDqhwGdPVldtMspN9yzO+KEHZ1HRI9YVhc0hwf4mGp?=
 =?us-ascii?Q?xNNiU8kLIC5hd4BLC3T9Pj+5+rQx87wiMqSEosfwfr/YLFeksgsIq+uxAByr?=
 =?us-ascii?Q?ST8RX8Ntu6eCr5Lo9xPOyBFrbRZRNwKrJIQRTtrrMShEMfznoDfX1S6iEzma?=
 =?us-ascii?Q?uNmdOqiM9FFFzjXXLIuHjMKVzv8BPmBUbeA3VHMr4M4eodvnjsHK/11+80Ls?=
 =?us-ascii?Q?4Qcduziyddpi6NxlaIBrnRzNpwoya55sGHUUrGHeYQlWvkWqA8Gb7WBrBYSi?=
 =?us-ascii?Q?hs2qOII+A2xmDVP+i1ys1dCK8Qxo3XUF7Uv/MyF/x9qhBlIXiC+kdHvxWqfC?=
 =?us-ascii?Q?pUK7YRUg5XoJK/Bwf1wI9RIAzn1FDVOnQalDCRgHH1yuik047sNpVxcMHn+l?=
 =?us-ascii?Q?HG5dr5ALC/Hv3aK2HoQ03MPELhJt97SfaWZWvpPC/2aU5G011YA8tGiM1gHV?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9382ba8b-2465-470e-df67-08dac2326a17
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:11:41.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi8rDxdnGpzR6DHSMPYCilJ9kbVv0c3kXGhWej9sqqi/Zu6pH4oWQ6a1EcDSeQXUYQB6fO81uf63CBm0ZK5PGSNhpPFoVeFDhbCra/z0Dnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5964
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <http://www.upboard.com> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

Change history

(1) PATCH V3 1 (mfd: Add support for UP board CPLD/FPGA)
Fixed kernel test robot compiler warning.

(2) PATCH V3 2 (pinctrl: Add support pin control for UP board CPLD/FPGA)
PATCH V3 3 (leds : Add support for UP board CPLD onboard LEDS)
There is no change.

old : 
(1) PATCH V2 1 (mfd: Add support for UP board CPLD/FPGA)
Refer 2022/10/31 Lee Jones review, fixed some of the issues.

(2) PATCH V2 2 (pinctrl: Add support pin control for UP board CPLD/FPGA)
Refer 2022/10/19 Mark Brown and Andy Shevchenko review, fixed some of 
the issues.

(3) PATCH V2 3 (leds : Add support for UP board CPLD onboard LEDS)
We did git send-email this patch to maintainer on 2022/10/11 for reviewing.
there's no change on this LED PATCH V2.

chengwei (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   78 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  620 +++++++++++
 drivers/pinctrl/Kconfig           |   15 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1588 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   56 +
 10 files changed, 2382 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

