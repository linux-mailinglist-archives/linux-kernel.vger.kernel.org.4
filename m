Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B361767C6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbjAZJTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbjAZJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2517CF7;
        Thu, 26 Jan 2023 01:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6sa+sKjmO+2KkmUDYJfbnpJilnwT3LEyn2pi4Hb9yO2yjPei+05VcA6T0z9Bemn0powVZatx8KZ2kWtYnBrkZ4v/JSTVOlsHGmDEmwv4TNcQuh82HtReVz+VyFx3zYMmVojoDiTeMTdvzTe7Hboz6tBdhfeBE2xt89sS2J1u9Ub4KF5B67mrFPxqIxm5aDv0n9CsQDxh1377oAjK4Q7/FCWJvngyeu8nhZRDOkW4D8oFP/qqMPHZSguGm0JGzQNgkXjAo8aD1NOoY3GZOkgh6vVr+byyhb8JrCHlSMNIUNWbh8gzl59brYHVX1kuVGt0yS2XPIucx38363ETr6etQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWEkzbCpBJZ1J6AGtrB4vzIydngUMIOXRQJ2gnoyK40=;
 b=nOvGygV8QBT2VTpXZN58zBIiG4Jxtyh7b8rMVwz25hD7TJveJHp1doV/vkHZCKf7+Sc0myY8Wzcc9TrnA0Nu1W0HihFI0e567fh+S3dUtJMpQcC+Dv+6NlWig6xx4UTak1mp7Mk+1sLOnkvXW/8nsPSGUKIbmU2Gwmlh8CwUaDZ5ImofeYvzcVsucjxZbN12rBIqltFFt+aqtEJPPUMkl+IjYrwZzxORDjoMaD8HAI+7rhnGB93n7K4Ijdsw0sEExNBTm2zAtclkZ4P9XPYvWTs1SBTrF47N/6GgsgcoYp5A8I/9giYIxHBbI1vk65nDDnCwXEyp7eG0yN46RKqcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWEkzbCpBJZ1J6AGtrB4vzIydngUMIOXRQJ2gnoyK40=;
 b=h+CmQX+F7eQi9oFqmsIFFApG2v7eV79/NywulZbEX+aJPQF/7vRpkyKoK6gFS09ysOyRTt8aUUAXOVzhPpjaezuYYOBLLjmp3goL97s6JqdBJ4Gjzdwcuxm/ebs6a69XhRkttHCSiN6iWiuJ+en+YIPIk09e0J1dPSwHUpjMgOqTBw0bHIauffyCUHB3oeWA2aymgyBy31PHy/VtJyyfXlx7a2ejUPslH6GeL22IsBw1zeKcGzsclYENRrmwmK6vrkbZvlnhjM0F3a27BBB3kZCP3FYLDK+kw8GJ+lY84wPSWbeHMKSf5teaeGc4RMQUDYhMNihydSlkeGC6x2xQ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:53 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:53 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 5/5] input: pwm-beeper: handle module unloading properly
Date:   Thu, 26 Jan 2023 10:18:25 +0100
Message-Id: <20230126091825.220646-6-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126091825.220646-1-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df6ba51-1538-4936-6cd6-08daff7e57ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1hmOApjRY4HdKIelEO3yYp+BED7XfPAeptHLBjS7sEFcnChlBXewlowrCq/flGOABegEUAS0PxsY66ALkbKz4ZFWR3gfzRn+ONGbRbofIHPZUe9lFNBZcwTiUkLiiQ93FeHWGIyBMZoJr8Ib8LDnt7oQ8sRj9o/SoOZhFEUfxSCxpC6FlNA4XHXOkYfMiwSRZBIwrzfiOkxuCDXR5WhhC6+YQ5N9WVNR9skcnhv99/cYqF44fimlc913LR77oCvY42cLBnBYnsNnLe7AeNoGJIZsp2W0f8koU/MMkuqLxM14cdVIIBBxY42Y8tUyAExPj8m5MAt3WRkIu0KHZaiKG4uRwAr20Gu+B5zYqQwghWhG7tdDp66IjQvUKa3eekhINdBEhnnn5XrAo+++UlGZl80nB0xQjvAfYVuDMzXu9bLRLVo7evp8EkEOdQX8LjcXdADg4lBGj/m6mc5tUDfy8b8+dndRZ47EDXpI5n7BHEIPsyzeE9siUOhBekR9SG5y3ZRI1SPBwkDZhO+1YdtUOgxBo1HyZkt/GunND04r0r0qBWFLJu+33U5oKId4XnwErx+jqmQVnRWEAB7vAjcq2EW+TCv08r6isJD7JhHaT2oJWm7fBXYTDjJAhQ3uqP6tkb5mu4wiXwFFjKnK89b7cvY9hEY/zy5EarQcV72L8W3PYzFHMIekrrn2xWXdB7tUNCEtURvhRUilfWbByxofg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(83380400001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zXILcEhhvleoKW1/gKlCaFiyQAejEBygnReGxZOcr4UfXhfIuZKweoZ7mhu?=
 =?us-ascii?Q?kRXqFaRU0R3g/MacxjZMjOer/Y9c90W2HQt8VZyM7qky4iRKZYRMMbvjxMUq?=
 =?us-ascii?Q?6eC75x9MoRDrVSrvRl+yeeAsYFNddOsQYH1XVOBJTt3NqGvqvBK7puOIFnEY?=
 =?us-ascii?Q?ACtmD/9bTwE8+708VBtIkmJoYHto/T3Tl6nfJvY6AzcgUIajjXUjIkLukQsv?=
 =?us-ascii?Q?7x5KrNoW02CrtFUhBKWjiryOkvb/M8ixoe/VWDJ1VPdToofFsfcebow8vnua?=
 =?us-ascii?Q?cEpkhXvRj7TZlQj6xt7AkJHyYYgGAoUV7vdjbCLYaiVZfD2wcJp/mhDEVdcW?=
 =?us-ascii?Q?FcXOVAlX1IkgNcjgJeB/jpBLZMKlMbJazSYKF7Ln+yW6DrkR7THNoIfpQAfC?=
 =?us-ascii?Q?Nq15TBwzQgPbzrs0nPIsZQGcv7kgzTUn5cGYX1jdHySnepEQnjIT2c/nJ/FC?=
 =?us-ascii?Q?6GmzMy2fS8nzEj7+Kyjh8ZmB8L1bcHmdUztqhQlt040hjUObEOuucMZwG/oL?=
 =?us-ascii?Q?mDGzg2kJvNK6AwZ5kLWF1wRzCT+A5xrXmHhb6YKp5P/nn8uKEu75DI0Mg5aU?=
 =?us-ascii?Q?TzCuahSzRBRuItA2dVDskcSndMC3lJpBtFg+1m1FROboF7engOHGLdB7Sfyu?=
 =?us-ascii?Q?8mZGA+m6Ki7jKiXn5ui8nGzmkUZus5pFV0/Tqmd59RLGRhQ1feL9EPFYq2b2?=
 =?us-ascii?Q?8aDPrCxRg+6T2bkXs9/ZVg0gQvjTnvm7AMytzqrab1c07NZjnvhaEBaFE3qM?=
 =?us-ascii?Q?WSps223vBJE7bOb5kVDfxa87jtQVF1ZzfjZrcOzkJwO3lkxQ2n/cJD4aC32T?=
 =?us-ascii?Q?O6ghDHTOER9Wk83aUZiB4bvnz87NjACQH/Ca7aKuLmryfiNqptNEyO0Fuqdi?=
 =?us-ascii?Q?9nHkHO3YRa54OSPVc59WELW9UkyJ0du/GB2sivpUEK+OO+WJgWgEoMJEHDI+?=
 =?us-ascii?Q?Wh8ZggBftorKac+2e8kwAgje4Xs568gYA0AZYHIvRQ1ei6th69uOzXDdJdAM?=
 =?us-ascii?Q?i4g3la/cLk5uJEPLvCncMwPQuFsyR6wTdwO5Ldc+4Jn8Je6jZVt+cBa4buTB?=
 =?us-ascii?Q?XBkZed3D55l6Q9b9NNEBRhdIvlELJBOEGx+q6gd2cvjDSyqFDHms1r3KnEB0?=
 =?us-ascii?Q?Ynq6i1/YKOYmMmNsnt7Cp5vtmwa7XMZwLWltTLXN3QIvNHmz/DeRwU5L9Ja/?=
 =?us-ascii?Q?Q6pIjezwMcCvHNC0GgbtBcYUwMJVojXJA1cZl0a/sVQwv1V+LCO0BJuvbJ0m?=
 =?us-ascii?Q?L8jDR3jMzZpWvvOMjZi+ePNFMZPtIy0JytirpK2bPU5wu6DGHL8sZazkH3Bn?=
 =?us-ascii?Q?PqIVVsTwYxFoTwT0T5ow6XETwDvOPu9hDh48wRNI2fTS/rZ2SEXPfR+xSpb8?=
 =?us-ascii?Q?mDL8Zx0aAoT1m/gRfAN8oVdU0D1fI1K1JvQddb/lgiqu5LqxTFDWDHvQLKVq?=
 =?us-ascii?Q?QTVmEFMpM2qjw895h+A4fXgElMFzG3EGtC+8YcydDPJ862Cc7koXxWeZOqpT?=
 =?us-ascii?Q?NnxKD5MKir80EhDq7pNhPtNo32+egAWlga991YcCEu3xG4FnUhh3UYJP9LRA?=
 =?us-ascii?Q?w51EPOt2fQOShF9gnQiv89+ytGssXHjfp15DUkiG?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df6ba51-1538-4936-6cd6-08daff7e57ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:53.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEwsX7IlK08OcPNUvGVMOX+7JVHs548958vDbACKimT5w1A2F/+hvizLnrBtMaB6zG66Rnn0hbBK83G5La47/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'input: pwm-beeper: add feature to set volume via sysfs' adds device
attributes without removing them on error or if the module is unloaded.

If the module will be unloaded and loaded again it fails:
[ 1007.918180] sysfs: cannot create duplicate filename '/devices/platform/buzzer/volume'

Therefore remove device attributes on module unloading and in case
registration at the input subsystem fails.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 drivers/input/misc/pwm-beeper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 82b05f7f4c70..736b89bd1b42 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -299,6 +299,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	error = input_register_device(beeper->input);
 	if (error) {
+		sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
 		dev_err(dev, "Failed to register input device: %d\n", error);
 		return error;
 	}
@@ -308,6 +309,17 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int pwm_beeper_remove(struct platform_device *pdev)
+{
+	struct pwm_beeper *beeper;
+
+	beeper = platform_get_drvdata(pdev);
+	input_unregister_device(beeper->input);
+	sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+
+	return 0;
+}
+
 static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
@@ -353,6 +365,7 @@ MODULE_DEVICE_TABLE(of, pwm_beeper_match);
 
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
+	.remove	= pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
 		.pm	= &pwm_beeper_pm_ops,
-- 
2.39.0

