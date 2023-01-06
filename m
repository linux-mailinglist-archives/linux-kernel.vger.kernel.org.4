Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B53660A6D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjAFXxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjAFXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:53:26 -0500
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC377ADE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:53:23 -0800 (PST)
Received: from myt5-8800bd68420f.qloud-c.yandex.net (myt5-8800bd68420f.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4615:0:640:8800:bd68])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 006F4603D8;
        Sat,  7 Jan 2023 02:53:21 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown [2a02:6b8:b081:a411::1:0])
        by myt5-8800bd68420f.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id GrjGHk1QfmI1-jOsvmmwv;
        Sat, 07 Jan 2023 02:53:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1673049200; bh=/XBs1WOG92WdqAPsxP3UvFcRV9WrH7qoeiWMRR4XqwU=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=D9peeyCopzp39Z4vZ8aLrE1BZhLXdnat20tJuI7JEUnNvQ6qEAETcZAEPluWH0pjz
         4rk1xvKhcfya3QoG50pRULVgsT2o1Rm6cWEHK0blHTA0kbnt0XJamnojRCQNS93N6u
         ZAt1EgzVbbh4CaRW0ygNxaErqhGNnfaU+WDMBUuY=
Authentication-Results: myt5-8800bd68420f.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Daniil Tatianin <d-tatianin@yandex-team.ru>
To:     Robert Moore <robert.moore@intel.com>
Cc:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH v0] ACPICA: nsrepair: handle cases without a return value correctly
Date:   Sat,  7 Jan 2023 02:53:08 +0300
Message-Id: <20230106235308.99999-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously acpi_ns_simple_repair() would crash if expected_btypes
contained any combination of ACPI_RTYPE_NONE with a different type,
e.g | ACPI_RTYPE_INTEGER because of slightly incorrect logic in the
!return_object branch, which wouldn't return AE_AML_NO_RETURN_VALUE
for such cases.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.

Link: https://github.com/acpica/acpica/pull/811
Fixes: 61db45ca2163 ("ACPICA: Restore code that repairs NULL package elements in return values.")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 drivers/acpi/acpica/nsrepair.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 367fcd201f96..ec512e06a48e 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -181,8 +181,9 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 	 * Try to fix if there was no return object. Warning if failed to fix.
 	 */
 	if (!return_object) {
-		if (expected_btypes && (!(expected_btypes & ACPI_RTYPE_NONE))) {
-			if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
+		if (expected_btypes) {
+			if (!(expected_btypes & ACPI_RTYPE_NONE) &&
+			    package_index != ACPI_NOT_PACKAGE_ELEMENT) {
 				ACPI_WARN_PREDEFINED((AE_INFO,
 						      info->full_pathname,
 						      ACPI_WARN_ALWAYS,
@@ -196,14 +197,15 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 				if (ACPI_SUCCESS(status)) {
 					return (AE_OK);	/* Repair was successful */
 				}
-			} else {
+			}
+
+			if (expected_btypes != ACPI_RTYPE_NONE) {
 				ACPI_WARN_PREDEFINED((AE_INFO,
 						      info->full_pathname,
 						      ACPI_WARN_ALWAYS,
 						      "Missing expected return value"));
+				return (AE_AML_NO_RETURN_VALUE);
 			}
-
-			return (AE_AML_NO_RETURN_VALUE);
 		}
 	}
 
-- 
2.25.1

