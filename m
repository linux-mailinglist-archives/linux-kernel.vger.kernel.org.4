Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB96A6E59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCAO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCAO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:26:15 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B239211F6;
        Wed,  1 Mar 2023 06:26:11 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AXfEW018556;
        Wed, 1 Mar 2023 05:11:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=fG0iZ5BMv90Ts8iEkPl0EXZ6iwuYU+tfmWRPVVMod90=;
 b=X1aETLAh1O9DhvJTFvhsVCMz9yrSiLEASF2e11KE88C5eRASwxUIJobQXTSy9nQarOoR
 TnM2dd02YShaSoLSsgyBtyhcfRB5dolv8i1VStlfabMGMeboFNAWMa4wyP+k58J9J1ph
 VhUp7mxcMhloJ6pW/RzE3SuhZnjFo1FDKOftECUXBia8pWMIye+BPvTla7CUKgwWq8V2
 gd9rL0wKVnfPHrWiFshq4dwoDKpJYWjDRtAOVMMh9Ito0fVd4T2hIV3kRV2Rtyqzy6uu
 g1A6EOPYIvRu8eezTewPAP+TPP/UoGpPITKMFv+27knE6VP/qkQl9rR7MqNUkLPKexKX Ow== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3p25280kxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:11:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzDNI7c2A4AbVFjCmtgBlj1ODxMDMgjZ9dC3yNrLZ8U9tHzESVpf4ZBNv8+e2BFix/ABTzcJ5U5g3ITvsj1OCjh6PnvSMGU/5RUejze56AWhme0/aEcsf+fg5QbhjpTCkxZlpGvb0WsWhNBS/xh+G57F71UpnI8PdoO1qo5bk2OLBhy07kbW6DE8epDePLTL1gpDljWW2BxL+xLN+RlCsOfq4wZ4BZSGiSqumbjimSSTT3GPx+KlZTqgWphYaY9HyfirgS5urXRXU68yL0BtIpTEqt7EC3IfPZDuOK62Hr+ZKrs32JOLGxsc89Wjk7cGAaTbHzuSZrUARgQinDimwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG0iZ5BMv90Ts8iEkPl0EXZ6iwuYU+tfmWRPVVMod90=;
 b=fDsPXy2G2TeqqdqUEcN3e69uChJxP74KA3D3mhDtK076RQd8Now6igFqSSey45K/fLBA2UiEYxXipxcxJdaw/oxgM+eUd5kGDqjKL4yTbcudyQpQxdzzR7UgBJ+0C3WUbzPy+Ugri2oNimYUOLCi0aD9azc9lR3en1DMlrjtzdyH8oK3bCgzh4p2Vj3NkZYW0bq68zKHO+ILWvD+kTYfQ2sWh2TqthkWnm37CWluQEOgqWIN0wq67WBzgc4NM4uFpIXMkhuB0d1CgNgmEKLMjTgjmeYFx0dtVt148ReGjj0oEnyM3z4JyG3SsGzGnvkzQrWJr/rEvzBDG/1AkBb6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG0iZ5BMv90Ts8iEkPl0EXZ6iwuYU+tfmWRPVVMod90=;
 b=k8IpLYPUIhagwh9iHNd049A+d1agp+MkbnWRqSGHAa2StCtQEoqwA+f+uZI7TRnp18rioHDHJ/9HLE58lS7PatFjR/9mq2fWLil3NWY/7DYMidg21HPXHkEjFMdk+zl9u1dj/CGIRcMQol9gnHgBSmuijAXJ0AFd7yOej9FET/M=
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by SN6PR07MB8206.namprd07.prod.outlook.com (2603:10b6:805:e8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Wed, 1 Mar
 2023 13:11:33 +0000
Received: from BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::c4) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 13:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT062.mail.protection.outlook.com (10.13.183.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 13:11:32 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTih021365
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 05:11:31 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Mar 2023 14:11:29 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 1 Mar 2023 14:11:29 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTCp006160;
        Wed, 1 Mar 2023 14:11:29 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 321DBTdF006154;
        Wed, 1 Mar 2023 14:11:29 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH 3/7] dt-bindings: phy: cadence-torrent: Add bindings to support dual input reference clock configurations
Date:   Wed, 1 Mar 2023 14:11:21 +0100
Message-ID: <20230301131125.6084-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230301131125.6084-1-sjakhade@cadence.com>
References: <20230301131125.6084-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT062:EE_|SN6PR07MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b14cbee-fc35-4852-e9e4-08db1a567a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drGmVgeYlvKBn0LqWAGYl8n7xWX7OxgdK+tpyBSv4tU8SkTiZjEV9/yIrNFQUnHBVqQCjz+UfD2sHJwsuQJ1brMKxtNLXgA1KA1RPuDX9PFujGSWFqJsD14u9Wsi6DSbzHJ2b4x6XKjKLT96nR2o5hNE6zGFo1ASBaGv430v8Q9+BUnHC9vpXy1bqzBQAJdpMJPEbF9cZ/LmkLPM/rB1gKQCUFRiSXkHet9LMqWsOQhBiGidyLDi73p7Xx2/osvTaUQdZcXa9gwrK0uGgu+5u+LVgDYp3I2LkKNohihVhZ+gSwVYibBmb64+4FfY2nk+HM6A1cRWMI8cjrRFFOIS5Q3DZfBOGDziv6PgJ5MZ4n+KhtHsrEF0a8KfkDFK0TNJeUJnpfkEciHKMGiF3/dIy6m8lAieKeBJr5S+6w4wqAkyZe7U6oCgUTMWUWKTUogy4WCGtm+gK2M0MsSZAJ5IdpGAdOUNiM9b2k4RUx/NY4Jnvii6gbeGhjyaIBIdTA0GdLmAEIylIjou7LWcIxzWr8SnKtr/ivQ1Og7sAE5eZTovg56vMCU2BUIJdfrxJOMU7goKmN2VQcCRF4mXUTsfXuzigNrbBdbnKCrd5422KzesP3yJTH4JmLPLJEAuDmbrKbfmuLH8deiiQLiRxPzNkqYrD25caNCyx+vDCeQKUN0IAqMST/rZK4XXQrtU8XY5wvcfdRl7ZfNFefFEGZ3uYg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(451199018)(46966006)(40470700004)(36840700001)(478600001)(8936002)(5660300002)(110136005)(186003)(54906003)(2906002)(4326008)(70586007)(70206006)(41300700001)(42186006)(8676002)(316002)(40460700003)(6666004)(40480700001)(2616005)(1076003)(26005)(336012)(36756003)(356005)(47076005)(426003)(36860700001)(82310400005)(82740400003)(7636003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:11:32.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b14cbee-fc35-4852-e9e4-08db1a567a7b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB8206
X-Proofpoint-GUID: Wp0-dJHUBjasDIgbs-c34d6EGqNb8wqU
X-Proofpoint-ORIG-GUID: Wp0-dJHUBjasDIgbs-c34d6EGqNb8wqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_09,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent(SD0801) PHY supports one external and one internal reference
clocks. Update bindings to support dual reference clock multilink
configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 2ad1faadda2a..711097e167bc 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -32,17 +32,34 @@ properties:
     const: 1
 
   clocks:
-    minItems: 1
-    maxItems: 2
-    description:
-      PHY reference clock for 1 item. Must contain an entry in clock-names.
-      Optional Parent to enable output reference clock.
+    anyOf:
+      - items:
+          - description: PHY input reference clock. Must contain an entry in clock-names.
+      - items:
+          - description: PHY input reference clock. Must contain an entry in clock-names.
+          - description: Optional Parent to enable output reference clock.
+      - items:
+          - description: PHY input reference clock. Must contain an entry in clock-names.
+          - description: Second optional input reference clock. Must contain an entry in clock-names.
+      - items:
+          - description: PHY input reference clock. Must contain an entry in clock-names.
+          - description: Second optional input reference clock. Must contain an entry in clock-names.
+          - description: Optional Parent to enable output reference clock.
 
   clock-names:
-    minItems: 1
-    items:
-      - const: refclk
-      - const: phy_en_refclk
+    oneOf:
+      - items:
+          - const: refclk
+      - items:
+          - const: refclk
+          - const: phy_en_refclk
+      - items:
+          - const: refclk
+          - const: refclk1
+      - items:
+          - const: refclk
+          - const: refclk1
+          - const: phy_en_refclk
 
   assigned-clocks:
     maxItems: 3
-- 
2.34.1

