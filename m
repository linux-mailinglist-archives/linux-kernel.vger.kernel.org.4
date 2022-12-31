Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4A65A582
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiLaPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLaPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:24:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D49A445;
        Sat, 31 Dec 2022 07:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5D53B801C0;
        Sat, 31 Dec 2022 15:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B453C433D2;
        Sat, 31 Dec 2022 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672500260;
        bh=F7IzcujFn2mgQzAY4UyS1F5vbPOdzr0l1GqQEExix3s=;
        h=From:To:Cc:Subject:Date:From;
        b=qOOOpVOuHnq8TlA209P7UUv+pc8DVCBNPDXou86Gxi3NLEDUWaKBKIpcyzgLPpCas
         JG+7wTlrvefVG0vmyTw0faWXS5cRQcoTDftVH/dru6rb8hZDZgDdPVfrkibB84rwiV
         5Ek7de0S4JsUgaK9Uoi/uhs02QsldNvEPwlmztvLAeBt+tZkZwzecm2BhZDzmMTKOG
         6kZqCPdMq1kWuIfgJSLUDLygx97DE7gSV/OstCFJzS5vfy45BoFjPfPN94cVz0x3GK
         99Vz9i2BFM1+HygTEIQf14e/NA5FNvB97md25/Z43r8ASIIw+FvX1F4j4wKbyhlLQ8
         fGxrvudyHcxEA==
From:   Conor Dooley <conor@kernel.org>
To:     corbet@lwn.net
Cc:     Conor Dooley <conor.dooley@microchip.com>, broonie@kernel.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: process: Document suitability of Proton Mail for kernel development
Date:   Sat, 31 Dec 2022 15:23:21 +0000
Message-Id: <20221231152320.1340874-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=conor.dooley@microchip.com; h=from:subject; bh=jx0XIn3vUX7lM+mkiSSNWe+lKBl7AInKAMIjrDZYcw8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMkbgp9Pv/d9Q9tNJb4co9jju259OnniXe93Jp5ljg/qLjf3 xZRO7yhlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEPNQY/ik/D7rZPFt/0cQtL1lyXu p/j6p//LZOwa58I8Nf55yPiwwYGfa1LMza4+8X3u6q8Wn11ZjUo6u2eGiwvUm/7lzlF5JiyAwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Proton Mail automatically picks up PGP keys for those with kernel.org
accounts (and other domains!) which provide WKD for their users & uses
them to encrypt emails, including patches.

Document the behaviour & Proton Mail's unsuitability for kernel
development.

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Add section about why encrypted mail may be an issue
- Use Konstantin's wording about the bridge.
---
 Documentation/process/email-clients.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index fc2c46f3f82d..471e1f93fa09 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -350,3 +350,23 @@ although tab2space problem can be solved with external editor.
 
 Another problem is that Gmail will base64-encode any message that has a
 non-ASCII character. That includes things like European names.
+
+Proton Mail
+***********
+
+Proton Mail has a "feature" where it looks up keys using Web Key Directory
+(WKD) and encrypts mail to any recipients for which it finds a key.
+Kernel.org publishes the WKD for all developers who have kernel.org accounts.
+As a result, emails sent using Proton Mail to kernel.org addresses will be
+encrypted.
+Unfortunately, Proton Mail does not provide a mechanism to disable the
+automatic encryption, viewing it as a privacy feature.
+The automatic encryption feature is also enabled for mail sent via the Proton
+Mail Bridge, so this affects all outgoing messages, including patches sent with
+``git send-email``.
+Encrypted mail adds unnecessary friction, as other developers may not have mail
+clients, or tooling, configured for use with encrypted mail and some mail
+clients may encrypt responses to encrypted mail for all recipients, including
+the mailing lists.
+Unless a way to disable this "feature" is introduced, Proton Mail is unsuited
+to kernel development.
-- 
2.39.0

