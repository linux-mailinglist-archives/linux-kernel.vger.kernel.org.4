Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC960E41F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiJZPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:08:33 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70712123479
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:08:32 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=lX9s8sNJK7Bj2V+5I+6MZ1kEN/u7zbIzT5n4q9k7kpu1PDyFnZHN91i5ymmc+D+KlBv00vJRfmhJX89sXPy8PMJJLio5al0RVkEjljii0VS2aMJ7GSS505+MAo0gZGRIx4q7rdXAJQ0YfISpFuSVUShHwXYv5hnnfnHDqpQFC0eTmnmlvRKetcCiiD/SBIDrt+OJmLp6NYMWI3GDyChvCiIDAwlCGOMfDkUi/xPuC22FFQ64TpkzXMHKeNgWAiQikpt0mrxy3pdOAVD/hW3uNuWysLNKKTyKM/tvIQW1laP+63E8kA8ksgIKfcolluzsQMsvFI5ZMaoekLbItD4R0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSROhHN+ILW5PCl2wDM9wNCCF0OA08XemKwknaWV3Dk=;
 b=T8Ohkce500OyHu/mD99W7BVQcchKz3BWtH0J5y268rOk/thE8JdztNEzeR0ydbROBBjuDFQb/2DdUAj4GtdcvE6AdUMApmduGhj8078e2YlRR5h23/QdtjZDScY8nscXDJhOBCnQbFB7eOle1CigTfq9qr3hZvvBQrcsQ/tnGbhHJFpRR7n54QhcxnZOjl/v0GFWo8q9YkBcAOrCFqAXbgmHjLGFXWaWbNqMpYYQly4+DYIjbLXoAqjVqPSXN6l9a0+mhhQIw1xfm20Z794oV9Bi+aVGnLdcm7nALk6FiJCPwYkFmFn0hF1FNH2w1pOGstXQgi9UT0t9Yi03Fp7Hfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSROhHN+ILW5PCl2wDM9wNCCF0OA08XemKwknaWV3Dk=;
 b=1KYUW+i53iu0xV27Ze8kFHqqzv8UQ7bSk1uJfQg6m/yenIsLOmTxILTc1l483j/afFwxT69xuFUqKrbf95yQh7U0O7RhLepQns5VzhnDJyAPcJ5+fUJ5ef7YcMLfbsaByDx3AZqndVsgncNvq40vVx8Yd1NfnU7RWWVzWBsl7Sc=
Received: from DU2PR04CA0051.eurprd04.prod.outlook.com (2603:10a6:10:234::26)
 by AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:08:29 +0000
Received: from DBAEUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::3c) by DU2PR04CA0051.outlook.office365.com
 (2603:10a6:10:234::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Wed, 26 Oct 2022 15:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT039.mail.protection.outlook.com (100.127.142.225) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.19 via Frontend Transport; Wed, 26 Oct 2022 15:08:29 +0000
Received: ("Tessian outbound f394866f3f2b:v130"); Wed, 26 Oct 2022 15:08:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 94ef1b3d8371e5d4
X-CR-MTA-TID: 64aa7808
Received: from 90cc8d6c0469.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4D72F77C-E526-4381-82D7-EE6053881968.1;
        Wed, 26 Oct 2022 15:05:18 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 90cc8d6c0469.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Oct 2022 15:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkjhuQLOkW26dyKvTxbcZMPGZhux8PbFSA/DjwnDg1XsdbbBWNTmrklWGEQHrn5k62DzDoLjuT93f8iyQIrfQkc8IUIe8g3QfZn4QW6uEVeCBsGWcmj3NI+CX6ydgVFwKyRY6PoV/ltae7jR/2XT1wDULwlwbOGwateICW1eks2PSdEVmUoYoJuHo8oMcVwoAueeXc1xgbay0Vo8Y2G2OSLvL1AALZzZEJgC16DhnJT3+I5xYPGAR/8c6DTnkGFJ8p+5aIhhzVLqO6sQEmXNOcRHZJLKYmmbUC4DDFnwf4HVIZooE1iOEUXBPnmJSapEM/RTRi2InMF5jhDLSLHH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSROhHN+ILW5PCl2wDM9wNCCF0OA08XemKwknaWV3Dk=;
 b=kJnU4TLOU3sDvy9lV1laz4jPogLBBsKMZJqc2bOnoEGiYL+0j7Fko4iXj3fnL351uOZ/siGfATLS8GAmaM+VrqZuyZAnu9w4bKd9v5eKLqokDk4ZWpy5at2qUPDnEZ2fK8aXoUfZkBTv+CHjW9gttntiNQeT8Lb4MsyLeAsiSjVK3NzpIDhHHdxsRxUzCUHdU1XQl4CKcSCW0XT24G/g9m0w5E73H5tJwNhcSzf3+198kloUyPTIySwYjLj7EibzzFTuTHXbdKRJ179onwLyfpOrsGEZx9JlrS/dQ0hNQXNv656Ea/ldQunfcCExJHFycVh0AuIUv2EEAKRvrwxkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSROhHN+ILW5PCl2wDM9wNCCF0OA08XemKwknaWV3Dk=;
 b=1KYUW+i53iu0xV27Ze8kFHqqzv8UQ7bSk1uJfQg6m/yenIsLOmTxILTc1l483j/afFwxT69xuFUqKrbf95yQh7U0O7RhLepQns5VzhnDJyAPcJ5+fUJ5ef7YcMLfbsaByDx3AZqndVsgncNvq40vVx8Yd1NfnU7RWWVzWBsl7Sc=
Received: from DB6PR0501CA0017.eurprd05.prod.outlook.com (2603:10a6:4:8f::27)
 by AS8PR08MB5974.eurprd08.prod.outlook.com (2603:10a6:20b:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:05:16 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::75) by DB6PR0501CA0017.outlook.office365.com
 (2603:10a6:4:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Wed, 26 Oct 2022 15:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Wed, 26 Oct 2022 15:05:15 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 26 Oct
 2022 15:05:15 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 26 Oct
 2022 15:05:15 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 15:05:14 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>
Subject: [PATCH v1 0/2] mm: In-kernel support for memory-deny-write-execute (MDWE)
Date:   Wed, 26 Oct 2022 16:04:55 +0100
Message-ID: <20221026150457.36957-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT020:EE_|AS8PR08MB5974:EE_|DBAEUR03FT039:EE_|AM9PR08MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0572c418-122e-4f72-b514-08dab763f091
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OJ0tWd0jGXCt6Vsu2MsRJPz5IB/Wd5mNXe09jlXyMjJMXg966b/fWOjJBnSfJR+y8rn5z4wHz6BhKJQD30wDSdZmJrIEKOFOBM8aT6CKkVUFyIIzqElosDM2LznIKRWgM2MAdrzBibpMVQ5inlyBL8nBqaqcDcR6yEhpvkDXuarI5IarkvCaZpPvSD1RtY4Q0BOB6fXPrwPBhLfin7D8uenNlYDSZnmX2OHRXwsZ/4u3af3PGu5FLt3EAaT4QUXE1LH1N8z+8b3KZv+wZcAOsau+Arw2hGaBAGlht8C3DgXwWpc4cwf/avdaIRwz5vK6FSGmxUIhKibwU+fxn4I6VeDf0Hz04efGJJ+TSl1iL4MQGLi2OHLk17cJcTPXFChjtTf1AMiA1M2C+Nwnuw5XnmLtxaW9SUSfS/Xdrr6oYll55KJ+JG7giRdmorhmQADPdlKD3mmdTiPn51uUT0h1kV/DXFrVgJa0PWuRjcA/j9kJDhjIVD6wZxjh1KjSs4G46ZBWYIvTV/yS3LAJsGrreJ9pJw/RZPcg+q7xjbuoixPgsoWmvpZhMfVFGWvXuv+yT/unYJpAC/Hi1c40vUEK+4YPv22yjWPC3V6W+jFSRoli4q4K2U4+Rxiq5Wuct19jaqfoFQZmYILGtEuWXOyeU5VKEUufCpZvxnyuurvzi3DvSJaa3kFTmgyRnxVz6NgoN4HVp3j0vJmUxMzcS+4FfdXwPGhtusQ9iQCIBNzHtFUeJf9+jOA7lzgSrTPxaZdYYWhGPCO01WmCl/+unCfNJmgnBzuEsI6YTS/Dw1QMyw/qRApS9MWM/cIOtktFSWyQxiozxY3BMIHJbAETpbm/POqcqnGqGBVypHtneFqsj46m2mbW6XAbKO8YqgluXpqn
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(110136005)(478600001)(36756003)(86362001)(44832011)(2906002)(81166007)(40460700003)(82740400003)(426003)(1076003)(47076005)(186003)(83380400001)(356005)(336012)(6666004)(7696005)(966005)(70586007)(316002)(70206006)(8676002)(4326008)(54906003)(8936002)(5660300002)(36860700001)(41300700001)(82310400005)(7416002)(40480700001)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5974
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f6ded434-6ca5-4c7c-5168-08dab7637d63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRZiIaeVBhtivFqdKTwM4SHTM7pU9eRFwOsRK984ah7A9KmFwVOEC0tBqMZYZ6yeBwi1R40+5r6v/8pBKBTobAd3I1bNEKY6zbkssWqQf1t98ACjjc8v8V2u0s+NVzmBdgvOrG1rM9U3U1ZilURwuSajHfDXZqrbFxXPoBOqMLL9NZyxeuGNLu+u3pN0ayZVZ1NWeHn0w/8ncqAVdtiuBNx7ngvYy7bCGmOkNHRhcOBARDtyVaQeBnOuaSe3TQ0kEXVRQCh+U8EyHnt+7IoHYYqt2XEHOpZPc9kKkwHryh1cBaXlUjb67Mqa+8jxYFrJXLq21X2ma/X0eplAApd+/zW68BGodjdaNWzVGNjCMWDZ0v2Tu1eeZLbyB3IU0kaGUkCnjvqCl0c/MKjs9WqDhXXBI0Y2rTUJO5htGm+UiVkBxW6DKhd/ZfE5pITlMdvKRhFoB/GRrqMNE38sB4EFt8PZkvmYX8bSLdJEp2DK0vsPk55xdFJUFfjTdDWvFzt+LZ3pW4kAyRVcz4cUUkYxQ0yumCcl4J1fYJyC9/Gxy2DjoGxLFTlwP4z8Cse/iJtvWURFsDvurMrCcCN+66Kk/Cki1yN3Mz3wx1YgzRZetqlHnv5PKzAfSP+AYXjJH7K19ox/G9PT/8oL6Q/BxDL4n02pGQzMhJWtar1YUtq6S2DKLrLxL2QxGT0cFqtPqBYKDNLuEJkrmlskgvc9l0wANmBJJfBBA/mpnAt9nZht6v+Pv/4RldKGKh17Wu4V1OoKXOcq2id74iEJx/1+QmwYEtYKIEByr9iMXc6+tUIF7kiqu/GCm3gkHu0EVAxyddX+WlzZePnQisHREN3xRfBtSQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(110136005)(8936002)(70586007)(26005)(8676002)(6666004)(70206006)(316002)(41300700001)(54906003)(4326008)(7696005)(36756003)(82740400003)(81166007)(82310400005)(2906002)(47076005)(426003)(336012)(40480700001)(36860700001)(40460700003)(44832011)(1076003)(2616005)(83380400001)(86362001)(478600001)(966005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:08:29.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0572c418-122e-4f72-b514-08dab763f091
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6258
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a follow up to the RFC that Catalin posted:
  https://lore.kernel.org/linux-arm-kernel/20220413134946.2732468-1-catalin.marinas@arm.com/

The background to this is that systemd has a configuration option called
MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
is to prevent a user task from inadvertently creating an executable
mapping that is (or was) writeable. Since such BPF filter is stateless,
it cannot detect mappings that were previously writeable but
subsequently changed to read-only. Therefore the filter simply rejects
any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
support (Branch Target Identification), the dynamic loader cannot change
an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
For libraries, it can resort to unmapping and re-mapping but for the
main executable it does not have a file descriptor. The original bug
report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
for libraries - [3].

This series adds in-kernel support for this feature as a prctl PR_SET_MDWE,
that is inherited on fork(). The prctl denies PROT_WRITE | PROT_EXEC mappings.
Like the systemd BPF filter it also denies adding PROT_EXEC to mappings.
However unlike the BPF filter it only denies it if the mapping didn't previous
have PROT_EXEC. This allows to PROT_EXEC -> PROT_EXEC | PROT_BTI with mprotect(),
which is a problem with the BPF filter.

Thanks,
Joey

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
[3] https://sourceware.org/bugzilla/show_bug.cgi?id=26831

Joey Gouly (2):
  mm: Implement memory-deny-write-execute as a prctl
  kselftest: vm: add tests for memory-deny-write-execute

 include/linux/mman.h                   |  15 ++
 include/linux/sched/coredump.h         |   6 +-
 include/uapi/linux/prctl.h             |   6 +
 kernel/sys.c                           |  18 +++
 mm/mmap.c                              |   3 +
 mm/mprotect.c                          |   5 +
 tools/testing/selftests/vm/mdwe_test.c | 194 +++++++++++++++++++++++++
 7 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/mdwe_test.c

-- 
2.17.1

