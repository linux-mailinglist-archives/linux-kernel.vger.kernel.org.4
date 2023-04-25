Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37D26EE15A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDYLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjDYLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:51:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B40E67;
        Tue, 25 Apr 2023 04:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G81srAa9KI0bfpApv2KdZdp/ywnf0gSoUsLNrm28YFYNVQgeNI48EsSVxsXB31v3XEGmipEwUZpSI3I0pVcX/uT6GRwJkJ6MZd+gUB59+1g3a34WBpsR6pFg782JSKKOK25azrbli0JgNTCtxRbVbz6filzjVuoCYPxLnSGzRrSodJxbsi6fP0Qhs/fV4ZKkCTTGG4kJBXVWfJJUwy4a84Lb0ae0ohm1vtwHApWrzEq/1u6syS/7QUZHkoOQPOaeWZB9IBnKdSEfCNkPmcz+MgxcFnD/+yj7YI88aaEB8dKM9EdQbeIw7eKn+36ZOpLGxWEWqnJ0T8F8Yk6B5CVNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFz/XN8Qi26KZcj4vHc+cQu0T0vJtwQjxfKmff/izPI=;
 b=TRkr6Si4L6vN7UFyE52t8YEOjHm+y3GGre0bcBcc5O6pTvlWRfjjjM7oLZg3wWdb1JNQw1aTxCHNQEM89xF6jFGngad7IvrxLTuLvimmxrdQX17PgXvVgaoTlOm4El/Bvt8WUUGS6IJaMRu6EUOb5iB+ouKVX1YCn/uI32LUGCPx+yZa01WcfP2MjexN055BCBQYO7IPFJ/qEfss87tYZlciQhpuqc1ovmGkt2V2USkwBqERpQyogFba/gK8ECRa9jlwy2dvZT0XUeYfuh+o5YaWnLGOwrJFN/Z7By5Ro/1MROQTEc+4Ucx0StBOL+q3j7aQBsg9UBNPd6XHOGQBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFz/XN8Qi26KZcj4vHc+cQu0T0vJtwQjxfKmff/izPI=;
 b=vn2AhAGlEEKulWAbf/6BW8hyOf7qM3jPguuupnfS3zgrfYd2A9Wyk7KiKmkEoFVXrRAD8I6Y4fKYc9hfTyiYF4y7EibOYkk5X0ZfzcBoNBNM7LuShx9GwiFnylv7SA1zNflXowo/QzMi+4QhV4MkX9JFSjmwFyB6kv3FfDKdYos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:51:24 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:51:24 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [RFC v1 4/4] dt-bindings: input: touchscreen: st1232: add virtual objects to the example
Date:   Tue, 25 Apr 2023 13:50:49 +0200
Message-Id: <20230425115049.870003-5-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: 32316544-6eb4-415d-6c3c-08db458364f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VyIEhjdcgMgX6qI32YYZ4AOxi/bTT6f3l12JKHNZasrjSxSVIeOwAFBm6EcvI9zPmZGjS6VzCra4pcm6NQPrt9OlJwpQSHGFAm3zPG4/1y3lcelX1IsKFwjDSyN6VE/apM0uEjmUX0IB47cJ2U6N+kYcUWSP0xgvJ0cSwYBvykFr0z3uAIhrjxrnKac0pIpV/b3U2eEzauJU06nAaaFlYP+LyPeDv+T9+EOI7kG58u3PaVlY7g0E3hQuHFLqoKAdoLBMzeb8uc5kY7pD74YZ/Gk7IoYKweoZzfwGqtanpjNBNuLvDLYn0Mqwy2YbA6zpDsNur6L+WttdHOZpYaO/GaOvQUbfZ/SOInJHrxhvlSSNDlBVT7LgUaU5SVLyt4QtIT4824FvReQohuqJt84M1HMYNMBSS6X5aA01p7ftnaVwdJ5oRxqEJwGmTqL0im6Zo28zgxSo8bvuJQ61Wv620hd09BFi96wudWSqlN7DEhNeBUw/EHZ68BJ/YwClH40SWBngAhlk2ew6uspEanR0MmHFjZGtVj6CWP508PePmOzS3tstMibkhoEG79ocVqQDVFy3BYMk/zz8uwf3D064jAo0inJJ8dsjJsMOAscin9yPpIDcPkvGDO6BNY7Ees9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(38350700002)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(7416002)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(1076003)(107886003)(52116002)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WG6dJEfoKblQDRKX507UYH/hwzaSDnDSf84/Wyn6+haoTsjA9uxmiRPlzl4R?=
 =?us-ascii?Q?jsCSu1Gm52MkciJTIMyeUhMP0HvnfaG8IIez4SeKOliXyGexPk6m2EE810jh?=
 =?us-ascii?Q?LrsNGVhwejJtvSWvehA7JVhpHoIij1hf6/I+BkHBP5YW9WtnxuCPMEexyjWx?=
 =?us-ascii?Q?CZ/YsD6VjCYMygR00GqnIja018WhhBLMRC5rLLo1vHXoF9k/ynzl5suDiiIk?=
 =?us-ascii?Q?Cvrst/N6nDvKz/9SF4Kw7JJPA9itGqh7xMHAvQmj4k8RRfbc0ibFspgNCqXx?=
 =?us-ascii?Q?NqlBV/YTjW3WEmO6nFm1GyQ8Vc/T2k7/j3bHoyAvSxfXDRLTo6hj5Sdik18a?=
 =?us-ascii?Q?iVlZrHef0LlRm+fCft+a/qbUZZQZsrF04Khv4qihmxoWXNM5gaugi7EVmEkA?=
 =?us-ascii?Q?F+dazNyX1vRndPjR+Tvyyonz+C7hOyryHF+k+kSaCts6T+t1hi73w3Wh1lE9?=
 =?us-ascii?Q?dWBkMa21fXCz00Oi54PKHtiNkBOflK5RH1IzgssCPnC/VdpZ/Ftr+plLmzpf?=
 =?us-ascii?Q?PQeU1StihWj3Wt3rOiHW1q46n+9J/PArfyp/FdlmcQvl44qF3JArJDaag+lc?=
 =?us-ascii?Q?swNiwAgUG/eVrCGpYbDOBv5h/uuu1UC2jXTL6hbJEH9Yl4hg/aBtHEZYKx7y?=
 =?us-ascii?Q?3GXkuOJed7FaEqWkjVCMBXvm3cwRXTLgMc86G3bwzuLOjmok/0UIXflzofm9?=
 =?us-ascii?Q?SHN2V6yuvz6WaU9hzUi9RIOP/ekOwRQzTbV/jJ1psIzgQ/0rkuyFDsd9u/kh?=
 =?us-ascii?Q?tHJuRCH6klDOt31aLkpqnTmuNVlGfPK3EGZPDzymcDJKD3T9m4M+CYxEXb9n?=
 =?us-ascii?Q?WmJUVP3IMjxwlG2yqnGWZvEOq4tzGw495m9nd6KS1MR8FjsETmAS+l/gYxvE?=
 =?us-ascii?Q?IoMeun/67O8h1DMnqLW6hMW2B1EWW9laVu9/EO9kwnR4eLwlmiPknUt9lKT9?=
 =?us-ascii?Q?cXR1SeG5wjXzCNHvhM1NNJbAGOM5u2J+bjDDJMKq9tGHNVXyaCthd2bmvvsT?=
 =?us-ascii?Q?WabQu+h9NCRaccyHu8jq40NmDDz3+wfMA9hkF/2Ld9fpA62bqctIRPBLG4nn?=
 =?us-ascii?Q?nBuOPHhO0Ir1qPFt1ZtlbeYeq/FUpV0D77sO5pKebMScZuC+imc1qg0V9Uz1?=
 =?us-ascii?Q?wUWB5CqxMBN58FRErB176th6ODNWiSVIRelflidJVThpRQz1l5KbvnotfUju?=
 =?us-ascii?Q?/m/Nv4ezLpl7ApAE2kvdJI6snrNs4IFBAZxuNlSkFf9QbPXfmHTI4DoWWaPj?=
 =?us-ascii?Q?g8BKbyUxGL0Q31lZN+o6YZXKtPhg3QG6ECfDeILdl16JzjFCU+WF/tQzHyiN?=
 =?us-ascii?Q?1V8sd7hwLjZEcvQg2PcGW3uozsafTPI6BEa77f+LamGloMOkRZL9jQbQi+/U?=
 =?us-ascii?Q?79OmaP+vAo9XusXCsGlKGc75Cf69c9CacLKGNBJWC8KEziFqBwSjbRuSAtkN?=
 =?us-ascii?Q?SJdo+VC9bLe5DGROMJUUU0N4QCp/OOwLE/uXXIKcwnxBTQXTdayMjoDdnFwV?=
 =?us-ascii?Q?u3kHIVA7jdb2y9VjP0q0JYuPf/OXQHZg2sdZ35HV5jZCt3KjLbXlGgmJ72W+?=
 =?us-ascii?Q?YBAj1MLsuJarN5Hs86lG5UZj66l7iZ/BK67819qD/tovgg4c+w6N9dIZUUFG?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32316544-6eb4-415d-6c3c-08db458364f7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:51:24.2061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPgeIE4VkuuLRa80rIhZpxXn8vqlvb0QmwhlIwoM43ZulIl5xbaQFnNierQru2it8bL3JXwmRC39NMDl/RGe/gcI8hEsY2A11cWJJnUP4nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 driver supports the virtual-touchscreen and virtual-buttons
objects defined in the generic touchscreen bindings. In order to support
the key codes properties within the virtual buttons, add the required
linux-event-codes include as well.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..66b8c85135b1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -37,6 +37,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/linux-event-codes.h>
     i2c {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -46,5 +47,32 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+
+                    virtual-touchscreen {
+                            x-origin = <0>;
+                            x-size = <240>;
+                            y-origin = <40>;
+                            y-size = <280>;
+                    };
+
+                    virtual-buttons {
+                            button-light {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            button-suspend {
+                                    label = "Suspend";
+                                    linux,code = <KEY_SUSPEND>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
             };
     };
-- 
2.37.2

