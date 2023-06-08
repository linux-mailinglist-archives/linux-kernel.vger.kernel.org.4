Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C248C72822A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjFHOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjFHOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:04:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8A26AD;
        Thu,  8 Jun 2023 07:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiiKFQK9YSr3pSeEZBQsHnVBPFhJdjLwl2P+FbFpVIu1XGDtcPch67zoQKAD+zi4sScggbsDEq6YJ1ETX73PcBBMyr0xnJOWZBp74D+BTyCAiAbXlfDiZf2FhuUDKMlgz9dMYW4ejZKI/0Zck7D3Pze9UfpkYD1PPCrraGiBG72H+i+N0I6Sno6Psz1+zizNFDVoqanywfi+1AkRkQPxfjthZqeIMA53CQx4zIcU0i0HkvYCKz2QGACcUzCRUMSQb0oaVK0DXxftha8bTLCA5E5CdFcIpZADlWUpc18ov1128yWr19Un480BJfYWf6CNuJUbIfch1R3x4z0y8nRWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNpCk+dbJNxNFV6UGlMSXJ/kvKEA5QGb3zKA01v36mE=;
 b=TurjQFaILe7xNmNbBWdCHbUFhMVaFCgfVSoS3ikXid39ulSEJimKI70i+Rajl2kE8DOSaiNIJXRBwAIWQvJNBxpioSRurgpJVmtUagX2HAzZgRnBeHn0KTwwiXsiO/KK8d2G181bieMPfCy4yaUizYVHg7iNwD9f47YUV5uamvB/wZMdVAx+oCIwJMTTOuTQ5d1RfoSA5+paJakfYZsVFJIornqj6XjNH9lhNCFOebpy/AenxAGCy1gIslcUWFuV8OK5UQb2yrlkDSkgH173amMVNcgPYcQQKnZ6wOEWw8VUm2WMZqWFUurhKepuotefVNDJns+3LORNwO9xEhvFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNpCk+dbJNxNFV6UGlMSXJ/kvKEA5QGb3zKA01v36mE=;
 b=f/lMDK/d7hoZCZWRD32ftA2i6n2O8zGnZ3C+aczvvoIlMi0Hn6dJW68BzxbLUJePc5KOyPwf+OsRhkmdI9q7xyqVtjV8XgNKK5v/nqYHmAEw5ALxKsC9l08P5rZAHIxz/YoUQNNlcqBq1/yZHN2IYSPWPd4vDGuB+PTNyrYkzuY=
Received: from CYZPR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:8b::10)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.39; Thu, 8 Jun 2023 14:04:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::be) by CYZPR12CA0018.outlook.office365.com
 (2603:10b6:930:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 14:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 14:04:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 09:04:15 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: trivial-devices: Add infineon,irps5401
Date:   Thu, 8 Jun 2023 16:04:12 +0200
Message-ID: <9673fc919c6785879975fb1830d5026d3cfa658a.1686233049.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=michal.simek@amd.com; h=from:subject:message-id; bh=wMMdfURyRBjvTyMMtlEylJxnVFkvHQvLFIR8p5JOUqM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTG+7fcr7sxN8yIzH35wc/jpMtZj8PfHKoO8f/3E4xae XR/YA13RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIyUcM81M96tKZT/w/Y/BC 2kLbs9gzM+V8DVD0bctGpU+P+Ssr0t9++nzVLOXiQgYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5632e4ce-f56b-446d-f08b-08db68293fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsWw+beaP1MD5nkjiYMM0D/kQI73j30dVu6WcIREWALYKhCOYNh5rAkm2wB0hTEp0TpS6IGOr9kC7gkbmE/yVQwVlC5e2TBocT1xLsEZ3qDoYTWQ8X7yBYmaFL1ztFfawPIf1GM5Xih1tWcPhtBgvDcyc7SUhXetvYOrNnndWdP4Y13Me38t/2sM0poKQn0tCwgt96Yg6qu/LCKfH+QzvDGXosE/5SSVahmQeA/JtssVmK1CH92qFqgqifqLA5yCwW96DyOdc2/qMTVGYHC8X8+8M9685PfnH7GWhM02UA2M9CHC/BHAbgDyIgpjbD23m8L8vqx2JRvfAwyvQN1n7e82DV3xXIDcVT2NVpZqah1B9wRY0itOewuo0y9WPBjnJd+l3RFWdlYezoScdHE5AIqn+ZZoj96gB2Q+z4nHGDNg1AEDD45bFjw9cwu5qJYBRGSCn6boHWMFJ7BkRXn7TdnDUBAIOVIPu+vQMcPSBv8VIc/BdNMSbEo7qbW5XirlcU79N8UUkWZCDdCZnEmHjlrPLCbpct2XQnmIPNXxt3SBLIAisft8yy7SrH3yLxSVYJPMVxnKzIzsUmzJHYJdVkn/pH/HC3E1phtTN1eRbH2p7gIqF6yiGE3JJpfyjNjftzwBypcLExKnswtL1t8YS3Ak/iakc5jos9emNATNgZBFavNsV7NeohyjTvnU1EpcV3n2ENT3FOhua1zDHIU3vqlBoTTtE3fAGL0N0rLGUA9NQ3rbLzCVxQ/4d67BhNGt7sJN44pwlXIhv+BNUeko4PmgbvEi4qC8iNBlqvHRVEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(16526019)(26005)(186003)(2616005)(336012)(426003)(7416002)(47076005)(36756003)(6666004)(82310400005)(36860700001)(2906002)(4744005)(8676002)(8936002)(54906003)(82740400003)(44832011)(110136005)(40480700001)(478600001)(5660300002)(4326008)(86362001)(40460700003)(316002)(41300700001)(356005)(81166007)(70586007)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:04:17.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5632e4ce-f56b-446d-f08b-08db68293fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Infineon IRPS5401 power supply to trivial devices. Driver has been
added long time ago by commit 9158411b96b1 ("hwmon: (pmbus) Add Infineon
IRPS5401 driver").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 246863a9bc7e..ba2bfb547909 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -139,6 +139,8 @@ properties:
           - infineon,ir38164
             # Infineon IR38263 Voltage Regulator
           - infineon,ir38263
+            # Infineon IRPS5401 Voltage Regulator (PMIC)
+          - infineon,irps5401
             # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-- 
2.36.1

