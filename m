Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDE655159
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiLWOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiLWOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:24:58 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA063EACC;
        Fri, 23 Dec 2022 06:24:57 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 959477E294;
        Fri, 23 Dec 2022 14:24:52 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671805496;
        bh=36kRhPHHUdU7fJ7TrqmVEqnC9MhObrpC3zL5rKf5PmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QY00C9VEs5iLtoDJTH60avD25mN1yk8Wh/CY+oLn0a+zSoFrI4UfpRDls0UyuUywx
         jLNt5XArojl5fzAp5z40SEIycAz5sbVJpuaPJUT1A+2psgHQ5qWZ8K4j0mBa5qgzQs
         8T5fEZgUGLQjbHKkoEPkKal8ecW4B0yEi2iuY7yBvfA7287RD49l0I/jLZtXyNQQ4g
         ch2de72lD9hJQBHr3vpd4e3OYeWcJtWcUi+5Suqzg/4KKL5Wp2jBI01So9WPNJVEDm
         Xbc67OaO6ArnP0WKHn8T4q2B/pDY1cPaONyYDyBqv9zrbd9jTVwKtGP8U6UeBaTMsj
         wzFNgLwGcyhTw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Len Brown <lenb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPICA Mailing List <devel@acpica.org>,
        LLVM Mailing List <llvm@lists.linux.dev>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1 2/2] ACPICA: Silence 'unused-but-set variable' warning
Date:   Fri, 23 Dec 2022 21:24:19 +0700
Message-Id: <20221223142419.3781410-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223142419.3781410-1-ammar.faizi@intel.com>
References: <20221223142419.3781410-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

@num_carats is used for debugging, passed to the 'ACPI_DEBUG_PRINT()'
macro. But this macro will expand to nothing when debug is disabled,
resulting in the following (clang-16):

  drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set \
  but not used [-Werror,-Wunused-but-set-variable]
        u32 num_carats;
            ^
  1 error generated.

Move the variable declaration inside the else block to reduce the scope,
then add '(void)num_carats' to silence the warning when debug is disabled.

Cc: LLVM Mailing List <llvm@lists.linux.dev>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 drivers/acpi/acpica/nsaccess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index a0c1a665dfc1..d73d052c5b3b 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -292,7 +292,6 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 	struct acpi_namespace_node *current_node = NULL;
 	struct acpi_namespace_node *this_node = NULL;
 	u32 num_segments;
-	u32 num_carats;
 	acpi_name simple_name;
 	acpi_object_type type_to_check_for;
 	acpi_object_type this_search_type;
@@ -394,6 +393,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					  "Path is absolute from root [%p]\n",
 					  this_node));
 		} else {
+			u32 num_carats = 0;
 			/* Pathname is relative to current scope, start there */
 
 			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
@@ -406,7 +406,6 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			 * the parent node for each prefix instance.
 			 */
 			this_node = prefix_node;
-			num_carats = 0;
 			while (*path == (u8) AML_PARENT_PREFIX) {
 
 				/* Name is fully qualified, no search rules apply */
@@ -449,6 +448,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 						  "Search scope is [%4.4s], path has %u carat(s)\n",
 						  acpi_ut_get_node_name
 						  (this_node), num_carats));
+				(void)num_carats;
 			}
 		}
 
-- 
Ammar Faizi

