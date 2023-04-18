Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F616E6FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDRWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjDRWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:48:12 -0400
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B840EE;
        Tue, 18 Apr 2023 15:48:09 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIkpQl011018;
        Tue, 18 Apr 2023 17:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=H8quVE2PlIiIVz4NJq4t/xu7XTAaIdYUoo9K+fkSw3I=;
 b=lVgmRGG5bSBF13QwPwHoWZxoEJ1lZaRkLks1twmKGLKxgB4d79Cd0vvkPeT6r3NTwI2Q
 9ulZZNwFS8hFBEmWTSHrwtU5mAX1ulutpNkFQIVBuE14SOZVZBD4JNiuSKPUycrfQ4vC
 py0lhUwDm1HgL4HA3ScaSOYbhfaMhOngzPYouOJL+D1jxph4AO/5+sP2fDWkK2cFDFQa
 catRJMHU4F32uFEPxDw/Y+UHcZvDgNUldzoPuRB/0BPKb9u3PmmUu/8Zb9gDyMAjIPnJ
 Y0v+qpANri3dSJ/tQ19qOI+SN3Kn94hnVXc7qB7pQkIJWCupAip6MCEwQ4Zrci293jfe 8A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pyr0eq17h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:47:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDM7pKw4Y3IikWxITPN+Z/1+IelWP+uw9PlV+OmL/Jq5oKxOCO2hlf3Oszl/muPOS3nxFy8mrR4NxaK8IEXhPUjOALEy3SM23z5yaJHHUv31+0rZsQp0hOJMpaV1ie1ZLU08ioeYoARApCqkA9hg61Ny1867C4tXRsQmx4mo3Bv+/Wkt1ErKKnOkGcDUAKI/dAActKNRnXnPvCawSvjrv50pAyCWecC8E5BGHDAw1ZWRcEHtIokm0iOGND54pBcDjlephyhrlo3PudfkSE53WZYMXaju9gydf+xPCXOFNmDmCu8ZarKjq3Y+Qs8HFmMdsCRP08eY9SHZ+OrNpasbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8quVE2PlIiIVz4NJq4t/xu7XTAaIdYUoo9K+fkSw3I=;
 b=Q4w9LiE5JPrrQyaoMnd1wr0L0AVYwVx8HGgYp2b2fxUqheBCSTg/UDbPMCD+1ldTMzVjDbfn7fn8E7fLbTpXhVcP+UDnZaHzileKXmjPFK6zDYKO9K4FZ1sF+LIdOZjXm591aa5xWTPo+c5LuZokJkSmgcRFjhVWKrU4Flmr6xhjD7KLdOFQSV5iojqLAKp6S+tRaM5OeBOYNlJQTBvkHjWDtCarjtUXFXlice9PfeuztZXXGcgvlqHHsq9Q9EOTycNrrPsRcTm080j2hDVw7h53T+SZK1AT0hrc0ty5gNjKBGOlBVHUp+QmVnpSkpLS1uBfQq0b6/Zv/eD7UelZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8quVE2PlIiIVz4NJq4t/xu7XTAaIdYUoo9K+fkSw3I=;
 b=p6mvED1ZmfTasM3AWCtPG6WZ+e5jwCUBBStY2MpIyemM5YVUKUqNrvFTgOgH8VPEagKAwfSYmTI3Jhv8p7FqtmctM07ZA5P9PR6UAVkai5k1JG8QSiTGMTRrM+EZejhGqHvpBhSTioqEO/KjZvTf7wvhcci4P3Qa5LfkSDECOSM=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM6PR04MB6761.namprd04.prod.outlook.com (2603:10b6:5:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 22:47:53 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 22:47:53 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 tty-next 1/2] dt-bindings: serial: ni,ni16650: add bindings
Date:   Tue, 18 Apr 2023 17:37:59 -0500
Message-Id: <20230418223800.284601-2-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418223800.284601-1-brenda.streiff@ni.com>
References: <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230418223800.284601-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::14) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM6PR04MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf31bfd-e630-4186-b2b8-08db405ef1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RixgoiWgipk+3zmJV37NZGcyaL6r/tqQJQ+/yNIzpaw5Sp3tK4q8n2WSS3zGsjaqUyBWs/ukz0JO6NT+BEtLqtlTjGSyLuD+TE0wXajM/JOI/SYctDhdflJKM3OCKBGGlP+taNi7tkQL8sKBPJWuOuZrbtK871RZQ6FUWG0KMVljESzPBKLxQ9G4obmmS748hthILGxhBaTKwKaYeii0SqBvd7us359E9XZcxkhMKzvtN89AolMw815d4st7n05uoSBjtvVAoKaXUSYF4iqnasepWgmHLQmocAAvjHYwimLEjCrgLitVeFbpQ8zdc2sU8mhh2jCHfkhv7pXLD7Gfa0/js3X4hTJq7y1RNaurtM9Ty3Gd/0AieEAFn6tjaYOK4ITyxVoZykyF8td5dNLMbg3pnTvuWVcOhXtUP0Lm5WwfWNLbPr59SzmnX7xN3N7bhiE7YJdQbe16vZgcmKHOd7vx1XBv7+3ZEvC6Z8cmwD3Q9SozCIHvGyzbss44FrhAwo+f/h69ETRKqF0sqyW2BS3a3T82fFuAosqyz1jAUZK0VNwGHpAd7uAlP8ZRVbjpapsNkY1FtHWm07OhE36AHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(109986019)(451199021)(44832011)(36756003)(2906002)(5660300002)(8936002)(8676002)(41300700001)(86362001)(38100700002)(478600001)(2616005)(26005)(1076003)(6506007)(6512007)(54906003)(186003)(966005)(6486002)(4326008)(66476007)(66556008)(66946007)(83380400001)(316002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYM+/hmxt+EJfssIl2dLtudDfELZt7+w0ki3jhyhg0eogJ/6av/nhu1mdbjb?=
 =?us-ascii?Q?2a18G0e97+ykogqcFIStV47Tr32M1kxZAFDsO/Nvj3t5zb/Ceor9LKwsP+zq?=
 =?us-ascii?Q?6jPLIEKaTVUYGrvIYo0BIOFbPsgQSMVWkdv7GmXI3rKmepy5brZGUmMBQ3Qc?=
 =?us-ascii?Q?YLSrcz1+U/AdVHcrkqbb+ZwB9phirsOSZ2gryDtnZvdx7gyAT4IDS/XQRXar?=
 =?us-ascii?Q?aEWaTzF+0ago+xLvEUYadcc8MHOW7kkfD+q+2d7Pq5eUO1P+cIkgLKBx7bXL?=
 =?us-ascii?Q?5YzQyn833Y/mRs7kPzbDlwrwY0FmHpvTMue7YCbHHJeoV/gaPJ0c6y/h4W0r?=
 =?us-ascii?Q?DoRODPncRxogUU1NBZppr9f4HJOJHMAFC3UUO1WozlTVhshHTvsVgAL+8H01?=
 =?us-ascii?Q?MUxr++OFPdESt4ZOvnIk4kdIgmN9uyluE6CiNdKhrQas1bOA9ETaUpNHtEOq?=
 =?us-ascii?Q?5uJPI8+ViZ6b8M7LEUMt4zw/Qu0wrZvpbun7mXtX4v1kEAlHyEJihX5b1uh4?=
 =?us-ascii?Q?/tnigmvv8YY5TH/li4zNTojN3mYsh6qycgEHtZ+gzarYTHnRwhX5Ms2u4JP5?=
 =?us-ascii?Q?JLwZyQFmcdlmRNyB2dpXeolBGC1HckO28hbtrIM6v2X/BrH+BiOPZYLlaHZ1?=
 =?us-ascii?Q?iIVv1uEK3jJMpDYrFEGDhxIso5U/MA6CHfDPP7MRBWnx9D4ICHrhAZMBaVob?=
 =?us-ascii?Q?ggSEYYEvuHAwI5qjVCRaTw7RV2YdIcM/aLB2D68qUugC2CEcuLhfHcHHlkUw?=
 =?us-ascii?Q?rWw6hiwoEdP1e+FPwid8606lG59RSnRl1SqNnoDRzk7dgE8UnW9Hwh+lNBSe?=
 =?us-ascii?Q?Si6+tYAToqdZ2U/ZwvjIPkXsA6/k5z35dlxtzv8BuYWk+x+nCiegc4bPMDTr?=
 =?us-ascii?Q?7RwD+EWpAchtUAEhHdYfhAimNCWSYv+InllgzqBT/bziBOGTm8v0f0IQcPyu?=
 =?us-ascii?Q?LwYHk6iJ0F7iqgNvNtU6kvY54e2Rn05U9lLYX1wYxZp25w7WQQcbOAGyyaSN?=
 =?us-ascii?Q?UAfP0zRDWqtLveAJg5Z7lXB4kafZeVmkK9fgeUBNayjkiBByH/810Xdt4cDA?=
 =?us-ascii?Q?G/Q2s8/NbKaxmUgm+9M05yG9ZBVS56XX79Agy6wdJKzT1a21D03GJZOeGFA4?=
 =?us-ascii?Q?PBeTfVl0oHmXsN87g7g2oukLntSOORXramV3FXzs3dQZQBxOxh/VwMvWurLH?=
 =?us-ascii?Q?ypBnaKyGAkYKL8TJB60ZNo8mPoJwqmcslIWc5f8yAOMcE3lPKK3wYPhzWxfq?=
 =?us-ascii?Q?8pGiIJ8aDWeD53HyNnAmCAvE7pFYq8sV/IfQyxpUwEggusCcc3hgu70/NScc?=
 =?us-ascii?Q?Dt547bQL57zgseHhk4LekfWufC17YqF40F70GBFLbCC7PYxXnoVRgUP6PUHy?=
 =?us-ascii?Q?b4RRnV5BE9MRLVWdcmn+klX0u40ebw0ObAoSEJRoGuepX8mdZl0To6xbrTPZ?=
 =?us-ascii?Q?ySrmCob4tW3Gi9JVzxm6jlXvXYHDLfmN1F0+RPsUUPv9a2BT9k4RY/yrp2ky?=
 =?us-ascii?Q?M9b9lm19ZVFcAH9bT7FLIFEl5MHvHZMYS1F/VwpHHyiJpjEsOZkf4vr3ba4N?=
 =?us-ascii?Q?T8rI40Uc7xt39kz+fA0lI05SQFfGRRynmjOv8kqR?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf31bfd-e630-4186-b2b8-08db405ef1be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 22:47:53.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9al+yS7MdN0NQENspWq4o05s17BNV5kdjSukUNk9XPHEiMNeaWxE43W8+cpSjkrBiGx6h/BPeA70X/GC5q2C+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6761
X-Proofpoint-ORIG-GUID: ledOvnFxX3jfVhGRB5MNZ3gqondKakDH
X-Proofpoint-GUID: ledOvnFxX3jfVhGRB5MNZ3gqondKakDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the NI 16550 UART.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Jason Smith <jason.smith@ni.com>
---
 .../bindings/serial/ni,ni16550.yaml           | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml

diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
new file mode 100644
index 000000000000..93b88c8206b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ni,ni16550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NI 16550 asynchronous serial interface (UART)
+
+maintainers:
+  - Brenda Streiff <brenda.streiff@ni.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: ni,ni16550
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: baudclk
+
+  # legacy clock property; prefer 'clocks' instead
+  clock-frequency: true
+
+  ni,serial-port-mode:
+    description: Indicates whether this is an RS-232 or RS-485 serial port.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ RS-232, RS-485 ]
+    default: RS-485
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@80000000 {
+      compatible = "ni,ni16550";
+      reg = <0x80000000 0x8>;
+      interrupts = <0 30 4>;
+      clock-names = "baudclk";
+      clocks = <&clk_uart>;
+      ni,serial-port-mode = "RS-232";
+    };
+
+    clk_uart: clock {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <58824000>;
+    };
+...
-- 
2.30.2

