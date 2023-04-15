Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B06F0B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjD0Rmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244536AbjD0Rmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A5955AD;
        Thu, 27 Apr 2023 10:42:21 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2486921C33E2;
        Thu, 27 Apr 2023 10:42:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2486921C33E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617341;
        bh=UW7ul1bnDEkuT8AVHX2Onz8R55uQ/uJg/sKB3VFIxA8=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=GliyQuKW8oGgjFC+cLdORseF/SjeucGpIWTeHmMqR/KK+I4hETWbTsw1knbYRh+ZR
         MAUHxIEfXAJKc+C+mHa5zeINLp0UrkYuhHWGUcDUmjK65ZhaWGnbgn4HjG5NdbtxYG
         zPBjIck4JhL804V8kj1f5FBRY43HMXKgC5GxUAzs=
Subject: [PATCH 5/7] ia64: asm/io.h: Expect immutable pointer in virt_to_phys
 prototype
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:48 -0700
Message-ID: <168155746830.13678.8071954787135972276.stgit@skinsburskii.localdomain>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

These helper function - virt_to_phys - doesn't need the address pointer to
be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Helge Deller <deller@gmx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/ia64/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 83a492c8d298..c56ad21ba1e9 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -74,7 +74,7 @@ extern unsigned int num_io_spaces;
  * Change virtual addresses to physical addresses and vv.
  */
 static inline unsigned long
-virt_to_phys (volatile void *address)
+virt_to_phys (const volatile void *address)
 {
 	return (unsigned long) address - PAGE_OFFSET;
 }


