Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73966E3C06
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDPVHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:07:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524371BD0;
        Sun, 16 Apr 2023 14:07:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 542361F37C;
        Sun, 16 Apr 2023 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681679235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PKKU3+MS92/pmja6nMDu+YDwiC1/ZOfbxi9E0yvlW3g=;
        b=kbw5pWLz5Nogbpr6IS3F36DDE3Cx+wEXt3Chyuvwj+oozDb8xVKRQuKWmXWonz3aWazDSh
        0prdyjfSadg+tBJ3smFTZXZg1wpvo56cn4Ga1ALK58F06uph0zCbaWksCKwvPnTIovmvcY
        2yqM9oeMgferYsU89bgK663v+Ncln+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681679235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PKKU3+MS92/pmja6nMDu+YDwiC1/ZOfbxi9E0yvlW3g=;
        b=9Rb3VVyw2EuVYRTrIMIa5gha9dqIjwHfDFaTPaxjUJSRRYGFE0usAJAbkJVDZQLTA5ch41
        DBr7LkPxgNGZ3qDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A619F13498;
        Sun, 16 Apr 2023 21:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WbBbJIFjPGSCUwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sun, 16 Apr 2023 21:07:13 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] uapi/netfilter: Prefer ISO-friendly __typeof__
Date:   Sun, 16 Apr 2023 23:07:05 +0200
Message-Id: <20230416210705.2300706-1-pvorel@suse.cz>
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
should be used.  Similarly to b4bd35a19df5 ("uapi/linux/const.h: Prefer
ISO-friendly __typeof__") use __typeof__() also in x_tables.h.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Based on [1] merged into linux-next as b4bd35a19df5.
There should be the same Fixes: which we agree in discussion in [1]
(likely a79ff731a1b2, or d6fc9fcbaa65).

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/20230411092747.3759032-1-kevin.brodsky@arm.com/


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

