Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A9736106
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjFTBRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFTBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46820197
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJh/ElfXvtySmgnjlyNkeXRiq9BFzj5R2n1acYXzC38k295aSHHkAjOEVMYMpyhIn1ID5lPUd4+4dzM2qFiFr2p5gFk5QhUWkx0mk90St+3LbvRaAt+hO7njJWns5KHvsdo2hNOJfsabJGrzyrjyPq38g/BdLX/XJMEBcS0duKf3V6yP23kWVKd25a+MBumIg+ghMdy6R/hmDZQhHAOhathvLk3ubP5W4fwbd44Np31qC0rIg4SIfwHA330OfHgmi9QhFfIfdRLDL5u3JkdpyNf4HcJ4HaeuGb0R1yde0Z/+iTl98XdAn/RVz6eMpsL2k7WAgDktHyIxrjfWnJKtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S08M6qCxf7uj+kvbpIUgDzdHbXyg5xFGSG/3z4Es1Z0=;
 b=LbzunH2C7NTPTh9MIZ9lAjGBJH+odC6Ym1EcrKHmXfISRJpOaiTVmyY74caDHQHEsTryOuBmCN2wTFCUaa5WgWx6chgG47C4oIVZzM+2f4CF+Ik2DQXyWCYHwiA3SrqNY0SLrYLhPnAkJfsKh6xjU0Bh6DETX7ZdmnJppcXR8fh3ou8HBLdPfAVBbtBJiK7zphukCK0rIV3pMDkvo9L4XPAmiAm7XNj5VqSn82rOsNsVfBydWzLJ8MJ1XcW67AzbpPr8tFalN9X4UUmAiAn4K7vy1SOcJUDP7uuEcJGKgOFI+yP0SdlxfPrCtkeBMA5V/oOE4In5z2uGQ1TKAeK03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S08M6qCxf7uj+kvbpIUgDzdHbXyg5xFGSG/3z4Es1Z0=;
 b=qRrXPykzU07YXHBWaouyzmJ2ngdu8d1Oqm/M2PUnQY0LQCm+W5bER51V0K84vvfMQdT/qvz+t/P7JfeKjimE3bmRaH4VF001839ny0XRw9v79JEMG74ypSgO5+MYMp+d154RRWfWUdL2Wd3PCHCaJzyvRsQ1WqFxxo+EN2w3hsnwzHxnKlyPk7rOna+gV/gI+PP5k9raWM5nw4iVctGmyxdGEofK71QIegaD4qCSE86rIVGLy/ZMsGPQoNIB5yJuQ0TgnvLwtzvBW2keiPlK97lW4dN0qCrXfTVPZKuiGL/FOF8qZCGRDHLVQs+Tx2FhoTjzF8WW2iParTmpdRMKpw==
Received: from SA1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::12)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:28 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::d8) by SA1P222CA0010.outlook.office365.com
 (2603:10b6:806:22c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:22 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:21 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 03/11] selftests/mm: fix "warning: expression which evaluates to zero..." in mlock2-tests.c
Date:   Mon, 19 Jun 2023 18:17:11 -0700
Message-ID: <20230620011719.155379-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc43935-c505-4b20-cc17-08db712c1d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ao0QKS/BWIR/4K+dSl1hpv/tFm7clkZKgDV72RcTulKklp9YYH5eeVA7to2OnPEywNmrE9UKlRK073iigo0f+yFRJrcP0Np2yx9A2VHB1JDTcBRmS3BQ7Q41GaBAVJcnTZd9dWGY+AhUJZV2mlvfbNKyOpSFNjetEJnmMEkJdcuvTNYjwFIWy/4aA0ZG1b+3CuEOhXYuZvHd0TOV3nAl0+JIHMJ8QKdN3ibGGHyypMeUX+cH7lqxYemvMawXClUbZJaIjnWad/EsE1UrgBuygeUMUtFrcdnWMgWlMnSVcwQVKRiuHBJDdvpYFn6DSZ0HvxaCp2KqLp49wCE8f5wauelXofbG2Y87QBmVtN3f7mK0iugXeVnaSOy/EVRTPV8WvLcU4vJ+cytF3og1O1I+jod0GxYEkzhbGXDg8RF/izcXVbX01kACuI8axMwHFZwVCoY9l23wdDW7OfgQQjQYQLGNj6/bTJutKz5WVFdC9Fvx5XCHAlZ6i7fKeR0F2oXYdx9yVuP3wvG78+qIKxQ3bDcXahaix2Tqt+y8AsXo2E/0lf0Y52NZ/xJFTp4o+cTpTFUfU3VgQL4OmtOaPH+Rpfk82JwML2DuK+Qx+TTQbYkezZ6nBdPMI2/1XPLANaB8rDe5mejUzdTuVqcERR4jG90VF9OfBgKOJJiXCWB6JzjD+AykkzRHGJgNr5jeNBGoud/OP1OmTsodqmbslt+TVMsnipwqKuDdJPfd/PYzXzKUg4J1nJ/6mIopEiqrurm6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(356005)(336012)(426003)(2616005)(86362001)(7636003)(83380400001)(4744005)(47076005)(36860700001)(2906002)(5660300002)(82740400003)(4326008)(40460700003)(54906003)(110136005)(82310400005)(70586007)(186003)(8676002)(70206006)(8936002)(478600001)(36756003)(41300700001)(40480700001)(1076003)(26005)(7696005)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:28.2274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc43935-c505-4b20-cc17-08db712c1d15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stop variable is a char*, and the code was assigning a char value to
it. This was generating a warning when compiling with clang.

However, as both David and Peter pointed out, stop is not even used
after the problematic assignment to a char type. So just delete that
line entirely.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mlock2-tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 11b2301f3aa3..80cddc0de206 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -50,7 +50,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 			printf("cannot parse /proc/self/maps\n");
 			goto out;
 		}
-		stop = '\0';
 
 		sscanf(line, "%lx", &start);
 		sscanf(end_addr, "%lx", &end);
-- 
2.40.1

