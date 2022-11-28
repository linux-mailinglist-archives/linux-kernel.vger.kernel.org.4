Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587B63A068
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiK1EQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiK1EQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:16:01 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56763D4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:16:00 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 14890412AA;
        Mon, 28 Nov 2022 04:07:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A3C8041369;
        Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669608440; a=rsa-sha256;
        cv=none;
        b=oOuCfdC2aFTU4OZ/m0PT2oQ/P9fnY+Fh9pM0MwmmyszUuHj97BnWl8LOFG+epTFI8V2hMS
        kg2SFJQAPxNmvoob/bUjsM36SaPCA8n+BFR8NBZEqanMYIwdXd8YBFJZ0z2jdAXBY6SPPF
        IP1wDStWQw3UO3CX8Da8mLmIYuwSCjXHXr+IwsS6H2n470YCm7KYG/8MgKkTv956SztvDm
        lbIrSIfr5KAuAFxkDF/khWGoc0orCUOKHaPS7eDjE2bSwvs0M5Q0bSx3BwfeNGCklI5JU/
        Br2uO2d6Pdq8tq1hzXDdO+ZfYDe003b2Wxo6s7WawNmK03oobRrnGEwljcQ9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669608440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cNHJgNohZbk1ATNrC2SM8HmkbxHfzP5Rb8J4WNikoEY=;
        b=7GX6vCXfBxxQI/AvknD9DT5j6ibK1ZCJK2TXsMw0yazRfTEMtwJJVm0V23njfY5q+fO5Mt
        sNoxP3mBJxlvjnmJQlN/KIEG3fYPzukxGOPTHxY0ddXvYv2SHKYGZIf/1fgsY2/iygO6kL
        ocFgLWMEcUqqzOGAoY+nwz4rEXTsU7DxWHZxnTgicn7jwF8jMbtEy1KbloTqjgcplI6mtq
        3QM8eQn3ZxTfc9ZLtZk3EciAwvb+NpHh+OCzCB08TATvHshG9dP89uNqoc0M/Yqo0nOqxh
        ErVEKfdP5OPO/0SmDpVc6CDI1+DpwjdyV3WRxKDpL8SUM1aMqrT6EfeJj+X3AQ==
ARC-Authentication-Results: i=1;
        rspamd-84789cff4b-5sz77;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Illustrious: 5388c18734dbd4c4_1669608440906_1724246424
X-MC-Loop-Signature: 1669608440906:384576075
X-MC-Ingress-Time: 1669608440906
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.104 (trex/6.7.1);
        Mon, 28 Nov 2022 04:07:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4NLBkc1Rw9zCV;
        Sun, 27 Nov 2022 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669608440;
        bh=cNHJgNohZbk1ATNrC2SM8HmkbxHfzP5Rb8J4WNikoEY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Elhx8hzils/2f+pIyPwtdDOoHpK3lVoa3HliCMM/wiFtVkuE0FsyXTxN5b/7thvtY
         Acb8uHx2IOaVRqVPk2Ko6eDpCgQcTFscXpCA4bYINGTpEEffpTD0w+LFLcKRwmTlOV
         djL4MYx1A60qKiJYU7Y+O/LmlXhaKYuaxzTR1w+NGOUqTl6CVkaPpJ2t2T4VQnFb5E
         LE1gCwOHIM6Z2TJg87zvU5gcoItA+3gpFR/MptVKjfhW8TXGYSMP9cT/gxGcNBgHU5
         6V/ENYyfnI+g205auuWmnl5p91D0rEZ1FqfUahqdaxPbjsmjnRNKujZApgo0mjzhzL
         FnnJ3zNKG8VEg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/2] tools/virtio: remove smp_read_barrier_depends()
Date:   Sun, 27 Nov 2022 19:43:47 -0800
Message-Id: <20221128034347.990-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128034347.990-1-dave@stgolabs.net>
References: <20221128034347.990-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the last references to smp_read_barrier_depends()
 which for the kernel side was removed in v5.9. The serialization
required for Alpha is done inside READ_ONCE() instead of having
users deal with it. Simply use a full barrier, the architecture
does not have rmb in the first place.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/virtio/ringtest/main.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 9ed09caa659e..b68920d52750 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -140,12 +140,6 @@ static inline void busy_wait(void)
 #define smp_wmb() smp_release()
 #endif
 
-#ifdef __alpha__
-#define smp_read_barrier_depends() smp_acquire()
-#else
-#define smp_read_barrier_depends() do {} while(0)
-#endif
-
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
@@ -175,13 +169,22 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	}
 }
 
+#ifdef __alpha__
 #define READ_ONCE(x) \
 ({									\
 	union { typeof(x) __val; char __c[1]; } __u;			\
 	__read_once_size(&(x), __u.__c, sizeof(x));		\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
+	smp_mb(); /* Enforce dependency ordering from x */		\
 	__u.__val;							\
 })
+#else
+#define READ_ONCE(x)							\
+({									\
+	union { typeof(x) __val; char __c[1]; } __u;			\
+	__read_once_size(&(x), __u.__c, sizeof(x));			\
+	__u.__val;							\
+})
+#endif
 
 #define WRITE_ONCE(x, val) \
 ({							\
-- 
2.38.1

