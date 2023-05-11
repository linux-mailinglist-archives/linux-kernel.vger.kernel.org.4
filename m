Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610B76FF2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjEKN2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbjEKN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:28:00 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9C1154F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:26:27 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA63F3F4A6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683811531;
        bh=ch7davOyHO5vzgs3WrwY5EQ2yT5MouTazclXi2xArF8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KavhHiCiKn/QOQF5nlTJZvM1b+/A0FNB6etexmx0a24iVupBQgTNPpFdHTA8BylHw
         F2l9fQ5Q0gAGQjUZuQ/Az8MRLFpQB4Dd8uVjt4tt/udAMg4A9SW36EeF9kzsAUkC8k
         rfaBeHqyLUCPs+4OF+qeJmjz6kQDVyQxkEWvHt87gSDIQa4A3aoM7hWiofr0sBUU6L
         CnIE4JB7utW+hH6+CTVrfn5pOwK1F7IK7/Uf2kI9hXIt78bHL4g53bQkz6SIv8nPrO
         wXZbw7gHBflOEpxmkMBEcP+fL+rkQteOHQ/7eBwsQlUH1k/M7YeVN3Xv9zxz8h22QW
         oRUwXvv+euCCw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-965e5cfca7cso871777566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683811531; x=1686403531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch7davOyHO5vzgs3WrwY5EQ2yT5MouTazclXi2xArF8=;
        b=WYC8F5ka8S1Q/6907OlUXc08dyUG7WyNFV3aqO/5RhZvUSursim5IE/4Q41A6CnPzp
         GVVJuseQ76TIu7ngez862igMIbYqcnfhv84ZG2TFvsfmX/45gLVHO0XTOWyAE759A9rm
         b+qASeuAGdWG3sLnYyC8UtMh+3IHcWqZkO4nSDqQqbAStkr7jFTGk6ww77qSlx9NNYiQ
         KgXr5KOZlibMcI1w0ZzdkbNeoAt5l8aIcz6hA5GFLPlfl8etzJ7GH8sZEXdpURKXUdEo
         b/1v1Q07ygioq6P/qCTHPkFnUIjoeSJ6RIXXhEuNA3zpUtlQIHBrPSRvPH7Pl/+fgS6Y
         3KNg==
X-Gm-Message-State: AC+VfDx+zzcQALiHWfVLqhnHTmBs7I4qzsFnBpr6AAABggRR6SUafxoY
        yxMkgYEzthMCz3AWkh10HjFgp3744xPN7WMkh7ItHTGTvj3dbMCe56eyzLqi00AOlvWyKNwyBsm
        GySstfSBUBHoIqkolztEpl3TqdgpI2QVKJqKj+bO7vw==
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id he31-20020a1709073d9f00b0095954541db7mr21156774ejc.3.1683811531209;
        Thu, 11 May 2023 06:25:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xYBBCiS0F3m++AIGabvifZQOL5/jshhNMHmOdRosjw/dT+tJALMD25HPpXkwEl9AGcsMRMw==
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id he31-20020a1709073d9f00b0095954541db7mr21156743ejc.3.1683811530743;
        Thu, 11 May 2023 06:25:30 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906939300b0094e7d196aa4sm3936099ejx.160.2023.05.11.06.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:25:30 -0700 (PDT)
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
Subject: [PATCH net-next v3] sctp: add bpf_bypass_getsockopt proto callback
Date:   Thu, 11 May 2023 15:25:06 +0200
Message-Id: <20230511132506.379102-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Implement ->bpf_bypass_getsockopt proto callback and filter out
SCTP_SOCKOPT_PEELOFF, SCTP_SOCKOPT_PEELOFF_FLAGS and SCTP_SOCKOPT_CONNECTX3
socket options from running eBPF hook on them.

SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS options do fd_install(),
and if BPF_CGROUP_RUN_PROG_GETSOCKOPT hook returns an error after success of
the original handler sctp_getsockopt(...), userspace will receive an error
from getsockopt syscall and will be not aware that fd was successfully
installed into a fdtable.

As pointed by Marcelo Ricardo Leitner it seems reasonable to skip
bpf getsockopt hook for SCTP_SOCKOPT_CONNECTX3 sockopt too.
Because internaly, it triggers connect() and if error is masked
then userspace will be confused.

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
v3: fix commit description and remove comments
v2: filter out SCTP_SOCKOPT_CONNECTX3
---
 net/sctp/socket.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..a68e1d541b12 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8281,6 +8281,22 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+static bool sctp_bpf_bypass_getsockopt(int level, int optname)
+{
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
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
@@ -9650,6 +9666,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9705,6 +9722,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
-- 
2.34.1

