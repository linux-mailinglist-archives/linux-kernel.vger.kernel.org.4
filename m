Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1066A33E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBZURr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:17:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114741689D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:17:44 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CC553F72E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677442661;
        bh=9/pq49ozwimVxEnGFYdfViP09nMRqPZhjqEhtsjGRMw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZDIwedpX5ZaJXeTs9eW8U5dhmsOMmA6p/zpue3bonzhLk2isYJZygHA4pxj+/769I
         fHmA13SJtmf2zAQTpy9vicNod27SWCe/pbcg3iMSmqiYUNsiboVy75xU0+9aof9+nI
         z0BizynJbddGBYlp0o9bhsJ547GiVydZDjMeyDoXYigOngzq5Fx6+9SnBPKfLv/OOx
         SjMIcuLCWN8YL7bJ8b4na8+1EzuzuzsCWMFtwLix75XF7/Iook8I/4XKeX9bcHUK/8
         fLyUQQ2s5nqFNE7m+ND8r9eRR4H2vmH63jPuicGa/UqoABGCCGPf/LaKhV/xaQf9X6
         BZ+cTM4N7HpYQ==
Received: by mail-ed1-f70.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso5457521edp.19
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/pq49ozwimVxEnGFYdfViP09nMRqPZhjqEhtsjGRMw=;
        b=GrmeRn7XNt+CzDvH6faYs8Z+krb42laqjrInGW9dfzOjXuIGzyQXqqTqLYIL52JKZ7
         HxrA1vjdkOoCNwt9dPbhRpTK7BZzPIiq4Mh8D+0h8yagIvFiypK5rRN3+5muXFhtfVK5
         JBs6BlUhWyc0w+YT5tIKH3EfMz8Bky7eOkOGXibghqCixcsq9Ov92fJ6UqHtZH/chw4y
         ngMQiCldvxS/e11GthmUcWq92P8mpeEkz3pEEHKrWLUnR9J2jrjQ4Ze7acZfiJ9VYm0M
         dtxy2T0BNe3JMX9LPcO72uVByKdOXDdnb2wpZRQuKzilDiBrvE+PiSw5UTbUVONykx8p
         ebYw==
X-Gm-Message-State: AO0yUKWVomBD/AKwnvLbjl8bNVfcXLgX9exEz91vULPJd5PFvLprO1OZ
        A0Zi/ox5evisONGQ1U84Bz7VuG4gEOO2iMEsDguzLa0C3N+nL6+yR7GqS32aZh/bi6rxIKs6SEw
        vfIwk4FExXDORf+V+yoI/8SKDYwVJkk6XmPme1uoCW4x4zt8=
X-Received: by 2002:aa7:ccd5:0:b0:4ac:bd72:e7c5 with SMTP id y21-20020aa7ccd5000000b004acbd72e7c5mr23012935edt.20.1677442660690;
        Sun, 26 Feb 2023 12:17:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/QLzUlE3acOhv46mqmlyZ8kHQPNmW84C2w7/OHzgdK3i153PU5WOejeRN6Tlj4XIUfEQKnSg==
X-Received: by 2002:aa7:ccd5:0:b0:4ac:bd72:e7c5 with SMTP id y21-20020aa7ccd5000000b004acbd72e7c5mr23012923edt.20.1677442660391;
        Sun, 26 Feb 2023 12:17:40 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:ea8f:7f5:4586:1075])
        by smtp.gmail.com with ESMTPSA id cm18-20020a0564020c9200b004af5968cb3bsm2284995edb.17.2023.02.26.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 12:17:39 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
Date:   Sun, 26 Feb 2023 21:17:30 +0100
Message-Id: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we set MSG_CTRUNC flag is we have no
msg_control buffer provided and SO_PASSCRED is set
or if we have pending SCM_RIGHTS.

For some reason we have no corresponding check for
SO_PASSSEC.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..585adc1346bd 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		}
 	}
 }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 { }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
 #endif /* CONFIG_SECURITY_NETWORK */
 
 static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
+		    scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
-- 
2.34.1

