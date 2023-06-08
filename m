Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BC72896B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjFHU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFHU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:27:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E83580
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:27:02 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1EF13F373
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686256018;
        bh=BjVOaOX+rOUwxqfCcfqaeBd3w4EjFD+d/9OSygYwXOc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wQK0hZhVfLcMxU4dlxzm2B9+jBCZKbCDPSbrR+s1fc8+Oh6xHJ+WqknKa0ztL23BR
         q5ebjyq/74YcPh0accPMv8Xunc1HJXWTOyZNjY8Uy4ty+duhKgFzPwc57CzcOlFiA0
         WiYNQu7a9PakROvBg4Qi7zKrXzfL2y19jzIvP9GgluqEwLncNCP+HewUs+kAxtdj59
         zCejD0j3jvHi4S5ylfEvV31ipqIGiv5epun07nOaYFdH83q0hvwA47r2K7GW9E+SA1
         HIMdyhzQZu0ct6XfutGI2vcnX6PuyZGnKjS0hnsFID/Hoznqfrd2x23BxX3yaV/t/A
         bdMIo/QjUZaOQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-970e0152da7so116794966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686256018; x=1688848018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjVOaOX+rOUwxqfCcfqaeBd3w4EjFD+d/9OSygYwXOc=;
        b=PmXHMuAjpNfJkEoAyIJeTrWruBXERxmh7lN5tfuxQKTOieCw7JifazURT/12+DPmUS
         1aSDcBO5WBQZxZrxn4cwnTWrPMZd6H4jOGBYpJZWvVP9cWQtU4tqAocmC5PN2TdFL36V
         IF7jKYuFecmVsposXdQ6uwpZvpGsdlYRjDZFTWt+qssBjbXA3LTrW4AOmHzWIKO6YGnt
         zMJdSfwjxmBFVcc818r4sqKYaq3WvCOdDxSLnVB77mBrTAwfT/uF9GMyPU3PGCsTzPhY
         KFAowjCF46slHUN3QxBVk3odKvJRxq1lAmaq7yiVknh/PZ2VH2p0njjwwre5kblD2xQ8
         Dy/w==
X-Gm-Message-State: AC+VfDy00jCTxo70Msmdf1ME+GYwgnW9ae04xwa3cx88c1MEa1r6KEdM
        VFpw2PRRKRhq7Wkt1ZyscejHRUrQUkE7fOa3AsFq+w+pOLcH3hri88lLTxk6YeeOosJ650OM27b
        cmVdXmTpPscBwmft2EXWp0FRKHebtpv1CRLMEp37D2g==
X-Received: by 2002:a17:907:7f23:b0:973:903c:35a4 with SMTP id qf35-20020a1709077f2300b00973903c35a4mr244245ejc.65.1686256018296;
        Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64l2skizqYkkoGjgKsgZOunpklCFslHyfrAGzKKNXGIZ19vqFFoZ4QRgjtjzYgI/m2J585WA==
X-Received: by 2002:a17:907:7f23:b0:973:903c:35a4 with SMTP id qf35-20020a1709077f2300b00973903c35a4mr244226ejc.65.1686256018075;
        Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906491000b0095342bfb701sm315592ejq.16.2023.06.08.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:26:57 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Subject: [PATCH net-next v7 4/4] af_unix: Kconfig: make CONFIG_UNIX bool
Date:   Thu,  8 Jun 2023 22:26:28 +0200
Message-Id: <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
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

Let's make CONFIG_UNIX a bool instead of a tristate.
We've decided to do that during discussion about SCM_PIDFD patchset [1].

[1] https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/unix/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index b7f811216820..28b232f281ab 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	help
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and
@@ -14,10 +14,6 @@ config UNIX
 	  an embedded system or something similar, you therefore definitely
 	  want to say Y here.
 
-	  To compile this driver as a module, choose M here: the module will be
-	  called unix.  Note that several important services won't work
-	  correctly if you say M here and then neglect to load the module.
-
 	  Say Y unless you know what you are doing.
 
 config UNIX_SCM
-- 
2.34.1

