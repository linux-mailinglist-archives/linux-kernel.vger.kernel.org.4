Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981360F917
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiJ0NcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiJ0Nb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:31:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D0D18058F;
        Thu, 27 Oct 2022 06:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMEU8CvVajvgAgmgw0ZNPpPUbSvqFiEJZPuF99AHy35CytDWc8Q/GA2luSmGaMOGRUqtQcB97NR5CClvHZ6zKr0sLj8Q4lsfNXfO6oX6gyVFpWlzMAkKpSzhFJLfsUEpW1DW90rmcCaq/uRdZAXzhSDa6IC4WwugmO00KzMYDPWA9tJcO1QSo/Y9REtZXkSGx+JhYQmk7TtIxN6LJhkyNx61F7fZ4LiMPXeHExEVcSm/3hzmTlsTC+nLcQUl9tBZ5cPFXXXdPl6o8ntR4Ot/K3EkzGd7iYOjU29Das3Sa28rbAm6APk2v8ZgfH/ZTnQ5siBcHpwt1DPKUm3aklfp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEMLmt9wZREjBPasPROXB3BcgO7k8QQfWl5bEXjXsuQ=;
 b=E4hVqXKa5beuATvDKUH4zK4K7yrPvmpVhatd0QMcNOsof3pMLTJxgGEabrC9QYQZfDcTkdHCfdNKOmsQcG2x81UusCAuhc8jvagI1KbGFr/U1rmz8MtELQeCIpl+j3sRxG1l8ayuhcQ+2vUn0USa92YdbieZivO5shS2JeZxYn6YFEPAgOg+6+VgquhsNOJn59hE0UWwFksVoB1ubHl+SgtZWajc3rDPBEM1OqHyyzG6Cqq6teWH6pAxFOGUHtWe0vh+A2BJxa4GRusDeXcHNtEU9hb5So/tfUACdr8X2G98EJgE2Hyv3SWWDEYWCvAIJETGZkWE9fjMLr5hXfKg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEMLmt9wZREjBPasPROXB3BcgO7k8QQfWl5bEXjXsuQ=;
 b=CilHXIjlU7HeO+Mj5ObvfVvpw5cgZpb65mqBihDw41qThoeGCoKLfkNgG4wB5aDQn+B4EGWf/+aHWNTnIsm1ln2JOLTQBDrODClS9Uqf6L7bNEz9T2JvVyCO12U/yonQtolOx1Gc7vipSsELgXmveFZgMk7IeCSQNvmH19mcJWS0g3QZ5vwytkV3ZhJtxm2BV9EMJHbu3Apso8uv/9fmYdzSXmPoCX0Job997eO6PJQP3cYcgZhHsX+y+g6CjdlyuJuSEq/xRkNclmRFnif/RoJx2auWAEiff5zAZWZdd+Tp5G3nHSiYrfcEx7d1SD+7fenfYCrtjLSVqdgfvpnhTQ==
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 13:31:52 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d3) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Thu, 27 Oct 2022 13:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 13:31:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 27 Oct
 2022 06:31:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 06:31:39 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 27 Oct 2022 06:31:38 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH v5 0/3] xhci: tegra: USB2 pad power controls
Date:   Thu, 27 Oct 2022 21:31:24 +0800
Message-ID: <20221027133127.27592-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c3b717-31a3-4fa7-9373-08dab81f9b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lO+sna69cAazOqB1pILupvIxwiTmOUQ/6fXAll08wP5sDqq7Ues2/SBzLsDymMPZ31MGbTNsocROzWLLRqmx58tLjyVt2A9qnQ0C6K4oRut0RUk+g+0M/fxP01QAdORJVs7rVu5GeslJkaeUERir2SmlTxUEngGm8cgOip1zP+lNNDkWIpZPXlwCVlrSiptU3/83yR0Zhc3NmPD/MzbStlbHG/edz9K9Y5v08oMXr8J0eDGbspKTDWCUpsX7MN3a0pG9IkjE5gKJNBFGzQpvxvsb3O8SWqq0Cx+d5JogJM/TYtXzGrvVyZ7YRG8U6PL7qS8VwcVUwIhJeFg39K5E5x3b5bc6TG7Ws2eXd3NyCaiU8V43WiqGNlq5uqzumRi+CCcB/SqnvWASkaS/lZVyxt6x/C1lKaZYwMeTBj8d7nDnMxwURhxfoGThE5QQh8Eh2T/Ybn2gHSgqiiWxBzyCjoQSvVDUYhpBtUzdh1D/RItUUMyfY3eQ+GoupexML1B9xU/n1l8JNJ6eYO/PuzL4bTmEagjInl3VKfR6KU8MqXWZkhHGQLNe5UBS0xualwHsAMt/adV6hOKCTEdJj+NzDOGylRnOhVuVwSh88jWC7IGFBism9Yl7TIBvwB2YT90FP+xsNVQIapid3kt3KEvBJPooP5lWHso3VtNQrXE0v4NLGLP2rBPTyj6VCAkaOmHjasB//7wMX6t+aHy9rJmy4jjhuznbj50L1ISxWi7T6tOa5B42xGdkGAlQhyUWwL2jYLcjdqaXY/KWe4Z3/Pvi7w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(478600001)(7696005)(54906003)(6636002)(110136005)(316002)(107886003)(36860700001)(70206006)(70586007)(6666004)(8676002)(4326008)(86362001)(1076003)(356005)(186003)(26005)(2616005)(36756003)(7636003)(2906002)(83380400001)(336012)(40460700003)(41300700001)(82740400003)(82310400005)(5660300002)(4744005)(426003)(47076005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:31:51.1645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c3b717-31a3-4fa7-9373-08dab81f9b2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Jim Lin (3):
  xhci: hub: export symbol on xhci_hub_control
  xhci: Add hub_control to xhci_driver_overrides
  xhci: tegra: USB2 pad power controls

 drivers/usb/host/xhci-hub.c   |   1 +
 drivers/usb/host/xhci-tegra.c | 131 +++++++++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c       |   2 +
 drivers/usb/host/xhci.h       |   2 +
 4 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.17.1

