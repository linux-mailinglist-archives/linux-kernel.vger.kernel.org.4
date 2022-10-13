Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B75FD94E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJMMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:39:40 -0400
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 05:39:36 PDT
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A271D6;
        Thu, 13 Oct 2022 05:39:36 -0700 (PDT)
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
        by wilbur.contactoffice.com (Postfix) with ESMTP id CC4AF1207;
        Thu, 13 Oct 2022 14:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665664302;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=From:Cc:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        l=1945; bh=M9N/7nWDqlxLQOR6V0NKYvTK2UrdV1FKuUtNqKoS8Os=;
        b=iSdfME4dI2biXPD3Zob+E/iABuqzlwyLdEGcO+gCLGr9jseukiO8u8SYFxC3N9IC
        H+r2KL8tniACXYw4oSoe3yoFFIuYhnloytJaRGlY9EJfqhVVHImnKKdif86dOO3CcWr
        X3gRTIzMYYVJwIOwhaZdISIsFjsjNvSBaQQZSsIR+IHUwdGCqjG1UEhpwyPvAsWifb3
        v9XkgPdCVgeDz8FP5nkPGalHy4e8KgbbCk0cln5I1iSZuLSLrRAzV+vEcLitqShft7V
        lND4cyuhC4B8/mkfInIBYyY1u6VjJCml0Up9r9OwkacYl5jWL9R2Y4v8o5haSUJ11pS
        fiCpimHfgA==
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 13 Oct 2022 14:31:40 +0200 (CEST)
From:   sndanailov@wired4ever.net
To:     corbet@lwn.net
Cc:     rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sotir Danailov <sndanailov@wired4ever.net>
Subject: [PATCH] doc: process: add privacy warning when using some SMTP servers
Date:   Thu, 13 Oct 2022 14:31:15 +0200
Message-Id: <20221013123115.17419-1-sndanailov@wired4ever.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-ContactOffice-Account: com:378009619
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sotir Danailov <sndanailov@wired4ever.net>

Warn the user about "Received" headers and how some
SMTP servers use them by attaching the user's IP addresses,
when using some email clients. Add suggestion on how to
test this behavior and how to avoid it.

Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
---
 Documentation/process/email-clients.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index fc2c46f3f82d..9c49f9b33fdb 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -350,3 +350,24 @@ although tab2space problem can be solved with external editor.
 
 Another problem is that Gmail will base64-encode any message that has a
 non-ASCII character. That includes things like European names.
+
+Privacy/Security
+----------------
+
+Keep in mind, that even if you're using a working email client, the SMTP
+server might have configurations you don't like.
+
+For example, if you decide to use the Gmail SMTP server with the Thunderbird
+client, the server will add your private and public IPs into "Received"
+headers, which are attached to all of your sent emails. This is done
+to avoid spam and to check where in the routing path an error might have
+occurred. Gmail's web GUI client doesn't add your IPs, because it's sent from
+Google's servers directly, not an external machine. Unfortunately the web
+client is not good for sending patches. You can check if your IPs are present
+in the headers by reading the raw email source.
+
+If you do not wish this behavior, you need to find a provider which doesn't
+do it or configure and host a SMTP server yourself.
+
+If you're concerned, always first send an email to yourself, read the email
+source and if you see no issues, continue to the mailing lists!
-- 
2.37.3

