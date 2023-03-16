Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326F6BD08E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCPNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCPNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:16:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C003C888E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:16:38 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F6A144605
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678972597;
        bh=OzH+kQ+KVGzBIH/pA2jTiU3WpLAj2IMHPWH8AuUv3go=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=OUvRHVLXIjE4xqXZsn5rEGVNqRfRiJJ2rhr0RHXnMPlmwF18WiufS1eOymypR77im
         0F1riRZIJAgfCDTROKrXujvQ+l9078u7+cUleHxmRRSn+vVYSohQ2anGUJ6ytCUtTk
         7bzhu8/szTyTTs5XqI9pqvUnQIE055BrxY/zCOzDzi1Y7dncZxrD8SqD8Q5n9hTOh5
         v1flvvnkGqjab0mDYBA7vksw6Ecrpinrjc6tUkRUQEBsTGoDkA+Rpa4Wv9/bgg8m2u
         FCndEnFXDDIJVA4gLEp46GLpHSwjQqp82Ma21KENWbPZLqFHpgpqoDa8Kec0AlvBsG
         YL3+OOiimj7Aw==
Received: by mail-ed1-f69.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so3017021edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzH+kQ+KVGzBIH/pA2jTiU3WpLAj2IMHPWH8AuUv3go=;
        b=8OnMHsD6gfRFY7zO2jyslLAS7aMmR2p81lSiwiA9VCEJRKySSZAJTwINcRPwBoj9pR
         INu+q0VXI6h54JcjRp0xhNLeuDBSCaeVp11cRNdKpHobGm36YZqhemgKuqG8S/I2wLbK
         NDHH/ZLYTW4ZvCv4/XDAPv8qfWCpfs4ZwkJ3IZRRWtoITKQgaejwBKkDdFXCClQhlzDL
         mmkdJYWDN2pB7YsO9eIsyYDBgNA/cVxCxOL2qS/tFOZisvIFxSQthKeKNI4JrMdCu50C
         9Lh/uZssLPU9ni9vnqFNQ+Bmz5TmByFBvWrQ7FR1OYIlJLT5AFDVjszNVXpXMclwFouO
         pTMA==
X-Gm-Message-State: AO0yUKXIzG/ADY7edRFkwI9xsoFU3pUr2wMyAQrm9kc9QgaBFrovAIx0
        klqPgkBpeceb6eL8TbPlUxSThnbyXirR7eFD0+gpCYlyyfi7s+FDs+fOBRCYAaI2vwgA9MFEb69
        lxYWs3gqOLA+RqSpmER0kkAI9/3PqDyPrivBf4ballQ==
X-Received: by 2002:a17:907:6d83:b0:8b1:76b8:904f with SMTP id sb3-20020a1709076d8300b008b176b8904fmr6724107ejc.34.1678972596962;
        Thu, 16 Mar 2023 06:16:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+7uNMTvJX9EGnInS/Y73P/nh1qiMWsw4fTJJwLjOfVlos9Jk0EwBh69Kb5P6fZkQ2hrQu/tg==
X-Received: by 2002:a17:907:6d83:b0:8b1:76b8:904f with SMTP id sb3-20020a1709076d8300b008b176b8904fmr6724085ejc.34.1678972596736;
        Thu, 16 Mar 2023 06:16:36 -0700 (PDT)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:5e7c:880e:420d:8cc7])
        by smtp.gmail.com with ESMTPSA id d20-20020a50cd54000000b004fd1ee3f723sm3812336edj.67.2023.03.16.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:16:36 -0700 (PDT)
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
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH net-next 0/3] Add SCM_PIDFD and SO_PEERPIDFD
Date:   Thu, 16 Mar 2023 14:15:23 +0100
Message-Id: <20230316131526.283569-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
but it contains pidfd instead of plain pid, which allows programmers not
to care about PID reuse problem.

2. Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
This thing is direct analog of SO_PEERCRED which allows to get plain PID.

3. Add SCM_PIDFD / SO_PEERPIDFD kselftest

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Big thanks to Christian Brauner and Lennart Poettering for productive
discussions about this.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>

Alexander Mikhalitsyn (3):
  scm: add SO_PASSPIDFD and SCM_PIDFD
  net: core: add getsockopt SO_PEERPIDFD
  selftests: net: add SCM_PIDFD / SO_PEERPIDFD test

 arch/alpha/include/uapi/asm/socket.h          |   3 +
 arch/mips/include/uapi/asm/socket.h           |   3 +
 arch/parisc/include/uapi/asm/socket.h         |   3 +
 arch/sparc/include/uapi/asm/socket.h          |   3 +
 include/linux/net.h                           |   1 +
 include/linux/socket.h                        |   1 +
 include/net/scm.h                             |  16 +-
 include/uapi/asm-generic/socket.h             |   3 +
 net/core/sock.c                               |  35 ++
 net/mptcp/sockopt.c                           |   1 +
 net/unix/af_unix.c                            |  18 +-
 tools/include/uapi/asm-generic/socket.h       |   3 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   3 +-
 .../testing/selftests/net/af_unix/scm_pidfd.c | 336 ++++++++++++++++++
 15 files changed, 423 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_pidfd.c

-- 
2.34.1

