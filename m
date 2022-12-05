Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67964374B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiLEVtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiLEVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:48:50 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2105.outbound.protection.outlook.com [40.107.10.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC29B7DA;
        Mon,  5 Dec 2022 13:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ/3P95dJVUSyZoLJttAdGBTruLcvX1wbSnPH8MBhUr9ymDNfLq7Zpno3JVGrctoVu81E2meEqKnVnlPxd9bM60A3ZEDZSnhsCzDUW2I2HjPJMNRR8N0ao1OG79/z2dZF2tTenWzoxDYWIGdoyXUl/4h9g5WVOmH6owhUMRKQT3vi42HjY8n9B3037qllA2PmRJ1cfOJxVxlo/2AOiMM76zsj73SArCjwLVCpma1UvB/itKibgNZF+CLg4zHRKW6GnciEfO9XCJuEYp8na33yFROyuEwmvzJ6yjBDDqEIftqxyQ0ja4nHtq0AEW1hp0bbYwFNplpm8lb2W3OK/JosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US1Ylm3U7PkQhFJKbC6A/ypJsfqawY4iQ2uFk/l+qMo=;
 b=Xv1MmU643QkPVlBjUDFwnvl1N0RPdkKaumR2bY7b+EbVg3Zr5wEwWyPXJGml3Al/igg9+rEz2OmC2h6UMdqVCcITadvJTuZyhxCOx7rCI8id18aqgsmdwSrII4Xuu+1/UPjXb08qrZIayX0sJ+kk9kAr3hAmvM+y4/gH8d4TULlZufSx9wwBhxch6gOWJFyxoTsS91xD4r+zYG54laDd0D0wCLb1HZ/eUzaBMlrnCtijDhQ8aQtfSPCbKIpQALh3Itf+chRE0RZzxY29jJnFUIGTt9ltZ/6lUCPNSsDaC6YT2yKss6zfRDQYjRox5Rgt+tjLo7sd+YiEboDzERfRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=US1Ylm3U7PkQhFJKbC6A/ypJsfqawY4iQ2uFk/l+qMo=;
 b=q3vyjKVrefvB5ZOGKpm+Eavw+2r4LtEvbK91LrupeCPVdGj6rDhCIbahJyWNkHy+tHzr+AMOEti38pnCSY9HTTPydFbbqzaUOWhMBLLXwX1zh6AexOLaM/JbnZUdqLZyTDlEBMp4VwcvSxyoT64fesrU5e/m7VOjm5SLFJ9/dlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6238.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:45:13 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:45:13 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rust: compiler_builtins: make stubs non-global
Date:   Mon,  5 Dec 2022 21:44:54 +0000
Message-Id: <20221205214454.2542888-1-gary@garyguo.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: aca7cffe-d9f0-4d4d-3cf8-08dad709fd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9un8E5ySsFeTROi/ZfkrO5WMiB8/9e4l+qCPcU/UvL/96yevub4Ry6NRoGco9txSY3CQYZVmQXtFqrIZWXJJCr8WqeGPPDO8Izv0727afaU3Wz8kXO9B5QDxkO7wwPAaZ7Z1MV+go6PofRFPwQDvXb7qzKncQXlkVgX71uqdbOwp6wNuIYL/zofAeg1l3B6KiwpgOgWqOf5jESz3Ho5zuH+z0M9f+NodxOXrop5ovqNkx8y5DNV10QpE0akvBBIH2yeWSAfg0Gwd8ir9MrfwAPo9jdTVhE1RymF3uyiGVOqXQ2q7jBIawH+lAcVKoBUCePj/SYCEdXfqulMEyH68pYwx52kyhoYvc6VGkQAD1nVQ3NXMelrEYaiMV1EUk/bE5gfcd3X78+uRERFiKCCb6zul+rXTokeI5WH1k1hcorO8CTlWWRLkrMXYyXEusxpG4pocp9iRaAjhV7ZiYmp2InGg5ZdYPGz78EkH4us8Esv+LkpXtDortrReeHmFbMygwubgN1H1iUBHCON+cNanZjGTCbX//37RYLfn8zR/zuOjTRZgoKfhaMFvPKEdCMxPshMC+3y9L8G2BdbYbtkwZwyh78c9NmiYdPUh+rPyoj1EoG0M/cHxxvgsKGlbtlvED1CbNKcVqePbAWkA1+FAy/d4/uPl25v8Utaxx1TVn50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39830400003)(451199015)(36756003)(38100700002)(86362001)(8936002)(2906002)(41300700001)(5660300002)(83380400001)(478600001)(966005)(66476007)(66556008)(6486002)(316002)(2616005)(66946007)(110136005)(8676002)(1076003)(6666004)(186003)(55236004)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?alfLTapgbApl0uy3ah/Y7f39Znh6EFLB1xML/xc9AddgPAPXgUHkNih+zdEw?=
 =?us-ascii?Q?fDxKAJx0pFsk6WdKGBtY56iRWibMa4wOWh4YAqQSHFx0z17qMaypB6L47ikF?=
 =?us-ascii?Q?+RfjFxHLyf6PtnC3PkTQo1C06Tp6KTphyE4FoBLFL2NjqOmT6bL+FEpYI4iM?=
 =?us-ascii?Q?SJ1B5Op9TH7MGYC4VGU6Tl0MeqlfwyUaCqWtd5ggqCdh4hR5IFhC2KyHT3dU?=
 =?us-ascii?Q?iSW8CujF/eIOAlX9tL3m3jQBpb59/kQg0Ce7yd3+p+3YY7t0/eYZX4mmkBut?=
 =?us-ascii?Q?BUqzvt0noCro77UongOAeCswW4TLN9OJymBmwo3NGLDNLDY4oqOhQcS9GPE7?=
 =?us-ascii?Q?Zqe3Ih3TgOUjpK17rVKeDgwc0XH281I3q4H0EPMyYrSM45kYW3VDzbUdRsx/?=
 =?us-ascii?Q?18XzWlbhmtJR2SgeA3evbodJWDjDCXuxb1qJLTEJFscUq+pXNXbEvb8AqVfH?=
 =?us-ascii?Q?N6UoKx4lpVWNPbkvcbA/pDG7bWyjVUKxr2/csl0ODni3BKs67gCUiCItncB6?=
 =?us-ascii?Q?2oW3UQSR9XSqvfefuiw24OAAHiYa0pjgpoj17CkvoClOTsX+/c6idg7Q8C0R?=
 =?us-ascii?Q?uxRuxAGLdiZ0nJ7b46+hg5dX0eTADD7tYm9xF/DH8KCMYNePiGg87r9YpCfx?=
 =?us-ascii?Q?+NgaI/3lejpvKdCyN2w96OwY9rfnUvECOyzSEuRTVxFo39/56ymvUEsI/o2t?=
 =?us-ascii?Q?hwvMSyOY3YhHhf1bOglnhnVEYO2jb4I6mfCTb2fJB8ai3EFmklDJossDWbOL?=
 =?us-ascii?Q?tJsVp2IFIKjDVl+QaKd8P5kwvBFFa4fA/ojbwYMhNvSGjK4iPT5Pf/GvFlR5?=
 =?us-ascii?Q?+gP8fHN8sqWvAqqGBvyuUWCOX8y6B8SySJImhiSQikMIm6Kklj4/ydhZe2++?=
 =?us-ascii?Q?E+p4/Kdc0MDXvnwILSGgZpNI8KfgSUBuwX/F61uTR2CAbftNRdlNoCbaSTjo?=
 =?us-ascii?Q?HJAYWBN/lGE5t8GodQyasFBoZfe8brcIw/4geeWc7fIgjPMT0ChQYXDwA4V6?=
 =?us-ascii?Q?d+hmpWWmlliZQtvwqUYEt+qoznI+4CRBQTheBir+/vDmy+vVqLl+ojJrML99?=
 =?us-ascii?Q?lvD8uf8wxiR5SyyXa5pse6oO+LhKIJiEJTrHDEdI9CDeXLUonRVRLX9kL9LG?=
 =?us-ascii?Q?Bhw4SA7HoUaVuplh8wPAFQArVvOP7OUtbb84NQMAirZjPsnmQY5AXC8hVLtf?=
 =?us-ascii?Q?xlh+L+9+LDG99gKCz0Z/S/LtqZHyBeaWAjkks0gNWR6hQ8dQ/m0BH+Zs7rQf?=
 =?us-ascii?Q?xrPTBNMhwOZ79miiH2u5ZSPvfZiZsS6GH6LmEi3HUSie2NeUW8L2Tn+3frGH?=
 =?us-ascii?Q?hsvsVHzdbCrwT2AbnpwM/uefnn4hMXzdqYUXF+uBsV8WMSNVsEtJvCSuti6m?=
 =?us-ascii?Q?5S3uWquVDCksqgce+reDfGSSI/uy5mrGLVE5c+U+7wC2730c9Lx3y5767SQ1?=
 =?us-ascii?Q?PG8BWJiU5IQtOv1mCUfHepwHajbXoqTa2Z1rRDlTjMI9uAaC3oT30Vl7d7bp?=
 =?us-ascii?Q?vMI+e0ZJN9hWuGg4bUahA8bDa0ssZ8vm6bhOSAYdbAV46L4fLTHTvFGcRoYz?=
 =?us-ascii?Q?aKAvRmO/jiWFdrE4HK4=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: aca7cffe-d9f0-4d4d-3cf8-08dad709fd93
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:45:13.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPt0UXNnTo3iq10W0fT2cVZI1+Zrik/0apmt1/ORmLfAMouP0j5mKvoBFgTZasGEMeOAcD+jQ1EnmjeBNqQkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6238
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

This patch was previously discussed on GitHub [1].

Link: https://github.com/Rust-for-Linux/linux/pull/779 [1]
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

