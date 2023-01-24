Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E86679F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjAXQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjAXQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:42:21 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2103.outbound.protection.outlook.com [40.107.249.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5914DBF3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFqlYj3RZLMtUsp670a88XXrrqYYFpM/uRqLRAQC+7kFtNTmmGzkpAnZO6dc33X9LSY9HdrOGIi4wmIRhU4L+kYpDmjc/mCSWCU+ezPAk+YKZ6SGvWyyI1CJJLZCNhmdFIUQhhklnuOJAnp+2TESbCDrROCm1WmZmenbwd1I3MM6rtGn7oYqC7ttsMpenbKFZ39SN+SADVSSSAdV9kW8uSgA0hu/3IpFP1EpGDND2gbCVsKCGAooV0zPgFbSsb9689h1kmatywc1kAXjnKo3Pqa4Kt3nJUXkNzRFNDVfIp9oYU7r9V7KgM5MceSOOsJm3Z37vdBSfRd0CoJmD+4C7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HRMwTPc/kfLY/jcFogHCzEOSKzQmCifk5X6VwpBOsc=;
 b=dGYlnCLcPFGZ5cmLPiSp+AqyVgNbGp8L/pbdxPEfaxLwLplZAtR+KqMlAue8w/9aYsPDKKKsBUWCoiWIfX5x7SMt2jIE8vBNU6E6Rruz2P5SpHL8zXal8EC5oJEhuAo0rsWYrZlv/znGFjVbZYgf3A0eVfiAOXG1ruaPWBycAhRdsu+7aeUtZMnse7AKSe+iOZXmLd6nsQYDv68faML5YEtZRmtEdkwcjwMwzAZu8YAHLreET1yhBLHnA8jafYG50tOV/oOMwrLjoq+VTjeaHSq62oluboZalRx2qYW1HPUAUjhxcHHkSFFEobQlTeCNQUeO8jJ2GEWZtoEeSyFK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HRMwTPc/kfLY/jcFogHCzEOSKzQmCifk5X6VwpBOsc=;
 b=TITI3A+lAt4kI3NXbHbm8l7+rZEqwFmW9lZocE8G9mtHEF7MN9gZAVJyD6gwc9Gwh4XBSrCPPPrWr9L7RaB+mUM3asR9OHu6RdukaxxEY2aDIB8Xz/aNPVwYsS/P+19nPGfpwmJ5b6Y88McGlgosygUt12lM2lxrH5E9k1enMj5wmsIpEZ9rJTg7ec01QiOEkHKkOTCIce2FBc3Kt6TORFhb9xhaxdFnXxyIFpYxkBb7mCg9d5PQyrFGvLGVKvSqLmmZNFCNX8zD1N9lZcUmBrponcS0bFQZjLCIy23G+JnQB/CEEGPj4vdATOmtiOqlkdsukoaSyIsqCZ5hYow9cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DU0PR03MB8788.eurprd03.prod.outlook.com (2603:10a6:10:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:41:54 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:41:53 +0000
Date:   Tue, 24 Jan 2023 17:41:52 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5 v7] dt-bindings: input: pwm-beeper: add documentation for
 volume devcetree bindings
Message-ID: <Y9AKUJui+jJRCtRH@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DU0PR03MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0a5c76-d1c0-4b06-d391-08dafe29e65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bb4GKk81zhcjxnMPaBilFdlrtkTRPUZ71gMXbREbGhGoFTvoFZN7+TY0DJTfVe+pGIFSDery6UwNRVklswm3JCiZbLeA8JblDfE1voq7XF97+w6/56TeCrsDbbuIqsfWkIDcrCbR93Kt41nu8MLmSS/7F18bz5qviL5RwOQP/UllzAXVmRoPzNjAOG5jgZM7GPDUB5BJWxgSmCYBsDaVc5suNYRyYwLrivopaotqErrWm+bqJZvfNKE7n8l97mqE4jkHQfGqFn8K7ZrWDLmTrwDMpOb5vORMEaLFuYbXHA9qlp9Rkk9wJkeho/Ek6fZKYXt/6pgz1XyYj2XJlsyQCm19exA9JIonXLO9qiQjYcoWBk4SHmFSUBRpB5ED7tHW5k+FaJ1yUIOEFrzuR0qeZbVBh7MgefMiU/i3SU/td6OATZTU7WsFK36db3kEckBbxq4rta3fC8Vgo58oz7y1bLoQ2JR4AxM9vU1j7lceT/hxuje76HrKPub1rCfBQo1xIfk44JfqliorYboi0cI4cXc5VryMS5Vd9q1M06WELc8DHp1+j+FEj9iRfA8Ia+n47OayPIseLojQRG/0s5fj7dZEi/EGUwsPFLVz9UFl1O8sr29rva8fXdKb3xzVs1zNfgcE8dW6lWC7ykRkuysQWHE+SCcBk3BFWQYZgUKW2O0wVY1zgO5zmVLNxLdw3wafqrfFycX1xjltRHY5D3TK9Tlaqbf/qZoon07N35Js0DE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36756003)(86362001)(44832011)(38100700002)(8936002)(5660300002)(38350700002)(2906002)(41300700001)(66476007)(6486002)(478600001)(52116002)(6916009)(8676002)(6512007)(186003)(26005)(2616005)(6506007)(66946007)(316002)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFOd2dhcXVReUhEcEk3c1JoK1Y4djFrcTRaTVB5TDRHbkpxL3NXUXlRc1ZK?=
 =?utf-8?B?ck91Q0hoUW5iY0RJRkI5ZHlxeUZ5R1JMTUo4SG5QeFlYR21pSUtWR241c2dZ?=
 =?utf-8?B?dW9sYUdyc1k2WmliMi8zSm93SFhydUxtNU4yQTAySDVaRUh1RHR3WlNXWFJm?=
 =?utf-8?B?WkZCQ1ViZXQyajB2ZVJ4QnhhWncyT3B6dG9CcmRkZ2dqakV4NlJaNnB2MDlL?=
 =?utf-8?B?U0JZeFB3dzJKazZEVFREYnV4bG85UGE5UDQ4VGxzUHB0czV0Y1N4YVBMOEFO?=
 =?utf-8?B?R0d1MnZCSU9JTUI3QzMzcE9UVkV3NnQrUStES2dMRXIrQnFQSFJsWGI0ekdR?=
 =?utf-8?B?UWpOODFrNnFERDlxTWJhYS9xck5vYUoxcmh2VkVsWE9aVU8xalZpNW56c0sw?=
 =?utf-8?B?SkhNaUtQSWQwbklLS1RBamxiMXZwUnF5dUdBSHg5bjNQR2k3QXQwL0x6OGZw?=
 =?utf-8?B?c3hBZHlFNHFpRkFZTEMrUDVjYmw4NUgrUzRNNGxBV1l2ZFhsODJaZmlCelVr?=
 =?utf-8?B?MlhYdzRNdHZvWTByZWlsWGl2cEVTVjF0R0RrZ1FaYmdmek1PWkF0cHdCTVJo?=
 =?utf-8?B?SWRhaFdpQk1xaVNkamRjUFJqSEk1NitjWElqWjhyK2pVMlhpeUxNNVI3c2Jh?=
 =?utf-8?B?RW1FNkE1ZWtiUzZXWVNPdG0waTlyaThzNG5Za0ErZlRuTUpDbGk0c2VjTTIz?=
 =?utf-8?B?K0J6SzhRZk9ZM1M0bm5rU1dSY096ckRmeXZkSXFVaFVTMEYzVnUzeFdrV3JJ?=
 =?utf-8?B?WjRjTUJNOE9rb3pyNDQwNmkyNENIbnc2bDVlOHRVTnh6Qlh6RGFHUnNYYWph?=
 =?utf-8?B?Nm5nYjdUN0lzSDRsNTdLM05tdFlTMFFqTXUyZWdlOHNVTWpJdUt4aUJiOHR4?=
 =?utf-8?B?RGE3SHNNenk5T2dydVdyK1JRbHlqdFoydk42T1NaNVFWdWlLbWQwZWRVOFE5?=
 =?utf-8?B?SEtnNElNRy84a2hSSUVRSi9VeVlURzN5MFgxRWZIZ0h4dEpsN3B4ZE16U0xo?=
 =?utf-8?B?czIwNS9oKzFVZXlQTlp6TktvUFB5V2V6QnFOeHF0eitFcUMvcTdSdE5iTVVH?=
 =?utf-8?B?S1R0M1huSHF1QjYvYTh5U0xvVmRCVDA5N0p1Y3lVMW9RVS9sU2NrZ3ZTK3ZT?=
 =?utf-8?B?em94NnpHSDU0OThLMUdoNHlWLzJWeWtFOHBqS1lkY1dHT2c3anNlNU8vQkFw?=
 =?utf-8?B?eklVZjlvSm1GQklkUG9zYnhGMVVDaU01WTd3M2FnbVhjK3dLckRvSVZ0TzVN?=
 =?utf-8?B?QUdSaEMvTnJlRnN4NTMyZElOOGJJQjczN1d6bEZFQ2U4NDlNb2l4YkxqVGh2?=
 =?utf-8?B?dE95VU1NK0hKWHJvcHdjaG5oZW5nNmxabWpHRSsvQS92dXdBdW5ubFNtQWNO?=
 =?utf-8?B?Q1F2Vy9jRFY5WjVYMy95TlNaZGVMb0JTNGRCQ1lGdW5ySEpwRlNaZXFKRWE5?=
 =?utf-8?B?VFVIZlBFa09GMGRPZHpNSTI4SVhWZlhUOGFNWTVPTklQN3BmUlN0d05tVE9P?=
 =?utf-8?B?NS80ZlV1dm1Qbjc5bHpFYW1MWlBPZkdyYVhDOWpibUw2N2tUZ1hkanVvL0g3?=
 =?utf-8?B?a3ErTGdONXBaRER5RWkyYXp5WkNrMEx0V3JNcnlIQ3RTMmRwQW9wa2Zzcm9j?=
 =?utf-8?B?VTRhTzFpSk5KWDlkWjlTWlAvZEtzaG13Ukl1ajIrSTBHcnhla3doVmNtSjZq?=
 =?utf-8?B?OXFNMTNxT1crNkVBM09mYmYzblVXeGpSeWtyS1ZudkxGVHlFT2tSUmljTDRo?=
 =?utf-8?B?dWdPcVpKWm9oQWMwZEN6eVRjcEE2OE4zTDBsUjdwcHN1azBRM2pHd3ljSkgx?=
 =?utf-8?B?UXNBNmRuV0NENnI4aGd0dzF0RFdaejc3dTRhcGYxUzJpSnpGQllLT0E5WG54?=
 =?utf-8?B?OUtnU1Q0SWZtZjdWd1lGbXFiYzRHVy9Ncmp3RlYyL3c4d1NsZUpLTnFZUkdE?=
 =?utf-8?B?aWhES2Z0VnBKUjhzdE9ZcklseGhmR1lwL1dnMDlzZXpGeEZuQkJyMXNwc1pu?=
 =?utf-8?B?YmFDQ29Tc2xIdmJGTjlOZmRjTkI0eTFzdTNFaXNOT01MclkzczNTZzVSblkv?=
 =?utf-8?B?QVZGc2NwdWx3K3ZkWStzalcwZURKckM2MXBDdzVVaGJYQ2U1bU9YTFBSVTFB?=
 =?utf-8?Q?8tXeAAWKzC9qUyYN1qVBbusN5?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0a5c76-d1c0-4b06-d391-08dafe29e65b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:41:53.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o29I3/rJw/setgLiciabldvJfZzgh2bfGaWgNpdYksKs+FupMa06wr1nTXt/Ha8Ib+8mWV+iGa+X+BdNTKQ0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation for the devicetree bindings to set
the volume levels.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/pwm-beeper.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
index 24a40f0f77c1..fe1bbc10147b 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -28,6 +28,23 @@ properties:
 	beeper-hz:
 		description: bell frequency in Hz
 
+
+	volume-levels:
+		description: >
+			Array of PWM duty cycle values that correspond to
+			linear volume levels. These need to be in the range of
+			0 to 500, while 0 means 0% duty cycle (mute) and 500
+			means 50% duty cycle (max volume).
+			Please note that the actual volume of most beepers is
+			highly non-linear, which means that low volume levels
+			are probably somewhere in the range of 1 to 30 (0.1-3%
+			duty cycle).
+
+	default-volume-level:
+		description: >
+			The default volume level (index into the array defined
+			by the "volume-levels" property).
+
 required:
 	- compatible
 	- pwms
@@ -45,4 +62,6 @@ examples:
 			compatible = "pwm-beeper";
 			pwms = <&pwm0>;
 			amp-supply = <&beeper_amp>;
+			volume-levels = <0 8 20 40 500>;
+			default-volume-level = <4>;
 		};
-- 
2.39.0
