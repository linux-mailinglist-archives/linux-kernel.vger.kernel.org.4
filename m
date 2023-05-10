Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB316FE17E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjEJPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjEJPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:23:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7D2D68
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:23:38 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8BEAD3F4DF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683732215;
        bh=nxt1AjdlyoqIrH6J1U3hreWGYLSAQKMD95fnrL6guHQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=B5sXuyt6jCKCE+C8ZAVQOrkULm7yQwZZmMQ6CW+MzIi+VCrKoOC5f/nukYvOYUlTE
         fyGn+oW83YmYfqPMg2GGtpX3574Nshg4BlPoJil9Zpdw6Nm1iq+o/Pnwi2Qghh9VJ5
         FuF2iWARi5rjcMA22oogunngkj3dnPcjI+zjIa+guXn5BObj5ePk+UXT3FwcSW1WPJ
         VE/v/0DbKj0DFCZY10cvjIeB11pALHpokY10Ib7S5+rBUeJnUhVPpzhm9klHAwDqp0
         qAAAthSyN5XhCaTWAJMoe3xAihVbl+PTbeuJgHv8Lc8s4UN5MrOP9Hc+6PoEdfvED+
         ARbTReTIA+9Sg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bcc3ee913so6840296a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732213; x=1686324213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxt1AjdlyoqIrH6J1U3hreWGYLSAQKMD95fnrL6guHQ=;
        b=TiF2OdSRkb79Ss24j2dfRD177HnnTK+mL8RwgH950XbkujSsRLDdgxwRVgg8G49McS
         mKx4j4aIvfN26IXjR6YaSDoivqGjc1ESbibuNVjijuYNscBc0GCgOzaVtZZcywofj1xh
         gxkujkw80saj+tmtJkx4ga01fc2W14QZyT9Ak5J81NJDxJ3xH1mm2jr7Id0kYWSw30me
         J0pJRNpu+OCysk6AeSJosORBX/XZh7J1iOUt/Uzk0P6WiWhCKB6W5vIkhZMVi2+Rp3+x
         92llzmQIlyskpC20Lb8XGnMSdpnxO/NM93mASkLIOVSDttHRhRjVU17+Mv0gqo1FmsGN
         xmVQ==
X-Gm-Message-State: AC+VfDzgPM2ScQ4Cna9yOxPRkQmV+MiScAwnuuoQiWcUvRwiVue8JGDg
        t2gRtc5fgSbd7TgeWiAACita5kdYsSLFsXFKd6pLpfoNN3rutjM4bXYM8VXpwL2rfMfLxB0chnm
        jHYuZaI2I+aLOu9fOkawClicTOoAUU71FvhfHANOquSUCPWYVOg==
X-Received: by 2002:a17:907:6295:b0:94e:cbfb:5fab with SMTP id nd21-20020a170907629500b0094ecbfb5fabmr16778387ejc.75.1683732213535;
        Wed, 10 May 2023 08:23:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wVCdAKwUlJ8V9lcgbWEAiwFeSNH6AK2FonknQiPTYHWcs8YvzVYyw9uHkDEkxON4bz52OSg==
X-Received: by 2002:a17:907:6295:b0:94e:cbfb:5fab with SMTP id nd21-20020a170907629500b0094ecbfb5fabmr16778362ejc.75.1683732213215;
        Wed, 10 May 2023 08:23:33 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm902755ejc.209.2023.05.10.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:23:32 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH net-next] net: core: add SOL_SOCKET filter for bpf getsockopt hook
Date:   Wed, 10 May 2023 17:22:16 +0200
Message-Id: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have per struct proto ->bpf_bypass_getsockopt callback
to filter out bpf socket cgroup getsockopt hook from being called.

It seems worthwhile to add analogical helper for SOL_SOCKET
level socket options. First user will be SO_PEERPIDFD.

This patch was born as a result of discussion around a new SCM_PIDFD interface:
https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/bpf-cgroup.h | 8 +++++---
 include/net/sock.h         | 1 +
 net/core/sock.c            | 5 +++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..97d8a49b35bf 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -387,10 +387,12 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = retval;						       \
 	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
 	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
-		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
-		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
+		if (((level != SOL_SOCKET) ||				       \
+		     !sock_bpf_bypass_getsockopt(level, optname)) &&	       \
+		    (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
+		     !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
 					tcp_bpf_bypass_getsockopt,	       \
-					level, optname))		       \
+					level, optname)))		       \
 			__ret = __cgroup_bpf_run_filter_getsockopt(	       \
 				sock, level, optname, optval, optlen,	       \
 				max_optlen, retval);			       \
diff --git a/include/net/sock.h b/include/net/sock.h
index 8b7ed7167243..530d6d22f42d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1847,6 +1847,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen);
 int sock_getsockopt(struct socket *sock, int level, int op,
 		    char __user *optval, int __user *optlen);
+bool sock_bpf_bypass_getsockopt(int level, int optname);
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
 		   bool timeval, bool time32);
 struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..194a423eb6e5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1963,6 +1963,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 			     USER_SOCKPTR(optlen));
 }
 
+bool sock_bpf_bypass_getsockopt(int level, int optname)
+{
+	return false;
+}
+
 /*
  * Initialize an sk_lock.
  *
-- 
2.34.1

