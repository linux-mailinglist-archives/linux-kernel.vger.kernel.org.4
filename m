Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F97697F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBOPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:13:26 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474A83F7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTm9G6EnUeymiFCa1Cebx7jvO8ab+PvP/EOkwJNRJRGd+0iqFmkGaV25RRIoszwURzXOKu3mdavK1LJCZjlPZ4UxnbUqorY3rJ84TV+A3EBVA3nvDT+UEkfuEjzf+h1VptprXz3Nzpli99UcTvEpA2CCPPa3F86Bs6l3ApkNVw402+YvdIxF1AW1uouqm1BTeqYTQeSh+lY0lbvCfAbi9WJ70Pxv41ZBR3NAMewqqB87EHVZv7GkabRoAmq6yk6T5OLFzgtCff4wyI3h0A0FJYZs4a+fNAKlLN17Mxg6zSYjw9rdBiCS1EFkb21qbKqXORN95kMNvQKfHmZYHWgOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E4Gjg5ExgH7/0MEsP9yTxZgTKpEO5VgTfBTKSZ/TCg=;
 b=QhCA5MqB158UBKX4/5mMxbpIN7JMg8bX7PxqjrSYAZ03YX++28LMFJ+XCWCfXdi4/yxCpTKWC1sG5x0BWADTB9oThWgilxGnC6PNh8AkZN3Jn3Wp/k6EUbu9ofnqYv1GqDgEue3gQqGu+lasRQK65pKUjy+lF1DFuRlSKeS/KXGpL4hFlZHMkmrpCr6RY9Lujq/1FMFkllokweKf4PAm0T758dwn8RRrKNPSur9IfHIy2UdH+fiiPZHyuC3ICZbGOsx2cfu6H2Wt4ziS2eHSCh7kfQz3UcLlJ0NqAY4C3Z/qce14NGwajcNN85k3yD5dasMznpk/fZb7h0bhDA5r6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E4Gjg5ExgH7/0MEsP9yTxZgTKpEO5VgTfBTKSZ/TCg=;
 b=jcMC3b13CHt6jGGJiaQbhZAfd7GOYH8pxsE40X5EQzKSBJETwJNgARk2cyVXQ/suIkIevJbJ+4pK7dbtgYxAm/tgksQ2bip4PKH2t/0iBFyoHszc1R9O+gU+OR1PR7UiLWWoPnNoQQTm/liPTFbLUDs0GIg8DG9y+5FB1kNC/gH+VseO/wT8iy8x6z/gP0r2GwUDYyTHQQvjxKPA55idO2fk4Sszm7xMdGhXYsWNlFf+UL11u/oj4mnLrUfonBDlsmJ0oHGwZQPSArMtpF/AZ8pDrGIZ1m4P7r50A0FpjCOofrKDYN0OwJx1I3olL56MC4MNramSj3WCmfirqLHmEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 15:13:20 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Wed, 15 Feb 2023
 15:13:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com
Subject: Re: f2fs: fix to release compress file for F2FS_IOC_RESERVE_COMPRESS_BLOCKS when has no space
Date:   Wed, 15 Feb 2023 23:13:10 +0800
Message-Id: <20230215151310.14520-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213142815.24095-1-frank.li@vivo.com>
References: <20230213142815.24095-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SEYPR06MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd2c65d-1b94-4b72-0b5d-08db0f672be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DSst36tkMyafTEJY9Rr7/o3zgmzpYM21UH95264QHIkx9qoVk+xiQycN9c/if2p9T+LVcAh41U7532kGeMmtAsI/7nNJlT2fG8cCUztyIGGe3tY7lp9WRMYfp7W4S9B+PK0Fxk3lMVjU3kBp/R20Dis4ZnmBF2IlA8ca54YcUXVjh2uJYZ1PhgbdGETWasFAhhbnfiRb/M8gGe3liaJI6VnpYZfHKnimGaKXoncuH/9glCvYel2VbksBQKIDwOYBomzHE21br+VN+xWmj2aOsL7gHbo2yVVuLVs1GqDITOCJViY0xnLySYhLodypmLJ7OJdjQjn0fnAYCAm7gYjpY6CCk/lIvfaLuP48ycBdAt9knWPJOsXB8AuE/txabYFnS5N3olKtyisdMDQSFMWGUA+/eyJT7abO3xBEHPdy0tnei7ok4OR2QDUs1r8hdE0ExcTeReAEk10VAQ8usrwivd1gihxEP2uVsNQAPsimTl0uk/DFOjJjkVfsOEt8uKARvJSUwS3DPU4+orQqNlDg7gfoU7vaGveOPyaNsHGhRjJS0NDWWTOn2WG+ol6hCAgAm8yMQLn+SXmTjZOedsVoNuiUpehws4rAS+bnjNxxRs1cP3fYFA7J86dkprV8VuhmURZRn7skuDWzzJZSgnjqSpe0cp1vijbG0QFc6ALjdyejbwLV81J+OHrJuNQcBX1screIzBmAt8IcDd/29fZdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(36756003)(558084003)(86362001)(52116002)(2616005)(316002)(6506007)(1076003)(107886003)(6666004)(186003)(26005)(6512007)(6486002)(478600001)(8936002)(5660300002)(2906002)(8676002)(38350700002)(4326008)(66946007)(66556008)(66476007)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWqY3NAH/9814DsFQMNuVUo+z9+3ZbykcAYRZGH9CK/rsTUle7jFkDjlhK7O?=
 =?us-ascii?Q?y5M/oRBP5ymI422OzspATS7R78mzqREbOeoRrfxy/BVZcgUdJe8K3Se5BlCw?=
 =?us-ascii?Q?VmOsjniE4a9oanxMVoX48yuLM30ME25o+DztVbfNUSmRtsuwj8b9ISZI41hq?=
 =?us-ascii?Q?0La9Xnm/cMknEb/HiiqNJ4KS8jg53uytzrokx5xpk8jL3B8L0xjAUepLmlX4?=
 =?us-ascii?Q?IYulda7ipeTkW3vt1egXb4VaFnbnd4eHzT2YKu8g4ZbP/O/6E1FeDJa32mGZ?=
 =?us-ascii?Q?51uj/cCOTloTRPeOI/9KFffBbvICVbNyLzszSutSCpVCkyHMGHEYD0o0DVlB?=
 =?us-ascii?Q?PbbRhgkhqTjmltG8AXBVMg7MP7V/DAmR/SVipWvp2ZBNYPIeLcWXWXCTZaqd?=
 =?us-ascii?Q?22wwQAXEs9ZOWsreG/xNyt25tKS6yH268gnP2PJAiAGRHcOfpiCWfvDqFAf9?=
 =?us-ascii?Q?jKq9iImdxPJURbXQ3TC5sqAJyWPwreZd+AV5EEdi0ZN7RtglrtlPYbVwYwQw?=
 =?us-ascii?Q?zvUA1PqhYsllQesjlYuJGEk3GJxCnd02rZ4bTJj2tqwPUPXx5scF/lGJtYUG?=
 =?us-ascii?Q?2wzZlsesap2/aH4emDS1v/X8Mio/HJkiq025DdnRSBY9pJ1rgfTn8ykHrM0L?=
 =?us-ascii?Q?chqTN6r5+y0nERLMCUscDi0AdNcZ4UVnftQTRet+Ua0rxhvXq7C5YLQLFLDF?=
 =?us-ascii?Q?pYQBkIDwYBBHOa6SOM8XMmj2BILubNM359dr4O20IqD27IdORn3frUUHpdfu?=
 =?us-ascii?Q?OIGr5VWzN0oQ1z6zoLTqAPPv42dLGUHL/zaP7DfCOOZ2OGuhWYvXKbvnCgRD?=
 =?us-ascii?Q?TETjaQA7pgK/Unktf9W+vyag7PVzdnTL9nHLo/GTXJErYTFUf/+IWm/o/2Po?=
 =?us-ascii?Q?GSbH8SPwogpuSERp9cN5DP5IFdeMZI+OEvmLrwSm5yXKeWfsgackA6LO6eLZ?=
 =?us-ascii?Q?73bGcZczCTrW0BfO5rONMAYB6Fg4WcL2k/qQz2upeBJNUdV7FWAgfgYtv1Aq?=
 =?us-ascii?Q?lw2rM2u2Z+Q07cPS83pqcJzaUFnSR3i0icJmj8Vqr+RdnnceOKvPvXphlpKA?=
 =?us-ascii?Q?bJ3gVMkk0i9WIpAuDodU8XH1Oprv96Bn7a3ezBUitHyoWMudgO7/EuBhCWc3?=
 =?us-ascii?Q?Bx3oapmqSK5Uyn2iAcn7zCuYR0lugzcEBpzGuVWSE6MwxvWIoEL7zhltu2El?=
 =?us-ascii?Q?6JzxFz/CX/d7y2wCRhFvx3wNkxFWXRhzbTdYrm4UxM40M9jo2VheOR54ghT6?=
 =?us-ascii?Q?ZkVF3cWPWNcntxUsg9gKwQbFJlqz13WyytemuDn6KiYi0VqVo+cw6e6ubR8Z?=
 =?us-ascii?Q?0CvYeHXH5/qpbf1MKLRDOGHb59jsBTuR07QS03CuYY20QejWN+j4odmB+Vbx?=
 =?us-ascii?Q?c8bBikD08wBLsb/CGdEEwkDYFycTIU5p/WfTM8YtX8IuHSOaWQ1B5xXd5syI?=
 =?us-ascii?Q?LQp3EWooYDBCmpjjoF79fwDq26h3Cgs6Kp7ZbTKYZK6oVl1QTyeuyjFgrSBI?=
 =?us-ascii?Q?/PJUfvNgYXdJAlONh/0vLgMpJyUojSB6Y7lf2Br1ehj2rLSG3+khzaXJrCWn?=
 =?us-ascii?Q?TlRqn05Q0mVhuyuqTmFHYDc8wJV0T8DI52dxHbse?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2c65d-1b94-4b72-0b5d-08db0f672be1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 15:13:19.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRShcuvWwQBo1Oq1+ZHfdvuNc1obUd8efT05TMQeESrzD/N7h8KLwBIIIB0C3UbO0yWOQ/gCXuFCxAzjb0UN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

> Chao, any comment?

ping......

Thx,
Yangtao
