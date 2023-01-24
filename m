Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149F67942A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjAXJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAXJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC13BDA6;
        Tue, 24 Jan 2023 01:26:42 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hs6Gt3G7vzGof1pAkzTdwmtY96iWMmkidqX3PCTzQW8=;
        b=eRawV1C+eMkN9NZ0abGsG3Ucugkj57N0p+7vof+Hjl+cFl6d+YXx1eaDXAVRmhAH6zIINn
        bbn7l6yELR8/Yyf6KLEsMXXhZxetBJ7DyKhVB/2HUz6RE08cTENInthbtgt7jCw7wQCTMz
        tZCOSLTnjmUM6mZwiR6Pk8JyGGpgs+lKOxnw8wTgCnthWTY6COLZIu9zYkpz2EfSdeBSk9
        mOWDy6ca9FPrdt9XO77eJFgaueB9GU7LBnWafo/XHve/AR4p205RtjQ29PHpIUKHSu9pIr
        Yj18tOhm6wgY62sA95EjsV4m/B2VxiYgNVkdhjiTNWSQ+gQjsISt8R/K6kbMSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hs6Gt3G7vzGof1pAkzTdwmtY96iWMmkidqX3PCTzQW8=;
        b=Vthr4zdStAOqifCNYvJ3eKcdGCvpCfcE5fX6IdMPpJIvfzNjisZ5OtLQav6WbxD87nIcM9
        O//fum4hZ0HzBUAw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-4-babu.moger@amd.com>
References: <20230113152039.770054-4-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239810.4906.3081147401716810165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a5b699665580725de8c0c01f2163a15af78b6866
Gitweb:        https://git.kernel.org/tip/a5b699665580725de8c0c01f2163a15af78b6866
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:29 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:38:22 +01:00

x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA

Add a new resource type RDT_RESOURCE_SMBA to handle the QoS enforcement
policies on the external slow memory.

Mostly initialization of the essentials. Setting fflags to RFTYPE_RES_MB
configures the SMBA resource to have the same resctrl files as the
existing MBA resource. The SMBA resource has identical properties to
the existing MBA resource. These properties will be enumerated in an
upcoming change and exposed via resctrl because of this flag.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-4-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c98e52f..f6af3ac 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_SMBA] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_SMBA,
+			.name			= "SMBA",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_SMBA),
+			.parse_ctrlval		= parse_bw,
+			.format_str		= "%d=%*u",
+			.fflags			= RFTYPE_RES_MB,
+		},
+	},
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5ebd28e..fdbbf66 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -409,6 +409,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
