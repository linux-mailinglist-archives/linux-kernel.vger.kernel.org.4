Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC96024CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJRGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:55:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F79E69B;
        Mon, 17 Oct 2022 23:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSlD3d8CQy3ac5yjgPFTEiKq2RRIHRs1YtZNudYhp4rZnnwY/9hEMmt0YjmJ6wWX0+7wPOZqzMa8fz919mgQVa1wb8iknL6w7n/FD7Xr6Y6sWE7pSw/uuqm9t63XbAyXrYumBnz7Qyphw/gTxXs+IZulU+FPh2xALWeQq4JjFXsRUm/5r5plvoFANuDBiyVwjXxWFNtjtqHoER2hDLCuUZE3TujOCefDaWI/L49NuUYZ/3G/rjDKWi3hAPoGni6ZSf/LZ3K4fU5uGBT3RAwVz1wm8c0A4N7BdosduePKadWbbN4ovE6KKa+DixmS1CKOmWsE/1642uqjqnHlZv+xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSNj/3TGR3Knx8h2eMM/qCyCVU2uyGjoGqr1ryptgb4=;
 b=YzjeGBCvoOGz5naDVQaBT6s5cnOirHgjZTi4Ogd7ooRHSRPewMcnyELbv2NuZLZqCoqvwFCM4iCJt6+1BvNKhMez16vu7VEJFwGnK9jrteP/O4j0TiHBTTouG8HPa/k1uTSp0Ez957W3VN8iGIv+gA12b27FXJo+MDl2NAiXZfJBD6Ouq7v558jYD+OQLZXI8o3yFeUwZmLlGvojf6QisgwPz3bYGGgWtZggruhGfx2r4YgdLvq+txOvgHwMLqzfafBul1N8ajoHeKwSEK9UuIrjlkxXgr+l32zqwRhQbPdqYxKGGm+BMYuJ8eJF4PMP/cLDzWaVMAT6LT2r9BSstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSNj/3TGR3Knx8h2eMM/qCyCVU2uyGjoGqr1ryptgb4=;
 b=X9D0xe6ua6lxtMXdyfu+kJn+v2IDHV807HJ76rmUL6v1KjcYrXFhOIkwY196TqaEiK16XxY+T8rw3byD7cGj7j3mZlNAtgPiEkgwA3DshzXAqHObYZEyjzJnQyjqm/9cVc4xfA7+5w0b1uXExOhwGy7gHfkN0CkzFQr0D03TVuNZ+atvTt3Ys6WnLnSfpsUEtwaJPUWxyxDnas3oFpw6JG2YP+IrdH0HDKzCjElY+bdmMy5IDIbvg3mDmP2uHVhTDIIg1v7p50gsde+tofWya4oBd94yomZ9ozTI086UsW+DOlgCzaA6ko11cSQEc2gh5E7EwNAAeayJmhrOgiDWaQ==
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 06:55:35 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::3d) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 06:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 06:55:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 23:55:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 23:55:20 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 23:55:17 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <gregkh@linuxfoundation.org>
CC:     <akhilrajeev@nvidia.com>, <jirislaby@kernel.org>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <swarren@nvidia.com>, <thierry.reding@gmail.com>
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Date:   Tue, 18 Oct 2022 12:25:16 +0530
Message-ID: <1666076116-12962-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Y05J19PplpDuOfR/@kroah.com>
References: <Y05J19PplpDuOfR/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0867b803-af5d-4b26-e1fc-08dab0d5c19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onmH/TpeB36poF7WeBbyGTUCcJHYRbmJNLEcYzVvHgSjHVE4j90D5LXo4bJN/ruEMlKsfF/2VjSMxOr/55f/JF5kFs3A77Z48gSFq73p/1ZeSncDszg2o0GfOlKiK1gxiJIuhCzzt/jRelB6K3gnPPBErdY1aatqJJfQrXqZ4zZmN4DGCXL+m6vaqOYHMy/JSYQA0W9s0H/kTzs4tJbAAc4Vi6YgBJq1Wy4F9bxrIDrCD8OgXUnJyx0+FATEvk6WrinMCz5f1gVCUaZsE8s/soRsYHdciRzpTc/J+HBDszInOLlu3nE2bQ0lZDVtsNDflSeidtRzrJl5RiVU4bYyMyzcrvGyldYBdXZWEWZ4wY5SjXnO6q3mrgMG6MxwwFbDdu4RHKEVs1KsiNoMQnNlQFMHncmMfzDMT90NvshwPgLcdgH6TYEcQCnYAF5h+ttWhgKgZDNja3C1JWwjKDjz6/AUz/RT0AtJOqQxh3KyfLR8wGkeGr/1gnau1wRUH3RxsQl9VRqPxT3WqnEdsOcKnK0kgAs38N1Rk0IfzLqBc+Xcj2xYX0nwh/U05CTNfyWJ3PubxE5AMJmT38smy21lvoHk2Z90m92rbZS/p52PfHrDeF8J9m3F29zN91J6RoKnU6UZ9L8rczriSe6+l7ESjOW8agetNLo21+S+a/K0NUoM89HUsOicgJKWXLYV2obitq01y6PIlBllhdHAnHlhbsNramivKQLR8tG9LvR0WsYg/1bjcCwNzYTb35UezNOWVC20IiOUzaOV+E9yt9Fqag==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(40460700003)(2906002)(7636003)(356005)(558084003)(8936002)(5660300002)(70586007)(41300700001)(70206006)(8676002)(4326008)(36860700001)(316002)(54906003)(186003)(53546011)(6916009)(40480700001)(82310400005)(7696005)(426003)(36756003)(47076005)(2616005)(336012)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 06:55:34.8124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0867b803-af5d-4b26-e1fc-08dab0d5c19d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:08, Greg KH wrote:
> Why send this twice?
> 
> confused,

Hi Greg,

I made a mistake in my "git send-email" and the patch got posted twice.

Regards,
Kartik
