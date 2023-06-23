Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8073BB97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFWPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjFWPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313621BF2;
        Fri, 23 Jun 2023 08:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A2761AA0;
        Fri, 23 Jun 2023 15:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730FFC433C8;
        Fri, 23 Jun 2023 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533911;
        bh=PWzWmQ+cBgJK6M6TA5MtMDmO0z6eE5AOkMWX2YVaO2k=;
        h=From:To:Cc:Subject:Date:From;
        b=P5hRm+79D+2sZ4kgfzfW91OywrM3XnOisdudNi2GlRMtyg5UH0fJKk2zIoCvyQc0P
         OwxUG8xC5hN6tuNUjuWTNRak3gq/OOfYS97/iZCng3xsnGxJBupj1nQL4aFhvctmTl
         augdY8OVO3DMh8cmyA8rxuEBFe/VRRgZQOTlmPsUAmYmcvKAUXHz+EIfDEAFO5yorG
         jOArBFZOJ+JaLhy4odrlwAyqdOyzmGfQemDAzuZZPVMFdSw6hqjMbX4XQiLJ8l/Zjj
         z3IgMXZdxB3oDlwbQ0XHp6Lf1srAPR+fS7bEartCAlVGgVq1o5ryKAW6kT7e8BK7jn
         CoDA9RnFTW+uA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] carl9170: re-fix fortified-memset warning
Date:   Fri, 23 Jun 2023 17:23:59 +0200
Message-Id: <20230623152443.2296825-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The carl9170_tx_release() function sometimes triggers a fortified-memset
warning in my randconfig builds:

In file included from include/linux/string.h:254,
                 from drivers/net/wireless/ath/carl9170/tx.c:40:
In function 'fortify_memset_chk',
    inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
    inlined from 'kref_put' at include/linux/kref.h:65:3,
    inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  493 |                         __write_overflow_field(p_size_field, size);

Kees previously tried to avoid this by using memset_after(), but it seems
this does not fully address the problem. I noticed that the memset_after()
here is done on a different part of the union (status) than the original
cast was from (rate_driver_data), which may confuse the compiler.

Unfortunately, the memset_after() trick does not work on driver_rates[]
because that is part of an anonymous struct, and I could not get
struct_group() to do this either. Using two separate memset() calls
on the two members does address the warning though.

Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 6bb9aa2bfe654..88ef6e023f826 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
 	 * carl9170_tx_fill_rateinfo() has filled the rate information
 	 * before we get to this point.
 	 */
-	memset_after(&txinfo->status, 0, rates);
+	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
+	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
-- 
2.39.2

