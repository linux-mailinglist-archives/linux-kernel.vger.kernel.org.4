Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5377B6273DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKNAeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNAeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:34:06 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C85DE090
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:34:05 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 45CDD6C0C58;
        Mon, 14 Nov 2022 00:34:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a299.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 981176C09C2;
        Mon, 14 Nov 2022 00:34:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668386043; a=rsa-sha256;
        cv=none;
        b=sXr3lZKSBd3gA/9CTRjW3deFnYx8CEljjsndKRhYRwz29hkxbdZUAuwFpBMBKh/wbOoa67
        rpGXR5T/aV3tg5lQndo+CXF9tsDuSBihCvo0nJ6d21hgd7SkC07sDG0XMNpk+B3ZKTeqTl
        RCFSPzKSZ5gVRnpzekhTGVwYd9t50t0BQlYhzDPO/GYs858m1nKhKE7xgwYrI8A5wkylks
        43fqaPjwQI0sBm5egMkpxCNqvdsgbG/J4o6ZShURRMH2bIRUJK+tlzgsGKMWiNZDUNVVMp
        tvqLzH483rDKHeqoNB6EwDqJGhRkz/V8mREbgCODUxgUN3jbhjykpNSLsj2Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668386043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=iEeLb2Txom9s2JPgG9LZpQszQ2eBr1flUZDsnu9gutw=;
        b=ISuW8yJfYu2XuhIrvFOxjYeZifYrQNin4O25k2om2JPXP9Fj1Y811oBN0HPc1yaB0bh64u
        OFKza5m7jmdCvf9sY+d7pq2RE8IBrjTIVofqR5+F+Il1aryEC1xadCUL8g2a79oMe5mHY3
        Q2+8VhUaZ4/LAO/dQZP1W4IbX1BColpIhtzlfp4k4rZEj6PbC42zGIcMyqTn77FXvSE8LU
        BbAn2gJuflDTWaqTK7S8MQ7ZDWbBp1eCJJ+NeGcI9LGRueY46vMOf2/WEFGYdwgKUWbOWE
        85v+bOvH8uPpAcEhrIIKAxNvnBL8z3elfG6E2Cp505hPMPq8AfNKdKkDDHr71Q==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-bvckr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Spill-Minister: 2ad575ce2edc83af_1668386043869_836292686
X-MC-Loop-Signature: 1668386043869:2075585772
X-MC-Ingress-Time: 1668386043868
Received: from pdx1-sub0-mail-a299.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.86 (trex/6.7.1);
        Mon, 14 Nov 2022 00:34:03 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a299.dreamhost.com (Postfix) with ESMTPSA id 4N9Vfy3TbLz3B;
        Sun, 13 Nov 2022 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668386043;
        bh=iEeLb2Txom9s2JPgG9LZpQszQ2eBr1flUZDsnu9gutw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=pkZYl7rZWL4HG3hvMxHoTwtHsrmDzG1kp6MOFrSPpMkdEPzqofIfe1Yb5PdzM0sdu
         c/eHxxroPeisOFjG56h+xwOEjMD6Fdl+iUiJU4P2uNXubMaTqFhJOfnrFDVeOL+Bjz
         CSVOtBk3yfQjQgrFW0KkNAfPfbQn+xGVWyAlpPd6GZ0osOaCbRPFENxEnm8nl4yKae
         gyevAgCOonTY3HldRB1R11bJauFA0YPP/Jpbf3LWKfZsLQ13mGn+ye++0uQcduQwwF
         AmyAZ7RCMM6YtZiUq10LOMnKLLwbGfXj7GTJSzjam9KR53bPwwPG7HEfPG+44eL/MY
         B+yd1D5ts8Eyg==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] mm: mmap: fix documentation for vma_mas_szero
Date:   Sun, 13 Nov 2022 19:33:49 -0500
Message-Id: <20221114003349.41235-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the struct_mm input, mm, was changed to a struct ma_state, mas, the
documentation for the function was never updated. This updates that
documentation reference.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bf2122af94e7..7ffd562c57a0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -456,7 +456,7 @@ void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
  * vma_mas_szero() - Set a given range to zero.  Used when modifying a
  * vm_area_struct start or end.
  *
- * @mm: The struct_mm
+ * @mas: The maple tree ma_state
  * @start: The start address to zero
  * @end: The end address to zero.
  */
-- 
2.38.1

