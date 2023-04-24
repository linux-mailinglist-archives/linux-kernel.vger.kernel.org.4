Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6266D06D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjC3Nea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjC3Ne1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:34:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E549029;
        Thu, 30 Mar 2023 06:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XguiMLPE1RSZAEmSU7WvrYp3HV25NO9O2WjLj/Xc8r+HrPCYy520RkCkuvluejYYl6sWZ1g0WWC8uBcIgXhWeR3i/yHsi4Dc5IfiYvOkw46AU9Cz4wHIPnW+nKJmuFuJQt+geIWt2SqxL1YWglBx5b+D6Kxi3nSS/tzZzqm2tZC7ZvjDYjVRdlpbAi5ZIFsqD4J6s3vGj9dnx796uGzl2+T3HgTT1Po1cC/+8ErK4XJkBDtmpSSc1wnYncb3vFML27b2q5ZNloqRsZy/4TQnvFJjK0RJjS5JA4iJkQ3qIX468ofYYZDQQYk0fyVXtlaAL+G2ZrqohathqbkDI+WTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/FPLSvJUMGH/Sainst3GJd9T28t69atGD6aYkesA8Y=;
 b=mENfeRTCoeQBjhSCvSLaZKslttG50g04o69YseHKCaZSvxDQ4ZZ1PCmH4gZJ6FNF1+25XVtDBxIe7AQHjaZNE70Rd7mrJ2ZipQVS6d9KFOwRkrUCFJywDu00VJXcW7T+u0jcIunxZfS4z0OflI8/W4gwsWFFi/QLjvlkRD/P9HpUqTYdUhGF7DrAbdhYwvxhcCz8EcrggqACI3xY+jHKme93zlBy97gnCsCQCoDxIkWl3iPAYv9iriAoGjGTZLB+01zS4OkH7sElPfqC+9yk4Mm9d8AmwC7BA8OyTNq6hl41X4aNfwVCCcDRCtZ6QCPzTQEhK5J7RdpppFU2xwIF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/FPLSvJUMGH/Sainst3GJd9T28t69atGD6aYkesA8Y=;
 b=KcXsRojDweao3IWBi5pN/Tt//1qWHvBJmkj8IMSeeuDDsHtMGFqRGvAKZFqArGOVX5oIeIyw90UIQwiABbxOlgRasV9jn/z+Nb5TRYtMyqKkLQzkY6eAtYjpr0kmM6RYnx7CKdDXuCT+Guug3HY9TYF0l7vfmbMtVhMH+7PSl9KAoh8thBsg2CQaBiqPJxdwXjkWf2JEpQ7CgF8F3Jhq9Ix454vkTM/v+DlDzyxBZpZO0TOM3Fy8eRdbqXFqswki7CHj5kbfA5tROBh3GyDqT6vSW2ayJor6CL1uCL2EeJjlquKkF9eczSgJybo/lqMbAwU6d5g1XM8oh0o2tnIO5Q==
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 13:34:05 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::b3) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 13:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 13:34:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:34:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:34:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:33:56 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v5 0/8] Tegra234 Memory interconnect support
Date:   Thu, 30 Mar 2023 19:03:46 +0530
Message-ID: <20230330133354.714-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: f6442c27-2a38-4865-f817-08db31236e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdJkvq22N5js+HKXtl68ZdcTrcaZzer02h2xTPTBoPWdO1OvGSOm+C6W/ODoClSzbLE2EL71v84o5xEzSYdqUZoOp7wnlWWrwFNhfVqlGdFf5zNifqPkEVjKsus98DDaZEg7ubBf/wd36wiMpQ1AGCfw6YtrjVhAV42w+/BWTeyN0zj7lhc3niQog2nCZ/38tZ85nE0XwaEhDC+IHqNlo2L6PZrQrEuzpan5N+qWW6dCg5WYJ1i37orzi4KVNi8FiQBCOKr3XwHmv3zCSujXf/2J1wUwUVaFqv43AXO4alCfawFLSVMk0EIj4BnNg1p1bZkfVwQ97f8o84zHkmJywF73KcJXuPp5t+nt/xQq1M8Op/XHdI3phgnda+m4hqoqiOPhy6ySZlFB1vrbeDzshEGsvApj26iA9w7bPfv6uNKW7FWyFABtH+8CgBnUH3c97YWC+2Z+Im/DywVJKQFbCwKwWpa2fl2fOJ/9IdfvE2UXU2l8u/4oOFoViQWqTPArnw/PdmXP3A7wZXtXVM/QISN9m0LrRBFHpnFYperDjdm4p1TccENOOxJCBhf/hGpsihefymEvCN90yeeLyg2/8IY/6rgsklprj227rCx/s6OWKc9PvJGHMjJCtHa5GAE+oSeW+wILdTFIXQHEPtGaRUWY1NRjlWy0X1XJShTR3sHevj7kNhMZnagu4wH6yFvUjPVgfGdgEE50mJTawS6zZjZbchWOi+FOHny1ph7XG6WkkWMB6QZVBUMW8H54/kG624AvBeq+dW/VhlBivja3R5JjOIpgYKJuorcdQmewt01XeDkleXJfHyYDW+zkQicKVKUTip2m5f9ee6ynH9cQ/asAy4R1q00RjhoWZd98p8k=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(478600001)(107886003)(186003)(70586007)(26005)(34020700004)(70206006)(316002)(8676002)(336012)(4326008)(41300700001)(5660300002)(356005)(7416002)(82740400003)(8936002)(54906003)(1076003)(36860700001)(7636003)(7696005)(40460700003)(2616005)(83380400001)(426003)(47076005)(110136005)(966005)(2906002)(82310400005)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:34:05.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6442c27-2a38-4865-f817-08db31236e9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thank you for the review. Have incorporated the changes suggested in v4.
Requesting for ACK on the remaining patches if all fine.

The patches are divided into below groups:

- Patch [7]  : Memory Interconnect support in PCI (MC client)
  -- Need ACK.

- Patch [3-6, 8]: Memory Interconnect support in CPUFREQ (MC client)
  -- 'Patch 3, 4 & 5': have ACK from Krzysztof.
  -- 'Patch 6 & 8': Need ACK.

- Patch [1-2]: Memory Interconnect base support
  -- 'Patch 2': has ACK from Krzysztof.
  -- 'Patch 1': Need ACK.

Both the MC client patches are dependent on the 'Patch [1-2]'.

Thank you,
Sumit Gupta
============

This patch series adds memory interconnect support for Tegra234 SoC.
It is used to dynamically scale DRAM Frequency as per the bandwidth
requests from different Memory Controller (MC) clients.
MC Clients use ICC Framework's icc_set_bw() api to dynamically request
for the DRAM bandwidth (BW). As per path, the request will be routed
from MC to the EMC driver. MC driver passes the request info like the
Client ID, type, and frequency request info to the BPMP-FW which will
set the final DRAM freq considering all exisiting requests.

MC and EMC are the ICC providers. Nodes in path for a request will be:
     Client[1-n] -> MC -> EMC -> EMEM/DRAM

The patch series also adds interconnect support in below clients:
1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
   add per cluster OPP table which will be used in the CPUFREQ driver
   by requesting the minimum BW respective to the given CPU frequency
   in the OPP table of it's cluster.
2) PCIE driver to request BW required for different modes.

---
v4[4] -> v5:
- dropped 'patch 1 & 2' from v4 which added "nvidia,bpmp" in MC node.
- save BPMP ref from EMC node into 'mc->bpmp' and use it in MC driver.
- added check for array bounds violation in pci suggested by Bjorn.
- moved DT patch having OPP table to the last 'Patch 8'.
- did multiple small changes and cleanup suggested by Krzysztof in v4.

v3[3] -> v4:
- dropped 'patch 1' from v3 which returns 'struct tegra_bpmp *'.
- added 'patch 1 & 2' to get bpmp ref using 'nvidia,bpmp' property.
- dropped 'patch 10 & 11' from v3 and added those changes in 'patch 3'.
- added static to prototype of 'tegra_cpufreq_init_cpufreq_table()' to
  fix the warning reported by 'kernel test robot'.

v2[2] -> v3:
- in 'patch 7', set 'icc_dram_bw_scaling' to false if set_opp call failed
  to avoid flooding of uart with 'Failed to set bw' messages.
- added 'patch 10' to handle if the bpmp-fw is old and not support bwmgr mrq.
- added 'patch 11' to fix interconnect registration in tegra186-emc.
  ref patch link in linux next:
  [https://lore.kernel.org/all/20230306075651.2449-21-johan+linaro@kernel.org/]

v1[1] -> v2:
- moved BW setting to tegra234_mc_icc_set() from EMC driver.
- moved sw clients to the 'tegra_mc_clients' table.
- point 'node->data' to the entry within 'tegra_mc_clients'.
- removed 'struct tegra_icc_node' and get client info using 'node->data'.
- changed error handling in and around tegra_emc_interconnect_init().
- moved 'tegra-icc.h' from 'include/soc/tegra' to 'include/linux'.
- added interconnect support to PCIE driver in 'Patch 9'.
- merged 'Patch 9 & 10' from [1] to get num_channels and use.
- merged 'Patch 2 & 3' from [1] to add ISO and NISO clients.
- added 'Acked-by' of Krzysztof from 'Patch 05/10' of [1].
- Removed 'Patch 7' from [1] as that is merged now.

Sumit Gupta (8):
  memory: tegra: add interconnect support for DRAM scaling in Tegra234
  memory: tegra: add mc clients for Tegra234
  memory: tegra: add software mc clients in Tegra234
  dt-bindings: tegra: add icc ids for dummy MC clients
  memory: tegra: make cpu cluster bw request a multiple of mc channels
  cpufreq: tegra194: add OPP support and set bandwidth
  PCI: tegra194: add interconnect support in Tegra234
  arm64: tegra: Add cpu OPP tables and interconnects property

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 276 ++++++++++
 drivers/cpufreq/tegra194-cpufreq.c         | 156 +++++-
 drivers/memory/tegra/mc.c                  |  24 +
 drivers/memory/tegra/mc.h                  |   1 +
 drivers/memory/tegra/tegra186-emc.c        | 130 +++++
 drivers/memory/tegra/tegra234.c            | 595 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c |  44 +-
 include/dt-bindings/memory/tegra234-mc.h   |   5 +
 include/linux/tegra-icc.h                  |  65 +++
 include/soc/tegra/mc.h                     |   8 +
 10 files changed, 1282 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/tegra-icc.h

[1] https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230220140559.28289-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20230320182441.11904-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20230327161426.32639-1-sumitg@nvidia.com/

-- 
2.17.1

