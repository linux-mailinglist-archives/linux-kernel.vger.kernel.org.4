Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA15B2EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIIGTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiIIGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:19:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1231839F;
        Thu,  8 Sep 2022 23:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgVt/aFDGrQWaAE3cTMlBQqB7ti0/DMsNTDNJ2Pp5px7MMNNFDWtaTxcS6ujfviUXMK4C4+PnlwQFlzheys97KaNsnCtoWp1W/PLU1M5KeV2H9svRZI1k7g0m8h+RMUwF34ehukh1ztiANgkty6aje8vfPgr38npQIXypiVBUf1uSUQn6xezC1Wc5fX5LchBukffMcR3wLu21GdlvPmqfQlXZj+K74CZSeG+5OOirHO8+ErKKB5SxCVts/Gq1FoSASx+SrIvha7KnkjeoqgzL+bUQTPBJGCNNFpOjn74gbrQ6P5i6M0JqURFFcAZ4EncCzjGbQpv8vTYSIfFpxhSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3TF0emoDtd+u+PCHrd5p1zvlWOnt0vIURh6Rkq1OGk=;
 b=HBpibZwy6RI7CEaaqcvaBlLvZY91wpxU4bVXhL6lz5ytMX2KmtnzRNFbQ341iB3+DJOwMWWz8jz3Jv1FyZ6OGmBhRvD2use3x618rzOOMV0CnIoA20gDvax+79VhYAF1Qhb/wWL2jIoGFhntXTkMCZJ/fTYUMs7fXjxqn4fe2vTtJjaWW92YJcBRmyDcsr+XHHOcI1M1m+NOFQJLP+9bjGI21pMJDTntw9998laGWzUtmM8kADpnYR/BPSySv+CqTQbW25zZjLGH2qUn59sWZxN2oIJYzej+GdiUVeZUJ4Fc90/vHk+GDGv85yuOczNX4qdny++5PIf7xLC0jGEcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3TF0emoDtd+u+PCHrd5p1zvlWOnt0vIURh6Rkq1OGk=;
 b=0KqWrF9Wq/6jMRA0oz2kf/toxZelILd/rc+GhVJry6OCIGB5bbqasy86QIci3oWzr8H7iObQcQmOaTbyn7fk3yjVC7c682GdsQCpnz4uhjZW4jr/jMV6zsnnL+AyzSeuxf8046wStEuYJqmZSSaV+25ikDFSbgBmbiIrFD2g7xM=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Fri, 9 Sep
 2022 06:19:33 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::a3) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Fri, 9 Sep 2022 06:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:19:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:19:31 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Fri, 9 Sep 2022 11:49:15 +0530
Message-ID: <20220909061916.2935431-4-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: ba83f51f-ec8b-4591-10c2-08da922b42ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlgAQWoIH/vFmqlvMkdQ3Ah5iH9HPcWDM6B34SlBiWhG+CS98VivgtFRfbT4bRJDsNUVbccnfkIx6SqbLkt7iaKNy82RpYqpnUSBQbZXUFZH0U7OfA7KZrTnqL+zeHk2kvOFrsWraCCNwt42cdinoYRWyC+ssobwPQm0jACueUqQgZ839WQiQPL55JMicIS2dKc/7AaOB+liGMsWrKyCYOG17OVd+okczDrzHDZpH5g7PrCOO0A4G6NY/7d1LQP+8pNBUsEeJhKujFIiK3UU/4+iik0NdiUaW73MRMK0d9ArFEwK5yTY0VnelQeQhyXVybcb+3Rb2HqHpIT0jMG7hJEvV2g+WloIlSo03jVzlfZpqBZtr4e3dnuQh3oWuf8cByu9GiLy7AI99YW6ul62n7Dk0+2uLWNAAdqmUdWzfWmhNO8xGsrSrzatkvRMQFQOcmmF00a8Ivip0jlv2bTAcLB0PZ16Av2ZDj3EoLJevC9Kj0nQy7jnfloKlHzN2C1TqcLC+5iQOOCBdo/wlgkDCJXxYe/q0iChpg/VFV69REf6dvrh4aTDw1WL3s+wPYh55sEdN/w3SE1yRtQgf88NwvziNQQhMi5FcR3oM1P0MR8OCVIAvGbugHGL71i0JgLx87+3dBEB0KBLyIpkk0t7IqkWgqTc6h8qaUuSYXu2ZQ8hllBRXWKWSt6eI+Nd4ma4KFgQKwKwok2rjzigYBDIF/fVv7xeI7U/9Lb8X3tQ4IYMz1B/KRY9jKoKO97maixQNfOs3YNIMBb21YiGGt+H6KYP7fAwRRMke2KZ0MDpCZqyvbjSxnXSqdhKDYczqVjuYnJNGQmAtz2+sbly/LcfpCIlHNRY9efBONRG58Tysz4yfx1N85VO0FRm1ZLGmdXYZdUkVWSc0xlOD2jwCI8CEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(2616005)(70206006)(36860700001)(8676002)(82740400003)(81166007)(4326008)(356005)(70586007)(921005)(1076003)(426003)(186003)(16526019)(47076005)(966005)(41300700001)(336012)(478600001)(40460700003)(110136005)(6666004)(54906003)(8936002)(83380400001)(316002)(26005)(2906002)(82310400005)(36756003)(5660300002)(86362001)(103116003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:19:32.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba83f51f-ec8b-4591-10c2-08da922b42ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) Inject core provides functional fault
injection by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection and fault
recovery logic is working properly.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as suggested
by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..1b6020e4ec27
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Triple Modular Redundancy(TMR) Inject IP
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Inject core provides functional fault
+  injection by changing selected MicroBlaze instructions, which provides the
+  possibility to verify that the TMR subsystem error detection and fault
+  recovery logic is working properly.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-inject-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic:
+    minimum: 0
+    maximum: 255
+    description: |
+      Magic number, When configured it allows the controller to perform
+      recovery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic
+
+additionalProperties: false
+
+examples:
+  - |
+    fault-inject@44a30000 {
+        compatible = "xlnx,tmr-inject-1.0";
+        reg = <0x44a10000 0x10000>;
+        xlnx,magic = <0x46>;
+    };
-- 
2.25.1

