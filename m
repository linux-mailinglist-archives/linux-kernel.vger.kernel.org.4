Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED6600FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJQNEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiJQNDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:03:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25DF60C93;
        Mon, 17 Oct 2022 06:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM3rkVB/RduLreSC3pvuEV51XDKUCbeR1mwk3UmKNs1wwwEj/aJ7Lv+Cy77RsuLe3G7Epga3uqx9ujkdgXzHHh+EDLCd2++IajqZqAVujhM7UAdpSusJ8lAe+5N7CaLOBtKCms4mXXbhUq9daa9rI5d3AK9dCQnhcyBBv0yGo+oZlf+TutK8NjexPeBCDy9G75zHb8hGwOe/JurQu/b7/Oip0kVnG00i8SjePIM4GTrsEfd8qw8/jW1L4TckS7Wvrdnxjy9TkRsAHlLVoXhZshKLuGFfLfHF9GM1F05vZVr+RP7M8u9pvVOtiDHuAXwYNchWjIq8Qm+CyWU8KUbUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwP30XUWAOZT98GWjg+FuivSVd4+VlNTLagEUqNyoU4=;
 b=eoLxf+vSsC3VMVGPapQSyIlC+jJa41FF1Er5DMxdIvQ0FJ9n6lk3Gj/YnCw3AN83qJqgER1PAUHmYE88RDT04vALmWtknoP1vsseCeG3XJrqZ8VB/HmrqgDrRP9VQPXp4PHWt0hKcpcFg64ZVUbole9+Lm1A4tASzdKJwY5dI5qmNXMh36adDhexsKPtQ9m5RoX3gVCwUdkP73axy88htt7nxOShJMlUYg1bCr+uTgO0Ocpr698TdKYrodl0Uj1hNMNCy8xhSEcZJL+dRp1R/QQ7g2trbS0LzkFpbJ/s+WZIdMjhfRo+cZaq7KQwiD5QtI3zMFD2PLS51yuAvfpwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwP30XUWAOZT98GWjg+FuivSVd4+VlNTLagEUqNyoU4=;
 b=wcU+/zJy+Q3FKh+43vho/bwGGxoX/eQbaWe2lxM5yQPK/XQkAMbGlAzNOC+dJdul29O+aNEAZVnaHnlVrTbz+WTwsJxKZ4L449z5onBXfypHJY+hW3Ca2qomAn5F+GuQYS5LBtD/ZxazcWsYLAzCBt8NveO0dky3tWkZ/faLIIc=
Received: from BN0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:408:e5::20)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 13:03:16 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::59) by BN0PR02CA0045.outlook.office365.com
 (2603:10b6:408:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 13:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 13:03:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 08:03:10 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 17 Oct 2022 08:03:08 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and bias-high-impedance support
Date:   Mon, 17 Oct 2022 18:33:01 +0530
Message-ID: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b46b53-9963-46fe-f0c8-08dab03ff498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rod8LzJqEE4PxOxTlV9435NuthVl+EOKTqRmrD3nXiIUxL4DHrImDpWVT+6DZ204VScNVKj9VETQVi2dleiT4a3lgFJ3OO9Kl1uPADb3ECMDPZxCSdbNuBUGdUDl6h0KB+SibTWOQ/ShY97k+6i1XSHWe1KHsSZCvfrofG5TnRkdSzEM0fS0TnNxKlDo0jNjeajWJuOxuOWQcyBWKG4e+7lAU1JP3xkdbYnM8Qva2GCaBWWmHsvL2jAsASbF5k/3Vt39Bn2YldFvcVEmRQRG2otA7EUJO4/KjvwSgCkeDqBy42zP8w9hvVeEE8kdM9m5qUwRD46sYO2CmN1gRR1KQ/WkpQTuC00tl7C/KIUkqISijPsyjhr05JstySL/Um+wHmAiWsIJnm6TKVsh8/gORiRLfDQ/wm1Ed+HQcHaTpqaICmEoxuz7kAZ4zITQy+E75qiSegchxSBmqyhvaxJBkV62rAliaxn+N9cYbeDaDCNyASaZLGjWnWvbj8Rc/CiMvIVh6UOKyTpgU43civQX0YyGQaahEvkPjWLSnAo09/1M8Her+WuNbu+LHYUqo8/JddZV3KfGEcjEICzgJ9AkD8rJed/acAS4trnmc4s6Jq7FL6//K0GCt2WxjBLzrMipRpbdypt3f3IU9g1FwBQ5gvFaFsZqD6pBBURSOhAy5ctaB8sFfexhrBwG1+us4b4gKZ9tj0O5RQVuAVRCzu0aK4Tg1+F+jHm2FcTjrZv9xsKbNw7Ke7I9eWnuyNC9jI/mtKfwGyo8hnOpTY/0s0PX3/SYzm93ZiSEwrBa+p7u78L0uhRVlbxdSVpWGVrwTugf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(82310400005)(82740400003)(81166007)(356005)(36756003)(40480700001)(86362001)(103116003)(40460700003)(36860700001)(83380400001)(6666004)(70586007)(70206006)(26005)(8676002)(316002)(54906003)(110136005)(4744005)(5660300002)(4326008)(186003)(1076003)(2906002)(336012)(2616005)(8936002)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 13:03:15.9126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b46b53-9963-46fe-f0c8-08dab03ff498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
X-Spam-Status: No, score=0.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having support for output-enable and bias-high-impedance properties
causing system hang with older Xilinx ZynqMP Platform Management Firmware
because there is missing autodetection feature.
When this feature is implemented, support for these two properties should
bring back.

changes in v2:
-> Added stable tree tag in 1/2 and 2/2 patches.

Sai Krishna Potthuri (2):
  Revert "pinctrl: pinctrl-zynqmp: Add support for output-enable and
    bias-high-impedance"
  Revert "dt-bindings: pinctrl-zynqmp: Add output-enable configuration"

 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml | 4 ----
 drivers/pinctrl/pinctrl-zynqmp.c                         | 9 ---------
 2 files changed, 13 deletions(-)

-- 
2.17.1

