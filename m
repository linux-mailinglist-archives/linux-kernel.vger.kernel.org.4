Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912163A05C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiK1EHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiK1EHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:07:23 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38083BF50
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:07:21 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 975B5921721;
        Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2996E9212EF;
        Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669608440; a=rsa-sha256;
        cv=none;
        b=lU4rom3mdnyyeuG2OY4NSDxMEOWsl3IBH2TPVhvULpKNqHT13b2kDgfC12Sda9nklvbrrA
        pPzGLktmEStIztGkWciq6n0E5QIlwx+qJE1uVhbMaFFCOKbGNLAwAVYDohprpY7bPmiEmZ
        BbQ7a8Xl1XA5sVpdmXveKpGzt1ZygZvel67nej4uECWYamWwnVZ3e+YKRF3m0XssiY/8/7
        Kai61YwiovlrbJZXeXXAMvXsS3LbtWGauVJurb3BWrj1epftAwfoVwD+xbGbLPrP6arEua
        6hKo+BVXatfV5H4KGknrGBYityaAHCLhCelFFh6xZpJ4hkQz2vcO5F6voJ3hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669608440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SKbnCvjMYXVAHe2AiOxYz31B4/GkUnKWltlmDgeCdug=;
        b=A3epQhUYPN8q2UQYMuBZv3EITmt7GlAbdhnRXy20fQ7dh7H75zaaYQIiPA1+R02P3i45KZ
        9pSaRKBjmHKAZXD4TQoiN2uCzlIIW5NraL9R5OFqHKl7BzkOEKpuu0tX8uVNtSrx5s77J+
        /jEfa2LF/N74ty/nLx4pHTSNPOe6wrDM3NqYfzsQQBjOLiJKQPhceVtyOzcTLwqnCcuCut
        +1inyossFUhhzXWaI3jDU5szT3FEKjqrJ+8F6vhRXgw1bOUTsIsmc/IgYGwxnsPgw3zcNW
        t4NVsr8Ip1rKzTJMZYDAlMo1ZE5IOEJvdEcDZzjzPM+tDWu1x394KQAD40FB4w==
ARC-Authentication-Results: i=1;
        rspamd-84789cff4b-smsx9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Abortive: 345b32716bfc5789_1669608440418_1916038887
X-MC-Loop-Signature: 1669608440418:3640735801
X-MC-Ingress-Time: 1669608440418
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.119 (trex/6.7.1);
        Mon, 28 Nov 2022 04:07:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4NLBkb4ygsz8p;
        Sun, 27 Nov 2022 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669608440;
        bh=SKbnCvjMYXVAHe2AiOxYz31B4/GkUnKWltlmDgeCdug=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=eS+8uiL0P+icyCZsAoPiH5GCxz99YBLavwqwBPaxs+67HC58MdfgMDHtMWgpqpOHL
         h1MxjBbuQbscIHvxHgOI6f3Pm9BdcWpCW3fSR2Co1f6CU56wLGNgJLTQZtteIeLwZy
         Of+nBCIdquK8ndoK8EApmgL2EBpE/4glAokFYUlrTMPmYW46Cz6nucSJ/wnon1MrvM
         IBCkRR/oFfZAaiIkGePQ+czhEca8O8Hv2ORF9HFJyuEEHsk1k1WoFjd9Dxi7HFGfyu
         xokY321ahBaOsdc2AF36CPQMRtbdecTRzrhZF7CmaS2/y8Pbq4DpSuEH4kMwRySwfb
         K48kWnYWQFUTw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 1/2] tools/virtio: remove stray characters
Date:   Sun, 27 Nov 2022 19:43:46 -0800
Message-Id: <20221128034347.990-2-dave@stgolabs.net>
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

__read_once_size() is not a macro, remove those '/'s.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/virtio/ringtest/main.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 6d1fccd3d86c..9ed09caa659e 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -149,16 +149,16 @@ static inline void busy_wait(void)
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
-        switch (size) {                                                 \
-        case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;              \
-        case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;            \
-        case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;            \
-        case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;            \
-        default:                                                        \
-                barrier();                                              \
-                __builtin_memcpy((void *)res, (const void *)p, size);   \
-                barrier();                                              \
-        }                                                               \
+	switch (size) {
+	case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;
+	case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;
+	case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;
+	case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)res, (const void *)p, size);
+		barrier();
+	}
 }
 
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-- 
2.38.1

