Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8170D976
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjEWJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbjEWJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:47:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE37E6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso2028855b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684835237; x=1687427237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JbrrHsu8KzXBp8abtNpZsLO9DbdsQWsXzCPkkoYMdc=;
        b=LeHmRtCQCbob1Ad8YEm2YLv5mAvn+aMuWIv78A1fohJzHjOiXc2rnwxby8WYnL/ewR
         MM/7pB74gbS7eWJdjpORMMbyBiKMsXNEt5il7o9ta5Xb8AQNhVbeCV53MtlCKD+g508Q
         blH+tGTg7Ad8TJmgxxgRqvyA+gGdI+HlgAxQPcczFNCWeQ9K2YrePJc4cC9xs85ovsqf
         KpGnxmHPLuTkrbE7lo+EzKQQENuGbRlZiS2MY4/iSmoOG0eV0ubhmDgjaQQ/+E313Fq0
         xqIhDGAC3+YdMS3ra3frtU5ICniR63D2pB6KBB73hMsEgnpaEENCB6/OsfpVmRS6qRJc
         NL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835237; x=1687427237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JbrrHsu8KzXBp8abtNpZsLO9DbdsQWsXzCPkkoYMdc=;
        b=Z8CnTGUPOKZlOnLINoBULcOYXAv0SXUsXtIftdaKrnl9/1zyZU1Iwg1FWzjikxoxWW
         /Ggs74B3m93HPPKCmm9/1v2F0+UgySG0vobPnvXJptiUhzrn+r1oD2IU/ksKzDXT+6/u
         +MsMEZJJu+YFK4fLOzLnhLP9+zXhDtDWFEZmkzk77Rb86uObSZ5WYuTSw8ZQsISm7AYi
         HQ60geIZY6NDCd7ACWu2vJgbvggdvO50c5gHGJlai7fogoPhu2Db/X7VzZX615RlWjAP
         epywhfZRgDMZjQ+G6SEE6/pao127N2JjQOthFMGxoBaf7b8Xmv/c/TegBpIdKXZpG96L
         mJTw==
X-Gm-Message-State: AC+VfDxwgIHzUvVV0loj5A0lvZauBpcbJrd6bitJQ7HXipWidLDhVn/Y
        WNq2RQHB3APm01PbQOGKZNGs3Q==
X-Google-Smtp-Source: ACHHUZ4S1nlt676DSbN0WKhez6GOfAS9tr9gLhf6vmcHbhMyBBQJuTFycQSDrPFN6/5nIhSjkHTd8w==
X-Received: by 2002:a05:6a20:3d0c:b0:106:8b:99d2 with SMTP id y12-20020a056a203d0c00b00106008b99d2mr16375595pzi.51.1684835236832;
        Tue, 23 May 2023 02:47:16 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0063b898b3502sm5457216pfh.153.2023.05.23.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:47:16 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3 2/5] sock: Always take memcg pressure into consideration
Date:   Tue, 23 May 2023 17:46:49 +0800
Message-Id: <20230523094652.49411-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230523094652.49411-1-wuyun.abel@bytedance.com>
References: <20230523094652.49411-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 641c9373b44b..b0e5533e5909 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1411,13 +1411,11 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
-	if (!sk->sk_prot->memory_pressure)
-		return false;
-
 	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return sk->sk_prot->memory_pressure &&
+		*sk->sk_prot->memory_pressure;
 }
 
 static inline long
-- 
2.37.3

