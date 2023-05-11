Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802D6FF18F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEKMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbjEKMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:32:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBAC59E0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:32:38 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B6B53F4A5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683808356;
        bh=9aj9w2ur8U+Nd5DK5XALx0/M31BkBPR/KrjmUiEylFY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DfDtwLzTMSznDLuBmCqTuJkImwuB+TGx7EYxWMpQtYTOxyXiOvN3fPJoZwQmRjCM+
         71TNbagxsy09Cm5R38ly58u+IwP3ywvUm+BKJR0HBktCv74K4SrNMGIa89MivtI/Ch
         AU4F2+KwDGIM/N7HmTZse9TWQYJ8zz0ip08LdZNObo9H7/MY0TH9iDujR5o50lt646
         paBV5t8wGaKl6D7tTvWKQ1XHOYo0fZm8dK7K3oFrrOUVc2veR6jWLJ1WZdIida0uFZ
         nJB2SnFA4zqESl3IpEaVL/Ml84YmPmqUkYOX2MleX7B5bvmsbsqGufKit2ipFdSes1
         cPQqkUR5h7LtQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-95f6f291b9aso1067303966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808355; x=1686400355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aj9w2ur8U+Nd5DK5XALx0/M31BkBPR/KrjmUiEylFY=;
        b=cRAhW33smiSMJZqOrifxmwj5IS5TjQx4c9U6TjsyMD3kARFTO+UDk3/FVq2BdqLDXJ
         HITlAEAdusQvzg2SQMpYlFqqRnWVKgYbJIEHgLokwjz5O6l6xiSa6LZpBkPNbhsBQKrl
         dJVeFWxjuyZmE33C0zRgdXNPumvJP6ygE8/1l2mWUNH6TZOaOudwCcc19cRRGLTF/g+B
         NL25DgOm4+yVYJ4CDkm9gSsDLZc018jltEb+6YWetlqgEoeJb42Nr2OFbVvqT+QNSSi1
         lQlitShJGnBEMqrIuw9x979EcUWabAd/b6OaNIWGcqVMKSOyHm2jJRLr4i2QRWX/C+vQ
         iLuw==
X-Gm-Message-State: AC+VfDwRugbXAF+78mibnT5i7uaYLtNpenwNKLH/1qrK/VkwgFs06XO4
        3h0F2dStuZMVJ4GSg/082ig/L6EuGwvYhXQiIXMRLu5INdMorMpNWJ79UXSU3V7dZOAHRjEqSeS
        tekwwnU9758W01K0oUc37A0hvSyYwbHlJNBhGkErlPg==
X-Received: by 2002:a17:906:9b8b:b0:96a:7de4:dd24 with SMTP id dd11-20020a1709069b8b00b0096a7de4dd24mr587382ejc.66.1683808355018;
        Thu, 11 May 2023 05:32:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sXboCrcgZqmPwaiL+LsLQ9aAYIhDtjlw+ataSN9pCjs1hBQsMsovl64QzHlnIObw8hQfvqg==
X-Received: by 2002:a17:906:9b8b:b0:96a:7de4:dd24 with SMTP id dd11-20020a1709069b8b00b0096a7de4dd24mr587346ejc.66.1683808354610;
        Thu, 11 May 2023 05:32:34 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id ia2-20020a170907a06200b00959c07bdbc8sm3968534ejc.100.2023.05.11.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:32:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     nhorman@tuxdriver.com
Cc:     davem@davemloft.net,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v2] sctp: add bpf_bypass_getsockopt proto callback
Date:   Thu, 11 May 2023 14:31:48 +0200
Message-Id: <20230511123148.332043-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bpf_bypass_getsockopt proto callback and filter out
SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
from running eBPF hook on them.

These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
hook returns an error after success of the original handler
sctp_getsockopt(...), userspace will receive an error from getsockopt
syscall and will be not aware that fd was successfully installed into fdtable.

This patch was born as a result of discussion around a new SCM_PIDFD interface:
https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Suggested-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/sctp/socket.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..a211a203003c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8281,6 +8281,35 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+static bool sctp_bpf_bypass_getsockopt(int level, int optname)
+{
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		/*
+		 * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
+		 * hook returns an error after success of the original handler
+		 * sctp_getsockopt(...), userspace will receive an error from getsockopt
+		 * syscall and will be not aware that fd was successfully installed into fdtable.
+		 *
+		 * Let's prevent bpf cgroup hook from running on them.
+		 */
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
+		/*
+		 * As pointed by Marcelo Ricardo Leitner it seems reasonable to skip
+		 * bpf getsockopt hook for this sockopt too. Because internaly, it
+		 * triggers connect() and if error will be masked userspace can be confused.
+		 */
+		case SCTP_SOCKOPT_CONNECTX3:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
 static int sctp_hash(struct sock *sk)
 {
 	/* STUB */
@@ -9650,6 +9679,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9705,6 +9735,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
-- 
2.34.1

