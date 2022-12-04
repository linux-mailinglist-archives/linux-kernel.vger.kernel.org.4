Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD8642082
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 00:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiLDXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 18:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 18:17:08 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2094.outbound.protection.outlook.com [40.107.11.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB31055C;
        Sun,  4 Dec 2022 15:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7MQE+lL8zWpL7+gr+eTIaBaxv5PgQfKsEMAm28zbEd9ZjNHE+Ccke1q1K0oP86ZYToBWKaWeXVQ5GoC7hpPOHLwGgBKwpE1ZvX59A6Aqeo14FodNaQ/9tcIJ4OvoeyKHR/n+T+Sh46bhKFolQM/gzzV/KnF9es7z3cNkhtJlR90oQh1YFeCU+YFZcjCDAjx4zOWZBvGRzQTmMk5BG1qnEsKcrgaN49rG0scSeGfsb3Tt56Uirq0BNqmWlAKNys6HpmgsunLh2X9AA5/7R6VKc8iPSOmP3cXxbzZvIOT76iWhLZY/S0gAZ7wcWkGEztVFGn6Aru4DGRzRi1CRiWYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxHbfX/xwVDFuOcs3E6EraYcCIOOw1j+lKQ3JfET30Y=;
 b=KT4r7CUG3Td0VNMm9dqsUojM46uv9eqAteqi76kj+U78rEfvBa4BYN446muiU8yos1Hl0fcbfpBMBTHg2LYhRGb/Rezpvl6kq1iVWBTT5M1RDrT2DsohvxhB18z2+qunZ4LJVQ5wFiZQWY9r6U91YBpuQ2FTUgCzD44WQobdEo1hHSHF4zjHOxjML/1M684xQhJyIfXxJVVwClMHaMr6+xNkK8y+XhaxdETyMdLTIlm4LSQp1J1UK4N3/hnJIOlVBKpwJ3clZtRQ+33kqFV3GY5TBDyYl4dF+FbJgH92vdt1uFqKk3PF2tgvUoLTv2cSfULnILEsFWqVl8GhOyxlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxHbfX/xwVDFuOcs3E6EraYcCIOOw1j+lKQ3JfET30Y=;
 b=lppX2FeSm5cbGmCTDmQZ1Kybhg16AQ+lLOdu6bqWV8+tH7LSEfUGGQFeLvUMH9MFw9W5dGxBit+As5mlTADryT6AvUMML5gI0NZsZRHzaZUNpFhm77/wXKj0vaxYAksiq6zIwrv9bG2kPRoNXShdWHIGZU8yLFmBdBZ1NSIgkyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Sun, 4 Dec
 2022 23:17:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5880.014; Sun, 4 Dec 2022
 23:17:04 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: make compiler-builtin stubs non-global
Date:   Sun,  4 Dec 2022 23:16:50 +0000
Message-Id: <20221204231650.2604587-1-gary@garyguo.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2198:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2c217e-c2a7-40bd-1ad0-08dad64da795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPFiX4wHbNjsi9AwAssLi16LAX6DeSHNESlmEw4PYd3vX4iaQBUCtlTcTVXM4ckuYRLp6KmIwrJxaLfWN9H4oHVK/fN1SRQhEBNg5VHO+zCV5hJNOqRibbjzZTJ+h7Xzj50za/lMf9eMBfJxjS+4viWcR3qt+YkO2iGk5IGVa8SKAnkag5YSzl99SkUSgS6CtmFYcJYHUzTcnuIgj2Y25guyziTIKuUlSmtvmWrMxlonc5sA2OSRypQ7Aa28cQrEhMA1XqaANqS1hwyEekKN+wBVJW9OSjdZNla8vw9dFpZ8dxduYZO3OoXuWueqs1QIVsCXvpt+peB7sEjCfp5voU7OAH+oHuzW/EHR/qSPMuNp1duIgXsqnEGbcb78jSgp/Cjkgj70hfhybNWkFd8r42z37aGgO2xhMFPJGbQ0Bq5oeY+XmAbLmLbqzfB66GClTvsc4BdqRCcIArA273nWAVwBYoiU+W6inb6sXkadZB+B9Y2XVc6jQ6N+SJ2M8oakro13QTv2xHZOnDijZnxQGunbyoSmBNzmZi75+Gqj/ejroax2+LH8U3bDBQwCS/4QNI8XIq9sK7haLQ/SatFLKV+xh9PbT/FKjpqqLXj4FrUhRp3T/0keEDyDXq4dEnBKojqxdA+GKaomqlkQB8xUpFnfJ/c4ty9eSs0fjosNhbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39830400003)(136003)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(8676002)(66476007)(66556008)(8936002)(5660300002)(6506007)(966005)(6486002)(6666004)(478600001)(55236004)(316002)(110136005)(6512007)(186003)(26005)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZRm/cNP2/J9AypwuT3g+QgBAu0miD4qU8BNmyRXXERqmRzfzqxX2aSVA7Vg?=
 =?us-ascii?Q?GKGKckS7/6xOSWZBAfIGs/7th3+4rONdl/G0LtwMdjVkBtVTQCjpxKn2Im5g?=
 =?us-ascii?Q?Kg08JmUxWT5Bg8NvGceWBxMDhKgHScNWSUhfrOCzSOIplzfh315+tmr0GjV0?=
 =?us-ascii?Q?pViFhb0oQaXLPgtXpbWtLmftreFO+xDjOq5Y0sgGW5NFXP7ps37OjKVYVNGi?=
 =?us-ascii?Q?FUBGxcQ8lbeN6AxHmU9ANZYf2ndhhrQJydSNg/RPQ9b2BgcFcGG0/8asw8P4?=
 =?us-ascii?Q?eIy70cRkKkttDZe0lgWoXiKB5MGAiUk6CrK7YrY6rS0vKJ6iMX388eWgu9Ev?=
 =?us-ascii?Q?WBohYcDDrNsgQx3dLPV/mhvzGBTu6k44VkOq2AiM+3dmJDJlt6vObTSqQZc0?=
 =?us-ascii?Q?G6NOeoQCJXJNvCFZDxuECz9kHCv/ead857GONYyR+SBqB2D6EV6pOYdYtbI+?=
 =?us-ascii?Q?87VXIZJ7cZGH4Rmf6VJLJsYG4Xepxc/tzuBiel+iERueSVj6BCqou+hrZKac?=
 =?us-ascii?Q?dGoZ5SlnNPlZY+G+WgjBrB4W1Yo2Jr3HQ+YQGPNn1gbMwCtkI4i3yNspF3zG?=
 =?us-ascii?Q?XlQo3mLxZM2RyXtkPDzeR6GpykAkSvSpwvyTBtYhKeoVEfbZa1neFMVl4Swk?=
 =?us-ascii?Q?4ZQ4xprxoN5pSD0q6imTkc7FIno2imiwi4LJ+mXzw1xb4cBeSTjvtMSGSUb7?=
 =?us-ascii?Q?G68/w4jYaHj/LTiiuhseITd6rYxtfKoiH7tTJ2NB09JD76z/cDcOullsA2b4?=
 =?us-ascii?Q?2+P0emxWDzqjPNM1+s9XSkcOXrqpcinO7th5bjQzl+ue1SXcuXeAmx3W/zmh?=
 =?us-ascii?Q?JJZp12L/3qkcbCHqBudSU1cpRN5TVf3dTMpXraKTld1v5i5kiJiaDJ/kQDND?=
 =?us-ascii?Q?eYW3/agbBOiFRWVIXoL/aEtO+KOUqVJSjiNve504ts2bniSpPCqakF6ATP9i?=
 =?us-ascii?Q?3tBEOHMhnrIVTClKRRzd9pPnAJBpzQiuqITiTwIoeAVVbFI3kFyT3B/4/F3Q?=
 =?us-ascii?Q?FDeVqvSDA0wY9KKVqB0AvqYJVNkdJT8rwXTx/WVhilfDAgjolcsrARH/QLgu?=
 =?us-ascii?Q?JJknQsGnq/3Y5N3/mt6IJlw4hDm6qt8DplT2QBGtROcFoeOsciuTS9tsgj7G?=
 =?us-ascii?Q?r5OEviWS9FJQyRR8Sv9fLLvBFg2HiTlc+8O8cHx8Ra+pb63bsoUY83Cfnqz3?=
 =?us-ascii?Q?CSK+fiy2IC4wtKxE9942As8Q6eJvb0KFph5NUSOoApeMYnvKB2Od86ctFUWe?=
 =?us-ascii?Q?4QHi83dAJFDxbY7SMU0RclXkZa/pxIlQsH7KrYbOxOuAGoesFfyE8aIvY3aL?=
 =?us-ascii?Q?szBX1RLz17tVqHgxusVqJOQOqdIrQJczuC6TJz+bwimAVT95a2M4mQ+SHxoT?=
 =?us-ascii?Q?UGqUGM1Y1RNtSdwnyiSTijLhTYbYAx40axTTt765vy1RDWX1GkGIrWG8CG4Q?=
 =?us-ascii?Q?FTXSceLkUVpyliOHkhWDh01ezHa8huO2dM5/fwMWbw3XM/XxdeCPFUQ3Jfxp?=
 =?us-ascii?Q?4+nXJKZY54w768BdHTpHAQDYsAa9zxaAIbMrPaoCZFUO8bZz/7qTYaNevuFp?=
 =?us-ascii?Q?9CKUz6D2VGa3y+5cdao=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2c217e-c2a7-40bd-1ad0-08dad64da795
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 23:17:03.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/bl6jwSxqeqVf9vgXKmKnAZsokIhATaQyiA5oIfQfmy58GJDqh5hmAGEuXhAWj88A9fNZdE3n28t1JAROrWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we define a number of stubs for compiler-builtin intrinsics
that compiled libcore generates. The defined stubs are weak so they will
not conflict with genuine implementation of these intrinsics, but their
effect is global and will cause non-libcore code that accidently
generate these intrinsics calls compile and bug on runtime.

Instead of defining a stub that can affect all code, this patch uses
objcopy's `--redefine-sym` flag to redirect these calls (from libcore
only) to a prefixed version (e.g. redirect `__multi3` to `__rust_multi3`),
so we can define panciking stubs that are only visible to libcore.

This patch was previous discussed on GitHub.
Link: https://github.com/Rust-for-Linux/linux/pull/779

Signed-off-by: Gary Guo <gary@garyguo.net>

diff --git a/rust/Makefile b/rust/Makefile
index ff70c4c916f8..aed6f7eca36f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -359,8 +359,22 @@ rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
 		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
 
+redirect-intrinsics = \
+	__eqsf2 __gesf2 __lesf2 __nesf2 __unordsf2 \
+	__unorddf2 \
+	__muloti4 __multi3 \
+	__udivmodti4 __udivti3 __umodti3
+
+ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
+	# These intrinsics are defined for ARM64 and RISCV64
+	redirect-intrinsics += \
+		__ashrti3 \
+		__ashlti3 __lshrti3
+endif
+
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Dunreachable_pub
+$(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs $(obj)/target.json FORCE
 	$(call if_changed_dep,rustc_library)
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index f8f39a3e6855..5f833dcca131 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -28,7 +28,7 @@ macro_rules! define_panicking_intrinsics(
     ($reason: tt, { $($ident: ident, )* }) => {
         $(
             #[doc(hidden)]
-            #[no_mangle]
+            #[export_name = concat!("__rust", stringify!($ident))]
             pub extern "C" fn $ident() {
                 panic!($reason);
             }
@@ -61,3 +61,6 @@ define_panicking_intrinsics!("`u128` should not be used", {
     __udivti3,
     __umodti3,
 });
+
+// NOTE: if you are adding a new intrinsic is added here, you should also add it to
+// `redirect-intrinsics` in `rust/Makefile`.
-- 
2.34.1

