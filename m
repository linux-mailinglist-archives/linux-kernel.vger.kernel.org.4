Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE7682D47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjAaNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjAaNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CF4E537
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:37 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC2BB41AC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170335;
        bh=k4C10jaPX9SATgjkcJPgwiqnKoKJu0rj0Lx0+VxMFbA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=OTcC8sDKIc1YQANEGakG5cBF5JY4WsfSv9i8IUGxHIy0lfVk0SlyeZeZpzAVGPs0X
         HeHJ/5caZyacGyHKJskvVonsGh+1a5K3VUFVrMUpgrGVtcuc55QO7o8G7NoqnI5QO+
         Ou0eTl9fc00OZmZRJp+M3Pe47P0pAqS0SKBYnFnpeR4vDYlkY5PLN1OEH8wlYICK0n
         9YkeAjQ7nSIwQ3e21yhk/xmM4fJVOtdiB+2rAlBdksYRXd6c1XcneNEt1+Lxb5KvAP
         XBIzY8ws18NFS76wSE2/6+yeTUZuRJ9ldPlPpfr/ZQkuovdWKtWNigcD0Il/zSDMza
         TnKrgnDQV0s1g==
Received: by mail-wm1-f70.google.com with SMTP id o31-20020a05600c511f00b003dc53da325dso4483768wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4C10jaPX9SATgjkcJPgwiqnKoKJu0rj0Lx0+VxMFbA=;
        b=1VusvUTexQWHAKTfzOFNWNPtfURa2OyE9O6jWel7Q13XMGCcXKewO9291JmWYbEO9F
         YLBuCu6ap/qtNG5lKjbr0NgQ1eEyz0r8EW/5X8UhfbBlx6+VoSOr1AOe0dyeAA9U5olQ
         sFxd3ZgmTAmAGYkPiBLGMGad1EKBa3FZwEyNOGkJK7RyGqM3cFK3+SPz1noCBUHkzJbe
         4NValbpc9KipJKnYq4jQ6SERghNhCk4h4YXJl7X7k+rqjkwhRpSZGDtamip9SkUu8JuO
         tWxrJZOmw32OWbr43NaW2FXmf3cHC+ybb4TeejncUD1h3N/8zLzs05PVMn0T8CUzHax5
         MHkA==
X-Gm-Message-State: AO0yUKVxgWLWaHMRItpU4SAC57fH/FcDdJ86uABLecXWyzNfaM6EfZ35
        5C3JLvIKmkrb8BgOnafdU7lD6SnXaSqWO/GEmPZH7/Yz066Uz4qYNbIIkY+hzUAZMWz3czCllX7
        Dt+EnM3nlKFSghsyMsFtMWp5qoK73mtqWtEFEjLkoxQ==
X-Received: by 2002:adf:c68a:0:b0:2bf:f2f2:7d64 with SMTP id j10-20020adfc68a000000b002bff2f27d64mr5125345wrg.33.1675170335341;
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/JKOWFouqXY4USuDFfFzUbfIHyMBzspi6+XkMA9ckLWmUhedeQ3yyjl+8b9xB/uwlPFXvVZA==
X-Received: by 2002:adf:c68a:0:b0:2bf:f2f2:7d64 with SMTP id j10-20020adfc68a000000b002bff2f27d64mr5125324wrg.33.1675170335068;
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:34 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] selftests: net: udpgso_bench_rx: Fix 'used uninitialized' compiler warning
Date:   Tue, 31 Jan 2023 13:04:09 +0000
Message-Id: <20230131130412.432549-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This change fixes the following compiler warning:

/usr/include/x86_64-linux-gnu/bits/error.h:40:5: warning: ‘gso_size’ may
be used uninitialized [-Wmaybe-uninitialized]
   40 |     __error_noreturn (__status, __errnum, __format,
   __va_arg_pack ());
         |
	 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 udpgso_bench_rx.c: In function ‘main’:
	 udpgso_bench_rx.c:253:23: note: ‘gso_size’ was declared here
	   253 |         int ret, len, gso_size, budget = 256;

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index 6a193425c367..d0895bd1933f 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -250,7 +250,7 @@ static int recv_msg(int fd, char *buf, int len, int *gso_size)
 static void do_flush_udp(int fd)
 {
 	static char rbuf[ETH_MAX_MTU];
-	int ret, len, gso_size, budget = 256;
+	int ret, len, gso_size = 0, budget = 256;
 
 	len = cfg_read_all ? sizeof(rbuf) : 0;
 	while (budget--) {
-- 
2.34.1

