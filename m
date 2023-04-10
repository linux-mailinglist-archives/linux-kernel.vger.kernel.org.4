Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7B6DCCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDJVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:13:14 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFC1FF7;
        Mon, 10 Apr 2023 14:13:12 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACLOOq016428;
        Mon, 10 Apr 2023 16:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=7FaA3T7W4cHCuW6L2AKIdZVcasMKV8Jn8TK6xA9JmQc=;
 b=LjVizq7miyWZIDkhd3PZYMtckZqp9RMJ1c2muXV7CvYg3YWJuepRMXJIxKnnS4mIa9ML
 nXqc0iGsVh38YexY6+63mWGHDz9QUpdgT9UEkcq14WSgLPbSi99ST2rSzUC0M/U8jYzH
 R/hFlvgBv4q4qRk26joUoSaVpFfpQqdLQIJ7DJGfjtdiN4yXVHMClNohQCJUDi0h8n9l
 8jZAzX3BZyKqK4dKhn/JO8Cr9sqRSshTkHFc3haGyRdV86TG1CkGekOKF85UKCZ/R1Tj
 xregkV/5mLMPLgcYuwvjWvK1ZvE29QvaEXN2O5+YjvG8vMKVmFpJDb4cQ2TZxvIXltUs gw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3pu5sxbauv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:13:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdZfZ529qhM2OgMRhwKZOgG6Q//1UKUL8jbJO7+86pZCOkhFc1OqHvSqjbsQJDflvYFeGXfIT49VTmp2idV9YdEuXO64tRquCZRHjuYdNHM1zNQXT962080tUJvL/o8QcyXe8grKuWEqNjiX/JZjLOl4hMJ+laL8sL1Rtpt3pqiS2GPfloG+q2NKAW426XDTsQf+SsOnBD3LE2rv6AfrMrdi44HJtIWXPtMazx+vpBjcs0a94OYRUkM1lbv+teLdzM62xeF73/QLuXkv5gQfzgUAPtj6n+oBSGCEB1YzVkXDQGcxdHdRWaJr2dE66Al5sOhneanCyYAcfR5gq5CMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FaA3T7W4cHCuW6L2AKIdZVcasMKV8Jn8TK6xA9JmQc=;
 b=CMBDa9wst1+s4re5qhD1I7RVoCYCUr4Uax867OfqY0PdoHfIPMlOcGzYuHdIj3HDuHexAa56lG+XIqUFPg7wgT3cKNJf6m2WoCo8I0rG+rlOHNI/PXEyAOsVSpHOuCU8XEbmHrPzSEntTVJn8sLOsFhNkuv4KZOjGzVbxgkcN+UgwaIzHwmsyQL+OhBQ9Y7LaCL1oU0kSFaXBgTn5XFHVQxdG3BhUSFXA3IwUJt7iQPz0B2sQpu4xxuBWi1NczbEsQRUZ7+GjY2fXu/tjr/vVBDLEshL5N33WEWbEChHbkq+6Soagtx2EHgNPOpZTWFcfQxqM6pZB7v2GgwIlpuplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FaA3T7W4cHCuW6L2AKIdZVcasMKV8Jn8TK6xA9JmQc=;
 b=tG+EA63ucQ6LzSGW2/K8y5zaV2LaBw35Lm73paKEPWu1sIC+JoKUPIdVWiR95XE3MgJVjztUkbZ7jlJgp2vSWN8gKDL7m0ln1FtgREXQ40Fah8lpFQoqtvy/kp/bkXGylgvyivRjARHjzQfQcSpojLg/t1lvx7gCZl4r/CxDdrs=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB8568.namprd04.prod.outlook.com (2603:10b6:a03:4e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 21:12:51 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.033; Mon, 10 Apr 2023
 21:12:51 +0000
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
Subject: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add bindings
Date:   Mon, 10 Apr 2023 16:11:50 -0500
Message-Id: <20230410211152.94332-2-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410211152.94332-1-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: c8412334-d0fd-4ea0-ac9b-08db3a08580e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zestLGv5euAJgFktAsRzdj1pwZZ3SXH3PBWUicpJG0ZJvQtT5QXjeJOgcrTY1dUJAdhtzmUcm6/H/g6fojRFDFhWkZsXfDRNk8DuX8KIKcUH2kBBtYXFwAT05WsHZdmLIXG/eE6zp+xhSspEQFEpH5wocBIoAaM+cYMfyyBWBQu7tZDzZ+N8k4w0RbRj0GPXnbRCJq94If9LauMQjsMQupqhc2YDT4EZbTpKjoZy6dSuZjnpouBR/5oho5RPvvuFxiV09SuhUf0grdLahJ4Rjf+4l1fOtPe8nl4icdIrExoexAiR51sND2PCNjXpwTxVVnaNQRYOb9uWOLGLfPIz+z5P4/iMO/jRsajylHu1GWZzA1IpiWnddvnbb7WQs9AKzseyFtZYNXLllThXbesPWrNm9sMRYs/li2e53PbJEN2eFva3poeczwiB595PW9ofCndTaR6uxJbYBX71pnRYri0OtiYp+o7/cozxPkRLBLHr0X+e7A5Cj9/b5bGQXP2aRhJw2zj6GdMo8zwhV7Lro0RxkImSZmHhBeYRt5Xy6RPs7rEau+yuuXWG+3F/v7G87r9oO94DxRTUzVmF/FeqQ49D39tnV1L1gqLvFztjpk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(109986019)(451199021)(83380400001)(66476007)(66556008)(38100700002)(8676002)(66946007)(4326008)(5660300002)(2616005)(44832011)(8936002)(2906002)(41300700001)(54906003)(86362001)(26005)(186003)(316002)(36756003)(478600001)(1076003)(966005)(6486002)(6506007)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2A8tij2zHV8Ugt0eWpo8Zk2At7pqCApZCmGnTr0NOBNAWnpK/mhtwOpaHL6K?=
 =?us-ascii?Q?0/4eA7ERbqo0szDbH93V56DODRBqbzxwymqaRRCk4AWG4U8urKRtcVodGDBb?=
 =?us-ascii?Q?MwVz1ap9lWFl/7rV1RNu8oDxRQZasshGlIdP1VTRRWwmaHlT8BHgo7gQPfJV?=
 =?us-ascii?Q?IrxuAMZWqiMFjgdyLdHfb93iYYyqhmXgkN2ezGfqqacg9Hl7KnDaG0BWdqx2?=
 =?us-ascii?Q?rCxOLfsVnyKM43FHfM70IGJkR0LH4mc+9Mw60MA7U8owh93rtZsEjSlxiJ81?=
 =?us-ascii?Q?635d0peCNpDrDcrZKbuaUExrGSTa3COozupC60/Cnt4kBpZHhW0ly8FZFcYQ?=
 =?us-ascii?Q?IuyXK06L0R5zZK6cGnGvb7NHgW7BD4wVEhsNqYuPFtnaDbJWjQPo1q9VPUX5?=
 =?us-ascii?Q?vFvK4eUkzhL+Lr29OAGynaKe61CsUKOwol3tUtUR44+61y+8I3cPrwijHlVm?=
 =?us-ascii?Q?B9zPjK7p4bpQWe4xLqNreuFlNZ5OVifQRZWyv8wiFUanQJphPZfCn26Gwd2E?=
 =?us-ascii?Q?KDJASR2+LvNpmmUfCKizRZOUotoxtGgGjS7Frd750o45Yux0lQwwlY+WCc5B?=
 =?us-ascii?Q?UoLc1G6yT+UtwMIayBh/aAH6F/p+Kd0bPvM+NSytthJAXIE48xhBGFY6x4dm?=
 =?us-ascii?Q?mmYOq4ssF57T+LocYwQ/OY5b73oLU6i4q7Z+B5kTHDNB4IXBr7e0FgnKXPKW?=
 =?us-ascii?Q?mG+fCtjH4RvjWx6BkjyzMUFW54vecj57+DSaJUFV2YwXAOwd8qn1uWkvRBf5?=
 =?us-ascii?Q?XOwy/tfTizhovPhq4aGKrtGXcc0WQm/XOxmwVpN0MA3F6zeUJw5vO1xKEaGw?=
 =?us-ascii?Q?n6b7WkhUyUFlYI1MNft3urUXKrGaFFqo4zzyjEgS4m7eZ29xNp9od/hxd1F/?=
 =?us-ascii?Q?FdZ879uTp5yX+h9ax/G0CcsSTO52/WA0gmM0gLFEADycA0Z2EZrKE+jCHNuz?=
 =?us-ascii?Q?qQs06/ptLt0wb/82k4fJOi/pxEe0YopVJO51Dko/07ZXT9dSCBQj2dd+GnG4?=
 =?us-ascii?Q?X6ysbBjkmlvPLnci+YrsKt+rCr1vJp0I6kfgKkDo+9bG16bdBJ/6L+q27Psh?=
 =?us-ascii?Q?EeSckuBapB9olV5JR5sKfns8yjGkDsNi4PV9/bWPhj1kZCTDv5k4b/N7tiLY?=
 =?us-ascii?Q?bgOVq+eOpjYewKLnBdJuMI9KC7yV0FMpQFRvw9dPg7I2KTVxQ1z7Y2GHvIKa?=
 =?us-ascii?Q?FkgLjm5blptQssOyKcuFAanlxzLBpF9lVEemOhy1hvN7JC6XQCf5RZ3edxlg?=
 =?us-ascii?Q?R/HXhbfWxe2npB9pPpA5YZqqbTu6eK6hbj5Ha0SFPvv9HRS520QO8xVlKR/l?=
 =?us-ascii?Q?UPeSN8je7mTnOo7KyVCDKLIEfSizXzO0iW5ja1OVjcIsSD026L2KgHTmO7vk?=
 =?us-ascii?Q?W3NizVjUhI3+WXBXb3Q5eQPNNgttihNpo+ynxW92R8/AV9hrX+I56yLYIvmA?=
 =?us-ascii?Q?xIVBTFNzANnzsSXGi8S78YqP3gYulD4khMaz9ln9UFILLHbweL+B+31E7Foh?=
 =?us-ascii?Q?jbzRuDTQ+/Ndcr034IV9XOdRBWqbRmaZh6lTLvBw3++XVfPhocFZ9nZDTT2M?=
 =?us-ascii?Q?BmcGry1Ei/g8ocNcSyCfT/N4WMoXbhyLIOUKfIlD?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8412334-d0fd-4ea0-ac9b-08db3a08580e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:12:51.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzihi3MIcOEWPRc4CFFGFvxdtoku11pUmpdm12dpUNIqlr7a3XK1cieZov63gt+T3FAqZU9jExW3hlNVneJtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8568
X-Proofpoint-ORIG-GUID: Qg2Q5G23Kq5Msd-sCoaqAfYelC5y0Uc6
X-Proofpoint-GUID: Qg2Q5G23Kq5Msd-sCoaqAfYelC5y0Uc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_15,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304100184
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 000000000000..13928e89f5aa
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
+  - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@80000000 {
+      compatible = "ni,ni16550";
+      reg = <0x80000000 0x8>;
+      interrupts = <0 30 4>;
+      clock-frequency = <58824000>;
+      ni,serial-port-mode = "RS-232";
+    };
+
+...
-- 
2.30.2

