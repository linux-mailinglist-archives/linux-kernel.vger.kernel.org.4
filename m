Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90206E88C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 05:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjDTDbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 23:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjDTDa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 23:30:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223B40D4;
        Wed, 19 Apr 2023 20:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxtxF8NhqURvH+Gv5gheFrmACihD7F65LLF4cQOBKJ2iqLD4wswp86b01dvK7vMJKzLANY9MTiV+lDIIsYWuPrvkaOTnGI/HLCiqn3gTK+prpX6dKXOfnTOe+eIrvvKov/oPvwrPm8oBnG2wrd0P6HzanLghLlJV3nQRHZTRgR99EMatDuIHCnfr/4fJFneK0lr2eD1ErkE9SjFMGBcY2KgpNAShBuzQk221w21eylLq2BJ6usDUoG13YrbeqyELTbCOVraE3IZS7f3f7OYdFonrTygMqzBPKtoa5sFkl2qEjXqHyfHwKLQI4TImJ63hZKyHK4fuwnnWJwH6SFvtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge4u8fViut+57+bPtIgPk2Hv4Bx456A3lFV5JQ/cGPM=;
 b=XbWuNYLJVQU2atkvuKVJfjUrP/6c912YsaKQOuJk+fg6lrDTc/YdHvFH1jCt00TRUFoeSq4QIaLOT1Voq4HZVYauw/3gOaZR7HykkVz/aqyJYTHBSLPZ6aKU2L0xndRr6+UEoOiezMOfX+8ivu9YNjQnONsycU1C0VKAup8YcNALj2Fhwvz3mAw5yr0C2bXxaQ6J5jSluRStZeCbV0cP1g/HEEaquDlq9aT2zY1Jc7fZqhm/SfjEXSc9/t6xY8P5YM2ZvckBQEYlGV+GnNpfm2xY41llVckSaIHxIk3RkfCuGbNo3ogO1IirMjDRzgWcULaWbeE7OPpfhDXuVO+B7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge4u8fViut+57+bPtIgPk2Hv4Bx456A3lFV5JQ/cGPM=;
 b=nouAvdeEdHC0y1UOsKNigogNxrmOPzc1Ejb685c0ugh5ogcAeLdc90yrNi62eIpXuzGHZZcdiWHtc6wp94p6CHlxabelOraiKGI6miaxeDMkD+pbZHmqHPKDJDg03wRowUqzW4kPq4vZ30S3Sw+Mtu+pH+M9aU3DglYZGuh2P4KCOV3Aze15sm4nxAaODOmKZOOOUcT4cFk686ZwY3dUlDSaD90IfjAImz5zYXQASnSqEGtkzMJnX7I91sbGIn4bSm4lsC06r3JL4vne9TgjK/Z9PIFWfU+QYVme4GTDgrj5e5TfQWLX30vY6JK1rVNOQN4cdgncjNgSHY7NPNwlJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4139.apcprd06.prod.outlook.com (2603:1096:4:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 03:30:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:30:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, frank.li@vivo.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v4 1/2] f2fs: refactor struct iostat_lat_info
Date:   Thu, 20 Apr 2023 11:30:39 +0800
Message-Id: <20230420033039.72746-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <ZEBPwz4fJATKs22g@google.com>
References: <ZEBPwz4fJATKs22g@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: a06ceded-6131-4005-e21e-08db414fa24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uc8w/6wAfxpwYT9y7yuO7qOon/aSZJMBVi2hqKMHlVLI2pQBXB1khTB12Mfpq/BfCc5AxiUbl0HCUS/zqPqmuzhgjgYeZuZdyAtD0gYsRSInkgdapnhBwKILCUtN69ZyOJpTnw4l2UIM/YUQPe/4JxkaDKMV8A1g9cDFp6EJLtCKc7s6uFBx6GX7EWgDMwQ6efMCmXOfNSy/2fPglqPxuN5gyBcQ40vyci7pZjhZGjiQJENI69fa3Abr5ZWgXVB05lZStNzTKd3cNDuk3j8+eanjg3S4Rl5wftxzHOsMjzSVnFHsVmNjO+EpLU4g4qYk4N0TcsKjJM2JWTHst3/kWmQZUt9fMueTXDWxXN3O4/XXcla3+4lNz46moe1GzGnidzttoHBb+wAePoqw2PI9MlDI5Br5Mx7+EkZSPINJME0xo5LqtxZLS0+YBdnRcWQpK2hB3VQ6l91oGWgpPfE+QIHB2/9su1SkB6LhVR2Wjps5L7v7UbQqiHqnlfa6a3RCxtpQJg1+viWIQ/cS/UxrZ3KoqxgG3xKfWkvbNrZhC1hcjWSZcmqeZTUcolyhppAeO7pKnCxtfQMYPpbHcoq6BpRVKOOGwvGWfRKxY4jmnelkX6aAk0EyinuPIPsmrcD5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(4744005)(86362001)(36756003)(2906002)(6486002)(52116002)(6666004)(186003)(2616005)(1076003)(26005)(6506007)(6512007)(478600001)(66476007)(6916009)(4326008)(66556008)(66946007)(41300700001)(38100700002)(38350700002)(316002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUkyuIDFl2niyfCQUzx25bHPxB1EqfB8JeDSGuGgIGCxUO6NWyrnk9d4lgrz?=
 =?us-ascii?Q?l3975q6xEYJCkKEVIXHrApz9g2ErXLmIMyhjimaLs8wOzkHlai7ENifTdSNE?=
 =?us-ascii?Q?QgKcb9nP7rFRRu8bewMgBMlL1OWD0SDnfJeIoVRHtqRMVpMmnEJBu2jWVaA1?=
 =?us-ascii?Q?+Jw4yYDhfRG99/sYKQ7it5SDhSv9ro6W4tyBqc3w4XsqjMPvU6Uenb8btz98?=
 =?us-ascii?Q?FmsfMY8X2jWwGdp6Hs2onnhU0GAPAnZRZLFrOI7MX/3l8uoIq66mPyziDsOW?=
 =?us-ascii?Q?vDgSx3QzlIsKixllmyuxJiStvptrNcPFZFxgoPeh1sRrR09TdyDwcDNP+Um/?=
 =?us-ascii?Q?VVRasDY/soaZroGbGUx3qCde3A9SzgDMncHbWFkEK8w7IUYDuJ6qvRDOGtuy?=
 =?us-ascii?Q?3RT73Ur/pivmSCmuB+ZcZiNFIt9wkdACDTiEuJwizaLEa26SB5f8kZGpe3if?=
 =?us-ascii?Q?VQbzWTblP8BRMsXMpzvuTok1emLERLY+xYOjrW43xgMwRXz7cK7NcnA5hNMS?=
 =?us-ascii?Q?B6TmesEfU/OpaoDgN3z982EKZS7XyvvVofLg1e0USu3OVZQf+R3DvY4jSxDd?=
 =?us-ascii?Q?XZSl95hwcw+PRYFIsePdcafZ1xRqUe+5C25YdYoUnChP8vkaB5tKMmHmwPIj?=
 =?us-ascii?Q?KEFxpIfpLzE/2E+RgHCtmbK10QxWDtChT679cS1tzUu2G0QW5olZACzt+0ui?=
 =?us-ascii?Q?5wsE2glBldeSxscv2KB1JJQ0IRaT4FcyXMY+8oOdLlNJ/45Z3W9cyWksgekA?=
 =?us-ascii?Q?Go6NVdr0lfd4SFf5efz71My1YSmgwrY0Ry1VX/ojQtu+M9o0mtX7yb+c2deY?=
 =?us-ascii?Q?QCN697e+ms8xDWm3D8MNy674YPLm7ICA8V4TTEsOhB0loivgHxKOE3jxWTkO?=
 =?us-ascii?Q?Gg655jo6wzTT3vLPblgUUyZ6xJCzhvPe3Rw/RaUGtI+1DJzcUUdnCX/4L5iw?=
 =?us-ascii?Q?VxXfIzbDsrn+0enWDWA54OCwU38f8K201RRIyx3LYHiH0GopG30Wh2PwHR2d?=
 =?us-ascii?Q?VUUOIoPCzNOvXYxVVAQ390+SPVzywOorwr0Ba8gTl6UaH+xTAl0Mf7siqRQH?=
 =?us-ascii?Q?F5qXMQ7aPrUckUs//H04NLOT4nnH9946Nw2/HbXqOObU5V4YKYlKWhSySpdO?=
 =?us-ascii?Q?TUUU6F8UkqLf7NrNvIxy7l/kPkE+0XECmd2ANegSQBPAu77zXCyo4Pvbdeo2?=
 =?us-ascii?Q?Ns/9MG3GeKBNLJmFGKkRvU02I1KkVuTHefKIODpwdh4w4lXHwzSAV4O7WF/J?=
 =?us-ascii?Q?bz7fCVeMw1um31Q8uGxFrsESQMzPOlPBr8jnp3A/VU/B7522XjOIJzFsB74w?=
 =?us-ascii?Q?TVmStyYgYf1jt0sKZdNaqXXSgPCjnjEAMePsFO15hWA3RmUA+FxH8CJ9r/Qi?=
 =?us-ascii?Q?aFUX4ehDxaBEIL94rK5aYi2c4mquyXSBJH6mczKB5HFVMG2k+Mz+vE0xMSA1?=
 =?us-ascii?Q?O4hbGNblCX4c4Gikz+7VQKJ99tDvBwogvMiy/b2MOoo+vyhSFTcdL7x5iZfp?=
 =?us-ascii?Q?XC2Xb4kYuWBCKXZ5dfu8+tBnDU4PpIOZkdqBdLNu1PwODu8MvFkZ29K6eUzm?=
 =?us-ascii?Q?UQ3j9n676yGn9PzjxMPFE+CtwCMBHEpPPk3G2MGc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06ceded-6131-4005-e21e-08db414fa24c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:30:48.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYyjqd2JmhRfD/tpBl+NERMhpz/f6oWTOmS2hHZco6fRXfu5yj0u3Zj2GlA5seztZtrmPG4kwSc8zLZXR3d3Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		ctx = iostat_get_bio_private(bio);
>
> This ctx is not used for iostat.

Considering that the next patch needs to store the discard_cmd pointer
in bio_iostat_ctx, there is no need to add a new variable.
We just need to rename post_read_ctx to data.
Change bio_iostat_ctx->post_read_ctx to bio_iostat_ctx->data?

Following the above logic, should get_post_read_ctx be changed to iostat_get_bio_data?
Since the function is located in the iostat file, we added the iostat prefix.

Thx,
Yangtao
