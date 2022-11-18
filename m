Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6A62F662
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiKRNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiKRNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:37:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB0167FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:36:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y4so4578701plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x00a1e9-dev.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9XENZamjilAfxElRc/JcTM/cA7kAitnCD65gVj2+w0=;
        b=rI1Y7n5dEOIvDcBXDIt3DjGMOGpGpd+Lj4e1/EkxpvXi805akk6Kt8/6tTkOU9MSeY
         2U6dptP41Ta4XCmdMUXB335DgdWSgo7ZT6OmVd3x/akJi16aPm9Dq4jvsr/DthFbSc5i
         dWNbqJewaRc+oYdMxR0V5em25h9eQQk7O1mOfE55xydZICU9IuzGCEFBDfcCGSIJBMTT
         0qtlfKnTUFlIVvgFGZO7jISWqft5Ot7mmvE/tJZAD3g86MUrX0X+pRdomIwSC+ZxAWuo
         l7SOP0viPtm/D6M5Xor/r3damEqdfg1eafknIE+HfKPfQND5Up+kxOR7Wu5l7nRJ4GY3
         FQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9XENZamjilAfxElRc/JcTM/cA7kAitnCD65gVj2+w0=;
        b=VZgA7zGj/UJhkcL6xUbp5LeJOCYjUbmpV9b9ABSQrkUGjE+xPY72LyKXGU5cU1atj3
         ZYP0qQw4eaug1WMxF++M9rBkXIXmuBiH8rvGL8SQrqUXUYjlHKtMStBAWzdpRtETVOcs
         P8AaWg7wcgWkkq3AeUwOlh1RolAJp2kO9RXUfCVxminhwrsyDCAwo2i0qxVyhFWno+Nd
         4eChLgmdeTyArjerqwvisaCBtoZfCmxXpCYxUm6vwaA8ZKaUxKUCZug45MHD60y1H/+E
         jeRXXujKT/+w/Zx0rwY7u/JZ36KPA8M1HHdn4/CfqbuyaUYhggJ5SYvr0RD4GFsbZIxN
         mMxg==
X-Gm-Message-State: ANoB5pm1hY1UUDmZh0V8MenY88p+ikOxII6WFYlro7Rlscg8N0GEjTpp
        QNoCVe2M+NWeCqY8zDvwPwyw7S3B8Q2eXCWr
X-Google-Smtp-Source: AA0mqf4PB2HuIt663tgUGhC0vN/toaGZnDRYM3aPwXNvcVpL7FystqTtS8+t9deXRANPji2yTE5uIQ==
X-Received: by 2002:a17:902:d4c3:b0:188:d824:5c9d with SMTP id o3-20020a170902d4c300b00188d8245c9dmr7494545plg.163.1668778599019;
        Fri, 18 Nov 2022 05:36:39 -0800 (PST)
Received: from localhost.localdomain ([2001:200:0:8802:c530:27ff:3bde:eaa7])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b00186b04776b0sm3688316ple.118.2022.11.18.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:36:38 -0800 (PST)
From:   Yuma Ueda <cyan@0x00a1e9.dev>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        ojeda@kernel.org, boqun.feng@gmail.com, masahiroy@kernel.org,
        samitolvanen@google.com, ytcoode@gmail.com,
        Yuma Ueda <cyan@0x00a1e9.dev>
Subject: [PATCH v3] scripts/kallsyms.c Make the comment up-to-date with current implementation
Date:   Fri, 18 Nov 2022 22:36:31 +0900
Message-Id: <20221118133631.4554-1-cyan@0x00a1e9.dev>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in scripts/kallsyms.c describing the usage of
scripts/kallsyms does not reflect the latest implementation.
Fix the comment to be equivalent to what the usage() function prints.

Signed-off-by: Yuma Ueda <cyan@0x00a1e9.dev>
---
 Changes from V2:
  - tabs in the comment into spaces
  - `scripts/kallsyms` in the comment into `kallsyms`

 Changes from V1:
  - Fix typo

 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..46d1afaaf4cd 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: kallsyms [--all-symbols] [--absolute-percpu]
+ *                         [--base-relative] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
-- 
2.17.1

