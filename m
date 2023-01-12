Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72666786F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjALPCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjALPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:01:36 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F725AC5B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIVd+HiGNtY+W2FMyEmLumUSa30KHtp7uViThHW/Fs/xIWuev7jFcy0MEftX+G6W8NNrt+u4SeHzSalPyR0PGratK6/1K7FhKgeoV27ddf+QO7LckO1rccvlNcvFXF9k0OtH717rq2YsUwr20UyGQPGg5+XUPSv60D9ImNWtL63yVILuyaoJXwL8mYkti+ew7xIOgpzSeuYCBo+QaOfW7FqT/ajEZwIt45ukjZPMsyNauZNkqL8/fPXYnUMNU+PfiQfM3Xxke2jusL+aszp0lHXpie7/c28U7/DxzJVxT1P0TKTywGP1Yv4lnfESNr82Q3tZvY6NBNgbYud9p3nrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRIfJHj4yc6ofRhw2V+lfUx9gxtRFGdZ2gLYy8fkyxo=;
 b=YhbWtiSTZTgiuIX3LFeGk3NqmcdzUSqO6UhqRBGkI+D1p0Cm0Whs6C3IOJuPQlUBB7HO10XCP8s++ZTYV9+70UYHGsmBLucU87jl0b/remOfrINsZ+J7O12aW72uS6BnEXn1JFJJ31mwnsyM9ttnawLaRlFVVA8sW7F0pbezzYUSVgzTpeKwxOoQ7ZS5r1fEkZq0YUB2+yoqHQcsgq1li9Dv4U3OQsEOlzSuNpDdVaRg7PcmbkVIdUtRT7KrVJeRp4V2rQyIOyIsiw++vhi+haq6Y35BLMEcw26awmsVocAQxIl7Gv8CsuM85WmC2704TAVsqFUPmkrwRqu+nP84AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIfJHj4yc6ofRhw2V+lfUx9gxtRFGdZ2gLYy8fkyxo=;
 b=IlzmRpgejWnitCz4Lqfqb8W72xMixKS6dvrxGUfvND9Lpv+KsA5ugdgOBOO6gvomqitzEsQ9CKFue42p6eIiCwdH2bu9UHle2pfR8yngh86IpBtdk00yTbc6SunSIHYQ9NA3Ck1Y4QFGYkifDLQu1zRU7AyFuSqm/32qRBuWaUEtIAL4z+r7xVcAZwMQm3Z0dOMMRXeT0FoHH/CHX48pExPBem+G9rPDhXeCS3RR3wekZ1uJ1ot8ur6LCCMWh+HyKoKqh9XluQdy2Yjj6/HWmKiC/kVLilWZgggJnVMqskYDR1u3GAWvXTg13ipl04iNLYZAYAFN7yk5+vjDeBodaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4464.apcprd06.prod.outlook.com (2603:1096:400:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 14:46:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 14:46:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: drop useless initializer and unneeded local variable
Date:   Thu, 12 Jan 2023 22:46:46 +0800
Message-Id: <20230112144646.25793-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <59f19f5f-dcde-6042-cbc1-eee4b3d2469b@kernel.org>
References: <59f19f5f-dcde-6042-cbc1-eee4b3d2469b@kernel.org>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0c57ab-55a8-491c-f3dd-08daf4abd939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMwtf/UBJKowrZE+gMYrGm//Y0sg+H+YgOznZMMmbUSWobWIBN5+EwkgkOsfypKioIVUyEZgXTKi1moLJ0vx/VfZXG8w+/p1/DmXC+nnITv2QhDLSaVo03ADTsURKGVhExXoojuUvPESo5QDwkJi9i16FHjKBbCpzlpTIVUeqAx5D7eRrWWX3doipUNtqN794PhQkUSCCb+TsY4Tbe9WYEJZAB9Lm9t0GZL4R/qJOVHr+MUJ45hpKY0j6Vf/WlPBr1s33mEOFJDTvJ7GFFdmLBYNCAWAMzfN/7vsttr3XUw6AHF+0HVtXW/oTH7wagc9iv9Yqu1CFv8X0MnajVZkbhSMQyVA/6q7yPRJyY0jU6F4sd1Tftolz1q2GZfo90Gu9m1GQH0ipDKk3CX+MUlwNZ6sOQsalxj4uhw3U3z1tXk3wDuX8bf3Nba3FK1Cdykfx2XyzskHun+Xh0e9GEQHAzBoH74zWinH5XPTpVWWJOE/QmTJ8juW71t1jyBfQzVxhhuURyoY7SGQ/bBfL5M2NTTFreQKJLZikE/r6VsAxliv6vBKFTBSlO83aimPFRtESjYZiz6sjVwhW8fqKV+pGanhlt3E87VZfMeeIlsDdars54ShcsqPigm2duN9RHcWrvhMZWMxX5M7wWNEP8foPJPpqgGQ9I4AjLK8+JaPNESQIzje0uLB8szeqrXXjRzjbnoutb2tjySYBs8PfMqRNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(2906002)(186003)(5660300002)(6512007)(4744005)(8936002)(41300700001)(36756003)(478600001)(8676002)(66946007)(86362001)(66476007)(4326008)(26005)(38350700002)(52116002)(66556008)(6486002)(2616005)(83380400001)(1076003)(6666004)(38100700002)(6506007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yF6hUOkUmRYQ9JuOFceQUMW/ZwecBr2PUtX/fD4+f+22Woex4N0KOAiwclOw?=
 =?us-ascii?Q?wBtnTdHugkYWGTuFreJ0K5S5eTYen4DkZTo72DgSml/cl5WfcvWn0v3adBl3?=
 =?us-ascii?Q?lkBkPTVtvQtTQbTZFKL6x4ldOjQwfjoTJ+ePkqncRPKDjEXRB3yEtoCduvtP?=
 =?us-ascii?Q?EyKUu2RSDyOsrObgohMadCTupjqPDxll1eOfwhnBjz4LeKLjlopVq0DJpgUb?=
 =?us-ascii?Q?nObAOu256B86aEOTXCuvYrX+Sr/hWO97436BE/9rDedxA2JlAD3R0VXtGm5L?=
 =?us-ascii?Q?cljwTZRaXqwyy1vI418hEMRXhob4hMksF3U5q4zOP2zKQuKghgyPziU5f78L?=
 =?us-ascii?Q?qi6Zw6a93TnMsa0nHE1a0CdyNx5FaZBPUC/B53qQ57VNlfZrOmYl71gDX1zJ?=
 =?us-ascii?Q?nGi507NjZBc6ktF0uPnTZsWpanS/aRbdv27OtBdEKs/ZZTO597nas30A6eqz?=
 =?us-ascii?Q?IwTnLpcenXrqBL86q85qZUVFhysKSyDAk7sO8qNqnzVJLPWQq1ocoiOp8OwW?=
 =?us-ascii?Q?m0hKY5xSsP7/eWRzMSQkkaBrteK7YrxZciL+46Sl9CqIvRFOaiqnfvj5JEIC?=
 =?us-ascii?Q?ZrCAUIvlfE5+zuihnRNW4DedgWipXt7EdRB6nuYGoTcUX3be0Q/34z+iEFh5?=
 =?us-ascii?Q?Ibr4IAVj3zf0rZGPDOhBqwll1P6QpEsa3hAuclmm/y+cFpVuRwEN35Roqb2L?=
 =?us-ascii?Q?F7XdWTHl2eJVYn6eWZ4B8q7mB6Y/1O9+Ki3GuNc7UhKCvu5TUkEq67Blyq/Q?=
 =?us-ascii?Q?CiH2+6l7VrG3VMpWJlWVES+v/jDiJVC9mtmjOwC05b5Y2MYmZkjNRxw9gOuK?=
 =?us-ascii?Q?IdVpIbFbFgEXYajRfARNpGtYbwuP2lru96jehvBdHPy2NVb1iOyuLOLlnekR?=
 =?us-ascii?Q?7JPqqFzEEkIntakRFF5lUU2ISELi7o8g4uyiuGmeQQBBcLxM0oXDuO/yRCZ2?=
 =?us-ascii?Q?6MxahgX+vyrjzGC85VLZDPUDUoq39jv1f69U8+IR1mMhu2y6X8MUIzcIhraE?=
 =?us-ascii?Q?hxuQqdGRL4BNW/GOgS9IgSWHOtufT0W/25qp077XSICDDj3s+E73L7YqHFDD?=
 =?us-ascii?Q?1lVY7FXq6VD0bIAKzYQ/0szMBkViW97pF4EUblOT4jcpiNyYVWQofeqx068Y?=
 =?us-ascii?Q?1+YtDpEj/InRCNoJ2W3o8DTySpVv3p3AbM7imxM9S5Gn2FnLhEd/AcQb93kQ?=
 =?us-ascii?Q?c0DACTU1rpdyb5GIg83kWiMO/XfgNe9VS6k4t4ikZ0bCJ2/wIOgGYMh0XQj7?=
 =?us-ascii?Q?h+CKLKf0OmzLd8rDDEKvH7mUJOv9crvakr0mEWDbVX3f+pdbmSEkN4pglw2L?=
 =?us-ascii?Q?DPN1zF/q+Dyz3AVQvu+WKbd5k1PjClK+WeiA9z5qTg2JxT5viWrq0wiPVcXS?=
 =?us-ascii?Q?YhdQQ4katSm/xtVnVF/TKUGS3gmCb8T3MKyemoQHANb7STGnAwNp1p81qMI8?=
 =?us-ascii?Q?5VWNtKWrVzU13hQmkS6Xb+SSdDdf4rkTpVjdZUTqoVplLIYqkDrpNC8yC4Uq?=
 =?us-ascii?Q?wb/1zBzMXnPnAgBfhZkmPqdD19nnTL8h7y6yxhNiuchJYGW/4C5Hp6IP11zn?=
 =?us-ascii?Q?x1hpYFkm4lxrLGQVXKKKa3A8ql6XyL5M6yp+Feeg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0c57ab-55a8-491c-f3dd-08daf4abd939
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 14:46:54.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkBSXHw1X0CmOxMfTdMYlHLA9Y1s5e8uvXTIYiDREl/c48KYIAsdrqPWJFvG675Pu2ZUjB4Yk7EitySZYExn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> exceed 80 column?

I use the checkpatch.pl script to check that there are no errors.
Earlier, the default line length was 80 columns.
Commit bdc48fa11e46 (“checkpatch/coding-style: deprecate 80-column warning”) increased the limit to 100 columns. 

$ ./scripts/checkpatch.pl 0001-f2fs-drop-useless-initializer-and-unneeded-local-var.patch
total: 0 errors, 0 warnings, 24 lines checked

0001-f2fs-drop-useless-initializer-and-unneeded-local-var.patch has no obvious style problems and is ready for submission.

Thx,
Yangtao
