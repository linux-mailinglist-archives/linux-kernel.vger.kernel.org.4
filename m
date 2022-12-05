Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627D864375F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiLEVvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiLEVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:51:25 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on0718.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDA766F;
        Mon,  5 Dec 2022 13:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU+7+wCxiOyUu62972QvmHeJkJTmBqrxCKEgyGi6+CcwO/lUASZADqf+RoesJe0FIX3tp29ajj4/adRQhIGZem7Ie5OYgWUyfQNfORTHAV2GrPWUutWmRDxyB3Z5ei70r0Ns0HetPo7Lsr8QuUZ6dxvc2I+oMwqMK0+hxSJcuvbMd/4h9YFsGA7gEmNT/EwcllG/4s0rxgizdmj9w71jMeC8/TfRWBtiGT6Jc5YJOtmg1KSCnp0B3mIkLyjFy6X1CJkKOsMQ2SA9GF876Tf5j0CbSJGcsyi0k9PKhKwMLzjMaqgT9VxNILy+vuixafiGIdTJ3Z9Hl44S9XZL/VQo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HutuBfseF8+fbw5cXCGK1xdciMWeZsnZ28w1ftJ43PA=;
 b=IWWLCMaUFyfirGg29oLrZEHKL+OVupdQcJUCvbyi38QtZCoaC72wWysWuH5rfwcfJJsETx62rRrxOu/QzVrO0p9MCQ0lMWl0Hmavou2q0eqae2e7EHz7vuIIdhcj7GteJ+Cgdwv7Bi9j3kw6We3wiidg42VOdQ+BakTFqO2gcHk6Ya5EkYToqpZLniVDLLzup0FtIbT4hBrr69rjUlbeHbbPiegSIJxhBQcVE3xvt8/Q8bFRItZHescSuM56wllwp6rnVw+M+OMqkvMwykuQ4qhMfFu3eKscfTB1yof+IqU06rTqLaCljtHhoVzunvu+x/pfbUFSafONT2rjRpe8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HutuBfseF8+fbw5cXCGK1xdciMWeZsnZ28w1ftJ43PA=;
 b=ZIvfZcAj3rIUr1DJSE0ci4aqqrrk2JbLUKrc4PLKB2bw/XYiLIsCn8uC5l7Ds6D90j1ii9ez2rLtdLIhPOQR0lWOpz4PcY8YPYlzlCqqdK36gfALuwqjvGptC2BocvpFVqQvAvy1mbWekYejFWRGRwqHZycaAfl14mnXfCJWbWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6464.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:50:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:50:15 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v4] rust: compiler_builtins: make stubs non-global
Date:   Mon,  5 Dec 2022 21:50:00 +0000
Message-Id: <20221205215000.2563281-1-gary@garyguo.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: da49c94a-19b9-495a-e357-08dad70ab07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/oe65gUR2QvFohHte7+xrvXAGI1rbM4C1WvHN/FJRzBTlkVYOpX9t7vIHiSJjRu9dJoeve+oyQmdgLv4BPjYMi8N17oICFzZStTQSZjwYkEL9GgxyX3tSOZlqOUe+BcjiXCzLndnnc78l1lPfebVa6uyCpBerX0VhysJnoOMhcYP4hcBC0ANOEUgGzAIYwoQqnmpeJoxJTEa6a7m9ShA+EZpZZn8ThJlvq9p/Mw4RDHAJzWyWz5dLv6JfM+by86K39qiCkrIZaILSu979srvHQUSAJdXt6A+QlgPwEChoWg5UOzuRyjW8OWRrNxsA8m2lcOWKviapjNtMy2R9rERH9yBMw/qNyYaI6arcMwFW++FWIuFtJBCmr82oPE3BV+ptmwwhFJFMqbSQgTGvvZ/dglNGwV9FiRlXjGCuc2qgYrIVKZ7MMuBOr+f01/zl2dcR0Ae79J2LaHzUAXRH/QJELgUHBFYAKtV3OwiCMXwV727yhAbcyTHUR5UeDH22JmVXeBvEUq3oMKQivWZ8JcLgD9LcsPOJuKu9cgORf29mWbY5aj2kdnw6bKSeVjU37FLgNRq5pGkUL4G0yGOwCG4eSL4PcKekd8s/h1iVOLTrgRXFWCapsCq8gg3ITfHmHRkfnvzZSKqq6ehS93aYaQWBGJN3WvXLwtlRrucvYT0V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39830400003)(451199015)(36756003)(38100700002)(86362001)(8936002)(2906002)(4326008)(41300700001)(5660300002)(83380400001)(478600001)(966005)(66476007)(66556008)(6486002)(316002)(2616005)(66946007)(110136005)(8676002)(1076003)(6666004)(186003)(55236004)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndrWK5/P2T+gpSd8DUW8crakHKye4icV1PpR1QvYOKkA4vb2mEn7MSwW6Vpg?=
 =?us-ascii?Q?2LOZMRbhe2RtH8Vfa0lnpgpGvSbZJ+K36DpJjeEGZuuNjMLGFSwk6kYRj17R?=
 =?us-ascii?Q?FEwOG8YC3nlK0reA5RHvljv7BcOolegdA6O+N0zuPzc7eu/+ln3rDNP0TFtZ?=
 =?us-ascii?Q?ephJcox69E/hFJ10PT13j83YpZ3+5BrCYq/x7Zr9DN3iqORwNcrSiPn2WpbP?=
 =?us-ascii?Q?jMuhol3fqSsHF56g5idW1ZQlQ5ihNfxwCxcqCB/4DwfhMQGDfrm1rD3//Gok?=
 =?us-ascii?Q?WkwpQTX8SeM1B7khtQfwGoEaVX4yPoPMAa5Fw9Jlmm8K2JK18UhWRgHQh+4B?=
 =?us-ascii?Q?4wnwPbQyticRg8Q3bN5/kurlz0Mf/l8g2R77BxGk9RPbP6j3NO6LN2V/jewX?=
 =?us-ascii?Q?jPw6Xm7Cz3G8x+ysQ3twEqMkNqUxbuT3E7qB69BGsbxjoixVb7c3CcCY0lnN?=
 =?us-ascii?Q?zvNzjFnJSsuJ8s6G5bdWF5Tc7+2y/d9HbkJtoW0nbr59OLF8mxAutfQ48q8P?=
 =?us-ascii?Q?XFqkjWXJuXs2e24m4xzfphSkVqVrSkM1QiLHCC4yfRlEeXWOI2BxSO/5bi/W?=
 =?us-ascii?Q?N7+M/XHLhn484YYLodY6tLV6x9o0C+ZaPRF0CKMA0C/JpGeGU1e3ZX9pOKVw?=
 =?us-ascii?Q?lW+TIKYFUw8+RZRxKax8qd6yTPCrwrQhMX24aBv/W1/aCTWDWXSDbLKHCFin?=
 =?us-ascii?Q?EYNZN+716sFj2kcY/IONqS4xcvhyquMv5Yy+Bbm0+IhJLa55EQ2EVEqIsxDu?=
 =?us-ascii?Q?NceGjF8GavQ6nTo0ZjuC2wd5KUxEH3rMi4FyPIHdAp3Rrvl9jQr5ElPpjA+n?=
 =?us-ascii?Q?4Ajm9C0n9H85UIodyHXY2vx/1TqAo6NJlFtvbf+j6qK6W3x2Nh5kvBFDxvRA?=
 =?us-ascii?Q?ei7Sr3/8llIwLqK36szkikdJoZ8sQvNWFcJx1s3ALxmdOH/5hc5wISB98oep?=
 =?us-ascii?Q?Jts+Fk6zepLPI+0GlQBkw1qFSza/26/9GPivtC4tDxA8cDQmfM3iI19AshpM?=
 =?us-ascii?Q?tgOx/EwkAVIRY9fqKJcRlooOq17Xen2BkEUq8/6qyxJ2+cdPNB+xRh1wRGCN?=
 =?us-ascii?Q?jLPiSidwm9YK6TveA2VJRvKYxzUeWUBqHLxicCUPsDFys0JNBIiROW/eqOJp?=
 =?us-ascii?Q?0uK6m/YGi04/48xGO4YA2dNRprCwmfztpeesaUFhPt5Z2rZIABRSnq1l1iqM?=
 =?us-ascii?Q?vKLhSLrGvS/S4/qhVxpejI90KXWP7Bo3Q13DpGCQyb5u7pSsVc3WUQishVl7?=
 =?us-ascii?Q?wQ0sXlYk3Eep3QPSk5wq/j41mEaOsLs1xGq0AI9Bny2hC+D3fUHn7d07yFsZ?=
 =?us-ascii?Q?IniiKxPq3NQVQ16dVFDpe/x1AbM6MCOoRY2QMNpfdSLJiPJ+78oR/8mG9Igj?=
 =?us-ascii?Q?WwX/S5syr3C2IZYLV4aRc6liQlnpABFDWTwFo0S0oQZhUvgrAbSJjchVvZ9d?=
 =?us-ascii?Q?08QkHJ7dfRMI0AAoptOiV3uHBozY/dYasLjKLciKX/t15K1uyMXHTBs6Gsv9?=
 =?us-ascii?Q?VWCRO8GJu2n377HThZE/O3SvMSwg0KQHcoh/JZDu4ZrGkX4a88xPMAFYLH5n?=
 =?us-ascii?Q?T59J/y9t6GguYTT88qQ=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: da49c94a-19b9-495a-e357-08dad70ab07e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:50:15.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdNVIlu39xAwXvsT8qUMrLZSkSOtD6EsFkl12IkY3ZiCrH03BvtDZOjCl+Cdr7KyDr63NcK83n0AsPiLGTJeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

This patch was previously discussed on GitHub [1]. This approach was also
independently proposed by Nick Desaulniers in [2].

Link: https://github.com/Rust-for-Linux/linux/pull/779 [1]
Link: https://lore.kernel.org/lkml/CAKwvOdkc0Qhwu=gfe1+H23TnAa6jnO6A3ZCO687dH6mSrATmDA@mail.gmail.com/
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile             | 14 ++++++++++++++
 rust/compiler_builtins.rs |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

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
index f8f39a3e6855..43378357ece9 100644
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
+// NOTE: if you are adding a new intrinsic here, you should also add it to
+// `redirect-intrinsics` in `rust/Makefile`.
-- 
2.34.1

