Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9629C6F8B33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjEEVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjEEVkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:40:12 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02F54215;
        Fri,  5 May 2023 14:40:07 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345L1hls014213;
        Fri, 5 May 2023 16:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=g02wSVWQa2Lss9/7navPoilCy7jINaqYu+KLSXRctPM=;
 b=qcl6QHyppCNemtnsCSCdSAdwx5WMrRuIW9WWbiwRcQRFL/fsUBu9U8zmV/5VJQp9dtWT
 tVFooqJ1iLR9A/VHYaTu1ylNLlG6tCfc9FNX8doQ3r37JUM7eR3TaSPM5FuyEP4cS7Sl
 JXTCixEIOuPA3QO8C93NchKNCELUKiVbndqM9gXKxrFO01l9fOvare0qwFDSlQ/OHR86
 VSx5zjPuyDQF5no/47io2/Hca1l9wiXOGzgmTlZpA7W2wtjy7KSexI76bdrVOnU4e0sN
 6f98ZWQl7cmF/JtWLCrwZI5llOh3/xE3FvwWSlwt8K26d310Fs/o/G/lEC7zq8n93Jj0 Yg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3q90rwcv3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 16:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alTx9UzP6n3SWt7zv8kpCZIjghk2NWyRj0LEnGtXkHUgrHejyfKsncS6kZHDNqrvVZBG4jov2HVfoe1Os6UIGZXWAUitAT2JP+y1cVNEQ0s+zuiO641EOqfPx4M27825Ljv6iHXfkzsLTI9tO8HHGKTHxli4Ra+/qywlVPPrTFvFNF5L5FKzbsNtqKGz+JQy4l8tRBAiM0/O3puWBTKy48MGQI06SkgBCCwn7j82qVt9bRzO03lhilnUv+YGe2w+Lt9jFvGhr7yxd6t+OMvOndj2yhFZf8DDItbNbNenVYPWv5u5Rm2xvelQeEffFV3+x1uzQ/wagbgLWi44HJz3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g02wSVWQa2Lss9/7navPoilCy7jINaqYu+KLSXRctPM=;
 b=kHAWaJEZzbcUzF59WYJx6vgufUMIQSg+tW/UvFfeVsbSvvPIcQYVkmml4uzD3IW1LVJ+6X5P9KJ/g3GUFCk1N0uYYCeRvWzb+JZKKGUdNJdUcgZemtIfuj+pJj3arRJDY3Fp8wK/JxwR/DBIRNfHGC8IzxVO8yX7XytJdtyO6IC/fmMB8/9L+co8Z3/O7x4Fx3fRU9ueqYAXP06LJXgRV4i8ggLE/f1IXosGaHrCqkfV+sJckmtoye0ViEyyHjVWT6NkiV7SPQGkmM0vQA+EgiAbZ7NemJWXN+LCkRLErZq9vJyDfXkeeFz606jOuRjjEUf4DKLsAqEvEg1aZWSwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g02wSVWQa2Lss9/7navPoilCy7jINaqYu+KLSXRctPM=;
 b=FzKKiWIsp9VvPfrIrrQIxqmNLcg8ugZPwcz/cKwEihB+glRttGeCykdWF9/zyaujrFJ/dpHa9G/ca3LUwgzdIcWF8qzH85SmN7sSAkqhDUN5b/tvY2gSuW+AtEJ6TRjMoVtppjlbGsGonNsmkBfr/1Ic8QSyCwuMTj3DBcatlQY=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7341.namprd04.prod.outlook.com (2603:10b6:a03:29e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:39:22 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:39:22 +0000
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
Subject: [PATCH v4 tty-next 1/2] dt-bindings: serial: ni,ni16650: add bindings
Date:   Fri,  5 May 2023 16:38:49 -0500
Message-Id: <20230505213850.829639-2-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230505213850.829639-1-brenda.streiff@ni.com>
References: <20230505213850.829639-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec31c06-0017-46af-7769-08db4db13092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/+go8k1hhvgICOZ0AX55ctX19IcS/YSDrpBRHPaCz0bSYMrSohpuHVix6QA/O9pMdMDVsSzPeks8xXk5MCJIGwBCbo0+iV0NyM9vh8q783zMezQP4WXojLJ8yR/kxuBJvdShHRvlavxKDlY6xxpMXGXGkwCDhgFwM7YnbF9eBu7RQbeKtuZ08rFXnuHwlIMafCmBtNaiza9wy4ssO1+jzGo++wnsURZ7rGRtjUUjmrhiLe13YRRStC/k8UHfhvn54eHMlGNHXBMIshuerj0HLSHfXant3e/1Yg0nJsYAKKcMKlnYIKtk8nVhCBJ/6KwyojB1fopi5kFA0/P51xV8KZwNjn/UWIzdNRplKJYdJcdy8UiMvWVPb8RgGydsUKqh4kCVrPgivoIdNBaEJukonhulIYzNFiLNPQJwzsXqc/hgUwlcvGP1af1+U8dw1fBbAzcZ7PYE7+Hw7t90OOS2oNCnmg0HdDpt40AXK9S+jqRZ16LtQSxtMpc3ZzridZnZ5UjSp8Qq5tiRAqY8EdPftZIrWTqnnXCf3z6iEcHpadeF0n7U01kM5PuzB731ktJSrNk1RrIaQ+YX7oZ7RDaNrr8+u5YpkQLXMDaaiPlxpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(109986019)(451199021)(8936002)(8676002)(2906002)(478600001)(54906003)(5660300002)(41300700001)(44832011)(66476007)(66556008)(316002)(66946007)(4326008)(36756003)(6506007)(1076003)(186003)(26005)(83380400001)(6512007)(86362001)(2616005)(6666004)(6486002)(966005)(38100700002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5uIHVnnx5y40ZXa2nYNG6rAQKRZlWapv0XIZQHvh0gttYMH1uQ6CPDXmzS/I?=
 =?us-ascii?Q?dR/D7DivzF0fUcWs6tBf7c0ayHaPzyB2yj+/itK9g3rJ/yIcoPZoym75hDGh?=
 =?us-ascii?Q?vubfkR2y34i84j/GQK5HH4ezvw/p8ijZCrkQIdjNyKXmilW0GUr0OKoyUjN8?=
 =?us-ascii?Q?SAeoUdu+lJ3VFYtNNUytCAR+df1h4hb5AI1pXr5IcdTbCaKYqG9SSIV4VT7F?=
 =?us-ascii?Q?FerjrtX29t/zLr+sW5DJhP3LF6ruTmor7H9uGGDj+1gO43ahLtE6bKRd/0fC?=
 =?us-ascii?Q?e8bQNPAufh+e17854UdhANHomLV6QS1HSfM/hndhxkVTH5rzXXS9o5zOfRBJ?=
 =?us-ascii?Q?VXHAwTeHJQY+0BdGgI5R0QCr0aYgOsZKtW3W5n5QnM9Ebe7zZJtoFFr20BCn?=
 =?us-ascii?Q?R+bOtffTbSfL6qHNJJsveTIvcwq8IyvLLDKCYAaWsV9jabG21iVdHaJoDXOH?=
 =?us-ascii?Q?wWaEj0zRjPnbRGShyFNp9GO0jUi98g+fHjuYYH67szd/WGNJ0sIuqfHY2MTq?=
 =?us-ascii?Q?ojxRo2+Anvrf6IBaeUUYSCiNoROVvHUCcgP/1HLY0Emk/mltx0TG0s4NAw8o?=
 =?us-ascii?Q?Cw/ugelfGl4p4UteZoW+K4JbaltUld5VBZZ825bfgfb707mevJoYs/243iT7?=
 =?us-ascii?Q?Gmz+Wfy434TsC6M7yDoT9u/RHUe6B2qOMPGWC/0oVrBNMuPhaDtz5uAfmGp2?=
 =?us-ascii?Q?bbUeHTzyPS+NKhCqCHu2Do2J0g4mp/gxi6ue4N1kzqY2+VfXu835y67kqEDB?=
 =?us-ascii?Q?KZ4bDWXyqo69ocHDAlEZUrgrB/m5Gjp1ni0qQaf2t2f3p/KB48jicUXBlK7f?=
 =?us-ascii?Q?b36TRXiz93Jfxd4juZPwsMjpBtPSxYVBkNs0tl9JVU9SWVOzD+q4mlMTJFxB?=
 =?us-ascii?Q?C/00jOvJSGRjQDxaxTLQYhxqHPjPt9kQH0T+QQO22g7jMw46L+uU2yyyxlE1?=
 =?us-ascii?Q?7esM3Dd+LZYjLVhvjOlVAPprQRF+46AXeJ87Ih2X2XXm4DLYDaS+eBa6sU8K?=
 =?us-ascii?Q?uyXCWl0ajcb/vL9WbsKdqPkGQaYRZSu4xIcbJQw6/UlSLFfpuEZXh4alV/3W?=
 =?us-ascii?Q?LiwiwuL5bIQI0OTXuQ5mabu3/2i2ayXZg+iExPBvDXXix7HNPV64FxxreaaU?=
 =?us-ascii?Q?kWCQ9+P70+0+UZbKD+j849fhu0/KzKTGKZUI3vfg8NllIK4BGpyI6O/uf77D?=
 =?us-ascii?Q?rcBK27g0kXnDrVJgBDaHUD/68qj6X335UYzOtJ4ftY/37kKp/WVBgerbl3R1?=
 =?us-ascii?Q?RUss9AGZns80SpDbfPHgxEGye5Te7ZwQWlA142RIjMmHETHVIiag4G//oiDR?=
 =?us-ascii?Q?LeSk1angjRgXYnvSLNDGh3eelLRpzdyDsCRm7TxHuycU2UtYeAPUeSZRu2eZ?=
 =?us-ascii?Q?reBHIQZkRv2ycwJDtEH+Lrvb3Jledne0Y20KZ6nNm2qipnf7/tPbRNl07XZ0?=
 =?us-ascii?Q?Wkx5kQwZ30IOI7EoRfmGaXletn53s+JHX4353oeYeq+LtVmgSbhM7B4j2CFq?=
 =?us-ascii?Q?QGofDnXozBH3GmcAaPxgcGvzJgMNUOgeVEjOlbnrwylgcxtT1WVNKkC2yu2w?=
 =?us-ascii?Q?cpQreQ/hKwAUsBQuMxEzuujqOFEHqxWTbx/m6vpY?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec31c06-0017-46af-7769-08db4db13092
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:39:22.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QMebRduP5TpMHbEjsRW3H8h43TuWWp2wGJAZpDrxV1+N44M6TlXE/yH5FfOwCDfK/wkoiUEskhyQOa1XN5ecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7341
X-Proofpoint-GUID: oFtdw-ftDG3TrZXKQmMpH1ompFLYMaiX
X-Proofpoint-ORIG-GUID: oFtdw-ftDG3TrZXKQmMpH1ompFLYMaiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305050175
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../bindings/serial/ni,ni16550.yaml           | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml

diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
new file mode 100644
index 000000000000..72ab125dd892
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
@@ -0,0 +1,51 @@
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    serial@80000000 {
+      compatible = "ni,ni16550";
+      reg = <0x80000000 0x8>;
+      interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk_uart>;
+      ni,serial-port-mode = "RS-232";
+    };
+...
-- 
2.30.2

