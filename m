Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CF6F679A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEDIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEDIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:36:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42B9B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:36:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8909520987;
        Thu,  4 May 2023 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683189365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XgjB6XJ0AGs54auI6LivfCPrFOnxl18R787CYwDjcX0=;
        b=cSY0jaixd5QiKyYBVh8j0w75M6k+osqRjoIFlL58OYZCs0JQtxVIT+MQCGhbQ+iYVqijDY
        gZBcP7BrBC/Fd41vF5QWkdTmYKcEQYeTzciHyGP1hasfqXNquarn2IQ82cddvTYIi6WVYS
        v7Ctf0nFoTpI2mHPKUJg1Vfb8FTpowo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683189365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XgjB6XJ0AGs54auI6LivfCPrFOnxl18R787CYwDjcX0=;
        b=/QNJ1ivHB1UKNvVeVWweJkdgqPQsc0Nbf8+VdaS4rFf8xILAfdxvFwLQhExrUJ70Q6Spma
        2/dqW7Qk+pemV9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AFF113444;
        Thu,  4 May 2023 08:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TGvkEHVuU2TtOgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 08:36:05 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, sam@ravnborg.org,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: [PATCH v2] uapi/netfilter: Prefer ISO-friendly __typeof__
Date:   Thu,  4 May 2023 10:36:13 +0200
Message-Id: <20230504083613.3789010-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typeof() is a GNU extension, UAPI requires ISO C, therefore __typeof__()
should be used.  Similarly to 31088f6f7906 ("uapi/linux/const.h: Prefer
ISO-friendly __typeof__") use __typeof__() also in x_tables.h.

Fixes: 72b2b1dd77e8 ("netfilter: xtables: replace XT_ENTRY_ITERATE macro")
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add Kevin's Reviewed-by:
  https://lore.kernel.org/lkml/f8bd4212-9cca-03ca-884a-c9dec63bb256@arm.com/
* Update hash to 31088f6f7906 (Kevin)
* Add Fixes: 72b2b1dd77e8 (Kevin)

 include/uapi/linux/netfilter/x_tables.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
index 796af83a963a..d4eced07f2a2 100644
--- a/include/uapi/linux/netfilter/x_tables.h
+++ b/include/uapi/linux/netfilter/x_tables.h
@@ -172,11 +172,11 @@ struct xt_counters_info {
 
 /* pos is normally a struct ipt_entry/ip6t_entry/etc. */
 #define xt_entry_foreach(pos, ehead, esize) \
-	for ((pos) = (typeof(pos))(ehead); \
-	     (pos) < (typeof(pos))((char *)(ehead) + (esize)); \
-	     (pos) = (typeof(pos))((char *)(pos) + (pos)->next_offset))
+	for ((pos) = (__typeof__(pos))(ehead); \
+	     (pos) < (__typeof__(pos))((char *)(ehead) + (esize)); \
+	     (pos) = (__typeof__(pos))((char *)(pos) + (pos)->next_offset))
 
-/* can only be xt_entry_match, so no use of typeof here */
+/* can only be xt_entry_match, so no use of __typeof__ here */
 #define xt_ematch_foreach(pos, entry) \
 	for ((pos) = (struct xt_entry_match *)entry->elems; \
 	     (pos) < (struct xt_entry_match *)((char *)(entry) + \
-- 
2.40.0

