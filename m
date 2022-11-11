Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6875625818
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiKKKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiKKKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752F11837;
        Fri, 11 Nov 2022 02:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njI5S8Kx/pxk5DsYlLUEbqoRR4aDgI64s+E50zyfhHYJDOBbqThFWCsBo/EXXTBHbD7V1SRso2MU5gUOyzIYu1nbLnukLuLr5GE6AV8JxzkZ4DDGA7jfHb6ofwYee0zi6oISNJmIUFApfu5FbwfWHTITIBOUsEaJhv/FUoXpYLuKrTbh19NvNy4san6+KJZZ5A8SvvbUHLGu2PCE3cBUnDJbr2ev7cy97zWDFT6Krhlt4vCTkOzqTzUh+4GiN5P1Z4oR+1Wsc0GQQkcRxAZsQad5o7HrfWsKsZxBdk00lOGiM24JRAytLxCXN/RVY/A9GES00Nxlm9+LGueKSBmrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ru9ini2u3kQyOIP/PVdxmz0Xzq7BhvuEvVG4GnfZSE=;
 b=KEdfdlrUOI+qtAlduyGS31xeBH6EvG3bm2w+jKhnmOr3aBXOkCNd9aDoCxiKB5m6L4sF5xRmIdz9NcfIg8KsuNpt+szxCFSk9GfZmsTSklncbkwm/WdpKzeTIjqKsryuYsPgbkuGT1pQalJ+bDFR49Z/HTpZcSch4m+mU86JgqQ0auGNt5De/x8nzCMCptmI1OY7hhPqAhraQbmwsKKmbkF9pMlWjqgM3ODa2LE6yLRbmjGQaP9c0PwQBBIuJwuMdwvTsLFz6ldOQ9/gWyctm72BWZHj0yAnOUPtiUVLAS6hRcuNB6WAFiRJwkpRZRPFtkAbndYCnsA3mnyymyGrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ru9ini2u3kQyOIP/PVdxmz0Xzq7BhvuEvVG4GnfZSE=;
 b=lV8Km4eg6QroOySQsl6L/acFnHeSlY+f5Af/LfqYfHFavLyDqtKfJmmdrhPSzDTiVqj6j3JGTdGqI7sTFfiAza9nQJD3hFgkbT293mqGHLnUWdOJ3Ax2uh63qBW5NcGBcxzswq0NYz4Hk/yM4x2ELOn1ep+XVG7+/hLlD7j7se320zSRVxQv1Tu/8kbTZlKzRVhRUcbAo+hdbRURe6EyH3se1NE5xIL0dfOLBjBRkEVGm41jRByYMxcw5qb6jL+Uynk5OmoDpnVecqkO2tmo59O8RSG5u87FLPAPAu5iK0U7kE0KAcPl5F213T406YdARZ6Jhzz12XYTh4n4xX8enw==
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 10:20:33 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::8c) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Fri, 11 Nov 2022 10:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:20:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 02:20:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 11 Nov
 2022 02:20:22 -0800
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 02:20:20 -0800
From:   Jim Lin <jilin@nvidia.com>
To:     <thierry.reding@gmail.com>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
Date:   Fri, 11 Nov 2022 18:18:10 +0800
Message-ID: <20221111101813.32482-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d6b6b4-0d87-40f0-ec5c-08dac3ce5dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XUuFGUMHQ0NCEeL2cFRgEkE6fvqQUJ6oXap4Wu7ln1qtaOg7OhWrEF3T3lO7Q4u0xMYx+KJvR/6DAFZTTF2ZoPgE11AeK0SBIv04QLYqrrM1w5WsJw9ONxTfOAz/r07fOLuZW1kh5SmWK+dVunQUvszlhx34gS4am/oypV0wotuYDJiZ3BYlGZuYy5m/KBXqyyunLeNR6CtTmWc59FUatmK9CdgUOTDKTVJRK2fsNQZWEHSyArtNRt7tYbNkcrMyARAgzq0TU51PbpMBjFi3c0Gm2zkBNxpVrzDcfZyVX4ZtBSxUK+WftuGebYr9ACJHk+/h9DUouj7/XzyOB9T/OsYRRgxrdR3nia9qrniZZkfFVox0F+NuT1fYj+lZmpBNZQH3jqYre5P3dKMdb422RADu6+l8p5JEsGB2+USjCR2g9K79+i+1SZX7MqV4AbIOX/0tAF9gk+UbQgc/Q0BUjI9Jo8luJLN7NfM4Y0n8c/sejMfTUWGaczceHN050WZUIX51CFN6z7l3o2HWVAQUofm1WeaCox+1oWikpEgcY4cAjX6qItJUfvrcEKRYGoDKxaNe5OshSqQS01KYI0Nu6zv77mginWzoav5nHduTQ/fjoGcl1aaS+W/sf+v7EV8zIdi8VYJCS2dA3KQkEvqTahrwcFDcBXCyQ6u6RWGdJfMxHeDOc+oyUSyE1sqJ+adkHAAzypazidCp+f4idaEV5Tp/GbMtmB0LHvy6vvF5YABL0TutNbA/+wdmmGyjPC0HX21S3D+4DtLN9QVX+N0jg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(8936002)(4326008)(82740400003)(5660300002)(41300700001)(4744005)(2616005)(86362001)(2906002)(316002)(70206006)(110136005)(40460700003)(54906003)(36756003)(6636002)(26005)(40480700001)(107886003)(186003)(6666004)(7636003)(70586007)(478600001)(7696005)(356005)(47076005)(36860700001)(82310400005)(83380400001)(8676002)(1076003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:20:33.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d6b6b4-0d87-40f0-ec5c-08dac3ce5dec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Export symbol on xhci_hub_control
2. Add hub_control to xhci_driver_overrides
3. Program USB2 pad PD controls during port connect/disconnect, port
suspend/resume, and test mode, to reduce power consumption on
disconnect or suspend.

Patch
xhci: tegra: USB2 pad power controls
depends on
xhci: hub: export symbol on xhci_hub_control
xhci: Add hub_control to xhci_driver_overrides

Jim Lin (3):
  xhci: Add hub_control to xhci_driver_overrides
  xhci: hub: export symbol on xhci_hub_control
  xhci: tegra: USB2 pad power controls

 drivers/usb/host/xhci-hub.c   |   1 +
 drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.c       |   2 +
 drivers/usb/host/xhci.h       |   2 +
 4 files changed, 130 insertions(+)

-- 
2.17.1

