Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855CF61F2FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKGMYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKGMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:24:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424B6247
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:24:21 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bdpkQyfunx/mDaqpI/v296vXjZlIbwZkWTQUr61DEEJn65aaR16nC/HlKvRYdAKkldE2F+i/nMeGbKvX+yRqMieGQIRtzWKpwNnXk0W8Rx++tcaR4DsUHhNyZ6eUaYbRCVU+pnHTs+qAIN2KnlzqGPg/jgt4CSid68+QQ+663G+ChNPr+AZn3MHSkWhucWHBR9jckuxCtzCrfIVUxBM9rozfdGOvc5aRRZOwmQ+VtSX9leTC5xagfZZFz0IhMgfsihV1laYLWXY0MM1TbuPR0cycL33LwhTpLXiHnV425a+UBSOeEWOz9jd9Ph+HtwMYzeqEkOIe4b9qbTehF06Izw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLqfHTz0x/Sj5WrCnWr79LRxjcv7ISip6qywXupVOvs=;
 b=P/Ww6Cc0dWmP+fZz7PJwXH3CmKM8ttIETWB9tX2c8/0sNw8esZRLmwdPz+QGPONH3gOHRbM4n2+cYUokh6vdD4ieZ215lO1lm1M9d8m1GN7sKTYPdv1w1hnMa2wNPLOKJSOJTP96U1DCrism02focNKisxwbj5scgbrJW4HXWyIJGJtqoXyUgs7vgu9uLjSUB3B2DQfR9nFtHHejBUlv8nlFAcvVSS+GFkwefp/PrAUM6TYGpPHdRdX3R6VM2cqZDQ+IVD4pwovVH+GT1YEdNkkWdN9YfOOI85MStT4cgMN7UeCm15AUuoAIak2CTbr6CptXl+9pcjBEKWLJcWbU2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLqfHTz0x/Sj5WrCnWr79LRxjcv7ISip6qywXupVOvs=;
 b=ocB8GK8Pg7084frRU8NMspzFGYROixRF4H4qPLVbib80RjK1zGdvcpOTuv+a/kB/e1xt2ESHq4HOQJiJGFh9w7Nm7P6I6ROujxKUjc2UQ0HSGqfI3lOBZK2dcJAm+ChdK8mC78mPDW5+GbDcvbfEsi8K7NUTVuBQnJ8UELv2UcU=
Received: from FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::11)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Mon, 7 Nov
 2022 12:24:02 +0000
Received: from VI1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::12) by FR3P281CA0176.outlook.office365.com
 (2603:10a6:d10:a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11 via Frontend
 Transport; Mon, 7 Nov 2022 12:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT060.mail.protection.outlook.com (100.127.144.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 12:24:01 +0000
Received: ("Tessian outbound f394866f3f2b:v130"); Mon, 07 Nov 2022 12:23:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 82e17c8263e51354
X-CR-MTA-TID: 64aa7808
Received: from e1fed9e9eccd.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2EF283DD-7B9B-4FE5-AE4B-CCD8210690E1.1;
        Mon, 07 Nov 2022 12:23:43 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e1fed9e9eccd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 07 Nov 2022 12:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgZ/trc9X2b/k9vDwNMJ1BoRL2rYQKbibmKae7pe6Z9WQC1hm1e4KVFEa6RWMg+z9J6zZRZtD1QtbNWfPZG5Yvedj3Pu6lrfI69RAFU1LrqPs0dFYQG2rAPV1TG+/SqMv69/KYq+uNld/KibtRGqY3oTeBplqATl3AhaiKQ9RH7p7VCV7zI4JbPeBouGYnSXoIEM3RQyY4EDH4y/KWCpfNp6m3SA4s/11TLQ+lkZICyvQlZRZQpN6ona9P388ctrMH7zV8Jgl8t6XVSea55oRiwOmyZa/W1RpvHvb/WlfieQ11rZNIJ2ZBaLPWX0SQ7NXuKbughaCt+OTMWmEdmnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLqfHTz0x/Sj5WrCnWr79LRxjcv7ISip6qywXupVOvs=;
 b=JBH0IRlATn5O5eFTcZWfliY1OvukxwMfye1ju2ll1AIeZJ4J+5zkHpoDWj9ZS5kqjC2mF4CfAVm7GhXIOdsCR7mrldqn+d6s1gBOZny3CH381MubIrKY20o+6T5gUnuqwJNfSeqB/RS97oXCzDMQ515s8m8o0xPMyKFg1lufBjMsjx5rAYaz6hr1vM3keac/ImkLytc7jmd8ITnSxclfHw3PzuSy4Nbi1LRXZeHt/NJ6sfGnivuY2KUC7da/w47cJeAH5BxtD9OnJVh1llSGOC45ZKrBoKEa/m1xvIBrVo1zpk5ABa5EQ4ci6WBIlqUADnrZ//H0AGzj21kx2Xxlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLqfHTz0x/Sj5WrCnWr79LRxjcv7ISip6qywXupVOvs=;
 b=ocB8GK8Pg7084frRU8NMspzFGYROixRF4H4qPLVbib80RjK1zGdvcpOTuv+a/kB/e1xt2ESHq4HOQJiJGFh9w7Nm7P6I6ROujxKUjc2UQ0HSGqfI3lOBZK2dcJAm+ChdK8mC78mPDW5+GbDcvbfEsi8K7NUTVuBQnJ8UELv2UcU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB6392.eurprd08.prod.outlook.com (2603:10a6:20b:31a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Mon, 7 Nov
 2022 12:23:39 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::81ce:94a0:632d:7016]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::81ce:94a0:632d:7016%3]) with mapi id 15.20.5813.011; Mon, 7 Nov 2022
 12:23:39 +0000
Date:   Mon, 7 Nov 2022 12:23:24 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <Y2j4vOLbg+bmIyAE@arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
 <202210281314.C5D3414722@keescook>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210281314.C5D3414722@keescook>
X-ClientProxiedBy: LO4P123CA0162.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::23) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB6392:EE_|VI1EUR03FT060:EE_|AM7PR08MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca63520-43c0-4f61-3522-08dac0baf418
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Hz/lbvRYIGqX+4Y05WeSDO3y2C3sYQVIBrYkZtpIuM87bruBxNkYnzXOhV0U0/CScH+4dapg9N3mhFPe918tzhrGMkdSblCeAWPJhUBX4sGu9+sl87fpWhItnJkPqmvzwWkZSRXH+1awxM10ipFaBCxpx53aX8zvd6DVejxvOAY+kyA3rwjtFGNuMfJXa6TsHDQIokl4dfmmKFD9j1R+I+YNCzR+PAa7Z4pv5EfpZhlMkmfXfEw2X2pyV4UZi8ci7fwHOQeFUlQ1hg6C/XqjePnvthDwOCRxtI0j9AK1u+ETiW+YoLAJzgxKkABVMxBmGpqjfwq+uSry199huvy5AU7symaBqm7DbOimeEaVxhbjkkNvR+YOYMUwdtztfGehfCVFXCt4WYJa8uHkQF2nn3ILMaysY5Q6GOg7pK5N0BqujWQ1BKi/Hi6pb3g8gWoEmCihi7yMwCGgBSWklvtszrH0OP6f8oR0rj3SZquBB8Iiqzpx8i6KuaGqyfSVu4o2AnW1SJZjdxQuCoX6AQDrToxjDdz2G45tA4ZgGVKNs/s9+Qt2QmsYRl2ANNadryXkotsrP53Ayb0sn9SumPKUW8sKNYPetQP9PEE4lOg15V9+/Pa0ZRB85icy3k3dIaOCSzRh4vObF+7kOF5lMefOLTcRikW3i6ubeJKvptT+2VUVU6ziQmvwfeftOBSvndzDxUNXd3MBBHoZW2Vow/9m6D5d0BHJNo41bqYLoUh7RJhjqNejFN2e2GHOM2/VU/O507c3nbC+JQYYUWqNPP79z2EOD7rSNI9S2+0lp74ZL2U=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(66899015)(6486002)(5660300002)(8936002)(7416002)(36756003)(2906002)(6506007)(6666004)(44832011)(966005)(4326008)(66476007)(66556008)(66946007)(8676002)(38100700002)(316002)(6916009)(54906003)(86362001)(41300700001)(83380400001)(2616005)(6512007)(26005)(186003)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6392
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 582a5359-9c2a-4f56-f460-08dac0bae697
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAtzkv8k7c9XEWPGsz4aTaHH6acoxfRGniUg8Jyd2yVyNkUdZ6waEh/J1IgFKibAWXe1yNEO3bpuHnTRFGCnOxjolstHuFVmddXHJmtJMjwgaYSWFKuvtGUyQ8SUoSZVr1NrefNVdXLlkRBbzNxsXUCYPuQtgdu6yZGuwAO5BClyL/YX4GUKEkmNoJhWyTERXXCpKwBqS66ZqPc44IvPamTl40FOs53KWvzIAIn0ces5Zg4rpwfu66XMoe+J2saJKsVjXjgTiv3FVgKql4bCBenycDOFZqxcnJyZJ6mCQJ8UiSC8H08pjm0ce4cHzABMYHBcLmSrNPM2jg9la65LxKTRZcZ9FuLWsLjwG7u33YMUbbwvpjqQ0yBBcIJ7fjTjo5sccccaz/6Bub5T0lwORDq1Xb13MZaXFkXuAGBB+Hzi8J63IaJRXPEeonKu/Ilti0S/TK5DUwW0UXo4syL7sJ2gcpczECQjzH9YUtX25gsshJN5uPsdIqfpftptwau6dUO2ig2czkWcVUp5xNs1PeeMn6eVVRj4zNQniObUSqORHTp0iEyO58IKEdhYyZZExhv/D96Y/ABOAnNSnOUih/XiW/gITtvfeJD03hUiUxqPDbhyiEfCPDbzmQrg1FzuZXl9Os1WBaU3o0EUJ07sxo6huJLetqxbaBMrLku//gwUhJScqWwnwsZVvQC4fixrsbgJhAeHzxri/OdMFJtBV8L6NlkXxRl4v4VCW/Y3IeStHFWiQL1UvafXlBkNbuGqchzL++/Zddv7o0kNhXmpWIX+ZkIP2jbvi9+VP5mFJLH905hIaUSLPhpNWsLlhhdhAavXCsrW8aDSfb1f7hQAow==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(66899015)(81166007)(86362001)(54906003)(966005)(6486002)(82740400003)(356005)(316002)(36860700001)(82310400005)(478600001)(6512007)(6506007)(26005)(6666004)(5660300002)(44832011)(6862004)(4326008)(2906002)(70586007)(8936002)(70206006)(47076005)(186003)(2616005)(336012)(40460700003)(83380400001)(41300700001)(8676002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 12:24:01.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca63520-43c0-4f61-3522-08dac0baf418
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/28/2022 13:16, Kees Cook wrote:
> +++ b/tools/testing/selftests/vm/mdwe_test.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifdef __aarch64__
> +#include <asm/hwcap.h>
> +#endif
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/auxv.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <linux/prctl.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define PR_SET_MDWE                     65
> +# define PR_MDWE_FLAG_MMAP              1
> +
> +#define PR_GET_MDWE                     66
> +
> +#ifdef __aarch64__
> +# define PROT_BTI	0x10            /* BTI guarded page */
> +#else
> +# define PROT_BTI	0
> +#endif
> +
> +TEST(prctl_flags)
> +{
> +	EXPECT_LT(prctl(PR_SET_MDWE, 7, 0, 0, 0), 0);
> +	EXPECT_LT(prctl(PR_SET_MDWE, 0, 7, 0, 0), 0);
> +	EXPECT_LT(prctl(PR_SET_MDWE, 0, 0, 7, 0), 0);
> +	EXPECT_LT(prctl(PR_SET_MDWE, 0, 0, 0, 7), 0);

note that prctl is declared as

  int prctl(int, ...);

and all 4 arguments are documented to be unsigned long in
the linux man pages (even though some are pointers: this
is already a problem for the libc as it does not know if it
should use va_arg(ap, unsigned long) or va_arg(ap, void *),
in practice the call abi rules are the same for those on
linux, so either works unless the compiler deliberately
breaks the code due to the type mismatch ub).

passing an int where an unsigned long is needed is wrong: it
breaks va_arg rules on the c language level (posix rules too)
but more importantly it breaks abi rules: on most LP64 abis
it is not required to be signextended so arbitrary top 32bits
may be passed down.

so e.g.

  prctl(option, 0, 0, 0, 0);

should be written as

  prctl(option, 0L, 0L, 0L, 0L);

or similar (int signedness does not matter according to c
rules), otherwise non-zero top bits may be passed that the
kernel has to ignore, which it currently does not always do.

ideally the kernel updated all the prctl arg macros to have
type long or unsigned long. or explicitly masked out the top
bits when it only uses an int.

see my related rant at
https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/
