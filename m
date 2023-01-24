Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A02679EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjAXQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjAXQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:39:57 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F503585;
        Tue, 24 Jan 2023 08:39:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF+L/cehiYLvWYKIS0B8ra7J3g7Fb40BsYAd/je6W9g5BtRoIPKVQavnCnaqoP9mDS275LM8TuSaqPSCxQa/XRS9KuGM4CYiBwAgpBReRS5w8vQw1m93Mh5Z0K0b2JziK5NDKGnomcnlRyH12ypXLWUAKllAG4YDDGlLfvHR92gBTdIYQSh+Uepg2LzLlywE+GFuDq/t8emCVkHp0u/tgukz5JBwLdhxGAeayEJ+xeQKWuY8KrTVQW0MjI1wc/ihLbAH+Pdffo49GDgIvJkMCKdbKbBu9KMM5yZlZZ03lKCd+JKM/DPlJd4VhK4zhYqMtxIhm59F/Mn+x2BwafRjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY9YRAXQvO2xhh93Xhcu8iiXDTffNPYYaP+YJcU7zEw=;
 b=GdOVUB8zsmLH06VgnOGxpvgquoY3haBc+gcevI/GynOveoZp804Mobwr2euKO6kCuBC/VKIla1HxlNv9XzhjD3D2zswdJBRDGQwucI1Mu9F0UbxVvJUM2T+FSIP1dUSxqA9q5f8rRdD6Y/HptbYfX6/svR6vpxh4r4Tnv9/BD0akM9SWMbgNcZrvU+xKBvEW0rreDqmoCmsN6gQiwmfZcfGZwK3BeLVONE+yrbVkMfVpr+saKOrNwYQ3CJ8JoIhRro9NK8MQcz1i1kx4mWPjOwgWtneN0G3IZRzB7DGGG1CRq6cuiG6jXADzUCxkE6vub9wAL6JvTNJiqL0lyYfaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY9YRAXQvO2xhh93Xhcu8iiXDTffNPYYaP+YJcU7zEw=;
 b=rTKtHPcY2lsATuZDX+i8MI4z35S+OOF4U0FMHxrhTqz0MK6QbdVzr059wLLbW6f1bNZmU2JRQQ51gddMyzNv7U1V3YRewzoDwC/E55wRduMh46kEg+daWgIi9+ts6typXehNMfd3HvEAZeyBBI4pHzvOea26LaOfErruiCpWfEa4bgA/eN/MH35P6y8PlJ5wLHTNSjOm5kGiMl6GFK0QDfOYQfdT+BQkJJHr3LePwPuM1jP+7eozDUga6ISGuI4a0O1VLhjd5BRQv5uXBZCdcnCQkWOpLfHP6ZrTNRD6CTy8nePpF4AaRJP82615RpKx/os+1uesVsQ0gweWLfxwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS8PR03MB6726.eurprd03.prod.outlook.com (2603:10a6:20b:29e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:39:50 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:39:50 +0000
Date:   Tue, 24 Jan 2023 17:39:47 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/5 v7] dt-bindings: input: pwm-beeper: Convert txt bindings
 to yaml
Message-ID: <Y9AJ07zT1lpBLhPk@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS8PR03MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: c69b2bdb-fed8-4179-c998-08dafe299c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxVTnvwYItuagO28bTf4qAkaai5qZ3Un7MaUN4U80RuhS+kbDr6J6SPPe+IuaSgdjWVtN7FBJT26/J2UTZq3zcAszSNuQNR/K5UvygCh7gQYCE0nqg3PFHq5saAZDZLrb4AbYMFlY/KV6Ba3JyuHip8e53ZO3UROtm0nVtx93MQXvtrYAjudjAkvzc0C7Uua6cMrsU4C5sTsOZINEG72fW0kkQeK7//S1K6VQud1KiE/cGhZ/6kT19v+14x2wHIaJaGpq+WfCxYh6bk48ZhOT/6d64NeTaxyeBdH6TiLLvEx+94naYooEzzoTGM5aPL02fa+iNp+mcaINxmx8QSHfJWDcFdcHHshKx49DTpefeUdPWS1UQGkz8kgXY5hEIFMyW0SBt+wHx9AR/0RZIzHq25QxNJlU0eynmRHM5sGZoJvjpuoUpDRWsie/8/xP5/Exw8dLpapM9ztDJxMBL9ZL6PzGfgXAstvlX3hJnLDnpMCsumpUzhXS0uFt9HraPOpQpPu3k9AKH8r7VqVHYPuqRadWJwgx3Bb5Mri4OPDdusx/ckt16p7joRo7j6bGKp5lTDEeQ8z6nI8lxrxrE75xfITcSn8dLYY+f5VpXn8uOEnP2njUxCVIQZhmPIT7PMnJiiH8AIFRZh2N+n396WqwnOFzkIOOz2KR2yCub3/Uv66V1XhPXn3gtKFB/pnxM0ZmrTpUA2a0H64MYlzgwcz9UCfDne9oGdv9ch8lRqpKD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(6666004)(86362001)(478600001)(6506007)(6486002)(26005)(6512007)(186003)(52116002)(316002)(36756003)(54906003)(83380400001)(2906002)(2616005)(38100700002)(66556008)(38350700002)(66946007)(6916009)(4326008)(66476007)(8676002)(41300700001)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFJdUdoVXdrWHN5dHY1bVp1bk1CVlRSeUxCT0x0TEprZUM4c2dPdG9PdmE3?=
 =?utf-8?B?RDJXZE1GQi9ZM2RBMXlmWmpWQmZKSFdxVXVUSHdGVUVzbEhwcFFnbmtod1Rz?=
 =?utf-8?B?SGRQN0tmYTd6cWIxb3VGaStoNG9oZlV1M3lNL3N5QVlYYjNRZ2hsd2xvQ0V6?=
 =?utf-8?B?MUgzUExZN3Y0bkhFOXZNVGpYZE9oV2lmL3JxRllXSkFnQkoxRDllQVhYc2Fv?=
 =?utf-8?B?ME40c3VtS2oySXBYUzRKQjVMNHkybEZtSWltK1RQc2lhb1BYMG1rK2Rqa3dx?=
 =?utf-8?B?aUU3SHF2TG4wYnJEaG5RK0F0YVhPSVhrU1RMUFBmS2JCdWR3dElsUmd3VW1E?=
 =?utf-8?B?YzA0WW1YSXozWDFZck4rOGpmK1F0UmhYWTNTWVZCYjFpTVZPOVBEaHlVaFJx?=
 =?utf-8?B?MHM5K2ZvdldWc1hta0NYNmt3QUNiRXlTS2NGYTArdDJuK2kxVDRtbW1mQzl3?=
 =?utf-8?B?dVpUZEduLzRybWFLUFhwWkc1c3JDU2lxWjUreGRwSldkT0tTR1NtdTI5NmFW?=
 =?utf-8?B?WDdtRG1EcnlVRzQ5YnBsU0hiQXpNeVdqcjNIOFM1UlRvVkVBMitHSWxWa2w0?=
 =?utf-8?B?d1FoN3dGZGEwTnFUNE1Cb2FwcG1YVmpNdE5JMWxha1FEa0ZoaXRVbUVXZDZa?=
 =?utf-8?B?OFRrL29hWHdIbHJhK25CV2U4WDU0aW9KVXUzaHBsYUl5N1ZVWEoyN0tNMkVD?=
 =?utf-8?B?eXMwcnpUbi9aNTJRcGhKQ3oyaWtpVzF4NzlQRllSTGFpL1IrTmlJRCtFVUYw?=
 =?utf-8?B?N3YzQTdkbEVWdnVXMEdiY3JpSE5JYWlyVFpxMHVhRzVsMW1aYVFlY1JuQ1RR?=
 =?utf-8?B?YjdYQmxHR0V6bjI1ZnphVmlkbTVWcWlBQmNkUTlZUnE2ZnI0RE8xZEdOK2RH?=
 =?utf-8?B?RTFYK05PMGM1bHJuQUZSY3YyY2RSWCtLR3hQNHJ2UWRPekY1dWhNbm9PMjVL?=
 =?utf-8?B?eCt3NmVqTmtlZ3VkMkN0aUxweXdSWS9nQ0ZicUdZQU9xQnI0T0RHQnB5N1Vw?=
 =?utf-8?B?cFRNMlFSUHlZS0oyUzBwOFUzYTBNTXN5SmNOektwUklld1FCVmpWUTg3OFJj?=
 =?utf-8?B?eU14NHFkVldHZ0tWMDFDUTN2cFlVeWdpTlhrQ01zYk0wWmdyZDVkOUg1N3BZ?=
 =?utf-8?B?dENKZjBOWTljb2FkMGtCVTl2aG03aUU3RFA3RWNzOXJ4ZU5HQlBaU3NJS3E4?=
 =?utf-8?B?U29mdjM4enJiTm1HRjdQRG9lQTdxSEd3dU16VTRUTDNabnZHbzd2OC81dzI0?=
 =?utf-8?B?NTBxYVFLdWMzZlh0bmtlNWpSYTRMU1pyQmpqYlhzVTRMRnl4czdtMmFjTlR6?=
 =?utf-8?B?WWhlVWdDSDFNcHBUZktST0dBSnhVdmpzQjV3eThBY0Z5NXplVTd0MlVTTHhG?=
 =?utf-8?B?YlNUbW92VGdkOU11eGhqM3VocmhLR0xnQlFQTVZQdEJFaGF6WUFGNzZBMUhI?=
 =?utf-8?B?YUFsd0tSaEQ2eWtJMDhsUWZvMFpJVmxqaVFkSy9XRmVRSEFYVFI3aEdqRVBS?=
 =?utf-8?B?eWIybWpsR2l5SUJrNlprTUxxbEZQdEdaN2dPcnZ4bG5NR0l0bnF1VG0vSDVj?=
 =?utf-8?B?WXRObzQzS0k1YTg0ZjBIek5vMzczdTF5dDVzWjZSMUNLWGxqNGpCV1BsaXhK?=
 =?utf-8?B?MUxNVUFaUXJmZnFKMWxSeFczanI5ZEloNEZEL1lRaWU4REJwS0VyTHVoYWpr?=
 =?utf-8?B?aWxIVmZqZ1d4OFo0WkRXZTdxZGI1Ylc5ZFdyRWtKMVcvVVhXL0czZ1JmUGk0?=
 =?utf-8?B?RlIwZGtteVpWRU5mRjg1WUs3eDVIYktiUXUzS1lFVXpxSzdVL2hzSWpVVWQr?=
 =?utf-8?B?Nkl4a3NGWmtVaGo2QklyRXhPSE5Ea0lLa3o2dkoyaFhHd21pQ2lCTWVIZ2pW?=
 =?utf-8?B?QnMyd2xSVHV3SGlYdm0ydllZUDRrSlZZbk9XOUVycGtkbkRObnc0WEFjaUNR?=
 =?utf-8?B?djV0WW1hMlhvM3VKdk1HbnRzbFZqZUFqdUNDUTN5RmhpUW9ldU85QktORGdL?=
 =?utf-8?B?MHBBUE9tU3ZHd0lmY1pGWlA3THU2NFV5aDlQN1FJb1BRRzFTMlFqUTVRZnht?=
 =?utf-8?B?VkY0c1pySGppWFhaYW10dCtLUUVQUFdDK0czZlVuQ2hlUndmdWVFbUZEUHlF?=
 =?utf-8?Q?XNa9GcHK6bpDv6csJk6bYqe9r?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69b2bdb-fed8-4179-c998-08dafe299c71
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:39:49.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axIW3dNdk71Wjomd4QxUxXvkMP0hRiaWAMSKRWtRdEb479TXqdhafd5h+H3sILbnGUsuCnpjT5Z2Ke8X9pzlBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6726
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts txt binding to new YAML format.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
 .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
deleted file mode 100644
index 8fc0e48c20db..000000000000
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* PWM beeper device tree bindings
-
-Registers a PWM device as beeper.
-
-Required properties:
-- compatible: should be "pwm-beeper"
-- pwms: phandle to the physical PWM device
-
-Optional properties:
-- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
-- beeper-hz:  bell frequency in Hz
-
-Example:
-
-beeper_amp: amplifier {
-	compatible = "fixed-regulator";
-	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
-};
-
-beeper {
-	compatible = "pwm-beeper";
-	pwms = <&pwm0>;
-	amp-supply = <&beeper_amp>;
-};
diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
new file mode 100644
index 000000000000..24a40f0f77c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/pwm-beeper.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: PWM beeper device tree bindings
+
+maintainers:
+	- Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description: Registers a PWM device as beeper.
+
+properties:
+	compatible:
+	const: pwm-beeper
+
+	pwms:
+		description: phandle to the physical PWM device
+		minItems: 1
+		maxItems: 1
+
+	amp-supply:
+		description: >
+			phandle to a regulator that acts as an amplifier for
+			the beeper
+
+	beeper-hz:
+		description: bell frequency in Hz
+
+required:
+	- compatible
+	- pwms
+
+additionalProperties: false
+
+examples:
+	- |
+		beeper_amp: amplifier {
+			compatible = "fixed-regulator";
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		beeper {
+			compatible = "pwm-beeper";
+			pwms = <&pwm0>;
+			amp-supply = <&beeper_amp>;
+		};
-- 
2.39.0
