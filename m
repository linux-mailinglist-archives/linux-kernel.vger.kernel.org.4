Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75CE64DEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLOQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLOQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:30:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775137FB8;
        Thu, 15 Dec 2022 08:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 275B7B81BA1;
        Thu, 15 Dec 2022 16:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8157DC433EF;
        Thu, 15 Dec 2022 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671121801;
        bh=nYCUcHgLM7p2KgVDr3zhrywdX+DOccT78qCBgHQVm00=;
        h=From:To:Cc:Subject:Date:From;
        b=MX6DCk3LHv3wfFD6gfqiZtpQ/htBYO9Us/Znb0DSNtdX8y+UDA+8BkUvlVsKi0P0v
         /XweUW3LAGRTSs9UHlfU4ztuYAusujhT/U7UiMo+TlJ7exHjtnpJZFu+5jJZO97qKG
         dMzPF54/8CCi0or2l1vyw+vQb6ocmwqTzX82yFRYYrbpGoiSdGUiRCVbs4Dq+Jp233
         k83AEgNkzM/yOhzRYd3/3eoNHfh7l0JK4v2BpzpC/iVrZMmjs60u34NTkg1NL7bQyD
         ipizUHZnjtnI5It+mV+x9LbYZF7jOlLT70N7z6r7rJN+A5LU0wSRFtfVZqPfVmbdPi
         CDkV+liHgHn6w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: wp512: disable kmsan checks in wp512_process_buffer()
Date:   Thu, 15 Dec 2022 17:29:38 +0100
Message-Id: <20221215162956.4037570-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The memory sanitizer causes excessive register spills in this function:

crypto/wp512.c:782:13: error: stack frame size (2104) exceeds limit (2048) in 'wp512_process_buffer' [-Werror,-Wframe-larger-than]

Assume that this one is safe, and mark it as needing no checks to
get the stack usage back down to the normal level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/wp512.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/wp512.c b/crypto/wp512.c
index 5e820afa3c78..07994e5ebf4e 100644
--- a/crypto/wp512.c
+++ b/crypto/wp512.c
@@ -779,7 +779,7 @@ static const u64 rc[WHIRLPOOL_ROUNDS] = {
  * The core Whirlpool transform.
  */
 
-static void wp512_process_buffer(struct wp512_ctx *wctx) {
+static __no_kmsan_checks void wp512_process_buffer(struct wp512_ctx *wctx) {
 	int i, r;
 	u64 K[8];        /* the round key */
 	u64 block[8];    /* mu(buffer) */
-- 
2.35.1

