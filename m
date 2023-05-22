Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7370B5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEVHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjEVHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:05:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CD1BCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:01:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d3491609fso1928825b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684738907; x=1687330907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAQinShNGu83yZk3rp1RX6U81r/+0AkNU5ra2AmWYPc=;
        b=R6qQVs8Q1EC7za9C0/4qceRDywImj4defA+/MxD5u5cL6DHOsp8Fo7zRfkA3tL3j4D
         lNyjLVK9jTeCzqt/i4lcpUIX1xMtpu2n5MLzkWz0bmtuupHIhPGlQ3LrsbHgIiH+zGar
         GyFrcO5kZ90L8eXWQXvpl4AB9adbMG7raaVldlWWmBkSrPEvinkkSxojT5/qC6t1JoBC
         ZXFTp6y2KVlqqWOOjQkm668oAE21GsEVSwMZ4j3C2GwxiUCk1a8zYaCJIaes7V48eFmG
         osdXJSikN8/mo9c59yhD/vAZbZDI3aqEtXB1hsd2HTjTEjgpJVNe2C1o1N9raWiK4Zwo
         m3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738907; x=1687330907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAQinShNGu83yZk3rp1RX6U81r/+0AkNU5ra2AmWYPc=;
        b=Ius/QlJfFrggDjattNgXh6o+LzrCG3qJurH8evDwtg+OudU3+IuN3JrKO8HQPjoK35
         DMJcqk2Soqa/vS4mM65IhQaOQVp0CMclEjImV26G5VdVpw76sY9lNqRMj+5Ac8BYoy3f
         4ggIPJR1LBgtKoDdFNYe3gRLamDDcWeM4OXfyyRDOAnXFLqzVCMm3JpupReagLxxRvLr
         cDSQQwrV6dY4XCP4Qv9ISjj5SLz1K4TdJcQFm8hkqzCmBa16cbFLaHN90fpJ9nC4OPLl
         NhYVY2qLeIRlZKmumBNiTTz2iUnE60YrfHdmUNU6d2d2jMm79gZ1UQHmQl+UX2o/xaEB
         5l/g==
X-Gm-Message-State: AC+VfDxTQOyGC/Kcp1NfVyy3wbKoVtgzeC6TVDVb2BSFCIh0mw1qZW6t
        yH9D99eN+i8jpsNr2fhffZGCCw==
X-Google-Smtp-Source: ACHHUZ5KWE6uNrz9B0dQhspuvs0CqmLb5hN3tWINo/EwRjj/SHAKsnFFjJrmCEAnGpvQaQbH8Q0wZQ==
X-Received: by 2002:a05:6a00:10c4:b0:63b:1708:10aa with SMTP id d4-20020a056a0010c400b0063b170810aamr12715822pfu.34.1684738907531;
        Mon, 22 May 2023 00:01:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d27-20020a630e1b000000b0052cbd854927sm3687505pgl.18.2023.05.22.00.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:01:46 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Glauber Costa <glommer@parallels.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 1/4] sock: Always take memcg pressure into consideration
Date:   Mon, 22 May 2023 15:01:19 +0800
Message-Id: <20230522070122.6727-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230522070122.6727-1-wuyun.abel@bytedance.com>
References: <20230522070122.6727-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sk_under_memory_pressure() is called to check whether there is
memory pressure related to this socket. But now it ignores the net-
memcg's pressure if the proto of the socket doesn't care about the
global pressure, which may put burden on its memcg compaction or
reclaim path (also remember that socket memory is un-reclaimable).

So always check the memcg's vm status to alleviate memstalls when
it's in pressure.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8b7ed7167243..c73d9bad7ac7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1411,14 +1411,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
-	if (!sk->sk_prot->memory_pressure)
-		return false;
-
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return sk->sk_prot->memory_pressure &&
+		*sk->sk_prot->memory_pressure;
 }
 
 static inline long
-- 
2.37.3

