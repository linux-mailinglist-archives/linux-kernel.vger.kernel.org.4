Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D072C365
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjFLLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjFLLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:48:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417EC5263;
        Mon, 12 Jun 2023 04:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgZUbTInz/rNwStUWmM+E1KGKy1/uh1kbr46O4Ze6Sq9DZ2Z1ZwHkUCW9mJD+CGvCJaiDIA5X58ByTzpCZbOzi0s9lhTbZZvG/GOlLHTjqa12/Q41M+MliVyyO2JSHE2IZpz1B8oKxJBoBrgCZuLkggIt5q4OxaNEdzWyLL3N2vmSVocBlKCMLI+5ZcyP18OKYp0OgGflzY3BN162L/J4JRpA+CSvlPiJNcAOz7hYSW+RCOv1Rfp6fVTXZoqqi27WvEa7bOYBFil9EohTGeKifbWp9VC/PVN15un1b67yG4uZdW8mq4d7O3mXwNrFJtt/LGTxqAIK8fiLz39m5a0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tgFlz9wPvD0Z3LeqNNjgl6p19zjTkLUIAsRpTxsHPU=;
 b=dDapzJ0pZIQVHMM78XZMsmCKiNTpLgynEwrQwGPGhsSctEt/NY1bmI6uZ7n3XFHQAxChQas83ZwZkgBtRuPwLgQMPi6SsJn5jP5yFgTwBXJHqw5CGqtNMjO1G2fQlmTvzE4l47WGTmpMv2E5OmqOFwPdjZXSEW2zTIrgZMZKdNshe/WYQl306C2JtIWeQK/IHYN696AAtCd1V1u3x+F9xc9FTkSebZkmJbJUCnEJFlpGZwEUL5KXe+BKR0dXdQQc/dqaURo155FDfSam8jEymKvYiHjqoFc1DwhIFYfhE9JavHEgXKOKLQ9USKJzAN5PJepMkSJNLjt6okRcsHsqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tgFlz9wPvD0Z3LeqNNjgl6p19zjTkLUIAsRpTxsHPU=;
 b=Ia/eG+IBp/XdB8vUgC21BTfvXlBc2fPo8yvEftAVTlmK08YJA4DlFPx+SWBM7ra/VVsvwmNWNIBILTMyAZaStWO7ETwVeT2afjxQqXrbVT8Lf+XYoEd+NYgprWdKisIhSw3mZtycAAC7XARovtIUucTaLwpMuxCi3sT93cuRfro=
Received: from DM5PR08CA0029.namprd08.prod.outlook.com (2603:10b6:4:60::18) by
 DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Mon, 12 Jun 2023 11:43:03 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::e0) by DM5PR08CA0029.outlook.office365.com
 (2603:10b6:4:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.31 via Frontend Transport; Mon, 12 Jun 2023 11:43:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:43:02 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 06:42:59 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gcnu.goud@gmail.com>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 0/3] can: xilinx_can: Add ECC feature support
Date:   Mon, 12 Jun 2023 17:12:54 +0530
Message-ID: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff2fd19-ed16-4a3f-ff1f-08db6b3a2e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRRrwqm+bhJUvYAf6brgttc2P0m2hOVv8reVFRK4aREf/1C+2a/MlhupgT2WxAEZXsZap1JblS+Cqn9k9wLQ4Gpjkz+nLHSOEiJvUYGTGCGH/jdRk1254omiZFdDgCMgJnNlrYzgMlSEOzvs2zLVmSbDTCMECPPvUJqbGUOZN3U+rDyNn6cuM3JAYNVtc0Y/jUJ6egGeBe25v28YMipzKwmbOJmCGl9NfT9no0ZhBhOIOnXqsFjScXMZDs6rLxxfyotTejQXQDnvTXEML8LcJP3jJMUh5YJR2kTsPNNKlPs0x+ERmT8Hc1lN9eAoE0YeB7ld9YHh/fhBKAnXwkBWpAF65eWx9qci+GSzISsMo4Byrl+9C0NWk7VaKZefMSa70Fe+pDZlPYpThlo2sXZJiyupUHw4PZhTWeza3/kdJn/9R2qvG5WWl9UK2+9RdTZK4H1B7CMW49eJU+/03pwdn0T+bRtp9PuGP8jaJpLjH4IyqBJRZboAOMfYtPxh7zFv9MRxkIakoXTO2vu9HS/LCCKW47dJs1umW+abl/EBSKZLZ1ELB0UTrnnuw8qCf0PQflmw2nsjmp7QUO0XULOJJJDJY7QAm/d6H7X5tbIbV0N1yPdc1zVm4NKJHwJaNyHY0ZPn94XswxbnddkY+JqJKQUE4aSAs5E9Gp8RhOMfyatxukvMp3LFKj+WB+oja0Uty1d7eyYGqR0f391tjwnAU48SgibpgMN45ai9zDCXVnMqEDLlQfOuVvJWNtV96Kaft4O2YDkjrGZkueZ/sKZnRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(4744005)(2906002)(82310400005)(7416002)(44832011)(86362001)(40480700001)(47076005)(6666004)(5660300002)(186003)(36860700001)(83380400001)(336012)(40460700003)(26005)(426003)(81166007)(478600001)(82740400003)(356005)(54906003)(110136005)(316002)(4326008)(70206006)(2616005)(70586007)(41300700001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:43:03.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff2fd19-ed16-4a3f-ff1f-08db6b3a2e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
Part of this feature configuration and counter registers added 
in Xilinx CAN Controller for 1bit/2bit ECC errors count and reset.
Please find more details in PG096 v5.1 document.

xlnx,has-ecc is optional property and added to Xilinx CAN Controller 
node if ECC block enabled in the HW.

Driver reports 1bit/2bit ECC errors for FIFO's based on ECC error interrupts
and also create debugfs entry for reading all the ECC errors.


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add ECC property ‘xlnx,has-ecc’
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add debugfs support for ECC

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 169 ++++++++++++++++++++-
 2 files changed, 169 insertions(+), 5 deletions(-)

-- 
2.1.1

