Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB0680FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjA3N5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjA3N5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:57:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2098.outbound.protection.outlook.com [40.107.6.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76339CD9;
        Mon, 30 Jan 2023 05:57:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKm/yF8ZTmy+Guf7FEbcin1dksfbqI1LI/KgL8JukWaiVHDzwmGbrZY90Mn8JLilyYY5Be9bmV/QSK7wf2vgdmAdtuzseeTyrvQrWtZbRWpwZhHVBCAU443io4YZOjo7chlb4A21WFJvRrJBGQmej+4uV0qH3cGVd0MwXWFoLufUm3b2Uowvc5rpzeurdB5+DTF62Qu1RANjKtDfdTHjKV0yuriJIuhxRqc6Q79Qw2SEBnnj0QDYm5lc7WiDhkq9Pz5+rm5vARL2xLvNPbalzlYVQHl3NIWll82ccdJ0iI3uZHIDuCN44TeTPYa8zmKyH3tqehXmu1FCFVLW6tFLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdmM1EIME/d/UNuEnq5tXxpVUaNzDCS+vZxpVuC/Ekw=;
 b=X/+BNQK0qzSMaZRWfRdNOI9aG/tPpO/U0PAWgSLAnApseHnNPLyajDlaDSy3JXezvWUYO466ROny6w6Hc1ni4kpE6g52Pgwb4ZCMsmyXuxmdYRotSSOTa4pmgzhOW+QdEGZ5dbFDxxJVQe3PqdnUcpQmDvB7I70KtPCkpTL6jcqR9VE1NrrdKLoAyt6Ad1lc9Z/8puyCQlRnT6e+fquebyjWmwiUN2bqv/b3RVzrhgSc2arUXKX5xZ0/N/Ph1aDYdwm6nNWtQVqezFaot79kRAk8g7ZXu35/qwOxVP9amQoeFPtXiWMGPr8UuLyS99XxL6rMr98OaArikSwbGuiSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdmM1EIME/d/UNuEnq5tXxpVUaNzDCS+vZxpVuC/Ekw=;
 b=BYwYSutjGvtGr6n5BErQhq8zIJB1G076VC/WkB5SjtkaIJx+7lEpSDGZvrbcPeBbD1E7QiMiJLaKXFqUEAhvI/7YfbidCO2It9a1KiQEKsocfjFsP8ABFgAfY57mHV4bzLnTQvaWIq/SA4iJIZ3rZFDvyO796o1ClrfBxk+vB0cS+7BYdNuCFKQiGrs8uGup2OMpGLttQ1NX+k8Qi2swb3HomCSEmqVyjMDhrknTZLUQktuJlrk/EKHxYGnQba0uotyhNqBEk3f8b+MUoMU/DfOP1nMG6jrPZkW43AvUVOInKdvMNb7JEhwsSSjm7tEJQgvI1AKQSCfwv3MKPpHRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAWPR03MB9081.eurprd03.prod.outlook.com (2603:10a6:102:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 13:57:05 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:57:05 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 3/4] dt-bindings: input: pwm-beeper: add volume
Date:   Mon, 30 Jan 2023 14:56:49 +0100
Message-Id: <20230130135650.1407156-4-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130135650.1407156-1-manuel.traut@mt.com>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAWPR03MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: dc27189e-9dd1-4570-777c-08db02c9deba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C9EcDG6yFWbIxKCHXUQeap8op5PnehfBeQJjc64PUSsJYv1OOYmzL4oHK3RaL3VH5zk2A0229YO+qKTi9W1L8LUchW7Mw/0+SP3lsMGH1/JwgyCT93OAVQdW9EbohGpdICQb+U0sCoVco9W0M6ojAUp+9mkW/WLGAQetribACeR7TMKQdm+9XU59LAQ0m2docI/ysITvxZj93Kp1VxWoV8QBLvzgs5/nK5h6fp+34j8HanB/+Q2DoY8b98N12dNqelumH2h7NoSYEmyc2WDybw6fO9yNJf1bcJ+08uNYuNUWAVc7RcZHkOu6q1VO8/4zQ6TE6dv/XpuEaAjg44ObpdcVqjBtqzwxG7MD4opY23bq0St0vhJF06boXl6EO5AKjdvmIJEviE55KUKwGnbstLv9EtTLyAtMmDVPn7xKa9w3c9NrAejFzPLS2kTUscdXF9ieDxapxA6HL7LdIPYjE/oXBR00183OW+Oeuoio0WEFNFwECmKQaz7uOqGulSf7iU7kWC+sFSGW/A+isKGBBxIFpKzJP3c8/Z0E7SRQyCdF8GEHE+8l/NOAZvHgbPEmxz/MV9lJbCtuK1YJxT0fWYGV9lRnLWTfrmmQ2KspHhXaDazuzyg19VfCR2pzc0oekV2KXNwJZWUhMKtQ9LUZCf+XbACe3bbeuELioMVrj+eDo6qsRt9YKp6/nC2R0L8o/YegERvWWJXIXFFhXy9Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(36756003)(86362001)(44832011)(38100700002)(38350700002)(2906002)(2616005)(52116002)(6486002)(6512007)(186003)(478600001)(1076003)(26005)(6506007)(54906003)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6916009)(316002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRTcQ6QtgqtqGOmGAWCsFVcv8RJkldBpIu5fdbjlb2w6iQKtDvanuSu40biI?=
 =?us-ascii?Q?xF1biVfB2/VxBkNwpIe4Bi7mxwiqqmgaKY5sUNCuTINB+r4hdniGnAj7O/WJ?=
 =?us-ascii?Q?+9OHA7zChpoxiJbaQSsN5hJpayw11zEehaLFVd4CXMaCLBc3o3omIo9qbJQ9?=
 =?us-ascii?Q?WWxAVSvRACvKXYozlF3QY61zfM3D7Y9EvOHNBOo8rzxaTEqGuYF5ah5P1kLR?=
 =?us-ascii?Q?l7yxg+DKX9JugCav7yYAODzuhPIWB5aBNN/01YnRMJOvWEcDrNkWs+JqdDaX?=
 =?us-ascii?Q?OycLJnoMQKMAjHE96CxkwlbDK+s+QGH/HWyD//KP9HlR2t2i/jRv9gk7d1wA?=
 =?us-ascii?Q?7mV0JXv7a1f6YULbyA7q3QG8WqWPQS2P+bwHoXIlWXsyPLt4q7PC5JJsJrJ2?=
 =?us-ascii?Q?DX23nu6+/WXQzqs2nWweheLYSmyq3hMkrKc+3flcIIYAKsSdmysMqa/gCCDa?=
 =?us-ascii?Q?AIxHsZYurLwf7tkLlwhyaAgIQZcVKH3SS6iw0jP+6fBuOsyKhhc5lhELSCWv?=
 =?us-ascii?Q?5Falxw65Yu22kB4lbB4SW8qcSt/vONMHSuodgb+JkAg/eYMLcB6Rk4vKes1F?=
 =?us-ascii?Q?TrSCEFnHakXaEdf8qrbW/aapeJj63ars0TqBJ9ZJvfB3KS5yyhAUSPDVkHK0?=
 =?us-ascii?Q?iY3JLF1rj5axpYuf8bxhCQWP2FW07Dq8FqViu0d8y/mBatGKRjSpLeAmxClW?=
 =?us-ascii?Q?BC9JbIDBoDDaf28a20MwHLrmoVFmM8wuKFS7h4ZqY6UJG85+YBp2FI549OFd?=
 =?us-ascii?Q?ScWgMGqT7qvaHB1qvis3QX/UQW/UrrUfdoqG+EADGuWDRKWSIYVJ5LkP8ZvN?=
 =?us-ascii?Q?jAeG2+c8voR4nptolIfHqo3ycs/bLs+NrqfvNZttrKbgFNKCIpD4WBIHGU7E?=
 =?us-ascii?Q?28u2wgB4mNTHYwDSpL2TcDDyI2LRmoeUmp+GBkqWPCRHrjndtUMQ/oEJ92Z6?=
 =?us-ascii?Q?lnI9uVzXrltm6Y8TUPFkCjCy8icWS4b4osfV4Tvr0EptQSFjz1MsPMQ/NnGj?=
 =?us-ascii?Q?KH7cu/J8E4mkwH6atKvdw3JWL+Bum30ridfZDjpBjII3H3zET4zFHpjxtuQw?=
 =?us-ascii?Q?uPI8CwaYBwvB8buSmG5Qai4z8suUq58bj1kV3J1AXWRiIW1BM+dNTTGYmQ8N?=
 =?us-ascii?Q?mKcykaL8+Jt2k/SxiGUau6eMBReGLrXApItfyW+VcaP4WIG9MfC1LY23VJcw?=
 =?us-ascii?Q?qji0Ke0YAV/y9nr3TsxKsqnoGkVGFuw2Y5v92PDVMzTG0WlFBjlidSbPS4PX?=
 =?us-ascii?Q?h5XSVzf+JBZGvXfyqelumrDjwZTpmHV3O4ysRmwgXHr5mC8NPReGL6EGimmD?=
 =?us-ascii?Q?NuZLGy9EX7wXsTq+nPBlbrhdhs7sF6zWogFH5cQ7NjztK6rzCb3yL6IxFRFk?=
 =?us-ascii?Q?iGvjegRB4tIlUzCtEhcINfQJy/VeOW1WAt15KPQfJGeTOShQ/ppIhnezPKVG?=
 =?us-ascii?Q?5trV6Ws3Pi/vBBX/3R2pm2NbMkMZXHGm0NrXd1kHGmg8A6gvBFYwFgLC3sEV?=
 =?us-ascii?Q?u9AVXBXAfAEQmryfvWHTjDIWsycBdePYedJ8TMOxy9i6kvAFDMOO6O6UShmW?=
 =?us-ascii?Q?DdptXqUP0hCJbERs1xrWwLu5jsaO80v3rz6UpQjh?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc27189e-9dd1-4570-777c-08db02c9deba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:57:05.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZmcsZwvFvqwjJo/97naPO85bH5gHR4xXiBpxFmydxl08n3LBXQn3u3966PTDE8IWeSaHw4ATUNkUk97PHD/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an array of supported volume levels and a default volume level.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
index 1ebc3a46d934..ca9efab7efbf 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -25,6 +25,21 @@ properties:
   beeper-hz:
     description: bell frequency in Hz
 
+  volume-levels-bp:
+    description: >
+      Array of PWM duty cycle values that correspond to
+      linear volume levels. These need to be in the range of
+      0 to 5000, while 0 means 0% duty cycle (mute) and 5000
+      means 50% duty cycle (max volume).
+      Please note that the actual volume of most beepers is
+      highly non-linear, which means that low volume levels
+      are probably somewhere in the range of 10 to 300 (0.1-3%
+      duty cycle).
+
+  default-volume-level-bp:
+    description: >
+      The default volume level.
+
 required:
   - compatible
   - pwms
@@ -36,4 +51,6 @@ examples:
     beeper {
       compatible = "pwm-beeper";
       pwms = <&pwm0>;
+      volume-levels = <0 8 20 40 500>;
+      default-volume-level = <4>;
     };
-- 
2.39.0

