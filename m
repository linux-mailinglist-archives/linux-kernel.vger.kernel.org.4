Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901CB6773FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjAWCN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWCNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:13:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17F126E3;
        Sun, 22 Jan 2023 18:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as2bSRFrlnAExdZV3kwx4WyLnomk/JJoFVHa9VrRwOwzCIYleNlqC11zokIMD5awm0ZiSeNFKuzjcuCrS/Kaj4ZEx4FcnBxw0Yb0ONg/DPW7AikPe1sV4bVqqjkmnek/amGOCbqnTeTJk0Nk1s98s7zDTcrsmj56Hyrxwy+31ZrjcBz+xBroMNRXs6yTOKNIv1GdfmxmMXdeOFnumVbPNoCBrRUPM5WXnrig39rl5Aez9CCzvGBOh7+VdaIm6mrPpL+gURA6Fz0gucTfrHLi7JuASlt3XinjrHVB83pViGmDacBId0Y7PS6KlN0f66rv2gU5oug1nArHVRE1YosYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9wVi6OLIVvD+pLHSOg5aEiIHjyHeyknly4jJyy+tjM=;
 b=Sqf6y0/x8GFoZ7Z1jzjDI8+/qb/BA6QrWxmxy3JLk1JHat1HCnmjJ7vvxp8tdUd4x5MdEtN2SMmipRB+h1DUvbrLIUuQvy7+acSOpjhxT4e+kZUZxNIT0xiQJHFocWQiHDNcFok03sjWOEyadMsqHgU6EFZpc2ayR8OUiQ+JbcXIbs6eFrLgKiX5X/uzyhkmjDQIaBmTbuPNdS1K9FA0ZBIJk1kUynP6HtShLss9xnUqx53o9juPdYylomD21CLOM4kGVaWf235t9xUW86vDhQP3WY005rA76uz1KHfdZrvc4NHn0DEyEDEHxi5/WgmkBQIWco4DYgqWXSf8K1+C0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9wVi6OLIVvD+pLHSOg5aEiIHjyHeyknly4jJyy+tjM=;
 b=lpgQQbWKHbKfoBa9Zy0ElKtssq62PYjpmB+NqIPgMVwstPAEvclt0fCHmljKWZvQAaj3WC4aTcqLkikwIeITmkDyvGMD2XLxOtuKQvFtodbYElzSYnB6lvIg+tT057zBHKQ4AgaqxvsWVMtzhtnqswUYBudDv/5vPZn8vhXMr4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 02:13:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%7]) with mapi id 15.20.6002.028; Mon, 23 Jan 2023
 02:13:47 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: ldb: Add i.MX93 LDB
Date:   Mon, 23 Jan 2023 10:14:48 +0800
Message-Id: <20230123021449.969243-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230123021449.969243-1-victor.liu@nxp.com>
References: <20230123021449.969243-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a7ec36-c352-4684-266b-08dafce775c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/SGZxzQ6/ymQqxCLtHxgnPn9owyuMN4kRdca6I1jLPZ069NQsmGA+jayNbuOvANhQWaT8/r3MSUvAYsBE7dklNTIEmM3hv0FmSFJLFkaDnRnxIyd7rH0NFcwmiXVR8xjrDnLLc+j2XMBW0kCV7CMzomZf2RlmxSXBHx6Plse6AJw8uCGBWi0e7rpK7sWb2E3dcx9Q5VKdqALGx7ckFSFN3iZ9KLXtA1k7FtBYkmhiKwxab6p9+DZ/MH/aAgz9xcUgQmSn3vAZDuFIVKpyCRG/kPwAMlZ9NibZqV4i8rd6P0p8hkMJH7FfrvW2rx92MTxxJF7p0irsefgAIwZoMnPl26qhy4kn1kgwiJViWrheyvJgMSWV5wdI4d2k2ZamEd8DadiXal0QNfNIOL55a3D6ynbkAVGtpMfdZyZSszETzZRwjESysSoYbgliPUK+g0xva7CcQ1QY17JyQwPIFcJRDiByrlyqGdWs1e1sVgWbDArhDao9GL3TwHZ1JLS44WXJ0iJlbG9f2vkO9QD4B5nk1ySnw65vZsT9peMjj+YKH6isoVV06hZc5AtZ0RWY5HKzxhT6uPdkP0zurWRCrk97oy80qopDVbaymrFX8UQJTsx1l32kiTcuuIRoxRE64ryE+cHPUtRTiDN2gSpj1ES3dsUlEBktXXs3huES/AJ82InJ0IxHbWO+3TYKhgoehoJcqz7rP8ZaMvbvl4r5/RBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(36756003)(2906002)(5660300002)(38100700002)(38350700002)(7416002)(8936002)(4326008)(41300700001)(83380400001)(52116002)(478600001)(6486002)(66476007)(86362001)(8676002)(26005)(6512007)(186003)(6506007)(316002)(2616005)(66946007)(1076003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iuu1dH+yslLjhEJuHUOyFO0AwrEZ738Gf9fbjWKcIubx+KX5QgaQNsum1nJK?=
 =?us-ascii?Q?vP00cCVqSMr+F02v/ByY0WvI/0S7tSO/1ib512+rbxrPBs9pBycrUCo0R7Vl?=
 =?us-ascii?Q?yXXVdIISMQO1bZvfLsHtaWdBsRqD41B2dtiG82ntd8DkQLE/KQKRjtAuAXni?=
 =?us-ascii?Q?RbgqclZpUDhhk7sD/VAK7bcZ/qispWVYBG0WX4GedjZ+UJKjkR1JLowPGBw0?=
 =?us-ascii?Q?yb023MuPTT5ydCSRHNWKyS5z9otQdzrrsUbLix5Bc8p1gaeRrOEGhvXbISze?=
 =?us-ascii?Q?qwy9Ympre/hfYVLpr23G4L8RUQTH5s9t1InCI37BhDqc8m0DqB2b5UUzlX3N?=
 =?us-ascii?Q?Uhka90GCH5VyP9FRceKgHvzizFLvr5KJRc2u0PBZUsEXVeXcp4hwr3MhpQB8?=
 =?us-ascii?Q?MypdvACExKXJ1fAJvcLsQSR/3NY5KjoCWykXoiWRuW5HzB0lzZq1gxBBMrXW?=
 =?us-ascii?Q?ulN6HpFN1ARBE3XiqzsLXyLZ2yaGT8H0P0zII7k3b2iKUaCbdoB2fJ7tNl/5?=
 =?us-ascii?Q?iDmlrPbcWpLEi5P6TDURckpSj0EiyhmXxJChP27iWnLkponLyeSvIle+MbbZ?=
 =?us-ascii?Q?VCJFbWMoBYjRp9fopCr3JnAnZ2wTFskMjIupd3Q5jOgV6fr9fOeL9M6T/HwL?=
 =?us-ascii?Q?pvqcXA8X9yPnqVbE1mqmlB3ozkNjNEEsk5el3GUHYBH+LOqP40vgsZMwTk3b?=
 =?us-ascii?Q?LxLmtnDQwLzS+HFcybmEw5vg2tWucKZPD/4GrNzjWn3fxcfQw3Karc8OmOKB?=
 =?us-ascii?Q?l0v1MPWZYc/+8vPEBtWdO6Q9GVadNZx8cUQmNegQtNs3aoAnIxIk02nZdJ+G?=
 =?us-ascii?Q?KYvrSrrv0prWKeblWJlv4c4P5WU/HVhPiAa5skui4RNJGFeV1Z77uUnStzAp?=
 =?us-ascii?Q?uIq355qNQcrzQLd3o0LrjDSWlqz4h/o3j7j1rsZNYNAI5DwQzsrTYYrKnXDE?=
 =?us-ascii?Q?myrR6rBuZMchixxj2uuZ/0pmdUjemeA9hUMR+J1yGJvQrAzIjRs8qnHZMKcg?=
 =?us-ascii?Q?Zrw4BzXlqO7HvuxfaO46R2rmjNzVfnhTbiy7cl7S6MjoE9BfkDaXxH3HTRiN?=
 =?us-ascii?Q?Bo4xL3X7BL0PthQOQ/P6++H5sP57zOu2x1lo1FtgzmVIMkZgTpYfcplw8D7R?=
 =?us-ascii?Q?5okH1Rqygc7AvEo4+r1MwWrv3hPQoHJFA+FEXORmTUnJatqbuQCOyQPtNrBy?=
 =?us-ascii?Q?lItoyZup1602cUfJ+ptyZi9Rzo/BVpkAi9Gxm6+UOJhzPtFNYJU5ctvT2izY?=
 =?us-ascii?Q?BzZdWAJtiIBLMyYFByEjWFcEdW/38UScHKcub4vDvhe8SsJb/p8dingaQLGe?=
 =?us-ascii?Q?1pXvSmIc2JrKXbN1NN78Wm8b/IssG2Vq0F9LXh3toB3i0lwuCKNnTSk9sw/T?=
 =?us-ascii?Q?0MkSzdA2ZUhBL9MYhm4kMbmdgJyBKX3XgV7eRFfNGJ7W5xJUven8P52Uhnqp?=
 =?us-ascii?Q?irXXE2t/wkxU9wjC/aoCWhEZBFVSiTdcRRCLKWPnAb1Y4cdfZbgCiEvOQD5Y?=
 =?us-ascii?Q?TPkYY/c05Kdiun8drvfXWYRy+nUPyAls1SJQefOQEGDS9p9IFsrsfaZ03lSv?=
 =?us-ascii?Q?Q8/II4Z9zrDNsRCvbMf0LTjuzd61kpGC0Jwaf5Ps?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a7ec36-c352-4684-266b-08dafce775c0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 02:13:47.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13KmkLpetWmnKZpOIU5BvFGBupi2OsgH8aNXPlqVy7Y4w2qIgt1FXz+i/YWtBHbrAh7ZC7ERL12SEWXclEbSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same to i.MX8mp LDB, i.MX93 LDB is controlled by mediamix blk-ctrl
through 'ldb' register and 'lvds' register.  Also, the 'ldb' clock
is required.  i.MX93 LDB supports only one LVDS channel(channel 0,
a.k.a, LVDS Channel-A in the device tree binding documentation), while
i.MX8mp LDB supports at most two.  Add i.MX93 LDB device tree binding
in the existing i.MX8mp LDB device tree binding documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* No change.

v1->v2:
* Drop redundant "device tree binding" from patch subject. (Krzysztof)
* Add Krzysztof's A-b tag.

 .../bindings/display/bridge/fsl,ldb.yaml         | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index b19be0804abe..6e0e3ba9b49e 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx8mp-ldb
+    enum:
+      - fsl,imx8mp-ldb
+      - fsl,imx93-ldb
 
   clocks:
     maxItems: 1
@@ -57,6 +59,18 @@ required:
   - clocks
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx93-ldb
+    then:
+      properties:
+        ports:
+          properties:
+            port@2: false
+
 additionalProperties: false
 
 examples:
-- 
2.37.1

