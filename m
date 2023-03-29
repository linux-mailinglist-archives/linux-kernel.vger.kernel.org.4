Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570626CF022
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjC2RGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjC2RGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:22 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB45FFA;
        Wed, 29 Mar 2023 10:06:14 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TFaeEG012335;
        Wed, 29 Mar 2023 10:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=pHBbCEQ35Z3hqzq6rR+0wAZddGNT1gCfBlArFS93UzI=;
 b=vYpgVVAw6m8SmQJSazl/ue4nKj8mHw+59+sTdrm+zWygc5yO2HNdVA+/BzoZQjt4Y+13
 EZlGrGrrqmNW+h33+SiV+XxNyTDbQ86tFL2juwiI6/n1+s8kcPw7o920wPCSw8lwyxG/
 5J82RYqbYx1/FlK4KxrkShiZeQxnPe4iAk3n2aoI5fgsjL+ntaJs7hi1LwITB1LlpNSH
 KSjnDVwWoQC0lsnW1zJvI0CHUyEyKRLaY5zVSHfz8101/RTp2TkoLesKCIVUL5vLSPx5
 XO/p12GaK1M1HYWs2qx/vj5Bd/tbvlchsfg/8DvdfG9//rrbC1cld/QSmaR/b56mttuT jg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3phxs8yahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:44:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj62Z3nQG88P9twctq+cPZ/ykCUe3MwdjJYdFv98DQ5PUEEzugUs0fZhGnMY28QksGRMA/aP5/eLnlu0srIrcqrIn2wU/LrDBdT3DOuQtA4HU/vmTypH5qqVsLnNseDFZd+BGarnOZ76+G2tj8aksPWFPO+kL3T2GKqRqkLBDHigNGWV/9tgVwg2+5LJ3XV5OHiUmPSZvWrL7THnAjOER1l5BkLKRSroJ8H8QvOp4qBOZ0+QW2cJ1zJShUhQEZK3P9JF8W//82jgbN5Af5c2xkD0o5vRT0iSMXiEDXT1cESWBvyFUYhLZpYON5+lTOXc39ID6TQ9DfTpR5/OpSOJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHBbCEQ35Z3hqzq6rR+0wAZddGNT1gCfBlArFS93UzI=;
 b=GlotXl0p8MFfpW034ACXuYY59oseQ4HXulO4/sDUk02pHr8hpi4I9mswuvI7njU4IdN11AW+Ue7jDRHPQEL8Pvdnlb/pnRkhqL65uSYTETz5zQjPMY+YOGtqWz6CCu1FAil2aFUi4utuVCerhJzWMhPkyDZut80TnBA3zaSVYKJkYO8j+Jd/CRbFMpUkP1EX8foQS2JTX+nVQvIAJlNdsPxvEsgFDXBjnJWYS/FUP/iDEfV9TudGyFwEeOtSgWKMRBeekFRd8uzTJEkelrKODwfi2Y9fIl3g36UP8h6c/ZPCnVc/lRZvnnEAHVMoSm567cj8r2NvDBopa+WirYEFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHBbCEQ35Z3hqzq6rR+0wAZddGNT1gCfBlArFS93UzI=;
 b=MxrDXhPsLyMhDimLqrLUBIqFtndOIJJXDxloDQxDD8K5HTtkkvGfUgQ52DvvLAcy731VM/5IlnkNzhMwh61MSqsQCkz4MSQX8Yg7WtaZbHGZti81ZrunZQWivTtHZaM7LdL5gJ4ubeHZI0qtz2vF0+RKLzKll2JzWdc+JbTs1WE=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM8PR04MB8021.namprd04.prod.outlook.com (2603:10b6:8:f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Wed, 29 Mar 2023 15:44:08 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%6]) with mapi id 15.20.6222.029; Wed, 29 Mar 2023
 15:44:08 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty-next 1/2] dt-bindings: serial: ni,ni16650: add bindings
Date:   Wed, 29 Mar 2023 10:42:34 -0500
Message-Id: <20230329154235.615349-2-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329154235.615349-1-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:806:126::31) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: e32df9ae-e968-4d92-6fda-08db306c6ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcu3zqUmA/4CU4Nkb3pKm/9NsgjIgQmuLF/ycN9UkbyH7EoGDZvjf7OREaN/o6BOmlpDj6yK6aIKvMzIQJMUIsIwwYfkDZx0YRX0h8D4B1lJAwdGRLTM0WR0+KvtbfmomHEvaaxXdr6Q1j9iT6SNz+D67LJ2Ed1HfHFHoGWq3KsqNXJquv5D2a5JUMZ/XvNHDspRpGAwISIvKqbwjpMDQbW2iGB3ezf+gPQBTawHcdJCiNxhLlQE88jc2lg1rhUbiJYI7KP/E6kUWh14CpC0dQc8qUYWl+oOLQ00U0TTZIlsUmlypVXNbah5E2dt0KbtgaQuD72tD+4OujB+qKphjxDg57mpK7Zsnzax5nwhA/aGfkWBsRDXs6+X/3qpiMBvoeM56CvLroCKaRmPzRDf76G0oERQZ8DbIJI758R16tsDcRZ8IclHCAYkmd2XdIPZ17bJpck4xVlkHC1zAUXA9yZUrp2/7Z1nbUyWoDWeZ6I3h92dvxS8vORCITv77YfYalSsAkb5ZLhAHogcarZIKgwdYoZ0pbSvVhotN8GZQ01VkjwPA3ArUGGurrzQmk8GlLTTmGGMfSd0c+ZNNjAEMc5G13XUJEg2P5e+XZJ6Q7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(109986019)(2906002)(2616005)(83380400001)(6512007)(8676002)(66946007)(66476007)(4326008)(966005)(66556008)(478600001)(54906003)(1076003)(316002)(26005)(6506007)(186003)(6666004)(44832011)(36756003)(38100700002)(86362001)(41300700001)(5660300002)(6486002)(8936002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Axq5lgHywNFFBQDoDavRCmfMUnp1MakbaotiyfkN5ygAtS2PsRJkNwf/zd2F?=
 =?us-ascii?Q?RxCSdugstpFNw/O+hUblWzM1ygSJ+bko0qA/6N0IGtEhVZOMaxFIbRFtoOyL?=
 =?us-ascii?Q?loOYNMVwULwv2z+Z5THU82Vpgl+BbOttwac707h8QPMQQL785y173Vk7cDcH?=
 =?us-ascii?Q?XmM3G2/bVmD3Sggj8fYlTiXfIeWWAMx3hSf3PVorVnZ7wwfncoUKOzm5i4wj?=
 =?us-ascii?Q?ehBMYhoOYKWA1Pz4S4456XCXUOToYJ7nWEb6mScABgz6H0Ge5KMOmz3HQfbX?=
 =?us-ascii?Q?1agthLWNzWJbFl9XmCGvuxrXVjs2+Mh5Yf6zj2kd/wmEmKSHQmekxEYvF1ZX?=
 =?us-ascii?Q?eZYiMoKkLjWuA6kbTUvW6/F7kQV8cB3gbp7zjrGJLhqVCyOWy9EFN6/ppvp3?=
 =?us-ascii?Q?Y96OLWWqt1nb86QS4EG9vbbA0aQ6MCF1zlZQyIzYJTHHalkvtzKOnYO3H/uZ?=
 =?us-ascii?Q?afYaXyk+QaNs2g9hdDPyavTSev9BSQDeHhoSg7oJyk2EXDQCa6oA5Oq6JOkl?=
 =?us-ascii?Q?JviJziq54Hcx0sdfvMGVDNjtKc4uIVEtP1ZhR/P0H6Y9qDs63WWXmSrvScD+?=
 =?us-ascii?Q?/UJlIFses/uMaHdYa0ZcnAOkRFi0pfB/cfN2O/J9519r8TC1PGSFq9xqE93k?=
 =?us-ascii?Q?Q/dz1dCJVpyxysU0s2tp52LJ7PFhC35GLVQ446BzXP+SqYekkkgcg5LxFX6h?=
 =?us-ascii?Q?VKCGKTTT9leZ3mDhe0Bavn6BPHxyfYXzHOysgRr+uK3TrI4hLcr3z08ixnGv?=
 =?us-ascii?Q?fVQHj/DSw8T/s+no7lUPtfLREsUo+R5YiQpqj8dPUR83X4ul25ppt+sVW6oj?=
 =?us-ascii?Q?frG0Y4jJzJOaJXqIVwrIrj3MmrJNt8Mo8M3SIwl2IwWX0Vs+XaJhQRpgLdx1?=
 =?us-ascii?Q?uef7a3i0cpIC1HLNbVJcfgTg4A0RTukF35PRj7leEXg+uoOvdhp/S6hja1z0?=
 =?us-ascii?Q?Nx9oqk6RSw6g3JjAuXwY6rrlcS2n2v9/VMuft7ucMDYdNawuWhX37ETeYZ4i?=
 =?us-ascii?Q?LJquI1tEpR1Tydg7xta2fKRr2zwWHQXkntzc6mY6V4Pvl7arQQKeZ8kP5jU+?=
 =?us-ascii?Q?mS7dLaJy2X3QRpSHeeQkbwrpEK9WLMNVSeLGnpUGbaLMriwkXpYdkld115Wa?=
 =?us-ascii?Q?nLIPLQ/jc4JHqabbV4Y54EzwvaTC48xneM3xxkZ7TPT0MTB4TXpk9k+Fr9gt?=
 =?us-ascii?Q?Q9iGJnZgF1D0sXi4w3AirYJ+RJyGrFGHTje7SbHfTcWxp0K0FCC0AST7JXIo?=
 =?us-ascii?Q?RllmYUDiKW0BbRA5Wo8m+49253IKL3eXzouL0IzGGlURmjMUsZj4RDGoH9Du?=
 =?us-ascii?Q?w+SsljhELcCBs+4/A9aBFH01FnkxNSjNiCiOh4Ygl/EfCJXERvCmSyCPYYSB?=
 =?us-ascii?Q?loHkxPHo5372ggxC17GdOcNGXE5mf31ndIdLnfhN11YhD92MihIGtdSg2ZFi?=
 =?us-ascii?Q?rh3o6FbEawPDCBfQ1jLh3LkW8URUHN/qHnIxEv3ozrYM2z7gXZOsxd2oH0R7?=
 =?us-ascii?Q?b3FM7R9QpxUg/cxHnYFQmInH9xy1HL9t3hylawGY+Y2A+IpS7SxtdooizCwo?=
 =?us-ascii?Q?6f5iv9bt8KRRVkM6+hTB8taQxZygV0hn+fVChg5H?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32df9ae-e968-4d92-6fda-08db306c6ed9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:44:07.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upK4q7Uv/ejfgVM9NLpC/PjrgX4PE3+0PTb5cuDQDn/0bgTZ8RzxMsxDpBtyHTig90IgFtFpOz0/Hu3Eit8/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8021
X-Proofpoint-GUID: y9xPdJW1tz398KOKYdsEfnvtd1e_JyaE
X-Proofpoint-ORIG-GUID: y9xPdJW1tz398KOKYdsEfnvtd1e_JyaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_09,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290124
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
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
 .../bindings/serial/ni,ni16550.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml

diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
new file mode 100644
index 000000000000..4ac1c96726f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
@@ -0,0 +1,53 @@
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
+    items:
+      - enum:
+          - ni,ni16550
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+  transceiver:
+    items:
+      - enum:
+          - RS-232
+          - RS-485
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
+      serial@80000000 {
+        compatible = "ni,ni16550", "ns16550a";
+        reg = <0x80000000 0x8>;
+        interrupts = <0 30 4>;
+        clock-frequency = <58824000>;
+        transceiver = "RS-485";
+      };
+
+...
-- 
2.30.2

